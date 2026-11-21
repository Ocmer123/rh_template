#!/usr/bin/env python3
"""Version and changelog helper. Standard library only (Python 3.7+).

  python tool/release.py version
      Print the version from pubspec.yaml (without the +build part).

  python tool/release.py prepare X.Y.Z [--date YYYY-MM-DD]
      Bump pubspec.yaml to X.Y.Z+<build+1> and move the "Unreleased" section
      of CHANGELOG.md under "## [X.Y.Z] - date". When "Unreleased" is empty,
      draft it from the Conventional Commit subjects since the last tag.

  python tool/release.py notes [X.Y.Z]
      Print the CHANGELOG.md section for a version (default: pubspec version).

  python tool/release.py check
      Release readiness for a dev -> main PR: the pubspec version has a
      non-empty CHANGELOG section and its tag does not exist yet.
"""
import argparse
import datetime
import pathlib
import re
import subprocess
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
PUBSPEC = ROOT / "pubspec.yaml"
CHANGELOG = ROOT / "CHANGELOG.md"

SEMVER = re.compile(r"^\d+\.\d+\.\d+$")
# [ \t] instead of \s: \s also matches newlines and would eat the next blank line.
VERSION_LINE = re.compile(r"^version:[ \t]*(\d+\.\d+\.\d+)\+(\d+)[ \t]*$", re.MULTILINE)
SECTION = re.compile(r"^## \[([^\]]+)\].*$", re.MULTILINE)
COMMIT = re.compile(r"^(\w+)(\([^)]*\))?(!)?: (.+)$")

GROUPS = [
    ("Added", ("feat",)),
    ("Fixed", ("fix",)),
    ("Changed", ("perf", "refactor", "revert")),
    ("Security", ("security",)),
]


def read(path):
    return path.read_text(encoding="utf-8")


def write(path, text):
    with open(str(path), "w", encoding="utf-8", newline="\n") as handle:
        handle.write(text)


def fail(message):
    print("error: " + message, file=sys.stderr)
    sys.exit(1)


def pubspec_version():
    match = VERSION_LINE.search(read(PUBSPEC))
    if not match:
        fail("pubspec.yaml needs a line like 'version: 1.2.3+4'")
    return match.group(1), int(match.group(2))


def as_tuple(version):
    return tuple(int(part) for part in version.split("."))


def sections(text):
    """Return {name: (start, end)} for each '## [name]' section body."""
    found = list(SECTION.finditer(text))
    result = {}
    for index, match in enumerate(found):
        end = found[index + 1].start() if index + 1 < len(found) else len(text)
        result[match.group(1)] = (match.end(), end)
    return result


def section_body(text, name):
    span = sections(text).get(name)
    if span is None:
        return None
    body = text[span[0]:span[1]]
    # Drop link reference definitions that follow the last section.
    body = re.split(r"^\[[^\]]+\]: ", body, flags=re.MULTILINE)[0]
    return body.strip()


def git(*args):
    return subprocess.run(
        ["git"] + list(args), cwd=str(ROOT), stdout=subprocess.PIPE,
        stderr=subprocess.PIPE, universal_newlines=True,
    )


def tag_exists(version):
    return git("rev-parse", "-q", "--verify", "refs/tags/v" + version).returncode == 0


def draft_from_commits():
    last_tag = git("describe", "--tags", "--abbrev=0").stdout.strip()
    rev_range = last_tag + "..HEAD" if last_tag else "HEAD"
    subjects = git("log", "--no-merges", "--format=%s", rev_range).stdout.splitlines()
    lines = []
    for heading, types in GROUPS:
        items = []
        for subject in subjects:
            match = COMMIT.match(subject)
            if match and match.group(1) in types:
                scope = match.group(2) or ""
                items.append("- " + (scope[1:-1] + ": " if scope else "") + match.group(4))
        if items:
            lines += ["### " + heading, ""] + items + [""]
    return "\n".join(lines).strip()


def cmd_version(_args):
    print(pubspec_version()[0])


def cmd_prepare(args):
    new = args.version
    if not SEMVER.match(new):
        fail("version must look like 1.2.3, got " + new)
    current, build = pubspec_version()
    # The current version may be released as-is while it has no tag yet (first release).
    unreleased_current = new == current and not tag_exists(current)
    if as_tuple(new) <= as_tuple(current) and not unreleased_current:
        fail("new version {} must be higher than {}".format(new, current))

    text = read(CHANGELOG)
    if "Unreleased" not in sections(text):
        fail("CHANGELOG.md needs a '## [Unreleased]' section")
    if new in sections(text):
        fail("CHANGELOG.md already has a section for " + new)
    body = section_body(text, "Unreleased") or draft_from_commits()
    if not body:
        fail("nothing to release: 'Unreleased' is empty and no feat/fix commits since the last tag")

    start, end = sections(text)["Unreleased"]
    tail = text[end:]
    date = args.date or datetime.date.today().isoformat()
    new_section = "\n\n## [{}] - {}\n\n{}\n\n".format(new, date, body)
    write(CHANGELOG, text[:start] + new_section + tail.lstrip("\n"))

    pubspec = VERSION_LINE.sub("version: {}+{}".format(new, build + 1), read(PUBSPEC), count=1)
    write(PUBSPEC, pubspec)
    print("Prepared {} (build {}). Review CHANGELOG.md before merging.".format(new, build + 1))


def cmd_notes(args):
    version = args.version or pubspec_version()[0]
    body = section_body(read(CHANGELOG), version)
    if not body:
        fail("CHANGELOG.md has no notes for " + version)
    print(body)


def cmd_check(_args):
    version = pubspec_version()[0]
    body = section_body(read(CHANGELOG), version)
    problems = []
    if not body:
        problems.append(
            "CHANGELOG.md has no '## [{0}]' section. Run the 'Prepare release' workflow "
            "or: python tool/release.py prepare {0}".format(version)
        )
    if tag_exists(version):
        problems.append("tag v{} already exists. Bump the version in pubspec.yaml.".format(version))
    for problem in problems:
        print("::error::" + problem)
    if problems:
        sys.exit(1)
    print("Release v{} is ready.".format(version))


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command")
    sub.required = True
    sub.add_parser("version").set_defaults(func=cmd_version)
    prepare = sub.add_parser("prepare")
    prepare.add_argument("version")
    prepare.add_argument("--date")
    prepare.set_defaults(func=cmd_prepare)
    notes = sub.add_parser("notes")
    notes.add_argument("version", nargs="?")
    notes.set_defaults(func=cmd_notes)
    sub.add_parser("check").set_defaults(func=cmd_check)
    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rh_template/core/theme/tokens.dart';
import 'package:rh_template/features/counter/application/counter_providers.dart';
import 'package:rh_template/features/counter/domain/counter.dart';
import 'package:rh_template/l10n/app_localizations.dart';

/// Example screen: renders state from a provider and forwards taps to it.
/// No logic lives here.
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final counter = ref.watch(counterControllerProvider);
    final controller = ref.read(counterControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: switch (counter) {
          AsyncData(:final value) => _CounterValue(counter: value),
          AsyncError(:final error) => Text('$error'),
          _ => const CircularProgressIndicator(),
        },
      ),
      floatingActionButton: _CounterActions(
        onIncrement: controller.increment,
        onDecrement: controller.decrement,
        onReset: controller.reset,
      ),
    );
  }
}

class _CounterValue extends StatelessWidget {
  const _CounterValue({required this.counter});

  final Counter counter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(l10n.counterHeadline),
        const SizedBox(height: Tokens.spaceSm),
        Text(
          '${counter.value}',
          key: const Key('counter-value'),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}

class _CounterActions extends StatelessWidget {
  const _CounterActions({
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
  });

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onReset,
          tooltip: l10n.resetTooltip,
          icon: const Icon(Icons.restart_alt),
        ),
        const SizedBox(width: Tokens.spaceSm),
        FloatingActionButton(
          heroTag: 'decrement',
          onPressed: onDecrement,
          tooltip: l10n.decrementTooltip,
          child: const Icon(Icons.remove),
        ),
        const SizedBox(width: Tokens.spaceSm),
        FloatingActionButton(
          heroTag: 'increment',
          onPressed: onIncrement,
          tooltip: l10n.incrementTooltip,
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

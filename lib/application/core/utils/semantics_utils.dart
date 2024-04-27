import 'package:flutter/semantics.dart';
import 'package:flutter/widgets.dart';

Future<void> sendFocusSemanticEventByKey(final GlobalKey key,
    {final Duration awaitDuration = const Duration(milliseconds: 500)}) async {
  await Future.delayed(awaitDuration);
  key.currentContext?.findRenderObject()?.sendSemanticsEvent(const FocusSemanticEvent());
}

Future<void> sendFocusSemanticEventByContext(final BuildContext context,
    {final Duration awaitDuration = const Duration(milliseconds: 500)}) async {
  await Future.delayed(awaitDuration);
  if (!context.mounted) return;
  context.findRenderObject()?.sendSemanticsEvent(const FocusSemanticEvent());
}

import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/colors.dart';

class BaseDialogue extends StatelessWidget {
  final String title;
  final String content;
  final DialogueAction mainAction;
  final DialogueAction? secondaryAction;

  const BaseDialogue({
    super.key,
    required this.title,
    required this.content,
    required this.mainAction,
    this.secondaryAction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: 270.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 24.0,
                bottom: 8.0,
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontFamily: 'SFProText',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                bottom: 24.0,
                right: 16.0,
              ),
              child: Text(
                content,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 46.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: BorderDirectional(
                          top: BorderSide(
                            color: CustomPalette.black10,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: mainAction.action,
                        child: Text(
                          mainAction.name,
                        ),
                      ),
                    ),
                  ),
                  if (secondaryAction != null) ...[
                    const Divider(
                      thickness: 10.0,
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          border: BorderDirectional(
                            top: BorderSide(
                              color: CustomPalette.black10,
                            ),
                            start: BorderSide(
                              color: CustomPalette.black10,
                            ),
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                          ),
                          onPressed: secondaryAction!.action,
                          child: Text(
                            secondaryAction!.name,
                            style: const TextStyle(
                              color: CustomPalette.errorRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DialogueAction {
  final String name;
  final void Function() action;
  DialogueAction({
    required this.name,
    required this.action,
  });
}

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/core/utils/styles/colors.dart';
import 'package:login/core/widgets/common_user_data.dart';
import 'package:login/features/social_network_functionality/presentation/create_post/cubit/create_post_state.dart';
import 'package:login/navigation/app_router.gr.dart';

import '../../../../translations/locale_keys.g.dart';
import 'cubit/create_post_cubit.dart';

class CreatePostPage extends StatelessWidget {
  final String imagePath;

  const CreatePostPage({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreatePostCubit>();
    final style = Theme.of(context);
    return BlocConsumer<CreatePostCubit, CreatePostState>(
        bloc: cubit,
        listenWhen: (prev, cur) {
          return cur.successfullyCreated;
        },
        listener: (context, state) {
          context.router.pop();
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text(
                          LocaleKeys.cancelPostCreationDialogTitle.tr(),
                          style: style.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              context.router.pop();
                            },
                            child: Text(LocaleKeys.cancel.tr()),
                          ),
                          CupertinoDialogAction(
                            onPressed: () {
                              context.router.navigate(
                                const MainNavigationPageRoute(),
                              );
                              context.router.pop();
                            },
                            isDestructiveAction: true,
                            child: Text(
                              LocaleKeys.leavingConfirmation.tr(),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: style.textTheme.bodyMedium,
                ),
              ),
              title: Center(
                child: Text(
                  LocaleKeys.newPost.tr(),
                  style: style.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton(
                    onPressed: () {
                      cubit.onPostCreated(imagePath);
                    },
                    child: Text(
                      LocaleKeys.share.tr(),
                      style: style.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: CustomPalette.loginblue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 358.0,
                      child: Image.file(
                        File(imagePath),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: 150.0,
                        child: CommonUserData(
                          hintText: 'Post description',
                          onChanged: (text) {
                            cubit.onTextInput(text);
                          },
                          errorText: state.descriptionField.message,
                          maxLength: 500,
                          maxLines: 8,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

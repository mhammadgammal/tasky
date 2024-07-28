import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/theme/app_color.dart';
import 'package:tasky/core/widgets/auth_error_dialogue.dart';
import 'package:tasky/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileDataLoadFailState) {
          showDialog(
              context: context,
              builder: (context) => const AuthErrorDialogue(
                  errorMessage: 'Getting data failed, try again later'));
        }
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            title: const Text('Profile'),
          ),
          body: state is ProfileDataLoadingState
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.mainColor,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsetsDirectional.all(15.0),
                  itemCount: cubit.getUserProfileFields().length,
                  itemBuilder: (context, index) => Card(
                        elevation: 0.0,
                        color: AppColor.lightGrey2,
                        child: ListTile(
                            title: Text(
                              cubit.fields[index],
                              style: TextStyle(color: AppColor.lightGrey),
                            ),
                            subtitle: Text(
                              cubit.getUserProfileFields()[index],
                              style: TextStyle(color: AppColor.solidGrey),
                            ),
                            trailing: index == 1
                                ? IconButton(
                                    onPressed: () => Clipboard.setData(
                                        ClipboardData(
                                            text: cubit.profile == null
                                                ? ''
                                                : cubit.profile!.phone)),
                                    icon: const Icon(
                                      Icons.content_copy,
                                      color: AppColor.mainColor,
                                    ))
                                : null),
                      )),
        );
      },
    );
  }
}

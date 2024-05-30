import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/admin_bloc/admin_states.dart';
import 'package:komiadmin/components/admin_comp/notify_users_dialog.dart';
import 'package:komiadmin/components/general/toast.dart';
import '../../blocs/admin_bloc/admin_cubit.dart';

// ignore: must_be_immutable
class MyAppBar extends StatefulWidget {
  bool home = false;

  MyAppBar({super.key, this.home = false});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AdminSuccess) {
          MyToast.customToast(state.msg, context);
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);
        return AppBar(
          foregroundColor: const Color(0xFF6C7293),
          surfaceTintColor: Colors.transparent,
          backgroundColor: const Color(0xFF191C24),
          title: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.home == true
                    ? IconButton(
                        tooltip: 'notify all users',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => NotifyUsersDialog(
                                ontap: () {
                                  AdminCubit.get(context)
                                      .announceUsers(context);
                                },
                                title: cubit.pushTitle,
                                body: cubit.pushBody),
                          );
                        },
                        icon: const Icon(Icons.notification_add))
                    : const SizedBox(),
                const SizedBox(
                  width: 15,
                ),
                CircleAvatar(
                  foregroundImage: cubit.adminDataModel != null
                      ? NetworkImage(
                          cubit.adminDataModel!.admindata![0]!.image!)
                      : null,
                  backgroundColor: const Color(0xFF6C7293),
                  radius: 20,
                  child: const Icon(Icons.person),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

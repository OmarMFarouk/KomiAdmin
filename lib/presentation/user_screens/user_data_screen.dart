import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/user_bloc/cashout_req_bloc/user_cubit.dart';
import 'package:komiadmin/blocs/user_bloc/cashout_req_bloc/user_states.dart';
import 'package:komiadmin/components/admin_comp/notify_users_dialog.dart';
import 'package:komiadmin/components/cashout_comp/cashout_actions.dart';
import 'package:komiadmin/components/general/custom_shimmer.dart';
import 'package:komiadmin/components/general/text_field.dart';
import 'package:komiadmin/src/app_navigator.dart';

import 'package:komiadmin/src/app_size.dart';

import '../../blocs/admin_bloc/admin_cubit.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key, required this.userName});
  final String userName;

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();
  @override
  void initState() {
    UserCubit.get(context).fetchUserInfo(widget.userName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: AppBar(
            foregroundColor: const Color(0xFF6C7293),
            surfaceTintColor: Colors.transparent,
            backgroundColor: const Color(0xFF191C24),
            title: Text(
              'DETAILS OF || ${widget.userName}',
              style: const TextStyle(
                  fontSize: 18,
                  letterSpacing: 01,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                  tooltip: 'notify user',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => NotifyUsersDialog(
                          ontap: () {
                            AdminCubit.get(context).announceUser(
                                UserCubit.get(context)
                                    .userDataModel!
                                    .userInfo![0]
                                    .fcmToken!,
                                _title.text,
                                _body.text,
                                context);
                          },
                          title: _title,
                          body: _body),
                    );
                  },
                  icon: const Icon(Icons.notification_add)),
              IconButton(
                onPressed: () {
                  showMenu(
                      color: const Color(0xFF191C24),
                      context: context,
                      position: const RelativeRect.fromLTRB(150, 50, 24, 100),
                      items: [
                        PopupMenuItem(
                            onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF191C24),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      height: AppSize.height(context) * 0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'MANAGE USER BALANCE',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.blueGrey.shade100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: _pointsController,
                                              textInputAction:
                                                  TextInputAction.done,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'add or remove points',
                                                  hintStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade600),
                                                  border: InputBorder.none,
                                                  filled: true,
                                                  fillColor:
                                                      const Color(0xFF2A3038))),
                                          CashoutActions(
                                              title: 'EDIT',
                                              ontap: _pointsController
                                                      .text.isNotEmpty
                                                  ? () {
                                                      UserCubit.get(context)
                                                          .editBalance(
                                                              widget.userName,
                                                              _pointsController
                                                                  .text);
                                                      AppNavigator.pop(context);
                                                      _pointsController.clear();
                                                    }
                                                  : () {},
                                              color: Colors.green.shade800),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            child: const Text(
                              'Manage Balance',
                              style: TextStyle(
                                  color: Color(0xFF6C7293),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                        PopupMenuItem(
                            onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF191C24),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      height: AppSize.height(context) * 0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'CONTROL USER ACCESS',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.blueGrey.shade100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          MyTextField(
                                              obscure: false,
                                              hint: 'Action Reason',
                                              isLast: true,
                                              controller: _reasonController),
                                          CashoutActions(
                                              title: 'BAN',
                                              ontap: _reasonController
                                                      .text.isNotEmpty
                                                  ? () {
                                                      UserCubit.get(context)
                                                          .banUser(
                                                              widget.userName,
                                                              _reasonController
                                                                  .text);

                                                      AppNavigator.pop(context);
                                                      _reasonController.clear();
                                                    }
                                                  : () {},
                                              color: Colors.amber.shade800),
                                          CashoutActions(
                                              title: 'DELETE',
                                              ontap: _reasonController
                                                      .text.isNotEmpty
                                                  ? () {
                                                      UserCubit.get(context)
                                                          .deleteUser(
                                                              widget.userName,
                                                              _reasonController
                                                                  .text);

                                                      AppNavigator.pop(context);
                                                      AppNavigator.pop(context);
                                                      _reasonController.clear();
                                                    }
                                                  : () {},
                                              color: Colors.red.shade700),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            child: const Text(
                              'Limit Access',
                              style: TextStyle(
                                  color: Color(0xFF6C7293),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ]);
                },
                icon: const Icon(Icons.more_vert_outlined),
              )
            ],
          )),
      backgroundColor: Colors.black,
      body: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = UserCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: cubit.userDataModel != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: AppSize.height(context) * 0.01,
                        ),
                        UserDataBox(
                          title: 'Balance',
                          icon: Icons.wallet,
                          value: cubit.userDataModel!.userInfo![0].balance!,
                        ),
                        UserDataBox(
                          title: 'E-mail',
                          icon: Icons.mail,
                          value: cubit.userDataModel!.userInfo![0].email!,
                        ),
                        MyExpansion(
                          title: 'Additional Info',
                          content: SizedBox(
                            height: AppSize.height(context) * 0.36,
                            child: ListView(children: [
                              UserDataBox(
                                title: 'Date Joined',
                                icon: Icons.calendar_month,
                                value: cubit
                                    .userDataModel!.userInfo![0].dateCreated!,
                              ),
                              UserDataBox(
                                title: 'Device',
                                icon: Icons.smartphone,
                                value: cubit
                                    .userDataModel!.userInfo![0].deviceInfo!,
                              ),
                              UserDataBox(
                                title: 'IP Address',
                                icon: Icons.language,
                                value:
                                    cubit.userDataModel!.userInfo![0].lastIp!,
                              ),
                            ]),
                          ),
                        ),
                        MyExpansion(
                          content: SizedBox(
                            height: cubit.userDataModel!.userCashout!.length < 3
                                ? AppSize.height(context) * 0.15
                                : AppSize.height(context) * 0.35,
                            child: ListView.builder(
                              itemCount:
                                  cubit.userDataModel!.userCashout!.length,
                              itemBuilder: (context, index) => UserDataBox(
                                title:
                                    '${cubit.userDataModel!.userCashout![index].status!}\n${cubit.userDataModel!.userCashout![index].dateCreated!}',
                                icon: Icons.monetization_on_outlined,
                                value:
                                    '${cubit.userDataModel!.userCashout![index].method!} ${cubit.userDataModel!.userCashout![index].amount!}'
                                            r'$' +
                                        '\nto\t' +
                                        cubit.userDataModel!.userCashout![index]
                                            .userInfo!,
                              ),
                            ),
                          ),
                          title: 'Cashout Requests',
                        ),
                        MyExpansion(
                          content: SizedBox(
                            height: cubit.userDataModel!.userLeads!.length < 3
                                ? AppSize.height(context) * 0.15
                                : AppSize.height(context) * 0.35,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: cubit.userDataModel!.userLeads!.length,
                              itemBuilder: (context, index) => UserDataBox(
                                title:
                                    '${cubit.userDataModel!.userLeads![index].points!} Points',
                                icon: Icons.money_rounded,
                                value:
                                    '${cubit.userDataModel!.userLeads![index].network!}/${cubit.userDataModel!.userLeads![index].offerName!}',
                              ),
                            ),
                          ),
                          title: 'Leads',
                        ),
                      ],
                    )
                  : const CustomShimmer(),
            ),
          );
        },
      ),
    );
  }
}

class UserDataBox extends StatelessWidget {
  const UserDataBox({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
  });
  final String title;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
          color: const Color(0xFF191C24),
          borderRadius: BorderRadius.circular(7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              SelectableText(
                value,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: title == 'E-mail' ? 13 : 15),
              )
            ],
          ),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.deepPurple.shade800),
              child: Icon(
                icon,
                size: 30,
                color: Colors.deepPurple.shade200,
              ))
        ],
      ),
    );
  }
}

class MyExpansion extends StatelessWidget {
  const MyExpansion({
    super.key,
    required this.content,
    required this.title,
  });
  final Widget content;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ExpansionWidget(
        initiallyExpanded: false,
        titleBuilder:
            (double animationValue, _, bool isExpaned, toogleFunction) {
          return InkWell(
              onTap: () => toogleFunction(animated: true),
              child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xFF191C24),
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.deepPurple.shade800),
                        child: Transform.rotate(
                          angle: 3.14 * animationValue / 2,
                          alignment: Alignment.center,
                          child: Icon(Icons.arrow_right,
                              color: Colors.deepPurple.shade200, size: 30),
                        ),
                      )
                    ],
                  )));
        },
        content: content);
  }
}

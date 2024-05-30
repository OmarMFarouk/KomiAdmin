import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/admin_bloc/admin_cubit.dart';
import 'package:komiadmin/blocs/admin_bloc/admin_states.dart';
import 'package:komiadmin/components/cashout_comp/cashout_actions.dart';
import 'package:komiadmin/components/general/custom_shimmer.dart';
import 'package:komiadmin/components/general/text_field.dart';
import 'package:komiadmin/components/general/toast.dart';

import '../components/admin_comp/config_tile.dart';
import '../services/functional/shared_prefs.dart';
import '../src/app_size.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AdminSuccess) {
          MyToast.customToast(state.msg, context);
          setState(() {});
        }
        if (state is AdminError) {
          MyToast.customToast(state.msg, context);
        }
      },
      builder: (context, state) {
        var cubit = AdminCubit.get(context);

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: AppBar(
                  foregroundColor: const Color(0xFF6C7293),
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: const Color(0xFF191C24),
                  title: const Text(
                    'ADMIN SETTINGS',
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 01,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ))),
          body: cubit.adminDataModel != null && cubit.configurationModel != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                        height: AppSize.height(context) * 0.01,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFF191C24),
                        ),
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  foregroundImage: cubit.path != ''
                                      ? FileImage(File(cubit.path))
                                          as ImageProvider
                                      : NetworkImage(cubit.adminDataModel!
                                              .admindata![0]!.image ??
                                          'https://cdn-icons-png.freepik.com/256/456/456212.png'),
                                  backgroundColor: Colors.deepPurple.shade800,
                                  radius: 50,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cubit.pickImage().whenComplete(() {
                                      setState(() {});
                                    });
                                  },
                                  child: Icon(
                                    Icons.edit_square,
                                    color: Colors.deepPurple.shade200,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            MyTextField(
                                obscure: false,
                                hint: cubit.adminDataModel!.admindata![0]!
                                        .adminname!.isEmpty
                                    ? r'Your Name'
                                    : cubit.adminDataModel!.admindata![0]!
                                        .adminname!,
                                isLast: true,
                                controller: cubit.name),
                            const SizedBox(
                              height: 10,
                            ),
                            MyTextField(
                                obscure: true,
                                hint: 'password',
                                isLast: true,
                                controller: cubit.password),
                            const SizedBox(
                              height: 10,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                r'points for 1$',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.deepOrange,
                                    letterSpacing: 1),
                              ),
                            ),
                            MyTextField(
                                obscure: false,
                                hint: cubit.adminDataModel!.admindata![0]!
                                        .percentage!.isEmpty
                                    ? r'points for 1$'
                                    : cubit.adminDataModel!.admindata![0]!
                                        .percentage!,
                                isLast: true,
                                controller: cubit.percentage),
                            CashoutActions(
                                title: 'SAVE',
                                ontap: () async {
                                  await cubit.saveAdminData();

                                  setState(() {
                                    cubit.path = '';
                                  });
                                },
                                color: Colors.deepPurple.shade800)
                          ],
                        )),
                      ),
                      SizedBox(
                        height: AppSize.height(context) * 0.01,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFF191C24),
                        ),
                        child: SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Authentication Security',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  color: Color(0xFF6C7293)),
                            ),
                            const Divider(
                              color: Colors.blueGrey,
                            ),
                            ConfigTile(
                              value: SharedPref.localStorage!
                                  .getBool('multiple-accounts')!,
                              option: 'Allow Multiple Accounts',
                              onchanged: (s) {
                                setState(() {
                                  SharedPref.localStorage!
                                      .setBool('multiple-accounts', s);
                                });
                                cubit.editConfigs(
                                    multipleAccounts: s.toString(),
                                    fakeEmail: '',
                                    vpn: '');
                              },
                            ),
                            ConfigTile(
                              value: SharedPref.localStorage!
                                  .getBool('fake-email')!,
                              option: 'Allow Fake Email',
                              onchanged: (s) {
                                setState(() {
                                  SharedPref.localStorage!
                                      .setBool('fake-email', s);
                                });
                                cubit.editConfigs(
                                    multipleAccounts: '',
                                    fakeEmail: s.toString(),
                                    vpn: '');
                              },
                            ),
                          ],
                        )),
                      ),
                      SizedBox(
                        height: AppSize.height(context) * 0.01,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xFF191C24),
                        ),
                        child: SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'In-App Security',
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  color: Color(0xFF6C7293)),
                            ),
                            const Divider(
                              color: Colors.blueGrey,
                            ),
                            ConfigTile(
                              value: SharedPref.localStorage!
                                  .getBool('allow-vpn')!,
                              option: 'Allow VPN',
                              onchanged: (s) {
                                setState(() {
                                  SharedPref.localStorage!
                                      .setBool('allow-vpn', s);
                                });
                                cubit.editConfigs(
                                    multipleAccounts: '',
                                    fakeEmail: '',
                                    vpn: s.toString());
                              },
                            ),
                          ],
                        )),
                      ),
                    ]),
                  ))
              : const CustomShimmer(),
        );
      },
    );
  }
}

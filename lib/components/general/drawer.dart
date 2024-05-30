import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/admin_bloc/admin_cubit.dart';
import 'package:komiadmin/presentation/auth_screens/login_screen.dart';
import 'package:komiadmin/presentation/cashout_methods_screens/cashout_methods_screen.dart';
import 'package:komiadmin/presentation/cashout_screens.dart/cashout_screen.dart';
import 'package:komiadmin/presentation/home_screen.dart';
import 'package:komiadmin/presentation/leads_screens/leads_screen.dart';
import 'package:komiadmin/presentation/offerwall_screens/offerwall_screen.dart';
import 'package:komiadmin/presentation/settings_screen.dart';
import 'package:komiadmin/presentation/user_screens/users_screen.dart';
import 'package:komiadmin/services/functional/shared_prefs.dart';
import 'package:komiadmin/src/app_navigator.dart';
import 'package:komiadmin/src/app_size.dart';
import 'drawer_tile.dart';

bool isSelected = true;
int id = 1;

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      backgroundColor: const Color(0xFF191C24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(alignment: Alignment.bottomRight, children: [
                      CircleAvatar(
                        foregroundImage: BlocProvider.of<AdminCubit>(context)
                                    .adminDataModel !=
                                null
                            ? NetworkImage(BlocProvider.of<AdminCubit>(context)
                                    .adminDataModel!
                                    .admindata![0]!
                                    .image ??
                                'https://cdn-icons-png.freepik.com/256/456/456212.png')
                            : null,
                        backgroundColor: const Color(0xFF6C7293),
                        child: const Icon(Icons.person),
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                      )
                    ]),
                    SizedBox(
                      width: AppSize.width(context) * 0.025,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SharedPref.localStorage!.getString('name')!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Admin',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4D557E)),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    AppNavigator.push(context, const SettingsScreen());
                  },
                  icon: const Icon(Icons.settings, color: Color(0xFF4D557E)),
                ),
              ],
            ),
            const Divider(
              color: Color(0xFF4D557E),
              indent: 15,
              endIndent: 15,
            ),
            const Text(
              'MAIN PAGES',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4D557E),
                  fontStyle: FontStyle.italic),
            ),
            DrawerTile(
              icon: Icons.home,
              title: 'Dashboard',
              ontap: () {
                id == 1
                    ? null
                    : AppNavigator.pushR(context, const HomeScreen());
                setState(() {
                  id = 1;
                  isSelected = true;
                });
              },
              isSelected: isSelected == true && id == 1 ? true : false,
            ),
            DrawerTile(
              icon: Icons.group,
              title: 'Users',
              ontap: () {
                setState(() {
                  id == 2
                      ? null
                      : AppNavigator.pushR(context, const UsersScreen());
                  id = 2;
                  isSelected = true;
                });
              },
              isSelected: isSelected == true && id == 2 ? true : false,
            ),
            DrawerTile(
              icon: Icons.receipt_long_outlined,
              title: 'Recent Leads',
              ontap: () {
                setState(() {
                  id == 3
                      ? null
                      : AppNavigator.pushR(context, const LeadsScreen());
                  id = 3;
                  isSelected = true;
                });
              },
              isSelected: isSelected == true && id == 3 ? true : false,
            ),
            DrawerTile(
              icon: Icons.monetization_on_outlined,
              title: 'Cash-out Requests',
              ontap: () {
                id == 4
                    ? null
                    : AppNavigator.pushR(context, const CashoutScreen());
                setState(() {
                  id = 4;
                  isSelected = true;
                });
              },
              isSelected: isSelected == true && id == 4 ? true : false,
            ),
            DrawerTile(
              icon: Icons.money,
              title: 'Cash-out Methods',
              ontap: () {
                setState(() {
                  id == 5
                      ? null
                      : AppNavigator.pushR(
                          context, const CashoutMethodsScreen());
                  id = 5;
                  isSelected = true;
                });
              },
              isSelected: isSelected == true && id == 5 ? true : false,
            ),
            DrawerTile(
              icon: Icons.local_offer_sharp,
              title: 'Offer Walls',
              ontap: () {
                id == 6
                    ? null
                    : AppNavigator.pushR(context, const OfferWallScreen());
                setState(() {
                  id = 6;
                  isSelected = true;
                });
              },
              isSelected: isSelected == true && id == 6 ? true : false,
            ),
            SizedBox(
              height: AppSize.height(context) * 0.2,
            ),
            TextButton(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 50)),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF6C7293))),
                onPressed: () {
                  SharedPref.localStorage?.setBool('active', false);
                  AppNavigator.pushR(context, const LoginScreen());
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 18,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}

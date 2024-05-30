import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/admin_bloc/admin_cubit.dart';
import 'package:komiadmin/blocs/analytics_bloc/analytics_cubit.dart';
import 'package:komiadmin/blocs/auth_bloc/auth_cubit.dart';
import 'package:komiadmin/blocs/cashout_bloc/cashout_cubit.dart';
import 'package:komiadmin/blocs/leads_bloc/leads_cubit.dart';
import 'package:komiadmin/blocs/offerwall_bloc/offerwall_cubit.dart';
import 'package:komiadmin/blocs/user_bloc/cashout_req_bloc/user_cubit.dart';
import 'package:komiadmin/presentation/auth_screens/login_screen.dart';
import 'package:komiadmin/presentation/home_screen.dart';

import '../services/functional/shared_prefs.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          if (SharedPref.localStorage?.getBool('active') == true) {
            return AdminCubit()
              ..fetchAdminData()
              ..fetchConfigs();
          } else {
            return AdminCubit();
          }
        }),
        BlocProvider(create: (context) {
          if (SharedPref.localStorage?.getBool('active') == true) {
            return AnalyticsCubit()
              ..fetchAnalytics()
              ..fetchCountries();
          } else {
            return AnalyticsCubit();
          }
        }),
        BlocProvider(create: (context) {
          if (SharedPref.localStorage?.getBool('active') == true) {
            return UserCubit()..fetchUsers();
          } else {
            return UserCubit();
          }
        }),
        BlocProvider(create: (context) {
          if (SharedPref.localStorage?.getBool('active') == true) {
            return CashoutCubit()
              ..fetchTransactions()
              ..fetchMethods();
          } else {
            return CashoutCubit();
          }
        }),
        BlocProvider(create: (context) {
          if (SharedPref.localStorage?.getBool('active') == true) {
            return OfferWallCubit()..fetchOfferWalls();
          } else {
            return OfferWallCubit();
          }
        }),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(create: (context) {
          if (SharedPref.localStorage?.getBool('active') == true) {
            return LeadsCubit()..fetchLeads();
          } else {
            return LeadsCubit();
          }
        }),
      ],
      child: SafeArea(
        child: MaterialApp(
          theme: ThemeData(
              fontFamily: 'ZillaSlab',
              textTheme: const TextTheme(
                      bodyLarge: TextStyle(), bodyMedium: TextStyle())
                  .apply(bodyColor: Colors.white, displayColor: Colors.white)),
          debugShowCheckedModeBanner: false,
          home: SharedPref.localStorage!.getBool('active') == true
              ? const HomeScreen()
              : const LoginScreen(),
        ),
      ),
    );
  }
}

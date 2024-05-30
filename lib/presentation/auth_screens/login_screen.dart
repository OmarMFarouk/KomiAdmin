import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/auth_bloc/auth_cubit.dart';
import 'package:komiadmin/blocs/auth_bloc/auth_states.dart';
import 'package:komiadmin/components/general/background.dart';
import 'package:komiadmin/components/general/text_field.dart';
import 'package:komiadmin/components/general/toast.dart';
import 'package:komiadmin/presentation/home_screen.dart';
import 'package:komiadmin/src/app_navigator.dart';
import 'package:komiadmin/src/app_size.dart';

import '../../components/general/check_box.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GradientBackground(),
        BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              MyToast.customToast(state.msg, context);
              AuthCubit.get(context).clearAndSave();
              AppNavigator.pushR(context, const HomeScreen());
            }
            if (state is AuthError) {
              MyToast.customToast(state.msg, context);
            }
          },
          builder: (context, state) {
            var cubit = AuthCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  width: AppSize.width(context) * 0.8,
                  height: AppSize.height(context) * 0.6,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 50),
                  decoration: const BoxDecoration(color: Color(0xFF191C24)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: AppSize.height(context) * 0.01,
                        ),
                        MyTextField(
                          controller: cubit.adminId,
                          obscure: false,
                          hint: 'ID',
                          isLast: false,
                        ),
                        SizedBox(
                          height: AppSize.height(context) * 0.03,
                        ),
                        MyTextField(
                          controller: cubit.password,
                          obscure: true,
                          hint: 'Password',
                          isLast: true,
                        ),
                        SizedBox(
                          height: AppSize.height(context) * 0.03,
                        ),
                        const Row(
                          children: [
                            MyCheckBox(),
                          ],
                        ),
                        SizedBox(
                          height: AppSize.height(context) * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            cubit.loginAdmin();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: AppSize.height(context) * 0.07,
                            decoration: const BoxDecoration(color: Colors.blue),
                            child: const Text(
                              'L O G I N',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: AppSize.height(context) * 0.015,
                        ),
                        const Center(
                          child: Text(
                            '\nADMIN PANEL',
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                letterSpacing: 3,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/auth_bloc/auth_cubit.dart';
import 'package:komiadmin/blocs/auth_bloc/auth_states.dart';

import '../../src/app_size.dart';

class MyCheckBox extends StatefulWidget {
  const MyCheckBox({
    super.key,
  });

  @override
  State<MyCheckBox> createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        AuthCubit.get(context).rememberID;
      },
      builder: (context, state) => GestureDetector(
        onTap: () {
          setState(() {
            AuthCubit.get(context).rememberID =
                !AuthCubit.get(context).rememberID;
          });
        },
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: AppSize.width(context) * 0.055,
              height: AppSize.height(context) * 0.025,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1.5),
                shape: BoxShape.rectangle,
              ),
              child: AuthCubit.get(context).rememberID == true
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
            const Text(
              '\tRemember Me',
              style: TextStyle(color: Colors.blueGrey),
            )
          ],
        ),
      ),
    );
  }
}

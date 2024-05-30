import 'package:flutter/material.dart';
import 'package:komiadmin/presentation/user_screens/user_data_screen.dart';
import 'package:komiadmin/src/app_size.dart';

import '../../src/app_navigator.dart';

class UsersListTile extends StatelessWidget {
  const UsersListTile({
    super.key,
    required this.id,
    required this.username,
  });
  final String username, id;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 5),
      width: AppSize.width(context),
      height: AppSize.height(context) * 0.075,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xFF191C24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSize.width(context) * 0.1,
            child: Text(
              '# $id',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          SizedBox(
            width: AppSize.width(context) * 0.45,
            child: SelectableText(
              username,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const VerticalDivider(
            color: Colors.blueGrey,
            endIndent: 12,
            indent: 12,
          ),
          SizedBox(
            width: AppSize.width(context) * 0.15,
            child: GestureDetector(
              onTap: () {
                AppNavigator.push(context, UserDataScreen(userName: username));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                height: AppSize.height(context) * 0.04,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade600,
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'VIEW',
                  style: TextStyle(letterSpacing: 1, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

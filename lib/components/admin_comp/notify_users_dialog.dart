import 'package:flutter/material.dart';
import 'package:komiadmin/src/app_size.dart';
import '../cashout_comp/cashout_actions.dart';
import '../general/text_field.dart';

class NotifyUsersDialog extends StatefulWidget {
  const NotifyUsersDialog({
    super.key,
    required this.title,
    required this.body,
    required this.ontap,
  });
  final VoidCallback ontap;
  final TextEditingController title, body;

  @override
  State<NotifyUsersDialog> createState() => _NotifyUsersDialogState();
}

class _NotifyUsersDialogState extends State<NotifyUsersDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: Colors.transparent,
      backgroundColor: const Color(0xFF191C24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        height: AppSize.height(context) * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.deepPurple.shade800,
              radius: 30,
              child: Icon(
                Icons.announcement,
                color: Colors.deepPurple.shade200,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
                obscure: false,
                hint: 'Title',
                isLast: false,
                controller: widget.title),
            const SizedBox(
              height: 5,
            ),
            MyTextField(
                obscure: false,
                hint: 'Announcement',
                isLast: false,
                controller: widget.body),
            const SizedBox(
              height: 5,
            ),
            CashoutActions(
                title: 'SEND',
                ontap: widget.ontap,
                color: Colors.green.shade700),
          ],
        ),
      ),
    );
  }
}

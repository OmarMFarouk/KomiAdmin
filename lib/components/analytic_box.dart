import 'package:flutter/material.dart';
import 'package:komiadmin/src/app_size.dart';

import '../services/functional/shared_prefs.dart';

class AnalyticsWidget extends StatelessWidget {
  const AnalyticsWidget(
      {super.key,
      required this.dailyIncome,
      required this.pending,
      required this.newUsers,
      required this.activeUsers});
  final String dailyIncome, pending, newUsers, activeUsers;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnalyticBox(
            icon: Icons.wallet,
            title: "Daily Income",
            value: SharedPref.localStorage!
                    .getDouble('percentage')
                    .toString()
                    .isNotEmpty
                ? r"$" +
                    ((double.parse(dailyIncome)) /
                            (SharedPref.localStorage!.getDouble('percentage') ??
                                500))
                        .toStringAsFixed(3)
                : 'reload'),
        AnalyticBox(
          icon: Icons.monetization_on_outlined,
          title: "Pending Cash-Outs",
          value: pending,
        ),
        AnalyticBox(
          icon: Icons.person,
          title: "New Users",
          value: newUsers,
        ),
        AnalyticBox(
          icon: Icons.group,
          title: "Daily Active Users",
          value: activeUsers,
        ),
      ],
    );
  }
}

class AnalyticBox extends StatelessWidget {
  const AnalyticBox({
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
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
          color: const Color(0xFF191C24),
          borderRadius: BorderRadius.circular(7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: AppSize.width(context) * 0.6,
                child: Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
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

class MoreAnalyticsWidget extends StatelessWidget {
  const MoreAnalyticsWidget(
      {super.key,
      required this.dailyIncome,
      required this.pending,
      required this.newUsers,
      required this.activeUsers});
  final String dailyIncome, pending, newUsers, activeUsers;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnalyticBox(
            icon: Icons.wallet,
            title: "Weekly Income",
            value: r"$" +
                '${double.parse(dailyIncome) / SharedPref.localStorage!.getDouble('percentage')!}'),
        AnalyticBox(
            icon: Icons.monetization_on_outlined,
            title: "Monthly Income",
            value: r"$" +
                '${double.parse(pending) / SharedPref.localStorage!.getDouble('percentage')!}'),
        AnalyticBox(
          icon: Icons.person,
          title: "Month's New Users",
          value: newUsers,
        ),
        AnalyticBox(
          icon: Icons.group,
          title: "Monthly Active Users",
          value: activeUsers,
        ),
      ],
    );
  }
}

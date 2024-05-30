import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/analytics_bloc/analytics_cubit.dart';
import 'package:komiadmin/blocs/analytics_bloc/analytics_states.dart';
import 'package:komiadmin/components/general/custom_shimmer.dart';
import 'package:komiadmin/components/general/drawer.dart';
import 'package:komiadmin/presentation/user_screens/user_data_screen.dart';
import 'package:komiadmin/src/app_size.dart';

import '../components/analytic_box.dart';
import '../components/general/app_bar.dart';
import '../components/general/countries_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnalyticsCubit, AnalyticsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AnalyticsCubit.get(context);
        return Scaffold(
          drawer: Container(
              margin: const EdgeInsets.only(top: kToolbarHeight),
              child: const MyDrawer()),
          appBar: PreferredSize(
              preferredSize: const Size(double.infinity, kToolbarHeight),
              child: MyAppBar(
                home: true,
              )),
          backgroundColor: Colors.black,
          body: RefreshIndicator(
            backgroundColor: const Color(0xFF6C7293),
            color: Colors.deepPurple.shade700,
            onRefresh: () async => cubit
              ..fetchAnalytics()
              ..fetchCountries(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSize.height(context) * 0.01,
                    ),
                    cubit.analyticsModel != null
                        ? AnalyticsWidget(
                            activeUsers: cubit.analyticsModel!
                                    .dailyAnalytics![0].sessions ??
                                '0',
                            dailyIncome: cubit.analyticsModel!
                                    .dailyAnalytics![0].revenue ??
                                '0',
                            newUsers: cubit.analyticsModel!.dailyAnalytics![0]
                                    .newUsers ??
                                '0',
                            pending:
                                '${cubit.analyticsModel!.pending![0].count}',
                          )
                        : const CustomShimmer(),
                    Container(
                        height: AppSize.height(context) * 0.3,
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                            color: const Color(0xFF191C24),
                            borderRadius: BorderRadius.circular(7)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Users by country',
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic),
                              ),
                              Expanded(
                                child: cubit.countriesModel != null
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: cubit
                                            .countriesModel!.countries!.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              CountryTile(
                                                id: cubit.countriesModel!
                                                    .countries![index]!.count!,
                                                country: cubit
                                                    .countriesModel!
                                                    .countries![index]!
                                                    .countrycode!,
                                              ),
                                              const Divider(
                                                color: Colors.blueGrey,
                                                endIndent: 12,
                                                indent: 12,
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : const CustomShimmer(),
                              ),
                            ])),
                    cubit.analyticsModel != null
                        ? MyExpansion(
                            title: 'More Analytics',
                            content: SizedBox(
                                height: AppSize.height(context) * 0.7,
                                child: MoreAnalyticsWidget(
                                  activeUsers: cubit.analyticsModel!
                                          .monthlyAnalytics![0].sessions ??
                                      '0',
                                  dailyIncome: cubit.analyticsModel!
                                          .weeklyAnalytics![0].revenue ??
                                      '0',
                                  newUsers: cubit.analyticsModel!
                                          .monthlyAnalytics![0].newUsers ??
                                      '0',
                                  pending: cubit.analyticsModel!
                                          .monthlyAnalytics![0].revenue ??
                                      '0',
                                )),
                          )
                        : const CustomShimmer(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

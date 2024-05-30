import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/cashout_bloc/cashout_cubit.dart';
import 'package:komiadmin/blocs/cashout_bloc/cashout_states.dart';
import 'package:komiadmin/components/cashout_comp/cashout_actions.dart';
import 'package:komiadmin/components/general/drawer.dart';
import 'package:komiadmin/presentation/cashout_screens.dart/completed_cashout_screen.dart';
import 'package:komiadmin/presentation/cashout_screens.dart/pending_cashout_screen.dart';
import 'package:komiadmin/presentation/cashout_screens.dart/rejected_cashout_screen.dart';

import '../../components/cashout_comp/cashout_list_tile.dart';
import '../../components/general/app_bar.dart';
import '../../components/general/search_field.dart';
import '../../components/general/toast.dart';
import '../../src/app_size.dart';

int index = 0;

class CashoutScreen extends StatefulWidget {
  const CashoutScreen({super.key});

  @override
  State<CashoutScreen> createState() => _CashoutScreenState();
}

PageController pageController = PageController();

class _CashoutScreenState extends State<CashoutScreen> {
  TextEditingController searchCont = TextEditingController();
  final List _searchResultData = [];

  void getMatch(requests) {
    String value = searchCont.text.toLowerCase();

    _searchResultData.clear();
    for (var item in requests) {
      if (item.username.toLowerCase().contains(value) ||
          item.userinfo.toLowerCase().contains(value) &&
              !_searchResultData.contains(item)) {
        setState(() => _searchResultData.add(item));
      } else if (value.isEmpty) {
        searchCont.clear();
      }
    }
  }

  @override
  void initState() {
    pageController = PageController(initialPage: index);
    BlocProvider.of<CashoutCubit>(context).fetchTransactions();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CashoutCubit, CashoutStates>(
      listener: (context, state) {
        if (state is CashoutError) {
          MyToast.customToast(state.msg, context);
        }
      },
      builder: (context, state) {
        var cubit = CashoutCubit.get(context);

        return Scaffold(
            backgroundColor: Colors.black,
            drawer: Container(
                margin: const EdgeInsets.only(top: kToolbarHeight),
                child: const MyDrawer()),
            appBar: PreferredSize(
                preferredSize: const Size(double.infinity, kToolbarHeight),
                child: MyAppBar()),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(children: [
                  SizedBox(
                    height: AppSize.height(context) * 0.01,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFF191C24),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CashoutActions(
                              color: index == 0
                                  ? Colors.amber.shade800
                                  : Colors.blueGrey,
                              ontap: () {
                                setState(() {
                                  _searchResultData.clear();
                                  searchCont.clear();
                                  index = 0;
                                });
                                if (pageController.hasClients) {
                                  pageController.jumpToPage(
                                    0,
                                  );
                                }
                              },
                              title: ' PENDING ',
                            ),
                            CashoutActions(
                              color: index == 1
                                  ? Colors.green.shade800
                                  : Colors.blueGrey,
                              ontap: () {
                                setState(() {
                                  _searchResultData.clear();
                                  searchCont.clear();
                                  index = 1;
                                });
                                if (pageController.hasClients) {
                                  pageController.jumpToPage(
                                    1,
                                  );
                                }
                              },
                              title: ' COMPLETED ',
                            ),
                            CashoutActions(
                              color: index == 2
                                  ? Colors.red.shade800
                                  : Colors.blueGrey,
                              ontap: () {
                                setState(() {
                                  _searchResultData.clear();
                                  searchCont.clear();
                                  index = 2;
                                });

                                if (pageController.hasClients) {
                                  pageController.jumpToPage(
                                    2,
                                  );
                                }
                              },
                              title: ' REJECTED ',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.height(context) * 0.01,
                  ),
                  MySearch(
                      searchCont: searchCont,
                      onChanged: () {
                        if (index == 0) {
                          getMatch(
                              cubit.cashoutRequestModel!.pendingTransaction);
                        }
                        if (index == 1) {
                          getMatch(
                              cubit.cashoutRequestModel!.completedTransaction);
                        }

                        if (index == 2) {
                          getMatch(
                              cubit.cashoutRequestModel!.rejectedTransaction);
                        }
                      }),
                  SizedBox(
                    height: AppSize.height(context) * 0.01,
                  ),
                  _searchResultData.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _searchResultData.length,
                          itemBuilder: (context, index) => CashoutListTile(
                            cashoutAmount: _searchResultData[index].amount,
                            type: 'pending',
                            date: _searchResultData[index].datecreated!,
                            cashoutInfo: _searchResultData[index].userinfo!,
                            id: '${_searchResultData[index].id}',
                            image: _searchResultData[index].methodImage!,
                            userName: _searchResultData[index].username!,
                          ),
                        ))
                      : cubit.cashoutRequestModel != null
                          ? Expanded(
                              child: PageView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageController,
                                  children: [
                                    cubit.cashoutRequestModel!
                                            .pendingTransaction!.isNotEmpty
                                        ? RefreshIndicator(
                                            backgroundColor:
                                                const Color(0xFF6C7293),
                                            color: Colors.deepPurple.shade700,
                                            onRefresh: () async =>
                                                cubit.fetchTransactions(),
                                            child: PendingCashoutScreen(
                                                cashoutRequestModel:
                                                    cubit.cashoutRequestModel!),
                                          )
                                        : const Center(
                                            child: Text(
                                              'NO PENDING REQUESTS',
                                              style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                    cubit.cashoutRequestModel!
                                            .completedTransaction!.isNotEmpty
                                        ? CompletedCashout(
                                            cashoutRequestModel:
                                                cubit.cashoutRequestModel!)
                                        : const Center(
                                            child: Text(
                                              'NO COMPLETED REQUESTS',
                                              style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                    cubit.cashoutRequestModel!
                                            .rejectedTransaction!.isNotEmpty
                                        ? RejectedCashout(
                                            cashoutRequestModel:
                                                cubit.cashoutRequestModel!)
                                        : const Center(
                                            child: Text(
                                              'NO REJECTED REQUESTS',
                                              style: TextStyle(
                                                color: Colors.deepOrange,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                  ]),
                            )
                          : const Center(
                              child: Text('No User Found'),
                            )
                ])));
      },
    );
  }
}

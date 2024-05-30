import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/offerwall_bloc/offerwall_cubit.dart';
import 'package:komiadmin/blocs/offerwall_bloc/offerwall_states.dart';
import 'package:komiadmin/components/cashout_comp/cashout_actions.dart';
import 'package:komiadmin/components/general/custom_shimmer.dart';
import 'package:komiadmin/components/general/drawer.dart';
import 'package:komiadmin/presentation/offerwall_screens/activated_offerwall_screen.dart';
import 'package:komiadmin/presentation/offerwall_screens/deactivated_offerwall_screen.dart';
import '../../components/general/app_bar.dart';
import '../../components/general/toast.dart';
import '../../components/offerwall_comp/offerwall_add_dialog.dart';
import '../../src/app_size.dart';

int index = 0;

class OfferWallScreen extends StatefulWidget {
  const OfferWallScreen({super.key});

  @override
  State<OfferWallScreen> createState() => _OfferWallScreenState();
}

PageController _pageController = PageController();

class _OfferWallScreenState extends State<OfferWallScreen> {
  @override
  void initState() {
    _pageController = PageController(initialPage: index);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferWallCubit, OfferWallStates>(
      listener: (context, state) {
        if (state is OfferWallError) {
          MyToast.customToast(state.msg, context);
        }
      },
      builder: (context, state) {
        var cubit = OfferWallCubit.get(context);

        return Scaffold(
            floatingActionButton: FloatingActionButton(
                tooltip: 'Add Method',
                backgroundColor: Colors.deepPurple.shade800,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AddOfferWallDialog(
                          rateCont: cubit.offerWallRate,
                          titleCont: cubit.offerWallName,
                          urlCont: cubit.offerWallurl,
                          skinCont: cubit.offerWallSkin));
                }),
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
                                  ? Colors.green.shade800
                                  : Colors.blueGrey,
                              ontap: () {
                                setState(() {
                                  index = 0;
                                });
                                if (_pageController.hasClients) {
                                  _pageController.jumpToPage(
                                    0,
                                  );
                                }
                              },
                              title: ' ACTIVATED ',
                            ),
                            CashoutActions(
                              color: index == 1
                                  ? Colors.red.shade800
                                  : Colors.blueGrey,
                              ontap: () {
                                setState(() {
                                  index = 1;
                                });
                                if (_pageController.hasClients) {
                                  _pageController.jumpToPage(
                                    1,
                                  );
                                }
                              },
                              title: ' DE-ACTIVATED ',
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
                  cubit.offerWallModel != null
                      ? Expanded(
                          child: PageView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              children: [
                                cubit.offerWallModel!.activatedOfferwalls!
                                        .isNotEmpty
                                    ? ActivatedOfferWallScreen(
                                        offerWallModel: cubit.offerWallModel!)
                                    : const Center(
                                        child: Text(
                                          'NO AVAILABLE OFFERWALLS',
                                          style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                cubit.offerWallModel!.deactivatedOfferwalls!
                                        .isNotEmpty
                                    ? DeactivatedOfferWallScreen(
                                        offerWallModel: cubit.offerWallModel!)
                                    : const Center(
                                        child: Text(
                                          'NO AVAILABLE OFFERWALLS',
                                          style: TextStyle(
                                            color: Colors.deepOrange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ]),
                        )
                      : const Expanded(child: CustomShimmer())
                ])));
      },
    );
  }
}

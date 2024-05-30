import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/Leads_bloc/Leads_states.dart';
import 'package:komiadmin/blocs/leads_bloc/leads_cubit.dart';
import 'package:komiadmin/components/general/custom_shimmer.dart';
import 'package:komiadmin/components/general/drawer.dart';
import 'package:komiadmin/components/leads_comp/leads_tile.dart';
import '../../components/general/app_bar.dart';
import '../../components/general/toast.dart';
import '../../src/app_size.dart';

int index = 0;

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  TextEditingController searchCont = TextEditingController();
  final List _searchResultData = [];
  int mode = 0;
  void getMatch(leads) {
    String value = searchCont.text;
    for (var item in leads) {
      if (item.username.contains(value) && !_searchResultData.contains(item)) {
        setState(() => _searchResultData.add(item));

        setState(() {
          mode = 1;
        });
      }
      if (value == "") {
        setState(() {
          mode = 0;
          _searchResultData.clear();
        });
      }
    }
  }

  @override
  void initState() {
    LeadsCubit.get(context).fetchLeads();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LeadsCubit, LeadsStates>(
      listener: (context, state) {
        if (state is LeadsError) {
          MyToast.customToast(state.msg, context);
        }
      },
      builder: (context, state) {
        var cubit = LeadsCubit.get(context);

        return Scaffold(
            backgroundColor: Colors.black,
            drawer: Container(
                margin: const EdgeInsets.only(top: kToolbarHeight),
                child: const MyDrawer()),
            appBar: PreferredSize(
                preferredSize: Size(double.infinity, kToolbarHeight),
                child: MyAppBar()),
            body: RefreshIndicator(
              backgroundColor: const Color(0xFF6C7293),
              color: Colors.deepPurple.shade700,
              onRefresh: () async => cubit.fetchLeads(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(children: [
                    SizedBox(
                      height: AppSize.height(context) * 0.01,
                    ),
                    cubit.leadsModel != null && mode == 0
                        ? Expanded(
                            child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.leadsModel!.leads!.length,
                            itemBuilder: (context, index) => LeadsListTile(
                              date: cubit.leadsModel!.formattedDate![index]!,
                              network:
                                  cubit.leadsModel!.leads![index]!.network!,
                              id: cubit.leadsModel!.leads![index]!.id!,
                              points: cubit.leadsModel!.leads![index]!.points!,
                              username:
                                  cubit.leadsModel!.leads![index]!.username!,
                              offerName:
                                  cubit.leadsModel!.leads![index]!.offername!,
                            ),
                          ))
                        : _searchResultData.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _searchResultData.length,
                                itemBuilder: (context, index) => LeadsListTile(
                                  date: _searchResultData[index].date,
                                  network: _searchResultData[index].network,
                                  id: _searchResultData[index].id,
                                  points: _searchResultData[index].points,
                                  username: _searchResultData[index].username,
                                  offerName: _searchResultData[index].offername,
                                ),
                              ))
                            : const Expanded(child: CustomShimmer())
                  ])),
            ));
      },
    );
  }
}

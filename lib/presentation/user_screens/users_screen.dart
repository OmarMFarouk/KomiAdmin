import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komiadmin/blocs/user_bloc/cashout_req_bloc/user_cubit.dart';
import 'package:komiadmin/blocs/user_bloc/cashout_req_bloc/user_states.dart';
import 'package:komiadmin/components/general/drawer.dart';
import '../../components/general/app_bar.dart';
import '../../components/general/search_field.dart';
import '../../components/general/toast.dart';
import '../../components/users_comp/users_list_tile.dart';
import '../../src/app_size.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

PageController pageController = PageController();

class _UsersScreenState extends State<UsersScreen> {
  TextEditingController searchCont = TextEditingController();
  final List _searchResultData = [];
  int mode = 0;
  void getMatch(requests) {
    String value = searchCont.text.toLowerCase();
    setState(() {
      mode = 1;
    });
    _searchResultData.clear();
    for (var item in requests) {
      if (item.username.toLowerCase().contains(value) &&
          !_searchResultData.contains(item)) {
        setState(() => _searchResultData.add(item));
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
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is UserError) {
          MyToast.customToast(state.msg, context);
        }
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);

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
              onRefresh: () async => cubit.fetchUsers(),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(children: [
                    SizedBox(
                      height: AppSize.height(context) * 0.01,
                    ),
                    MySearch(
                        searchCont: searchCont,
                        onChanged: () {
                          getMatch(cubit.usersModel!.users);
                        }),
                    SizedBox(
                      height: AppSize.height(context) * 0.01,
                    ),
                    cubit.usersModel != null && mode == 0
                        ? Expanded(
                            child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cubit.usersModel!.users!.length,
                            itemBuilder: (context, index) => UsersListTile(
                              id: cubit.usersModel!.users![index]!.id!,
                              username:
                                  cubit.usersModel!.users![index]!.username!,
                            ),
                          ))
                        : _searchResultData.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _searchResultData.length,
                                itemBuilder: (context, index) => UsersListTile(
                                  id: '${_searchResultData[index].id}',
                                  username: _searchResultData[index].username!,
                                ),
                              ))
                            : const Center(
                                child: Text('No User Found'),
                              )
                  ])),
            ));
      },
    );
  }
}

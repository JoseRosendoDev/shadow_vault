import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shadow_vault/data/password.dart';
import 'package:shadow_vault/views/blocs/home_password/home_bloc.dart';
import 'package:flutter/services.dart';
import 'package:shadow_vault/views/password_view/add_password.dart';
import '../../widgets/custom_icon_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    context.read<HomePasswordBloc>().add(GetPasswords());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: Colors.white,
          elevation: 0,
          title: AnimatedSwitcher(
            duration: Duration(milliseconds: 1000),
            child: _isSearching
                ? TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'SearchPassword'.tr(),
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) => setState(() {}),
                  )
                : Text(
                    'ShadowVault',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
          actions: [
            IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search,
                  color: Colors.black),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) _searchController.clear();
                });
              },
            ),
            PopupMenuButton<SortOption>(
              onSelected: (SortOption value) {
                // Trigger the filtering logic based on the selected option
                context.read<HomePasswordBloc>().add(ButtonFilter(sortBy: value));
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<SortOption>(
                    value: SortOption.creationDate,
                    child: Text('CreationDate'.tr()),
                  ),
                  PopupMenuItem<SortOption>(
                    value: SortOption.alphabetical,
                    child: Text('Alphabetical'.tr()),
                  ),
                ];
              },
              icon: Icon(Icons.filter_alt_outlined, color: Colors.black),
            ),
            IconButton(
              icon: Icon(Icons.add, color: Colors.black),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoSheetRoute<void>(
                    builder: (BuildContext context) => const SheetScaffold(),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<HomePasswordBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoaded) {
              if (state.passwords.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.lock_outline,
                            size: 80, color: Colors.grey.shade400),
                        const SizedBox(height: 20),
                        Text(
                          'NoPasswordsSaved'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'StartSavingOne'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: Text(
                            'Oklabel'.tr(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoSheetRoute<void>(
                                builder: (BuildContext context) =>
                                    const SheetScaffold(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              // We use the SearchableListView to enable searching
              List<Password> filteredPasswords = state.passwords
                  .where((password) => password.title
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase()))
                  .toList();
      
              return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: filteredPasswords.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: Icon(Icons.vpn_key, color: Colors.blueAccent),
                      title: Text(
                        filteredPasswords[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        filteredPasswords[index].description,
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          CustomIconButton(
                              icon: Icons.copy,
                              color: Colors.green,
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: filteredPasswords[index].password));
                                _showToast("PasswordCopiedMessage".tr());
                              }),
                          CustomIconButton(
                              icon: Icons.visibility,
                              color: Colors.blue,
                              onPressed: () {
                                _showPasswordDialog(
                                    context, filteredPasswords[index].password);
                              }),
                          CustomIconButton(
                              icon: Icons.delete_outline,
                              color: Colors.red,
                              onPressed: () {
                                context.read<HomePasswordBloc>().add(
                                    DeletePassword(filteredPasswords[index].id));
                              }),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is HomeFailed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      state.errorMessage,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          context.read<HomePasswordBloc>().add(GetPasswords());
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              );
            } else if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            }
      
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void _showPasswordDialog(BuildContext context, String password) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title: Text('UnlockedPassword'.tr(),
              style: TextStyle(color: Colors.white)),
          content: Text(password,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('CopyPassword'.tr(),
                  style: TextStyle(color: Colors.blueAccent)),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: password));
                Navigator.of(context).pop();
                _showToast('PasswordCopiedMessage'.tr());
              },
            ),
            TextButton(
              child: Text('CloseLabel'.tr(),
                  style: TextStyle(color: Colors.redAccent)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}

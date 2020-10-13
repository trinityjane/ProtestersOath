import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:preferences/preference_service.dart';
import 'package:protestersoath/navigation/app_drawer.dart';
import 'package:protestersoath/navigation/app_drawer/appdrawer_bloc.dart';
import 'package:protestersoath/navigation/app_drawer/appdrawer_event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:protestersoath/protests/old/protests_cubit.dart';
import 'package:protestersoath/protests/old/protests_state.dart';

import '../ProtestRSSCard.dart';

class ProtestPage extends StatefulWidget {
  @override
  _ProtestPageState createState() => _ProtestPageState();
}

class _ProtestPageState extends State<ProtestPage> {
  final drawer = PrefService.getString('drawer', ignoreCache: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return CubitBuilder<ProtestsCubit, ProtestsState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ErrorState) {
                  return Center(
                    child: Icon(Icons.close),
                  );
                } else if (state is LoadedState) {
                  return Scaffold(
                      drawer: this.drawer == 'all' ? AppDrawer() : null,
                      body: Container(
                          color: Colors.grey,
                          child: CustomScrollView(slivers: <Widget>[
                                SliverAppBar(
                                  pinned: true,
                                  // expandedHeight: appBarHeight,
                                  title: Text(
                                    "PROTESTS".tr(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  actions: [
                                    IconButton(
                                      icon: Icon(Icons.art_track, size: 40),
                                      onPressed: () =>
                                          CubitProvider.of<ProtestsCubit>(
                                              context).getNextProtest(),
                                    ),
                                  ],
                                  leading: drawer == 'all' ? null :
                                  IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      BlocProvider.of<AppDrawerBloc>(context)
                                          .add(BackButtonEvent("ProtestPage"));
                                    },
                                  ),
                                ),
                                SliverList(
                                  delegate: SliverChildListDelegate(
                                    [
                                      // ProtestCard(context, state.protest),
                                    ],
                                  ),
                                )
                              ])));
                }
                return Center(
                  child: Icon(Icons.close),
                );
              });
        });
  }
}

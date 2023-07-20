import 'package:assetmng/widget/CustomAppBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assetmng/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/service_request_bloc/service_request_bloc.dart';
import '../../shared/colors.dart';
import '../../shared/text_styles.dart';
import '../../utils/index.dart';
import '../../widget/side_menu.dart';

class HomePage extends StatefulWidget {
  // final user;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc authBloc = HomeBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: state is HomeBlocFetchedState ? state.user.role : "Error",
          ),
          drawer: const SideMenu(),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeBlocLodingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is HomeBlocErrorState) {
                return Center(
                  child: Text(state.apiErroe),
                );
              } else if (state is HomeBlocFetchedState) {
                context.read<ServiceRequestBloc>().add(ServiceRequestEventFetch(
                    state.user.role, state.user.locationcode));
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.user.id.toString(),
                        style: kSubtitleTextStyle,
                      ),
                      Text(
                        state.user.username,
                        style: kSubtitleTextStyle,
                      ),
                      Text(
                        state.user.locationname,
                        style: kSubtitleTextStyle,
                      ),
                      Text(
                        state.user.maxdevices.toString(),
                        style: kSubtitleTextStyle,
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text("Data not found"),
                );
              }
            },
          ),
        );
      },
    );
  }
}

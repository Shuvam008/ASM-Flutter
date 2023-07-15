import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc/bloc/home_bloc.dart';
import '../../utils/index.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.user.id.toString()),
                  Text(state.user.locationname),
                  Text(state.user.locationname),
                  Text(state.user.maxdevices.toString()),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: const Text("Home"),
                  )
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
  }
}

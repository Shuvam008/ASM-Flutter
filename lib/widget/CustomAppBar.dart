import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc/bloc/home_bloc.dart';
import '../shared/colors.dart';
import '../shared/text_styles.dart';
import '../utils/index.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: kBlackColor,
      ),
      backgroundColor: kWhiteColor,
      // backgroundColor: Color.fromARGB(255, 240, 240, 240),
      elevation: 0,
      title: Text(
        title.toUpperCase(),
        style: kSubtitleTextStyle,
      ),
      actions: [
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_outlined))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

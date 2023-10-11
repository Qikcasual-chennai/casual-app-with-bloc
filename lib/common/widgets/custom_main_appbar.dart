import 'package:casual_app/features/account/bloc/account_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomMainAppBar extends StatefulWidget implements PreferredSizeWidget{
  const CustomMainAppBar({super.key});

  @override
  State<CustomMainAppBar> createState() => _CustomMainAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 64);
}

class _CustomMainAppBarState extends State<CustomMainAppBar> {

  AccountBloc? accountBloc;

  String? name, city;

  @override
  void initState() {
    context.read<AccountBloc>().add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    accountBloc = BlocProvider.of<AccountBloc>(context);

    return BlocBuilder(
      bloc: accountBloc,
      builder: (context, state) {
        GetProfileState? successState;
        if(state is GetProfileState){
          successState = state;
          // print(successState.casualModel!.casual_first_name!);
          name = successState?.casualModel!.casual_first_name!;
          city = successState.casualModel.city!.city_name;
        }

        return AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 64,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16),),
            side: BorderSide(
              color: Colors.blue,
              style: BorderStyle.solid,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name == null ? "person" : name!, style: TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis,),
                  Row(
                    children: [
                      Text(city != null ? city! : "city", style: TextStyle(fontSize: 16),),
                      Gap(10),
                      Text("|", style: TextStyle(fontSize: 8),),
                      Gap(10),
                      Text("4.5", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
              const Gap(20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Your Earnings", style: TextStyle(fontSize: 14),),
                  const Gap(6),
                  Text("THB 45,000", style: GoogleFonts.robotoMono(fontSize: 12),
                    overflow: TextOverflow.ellipsis,),
                ],
              )
            ],
          ),
          actions: [
            IconButton(onPressed: () {

            }, icon: const Icon(Icons.notifications_none_outlined),
                iconSize: 32),
            IconButton(onPressed: () {

            }, icon: const Icon(Icons.search),
                iconSize: 32),
          ],
        );
      },
    );
  }
}



AppBar customMainAppBar(){
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: 64,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16),),
      side: BorderSide(
        color: Colors.blue,
        style: BorderStyle.solid,
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Venkatraj", style: TextStyle(fontSize: 16), overflow: TextOverflow.ellipsis,),
            Row(
              children: [
                Text("Bangkok", style: TextStyle(fontSize: 16),),
                Gap(10),
                Text("|", style: TextStyle(fontSize: 8),),
                Gap(10),
                Text("4.5", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
              ],
            )
          ],
        ),
        const Gap(20),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Your Earnings", style: TextStyle(fontSize: 14),),
            const Gap(6),
            Text("THB 45,000", style: GoogleFonts.robotoMono(fontSize: 12),
              overflow: TextOverflow.ellipsis,),
          ],
        )
      ],
    ),
    actions: [
      IconButton(onPressed: () {

      }, icon: const Icon(Icons.notifications_none_outlined),
      iconSize: 32),
      IconButton(onPressed: () {

      }, icon: const Icon(Icons.search),
          iconSize: 32),
    ],
  );
}
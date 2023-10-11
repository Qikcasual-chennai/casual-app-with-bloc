import 'package:casual_app/constants/app_styles.dart';
import 'package:casual_app/constants/global_variables.dart';
import 'package:casual_app/constants/utils.dart';
import 'package:casual_app/features/account/bloc/account_bloc.dart';
import 'package:casual_app/models/casual/casual_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with AutomaticKeepAliveClientMixin {
  AccountBloc? accountBloc;
  CasualModel? casualModel;

  @override
  void initState() {
      context.read<AccountBloc>().add(GetProfileEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    accountBloc = BlocProvider.of<AccountBloc>(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              profileBoxWidget(),
              earningsBoxWidget(),
              accountMenuWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileBoxWidget() {
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: accountBloc,
      builder: (context, state) {
        if (state is LoadingState) {
          return const CircularProgressIndicator();
        } else if (state is GetProfileState) {
          casualModel = state.casualModel;
          return Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 50,
                    backgroundImage: casualModel!.casual_avatar == null
                        ? Image.asset("assets/images/person.png").image
                        : NetworkImage(GlobalVariables.s3Bucket +
                        casualModel!.casual_avatar!),
                  ),
                  const Gap(24),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          casualModel!.casual_first_name != null ? casualModel!.casual_first_name! : "null",
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Gap(10),
                        Text(
                          casualModel!.casual_id!,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Gap(10),
                        Text(
                          casualModel!.role!.toUpperCase(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Gap(10),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
          // return Container(
          //   margin: const EdgeInsets.only(top: 16),
          //   child: Card(
          //
          //     child: ListTile(
          //       title: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             casualModel!.casual_first_name!,
          //             overflow: TextOverflow.ellipsis,
          //             style: const TextStyle(
          //               fontSize: 18,
          //             ),
          //           ),
          //           Text(
          //             casualModel!.role!,
          //             overflow: TextOverflow.ellipsis,
          //             style: const TextStyle(
          //               letterSpacing: 2,
          //               fontSize: 12,
          //             ),
          //           ),
          //           const Divider(
          //             height: 32,
          //           ),
          //         ],
          //       ),
          //       subtitle: Text(
          //         casualModel!.city!.city_name!,
          //         overflow: TextOverflow.ellipsis,
          //         style: const TextStyle(
          //           letterSpacing: 2,
          //           fontSize: 12,
          //         ),
          //       ),
          //       trailing:  CircleAvatar(
          //         radius: 30,
          //         backgroundImage: casualModel!.casual_avatar == null
          //             ? Image.asset(
          //             "assets/images/person.png")
          //             .image
          //             : NetworkImage(
          //             GlobalVariables.s3Bucket +
          //                 casualModel!.casual_avatar!),
          //       ),
          //       contentPadding: const EdgeInsets.only(
          //         left: 32,
          //         right: 32,
          //         top: 16,
          //         bottom: 16,
          //       ),
          //     ),
          //   ),
          // );
        }
        return const SizedBox();
      },
    );
  }

  Widget earningsBoxWidget() {
    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      // color: Colors.white,
      child: Center(
        child: Column(
          children: [
            const Text('Your Earnings'),
            Text(
              '45000',
              style: GoogleFonts.robotoMono(
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget accountMenuWidget() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.star_border),
            title: const Text('Rating'),
            trailing: Text(
              '4.5',
              style: GoogleFonts.robotoMono(),
            ),
          ),
          const Divider(
            height: 1,
          ),
          InkWell(
            child: ListTile(
              onTap: () {
                // print('tickets');
                Navigator.pushNamed(context, 'raise_tickets');
              },
              leading: const Icon(Icons.bug_report_outlined),
              title: const Text('Issues and Ticket'),
              trailing: const Text('Go to Tickets'),
            ),
          ),
          const Divider(
            height: 1,
          ),
          InkWell(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
              leading: const Icon(Icons.person),
              title: const Text('View Profile'),
              trailing: const Text('Go to Profile'),
            ),
          ),
          const Divider(
            height: 1,
          ),
          InkWell(
            child: ListTile(
              onTap: () {
                // print('show Feedback');
                Navigator.pushNamed(context, 'feedback');
              },
              leading: const Icon(Icons.feedback_outlined),
              title: const Text('Feedback'),
              trailing: const Text('Go to FeedBack'),
            ),
          ),
          const Divider(
            height: 1,
          ),
          InkWell(
            child: ListTile(
              onTap: () {
                // print('show QRCode');
                Navigator.pushNamed(context, 'qrcode_settings');
              },
              leading: const Icon(Icons.qr_code_2_outlined),
              title: const Text('QRCode'),
              trailing: const Text('Show QRCode'),
            ),
          ),
          const Divider(
            height: 1,
          ),
          InkWell(
            child: ListTile(
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              trailing: const Text('Go to Settings'),
            ),
          ),
          const Divider(
            height: 1,
          ),
          InkWell(
            child: ListTile(
              onTap: () {
                showLogoutDialog(context);
              },
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

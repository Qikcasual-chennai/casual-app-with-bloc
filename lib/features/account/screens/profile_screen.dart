import 'package:casual_app/common/widgets/custom_appbar.dart';
import 'package:casual_app/constants/global_variables.dart';
import 'package:casual_app/features/account/bloc/account_bloc.dart';
import 'package:casual_app/models/casual/casual_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AccountBloc? accountBloc;
  CasualModel casualModel = CasualModel();

  onGoBack(dynamic value) {
    context.read<AccountBloc>().add(GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    accountBloc = BlocProvider.of<AccountBloc>(context);

    return Scaffold(
      appBar:
          customAppbar(context: context, title: "Profile", homeVisible: true),
      body: BlocBuilder<AccountBloc, AccountState>(
        bloc: accountBloc,
        builder: (context, state) {
          if (state is LoadingState) {
            return const CircularProgressIndicator();
          } else if (state is GetProfileState) {
            casualModel = state.casualModel;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: Card(
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      casualModel.casual_first_name!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      casualModel.role!,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        letterSpacing: 2,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const Divider(
                                      height: 32,
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  casualModel.city!.city_name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    letterSpacing: 2,
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: CircleAvatar(
                                    maxRadius: 300,
                                    minRadius: 100,
                                    backgroundImage: casualModel.casual_avatar == null
                                            ? Image.asset(
                                                    "assets/images/person.png")
                                                .image
                                            : NetworkImage(
                                                GlobalVariables.s3Bucket +
                                                    casualModel.casual_avatar!),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.only(
                                  left: 32,
                                  right: 32,
                                  top: 16,
                                  bottom: 16,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 20,
                            child: IconButton(
                              onPressed: () { Navigator.pushNamed(context, "/edit-profile").then(onGoBack); },
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading:
                                  const Icon(Icons.currency_rupee_outlined),
                              title: const Text('Amount Earned'),
                              subtitle: Text(
                                '45,000',
                                style: GoogleFonts.robotoMono(),
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              leading: const Icon(Icons.star_border_outlined),
                              title: const Text('Ratings'),
                              subtitle: Text(
                                '4.5',
                                style: GoogleFonts.robotoMono(),
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on_outlined),
                              title: const Text('Current Location'),
                              subtitle: Text(
                                casualModel.city!.city_name!,
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              leading: const Icon(Icons.email_outlined),
                              title: const Text('Email'),
                              subtitle: Text(
                                casualModel.email!,
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              leading: const Icon(Icons.call_outlined),
                              title: const Text('Phone number'),
                              subtitle: Text(
                                casualModel.casual_phone_no!,
                                style: GoogleFonts.robotoMono(),
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            ListTile(
                              leading: const Icon(Icons.credit_card),
                              title: const Text('Thai Card Number'),
                              subtitle: Text(
                                casualModel.thaiNationalId!,
                                style: GoogleFonts.robotoMono(),
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            const ListTile(
                              leading: Icon(Icons.home_outlined),
                              title: Text('Address'),
                              subtitle: Text(
                                'no.22 perumal reddy street, egmore, chennai-600008',
                              ),
                            ),
                            const Divider(
                              height: 1,
                            ),
                            const ListTile(
                              leading: Icon(Icons.work_outline_outlined),
                              title: Text('Prefered work'),
                              subtitle: Text(
                                'waiter, cleaner, server, valet, greeter, flourist,server, valet, greeter, flourist,',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

import 'package:casual_app/features/jobs/bloc/jobs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  JobsBloc? jobsBloc;
  
  @override
  void initState() {
    context.read<JobsBloc>().add(GetAllJobsEvent());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    jobsBloc = BlocProvider.of<JobsBloc>(context);

    return Scaffold(
      // appBar: customAppbar(context: context, title: "Home", homeVisible: false),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // top jobs-------------------------
              // Padding(
              //   padding: const EdgeInsets.only(top: 16),
              //   child: Column(
              //     children: [
              //       Container(
              //         width: double.infinity,
              //         margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             const Expanded(
              //               child: Text(
              //                 'Recent Jobs',
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(fontSize: 18),
              //               ),
              //             ),
              //             TextButton(
              //               child: const Text('Load More'),
              //               onPressed: () {
              //                 print('more top jobs');
              //                 Navigator.of(context)
              //                     .pushNamed('load_more_top_jobs');
              //               },
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 250,
              //         width: double.infinity,
              //         child: ListView(
              //           scrollDirection: Axis.horizontal,
              //           clipBehavior: Clip.none,
              //           children: const [
              //             JobCard(),
              //             JobCard(),
              //             JobCard(),
              //             JobCard(),
              //             JobCard(),
              //             JobCard(),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // top group of hotels-------------------------
              // Padding(
              //   padding: const EdgeInsets.only(top: 16),
              //   child: Column(
              //     children: [
              //       Container(
              //         width: double.infinity,
              //         margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             const Expanded(
              //               child: Text(
              //                 'Top Group of Hotels',
              //                 overflow: TextOverflow.ellipsis,
              //                 style: TextStyle(fontSize: 18),
              //               ),
              //             ),
              //             TextButton(
              //               child: const Text('Load More'),
              //               onPressed: () {
              //                 print('more Top Group of Hotels');
              //                 Navigator.of(context).pushNamed(
              //                     'load_more_top_Group_of_Hotels');
              //               },
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(
              //         height: 120,
              //         width: double.infinity,
              //         child: ListView(
              //           scrollDirection: Axis.horizontal,
              //           clipBehavior: Clip.none,
              //           children: const [
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //             GroupofHotelCard(),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // suggested jobs-------------------------
              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Suggested Jobs',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          TextButton(
                            child: const Text('Load More'),
                            onPressed: () {
                              print('more Suggested Jobs');
                              Navigator.of(context)
                                  .pushNamed('load_more_suggest_jobs');
                            },
                          ),
                        ],
                      ),
                    ),
                    Card(
                      clipBehavior: Clip.hardEdge,
                      margin: const EdgeInsets.all(0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          jobTile(),
                          jobTile(),
                          jobTile(),
                          jobTile(),
                          jobTile(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // footer-------------------------
              // const SizedBox(
              //   height: 300,
              //   child: Placeholder(
              //     child: Center(
              //       child: Text('Footer'),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}


// =================================================================================================================================
// job tile
class jobTile extends StatelessWidget {
  const jobTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('display_single_job_details');
          },
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.only(
          //     topLeft: Radius.circular(16),
          //     topRight: Radius.circular(16),
          //     bottomRight: Radius.circular(16),
          //     bottomLeft: Radius.circular(16),
          //   ),
          // ),
          title: Row(
            children: [
              Icon(
                Icons.work_outline_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Valet',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Marriott',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Sukumuvit',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Per Hour / Day',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                '500 B',
                style: GoogleFonts.robotoMono(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          tileColor: Colors.blueAccent,
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}

// job card
class JobCard extends StatelessWidget {
  const JobCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Card(
        // margin: const EdgeInsets.all(8),
        // elevation: 2,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(24),
        // ),
        child: InkWell(
          onTap: () {
            print('job tapped');
            Navigator.of(context).pushNamed('display_single_job_details');
          },
          splashColor: Colors.deepPurpleAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(

                // child: Image.asset("assets/images/banner.jpg", fit: BoxFit.cover,)
                child: Image.network(
                  'https://picsum.photos/800/800',
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.only(
                //       topLeft: Radius.circular(0),
                //       topRight: Radius.circular(0),
                //       bottomRight: Radius.circular(24),
                //       bottomLeft: Radius.circular(24),
                //     ),
                //     ),
                // leading: Icon(
                //   Icons.qr_code_2_rounded,
                //   color: Colors.white,
                // ),
                title: Row(
                  children: [
                    Icon(
                      Icons.work_outline_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Valet',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Marriott',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Valet',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Per Hour / Day',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '500 B',
                      style: GoogleFonts.robotoMono(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                tileColor: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// GHC icon card
class GroupofHotelCard extends StatelessWidget {
  const GroupofHotelCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Group of Hotel Card tapped');
        Navigator.of(context).pushNamed('load_more_top_properties');
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Card(
              child: Image.network(
                'https://picsum.photos/100/100',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Marriott',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

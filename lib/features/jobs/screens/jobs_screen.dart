import 'package:casual_app/common/widgets/loader.dart';
import 'package:casual_app/features/jobs/bloc/job_applied/job_applied_cubit.dart';
import 'package:casual_app/models/casualJob/applicant_job_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  JobAppliedCubit? jobAppliedCubit;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    context.read<JobAppliedCubit>().getAllAppliedJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Card(
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        // icon: Icon(Icons.cloud_outlined),
                        child: Text('Applied Jobs'),
                      ),
                      Tab(
                        // icon: Icon(Icons.brightness_5_sharp),
                        child: Text('Accepted Jobs'),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(top: 0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 280,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        BlocBuilder(
                          bloc: jobAppliedCubit,
                          builder: (context, state) {
                            if(state is JobAppliedLoading){
                              return const Loader();
                            }else if(state is GetAllAppliedJobsState){
                              return ListView.separated(
                                itemCount: state.appliedJobs.length,
                                separatorBuilder: (context, index) => const Gap(6),
                                itemBuilder: (context, index) {
                                  ApplicantJobModel applicantJobModel = state.appliedJobs[index];
                                  return JobTile(applicantJobModel: applicantJobModel,);
                                },
                              );
                            }else if(state is AppliedJobsIsEmpty){
                              return Center(child: Text(state.msg),);
                            }
                            return const SizedBox();
                          },
                        ),
                        ListView(
                          children: const [
                            JobTileAccepted(),
                            JobTileAccepted(),
                            JobTileAccepted(),
                            JobTileAccepted(),
                            JobTileAccepted(),
                            JobTileAccepted(),
                            JobTileAccepted(),
                            JobTileAccepted(),
                            JobTileAccepted(),
                            JobTileAccepted(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class JobTile extends StatelessWidget {

  final ApplicantJobModel applicantJobModel;

  const JobTile({
    super.key, required this.applicantJobModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/job-details', arguments: applicantJobModel.casual_job);
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
              const Icon(
                Icons.work_outline_outlined,
                color: Colors.white,
                size: 20,
              ),
              const Gap(7),
              Text(
                applicantJobModel.casual_job!.job_title!,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.white,
                  size: 20,
                ),
                const Gap(7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      applicantJobModel.casual_job!.client!.client_name!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    ),
                    Text(
                      applicantJobModel.casual_job!.city!.city_name!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(text: TextSpan(
                  text: applicantJobModel.casual_job!.amount.toString(), style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                  children: [
                    TextSpan(
                        text: " THB/${applicantJobModel.casual_job!.payment_type == "per_day" ? "Day" : "Hour" }",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)
                    )
                  ]
              )),
              Text(
                applicantJobModel.casual_job!.start_date!,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          tileColor: Colors.blueAccent,
        ),
        const Divider(
          height: 1,
        )
      ],
    );
  }
}

class JobTileAccepted extends StatelessWidget {
  const JobTileAccepted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('qrcode_for_applied_job');
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


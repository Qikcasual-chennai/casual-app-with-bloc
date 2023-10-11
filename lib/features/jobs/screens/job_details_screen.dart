import 'package:casual_app/common/widgets/custom_appbar.dart';
import 'package:casual_app/common/widgets/loader.dart';
import 'package:casual_app/constants/utils.dart';
import 'package:casual_app/features/jobs/bloc/check_job_applied/check_job_applied_cubit.dart';
import 'package:casual_app/features/jobs/bloc/job_apply/job_apply_cubit.dart';
import 'package:casual_app/models/casualJob/casual_job_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetailsScreen extends StatefulWidget {

  final CasualJobModel? casualJobModel;

  const JobDetailsScreen({super.key, required this.casualJobModel});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {

  JobApplyCubit jobApplyCubit = JobApplyCubit();
  CheckJobAppliedCubit checkJobAppliedCubit = CheckJobAppliedCubit();

  @override
  void initState() {
    context.read<CheckJobAppliedCubit>().checkJobAppliedOrNotEvent(jobId: widget.casualJobModel!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    jobApplyCubit = BlocProvider.of<JobApplyCubit>(context);
    checkJobAppliedCubit = BlocProvider.of<CheckJobAppliedCubit>(context);

    return Scaffold(
      appBar: customAppbar(context: context, title: widget.casualJobModel!.job_title!, homeVisible: true),
      body: MultiBlocListener(
        listeners: [
          BlocListener<JobApplyCubit, JobApplyState>(
            bloc: jobApplyCubit,
            listener: (context, state) {
              if(state is JobAppliedSuccessState){
                showFlushBar(context, state.msg, Colors.green);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(days: 1),
                    showCloseIcon: true,
                    elevation: 3,
                    backgroundColor: Colors.green,
                    closeIconColor: Colors.white,
                    content: const Text(
                        'APPLIED waiting for manager conformation!'),
                    action: SnackBarAction(
                      label: 'OK',
                      onPressed: (){
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 4,
                  children: [
                    ActionChip(
                      avatar: const Icon(Icons.people_alt_outlined),
                      label: Text('Vacancies Remaining : ${widget.casualJobModel!.no_of_casuals!}'),
                      onPressed: () {},
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.house_outlined),
                      label: Text('Venue : ${widget.casualJobModel!.property!.address!}'),
                      onPressed: () {},
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.calendar_month_outlined),
                      label: Text('From : ${widget.casualJobModel!.start_date}'),
                      onPressed: () {},
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.access_time),
                      label: Text(
                        'timings : ${widget.casualJobModel!.shift_time_start} - ${widget.casualJobModel!.shift_time_end}',
                        style: GoogleFonts.robotoMono(),
                      ),
                      onPressed: () {},
                    ),
                    ActionChip(
                      avatar: const Icon(Icons.currency_rupee_sharp),
                      label: Text(
                        'Pay : ${widget.casualJobModel!.amount} THB / ${widget.casualJobModel!.payment_type == "per_day"? "Day":"Hour"}',
                        style: GoogleFonts.robotoMono(),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Gap(14),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  onTap: () {
                    // print('Call Manager');
                  },
                  leading: const Icon(Icons.supervisor_account),
                  title: const Text('Reporting Manager'),
                  subtitle: Text(
                    widget.casualJobModel!.reporting_person!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  // trailing: const Icon(Icons.phone_enabled_outlined),
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  onTap: () {
                    // print('Venue');
                  },
                  leading: const Icon(Icons.business_outlined),
                  title: const Text('Venue'),
                  subtitle: Text(
                    widget.casualJobModel!.outlet_name!,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Gap(8),
                ExpansionTile(
                  tilePadding: const EdgeInsets.all(5),
                  childrenPadding: const EdgeInsets.only(bottom: 10),
                  leading: const Icon(Icons.info_outline),
                  title: Text('About the Job', style: Theme.of(context).textTheme.titleMedium,),
                  children: [
                    Text(
                        widget.casualJobModel!.job_description!),
                  ],
                ),
                const Gap(14),
                const Text(
                  'Things to Bring',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18),
                ),
                const Gap(8),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 4,
                  children: thingsToBring(widget.casualJobModel!.things_to_bring!),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: BlocBuilder<CheckJobAppliedCubit, CheckJobAppliedState>(
        builder: (context, state) {
          if(state is CheckJobAppliedLoading){
            return const Loader();
          }else if(state is CheckJobAppliedOrNotState){
            return FloatingActionButton.extended(
              icon: Icon(state.isApplied ? Icons.check_circle : Icons.send_outlined),
              backgroundColor: state.isApplied ? Colors.green : Colors.blueGrey,
              foregroundColor: Colors.white,
              label: Text(state.isApplied ? 'Applied!' : 'Apply Job'),
              onPressed: () async {
                // print('Applied Job');
                if(!state.isApplied){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        elevation: 4,
                        icon: const Icon(Icons.info_outline),
                        title: const Text('Job Request Sent'),
                        content: Text(
                            'Your Request for ${widget.casualJobModel!.job_title} has been Froward to manager of ${widget.casualJobModel!.property!.property_name} \n\nplease wait for an approval from the manager'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // jobApplyCubit.add(ApplyJobEvent(JobId: 22));
                              context.read<JobApplyCubit>().emitApplyJob(jobId: widget.casualJobModel!.id!);
                              context.read<CheckJobAppliedCubit>().emit(CheckJobAppliedOrNotState(isApplied: true));
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text(
                              'OK',
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  List<Widget> thingsToBring(String things){
    List<Widget> tags = [];
    var results = things.replaceAll('"', "").split(",").map((e) => e.trim()).toList();
    for (var tag in results) {
      tags.add(ActionChip(
        avatar: const Icon(Icons.widgets),
        label: Text(tag),
        onPressed: () {},
      )); 
    }
    return tags;
  }


}

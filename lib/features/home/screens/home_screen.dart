import 'package:casual_app/common/widgets/loader.dart';
import 'package:casual_app/constants/global_variables.dart';
import 'package:casual_app/features/client/bloc/client_bloc.dart';
import 'package:casual_app/features/jobs/bloc/jobs_bloc.dart';
import 'package:casual_app/models/casualJob/casual_job_model.dart';
import 'package:casual_app/models/client/client_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  double availableScreenWidth = 0;
  double availableScreenHeight = 0;
  JobsBloc? jobsBloc;
  ClientBloc? clientBloc;
  
  @override
  void initState() {
    context.read<JobsBloc>().add(GetAllJobsEvent());
    context.read<ClientBloc>().add(GetAllClientsEvent());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    availableScreenWidth = MediaQuery.of(context).size.width - 50;
    availableScreenHeight = MediaQuery.of(context).size.height;
    jobsBloc = BlocProvider.of<JobsBloc>(context);
    clientBloc = BlocProvider.of<ClientBloc>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          // color: Colors.green,
          child: Column(
            children: [
              recentJobListContainer(),
              const Gap(18),
              getClients(),
              const Gap(18),
              jobListContainer(),
              const Gap(18),
            ],
          ),
        ),
      ),
    );
  }

  // ================Recent Top Jobs=====================

  Widget recentJobListContainer(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Jobs".toUpperCase(), style: Theme.of(context).textTheme.titleMedium,),
            Text("Load More".toUpperCase(), style: Theme.of(context).textTheme.titleSmall,)
          ],
        ),
        const Gap(18),
        buildRecentJobsLists(),
      ],
    );
  }

  Widget buildRecentJobsLists(){
    return BlocBuilder<JobsBloc, JobsState>(
      bloc: jobsBloc,
      builder: (context, state) {
        if(state is JobsLoadingState){
          return const Loader();
        }
        if(state is GetAllJobsState){
          return SizedBox(
            height: availableScreenHeight * .35,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.casualJobs.length,
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: (context, index) {
                CasualJobModel casualJobModel = state.casualJobs[index];
                return recentJobCard(casualJobModel);
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
  
  Widget recentJobCard(CasualJobModel casualJobModel){
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
            Navigator.of(context).pushNamed('/job-details', arguments: casualJobModel);
          },
          splashColor: Colors.deepPurpleAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                // child: Image.asset("assets/images/banner.jpg", fit: BoxFit.cover,)
                child: Image.network(
                  casualJobModel.property!.property_avatar != null ?
                  GlobalVariables.s3Bucket + casualJobModel.client!.client_avatar! :
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
                    const Icon(
                      Icons.work_outline_outlined,
                      color: Colors.white,
                    ),
                    const Gap(14),
                    Flexible(
                      child: Text(
                        casualJobModel.job_title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: true,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                    const Gap(14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          casualJobModel.property!.property_name!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                        ),
                        Text(
                          casualJobModel.city!.city_name!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(text: TextSpan(
                        text: casualJobModel.amount.toString(), style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                        children: [
                          TextSpan(
                              text: " THB/${casualJobModel.payment_type == "per_day" ? "Day" : "Hour" }",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)
                          )
                        ]
                    )),
                    Text(
                      casualJobModel.start_date!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(
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

  // ========suggest Jobs=============

  Widget jobListContainer(){
    return Column(
      children: [
        Row(
          children: [
            Text("Suggest Jobs".toUpperCase(), style: Theme.of(context).textTheme.titleMedium,)
          ],
        ),
        const Gap(18),
        buildCasualJobList()

      ],
    );
  }

  Widget buildCasualJobList(){
    return BlocBuilder<JobsBloc, JobsState>(
      bloc: jobsBloc,
      builder: (context, state) {
        if(state is JobsLoadingState){
          return const Loader();
        }
        if(state is GetAllJobsState){
          return Material(
            child: SizedBox(
              height: availableScreenHeight * .4,
              width: double.infinity,
              child: ListView.separated(
                cacheExtent: 300,
                // clipBehavior: Clip.hardEdge,
                itemBuilder: (context, index) {
                  CasualJobModel casualJobModel = state.casualJobs[index];
                  return casualJobCard(casualJobModel);
                }, separatorBuilder: (context, index) => const Gap(5), itemCount: state.casualJobs.length,
              ),
            ),
          );
        }
        return const SizedBox();
      },
    ) ;
  }

  Widget casualJobCard(CasualJobModel casualJobModel){
    // print(casualJobModel);
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed('/job-details', arguments: casualJobModel);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.work_outline_outlined,
            color: Colors.white,
            size: 20,
          ),
          const Gap(10),
          Text(
            casualJobModel.job_title!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 20,
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  casualJobModel.client!.client_name!,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                ),
                Text(
                  casualJobModel.city!.city_name!,
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
            text: casualJobModel.amount.toString(), style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
            children: [
              TextSpan(
                text: " THB/${casualJobModel.payment_type == "per_day" ? "Day" : "Hour" }",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white)
              )
            ]
          )),
          Text(
            casualJobModel.start_date!,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      tileColor: Colors.blueAccent,
    );
  }

  //=============Clients================

  Widget getClients(){
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    'Top Group of Hotels',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextButton(
                  child: const Text('Load More'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        'load_more_top_Group_of_Hotels');
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<ClientBloc, ClientState>(
            bloc: clientBloc,
            builder: (context, state) {
              if(state is ClientLoadingState){
                return const Loader();
              }else if(state is GetAllClientsState){
                return SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.clients.length,
                    separatorBuilder: (context, index) => const Gap(5),
                    itemBuilder: (context, index) {
                      ClientModel clientModel = state.clients[index];
                      return groupOfHotelCard(clientModel);
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget groupOfHotelCard(ClientModel clientModel){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: Card(
            child:clientModel.client_avatar != null ? Image.network(
              GlobalVariables.s3Bucket + clientModel.client_avatar!,
              fit: BoxFit.cover,
            ) : Image.asset("assets/images/person.png"),
          ),
        ),
        Expanded(
          child: Text( clientModel.client_name!,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

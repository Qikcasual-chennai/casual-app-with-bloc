import 'package:flutter/material.dart';

import '../../constants/app_styles.dart';

class HeadTitle extends StatefulWidget {
  const HeadTitle({super.key});

  @override
  State<HeadTitle> createState() => _HeadTitleState();
}

class _HeadTitleState extends State<HeadTitle> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "Qikcasual",
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Text(
            "Casual",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text("Manager", style: Styles.headLineStyle4,)
          //   ],
          // ),
        ],
      ),
    );
  }
}

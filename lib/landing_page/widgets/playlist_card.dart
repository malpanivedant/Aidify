import 'package:flutter/material.dart';
import 'package:help_on_needs/custom_widgets/card.dart';
import 'package:help_on_needs/landing_page/models/landing_page_model.dart';

class PlayListCard extends StatefulWidget {
  final List<DisasterList> disasterList;
  const PlayListCard({
    Key? key,
    required this.disasterList,
  }) : super(key: key);

  @override
  State<PlayListCard> createState() => _PlayListCardState();
}

class _PlayListCardState extends State<PlayListCard> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: getPlaylist(),
    );
  }

  Widget getPlaylist() {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: widget.disasterList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: CardDisplay(
            disasterDetail: widget.disasterList[index],
          ),
        );
      },
    );
  }
}

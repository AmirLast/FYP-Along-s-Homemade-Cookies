import 'package:flutter/material.dart';

class MySortBy extends StatefulWidget {
  final double width;
  final List<String> options;
  final List<void Function()?> functions;
  final bool enable;
  const MySortBy({
    super.key,
    required this.width,
    required this.options,
    required this.functions,
    required this.enable,
  });

  @override
  State<MySortBy> createState() => _MySortByState();
}

class _MySortByState extends State<MySortBy> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Theme(
        data: Theme.of(context).copyWith(
          listTileTheme: ListTileTheme.of(context).copyWith(
            dense: true,
            visualDensity: VisualDensity.compact,
            horizontalTitleGap: 0,
            minTileHeight: 0,
            minLeadingWidth: 0,
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              widget.enable ? isExpand = value : isExpand = false;
            });
          },
          trailing: Icon(
            isExpand ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_right_rounded,
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          collapsedBackgroundColor: Colors.grey.shade400,
          backgroundColor: Colors.grey.shade400,
          title: const Center(
              child: Padding(
            padding: EdgeInsets.all(5),
            child: Text("Sort By", style: TextStyle(color: Colors.black)),
          )),
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
          children: [
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: widget.options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 2),
                    padding: const EdgeInsets.all(5),
                    width: widget.width,
                    child: Center(child: Text(widget.options[index])),
                  ),
                  onTap: widget.functions[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

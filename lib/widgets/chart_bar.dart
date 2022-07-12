import 'package:flutter/material.dart';

class ChartBar extends StatefulWidget {
  final String label;
  final double spending;
  final double spendingPercent;

  const ChartBar(
      {Key? key,
      required this.label,
      required this.spending,
      required this.spendingPercent})
      : super(key: key);

  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: FittedBox(
            child: Text('\$ ${widget.spending.toStringAsFixed(0)}'),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          height: 60.0,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                color: const Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              heightFactor: widget.spendingPercent,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(widget.label),
      ],
    );
  }
}

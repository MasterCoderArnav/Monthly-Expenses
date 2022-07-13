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
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text('\$ ${widget.spending.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.08,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
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
            SizedBox(
              height: constraints.maxHeight * 0.08,
            ),
            Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                child: Text(widget.label),
              ),
            ),
          ],
        );
      },
    );
  }
}

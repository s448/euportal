import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:eup/View/Widgets/product_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final Item item = Get.arguments['item'];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(color: ColorManager.greyC),
            columnWidths: const <int, TableColumnWidth>{
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                children: [
                  const RowTitle(t: "Title"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${item.title}"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const RowTitle(t: "Location"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Latitude : ${item.location?.lat} & Longitude : ${item.location?.long}",
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const RowTitle(t: "Working hours"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${item.workingHours}"),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const RowTitle(t: "Products"),
                  ListView(
                    shrinkWrap: true,
                    children:
                        List.generate(item.products?.length ?? 0, (index) {
                      var product = item.products?[index];
                      return ProductGridTile(product: product);
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowTitle extends StatelessWidget {
  const RowTitle({
    super.key,
    required this.t,
  });
  final String t;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        t,
        style: StyleManager.greenHeadline,
      ),
    );
  }
}

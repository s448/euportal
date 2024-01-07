import 'package:dashboard/Controller/add_remove_items.dart';
import 'package:dashboard/View/Screen/side_bar.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_model.dart';
import 'package:eup/View/Widgets/product_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  ItemDetails({super.key});
  final controller = Get.put(ItemsController());
  @override
  Widget build(BuildContext context) {
    final Item item = Get.arguments['item'];
    final isRestaurantOrCoffeShop =
        item.category?.id == "1" || item.category?.id == "4";

    final isMosque = item.category?.id == "2";
    final isDr = item.category?.id == "3";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details",
          style: StyleManager.greenHeadline,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const RowTitle(t: "Logo: "),
                      Image.network(
                        item.logo ?? "",
                        width: 80,
                        height: 100,
                      )
                    ],
                  ),
                  isRestaurantOrCoffeShop
                      ? Row(
                          children: [
                            const RowTitle(t: "Portrait: "),
                            SizedBox(
                                width: 150,
                                height: 200,
                                child: Image.network(
                                  item.portrait ?? "",
                                  width: 80,
                                  height: 100,
                                ))
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Table(
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
                        child: Text(
                          "${item.title}",
                          style: StyleManager.headline,
                        ),
                      ),
                    ],
                  ),
                  if (!isRestaurantOrCoffeShop)
                    TableRow(
                      children: [
                        const RowTitle(t: "Descripion"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${item.description}",
                            style: StyleManager.headline,
                          ),
                        ),
                      ],
                    ),
                  TableRow(
                    children: [
                      const RowTitle(t: "Location"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'Latitude : ',
                                style: StyleManager.greenHeadline,
                              ),
                              TextSpan(
                                text: item.location?.lat,
                                style: StyleManager.headline,
                              ),
                              const TextSpan(
                                text: '   Longitude : ',
                                style: StyleManager.greenHeadline,
                              ),
                              TextSpan(
                                text: item.location?.long,
                                style: StyleManager.headline,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const RowTitle(t: "Addess"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'Country : ',
                                style: StyleManager.greenHeadline,
                              ),
                              TextSpan(
                                text: item.region?.country,
                                style: StyleManager.headline,
                              ),
                              const TextSpan(
                                text: '   City : ',
                                style: StyleManager.greenHeadline,
                              ),
                              TextSpan(
                                text: item.region?.city,
                                style: StyleManager.headline,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isMosque)
                    TableRow(
                      children: [
                        const RowTitle(t: "Mosque capacity"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${item.mosqueCapacity}"),
                        ),
                      ],
                    ),
                  if (isRestaurantOrCoffeShop)
                    TableRow(
                      children: [
                        const RowTitle(t: "Working hours"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${item.workingHours}"),
                        ),
                      ],
                    ),
                  if (isRestaurantOrCoffeShop)
                    TableRow(
                      children: [
                        const RowTitle(t: "Products"),
                        SizedBox(
                          width: Get.width * 0.7,
                          height: 70,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: List.generate(item.products?.length ?? 0,
                                (index) {
                              var product = item.products?[index];
                              return ProductGridTile(product: product);
                            }),
                          ),
                        ),
                      ],
                    ),
                  if (!isMosque)
                    TableRow(
                      children: [
                        const RowTitle(t: "Phone"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.phone ?? ""),
                        ),
                      ],
                    ),
                  if (isDr)
                    TableRow(
                      children: [
                        const RowTitle(t: "Instagram"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.insta ?? ""),
                        ),
                      ],
                    ),
                  if (isDr)
                    TableRow(
                      children: [
                        const RowTitle(t: "Facebook"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(item.fb ?? ""),
                        ),
                      ],
                    ),
                  if (isRestaurantOrCoffeShop)
                    TableRow(
                      children: [
                        const RowTitle(t: "Delivery"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Switch(
                                value: item.delivery ?? false,
                                onChanged: null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (isRestaurantOrCoffeShop)
                    TableRow(
                      children: [
                        const RowTitle(t: "Featured logo"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Checkbox(
                                activeColor: ColorManager.primaryC,
                                value: item.featuredLogo,
                                onChanged: null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  TableRow(
                    children: [
                      const RowTitle(t: "Featured portrait"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Checkbox(
                              activeColor: ColorManager.primaryC,
                              value: item.featuredPortrait,
                              onChanged: null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (isMosque)
                    TableRow(
                      children: [
                        const RowTitle(t: "مصلى للنساء متوفر"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Checkbox(
                                activeColor: ColorManager.primaryC,
                                value: item.womenPrayerRoom,
                                onChanged: null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (isMosque)
                    TableRow(
                      children: [
                        const RowTitle(t: "مرافق الوضوء متوفرة"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Checkbox(
                                activeColor: ColorManager.primaryC,
                                value: item.mosqueAblutionFacilities,
                                onChanged: null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (isMosque)
                    TableRow(
                      children: [
                        const RowTitle(t: "درس بعد صلاة العشاء"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Checkbox(
                                activeColor: ColorManager.primaryC,
                                value: item.lessonAfterEshaa,
                                onChanged: null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (isMosque)
                    TableRow(
                      children: [
                        const RowTitle(t: "كل الصلاوات وصلاة الجمعة"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Checkbox(
                                activeColor: ColorManager.primaryC,
                                value: item.allPrayers,
                                onChanged: null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Expanded(
            //   child: InkWell(
            //     onTap: () => Get.to(
            //       AddItem(itemType: item,),
            //     ),
            //     child: Container(
            //         padding: const EdgeInsets.all(20),
            //         decoration: BoxDecoration(
            //           color: ColorManager.primaryC,
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child: const Text(
            //           "Edit",
            //           textAlign: TextAlign.center,
            //           style: StyleManager.authButtonTextStyle,
            //         )),
            //   ),
            // ),
            // const SizedBox(width: 25),
            Expanded(
              child: InkWell(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.transparent,
                        content: AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: AlertDialog(
                              title: const Text("Confirm delete this item ?"),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await controller.deleteItem(item.id ?? "");
                                    Get.offAll(const SideBarPage());
                                    Get.snackbar("Delete Success", '');
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Delete",
                      textAlign: TextAlign.center,
                      style: StyleManager.authButtonTextStyle,
                    )),
              ),
            ),
          ],
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

// ignore_for_file: invalid_use_of_protected_member
import 'dart:typed_data';

import 'package:dashboard/Controller/add_remove_items.dart';
import 'package:eup/BusinessLogic/Controller/home_page_controller.dart';
import 'package:eup/Core/Constant/image_path.dart';
import 'package:eup/Core/Theme/colors.dart';
import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/region_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_region_model.dart';
import 'package:eup/Model/search_item_complex_datatypes/item_type_model.dart';
import 'package:eup/View/Widgets/product_grid_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key, required this.itemType});
  final Category itemType;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  void initState() {
    super.initState();
    controller.item.value.category = widget.itemType;
  }

  final controller = Get.put(ItemsController());
  final homeCtrl = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = (Get.width / 100).floor();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "اضافة ${widget.itemType.title}",
          style: StyleManager.greenHeadline,
        ),
      ),
      body: GetBuilder<ItemsController>(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            var pickLogo = InkWell(
              onTap: () => controller.pickLogo(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: controller.logo.value.isNotEmpty
                    ? Column(
                        children: [
                          Image.memory(
                            controller.logo.value,
                            width: 60,
                            height: 60,
                          ),
                          IconButton(
                              onPressed: () =>
                                  controller.logo.value = Uint8List(0),
                              icon: const Icon(
                                CupertinoIcons.delete,
                                color: Colors.red,
                              ))
                        ],
                      )
                    : const Column(
                        children: [
                          Icon(Icons.image),
                          Text(
                            "Pick logo",
                            style: StyleManager.greenHeadline,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
              ),
            );
            var productsAddRemove = Obx(() {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1 / 1,
                  ),
                  itemCount: controller.products!.value.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                content: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    width: Get.width * 0.6,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: AlertDialog(
                                      title: const Text("Add product"),
                                      content: Column(
                                        children: [
                                          InkWell(
                                            onTap: () => controller
                                                .pickNewProductImage(),
                                            child: Obx(() {
                                              return Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: controller.productImage
                                                          .value.isEmpty
                                                      ? const Column(
                                                          children: [
                                                            Icon(Icons.image),
                                                            Text(
                                                              "Pick product image",
                                                              style: StyleManager
                                                                  .greenHeadline,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        )
                                                      : Stack(
                                                          children: [
                                                            Image.memory(
                                                              controller
                                                                  .productImage
                                                                  .value,
                                                              width: Get.width *
                                                                  0.25,
                                                              height:
                                                                  Get.height *
                                                                      0.3,
                                                            ),
                                                            Positioned(
                                                              child: IconButton(
                                                                onPressed: () =>
                                                                    controller
                                                                            .productImage
                                                                            .value =
                                                                        Uint8List(
                                                                            0),
                                                                icon: const Icon(
                                                                    CupertinoIcons
                                                                        .delete),
                                                                color:
                                                                    Colors.red,
                                                                iconSize: 50,
                                                              ),
                                                            )
                                                          ],
                                                        ));
                                            }),
                                          ),
                                          const SizedBox(height: 10),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                filled: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 4,
                                                ),
                                                hintText: "Product title",
                                              ),
                                              onChanged: (v) => controller
                                                  .productTitle.value = v,
                                              initialValue:
                                                  controller.productTitle.value,
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              controller.addProduct(),
                                          child: const Text(
                                            "Save",
                                            style: TextStyle(
                                              color: ColorManager.primaryC,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.primaryC,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                        ),
                      );
                    } else {
                      var product = controller.products?.value[index - 1];
                      return ProductGridTile(product: product);
                    }
                  },
                ),
              );
            });
            return SingleChildScrollView(
              child: Column(
                children: [
                  ///pick logo and portrait
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (controller.isRestaurantOrCoffeeShop()) pickLogo,
                      SizedBox(
                        // height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () => controller.pickPortrait(),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: controller.portrait.value.isNotEmpty
                                    ? Column(
                                        children: [
                                          Image.memory(
                                            controller.portrait.value,
                                            width: 60,
                                            height: 100,
                                          ),
                                          IconButton(
                                              onPressed: () => controller
                                                  .portrait
                                                  .value = Uint8List(0),
                                              icon: const Icon(
                                                CupertinoIcons.delete,
                                                color: Colors.red,
                                              ))
                                        ],
                                      )
                                    : const Column(
                                        children: [
                                          Icon(Icons.image),
                                          Text(
                                            "Pick portrait",
                                            style: StyleManager.greenHeadline,
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  ///select country and city

                  Container(
                    decoration: StyleManager.dropDownButtonDecoration,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 48.0,
                              width: Get.width * 0.45,
                              child: Obx(() => DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: ColorManager.greyC,
                                      ),
                                      value: homeCtrl.getCountry().value.isEmpty
                                          ? null
                                          : homeCtrl.getCountry().value,
                                      onChanged: (String? newValue) {
                                        homeCtrl.clearCity();
                                        homeCtrl.setCountry(newValue);
                                      },
                                      style: StyleManager.bodyStyle,
                                      items: homeCtrl.regions.value
                                          .map((Region region) {
                                        return DropdownMenuItem<String>(
                                          value: region.country.toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child:
                                                Text(region.country.toString()),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Row(
                                        children: [
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: SvgPicture.asset(scope,
                                                color: ColorManager.primaryC),
                                          ),
                                          const SizedBox(width: 3),
                                          const Text(
                                            'الدولة',
                                            style: StyleManager.hintStyle,
                                          ),
                                        ],
                                      ),
                                      isExpanded: true,
                                    ),
                                  )),
                            ),
                            const VerticalDivider(
                              color: ColorManager.greyC,
                              thickness: 0.3,
                            ),
                            SizedBox(
                              height: 48,
                              width: Get.width * 0.45,
                              child: Obx(() => DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: ColorManager.greyC,
                                      ),
                                      value: homeCtrl.getCity().value.isEmpty
                                          ? null
                                          : homeCtrl.getCity().value,
                                      onChanged: (String? newValue) {
                                        homeCtrl.setCity(newValue);
                                        print(homeCtrl.getCity().value);
                                        controller.item.value.region =
                                            ItemRegion(
                                          city: homeCtrl.getCity().value,
                                          country: homeCtrl.getCountry().value,
                                        );
                                        print(
                                            controller.item.value.region?.city);
                                      },
                                      style: StyleManager.bodyStyle,
                                      items: homeCtrl
                                          .selectedRegion.value.cities
                                          ?.map((String? city) {
                                        return DropdownMenuItem<String>(
                                          value: city,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text(city.toString()),
                                          ),
                                        );
                                      }).toList(),
                                      hint: Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: SvgPicture.asset(filter,
                                                color: ColorManager.primaryC),
                                          ),
                                          const SizedBox(width: 3),
                                          const Text(
                                            'المدينة',
                                            style: StyleManager.hintStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  ///title
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        hintText: "Title",
                      ),
                      onChanged: (v) => controller.item.value.title = v,
                      initialValue: controller.item.value.title,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ///description
                  if (!controller.isRestaurantOrCoffeeShop())
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          hintText: "Description",
                        ),
                        onChanged: (v) => controller.item.value.description = v,
                        maxLines: 4,
                        initialValue: controller.item.value.description,
                      ),
                    ),
                  const SizedBox(height: 12),

                  ///working hours
                  if (!controller.isMosque())
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          hintText: "Working hours",
                        ),
                        onChanged: (v) =>
                            controller.item.value.workingHours = v,
                        initialValue: controller.item.value.workingHours,
                      ),
                    ),
                  const SizedBox(height: 12),

                  ///phone
                  if (!controller.isMosque())
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          hintText: "Phone",
                        ),
                        onChanged: (v) => controller.item.value.phone = v,
                        initialValue: controller.item.value.phone,
                      ),
                    ),
                  const SizedBox(height: 12),

                  ///fb
                  if (controller.isDr())
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          hintText: "Facebook",
                        ),
                        onChanged: (v) => controller.item.value.fb = v,
                        initialValue: controller.item.value.fb,
                      ),
                    ),
                  const SizedBox(height: 12),

                  ///insta
                  if (controller.isDr())
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          hintText: "Instagram",
                        ),
                        onChanged: (v) => controller.item.value.insta = v,
                        initialValue: controller.item.value.insta,
                      ),
                    ),
                  const SizedBox(height: 25),

                  ///set delivery
                  if (controller.isRestaurantOrCoffeeShop())
                    Row(
                      children: [
                        Checkbox(
                          value: controller.item.value.delivery ?? false,
                          onChanged: (v) {
                            setState(() {
                              controller.item.value.delivery = v;
                            });
                          },
                        ),
                        const Text(
                          "Delivery availible",
                          style: StyleManager.headline,
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),

                  ///wodoaa
                  if (controller.isMosque())
                    Row(
                      children: [
                        Checkbox(
                          value:
                              controller.item.value.mosqueAblutionFacilities ??
                                  false,
                          onChanged: (v) {
                            setState(() {
                              controller.item.value.mosqueAblutionFacilities =
                                  v;
                            });
                          },
                        ),
                        const Text(
                          "متاح مرافق للوضوء",
                          style: StyleManager.headline,
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),

                  ///prayers
                  if (controller.isMosque())
                    Row(
                      children: [
                        Checkbox(
                          value: controller.item.value.allPrayers ?? false,
                          onChanged: (v) {
                            setState(() {
                              controller.item.value.allPrayers = v;
                            });
                          },
                        ),
                        const Text(
                          "جميع الصلاوات وصلاة الجمعة",
                          style: StyleManager.headline,
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),

                  ///lesson after ishaa
                  if (controller.isMosque())
                    Row(
                      children: [
                        Checkbox(
                          value:
                              controller.item.value.lessonAfterEshaa ?? false,
                          onChanged: (v) {
                            setState(() {
                              controller.item.value.lessonAfterEshaa = v;
                            });
                          },
                        ),
                        const Text(
                          "متاح درس بعد صلاة العشاء",
                          style: StyleManager.headline,
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),

                  ///women prayer room
                  if (controller.isMosque())
                    Row(
                      children: [
                        Checkbox(
                          value: controller.item.value.womenPrayerRoom ?? false,
                          onChanged: (v) {
                            setState(() {
                              controller.item.value.womenPrayerRoom = v;
                            });
                          },
                        ),
                        const Text(
                          "متاح مصلى للنساء",
                          style: StyleManager.headline,
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),

                  ///portrait featured
                  Row(
                    children: [
                      Checkbox(
                        value: controller.item.value.featuredPortrait ?? false,
                        onChanged: (v) {
                          setState(() {
                            controller.item.value.featuredPortrait = v;
                          });
                        },
                      ),
                      const Text(
                        "Featured portrait",
                        style: StyleManager.headline,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  ///logo featured
                  if (controller.isRestaurantOrCoffeeShop())
                    Row(
                      children: [
                        Checkbox(
                          value: controller.item.value.featuredLogo ?? false,
                          onChanged: (v) {
                            setState(() {
                              controller.item.value.featuredLogo = v;
                            });
                          },
                        ),
                        const Text(
                          "Featured logo",
                          style: StyleManager.headline,
                        ),
                      ],
                    ),
                  const SizedBox(height: 40),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Add item location parameters: ",
                        style: StyleManager.headline,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  ///add location params manualy
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                hintText: "Latitude",
                              ),
                              onChanged: (v) => controller.lat.value = v,
                              initialValue: controller.item.value.location?.lat,
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                hintText: "Longitude",
                              ),
                              onChanged: (v) => controller.long.value = v,
                              initialValue:
                                  controller.item.value.location?.long,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),

                  ///add products
                  if (controller.isRestaurantOrCoffeeShop())
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Add item products: ",
                          style: StyleManager.headline,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  if (controller.isRestaurantOrCoffeeShop()) productsAddRemove,
                ],
              ),
            );
          }),
        );
      }),
      bottomNavigationBar: InkWell(
        onTap: () => controller.saveItem(),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: ColorManager.primaryC,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                "Upload changes",
                style: StyleManager.authButtonTextStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

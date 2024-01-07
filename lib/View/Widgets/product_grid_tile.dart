import 'package:eup/Core/Theme/style_manager.dart';
import 'package:eup/Model/search_item_complex_datatypes/product_model.dart';
import 'package:flutter/material.dart';

class ProductGridTile extends StatelessWidget {
  const ProductGridTile({
    super.key,
    required this.product,
  });

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: SizedBox(
        width: 80,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
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
                            image: DecorationImage(
                              image: NetworkImage(product?.img ?? ""),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              child: Image.network(
                product?.img ?? "",
                width: 50,
                height: 42,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 3.0),
            Text(
              product?.title ?? "",
              style: StyleManager.hintStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

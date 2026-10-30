import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/widget/product_category.dart';
import 'package:inventory_managment/features/dashboard/widget/search_field.dart';
import 'package:inventory_managment/features/sales/widget/sales_product_card.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class SalesView extends StatefulWidget {
  const SalesView({super.key});

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  final List category = [
    'الكل',
    'المشروبات',
    'الإلكترونيات',
    'الخضروات',
    'اللحوم',
  ];
  int selectedIndex = 0;

  // نموذج تجريبي للكميات الخاصة بالمنتجات في شاشة المبيعات
  final Map<int, int> _productQuantities = {0: 1, 1: 0, 2: 5};

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 750;

    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.secondry,
            elevation: 0,
            scrolledUnderElevation: 0,
            automaticallyImplyLeading: false,
            leadingWidth: 100,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 22),
                    onPressed: () => Navigator.pop(context),
                    tooltip: 'رجوع',
                  ),
                  const Gap(4),
                  const CircleAvatar(
                    radius: 16,
                    child: Icon(Icons.person, size: 18),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CustomText(
                      text: 'شاشة بيع ومبيعات (POS)',
                      weight: FontWeight.bold,
                      size: 18,
                    ),
                    const Gap(8),
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, size: 24),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: const SizedBox(height: 45, child: SearchField()),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ProductCategory(
                selectedIndex: selectedIndex,
                category: category,
                onTap: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CustomText(
                    text: 'قائمة بطاقات المنتجات',
                    size: 20,
                    weight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(childCount: 4, (
                context,
                index,
              ) {
                final int currentQty = _productQuantities[index] ?? 0;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SalesProductCard(
                    name: index == 0 ? 'كوكاكولا 330 مل' : 'لابتوب ديل XPS 13',
                    sku: index == 0 ? 'CC330ML' : 'DELL-XPS13',
                    category: index == 0 ? 'Beverages' : 'Electronics',
                    salePrice: index == 0 ? '5.00' : '4999.05',
                    costPrice: index == 0 ? '3.50' : '3800.00',
                    quantity: currentQty,
                    isAdmin: true,
                    onIncrement: () {
                      setState(() {
                        _productQuantities[index] = currentQty + 1;
                      });
                    },
                    onDecrement: () {
                      if (currentQty > 0) {
                        setState(() {
                          _productQuantities[index] = currentQty - 1;
                        });
                      }
                    },
                    onAddTOCart: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'تمت إضافة المنتج للسلة برقم كمية: $currentQty',
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 2,
                childAspectRatio: isMobile ? 1.6 : 2.2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

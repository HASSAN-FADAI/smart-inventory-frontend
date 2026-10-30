import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/widget/add_category_bottom_sheet.dart';
import 'package:inventory_managment/features/dashboard/widget/add_product_bottom_sheet.dart';
import 'package:inventory_managment/features/dashboard/widget/product_card.dart';
import 'package:inventory_managment/features/dashboard/widget/product_category.dart';
import 'package:inventory_managment/features/dashboard/widget/search_field.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';
import 'package:inventory_managment/shared/custom_button.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class ProductManagementView extends StatefulWidget {
  const ProductManagementView({super.key});

  @override
  State<ProductManagementView> createState() => _ProductManagementViewState();
}

class _ProductManagementViewState extends State<ProductManagementView> {
  List category = ['الكل', 'المشروبات', 'الإلكترونيات', 'الخضروات', 'اللحوم'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 750;

    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          // 1. شريط علوي نظيف ومخصص فقط للـ AppBar والأيقونات العلوية
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
                      text: 'إدارة المنتجات والأقسام',
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

          // 2. الأزرار وشريط البحث أصبحت في محتوى مرن أسفل الـ AppBar لمنع التداخل نهائياً
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                children: [
                  isMobile
                      ? Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                text: 'إضافة فئة/قسم',
                                color: Colors.green,
                                size: 16,
                                icon: const Icon(
                                  Icons.create_new_folder_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                        const AddCategoryBottomSheet(),
                                  );
                                },
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                text: 'إضافة منتج جديد',
                                size: 16,
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                        const AddProductBottomSheet(),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              text: 'إضافة فئة/قسم',
                              color: Colors.green,
                              size: 17,
                              icon: const Icon(
                                Icons.create_new_folder_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) =>
                                      const AddCategoryBottomSheet(),
                                );
                              },
                            ),
                            const Gap(10),
                            CustomButton(
                              text: 'إضافة منتج جديد',
                              size: 17,
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) =>
                                      const AddProductBottomSheet(),
                                );
                              },
                            ),
                          ],
                        ),
                  const Gap(15),
                  const SizedBox(height: 45, child: SearchField()),
                ],
              ),
            ),
          ),

          // 3. شريط الفئات الأفقي
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

          // 4. عنوان القائمة
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  CustomText(
                    text: 'قائمة المنتجات',
                    size: 20,
                    weight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),

          // 5. شبكة بطاقات المنتجات المتجاوبة
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(childCount: 3, (
                context,
                index,
              ) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ProductCard(
                    name: 'لابتوب ديل XPS 13',
                    sku: 'DELL-XPS13',
                    category: 'الاكترونيات',
                    salePrice: '4999.00',
                    costPrice: '3800.00',
                    quantity: '25',
                    minQuantity: '5',
                    onDelete: () {},
                    onEdit: () {},
                  ),
                );
              }),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : 2,
                childAspectRatio: isMobile ? 1.3 : 1.8,
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

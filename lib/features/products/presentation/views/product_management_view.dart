import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/search_field.dart';
import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';
import 'package:inventory_managment/features/products/presentation/cubit/products_cubit.dart';
import 'package:inventory_managment/features/products/presentation/cubit/products_stata.dart';
import 'package:inventory_managment/features/products/presentation/widget/add_category_bottom_sheet.dart';
import 'package:inventory_managment/features/products/presentation/widget/add_product_bottom_sheet.dart';
import 'package:inventory_managment/features/products/presentation/widget/product_card.dart';
import 'package:inventory_managment/features/products/presentation/widget/product_category.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';
import 'package:inventory_managment/shared/custom_button.dart';
import 'package:inventory_managment/shared/custom_snack_bar.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class ProductManagementView extends StatefulWidget {
  const ProductManagementView({super.key});

  @override
  State<ProductManagementView> createState() => _ProductManagementViewState();
}

class _ProductManagementViewState extends State<ProductManagementView> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 750;

    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is ProductsError) {
            CustomSnackBar.show(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          } else if (state is ProductsSuccess && state.actionMessage != null) {
            CustomSnackBar.show(
              context,
              message: state.actionMessage!,
              type: SnackBarType.success,
            );
          }
        },
        builder: (context, state) {
          final List<CategoryEntity> categories = state is ProductsSuccess
              ? state.categories
              : [];
          final int selectedIndex = state is ProductsSuccess
              ? state.selectedCategoryIndex
              : 0;

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              await context.read<ProductsCubit>().loadInitialData(
                forceRefresh: true,
              );
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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

                if (state is ProductsLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state is ProductsError)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: state.message, size: 16),
                          const Gap(15),
                          ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().loadInitialData();
                            },
                            child: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state is ProductsSuccess) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
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
                                        onTap: () =>
                                            AddCategoryBottomSheet.show(
                                              context,
                                            ),
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
                                        onTap: () => AddProductBottomSheet.show(
                                          context,
                                          categories,
                                        ),
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
                                      onTap: () =>
                                          AddCategoryBottomSheet.show(context),
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
                                      onTap: () => AddProductBottomSheet.show(
                                        context,
                                        categories,
                                      ),
                                    ),
                                  ],
                                ),
                          const Gap(15),
                          SizedBox(
                            height: 45,
                            child: SearchField(
                              onChanged: (value) {
                                context.read<ProductsCubit>().onSearchChanged(
                                  value,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ProductCategory(
                        selectedIndex: selectedIndex,
                        categories: categories,
                        onTap: (int index) {
                          context.read<ProductsCubit>().selectCategory(index);
                        },
                        onLongPressDelete: (String categoryId) {
                          context.read<ProductsCubit>().deleteCategory(
                            categoryId,
                          );
                        },
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
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

                  if (state.filteredProducts.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CustomText(
                          text: 'لا توجد منتجات مطابقة',
                          size: 16,
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      sliver: SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          childCount: state.filteredProducts.length,
                          (context, index) {
                            final product = state.filteredProducts[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: ProductCard(
                                name: product.name,
                                sku: product.sku,
                                category: product.category?.name ?? 'غير مصنف',
                                salePrice: product.price.toStringAsFixed(2),
                                costPrice: product.costPrice.toStringAsFixed(2),
                                quantity: product.stockQuantity.toString(),
                                minQuantity: product.minStockLevel.toString(),
                                onDelete: () {
                                  context.read<ProductsCubit>().deleteProduct(
                                    product.id,
                                  );
                                },
                                onEdit: () {
                                  AddProductBottomSheet.show(
                                    context,
                                    categories,
                                    productToEdit: product,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 1 : 2,
                          childAspectRatio: isMobile ? 1.3 : 1.8,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                        ),
                      ),
                    ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

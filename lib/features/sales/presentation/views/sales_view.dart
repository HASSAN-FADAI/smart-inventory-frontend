import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/search_field.dart';
import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';
import 'package:inventory_managment/features/products/presentation/widget/product_category.dart';
import 'package:inventory_managment/features/sales/presentation/cubit/sales_cubit.dart';
import 'package:inventory_managment/features/sales/presentation/cubit/sales_state.dart';
import 'package:inventory_managment/features/sales/presentation/widget/cart_badge_icon.dart';
import 'package:inventory_managment/features/sales/presentation/widget/cart_bottom_sheet.dart';
import 'package:inventory_managment/features/sales/presentation/widget/sales_product_card.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';
import 'package:inventory_managment/shared/custom_snack_bar.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class SalesView extends StatefulWidget {
  const SalesView({super.key});

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  @override
  void initState() {
    super.initState();
    context.read<SalesCubit>().loadSalesData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 750;

    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      body: BlocConsumer<SalesCubit, SalesState>(
        listener: (context, state) {
          if (state is SalesError) {
            CustomSnackBar.show(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          } else if (state is SalesSuccess && state.actionMessage != null) {
            CustomSnackBar.show(
              context,
              message: state.actionMessage!,
              type: SnackBarType.success,
            );
          }
        },
        builder: (context, state) {
          final List<CategoryEntity> categories = state is SalesSuccess
              ? state.categories
              : [];
          final int selectedIndex = state is SalesSuccess
              ? state.selectedCategoryIndex
              : 0;
          final int cartCount = state is SalesSuccess
              ? state.totalCartCount
              : 0;

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              await context.read<SalesCubit>().loadSalesData(
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
                  leadingWidth: 140,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, size: 22),
                          onPressed: () => Navigator.pop(context),
                          tooltip: 'رجوع',
                        ),
                        CartBadgeIcon(
                          itemCount: cartCount,
                          onTap: () => CartBottomSheet.show(context),
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
                            text: 'إدارة البيع والمبيعات',
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

                if (state is SalesLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (state is SalesError)
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
                              context.read<SalesCubit>().loadSalesData();
                            },
                            child: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (state is SalesSuccess) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        height: 45,
                        child: SearchField(
                          onChanged: (value) {
                            context.read<SalesCubit>().onSearchChanged(value);
                          },
                        ),
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
                          context.read<SalesCubit>().selectCategory(index);
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
                            text: 'قائمة بطاقات المنتجات',
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
                            final int currentQty =
                                state.cardQuantities[product.id] ?? 0;
                            final cubit = context.read<SalesCubit>();

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: SalesProductCard(
                                name: product.name,
                                sku: product.sku,
                                category: product.category?.name ?? 'غير مصنف',
                                salePrice: product.price.toStringAsFixed(2),
                                costPrice: product.costPrice.toStringAsFixed(2),
                                quantity: currentQty,
                                isAdmin: true,
                                onIncrement: () =>
                                    cubit.incrementCardQty(product),
                                onDecrement: () =>
                                    cubit.decrementCardQty(product.id),
                                onAddTOCart: () => cubit.addToCart(product),
                              ),
                            );
                          },
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 1 : 2,
                          childAspectRatio: isMobile ? 1.6 : 2.2,
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

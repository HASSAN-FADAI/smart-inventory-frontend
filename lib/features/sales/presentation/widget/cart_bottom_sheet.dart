import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/sales/presentation/cubit/sales_cubit.dart';
import 'package:inventory_managment/features/sales/presentation/cubit/sales_state.dart';
import 'package:inventory_managment/features/sales/presentation/widget/cart_item_tile.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    final cubit = context.read<SalesCubit>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const CartBottomSheet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: BlocBuilder<SalesCubit, SalesState>(
        builder: (context, state) {
          if (state is! SalesSuccess || state.cartItems.isEmpty) {
            return const SizedBox(
              height: 180,
              child: Center(
                child: CustomText(text: 'السلة فارغة حالياً', size: 16),
              ),
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomText(
                text: 'سلة المبيعات',
                size: 18,
                weight: FontWeight.bold,
              ),
              const Gap(15),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.45,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.cartItems.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];
                    final cubit = context.read<SalesCubit>();
                    return CartItemTile(
                      item: item,
                      onIncrement: () =>
                          cubit.updateCartItemQty(item.product.id, 1),
                      onDecrement: () =>
                          cubit.updateCartItemQty(item.product.id, -1),
                      onRemove: () => cubit.removeFromCart(item.product.id),
                    );
                  },
                ),
              ),
              const Divider(height: 25, thickness: 1.2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: '${state.totalCartAmount.toStringAsFixed(2)} SAR',
                    size: 18,
                    weight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  const CustomText(
                    text: 'الإجمالي الكلي:',
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              const Gap(20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: state.isCheckingOut
                      ? null
                      : () async {
                          final success = await context
                              .read<SalesCubit>()
                              .checkout();
                          if (success && context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                  child: state.isCheckingOut
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const CustomText(
                          text: 'إتمام البيع',
                          color: Colors.white,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

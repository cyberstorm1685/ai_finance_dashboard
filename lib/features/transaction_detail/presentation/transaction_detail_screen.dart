import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/constants/colors.dart';

class TransactionDetailScreen extends StatelessWidget {
  final String transactionId;

  const TransactionDetailScreen({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kSpacingLarge),
        child: Column(
          children: [
            Hero(
              tag: 'trans_$transactionId',
              child: Material(
                color: Colors.transparent,
                child: Text('Transaction #$transactionId', style: Theme.of(context).textTheme.headlineMedium),
              ),
            ),
            const SizedBox(height: kSpacingLarge),
            CustomTextField(label: 'Amount', onChanged: (_) {}, initialValue: '\$150.00'),
            CustomTextField(label: 'Description', onChanged: (_) {}),
            CustomTextField(label: 'Date', onChanged: (_) {}),
            const SizedBox(height: kSpacingLarge),
            CustomButton(
              text: 'Select Category',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (ctx) => Container(
                    padding: const EdgeInsets.all(kSpacingLarge),
                    child: ListView(
                      shrinkWrap: true,
                      children: ['Food', 'Transport', 'Shopping', 'Bills'].map((cat) => ListTile(
                        title: Text(cat),
                        onTap: () => context.pop(),
                      )).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
        backgroundColor: AppColors.primary,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
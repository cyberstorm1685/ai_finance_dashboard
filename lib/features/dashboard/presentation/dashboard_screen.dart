import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';
import 'dashboard_notifier.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardProvider);
    final notifier = ref.read(dashboardProvider.notifier);
    final RefreshController refreshController = RefreshController(initialRefresh: false);

    return Scaffold(
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await notifier.refresh();
          refreshController.refreshCompleted();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              backgroundColor: AppColors.primary,
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(bottom: 16),
                centerTitle: true,
                title: const Text(
                  'Finance Dashboard',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: dashboardAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Center(child: Text('Error loading data')),
                data: (data) => Padding(
                  padding: const EdgeInsets.all(kSpacingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Monthly Summary Card
                      CustomCard(
                        child: Padding(
                          padding: const EdgeInsets.all(kSpacingMedium),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Monthly Summary',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: kSpacingSmall),
                              Text('Balance: \$${data['balance']}',
                                  style: const TextStyle(fontSize: 28, color: AppColors.secondary, fontWeight: FontWeight.bold)),
                              const SizedBox(height: kSpacingSmall),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Income: \$${data['income']}',
                                      style: const TextStyle(color: AppColors.secondary, fontSize: 16)),
                                  Text('Expenses: \$${data['expenses']}',
                                      style: const TextStyle(color: AppColors.error, fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: kSpacingLarge),

                      // Line Chart
                      CustomCard(
                        child: SizedBox(
                          height: 250,
                          child: LineChart(
                            LineChartData(
                              lineTouchData: const LineTouchData(enabled: true),
                              gridData: const FlGridData(show: true),
                              titlesData: const FlTitlesData(show: true),
                              borderData: FlBorderData(show: true),
                              lineBarsData: [
                                LineChartBarData(
                                  spots: (data['chartData'] as List<double>)
                                      .asMap()
                                      .entries
                                      .map((e) => FlSpot(e.key.toDouble(), e.value))
                                      .toList(),
                                  isCurved: true,
                                  color: AppColors.primary,
                                  barWidth: 4,
                                  dotData: const FlDotData(show: true),
                                ),
                              ],
                            ),
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.easeInOut,
                          ),
                        ),
                      ),
                      const SizedBox(height: kSpacingLarge),

                      // Category Chips
                      const Text('Categories',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: kSpacingSmall),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (data['categories'] as List).length,
                          itemBuilder: (ctx, i) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Chip(
                              label: Text(data['categories'][i]),
                              backgroundColor: AppColors.primary.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: kSpacingLarge),

                      // Recent Transactions
                      const Text('Recent Transactions',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: kSpacingMedium),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: (data['transactions'] as List).length,
                        itemBuilder: (ctx, index) {
                          final trans = data['transactions'][index];
                          final isExpense = trans['amount'] < 0;

                          return Hero(
                            tag: 'trans_${trans['id']}',
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: Icon(trans['icon'], color: AppColors.primary),
                                title: Text(trans['title']),
                                subtitle: Text(trans['date']),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${isExpense ? '-' : '+'}\$${trans['amount'].abs()}',
                                      style: TextStyle(
                                        color: isExpense ? AppColors.error : AppColors.secondary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Chip(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      label: Text(
                                        trans['status'],
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                      backgroundColor: trans['status'] == 'Pending'
                                          ? Colors.orange[100]
                                          : Colors.green[100],
                                    ),
                                  ],
                                ),
                                onTap: () => context.go('/transaction/${trans['id']}'),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
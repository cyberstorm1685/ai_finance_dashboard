import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/spacing.dart';

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.delayed(const Duration(seconds: 2), () => setState(() => loading = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          tabs: const [Tab(text: 'Weekly'), Tab(text: 'Monthly'), Tab(text: 'Yearly')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [1, 2, 3].map((_) => Skeletonizer(
          enabled: loading,
          child: Padding(
            padding: const EdgeInsets.all(kSpacingLarge),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: PieChart(PieChartData(sections: [
                    PieChartSectionData(value: 30, color: AppColors.primary, title: 'Food'),
                    PieChartSectionData(value: 25, color: AppColors.secondary, title: 'Transport'),
                    // Add more
                  ])),
                ),
                ExpansionTile(
                  title: const Text('Insight Card'),
                  children: [AnimatedContainer(duration: const Duration(milliseconds: 300), child: const Text('Details here...'))],
                ),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }
}
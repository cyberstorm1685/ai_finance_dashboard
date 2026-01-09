import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_dashboard_repo.dart';

final mockRepo = MockDashboardRepo();

class DashboardNotifier extends AutoDisposeAsyncNotifier<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> build() async {
    return mockRepo.fetchData();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => mockRepo.fetchData());
  }
}

final dashboardProvider = AutoDisposeAsyncNotifierProvider<DashboardNotifier, Map<String, dynamic>>(DashboardNotifier.new);
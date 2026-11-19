import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Enums for alert categories and filter tabs
enum AlertType { lowStock, expiring }

enum AlertFilter { lowStock, expiring }

// 2. Immutable model for a single alert card
class StockAlert {
  final String id;
  final String productName;
  final AlertType type;
  final String subtitle;
  final bool isMarkedForReorder;

  const StockAlert({
    required this.id,
    required this.productName,
    required this.type,
    required this.subtitle,
    this.isMarkedForReorder = false,
  });

  // Returns a new copy with updated fields (required for Riverpod immutability)
  StockAlert copyWith({bool? isMarkedForReorder}) {
    return StockAlert(
      id: id,
      productName: productName,
      type: type,
      subtitle: subtitle,
      isMarkedForReorder: isMarkedForReorder ?? this.isMarkedForReorder,
    );
  }
}

// 3. State class holding the active tab, alert list, and live badge counts
class AlertsState {
  final AlertFilter selectedFilter;
  final List<StockAlert> alerts;

  const AlertsState({
    this.selectedFilter = AlertFilter.lowStock,
    required this.alerts,
  });

  int get lowStockCount =>
      alerts.where((a) => a.type == AlertType.lowStock).length;

  int get expiringCount =>
      alerts.where((a) => a.type == AlertType.expiring).length;

  List<StockAlert> get lowStockAlerts =>
      alerts.where((a) => a.type == AlertType.lowStock).toList();

  List<StockAlert> get expiringAlerts =>
      alerts.where((a) => a.type == AlertType.expiring).toList();

  AlertsState copyWith({
    AlertFilter? selectedFilter,
    List<StockAlert>? alerts,
  }) {
    return AlertsState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      alerts: alerts ?? this.alerts,
    );
  }
}

// 4. Notifier & Provider holding Demo 1 seed data and user actions
class AlertsNotifier extends Notifier<AlertsState> {
  @override
  AlertsState build() {
    return const AlertsState(
      selectedFilter: AlertFilter.lowStock,
      alerts: [
        StockAlert(
          id: 'alert-1',
          productName: 'Vitamin C Serum',
          type: AlertType.lowStock,
          subtitle: '4 bottles left • minimum 10',
          isMarkedForReorder: true,
        ),
        StockAlert(
          id: 'alert-2',
          productName: 'Hyaluronic filler 2ml',
          type: AlertType.lowStock,
          subtitle: '3 bottles left • minimum 12',
          isMarkedForReorder: false,
        ),
        StockAlert(
          id: 'alert-3',
          productName: 'Peptide serum • Batch PS-67',
          type: AlertType.expiring,
          subtitle: 'Expires 24 Oct 2026',
        ),
      ],
    );
  }

  void setFilter(AlertFilter filter) {
    state = state.copyWith(selectedFilter: filter);
  }

  void toggleMarkForReorder(String alertId) {
    final updated = state.alerts.map((alert) {
      if (alert.id == alertId) {
        return alert.copyWith(isMarkedForReorder: !alert.isMarkedForReorder);
      }
      return alert;
    }).toList();

    state = state.copyWith(alerts: updated);
  }
}

final alertsProvider = NotifierProvider<AlertsNotifier, AlertsState>(
  AlertsNotifier.new,
);

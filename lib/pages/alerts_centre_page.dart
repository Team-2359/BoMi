import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme.dart';
import '../features/alerts/providers/alerts_provider.dart';

class AlertsCenterScreen extends ConsumerWidget {
  final VoidCallback? onNavigateToInventory;

  const AlertsCenterScreen({super.key, this.onNavigateToInventory});

  static const Color alertRed = Color(0xFFE53935);
  static const Color alertRedBg = Color(0xFFFDECEA);
  static const Color alertRedBorder = Color(0x66E53935);
  static const Color expiringAmber = Color(0xFFF5A623);
  static const Color expiringAmberBg = Color(0xFFFEF3C7);
  static const Color reorderGreen = Color(0xFF1B5E20);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsState = ref.watch(alertsProvider);
    final notifier = ref.read(alertsProvider.notifier);
    final isLowSelected = alertsState.selectedFilter == AlertFilter.lowStock;

    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Bar
            Container(
              width: double.infinity,
              color: kWhite,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
              child: SizedBox(
                height: 34,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Alerts',
                      style: playfair(24, w: FontWeight.w700, c: kDark),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable Content (aligned with BoMI Insight layout)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resolve stock risks before they affect cares',
                      style: inter(
                        13,
                        w: FontWeight.w400,
                        c: const Color(0xFF8E8E93),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _FilterTabBar(
                      selectedFilter: alertsState.selectedFilter,
                      lowStockCount: alertsState.lowStockCount,
                      expiringCount: alertsState.expiringCount,
                      onSelectFilter: notifier.setFilter,
                    ),
                    const SizedBox(height: 20),
                    if (isLowSelected) ...[
                      Text(
                        'ACTION NEEDED',
                        style: inter(
                          12,
                          w: FontWeight.w700,
                          c: alertRed,
                        ).copyWith(letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 10),
                      ...alertsState.lowStockAlerts.map(
                        (alert) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _LowStockAlertCard(
                            alert: alert,
                            onToggleReorder: () =>
                                notifier.toggleMarkForReorder(alert.id),
                            onViewItem: () => _handleViewItem(context, alert),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                    Text('Expiring Soon', style: inter(14, w: FontWeight.w700)),
                    const SizedBox(height: 10),
                    ...alertsState.expiringAlerts.map(
                      (alert) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ExpiringAlertCard(
                          alert: alert,
                          onViewItem: () => _handleViewItem(context, alert),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleViewItem(BuildContext context, StockAlert alert) {
    if (onNavigateToInventory != null) {
      onNavigateToInventory!();
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Viewing ${alert.productName}',
          style: inter(12, w: FontWeight.w500, c: kWhite),
        ),
        backgroundColor: kDark,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class _FilterTabBar extends StatelessWidget {
  final AlertFilter selectedFilter;
  final int lowStockCount;
  final int expiringCount;
  final ValueChanged<AlertFilter> onSelectFilter;

  const _FilterTabBar({
    required this.selectedFilter,
    required this.lowStockCount,
    required this.expiringCount,
    required this.onSelectFilter,
  });

  @override
  Widget build(BuildContext context) {
    final isLowSelected = selectedFilter == AlertFilter.lowStock;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onSelectFilter(AlertFilter.lowStock),
              child: Container(
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isLowSelected ? kDark : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Low stock',
                      style: inter(
                        13,
                        w: isLowSelected ? FontWeight.w600 : FontWeight.w400,
                        c: isLowSelected ? kWhite : kDark,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Transform.translate(
                      offset: const Offset(0, -4),
                      child: _BadgeCircle(
                        count: lowStockCount,
                        color: AlertsCenterScreen.alertRed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onSelectFilter(AlertFilter.expiring),
              child: Container(
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !isLowSelected ? kDark : Colors.transparent,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Expiring',
                      style: inter(
                        13,
                        w: !isLowSelected ? FontWeight.w600 : FontWeight.w400,
                        c: !isLowSelected ? kWhite : kDark,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Transform.translate(
                      offset: const Offset(0, -4),
                      child: _BadgeCircle(
                        count: expiringCount,
                        color: AlertsCenterScreen.expiringAmber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BadgeCircle extends StatelessWidget {
  final int count;
  final Color color;

  const _BadgeCircle({required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 19,
      height: 19,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Text(
        '$count',
        style: inter(10, w: FontWeight.w700, c: kWhite),
      ),
    );
  }
}

class _LowStockAlertCard extends StatelessWidget {
  final StockAlert alert;
  final VoidCallback onToggleReorder;
  final VoidCallback onViewItem;

  const _LowStockAlertCard({
    required this.alert,
    required this.onToggleReorder,
    required this.onViewItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AlertsCenterScreen.alertRedBg,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AlertsCenterScreen.alertRedBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.circle,
                  size: 8,
                  color: AlertsCenterScreen.alertRed,
                ),
                const SizedBox(width: 6),
                Text(
                  'Low',
                  style: inter(
                    11,
                    w: FontWeight.w600,
                    c: AlertsCenterScreen.alertRed,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(alert.productName, style: inter(15, w: FontWeight.w700)),
          const SizedBox(height: 3),
          Text(alert.subtitle, style: inter(12, c: Colors.black54)),
          const SizedBox(height: 12),
          if (alert.isMarkedForReorder)
            SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: onToggleReorder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AlertsCenterScreen.reorderGreen,
                  foregroundColor: kWhite,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.check, size: 17),
                label: Text(
                  'Marked for reorder',
                  style: inter(12, w: FontWeight.w600, c: kWhite),
                ),
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: onToggleReorder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kDark,
                        foregroundColor: kWhite,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Mark for reorder',
                        style: inter(12, w: FontWeight.w600, c: kWhite),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextButton(
                      onPressed: onViewItem,
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF0F0F0),
                        foregroundColor: kDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'View item',
                        style: inter(12, w: FontWeight.w600, c: kDark),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _ExpiringAlertCard extends StatelessWidget {
  final StockAlert alert;
  final VoidCallback onViewItem;

  const _ExpiringAlertCard({required this.alert, required this.onViewItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AlertsCenterScreen.expiringAmberBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.circle,
                  size: 8,
                  color: AlertsCenterScreen.expiringAmber,
                ),
                const SizedBox(width: 6),
                Text(
                  'Expiring',
                  style: inter(
                    11,
                    w: FontWeight.w600,
                    c: const Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(alert.productName, style: inter(15, w: FontWeight.w700)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(alert.subtitle, style: inter(12, c: Colors.black54)),
              GestureDetector(
                onTap: onViewItem,
                child: Text(
                  'View Item →',
                  style: inter(12, w: FontWeight.w600, c: Colors.teal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

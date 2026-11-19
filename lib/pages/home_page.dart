import 'package:flutter/material.dart';

import '../theme.dart';
import 'alerts_centre_page.dart';
import 'bomi_insight_page.dart';
import 'inventory_page.dart';
import 'notifications_page.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onNavigateToInventory;
  final VoidCallback? onNavigateToAlerts;
  final VoidCallback? onNavigateToInsight;
  final VoidCallback? onNavigateToScan;

  const HomePage({
    super.key,
    this.onNavigateToInventory,
    this.onNavigateToAlerts,
    this.onNavigateToInsight,
    this.onNavigateToScan,
  });

  BoxDecoration get _card => BoxDecoration(
    color: kWhite,
    borderRadius: BorderRadius.circular(14),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  void _goToInventory(BuildContext context) {
    if (onNavigateToInventory != null) {
      onNavigateToInventory!();
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const InventoryPage()),
    );
  }

  void _goToAlerts(BuildContext context) {
    if (onNavigateToAlerts != null) {
      onNavigateToAlerts!();
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AlertsCenterScreen(
          onNavigateToInventory: () {
            Navigator.pop(context);
            _goToInventory(context);
          },
        ),
      ),
    );
  }

  void _goToInsight(BuildContext context) {
    if (onNavigateToInsight != null) {
      onNavigateToInsight!();
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const BoMIInsightPage()),
    );
  }

  void _goToScan(BuildContext context) {
    if (onNavigateToScan != null) {
      onNavigateToScan!();
      return;
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Opening BoMI Scan...',
            style: inter(13, w: FontWeight.w500, c: kWhite),
          ),
          backgroundColor: kDark,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
  }

  void _showProfileSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: kWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person_outline, color: kDark),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Emily',
                            style: playfair(18, w: FontWeight.w700, c: kDark),
                          ),
                          Text(
                            'Clinic Inventory Manager • Miri Branch',
                            style: inter(12, c: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kDark,
                      foregroundColor: kWhite,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Close',
                      style: inter(13, w: FontWeight.w600, c: kWhite),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _stat(
    String num,
    String label,
    String sub,
    Color color, {
    VoidCallback? onTap,
  }) => Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: _card,
        child: Column(
          children: [
            Text(
              num,
              style: playfair(30, w: FontWeight.w700, c: color),
            ),
            Text(label, style: inter(11, c: Colors.black54)),
            Text(sub, style: inter(9, c: Colors.black38)),
          ],
        ),
      ),
    ),
  );

  Widget _quick(
    IconData icon,
    Color color,
    String title,
    String sub, {
    required VoidCallback onTap,
  }) => Expanded(
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: _card,
        child: Row(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: inter(13, w: FontWeight.w600)),
                  Text(sub, style: inter(10, c: Colors.black54)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward, size: 16, color: Colors.black26),
          ],
        ),
      ),
    ),
  );

  Widget _aiTool(
    IconData icon,
    String title,
    String desc,
    String link, {
    required VoidCallback onTap,
  }) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: _card,
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7C6FE0), size: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: inter(13, w: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(desc, style: inter(10, c: Colors.black54)),
                const SizedBox(height: 2),
                Text(
                  '$link  →',
                  style: inter(
                    10,
                    w: FontWeight.w600,
                    c: const Color(0xFF7C6FE0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _section(String t) => Padding(
    padding: const EdgeInsets.only(top: 18, bottom: 10),
    child: Text(t, style: inter(14, w: FontWeight.w700)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Bar (matches Inventory & BoMI Insight height)
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
                      'BoMI',
                      style: playfair(24, w: FontWeight.w700, c: kDark),
                    ),
                    const Spacer(),
                    Flexible(
                      child: Text(
                        'GOOD MORNING, EMILY',
                        overflow: TextOverflow.ellipsis,
                        style: inter(10, w: FontWeight.w500, c: kDark),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (_) => const NotificationsPage(),
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.notifications_none,
                            size: 26,
                            color: kDark,
                          ),
                          Positioned(
                            right: -2,
                            top: -2,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '3',
                                style: inter(8, w: FontWeight.w700, c: kWhite),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () => _showProfileSheet(context),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.person_outline,
                          color: kDark,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Overview', style: playfair(24, w: FontWeight.w700)),
                    Text(
                      'Miri branch   Mon, 12 Oct 2026',
                      style: inter(11, c: Colors.black54),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        _stat(
                          '67',
                          'Total Items',
                          'Tracked',
                          kDark,
                          onTap: () => _goToInventory(context),
                        ),
                        const SizedBox(width: 10),
                        _stat(
                          '6',
                          'Low stock',
                          'Needs action',
                          Colors.red,
                          onTap: () => _goToAlerts(context),
                        ),
                        const SizedBox(width: 10),
                        _stat(
                          '7',
                          'Expiring soon',
                          'Next 30 days',
                          Colors.orange,
                          onTap: () => _goToAlerts(context),
                        ),
                      ],
                    ),
                    _section('Quick actions'),
                    Row(
                      children: [
                        _quick(
                          Icons.assignment_outlined,
                          kDark,
                          'Inventory',
                          '128 items',
                          onTap: () => _goToInventory(context),
                        ),
                        const SizedBox(width: 10),
                        _quick(
                          Icons.error_outline,
                          Colors.red,
                          'Alerts',
                          '13 need review',
                          onTap: () => _goToAlerts(context),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18, bottom: 10),
                      child: Row(
                        children: [
                          Text(
                            'AI Tools',
                            style: inter(14, w: FontWeight.w700),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDEAFB),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF7C6FE0),
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.auto_awesome,
                                  size: 12,
                                  color: Color(0xFF7C6FE0),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'AI POWERED',
                                  style: inter(9, c: const Color(0xFF7C6FE0)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _aiTool(
                      Icons.center_focus_strong,
                      'BoMI Scan',
                      'Turn supplier invoices into draft stock entries.',
                      'Open scan',
                      onTap: () => _goToScan(context),
                    ),
                    _aiTool(
                      Icons.bar_chart,
                      'BoMI Insight',
                      'Explain usage trends, suggest replenishment and reports',
                      'View insight',
                      onTap: () => _goToInsight(context),
                    ),
                    _section("Today's Priority"),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: _card,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Reorder 2% lidocaine filler before next clinic.',
                              style: inter(11, c: Colors.black54),
                            ),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => _goToAlerts(context),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 4,
                              ),
                              child: Text(
                                'Review',
                                style: inter(
                                  11,
                                  w: FontWeight.w600,
                                  c: Colors.teal,
                                ),
                              ),
                            ),
                          ),
                        ],
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
}

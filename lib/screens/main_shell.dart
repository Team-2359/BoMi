import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme.dart';
import 'pages/alerts_center_page.dart';
import '/pages/bomi_insight_page.dart';
import '/pages/bomi_scan_page.dart';
import '/pages/home_page.dart';
import '/pages/stock_movement_page.dart';
import '/pages/inventory_page.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  bool _actionsOpen = false;

  static const Color _actionsActivePurple = Color(0xFF8866C6);
  static const Color _scanCirclePurple = Color(0xFFEFE8FC);

  static const _items = [
    (Icons.home_filled, 'Home'),
    (Icons.inventory_2_outlined, 'Inventory'),
    (Icons.bolt, 'Actions'),
    (Icons.bar_chart, 'Insight'),
    (Icons.sensors, 'Alert'),
  ];

  Widget _buildBody() {
    switch (_index) {
      case 0:
        return const HomePage();
      case 1:
        return const InventoryPage();
      case 3:
        return const BoMIInsightPage();
      case 4:
        return AlertsCenterScreen(
          onNavigateToInventory: () => setState(() => _index = 1),
        );
      default:
        return Scaffold(
          backgroundColor: kBg,
          body: SafeArea(
            child: Center(child: Text(_items[_index].$2, style: playfair(28))),
          ),
        );
    }
  }

  void _openQuickRoute(Widget page) {
    setState(() => _actionsOpen = false);
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: kBg,
      extendBody: true,
      body: Stack(
        children: [
          _buildBody(),
          if (_actionsOpen) ...[
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _actionsOpen = false),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(color: const Color(0x26FFFFFF)),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomInset + 14,
              child: Center(
                child: _QuickActionsWheel(
                  onStockIn: () => _openQuickRoute(
                    const StockMovementPage(initialIsStockIn: true),
                  ),
                  onBomiScan: () => _openQuickRoute(const BoMIScanPage()),
                  onStockOut: () => _openQuickRoute(
                    const StockMovementPage(initialIsStockIn: false),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: SizedBox(
            height: 82,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: kDark,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    children: List.generate(_items.length, (i) {
                      if (i == 2) {
                        return const Expanded(child: SizedBox());
                      }

                      final sel = !_actionsOpen && i == _index;
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => setState(() {
                            _actionsOpen = false;
                            _index = i;
                          }),
                          child: Center(
                            child: Container(
                              width: 54,
                              height: 52,
                              decoration: BoxDecoration(
                                color: sel ? kWhite : Colors.transparent,
                                borderRadius: BorderRadius.circular(26),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _items[i].$1,
                                    size: 22,
                                    color: sel ? Colors.black : kWhite,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    _items[i].$2,
                                    style: inter(
                                      8,
                                      w: FontWeight.w600,
                                      c: sel ? Colors.black : kWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _actionsOpen = !_actionsOpen),
                    child: Container(
                      width: 78,
                      height: 78,
                      decoration: BoxDecoration(
                        color: _actionsOpen ? _actionsActivePurple : kWhite,
                        shape: BoxShape.circle,
                        border: Border.all(color: kDark, width: 4.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.bolt, size: 32, color: kDark),
                          Text(
                            'Actions',
                            style: inter(9, w: FontWeight.w700, c: kDark),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionsWheel extends StatelessWidget {
  final VoidCallback onStockIn;
  final VoidCallback onBomiScan;
  final VoidCallback onStockOut;

  const _QuickActionsWheel({
    required this.onStockIn,
    required this.onBomiScan,
    required this.onStockOut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 224,
      height: 224,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0x66FFFFFF),
        border: Border.all(color: const Color(0x1F000000), width: 1),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 14,
            left: 0,
            right: 0,
            child: Center(
              child: _FloatingActionCircle(
                icon: Icons.center_focus_weak,
                label: 'BoMI Scan',
                backgroundColor: _MainShellState._scanCirclePurple,
                onTap: onBomiScan,
              ),
            ),
          ),
          Positioned(
            top: 76,
            left: 14,
            child: _FloatingActionCircle(
              icon: Icons.login_rounded,
              label: 'Stock In',
              backgroundColor: kWhite,
              onTap: onStockIn,
            ),
          ),
          Positioned(
            top: 76,
            right: 14,
            child: _FloatingActionCircle(
              icon: Icons.logout_rounded,
              label: 'Stock Out',
              backgroundColor: kWhite,
              onTap: onStockOut,
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingActionCircle extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _FloatingActionCircle({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 66,
        height: 66,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: kDark),
            const SizedBox(height: 3),
            Text(
              label,
              style: inter(8.5, w: FontWeight.w600, c: kDark),
            ),
          ],
        ),
      ),
    );
  }
}

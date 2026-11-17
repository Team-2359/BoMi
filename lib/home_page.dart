import 'package:flutter/material.dart';

import '../theme.dart';
import 'notifications_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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

  Widget _stat(String num, String label, String sub, Color color) => Expanded(
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
  );

  Widget _quick(IconData icon, Color color, String title, String sub) =>
      Expanded(
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
      );

  Widget _aiTool(IconData icon, String title, String desc, String link) =>
      Container(
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
                  Text('$link  ', style: inter(10, c: const Color(0xFF7C6FE0))),
                ],
              ),
            ),
          ],
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
            // Top Header Bar
            Container(
              width: double.infinity,
              color: kWhite,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              child: SizedBox(
                height: 36,
                child: Row(
                  children: [
                    Text('BoMI', style: playfair(26, w: FontWeight.w700)),
                    const Spacer(),
                    Text(
                      'GOOD MORNING, EMILY',
                      style: inter(10, w: FontWeight.w500),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsPage(),
                        ),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(Icons.notifications_none, size: 28),
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
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(Icons.person_outline, color: kDark),
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
                        _stat('67', 'Total Items', 'Tracked', kDark),
                        const SizedBox(width: 10),
                        _stat('6', 'Low stock', 'Needs action', Colors.red),
                        const SizedBox(width: 10),
                        _stat(
                          '7',
                          'Expiring soon',
                          'Next 30 days',
                          Colors.orange,
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
                        ),
                        const SizedBox(width: 10),
                        _quick(
                          Icons.error_outline,
                          Colors.red,
                          'Alerts',
                          '13 need review',
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
                    ),
                    _aiTool(
                      Icons.bar_chart,
                      'BoMI Insight',
                      'Explain usage trends, suggest replenishment and reports',
                      'View insight',
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
                          Text(
                            'Review',
                            style: inter(
                              11,
                              w: FontWeight.w600,
                              c: Colors.teal,
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

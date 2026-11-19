import 'package:flutter/material.dart';

import '../theme.dart';

class GeneratedReportPage extends StatelessWidget {
  const GeneratedReportPage({super.key});

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
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

  @override
  Widget build(BuildContext context) {
    const purpleAccent = Color(0xFF8B5CF6);
    const purpleBg = Color(0xFFF5F3FF);

    return Scaffold(
      backgroundColor: kBg,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kDark),
          onPressed: () => Navigator.maybePop(context),
        ),
        titleSpacing: 0,
        title: Text(
          'Generated Report',
          style: playfair(20, w: FontWeight.w500, c: kDark),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: kDark, size: 26),
            tooltip: 'Report History',
            onPressed: () => _showSnackBar(context, 'Viewing report history'),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Light green confirmation banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F4EA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xFF34C759),
                      size: 22,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Report Generated Successfully !',
                        style: inter(
                          13,
                          w: FontWeight.w600,
                          c: const Color(0xFF2E9E53),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // White rounded summary card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x08000000),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEBF5FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.description_rounded,
                            color: Color(0xFF4BA3F2),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weekly Report',
                                style: playfair(
                                  18,
                                  w: FontWeight.w700,
                                  c: kDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Generated on\n25 Oct 2026, 11:30 AM',
                                style: inter(
                                  12,
                                  w: FontWeight.w400,
                                  c: const Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFF0F0F0),
                      ),
                    ),

                    // Row 1: Report Summary + Total Items
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Report Summary',
                                  style: playfair(
                                    16,
                                    w: FontWeight.w700,
                                    c: kDark,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Period:\n19 Oct – 25 Oct 2026',
                                  style: inter(
                                    12,
                                    w: FontWeight.w400,
                                    c: const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: _MetricTile(
                            backgroundColor: Color(0xFFE3F2FD),
                            icon: Icons.inventory_2_outlined,
                            iconColor: Color(0xFF1E4FA1),
                            label: 'Total Items',
                            value: '120',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Row 2: Near Expiry + Low Stock
                    const Row(
                      children: [
                        Expanded(
                          child: _MetricTile(
                            backgroundColor: Color(0xFFF6F6F6),
                            icon: Icons.timelapse_rounded,
                            iconColor: Color(0xFFE53935),
                            label: 'Near Expiry',
                            value: '7',
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _MetricTile(
                            backgroundColor: Color(0xFFFEF6DC),
                            icon: Icons.warning_amber_rounded,
                            iconColor: Color(0xFFE6A800),
                            label: 'Low Stock',
                            value: '8',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Row 3: Stock In + Stock Out
                    const Row(
                      children: [
                        Expanded(
                          child: _MetricTile(
                            backgroundColor: Color(0xFFE6F3EA),
                            icon: Icons.inventory_2_outlined,
                            iconColor: Color(0xFF374151),
                            label: 'Stock In',
                            value: '+45',
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _MetricTile(
                            backgroundColor: Color(0xFFFCE8E8),
                            icon: Icons.inventory_2_outlined,
                            iconColor: Color(0xFF374151),
                            label: 'Stock Out',
                            value: '-32',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // AI key findings
              const _AiPillBadge(
                label: 'AI key findings',
                borderColor: purpleAccent,
                backgroundColor: purpleBg,
              ),
              const SizedBox(height: 10),
              Text(
                'Dermal filler use increased 32% compared with last week, alongside weekend bookings. Glove use remains steady, with around three weeks of stock remaining.',
                style: inter(
                  13,
                  w: FontWeight.w400,
                  c: const Color(0xFF4B5563),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE5E7EB),
                ),
              ),

              // AI recommended actions
              const _AiPillBadge(
                label: 'AI recommended actions',
                borderColor: purpleAccent,
                backgroundColor: purpleBg,
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•  ',
                    style: inter(14, w: FontWeight.w700, c: kDark),
                  ),
                  Expanded(
                    child: Text(
                      'Reorder 8 boxes of HA Dermal Filler and 10 packs of Sterile Gauze',
                      style: inter(
                        13,
                        w: FontWeight.w400,
                        c: const Color(0xFF4B5563),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Full-width dark pill Download Report button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () =>
                      _showSnackBar(context, 'Weekly Report downloaded.'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kDark,
                    foregroundColor: kWhite,
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  icon: const Icon(
                    Icons.file_download_outlined,
                    size: 20,
                    color: kWhite,
                  ),
                  label: Text(
                    'Download Report',
                    style: inter(14, w: FontWeight.w600, c: kWhite),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _MetricTile({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 26, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: inter(
                    12,
                    w: FontWeight.w400,
                    c: const Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: inter(20, w: FontWeight.w700, c: kDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiPillBadge extends StatelessWidget {
  final String label;
  final Color borderColor;
  final Color backgroundColor;

  const _AiPillBadge({
    required this.label,
    required this.borderColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Text(
        label,
        style: inter(11, w: FontWeight.w500, c: borderColor),
      ),
    );
  }
}

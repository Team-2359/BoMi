import 'package:flutter/material.dart';

import '../theme.dart';
import 'generated_report_page.dart';

class BoMIInsightPage extends StatefulWidget {
  const BoMIInsightPage({super.key});

  @override
  State<BoMIInsightPage> createState() => _BoMIInsightPageState();
}

class _BoMIInsightPageState extends State<BoMIInsightPage> {
  bool _isWeekly = true;
  String _selectedMonth = 'Oct 2026';
  int _selectedBarIndex = 4; // Friday highlighted by default

  static const List<String> _dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const List<double> _weeklyValues = [
    0.58,
    0.42,
    0.50,
    0.64,
    0.72,
    0.88,
    0.08,
  ];
  static const List<double> _monthlyValues = [
    0.66,
    0.54,
    0.70,
    0.60,
    0.84,
    0.76,
    0.18,
  ];

  void _openGeneratedReport() {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (_) => const GeneratedReportPage()),
    );
  }

  void _pickMonth() {
    const months = ['Aug 2026', 'Sep 2026', 'Oct 2026', 'Nov 2026'];
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
                Text(
                  'Select Month',
                  style: playfair(18, w: FontWeight.w700, c: kDark),
                ),
                const SizedBox(height: 12),
                ...months.map((month) {
                  final selected = _selectedMonth == month;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      month,
                      style: inter(
                        14,
                        w: selected ? FontWeight.w600 : FontWeight.w400,
                        c: kDark,
                      ),
                    ),
                    trailing: selected
                        ? const Icon(Icons.check_circle, color: kDark)
                        : null,
                    onTap: () {
                      setState(() => _selectedMonth = month);
                      Navigator.pop(sheetContext);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const purpleAccent = Color(0xFF8B5CF6);
    const purpleBg = Color(0xFFF3EFFE);
    final barValues = _isWeekly ? _weeklyValues : _monthlyValues;

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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
              decoration: const BoxDecoration(
                color: kWhite,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'BoMI Insight',
                    style: playfair(24, w: FontWeight.w700, c: kDark),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: purpleBg,
                      shape: BoxShape.circle,
                      border: Border.all(color: purpleAccent, width: 1),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'AI',
                      style: inter(11, w: FontWeight.w600, c: kDark),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subtitle
                    Text(
                      'Invoice Insight',
                      style: inter(
                        13,
                        w: FontWeight.w400,
                        c: const Color(0xFF8E8E93),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Weekly / Monthly segmented control
                    Container(
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
                              onTap: () => setState(() => _isWeekly = true),
                              child: Container(
                                height: 38,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: _isWeekly ? kDark : Colors.transparent,
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: Text(
                                  'Weekly',
                                  style: inter(
                                    13,
                                    w: _isWeekly
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    c: _isWeekly ? kWhite : kDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _isWeekly = false),
                              child: Container(
                                height: 38,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: !_isWeekly
                                      ? kDark
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: Text(
                                  'Monthly',
                                  style: inter(
                                    13,
                                    w: !_isWeekly
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    c: !_isWeekly ? kWhite : kDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Date range + Month selector pill
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _isWeekly
                              ? 'This week: 12–16 Oct'
                              : 'Period: 1–31 Oct',
                          style: inter(
                            12,
                            w: FontWeight.w400,
                            c: const Color(0xFF4B5563),
                          ),
                        ),
                        GestureDetector(
                          onTap: _pickMonth,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x05000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_outlined,
                                  size: 18,
                                  color: kDark,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _selectedMonth,
                                  style: inter(
                                    12,
                                    w: FontWeight.w400,
                                    c: const Color(0xFF4B5563),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 18,
                                  color: kDark,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // 3 KPI Metric Cards: Units used, Near expiry, Below min
                    Row(
                      children: [
                        Expanded(
                          child: _InsightMetricCard(
                            value: _isWeekly ? '67' : '248',
                            valueColor: kDark,
                            label: 'Units used',
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: _InsightMetricCard(
                            value: '6',
                            valueColor: Color(0xFFE69D00),
                            label: 'Near expiry',
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: _InsightMetricCard(
                            value: '7',
                            valueColor: Color(0xFFFF2D20),
                            label: 'Below min',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Usage trend bar chart card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x05000000),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usage trend',
                            style: inter(
                              13,
                              w: FontWeight.w500,
                              c: const Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 82,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(barValues.length, (
                                index,
                              ) {
                                final isHighlighted =
                                    index == _selectedBarIndex;
                                final isSunday = index == 6;
                                Color barColor;
                                if (isHighlighted) {
                                  barColor = const Color(0xFF568B8E);
                                } else if (isSunday) {
                                  barColor = const Color(0xFFE5E7EB);
                                } else {
                                  barColor = const Color(0xFFD9EDF8);
                                }

                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedBarIndex = index),
                                  child: Container(
                                    width: 18,
                                    height: 78 * barValues[index],
                                    decoration: BoxDecoration(
                                      color: barColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const Divider(
                            height: 8,
                            thickness: 1,
                            color: Color(0xFFF3F4F6),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: _dayLabels.map((day) {
                              return SizedBox(
                                width: 18,
                                child: Text(
                                  day,
                                  textAlign: TextAlign.center,
                                  style: inter(
                                    10,
                                    w: FontWeight.w400,
                                    c: const Color(0xFF9CA3AF),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // AI Summary purple card
                    const _AiInsightBox(
                      badgeLabel: 'AI Summary',
                      bodyText: 'Filler use up 67% vs last week',
                    ),
                    const SizedBox(height: 10),

                    // AI Recommendation purple card
                    const _AiInsightBox(
                      badgeLabel: 'AI Recommendation',
                      bodyText: 'Reorder botulinum toxin and cleansing foam.',
                    ),
                    const SizedBox(height: 10),

                    // Disclaimer row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Icon(
                            Icons.info_outline,
                            size: 16,
                            color: Color(0xFF34C759),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'All figures are calculated by BoMI from your stock log. The AI only explains them',
                            style: inter(
                              11,
                              w: FontWeight.w400,
                              c: const Color(0xFF6B7280),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Right-aligned Draft inventory report button
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        onPressed: _openGeneratedReport,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: kWhite,
                          foregroundColor: kDark,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          side: const BorderSide(
                            color: Color(0xFF4B5563),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: const Icon(
                          Icons.description_outlined,
                          size: 18,
                          color: kDark,
                        ),
                        label: Text(
                          'Draft inventory report',
                          style: inter(
                            12,
                            w: FontWeight.w400,
                            c: const Color(0xFF4B5563),
                          ),
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
}

class _InsightMetricCard extends StatelessWidget {
  final String value;
  final Color valueColor;
  final String label;

  const _InsightMetricCard({
    required this.value,
    required this.valueColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: playfair(28, w: FontWeight.w700, c: valueColor),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: inter(11, w: FontWeight.w400, c: const Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }
}

class _AiInsightBox extends StatelessWidget {
  final String badgeLabel;
  final String bodyText;

  const _AiInsightBox({required this.badgeLabel, required this.bodyText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3EFFE),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF9F7AEA), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeLabel,
              style: inter(10, w: FontWeight.w600, c: kWhite),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            bodyText,
            style: inter(11, w: FontWeight.w400, c: const Color(0xFF4B5563)),
          ),
        ],
      ),
    );
  }
}

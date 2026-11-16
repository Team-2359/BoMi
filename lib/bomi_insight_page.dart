import 'package:flutter/material.dart';

import '../theme.dart';

class BoMIInsightPage extends StatefulWidget {
  const BoMIInsightPage({super.key});

  @override
  State<BoMIInsightPage> createState() => _BoMIInsightPageState();
}

class _BoMIInsightPageState extends State<BoMIInsightPage> {
  bool weekly = true;

  static const purple = Color(0xFF8956E8);
  static const palePurple = Color(0xFFF1EAFE);

  BoxDecoration get _cardDecoration => BoxDecoration(
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
                    Text(
                      'BoMI Insight',
                      style: playfair(26, w: FontWeight.w700),
                    ),
                    const SizedBox(width: 9),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: palePurple,
                        border: Border.all(color: purple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'AI',
                        style: inter(11, w: FontWeight.w700, c: kDark),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 96),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Invoice insight',
                      style: inter(12, c: Colors.black54),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: _cardDecoration,
                      child: Row(
                        children: [
                          _periodButton('Weekly', true),
                          _periodButton('Monthly', false),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 9,
                      ),
                      decoration: _cardDecoration,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              weekly ? 'This week: 12-16 Oct' : 'October 2026',
                              style: inter(12, w: FontWeight.w500, c: kDark),
                            ),
                          ),
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 18,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 6),
                          Text('Oct 2026', style: inter(12, c: Colors.black54)),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: kDark,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      children: [
                        Expanded(
                          child: InsightStat(
                            value: '67',
                            label: 'Units used',
                            color: kDark,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InsightStat(
                            value: '6',
                            label: 'Near expiry',
                            color: Color(0xFFF0A000),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InsightStat(
                            value: '7',
                            label: 'Below min',
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                      decoration: _cardDecoration,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usage trend',
                            style: inter(14, w: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          const SizedBox(
                            height: 70,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                UsageBar(height: 34, day: 'M'),
                                UsageBar(height: 25, day: 'T'),
                                UsageBar(height: 29, day: 'W'),
                                UsageBar(height: 36, day: 'T'),
                                UsageBar(height: 42, day: 'F', active: true),
                                UsageBar(height: 48, day: 'S'),
                                UsageBar(height: 6, day: 'S', muted: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const AIInsightCard(
                      label: 'AI Summary',
                      message: 'Filler use up 67% vs last week',
                    ),
                    const SizedBox(height: 8),
                    const AIInsightCard(
                      label: 'AI Recommendation',
                      message: 'Reorder botulinum toxin and cleansing foam.',
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 15,
                            color: Color(0xFF4CAF50),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'All figures are calculated by BoMI from your stock log. The AI only explains them.',
                              style: inter(
                                11,
                                c: Colors.black54,
                              ).copyWith(height: 1.25),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.description_outlined,
                            size: 17,
                            color: kDark,
                          ),
                          label: Text(
                            'Draft inventory report',
                            style: inter(12, w: FontWeight.w600, c: kDark),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: kWhite,
                            foregroundColor: kDark,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 7,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            side: const BorderSide(color: Colors.black26),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
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

  Widget _periodButton(String label, bool isWeekly) {
    final selected = weekly == isWeekly;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            weekly = isWeekly;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? kDark : Colors.transparent,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: inter(13, w: FontWeight.w600, c: selected ? kWhite : kDark),
          ),
        ),
      ),
    );
  }
}

class InsightStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const InsightStat({
    super.key,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: playfair(30, w: FontWeight.w700, c: color),
          ),
          Text(label, style: inter(11, c: Colors.black54)),
        ],
      ),
    );
  }
}

class UsageBar extends StatelessWidget {
  final double height;
  final String day;
  final bool active;
  final bool muted;

  const UsageBar({
    super.key,
    required this.height,
    required this.day,
    this.active = false,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 16,
          height: height,
          decoration: BoxDecoration(
            color: muted
                ? const Color(0xFFEEEEEE)
                : active
                ? const Color(0xFF579A9B)
                : const Color(0xFFDCEFF8),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          day,
          style: inter(11, w: FontWeight.w500, c: Colors.black54),
        ),
      ],
    );
  }
}

class AIInsightCard extends StatelessWidget {
  final String label;
  final String message;

  const AIInsightCard({super.key, required this.label, required this.message});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF8956E8);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EAFE),
        border: Border.all(color: purple, width: 0.8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: purple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: inter(11, w: FontWeight.w600, c: kWhite),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: inter(12, w: FontWeight.w500, c: Colors.black87),
          ),
        ],
      ),
    );
  }
}

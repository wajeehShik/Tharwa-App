import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:thrawa_app/controllers/statistics/statistics_controller.dart';
import 'package:thrawa_app/utils/theme/app_colors.dart';
import 'package:thrawa_app/screens/home/widgets/home_header.dart';
import 'package:thrawa_app/controllers/home/home_controller.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:thrawa_app/widgets/count_up_text.dart';

class StatisticsScreen extends GetView<StatisticsController> {
  final bool showScaffold;
  const StatisticsScreen({super.key, this.showScaffold = true});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final homeController = Get.find<HomeController>();

    Widget content = Container(
      color: AppColors.background,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 50.h),
                Text(
                      'أرشيف الإحصائيات',
                      style: GoogleFonts.cairo(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideX(begin: -0.1, end: 0),
                Text(
                      'حلل توزيع مواردك وحسن تقدمك في اللعبة.',
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 500.ms, delay: 100.ms)
                    .slideX(begin: -0.1, end: 0),
                SizedBox(height: 25.h),

                _buildExpenseClassificationCard()
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .slideY(begin: 0.1, end: 0),
                SizedBox(height: 20.h),
                _buildResourceDistributionCard()
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 300.ms)
                    .slideY(begin: 0.1, end: 0),
                SizedBox(height: 20.h),
                _buildTacticalAlertCard()
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 400.ms)
                    .slideY(begin: 0.1, end: 0),
                SizedBox(height: 20.h),
                _buildWeeklyFlowCard()
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 500.ms)
                    .slideY(begin: 0.1, end: 0),
                SizedBox(height: 20.h),
                _buildStorageRecordHeader()
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 600.ms)
                    .slideY(begin: 0.1, end: 0),
                SizedBox(height: 10.h),
                _buildTransactionList()
                    .animate()
                    .fadeIn(duration: 600.ms, delay: 700.ms)
                    .slideY(begin: 0.1, end: 0),
                SizedBox(height: 100.h),
              ]),
            ),
          ),
        ],
      ),
    );

    if (!showScaffold) return content;

    return Scaffold(backgroundColor: AppColors.background, body: content);
  }

  Widget _buildExpenseClassificationCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تصنيف المصروفات',
            style: GoogleFonts.cairo(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                flex: 65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CountUpText(
                      value: 65,
                      suffix: '%',
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2563EB), // Blue for Needs
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      height: 12.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                        ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6.r),
                          bottomRight: Radius.circular(6.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2563EB).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ).animate().shimmer(
                      duration: const Duration(seconds: 2),
                      delay: const Duration(seconds: 1),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'احتياجات',
                      style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                flex: 35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CountUpText(
                      value: 35,
                      suffix: '%',
                      style: GoogleFonts.cairo(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF59E0B), // Amber for Luxuries
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      height: 12.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.r),
                          bottomLeft: Radius.circular(6.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF59E0B).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ).animate().shimmer(
                      duration: const Duration(seconds: 2),
                      delay: const Duration(milliseconds: 1500),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'كماليات',
                      style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResourceDistributionCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'توزيع الموارد',
                style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h),
          SizedBox(
            height: 200.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 6,
                    centerSpaceRadius: 65.r,
                    sections: [
                      PieChartSectionData(
                        value: 40,
                        color: const Color(0xFF10B981), // Emerald
                        radius: 20.r,
                        showTitle: false,
                        badgeWidget: _buildPieBadge(
                          Icons.restaurant,
                          const Color(0xFF10B981),
                        ),
                        badgePositionPercentageOffset: 1.1,
                      ),
                      PieChartSectionData(
                        value: 35,
                        color: const Color(0xFF6366F1), // Indigo
                        radius: 20.r,
                        showTitle: false,
                        badgeWidget: _buildPieBadge(
                          Icons.home,
                          const Color(0xFF6366F1),
                        ),
                        badgePositionPercentageOffset: 1.1,
                      ),
                      PieChartSectionData(
                        value: 25,
                        color: const Color(0xFFF59E0B), // Amber
                        radius: 20.r,
                        showTitle: false,
                        badgeWidget: _buildPieBadge(
                          Icons.videogame_asset,
                          const Color(0xFFF59E0B),
                        ),
                        badgePositionPercentageOffset: 1.1,
                      ),
                    ],
                  ),
                ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'إجمالي الخارج',
                      style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    CountUpText(
                      value: 842,
                      suffix: ' ريال',
                      style: GoogleFonts.cairo(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          _buildDistributionItem('المعيشة (طعام)', 40, const Color(0xFF10B981)),
          SizedBox(height: 12.h),
          _buildDistributionItem('المسكن والمقر', 35, const Color(0xFF6366F1)),
          SizedBox(height: 12.h),
          _buildDistributionItem('ترفيه', 25, const Color(0xFFF59E0B)),
        ],
      ),
    );
  }

  Widget _buildPieBadge(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 4)],
        border: Border.all(color: color, width: 1.5),
      ),
      child: Icon(icon, color: color, size: 12.sp),
    );
  }

  Widget _buildDistributionItem(String label, int percentage, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 14.r,
            height: 14.r,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: color.withOpacity(0.4), blurRadius: 6),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          CountUpText(
            value: percentage.toDouble(),
            suffix: '%',
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTacticalAlertCard() {
    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFECFDF5), Colors.white],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                'تنبيه تكتيكي',
                style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            'لقد خصصت 40% من مواردك للمعيشة.',
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primary.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: AppColors.primary, size: 18.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'هذا يعني تأخر مستويين في مهمة صندوق الطوارئ.',
                    style: GoogleFonts.cairo(
                      fontSize: 13.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyFlowCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'التدفق الأسبوعي',
                style: GoogleFonts.cairo(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  _buildLegendItem(
                    'مصروف',
                    const Color(0xFFEF4444),
                  ), // Red for Expense
                  SizedBox(width: 12.w),
                  _buildLegendItem(
                    'ادخار',
                    AppColors.primary,
                  ), // Green for Savings
                ],
              ),
            ],
          ),
          SizedBox(height: 35.h),
          SizedBox(
            height: 220.h,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => AppColors.textPrimary,
                    tooltipPadding: EdgeInsets.all(8.r),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toInt()}%',
                        GoogleFonts.cairo(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'اثنين',
                          'ثلاثاء',
                          'أربعاء',
                          'خميس',
                          'جمعة',
                          'سبت',
                          'أحد',
                        ];
                        return Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            days[value.toInt() % 7],
                            style: GoogleFonts.cairo(
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine:
                      (value) =>
                          FlLine(color: AppColors.background, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeGroupData(0, 40, 60),
                  _makeGroupData(1, 55, 45),
                  _makeGroupData(2, 30, 70),
                  _makeGroupData(3, 50, 50),
                  _makeGroupData(4, 20, 80),
                  _makeGroupData(5, 75, 25),
                  _makeGroupData(6, 40, 60),
                ],
              ),
            ).animate().slideY(
              begin: 0.1,
              end: 0,
              duration: 800.ms,
              curve: Curves.easeOutCirc,
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 6,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: const Color(0xFFEF4444), // Expense
          width: 10.w,
          borderRadius: BorderRadius.circular(6.r),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: AppColors.background,
          ),
        ),
        BarChartRodData(
          toY: y2,
          color: AppColors.primary, // Savings
          width: 10.w,
          borderRadius: BorderRadius.circular(6.r),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: AppColors.background,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10.r,
          height: 10.r,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.3), blurRadius: 4),
            ],
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 12.sp,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStorageRecordHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Text(
        'سجل المخزون',
        style: GoogleFonts.cairo(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.recentTransactions.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final tx = controller.recentTransactions[index];
          return _buildTransactionItem(tx)
              .animate()
              .fadeIn(delay: (index * 100).ms)
              .slideX(begin: 0.05, end: 0);
        },
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> tx) {
    IconData icon;
    Color iconColor;
    switch (tx['category']) {
      case 'living':
        icon = Icons.restaurant;
        iconColor = const Color(0xFF10B981);
        break;
      case 'housing':
        icon = Icons.home;
        iconColor = const Color(0xFF6366F1);
        break;
      case 'entertainment':
        icon = Icons.videogame_asset;
        iconColor = const Color(0xFFF59E0B);
        break;
      default:
        icon = Icons.category;
        iconColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx['title'],
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${tx['transactions']} معاملة',
                  style: GoogleFonts.cairo(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CountUpText(
                value: tx['amount'].toDouble().abs(),
                prefix: '- ',
                suffix: ' ريال',
                decimalPlaces: 2,
                style: GoogleFonts.cairo(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                tx['status'],
                style: GoogleFonts.cairo(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: _getStatusColor(tx['status']),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status.contains('عالٍ')) return const Color(0xFFEF4444);
    if (status.contains('متوقع')) return const Color(0xFF3B82F6);
    if (status.contains('الحدود')) return const Color(0xFF10B981);
    return AppColors.textSecondary;
  }
}

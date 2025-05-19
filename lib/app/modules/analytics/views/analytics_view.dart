import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:visit_tracker/app/data/model/activity_response.dart';
import 'package:visit_tracker/app/modules/analytics/models/sf_data.dart';
import 'package:visit_tracker/app/utils/resources/data_state.dart';

import '../../../dimens/dimens.dart';
import '../controllers/analytics_controller.dart';
import '../models/chart_data.dart';

class AnalyticsView extends GetView<AnalyticsController> {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analysis'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Obx(() {
          var activities = controller.activities.value;
          final chartData = controller.buildChartData(activities.data!);
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today, ${controller.currentDay}',
                    style: AppTextStyles.subHeaderStyle,
                  ),
                  _buildReportPeriod(context),
                ],
              ),
              Expanded(
                flex: 9,
                child:
                    activities is Success
                        ? SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildReportSection(activities.data!),
                              mediumVerticalSpacing,
                              _buildDailyReportSection(chartData),
                              Text(
                                'Counts',
                                style: AppTextStyles.largeSubHeaderStyle,
                              ),
                              StaggeredGrid.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                children: [
                                  ...controller.statusCount.entries.map(
                                    (entry) => _buildCountSection(
                                      entry.key,
                                      entry.value,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                        : activities is Error
                        ? Center(
                          child: Text(activities.error ?? "An error occurred"),
                        )
                        : activities is Initial
                        ? const Center(child: CircularProgressIndicator())
                        : const Center(child: Text("No activity")),
              ),
            ],
          );
        }),
      ),
    );
  }

  _buildReportPeriod(context) {
    return DropdownButton<String>(
      value: controller.reportPeriod.value,
      icon: const Icon(Icons.arrow_drop_down_rounded),
      elevation: 0,
      iconSize: 24,
      underline: Container(),
      dropdownColor:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.grey
              : Color(0xffF2F2F2),
      items:
          <String>[
            'Monthly',
            'Weekly',
            'Daily',
            'All',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem(value: value, child: Text(value));
          }).toList(),
      onChanged: (String? newValue) {
        controller.reportPeriod.value = newValue!;
        if (newValue == 'Weekly') {
          // controller.getWeeklyReport();
        } else if (newValue == 'Monthly') {
          // controller.getMonthlyReport();
        } else if (newValue == 'All') {
          // controller.getDailyReport();
        } else {
          //tod0
        }
      },
    );
  }

  _buildReportSection(List<ActivityResponse>? activity) {
    return Obx(() {
      final chartData =
          controller.statusCount.entries
              .map((e) => ChartData(e.key, e.value))
              .toList();

      return Container(
        alignment: Alignment.center,
        width: 350,
        height: 250,
        child: SfCircularChart(
          legend: Legend(isVisible: true, position: LegendPosition.right),
          series: <CircularSeries>[
            DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.status,
              yValueMapper: (ChartData data, _) => data.count,
              radius: '100%',
              strokeColor: Colors.white,
              strokeWidth: 2,
              explode: true,
            ),
          ],
        ),
      );
    });
  }

  _buildDailyReportSection(List<SfData> chartData) {
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        series: <CartesianSeries>[
          StackedColumn100Series<SfData, String>(
            dataSource: chartData,
            xValueMapper: (SfData data, _) => data.x,
            yValueMapper: (SfData data, _) => data.complete,
            name: 'Complete',
            width: 0.8,
            spacing: 0.2,
          ),
          StackedColumn100Series<SfData, String>(
            dataSource: chartData,
            xValueMapper: (SfData data, _) => data.x,
            yValueMapper: (SfData data, _) => data.pending,
            width: 0.8,
            spacing: 0.2,
          ),
          StackedColumn100Series<SfData, String>(
            dataSource: chartData,
            xValueMapper: (SfData data, _) => data.x,
            yValueMapper: (SfData data, _) => data.cancelled,
            width: 0.8,
            spacing: 0.2,
          ),
        ],
      ),
    );
  }

  _buildCountSection(String title, int count) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Column(children: [Text(title), Text("$count")]),
    );
  }
}

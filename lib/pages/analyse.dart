import 'package:assabil/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:assabil/pages/synchronization/animations/fade_in.dart';
import 'package:assabil/pages/synchronization/widgets/app_card.dart';


class DataAnalysisScreen extends StatelessWidget {
  const DataAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analyse des Données'),
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FadeInAnimation(
                delay: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Statistiques des Ordres",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppCard(
                      height: 300,
                      child: PieChart(
                        PieChartData(
                          sections: showingSections(),
                          centerSpaceRadius: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              FadeInAnimation(
                delay: 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Photos GSM et Ordres Saisis / Non Saisis",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppCard(
                      height: 300,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceEvenly,
                          maxY: 20,
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 28,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: bottomTitles,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: barGroups(),
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
    );
  }

  List<PieChartSectionData> showingSections() {
    return [
      PieChartSectionData(
        color: Colors.green,
        value: 60,
        title: 'Saisis',
        radius: 60,
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: 40,
        title: 'Non Saisis',
        radius: 60,
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Photos GSM', style: style);
        break;
      case 1:
        text = Text('Ordres Saisis', style: style);
        break;
      case 2:
        text = Text('Ordres Non Saisis', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, // top spacing
      child: text,
    );
  }

  List<BarChartGroupData> barGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 15,
            color: Colors.blue,
            width: 22,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.blue.withOpacity(0.2),
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 12,
            color: Colors.green,
            width: 22,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.green.withOpacity(0.2),
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 8,
            color: Colors.red,
            width: 22,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.red.withOpacity(0.2),
            ),
          ),
        ],
      ),
    ];
  }
}
import 'package:covid_tracker/models/ModelList.dart';
import 'package:covid_tracker/services/utilities/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'countries_list.dart';
import 'splash_screen.dart';
class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController _controller=AnimationController(vsync: this,
      duration: const Duration(seconds: 3)
  )..repeat();

final colorList=<Color>[
  const Color(0xff4285F4),
  const Color(0xff1aa260),
  const Color(0xffde5246),
];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
          key: _scaffoldKey,
             body: SizedBox(
               height: mq.height,
               width: mq.width,
               child: Column(
                 children: [
                   SizedBox(height: 10,),
                   Expanded(
                     flex: 1,
                     child: Column(
                       children: [
                         SizedBox(height: 50,),
                         FutureBuilder(
                             future: StateServices.fetchWorldStateRecord(),
                             builder: (context,AsyncSnapshot<ModelList> snapshot) {
                               if(snapshot.hasData)
                                 {
                                  return Column(
                                    children: [
                                      PieChart(
                                        dataMap:  {
                                          "Total":double.parse(snapshot.data!.cases!.toString()),
                                          "Recover":double.parse(snapshot.data!.recovered.toString()),
                                          "Death":double.parse(snapshot.data!.deaths.toString()),
                                        },chartValuesOptions: ChartValuesOptions(
                                        showChartValuesInPercentage: true,
                                      ),
                                        animationDuration: Duration(milliseconds: 1200),
                                        chartType: ChartType.ring,
                                        colorList: colorList,
                                        legendOptions: LegendOptions(
                                          legendPosition: LegendPosition.left,
                                        ),
                                        chartRadius: MediaQuery.of(context).size.width /3.1,
                                      ),
                                      SizedBox(
                                        height: 450,
                                        child: SingleChildScrollView(
                                          child: Card(
                                            child:Column(
                                              children: [
                                                ReusebleRow(title: 'Total', value: snapshot.data!.cases.toString()),
                                                ReusebleRow(title: 'Recoverd', value: snapshot.data!.recovered.toString()),
                                                ReusebleRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                                ReusebleRow(title: 'TodayCases', value: snapshot.data!.todayCases.toString()),
                                                ReusebleRow(title: 'TodayRecoverd', value: snapshot.data!.todayRecovered.toString()),
                                                ReusebleRow(title: 'TodayDeaths', value: snapshot.data!.todayDeaths.toString()),
                                                ReusebleRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                                ReusebleRow(title: 'Active', value: snapshot.data!.active.toString()),
                                                ReusebleRow(title: 'Tests', value: snapshot.data!.tests.toString()),
                                                ReusebleRow(title: 'Population', value: snapshot.data!.population.toString()),
                                                ReusebleRow(title: 'Update', value: snapshot.data!.updated.toString()),
                                                ReusebleRow(title: 'ActivePerOneMillion', value: snapshot.data!.activePerOneMillion.toString()),
                                                ReusebleRow(title: 'CasesPerOneMillion', value: snapshot.data!.casesPerOneMillion.toString()),
                                                ReusebleRow(title: 'DeathsPerOneMillion', value: snapshot.data!.deathsPerOneMillion.toString()),
                                                ReusebleRow(title: 'TestsPerOneMillion', value: snapshot.data!.testsPerOneMillion.toString()),




                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 60,),
                                      SizedBox(
                                        width: 350,
                                        height: 50,
                                        child: ElevatedButton(onPressed: (){
                                              Navigator.push(context, MaterialPageRoute( builder: (context) => CountriesList(),));
                                        },
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                                          child: const Text('Track Country',style: TextStyle(fontSize: 25,fontWeight:FontWeight.bold ),),
                                        ),
                                      )
                                    ],
                                  );
                                 }
                               else{
                                 return Expanded(
                                     flex: 1,
                                     child: SpinKitFadingCircle(
                                       controller: _controller,
                                       color: Colors.white,
                                       size: 50.0,
                                     )
                                 );
                               }
                             },
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
}
class ReusebleRow extends StatelessWidget {
  String title,value;
   ReusebleRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),

        ),
        const SizedBox(height: 20,),
        Divider(),
      ],
    );
  }
}

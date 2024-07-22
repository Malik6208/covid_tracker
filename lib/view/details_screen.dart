import 'package:covid_tracker/view/splash_screen.dart';
import 'package:covid_tracker/view/world_states.dart';
import 'package:flutter/material.dart';
class DetailsScreen extends StatefulWidget {
  String name,image,continent;
  int totalCases,totalDeaths,totalRecoverd,active,critical,todayRecoverd,tests,todayCases,casesPerOneMillion;
  int deathsPerOneMillion,testsPerOneMillion,population;

  DetailsScreen(
      {
        required this.continent,
        required this.population,
        required this.testsPerOneMillion,
        required this.deathsPerOneMillion,
        required this.casesPerOneMillion,
        required this.todayCases,
        required this.name,
        required this.image,
        required  this.totalCases,
        required this.totalDeaths,
        required  this.totalRecoverd,
        required this.active,
        required this.critical,
        required this.todayRecoverd,
        required this.tests});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(),
      body: SizedBox(
        height: mq.height,
        width: mq.width,
        child: Column(
          children: [
            SizedBox(height: 40,),
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),

            ),
            Text(widget.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            Text(widget.continent,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 20),),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 450,
                child: SingleChildScrollView(
                  child: Card(
                    child: Column(
                      children: [
                        ReusebleRow(title: 'Population', value: widget.population.toString()),
                        ReusebleRow(title: 'tests', value: widget.tests.toString()),
                        ReusebleRow(title: 'cases', value: widget.totalCases.toString()),
                        ReusebleRow(title: 'TotalRecovered', value: widget.totalRecoverd.toString()),
                        ReusebleRow(title: 'TotalDeaths', value: widget.totalDeaths.toString()),
                        ReusebleRow(title: 'Active', value: widget.active.toString()),
                        ReusebleRow(title: 'Critical', value: widget.critical.toString()),
                        ReusebleRow(title: 'TodayRecovered', value: widget.todayRecoverd.toString()),
                        ReusebleRow(title: 'TodayCases', value: widget.todayCases.toString()),
                        ReusebleRow(title: 'CasesPerOneMillion', value: widget.casesPerOneMillion.toString()),
                        ReusebleRow(title: 'DeathsPerOneMillion', value: widget.deathsPerOneMillion.toString()),
                        ReusebleRow(title: 'TestsPerOneMillion', value: widget.testsPerOneMillion.toString()),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}

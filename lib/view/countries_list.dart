import 'package:covid_tracker/services/utilities/api.dart';
import 'package:covid_tracker/view/details_screen.dart';
import 'package:covid_tracker/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> with TickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController _controller=AnimationController(vsync: this,
      duration: const Duration(seconds: 3)
  )..repeat();
  void dispose()
  {

    _controller.dispose();
    super.dispose();
  }
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
      body: SafeArea(
          child: SizedBox(
            height: mq.height,
            width: mq.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 8,bottom: 8),
                  child: TextFormField(
                        onChanged: (val){
                          setState(() {

                          });
                        },
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Countries With Name',
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blue),

                      ),
                    ),
                  ),
                ),
               Expanded(

                 child: FutureBuilder(future: StateServices.countriesList(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                    if(snapshot.hasData)
                    {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        //shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name=snapshot.data![index]['country'].toString();
                          if(searchController.text.isEmpty){
                            return Column(

                              children: [

                                ListTile(

                                  leading: CircleAvatar(

                                    backgroundImage: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    //maxRadius: 50.0,
                                  ),
                                  title: Text(snapshot.data![index]['country'].toString()),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return DetailsScreen(
                                          population: snapshot.data![index]['population'],
                                          continent: snapshot.data![index]['continent'],
                                          todayCases: snapshot.data![index]['todayCases'],
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          totalRecoverd: snapshot.data![index]['recovered'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          todayRecoverd: snapshot.data![index]['todayRecovered'],
                                          tests: snapshot.data![index]['tests'],
                                          casesPerOneMillion:snapshot.data![index]['casesPerOneMillion'] ,
                                          deathsPerOneMillion: snapshot.data![index]['deathsPerOneMillion'],
                                          testsPerOneMillion: snapshot.data![index]['testsPerOneMillion'],
                                      );
                                    },));
                                  },
                                )
                              ],
                            );
                          }else if(name.toLowerCase().contains(searchController.text.toLowerCase()))
                          {
                            return   Column(
                              children: [

                                ListTile(

                                  leading: CircleAvatar(

                                    backgroundImage: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    //maxRadius: 50.0,
                                  ),
                                  title: Text(snapshot.data![index]['country'].toString()),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return DetailsScreen(
                                          population: snapshot.data![index]['population'],
                                          todayCases: snapshot.data![index]['todayCases'],
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          totalRecoverd: snapshot.data![index]['recovered'],
                                          active: snapshot.data![index]['active'],
                                          critical: snapshot.data![index]['critical'],
                                          todayRecoverd: snapshot.data![index]['todayRecovered'],
                                          tests: snapshot.data![index]['tests'],
                                          casesPerOneMillion:snapshot.data![index]['casesPerOneMillion'],
                                          deathsPerOneMillion: snapshot.data![index]['deathsPerOneMillion'],
                                          testsPerOneMillion: snapshot.data![index]['testsPerOneMillion'],
                                          continent: snapshot.data![index]['continent'],
                                      );
                                    },));
                                  },
                                )
                              ],
                            );
                          }else{
                            return Container();
                          }

                        },);
                    }else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                                     ),
               )
              ],
            ),
          )
      ),
    );
  }
}

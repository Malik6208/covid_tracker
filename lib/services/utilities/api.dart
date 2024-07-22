import 'dart:convert';

import 'package:covid_tracker/models/ModelList.dart';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;
class StateServices{

  static Future <ModelList>fetchWorldStateRecord()async{
    final response= await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
    if(response.statusCode==200)
      {
        var data=jsonDecode(response.body);
        return ModelList.fromJson(data);
      }
    else{
     throw Exception('error');
    }
  }

  static Future <List<dynamic>>countriesList()async{
    var data;
    final response= await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if(response.statusCode==200)
    {
       data=jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('error');
    }
  }
}
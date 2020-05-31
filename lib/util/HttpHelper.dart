import 'dart:convert';
import 'dart:developer';

import 'package:flutterappdemo/model/BaseEntity.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  static Future<List<BaseEntity>> getByUrl(String url) async {
    List<BaseEntity> baseEntities = [];

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as List;
      for(var rd in responseData){
        BaseEntity be = new BaseEntity();
        be.name=rd['schoolName'];
        be.id = rd['schoolId'];
        baseEntities.add(be);
      }
      print(responseData);
    } catch (error) {
      log(error);
    }

    return baseEntities;
  }

  Future get(String url, var requestParam) async {
    /*try {
      final response = await http.get(fetchStudentByClassIdsUrl);
      final responseData = json.decode(response.body);

      cl.name = responseData['className'];
      cl.desc = responseData['classId'];
      classList.add(cl);
      classList.add(cl);
    } catch (error) {
      log(error);
    }*/
  }
}

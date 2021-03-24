import 'dart:convert';
import 'package:elite_provider/global/Global.dart';
import 'package:http/http.dart' as http;

class ServiceHttp{
  String BASE_URL = "https://eliteguardian.co.uk/api/";

  httpRequestPost(String url,{Map map,void onSuccess(value),void onError(value)}) async{
    var token = await Global.getToken();
    print(token);
    print(BASE_URL+url);
    var response= await http.post(
      BASE_URL+url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token.isNotEmpty?'Bearer $token':"",
      },
      body: map!=null?jsonEncode(map):null,
    );
    if (response.statusCode == 200 || response.statusCode == 201)
    {
        onSuccess(response.body);
    }
    else
     {
      onError(response.body);
    }
  }

  httpRequestGet(String url,{void onSuccess(value),void onError(value)}) async{
    var token = await Global.getToken();
    if(token.isNotEmpty)
      print(BASE_URL+url);
    var response= await http.get(
      BASE_URL+url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token.isNotEmpty?'Bearer $token':"",
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201)
    {
      onSuccess(response.body);
    }
    else
    {
      onError(response.body);
    }
  }
}
import 'dart:convert';
import 'package:elite_provider/global/Global.dart';
import 'package:http/http.dart' as http;

class ServiceHttp{
  static const  String BASE_URL = "eliteguardian.co.uk";

  httpRequestPost(String url1,{Map map,void onSuccess(value),void onError(value)}) async{
    var token = await Global.getToken();
    var url = Uri.https(BASE_URL, "/api/"+url1, {'q': '{http}'});
    var response= await http.post(url,
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

  httpRequestGet(String url1,{void onSuccess(value),void onError(value)}) async{
    var token = await Global.getToken();
    var url = Uri.https(BASE_URL, "/api/"+url1, {'q': '{http}'});
    var response= await http.get(url,
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
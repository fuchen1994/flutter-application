import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/toast.dart';

Future getAjax(url, stringParams, context) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String  cookies = 'JSESSIONID=${prefs.get('cookies')}';
  // String  cookies = 'JSESSIONID=9b2c3610-38fe-4541-8459-198333436af2';
  try {
    Response response;
    Dio dio = new Dio();

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //   client.findProxy = (uri) {
    //     return "PROXY 192.168.10.120:8888";
    //   };
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) {
    //     return true;
    //   };
    // };

    String reqUrl;
     dio.options.baseUrl = serviceUrl;
     dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
     dio.options.headers['Cookie'] = cookies;
    if(stringParams == ''){
     reqUrl = servicePath[url];
    }else{
      reqUrl = servicePath[url] + stringParams;
    }
    print(reqUrl);
    response = await dio.get(reqUrl);
    print(response);
    if(response.data == null || response.data == ''){
      return null;
    }
    if(response.data['code'] == 500) {
      Future.delayed(Duration(milliseconds: 10),(){
        Toast.toast(context, response.data['content']);
      });
    }else if(response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }else {
      return response.data;
    }
  }on DioError catch (e) {
    if (e.response != null && e.response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }
  }
}

Future postAjax(String url, Map<String, dynamic>params,  BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String  cookies = 'JSESSIONID=' +  prefs.get('cookies');
  try {
    print('获取数据');
    print(url);
    print(params);
    Response response;
    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.headers['Cookie'] = cookies;
    response = await dio.post(servicePath[url], data:params);
    if(response.data == null || response.data == ''){
      return null;
    }
    if(response.data['code'] == 500) {
      Future.delayed(Duration(milliseconds: 10),(){
        Toast.toast(context, response.data['content']);
      });
    }else if(response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }else{
      return response.data;
    }
    
  } on DioError catch (e) {
   if (e.response != null && e.response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }
  }
}

Future getAjaxStr(url, stringParams, context) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String  cookies = 'JSESSIONID=' +  prefs.get('cookies');
  try {
    Response response;
    Dio dio = new Dio();
    String reqUrl;
    dio.options.baseUrl = serviceUrl;
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.headers['Cookie'] = cookies;
    if(stringParams == ''){
     reqUrl = url;
    }else{
      reqUrl = url + stringParams;
    }
    print(reqUrl);
    response = await dio.get(reqUrl);
    print(response.data);
    if(response.data == null || response.data == ''){
      return null;
    }
    if(response.data['code'] == 500) {
      Future.delayed(Duration(milliseconds: 10),(){
        Toast.toast(context, response.data['content']);
      });
    }else if(response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }else{
      return response.data;
    }
    
    
  }on DioError catch (e) {
    if (e.response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }
  }
}

Future postAjaxStr(url, params, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String  cookies = 'JSESSIONID=' +  prefs.get('cookies');
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.headers['Cookie'] = cookies;
    response = await dio.post(url, data:params);
    if(response.data == null || response.data == ''){
      return null;
    }
    if(response.data['code'] == 500) {
      Future.delayed(Duration(milliseconds: 10),(){
        Toast.toast(context, response.data['content']);
      });
    }else if(response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }else{
       return response.data;
    }
    
  } on DioError catch (e) {
   if (e.response != null && e.response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }
  }
}

Future uploaFile(url, FormData formData, context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String  cookies = 'JSESSIONID=' +  prefs.get('cookies');
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.baseUrl = serviceUrl;
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded");
    dio.options.headers['Cookie'] = cookies;
    response = await dio.post(servicePath[url], data:formData);
    if(response.data == null || response.data == ''){
      return null;
    }
    if(response.data['code'] == 500) {
      Future.delayed(Duration(milliseconds: 10),(){
        Toast.toast(context, response.data['content']);
      });
    }else if(response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }else{
      return response.data;
    }
    
  } on DioError catch (e) {
   if (e.response != null && e.response.data['code'] == 401) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route)=>false);
    }
  }
}
 
Widget commonFutureBuilder( Future _fecth, Widget pageWidget) {
  return FutureBuilder(
    future: _fecth,
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      print(snapshot.connectionState);
      switch (snapshot.connectionState) {
        case ConnectionState.none://-------请求态
            return loadingWidget();
        case ConnectionState.waiting://-------请求态
        print('waiting');
          return loadingWidget();
        case ConnectionState.done : //完成态
          print('done');
          return pageWidget;
          break;
        default:
        break;
      }
      return Container();
    },
  );
}

Widget loadingWidget() {
  return Stack(
    children: <Widget>[
      Opacity(
        opacity: 0.3,
        child: new ModalBarrier(color: Colors.black87),
      ),
      Center(
        child: CircularProgressIndicator(),
      )
    ],
  );
}

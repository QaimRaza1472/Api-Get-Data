import 'dart:convert';
import 'package:api_test/Constants/strings.dart';
import 'package:api_test/Model/image_flip.dart';
import 'package:http/http.dart' as http;


class Api_Manager{

  Future<ImageFlip> get_data() async {
    var client=http.Client();
    var flipModel=null;
    try{
      var response= await client.get(Strings.flip_url);
      var flipString=response.body;
      var flipMap=json.decode(flipString);
      flipModel=ImageFlip.fromJson(flipMap);
    }catch(Exception){
      return flipModel;
    }
    return flipModel;
  }

}
import 'package:asubrix/models/restraunts.dart';
import 'package:http/http.dart' as http;
class RemoteServices{
  Future<List<Restraunts>?> getPosts()async{
    var client  = http.Client();


    var uri = Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');
    var response = await client.get(uri);
     if(response.statusCode == 200){
       var json = response.body;
       print("debug 1 success");
       return restrauntsFromJson(json);
     }
  }
}
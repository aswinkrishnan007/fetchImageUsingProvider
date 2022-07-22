import 'package:fetch_image_with_provider/model/search_model.dart';
import 'package:fetch_image_with_provider/service/network_service.dart';
import 'package:fetch_image_with_provider/utils/internet_connectivity.dart';
import 'package:flutter/material.dart';

class MyHomeViewModel extends ChangeNotifier {
  bool loader = true;
  List<Hits> hits = [];
    List<Hits> favorite = [];
  bool isConnected=true;
loadData(BuildContext context, String name){
     internetConnectivity().then((value){
     isConnected=true;
     value?
     getSearch(context, name):isConnected  =false;
      notifyListeners();
     });
}

  Future getSearch(BuildContext context, String name) async {
     
    loader = true;
    var searchList = await NetworkService().get({}, context, name);

    SearchModel searchdata = SearchModel.fromJson(searchList);
    hits = searchdata.hits;

    loader = false;
    notifyListeners();
    return searchList;
  }
  addToFavorite(int index){
     favorite.add(hits[index]);
     notifyListeners();
  }
}

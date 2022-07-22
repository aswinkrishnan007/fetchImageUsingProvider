import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool>  internetConnectivity()async{
  var connectivityResult = await (Connectivity().checkConnectivity());
if (connectivityResult == ConnectivityResult.mobile) {
  // I am connected to a mobile network.
  return true;

} else if (connectivityResult == ConnectivityResult.wifi) {
  // I am connected to a wifi network.
 return true;
}
else{
return false;



}
}
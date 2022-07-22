
import 'package:fetch_image_with_provider/viewmodel/myhome_viewmodel.dart';
import 'package:get_it/get_it.dart';



GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  //Services should be register as lazy singleton. Services are shared across app

  //Viewmodles should be register as factory. Viewmodel instances are binded to its view.
  
  serviceLocator
      .registerFactory<MyHomeViewModel>(() => MyHomeViewModel());
}

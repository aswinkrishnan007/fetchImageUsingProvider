import 'package:fetch_image_with_provider/service/service_locator.dart';
import 'package:fetch_image_with_provider/utils/constants.dart';
import 'package:fetch_image_with_provider/view/favorite.dart';
import 'package:fetch_image_with_provider/view/listing_view.dart';

import 'package:fetch_image_with_provider/viewmodel/myhome_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final TextEditingController _controller = TextEditingController();

  final MyHomeViewModel _viewModel = serviceLocator<MyHomeViewModel>();
  @override
  void initState() {
    _viewModel.loadData(context, "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => _viewModel,
          child: Consumer<MyHomeViewModel>(builder: (context, model, child) {
            return Scaffold(
              backgroundColor: Colorconstants.colorF1EFFF,
              body: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchArea(context, model),
                    const SizedBox(height: 25),
                    !_viewModel.isConnected
                        ? noInternet(context)
                        : _viewModel.loader
                            ? const Center(child: CircularProgressIndicator())
                            : _viewModel.hits.isEmpty
                                ? noDataFound()
                                : ListingView(viewModel: _viewModel)
                  ],
                ),
              ),
              bottomNavigationBar: bottomBar(size),
            );
          }),
        ),
      ),
    );
  }

  Container bottomBar(Size size) {
    return Container(
      height: 75,
      width: size.width,
      color: Colorconstants.color9745FF,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("click on favorite icon ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 15,
                letterSpacing: 1,
              )),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  (MaterialPageRoute(
                      builder: (builder) => Favorite(viewModel: _viewModel))));
            },
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite,color: Colors.red,),
                  Text("favorite",
                      style: TextStyle(
                        color: Colorconstants.color1A059D,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 10,
                        letterSpacing: 1,
                      ))
                ],
              ),
            ),
          )
        ],
        
      ),
    );
  }

  Center noInternet(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () {
            _viewModel.loadData(context, "");
          },
          child: SizedBox(
              height: 50,
              child: Text(
                "No Internet\n retry !!",
                style: TextStyle(
                  color: Colorconstants.color1A059D,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 15,
                  letterSpacing: 1,
                ),
              ))),
    );
  }

  SizedBox noDataFound() {
    return SizedBox(
      child: Center(
        child: Text(
          "no data found !!",
          style: TextStyle(
            color: Colorconstants.color1A059D,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 15,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }

  Container searchArea(BuildContext context, MyHomeViewModel model) {
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colorconstants.color9745FF.withOpacity(.6),
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0)),
      ),
      child: Container(
          margin:
              const EdgeInsets.only(left: 15, right: 15, bottom: 25, top: 20),
          padding: const EdgeInsets.only(left: 0),
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Colorconstants.color1A059D.withOpacity(.52), width: 1),
            color: Colorconstants.colorFFFFFF,
          ),
          child: TextFormField(
            controller: _controller,
            onTap: () {},
            autofocus: false,
            cursorColor: Colorconstants.color1A059D,
            style: TextStyle(
              color: Colorconstants.color1A059D,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 15,
              letterSpacing: 1,
            ),
            decoration: InputDecoration(
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colorconstants.color1A059D,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colorconstants.color1A059D,
                    size: 15,
                  ),
                  onPressed: () {
                    _controller.clear();
                    _viewModel.getSearch(context, _controller.text);
                  },
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colorconstants.color1A059D,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
                border: InputBorder.none),
            onChanged: (value) {
              _viewModel.getSearch(context, _controller.text);
            },
          )),
    );
  }
}

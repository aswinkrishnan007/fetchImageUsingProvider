import 'package:cached_network_image/cached_network_image.dart';
import 'package:fetch_image_with_provider/utils/constants.dart';

import 'package:fetch_image_with_provider/viewmodel/myhome_viewmodel.dart';
import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({   Key? key,
    required MyHomeViewModel viewModel,
  })  : _viewModel = viewModel,
        super(key: key);
  final MyHomeViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
      
        child: ListView.builder(
          itemCount: _viewModel.favorite.length,
          itemBuilder: (context, index) {
            return singleCard(index);
          },
        ),
      ),
    );
  }

  Container singleCard(int index) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colorconstants.color1A059D)),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.red,
                 
                  borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                          imageUrl: _viewModel.favorite[index].userImageURL,
                          placeholder: (context, url) =>const Center(child: Icon(Icons.image),),
                          errorWidget: (context, url, error) =>const Center(child: Icon(Icons.image)),
                          fit: BoxFit.cover,
                       ),
                  ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              _viewModel.favorite[index].user,
              style: TextStyle(
                color: Colorconstants.color1A059D,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
  
  
          ],
        ),
        height: 100,
      );
  }
}
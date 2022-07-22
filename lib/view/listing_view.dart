import 'package:cached_network_image/cached_network_image.dart';
import 'package:fetch_image_with_provider/utils/constants.dart';
import 'package:fetch_image_with_provider/view/full_screen_page.dart';
import 'package:fetch_image_with_provider/viewmodel/myhome_viewmodel.dart';
import 'package:flutter/material.dart';

class ListingView extends StatefulWidget {
  const ListingView({
    Key? key,
    required MyHomeViewModel viewModel,
  })  : _viewModel = viewModel,
        super(key: key);

  final MyHomeViewModel _viewModel;

  @override
  State<ListingView> createState() => _ListingViewState();
}

class _ListingViewState extends State<ListingView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 150,
      child: ListView.builder(
        itemCount: widget._viewModel.hits.length,
        itemBuilder: (context, index) {
          return singleCard(context, index);
        },
      ),
    );
  }

  GestureDetector singleCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        navigateToFullScreen(context, index);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colorconstants.color1A059D)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: widget._viewModel.hits[index].userImageURL,
                  placeholder: (context, url) => const Center(
                    child: Icon(Icons.image),
                  ),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.image)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              widget._viewModel.hits[index].user,
              style: TextStyle(
                color: Colorconstants.color1A059D,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 15,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            GestureDetector(
                onTap: () {
                  widget._viewModel.addToFavorite(index);
                },
                child: Icon(
                  Icons.favorite_sharp,
                  color: widget._viewModel.favorite
                          .contains(widget._viewModel.hits[index])
                      ? Colors.red
                      : Colors.black,
                ))
          ],
        ),
        height: 100,
      ),
    );
  }

  Future<dynamic> navigateToFullScreen(BuildContext context, int index) {
    return Navigator.push(
        context,
        PageRouteBuilder(
          opaque: false,
          barrierColor: Colors.black,
          pageBuilder: (BuildContext context, _, __) {
            return FullScreenPage(
              child: CachedNetworkImage(
                imageUrl: widget._viewModel.hits[index].userImageURL,
                placeholder: (context, url) => const Center(
                  child: Icon(Icons.image),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.image)),
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      );
  }
}

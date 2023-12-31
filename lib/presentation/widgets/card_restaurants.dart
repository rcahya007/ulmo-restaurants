import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ulmo_restaurants/domain/entities/restaurants_response_model.dart';
import 'package:ulmo_restaurants/presentation/extensions/styles.dart';
import 'package:ulmo_restaurants/presentation/pages/detail_restaurant_page/detail_restaurant_page.dart';

class CardRestaurants extends StatelessWidget {
  const CardRestaurants({
    super.key,
    required this.restaurants,
  });

  final List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailRestaurantPage(
                    restaurant: restaurants[index],
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(
                bottom: 16,
              ),
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8,
                ),
                color: colorGray100,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 16,
                        right: 16,
                        bottom: 8,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.start,
                        children: [
                          Text(
                            restaurants[index].name,
                            style: heading2semi,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              RatingBar.builder(
                                ignoreGestures: true,
                                itemSize: 20,
                                initialRating:
                                    restaurants[index].rating,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                itemBuilder: (context, _) =>
                                    const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '${restaurants[index].rating}',
                                style: body2reg,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.location_on_sharp,
                                color: colorYellow500,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  restaurants[index].city,
                                  style: body2reg,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Hero(
                    tag: restaurants[index].pictureId,
                    child: Container(
                      width: 82,
                      decoration: BoxDecoration(
                        color: colorGray400,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            restaurants[index].pictureId,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

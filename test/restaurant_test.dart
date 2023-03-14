import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/models/restaurant.dart';

void main() {
  late RestaurantElement restaurant;

  setUp(() => {
        restaurant = RestaurantElement(
          id: "mockId",
          name: "mockName",
          description: "mockDescription",
          pictureId: "mockPictureId",
          city: "mockCity",
          rating: 5.0,
        )
      });

  group('fetchRestaurant', () {
    test(
      'should returns Restaurant if the json parsing completes successfully',
      () {
        var result = RestaurantElement.fromJson(restaurant.toJson());

        expect(result.id, restaurant.id);
        expect(result.name, restaurant.name);
        expect(result.description, restaurant.description);
        expect(result.pictureId, restaurant.pictureId);
        expect(result.city, restaurant.city);
        expect(result.rating, restaurant.rating);
      },
    );
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/models/restaurant.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([ApiService])
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

    test(
      "should returns Restaurants if the api call completes successfully",
      () async {
        final apiService = MockApiService();

        when(apiService.fetchList()).thenAnswer((_) async => Restaurants(
              error: false,
              message: "success",
              count: 1,
              restaurants: [restaurant],
              isFavorite: false,
            ));

        expect(await apiService.fetchList(), isA<Restaurants>());
      },
    );
  });
}

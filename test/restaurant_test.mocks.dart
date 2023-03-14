// Mocks generated by Mockito 5.3.2 from annotations
// in restaurant_app/test/restaurant_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:restaurant_app/data/api/api_service.dart' as _i5;
import 'package:restaurant_app/models/restaurant.dart' as _i2;
import 'package:restaurant_app/models/restaurant_detail.dart' as _i3;
import 'package:restaurant_app/models/restaurant_search.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRestaurants_0 extends _i1.SmartFake implements _i2.Restaurants {
  _FakeRestaurants_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRestaurantDetail_1 extends _i1.SmartFake
    implements _i3.RestaurantDetail {
  _FakeRestaurantDetail_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeRestaurantSearch_2 extends _i1.SmartFake
    implements _i4.RestaurantSearch {
  _FakeRestaurantSearch_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ApiService].
///
/// See the documentation for Mockito's code generation for more information.
class MockApiService extends _i1.Mock implements _i5.ApiService {
  MockApiService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Restaurants> fetchList() => (super.noSuchMethod(
        Invocation.method(
          #fetchList,
          [],
        ),
        returnValue: _i6.Future<_i2.Restaurants>.value(_FakeRestaurants_0(
          this,
          Invocation.method(
            #fetchList,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Restaurants>);
  @override
  _i6.Future<_i3.RestaurantDetail> fetchDetail(String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchDetail,
          [id],
        ),
        returnValue:
            _i6.Future<_i3.RestaurantDetail>.value(_FakeRestaurantDetail_1(
          this,
          Invocation.method(
            #fetchDetail,
            [id],
          ),
        )),
      ) as _i6.Future<_i3.RestaurantDetail>);
  @override
  _i6.Future<_i4.RestaurantSearch> fetchByQuery(String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchByQuery,
          [query],
        ),
        returnValue:
            _i6.Future<_i4.RestaurantSearch>.value(_FakeRestaurantSearch_2(
          this,
          Invocation.method(
            #fetchByQuery,
            [query],
          ),
        )),
      ) as _i6.Future<_i4.RestaurantSearch>);
}
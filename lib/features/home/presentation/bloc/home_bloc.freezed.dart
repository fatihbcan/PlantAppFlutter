// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeStarted value)?  started,TResult Function( HomeRefreshRequested value)?  refreshRequested,TResult Function( HomeSearchChanged value)?  searchChanged,TResult Function( HomeSearchCleared value)?  searchCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started(_that);case HomeRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case HomeSearchChanged() when searchChanged != null:
return searchChanged(_that);case HomeSearchCleared() when searchCleared != null:
return searchCleared(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeStarted value)  started,required TResult Function( HomeRefreshRequested value)  refreshRequested,required TResult Function( HomeSearchChanged value)  searchChanged,required TResult Function( HomeSearchCleared value)  searchCleared,}){
final _that = this;
switch (_that) {
case HomeStarted():
return started(_that);case HomeRefreshRequested():
return refreshRequested(_that);case HomeSearchChanged():
return searchChanged(_that);case HomeSearchCleared():
return searchCleared(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeStarted value)?  started,TResult? Function( HomeRefreshRequested value)?  refreshRequested,TResult? Function( HomeSearchChanged value)?  searchChanged,TResult? Function( HomeSearchCleared value)?  searchCleared,}){
final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started(_that);case HomeRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case HomeSearchChanged() when searchChanged != null:
return searchChanged(_that);case HomeSearchCleared() when searchCleared != null:
return searchCleared(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshRequested,TResult Function( String query)?  searchChanged,TResult Function()?  searchCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started();case HomeRefreshRequested() when refreshRequested != null:
return refreshRequested();case HomeSearchChanged() when searchChanged != null:
return searchChanged(_that.query);case HomeSearchCleared() when searchCleared != null:
return searchCleared();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshRequested,required TResult Function( String query)  searchChanged,required TResult Function()  searchCleared,}) {final _that = this;
switch (_that) {
case HomeStarted():
return started();case HomeRefreshRequested():
return refreshRequested();case HomeSearchChanged():
return searchChanged(_that.query);case HomeSearchCleared():
return searchCleared();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshRequested,TResult? Function( String query)?  searchChanged,TResult? Function()?  searchCleared,}) {final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started();case HomeRefreshRequested() when refreshRequested != null:
return refreshRequested();case HomeSearchChanged() when searchChanged != null:
return searchChanged(_that.query);case HomeSearchCleared() when searchCleared != null:
return searchCleared();case _:
  return null;

}
}

}

/// @nodoc


class HomeStarted implements HomeEvent {
  const HomeStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.started()';
}


}




/// @nodoc


class HomeRefreshRequested implements HomeEvent {
  const HomeRefreshRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.refreshRequested()';
}


}




/// @nodoc


class HomeSearchChanged implements HomeEvent {
  const HomeSearchChanged(this.query);
  

 final  String query;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeSearchChangedCopyWith<HomeSearchChanged> get copyWith => _$HomeSearchChangedCopyWithImpl<HomeSearchChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSearchChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'HomeEvent.searchChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $HomeSearchChangedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $HomeSearchChangedCopyWith(HomeSearchChanged value, $Res Function(HomeSearchChanged) _then) = _$HomeSearchChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$HomeSearchChangedCopyWithImpl<$Res>
    implements $HomeSearchChangedCopyWith<$Res> {
  _$HomeSearchChangedCopyWithImpl(this._self, this._then);

  final HomeSearchChanged _self;
  final $Res Function(HomeSearchChanged) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(HomeSearchChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HomeSearchCleared implements HomeEvent {
  const HomeSearchCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSearchCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.searchCleared()';
}


}




/// @nodoc
mixin _$HomeState {

 bool get isLoading; List<Question> get questions; List<Category> get categories; String get query; HomeFailure? get questionsFailure; HomeFailure? get categoriesFailure;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.questions, questions)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.query, query) || other.query == query)&&(identical(other.questionsFailure, questionsFailure) || other.questionsFailure == questionsFailure)&&(identical(other.categoriesFailure, categoriesFailure) || other.categoriesFailure == categoriesFailure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(questions),const DeepCollectionEquality().hash(categories),query,questionsFailure,categoriesFailure);

@override
String toString() {
  return 'HomeState(isLoading: $isLoading, questions: $questions, categories: $categories, query: $query, questionsFailure: $questionsFailure, categoriesFailure: $categoriesFailure)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<Question> questions, List<Category> categories, String query, HomeFailure? questionsFailure, HomeFailure? categoriesFailure
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? questions = null,Object? categories = null,Object? query = null,Object? questionsFailure = freezed,Object? categoriesFailure = freezed,}) {
  return _then(HomeState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,questionsFailure: freezed == questionsFailure ? _self.questionsFailure : questionsFailure // ignore: cast_nullable_to_non_nullable
as HomeFailure?,categoriesFailure: freezed == categoriesFailure ? _self.categoriesFailure : categoriesFailure // ignore: cast_nullable_to_non_nullable
as HomeFailure?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<Question> questions,  List<Category> categories,  String query,  HomeFailure? questionsFailure,  HomeFailure? categoriesFailure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.isLoading,_that.questions,_that.categories,_that.query,_that.questionsFailure,_that.categoriesFailure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<Question> questions,  List<Category> categories,  String query,  HomeFailure? questionsFailure,  HomeFailure? categoriesFailure)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.isLoading,_that.questions,_that.categories,_that.query,_that.questionsFailure,_that.categoriesFailure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<Question> questions,  List<Category> categories,  String query,  HomeFailure? questionsFailure,  HomeFailure? categoriesFailure)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.isLoading,_that.questions,_that.categories,_that.query,_that.questionsFailure,_that.categoriesFailure);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState extends HomeState {
  const _HomeState({this.isLoading = false,  List<Question> questions = const <Question>[],  List<Category> categories = const <Category>[], this.query = '', this.questionsFailure = null, this.categoriesFailure = null}): _questions = questions,_categories = categories,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<Question> _questions;
@override@JsonKey() List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

 final  List<Category> _categories;
@override@JsonKey() List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  String query;
@override@JsonKey() final  HomeFailure? questionsFailure;
@override@JsonKey() final  HomeFailure? categoriesFailure;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._questions, _questions)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.query, query) || other.query == query)&&(identical(other.questionsFailure, questionsFailure) || other.questionsFailure == questionsFailure)&&(identical(other.categoriesFailure, categoriesFailure) || other.categoriesFailure == categoriesFailure));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_questions),const DeepCollectionEquality().hash(_categories),query,questionsFailure,categoriesFailure);

@override
String toString() {
  return 'HomeState(isLoading: $isLoading, questions: $questions, categories: $categories, query: $query, questionsFailure: $questionsFailure, categoriesFailure: $categoriesFailure)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<Question> questions, List<Category> categories, String query, HomeFailure? questionsFailure, HomeFailure? categoriesFailure
});




}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? questions = null,Object? categories = null,Object? query = null,Object? questionsFailure = freezed,Object? categoriesFailure = freezed,}) {
  return _then(_HomeState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,questionsFailure: freezed == questionsFailure ? _self.questionsFailure : questionsFailure // ignore: cast_nullable_to_non_nullable
as HomeFailure?,categoriesFailure: freezed == categoriesFailure ? _self.categoriesFailure : categoriesFailure // ignore: cast_nullable_to_non_nullable
as HomeFailure?,
  ));
}


}

// dart format on

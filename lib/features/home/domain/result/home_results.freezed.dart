// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetCategoriesResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCategoriesResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetCategoriesResult()';
}


}

/// @nodoc
class $GetCategoriesResultCopyWith<$Res>  {
$GetCategoriesResultCopyWith(GetCategoriesResult _, $Res Function(GetCategoriesResult) __);
}


/// Adds pattern-matching-related methods to [GetCategoriesResult].
extension GetCategoriesResultPatterns on GetCategoriesResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GetCategoriesSuccess value)?  success,TResult Function( GetCategoriesNetwork value)?  network,TResult Function( GetCategoriesServer value)?  server,TResult Function( GetCategoriesParse value)?  parse,TResult Function( GetCategoriesUnknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GetCategoriesSuccess() when success != null:
return success(_that);case GetCategoriesNetwork() when network != null:
return network(_that);case GetCategoriesServer() when server != null:
return server(_that);case GetCategoriesParse() when parse != null:
return parse(_that);case GetCategoriesUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GetCategoriesSuccess value)  success,required TResult Function( GetCategoriesNetwork value)  network,required TResult Function( GetCategoriesServer value)  server,required TResult Function( GetCategoriesParse value)  parse,required TResult Function( GetCategoriesUnknown value)  unknown,}){
final _that = this;
switch (_that) {
case GetCategoriesSuccess():
return success(_that);case GetCategoriesNetwork():
return network(_that);case GetCategoriesServer():
return server(_that);case GetCategoriesParse():
return parse(_that);case GetCategoriesUnknown():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GetCategoriesSuccess value)?  success,TResult? Function( GetCategoriesNetwork value)?  network,TResult? Function( GetCategoriesServer value)?  server,TResult? Function( GetCategoriesParse value)?  parse,TResult? Function( GetCategoriesUnknown value)?  unknown,}){
final _that = this;
switch (_that) {
case GetCategoriesSuccess() when success != null:
return success(_that);case GetCategoriesNetwork() when network != null:
return network(_that);case GetCategoriesServer() when server != null:
return server(_that);case GetCategoriesParse() when parse != null:
return parse(_that);case GetCategoriesUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Category> categories)?  success,TResult Function()?  network,TResult Function( int statusCode)?  server,TResult Function()?  parse,TResult Function( Object? cause)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GetCategoriesSuccess() when success != null:
return success(_that.categories);case GetCategoriesNetwork() when network != null:
return network();case GetCategoriesServer() when server != null:
return server(_that.statusCode);case GetCategoriesParse() when parse != null:
return parse();case GetCategoriesUnknown() when unknown != null:
return unknown(_that.cause);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Category> categories)  success,required TResult Function()  network,required TResult Function( int statusCode)  server,required TResult Function()  parse,required TResult Function( Object? cause)  unknown,}) {final _that = this;
switch (_that) {
case GetCategoriesSuccess():
return success(_that.categories);case GetCategoriesNetwork():
return network();case GetCategoriesServer():
return server(_that.statusCode);case GetCategoriesParse():
return parse();case GetCategoriesUnknown():
return unknown(_that.cause);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Category> categories)?  success,TResult? Function()?  network,TResult? Function( int statusCode)?  server,TResult? Function()?  parse,TResult? Function( Object? cause)?  unknown,}) {final _that = this;
switch (_that) {
case GetCategoriesSuccess() when success != null:
return success(_that.categories);case GetCategoriesNetwork() when network != null:
return network();case GetCategoriesServer() when server != null:
return server(_that.statusCode);case GetCategoriesParse() when parse != null:
return parse();case GetCategoriesUnknown() when unknown != null:
return unknown(_that.cause);case _:
  return null;

}
}

}

/// @nodoc


class GetCategoriesSuccess implements GetCategoriesResult {
  const GetCategoriesSuccess( List<Category> categories): _categories = categories;
  

 final  List<Category> _categories;
 List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of GetCategoriesResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCategoriesSuccessCopyWith<GetCategoriesSuccess> get copyWith => _$GetCategoriesSuccessCopyWithImpl<GetCategoriesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCategoriesSuccess&&const DeepCollectionEquality().equals(other._categories, _categories));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_categories));

@override
String toString() {
  return 'GetCategoriesResult.success(categories: $categories)';
}


}

/// @nodoc
abstract mixin class $GetCategoriesSuccessCopyWith<$Res> implements $GetCategoriesResultCopyWith<$Res> {
  factory $GetCategoriesSuccessCopyWith(GetCategoriesSuccess value, $Res Function(GetCategoriesSuccess) _then) = _$GetCategoriesSuccessCopyWithImpl;
@useResult
$Res call({
 List<Category> categories
});




}
/// @nodoc
class _$GetCategoriesSuccessCopyWithImpl<$Res>
    implements $GetCategoriesSuccessCopyWith<$Res> {
  _$GetCategoriesSuccessCopyWithImpl(this._self, this._then);

  final GetCategoriesSuccess _self;
  final $Res Function(GetCategoriesSuccess) _then;

/// Create a copy of GetCategoriesResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categories = null,}) {
  return _then(GetCategoriesSuccess(
null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,
  ));
}


}

/// @nodoc


class GetCategoriesNetwork implements GetCategoriesResult {
  const GetCategoriesNetwork();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCategoriesNetwork);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetCategoriesResult.network()';
}


}




/// @nodoc


class GetCategoriesServer implements GetCategoriesResult {
  const GetCategoriesServer(this.statusCode);
  

 final  int statusCode;

/// Create a copy of GetCategoriesResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCategoriesServerCopyWith<GetCategoriesServer> get copyWith => _$GetCategoriesServerCopyWithImpl<GetCategoriesServer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCategoriesServer&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode);

@override
String toString() {
  return 'GetCategoriesResult.server(statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $GetCategoriesServerCopyWith<$Res> implements $GetCategoriesResultCopyWith<$Res> {
  factory $GetCategoriesServerCopyWith(GetCategoriesServer value, $Res Function(GetCategoriesServer) _then) = _$GetCategoriesServerCopyWithImpl;
@useResult
$Res call({
 int statusCode
});




}
/// @nodoc
class _$GetCategoriesServerCopyWithImpl<$Res>
    implements $GetCategoriesServerCopyWith<$Res> {
  _$GetCategoriesServerCopyWithImpl(this._self, this._then);

  final GetCategoriesServer _self;
  final $Res Function(GetCategoriesServer) _then;

/// Create a copy of GetCategoriesResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? statusCode = null,}) {
  return _then(GetCategoriesServer(
null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class GetCategoriesParse implements GetCategoriesResult {
  const GetCategoriesParse();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCategoriesParse);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetCategoriesResult.parse()';
}


}




/// @nodoc


class GetCategoriesUnknown implements GetCategoriesResult {
  const GetCategoriesUnknown([this.cause]);
  

 final  Object? cause;

/// Create a copy of GetCategoriesResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetCategoriesUnknownCopyWith<GetCategoriesUnknown> get copyWith => _$GetCategoriesUnknownCopyWithImpl<GetCategoriesUnknown>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetCategoriesUnknown&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'GetCategoriesResult.unknown(cause: $cause)';
}


}

/// @nodoc
abstract mixin class $GetCategoriesUnknownCopyWith<$Res> implements $GetCategoriesResultCopyWith<$Res> {
  factory $GetCategoriesUnknownCopyWith(GetCategoriesUnknown value, $Res Function(GetCategoriesUnknown) _then) = _$GetCategoriesUnknownCopyWithImpl;
@useResult
$Res call({
 Object? cause
});




}
/// @nodoc
class _$GetCategoriesUnknownCopyWithImpl<$Res>
    implements $GetCategoriesUnknownCopyWith<$Res> {
  _$GetCategoriesUnknownCopyWithImpl(this._self, this._then);

  final GetCategoriesUnknown _self;
  final $Res Function(GetCategoriesUnknown) _then;

/// Create a copy of GetCategoriesResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cause = freezed,}) {
  return _then(GetCategoriesUnknown(
freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc
mixin _$GetQuestionsResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetQuestionsResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetQuestionsResult()';
}


}

/// @nodoc
class $GetQuestionsResultCopyWith<$Res>  {
$GetQuestionsResultCopyWith(GetQuestionsResult _, $Res Function(GetQuestionsResult) __);
}


/// Adds pattern-matching-related methods to [GetQuestionsResult].
extension GetQuestionsResultPatterns on GetQuestionsResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GetQuestionsSuccess value)?  success,TResult Function( GetQuestionsNetwork value)?  network,TResult Function( GetQuestionsServer value)?  server,TResult Function( GetQuestionsParse value)?  parse,TResult Function( GetQuestionsUnknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GetQuestionsSuccess() when success != null:
return success(_that);case GetQuestionsNetwork() when network != null:
return network(_that);case GetQuestionsServer() when server != null:
return server(_that);case GetQuestionsParse() when parse != null:
return parse(_that);case GetQuestionsUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GetQuestionsSuccess value)  success,required TResult Function( GetQuestionsNetwork value)  network,required TResult Function( GetQuestionsServer value)  server,required TResult Function( GetQuestionsParse value)  parse,required TResult Function( GetQuestionsUnknown value)  unknown,}){
final _that = this;
switch (_that) {
case GetQuestionsSuccess():
return success(_that);case GetQuestionsNetwork():
return network(_that);case GetQuestionsServer():
return server(_that);case GetQuestionsParse():
return parse(_that);case GetQuestionsUnknown():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GetQuestionsSuccess value)?  success,TResult? Function( GetQuestionsNetwork value)?  network,TResult? Function( GetQuestionsServer value)?  server,TResult? Function( GetQuestionsParse value)?  parse,TResult? Function( GetQuestionsUnknown value)?  unknown,}){
final _that = this;
switch (_that) {
case GetQuestionsSuccess() when success != null:
return success(_that);case GetQuestionsNetwork() when network != null:
return network(_that);case GetQuestionsServer() when server != null:
return server(_that);case GetQuestionsParse() when parse != null:
return parse(_that);case GetQuestionsUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<Question> questions)?  success,TResult Function()?  network,TResult Function( int statusCode)?  server,TResult Function()?  parse,TResult Function( Object? cause)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GetQuestionsSuccess() when success != null:
return success(_that.questions);case GetQuestionsNetwork() when network != null:
return network();case GetQuestionsServer() when server != null:
return server(_that.statusCode);case GetQuestionsParse() when parse != null:
return parse();case GetQuestionsUnknown() when unknown != null:
return unknown(_that.cause);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<Question> questions)  success,required TResult Function()  network,required TResult Function( int statusCode)  server,required TResult Function()  parse,required TResult Function( Object? cause)  unknown,}) {final _that = this;
switch (_that) {
case GetQuestionsSuccess():
return success(_that.questions);case GetQuestionsNetwork():
return network();case GetQuestionsServer():
return server(_that.statusCode);case GetQuestionsParse():
return parse();case GetQuestionsUnknown():
return unknown(_that.cause);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<Question> questions)?  success,TResult? Function()?  network,TResult? Function( int statusCode)?  server,TResult? Function()?  parse,TResult? Function( Object? cause)?  unknown,}) {final _that = this;
switch (_that) {
case GetQuestionsSuccess() when success != null:
return success(_that.questions);case GetQuestionsNetwork() when network != null:
return network();case GetQuestionsServer() when server != null:
return server(_that.statusCode);case GetQuestionsParse() when parse != null:
return parse();case GetQuestionsUnknown() when unknown != null:
return unknown(_that.cause);case _:
  return null;

}
}

}

/// @nodoc


class GetQuestionsSuccess implements GetQuestionsResult {
  const GetQuestionsSuccess( List<Question> questions): _questions = questions;
  

 final  List<Question> _questions;
 List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of GetQuestionsResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetQuestionsSuccessCopyWith<GetQuestionsSuccess> get copyWith => _$GetQuestionsSuccessCopyWithImpl<GetQuestionsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetQuestionsSuccess&&const DeepCollectionEquality().equals(other._questions, _questions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'GetQuestionsResult.success(questions: $questions)';
}


}

/// @nodoc
abstract mixin class $GetQuestionsSuccessCopyWith<$Res> implements $GetQuestionsResultCopyWith<$Res> {
  factory $GetQuestionsSuccessCopyWith(GetQuestionsSuccess value, $Res Function(GetQuestionsSuccess) _then) = _$GetQuestionsSuccessCopyWithImpl;
@useResult
$Res call({
 List<Question> questions
});




}
/// @nodoc
class _$GetQuestionsSuccessCopyWithImpl<$Res>
    implements $GetQuestionsSuccessCopyWith<$Res> {
  _$GetQuestionsSuccessCopyWithImpl(this._self, this._then);

  final GetQuestionsSuccess _self;
  final $Res Function(GetQuestionsSuccess) _then;

/// Create a copy of GetQuestionsResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? questions = null,}) {
  return _then(GetQuestionsSuccess(
null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}


}

/// @nodoc


class GetQuestionsNetwork implements GetQuestionsResult {
  const GetQuestionsNetwork();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetQuestionsNetwork);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetQuestionsResult.network()';
}


}




/// @nodoc


class GetQuestionsServer implements GetQuestionsResult {
  const GetQuestionsServer(this.statusCode);
  

 final  int statusCode;

/// Create a copy of GetQuestionsResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetQuestionsServerCopyWith<GetQuestionsServer> get copyWith => _$GetQuestionsServerCopyWithImpl<GetQuestionsServer>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetQuestionsServer&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode);

@override
String toString() {
  return 'GetQuestionsResult.server(statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $GetQuestionsServerCopyWith<$Res> implements $GetQuestionsResultCopyWith<$Res> {
  factory $GetQuestionsServerCopyWith(GetQuestionsServer value, $Res Function(GetQuestionsServer) _then) = _$GetQuestionsServerCopyWithImpl;
@useResult
$Res call({
 int statusCode
});




}
/// @nodoc
class _$GetQuestionsServerCopyWithImpl<$Res>
    implements $GetQuestionsServerCopyWith<$Res> {
  _$GetQuestionsServerCopyWithImpl(this._self, this._then);

  final GetQuestionsServer _self;
  final $Res Function(GetQuestionsServer) _then;

/// Create a copy of GetQuestionsResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? statusCode = null,}) {
  return _then(GetQuestionsServer(
null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class GetQuestionsParse implements GetQuestionsResult {
  const GetQuestionsParse();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetQuestionsParse);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetQuestionsResult.parse()';
}


}




/// @nodoc


class GetQuestionsUnknown implements GetQuestionsResult {
  const GetQuestionsUnknown([this.cause]);
  

 final  Object? cause;

/// Create a copy of GetQuestionsResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetQuestionsUnknownCopyWith<GetQuestionsUnknown> get copyWith => _$GetQuestionsUnknownCopyWithImpl<GetQuestionsUnknown>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetQuestionsUnknown&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'GetQuestionsResult.unknown(cause: $cause)';
}


}

/// @nodoc
abstract mixin class $GetQuestionsUnknownCopyWith<$Res> implements $GetQuestionsResultCopyWith<$Res> {
  factory $GetQuestionsUnknownCopyWith(GetQuestionsUnknown value, $Res Function(GetQuestionsUnknown) _then) = _$GetQuestionsUnknownCopyWithImpl;
@useResult
$Res call({
 Object? cause
});




}
/// @nodoc
class _$GetQuestionsUnknownCopyWithImpl<$Res>
    implements $GetQuestionsUnknownCopyWith<$Res> {
  _$GetQuestionsUnknownCopyWithImpl(this._self, this._then);

  final GetQuestionsUnknown _self;
  final $Res Function(GetQuestionsUnknown) _then;

/// Create a copy of GetQuestionsResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cause = freezed,}) {
  return _then(GetQuestionsUnknown(
freezed == cause ? _self.cause : cause ,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'intro_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$IntroEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntroEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IntroEvent()';
}


}

/// @nodoc
class $IntroEventCopyWith<$Res>  {
$IntroEventCopyWith(IntroEvent _, $Res Function(IntroEvent) __);
}


/// Adds pattern-matching-related methods to [IntroEvent].
extension IntroEventPatterns on IntroEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( IntroNextPressed value)?  nextPressed,TResult Function( IntroPageSwiped value)?  pageSwiped,TResult Function( IntroFinishConsumed value)?  finishConsumed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case IntroNextPressed() when nextPressed != null:
return nextPressed(_that);case IntroPageSwiped() when pageSwiped != null:
return pageSwiped(_that);case IntroFinishConsumed() when finishConsumed != null:
return finishConsumed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( IntroNextPressed value)  nextPressed,required TResult Function( IntroPageSwiped value)  pageSwiped,required TResult Function( IntroFinishConsumed value)  finishConsumed,}){
final _that = this;
switch (_that) {
case IntroNextPressed():
return nextPressed(_that);case IntroPageSwiped():
return pageSwiped(_that);case IntroFinishConsumed():
return finishConsumed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( IntroNextPressed value)?  nextPressed,TResult? Function( IntroPageSwiped value)?  pageSwiped,TResult? Function( IntroFinishConsumed value)?  finishConsumed,}){
final _that = this;
switch (_that) {
case IntroNextPressed() when nextPressed != null:
return nextPressed(_that);case IntroPageSwiped() when pageSwiped != null:
return pageSwiped(_that);case IntroFinishConsumed() when finishConsumed != null:
return finishConsumed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  nextPressed,TResult Function( int page)?  pageSwiped,TResult Function()?  finishConsumed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case IntroNextPressed() when nextPressed != null:
return nextPressed();case IntroPageSwiped() when pageSwiped != null:
return pageSwiped(_that.page);case IntroFinishConsumed() when finishConsumed != null:
return finishConsumed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  nextPressed,required TResult Function( int page)  pageSwiped,required TResult Function()  finishConsumed,}) {final _that = this;
switch (_that) {
case IntroNextPressed():
return nextPressed();case IntroPageSwiped():
return pageSwiped(_that.page);case IntroFinishConsumed():
return finishConsumed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  nextPressed,TResult? Function( int page)?  pageSwiped,TResult? Function()?  finishConsumed,}) {final _that = this;
switch (_that) {
case IntroNextPressed() when nextPressed != null:
return nextPressed();case IntroPageSwiped() when pageSwiped != null:
return pageSwiped(_that.page);case IntroFinishConsumed() when finishConsumed != null:
return finishConsumed();case _:
  return null;

}
}

}

/// @nodoc


class IntroNextPressed implements IntroEvent {
  const IntroNextPressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntroNextPressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IntroEvent.nextPressed()';
}


}




/// @nodoc


class IntroPageSwiped implements IntroEvent {
  const IntroPageSwiped(this.page);
  

 final  int page;

/// Create a copy of IntroEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntroPageSwipedCopyWith<IntroPageSwiped> get copyWith => _$IntroPageSwipedCopyWithImpl<IntroPageSwiped>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntroPageSwiped&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,page);

@override
String toString() {
  return 'IntroEvent.pageSwiped(page: $page)';
}


}

/// @nodoc
abstract mixin class $IntroPageSwipedCopyWith<$Res> implements $IntroEventCopyWith<$Res> {
  factory $IntroPageSwipedCopyWith(IntroPageSwiped value, $Res Function(IntroPageSwiped) _then) = _$IntroPageSwipedCopyWithImpl;
@useResult
$Res call({
 int page
});




}
/// @nodoc
class _$IntroPageSwipedCopyWithImpl<$Res>
    implements $IntroPageSwipedCopyWith<$Res> {
  _$IntroPageSwipedCopyWithImpl(this._self, this._then);

  final IntroPageSwiped _self;
  final $Res Function(IntroPageSwiped) _then;

/// Create a copy of IntroEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(IntroPageSwiped(
null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class IntroFinishConsumed implements IntroEvent {
  const IntroFinishConsumed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntroFinishConsumed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'IntroEvent.finishConsumed()';
}


}




/// @nodoc
mixin _$IntroState {

 int get pageIndex; int get pageCount;/// Set when the flow should advance to the paywall; the view consumes it
/// through a [BlocListener] and it is cleared by [IntroBloc].
 bool get isFinished;
/// Create a copy of IntroState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IntroStateCopyWith<IntroState> get copyWith => _$IntroStateCopyWithImpl<IntroState>(this as IntroState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IntroState&&(identical(other.pageIndex, pageIndex) || other.pageIndex == pageIndex)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.isFinished, isFinished) || other.isFinished == isFinished));
}


@override
int get hashCode => Object.hash(runtimeType,pageIndex,pageCount,isFinished);

@override
String toString() {
  return 'IntroState(pageIndex: $pageIndex, pageCount: $pageCount, isFinished: $isFinished)';
}


}

/// @nodoc
abstract mixin class $IntroStateCopyWith<$Res>  {
  factory $IntroStateCopyWith(IntroState value, $Res Function(IntroState) _then) = _$IntroStateCopyWithImpl;
@useResult
$Res call({
 int pageIndex, int pageCount, bool isFinished
});




}
/// @nodoc
class _$IntroStateCopyWithImpl<$Res>
    implements $IntroStateCopyWith<$Res> {
  _$IntroStateCopyWithImpl(this._self, this._then);

  final IntroState _self;
  final $Res Function(IntroState) _then;

/// Create a copy of IntroState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageIndex = null,Object? pageCount = null,Object? isFinished = null,}) {
  return _then(IntroState(
pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,pageCount: null == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int,isFinished: null == isFinished ? _self.isFinished : isFinished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [IntroState].
extension IntroStatePatterns on IntroState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IntroState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IntroState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IntroState value)  $default,){
final _that = this;
switch (_that) {
case _IntroState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IntroState value)?  $default,){
final _that = this;
switch (_that) {
case _IntroState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pageIndex,  int pageCount,  bool isFinished)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IntroState() when $default != null:
return $default(_that.pageIndex,_that.pageCount,_that.isFinished);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pageIndex,  int pageCount,  bool isFinished)  $default,) {final _that = this;
switch (_that) {
case _IntroState():
return $default(_that.pageIndex,_that.pageCount,_that.isFinished);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pageIndex,  int pageCount,  bool isFinished)?  $default,) {final _that = this;
switch (_that) {
case _IntroState() when $default != null:
return $default(_that.pageIndex,_that.pageCount,_that.isFinished);case _:
  return null;

}
}

}

/// @nodoc


class _IntroState extends IntroState {
  const _IntroState({this.pageIndex = 0, this.pageCount = IntroBloc.pageCount, this.isFinished = false}): super._();
  

@override@JsonKey() final  int pageIndex;
@override@JsonKey() final  int pageCount;
/// Set when the flow should advance to the paywall; the view consumes it
/// through a [BlocListener] and it is cleared by [IntroBloc].
@override@JsonKey() final  bool isFinished;

/// Create a copy of IntroState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IntroStateCopyWith<_IntroState> get copyWith => __$IntroStateCopyWithImpl<_IntroState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IntroState&&(identical(other.pageIndex, pageIndex) || other.pageIndex == pageIndex)&&(identical(other.pageCount, pageCount) || other.pageCount == pageCount)&&(identical(other.isFinished, isFinished) || other.isFinished == isFinished));
}


@override
int get hashCode => Object.hash(runtimeType,pageIndex,pageCount,isFinished);

@override
String toString() {
  return 'IntroState(pageIndex: $pageIndex, pageCount: $pageCount, isFinished: $isFinished)';
}


}

/// @nodoc
abstract mixin class _$IntroStateCopyWith<$Res> implements $IntroStateCopyWith<$Res> {
  factory _$IntroStateCopyWith(_IntroState value, $Res Function(_IntroState) _then) = __$IntroStateCopyWithImpl;
@override @useResult
$Res call({
 int pageIndex, int pageCount, bool isFinished
});




}
/// @nodoc
class __$IntroStateCopyWithImpl<$Res>
    implements _$IntroStateCopyWith<$Res> {
  __$IntroStateCopyWithImpl(this._self, this._then);

  final _IntroState _self;
  final $Res Function(_IntroState) _then;

/// Create a copy of IntroState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageIndex = null,Object? pageCount = null,Object? isFinished = null,}) {
  return _then(_IntroState(
pageIndex: null == pageIndex ? _self.pageIndex : pageIndex // ignore: cast_nullable_to_non_nullable
as int,pageCount: null == pageCount ? _self.pageCount : pageCount // ignore: cast_nullable_to_non_nullable
as int,isFinished: null == isFinished ? _self.isFinished : isFinished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingStatusResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStatusResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingStatusResult()';
}


}

/// @nodoc
class $OnboardingStatusResultCopyWith<$Res>  {
$OnboardingStatusResultCopyWith(OnboardingStatusResult _, $Res Function(OnboardingStatusResult) __);
}


/// Adds pattern-matching-related methods to [OnboardingStatusResult].
extension OnboardingStatusResultPatterns on OnboardingStatusResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnboardingStatusCompleted value)?  completed,TResult Function( OnboardingStatusPending value)?  pending,TResult Function( OnboardingStatusUnavailable value)?  unavailable,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnboardingStatusCompleted() when completed != null:
return completed(_that);case OnboardingStatusPending() when pending != null:
return pending(_that);case OnboardingStatusUnavailable() when unavailable != null:
return unavailable(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnboardingStatusCompleted value)  completed,required TResult Function( OnboardingStatusPending value)  pending,required TResult Function( OnboardingStatusUnavailable value)  unavailable,}){
final _that = this;
switch (_that) {
case OnboardingStatusCompleted():
return completed(_that);case OnboardingStatusPending():
return pending(_that);case OnboardingStatusUnavailable():
return unavailable(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnboardingStatusCompleted value)?  completed,TResult? Function( OnboardingStatusPending value)?  pending,TResult? Function( OnboardingStatusUnavailable value)?  unavailable,}){
final _that = this;
switch (_that) {
case OnboardingStatusCompleted() when completed != null:
return completed(_that);case OnboardingStatusPending() when pending != null:
return pending(_that);case OnboardingStatusUnavailable() when unavailable != null:
return unavailable(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  completed,TResult Function()?  pending,TResult Function( Object? cause)?  unavailable,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnboardingStatusCompleted() when completed != null:
return completed();case OnboardingStatusPending() when pending != null:
return pending();case OnboardingStatusUnavailable() when unavailable != null:
return unavailable(_that.cause);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  completed,required TResult Function()  pending,required TResult Function( Object? cause)  unavailable,}) {final _that = this;
switch (_that) {
case OnboardingStatusCompleted():
return completed();case OnboardingStatusPending():
return pending();case OnboardingStatusUnavailable():
return unavailable(_that.cause);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  completed,TResult? Function()?  pending,TResult? Function( Object? cause)?  unavailable,}) {final _that = this;
switch (_that) {
case OnboardingStatusCompleted() when completed != null:
return completed();case OnboardingStatusPending() when pending != null:
return pending();case OnboardingStatusUnavailable() when unavailable != null:
return unavailable(_that.cause);case _:
  return null;

}
}

}

/// @nodoc


class OnboardingStatusCompleted implements OnboardingStatusResult {
  const OnboardingStatusCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStatusCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingStatusResult.completed()';
}


}




/// @nodoc


class OnboardingStatusPending implements OnboardingStatusResult {
  const OnboardingStatusPending();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStatusPending);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingStatusResult.pending()';
}


}




/// @nodoc


class OnboardingStatusUnavailable implements OnboardingStatusResult {
  const OnboardingStatusUnavailable([this.cause]);
  

 final  Object? cause;

/// Create a copy of OnboardingStatusResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStatusUnavailableCopyWith<OnboardingStatusUnavailable> get copyWith => _$OnboardingStatusUnavailableCopyWithImpl<OnboardingStatusUnavailable>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStatusUnavailable&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'OnboardingStatusResult.unavailable(cause: $cause)';
}


}

/// @nodoc
abstract mixin class $OnboardingStatusUnavailableCopyWith<$Res> implements $OnboardingStatusResultCopyWith<$Res> {
  factory $OnboardingStatusUnavailableCopyWith(OnboardingStatusUnavailable value, $Res Function(OnboardingStatusUnavailable) _then) = _$OnboardingStatusUnavailableCopyWithImpl;
@useResult
$Res call({
 Object? cause
});




}
/// @nodoc
class _$OnboardingStatusUnavailableCopyWithImpl<$Res>
    implements $OnboardingStatusUnavailableCopyWith<$Res> {
  _$OnboardingStatusUnavailableCopyWithImpl(this._self, this._then);

  final OnboardingStatusUnavailable _self;
  final $Res Function(OnboardingStatusUnavailable) _then;

/// Create a copy of OnboardingStatusResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cause = freezed,}) {
  return _then(OnboardingStatusUnavailable(
freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc
mixin _$CompleteOnboardingResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteOnboardingResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteOnboardingResult()';
}


}

/// @nodoc
class $CompleteOnboardingResultCopyWith<$Res>  {
$CompleteOnboardingResultCopyWith(CompleteOnboardingResult _, $Res Function(CompleteOnboardingResult) __);
}


/// Adds pattern-matching-related methods to [CompleteOnboardingResult].
extension CompleteOnboardingResultPatterns on CompleteOnboardingResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CompleteOnboardingSuccess value)?  success,TResult Function( CompleteOnboardingFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CompleteOnboardingSuccess() when success != null:
return success(_that);case CompleteOnboardingFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CompleteOnboardingSuccess value)  success,required TResult Function( CompleteOnboardingFailure value)  failure,}){
final _that = this;
switch (_that) {
case CompleteOnboardingSuccess():
return success(_that);case CompleteOnboardingFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CompleteOnboardingSuccess value)?  success,TResult? Function( CompleteOnboardingFailure value)?  failure,}){
final _that = this;
switch (_that) {
case CompleteOnboardingSuccess() when success != null:
return success(_that);case CompleteOnboardingFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  success,TResult Function( Object? cause)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CompleteOnboardingSuccess() when success != null:
return success();case CompleteOnboardingFailure() when failure != null:
return failure(_that.cause);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  success,required TResult Function( Object? cause)  failure,}) {final _that = this;
switch (_that) {
case CompleteOnboardingSuccess():
return success();case CompleteOnboardingFailure():
return failure(_that.cause);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  success,TResult? Function( Object? cause)?  failure,}) {final _that = this;
switch (_that) {
case CompleteOnboardingSuccess() when success != null:
return success();case CompleteOnboardingFailure() when failure != null:
return failure(_that.cause);case _:
  return null;

}
}

}

/// @nodoc


class CompleteOnboardingSuccess implements CompleteOnboardingResult {
  const CompleteOnboardingSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteOnboardingSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompleteOnboardingResult.success()';
}


}




/// @nodoc


class CompleteOnboardingFailure implements CompleteOnboardingResult {
  const CompleteOnboardingFailure([this.cause]);
  

 final  Object? cause;

/// Create a copy of CompleteOnboardingResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompleteOnboardingFailureCopyWith<CompleteOnboardingFailure> get copyWith => _$CompleteOnboardingFailureCopyWithImpl<CompleteOnboardingFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompleteOnboardingFailure&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'CompleteOnboardingResult.failure(cause: $cause)';
}


}

/// @nodoc
abstract mixin class $CompleteOnboardingFailureCopyWith<$Res> implements $CompleteOnboardingResultCopyWith<$Res> {
  factory $CompleteOnboardingFailureCopyWith(CompleteOnboardingFailure value, $Res Function(CompleteOnboardingFailure) _then) = _$CompleteOnboardingFailureCopyWithImpl;
@useResult
$Res call({
 Object? cause
});




}
/// @nodoc
class _$CompleteOnboardingFailureCopyWithImpl<$Res>
    implements $CompleteOnboardingFailureCopyWith<$Res> {
  _$CompleteOnboardingFailureCopyWithImpl(this._self, this._then);

  final CompleteOnboardingFailure _self;
  final $Res Function(CompleteOnboardingFailure) _then;

/// Create a copy of CompleteOnboardingResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cause = freezed,}) {
  return _then(CompleteOnboardingFailure(
freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc
mixin _$GetPlansResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetPlansResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetPlansResult()';
}


}

/// @nodoc
class $GetPlansResultCopyWith<$Res>  {
$GetPlansResultCopyWith(GetPlansResult _, $Res Function(GetPlansResult) __);
}


/// Adds pattern-matching-related methods to [GetPlansResult].
extension GetPlansResultPatterns on GetPlansResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GetPlansSuccess value)?  success,TResult Function( GetPlansFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GetPlansSuccess() when success != null:
return success(_that);case GetPlansFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GetPlansSuccess value)  success,required TResult Function( GetPlansFailure value)  failure,}){
final _that = this;
switch (_that) {
case GetPlansSuccess():
return success(_that);case GetPlansFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GetPlansSuccess value)?  success,TResult? Function( GetPlansFailure value)?  failure,}){
final _that = this;
switch (_that) {
case GetPlansSuccess() when success != null:
return success(_that);case GetPlansFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<SubscriptionPlan> plans)?  success,TResult Function( Object? cause)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GetPlansSuccess() when success != null:
return success(_that.plans);case GetPlansFailure() when failure != null:
return failure(_that.cause);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<SubscriptionPlan> plans)  success,required TResult Function( Object? cause)  failure,}) {final _that = this;
switch (_that) {
case GetPlansSuccess():
return success(_that.plans);case GetPlansFailure():
return failure(_that.cause);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<SubscriptionPlan> plans)?  success,TResult? Function( Object? cause)?  failure,}) {final _that = this;
switch (_that) {
case GetPlansSuccess() when success != null:
return success(_that.plans);case GetPlansFailure() when failure != null:
return failure(_that.cause);case _:
  return null;

}
}

}

/// @nodoc


class GetPlansSuccess implements GetPlansResult {
  const GetPlansSuccess( List<SubscriptionPlan> plans): _plans = plans;
  

 final  List<SubscriptionPlan> _plans;
 List<SubscriptionPlan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}


/// Create a copy of GetPlansResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetPlansSuccessCopyWith<GetPlansSuccess> get copyWith => _$GetPlansSuccessCopyWithImpl<GetPlansSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetPlansSuccess&&const DeepCollectionEquality().equals(other._plans, _plans));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_plans));

@override
String toString() {
  return 'GetPlansResult.success(plans: $plans)';
}


}

/// @nodoc
abstract mixin class $GetPlansSuccessCopyWith<$Res> implements $GetPlansResultCopyWith<$Res> {
  factory $GetPlansSuccessCopyWith(GetPlansSuccess value, $Res Function(GetPlansSuccess) _then) = _$GetPlansSuccessCopyWithImpl;
@useResult
$Res call({
 List<SubscriptionPlan> plans
});




}
/// @nodoc
class _$GetPlansSuccessCopyWithImpl<$Res>
    implements $GetPlansSuccessCopyWith<$Res> {
  _$GetPlansSuccessCopyWithImpl(this._self, this._then);

  final GetPlansSuccess _self;
  final $Res Function(GetPlansSuccess) _then;

/// Create a copy of GetPlansResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plans = null,}) {
  return _then(GetPlansSuccess(
null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<SubscriptionPlan>,
  ));
}


}

/// @nodoc


class GetPlansFailure implements GetPlansResult {
  const GetPlansFailure([this.cause]);
  

 final  Object? cause;

/// Create a copy of GetPlansResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetPlansFailureCopyWith<GetPlansFailure> get copyWith => _$GetPlansFailureCopyWithImpl<GetPlansFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetPlansFailure&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cause));

@override
String toString() {
  return 'GetPlansResult.failure(cause: $cause)';
}


}

/// @nodoc
abstract mixin class $GetPlansFailureCopyWith<$Res> implements $GetPlansResultCopyWith<$Res> {
  factory $GetPlansFailureCopyWith(GetPlansFailure value, $Res Function(GetPlansFailure) _then) = _$GetPlansFailureCopyWithImpl;
@useResult
$Res call({
 Object? cause
});




}
/// @nodoc
class _$GetPlansFailureCopyWithImpl<$Res>
    implements $GetPlansFailureCopyWith<$Res> {
  _$GetPlansFailureCopyWithImpl(this._self, this._then);

  final GetPlansFailure _self;
  final $Res Function(GetPlansFailure) _then;

/// Create a copy of GetPlansResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cause = freezed,}) {
  return _then(GetPlansFailure(
freezed == cause ? _self.cause : cause ,
  ));
}


}

// dart format on

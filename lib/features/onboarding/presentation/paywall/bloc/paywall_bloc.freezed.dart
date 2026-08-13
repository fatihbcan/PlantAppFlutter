// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paywall_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaywallEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaywallEvent()';
}


}

/// @nodoc
class $PaywallEventCopyWith<$Res>  {
$PaywallEventCopyWith(PaywallEvent _, $Res Function(PaywallEvent) __);
}


/// Adds pattern-matching-related methods to [PaywallEvent].
extension PaywallEventPatterns on PaywallEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaywallStarted value)?  started,TResult Function( PaywallPlanSelected value)?  planSelected,TResult Function( PaywallSubscribePressed value)?  subscribePressed,TResult Function( PaywallClosePressed value)?  closePressed,TResult Function( PaywallExitConsumed value)?  exitConsumed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaywallStarted() when started != null:
return started(_that);case PaywallPlanSelected() when planSelected != null:
return planSelected(_that);case PaywallSubscribePressed() when subscribePressed != null:
return subscribePressed(_that);case PaywallClosePressed() when closePressed != null:
return closePressed(_that);case PaywallExitConsumed() when exitConsumed != null:
return exitConsumed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaywallStarted value)  started,required TResult Function( PaywallPlanSelected value)  planSelected,required TResult Function( PaywallSubscribePressed value)  subscribePressed,required TResult Function( PaywallClosePressed value)  closePressed,required TResult Function( PaywallExitConsumed value)  exitConsumed,}){
final _that = this;
switch (_that) {
case PaywallStarted():
return started(_that);case PaywallPlanSelected():
return planSelected(_that);case PaywallSubscribePressed():
return subscribePressed(_that);case PaywallClosePressed():
return closePressed(_that);case PaywallExitConsumed():
return exitConsumed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaywallStarted value)?  started,TResult? Function( PaywallPlanSelected value)?  planSelected,TResult? Function( PaywallSubscribePressed value)?  subscribePressed,TResult? Function( PaywallClosePressed value)?  closePressed,TResult? Function( PaywallExitConsumed value)?  exitConsumed,}){
final _that = this;
switch (_that) {
case PaywallStarted() when started != null:
return started(_that);case PaywallPlanSelected() when planSelected != null:
return planSelected(_that);case PaywallSubscribePressed() when subscribePressed != null:
return subscribePressed(_that);case PaywallClosePressed() when closePressed != null:
return closePressed(_that);case PaywallExitConsumed() when exitConsumed != null:
return exitConsumed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String planId)?  planSelected,TResult Function()?  subscribePressed,TResult Function()?  closePressed,TResult Function()?  exitConsumed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaywallStarted() when started != null:
return started();case PaywallPlanSelected() when planSelected != null:
return planSelected(_that.planId);case PaywallSubscribePressed() when subscribePressed != null:
return subscribePressed();case PaywallClosePressed() when closePressed != null:
return closePressed();case PaywallExitConsumed() when exitConsumed != null:
return exitConsumed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String planId)  planSelected,required TResult Function()  subscribePressed,required TResult Function()  closePressed,required TResult Function()  exitConsumed,}) {final _that = this;
switch (_that) {
case PaywallStarted():
return started();case PaywallPlanSelected():
return planSelected(_that.planId);case PaywallSubscribePressed():
return subscribePressed();case PaywallClosePressed():
return closePressed();case PaywallExitConsumed():
return exitConsumed();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String planId)?  planSelected,TResult? Function()?  subscribePressed,TResult? Function()?  closePressed,TResult? Function()?  exitConsumed,}) {final _that = this;
switch (_that) {
case PaywallStarted() when started != null:
return started();case PaywallPlanSelected() when planSelected != null:
return planSelected(_that.planId);case PaywallSubscribePressed() when subscribePressed != null:
return subscribePressed();case PaywallClosePressed() when closePressed != null:
return closePressed();case PaywallExitConsumed() when exitConsumed != null:
return exitConsumed();case _:
  return null;

}
}

}

/// @nodoc


class PaywallStarted implements PaywallEvent {
  const PaywallStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaywallEvent.started()';
}


}




/// @nodoc


class PaywallPlanSelected implements PaywallEvent {
  const PaywallPlanSelected(this.planId);
  

 final  String planId;

/// Create a copy of PaywallEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaywallPlanSelectedCopyWith<PaywallPlanSelected> get copyWith => _$PaywallPlanSelectedCopyWithImpl<PaywallPlanSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallPlanSelected&&(identical(other.planId, planId) || other.planId == planId));
}


@override
int get hashCode => Object.hash(runtimeType,planId);

@override
String toString() {
  return 'PaywallEvent.planSelected(planId: $planId)';
}


}

/// @nodoc
abstract mixin class $PaywallPlanSelectedCopyWith<$Res> implements $PaywallEventCopyWith<$Res> {
  factory $PaywallPlanSelectedCopyWith(PaywallPlanSelected value, $Res Function(PaywallPlanSelected) _then) = _$PaywallPlanSelectedCopyWithImpl;
@useResult
$Res call({
 String planId
});




}
/// @nodoc
class _$PaywallPlanSelectedCopyWithImpl<$Res>
    implements $PaywallPlanSelectedCopyWith<$Res> {
  _$PaywallPlanSelectedCopyWithImpl(this._self, this._then);

  final PaywallPlanSelected _self;
  final $Res Function(PaywallPlanSelected) _then;

/// Create a copy of PaywallEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? planId = null,}) {
  return _then(PaywallPlanSelected(
null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PaywallSubscribePressed implements PaywallEvent {
  const PaywallSubscribePressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallSubscribePressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaywallEvent.subscribePressed()';
}


}




/// @nodoc


class PaywallClosePressed implements PaywallEvent {
  const PaywallClosePressed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallClosePressed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaywallEvent.closePressed()';
}


}




/// @nodoc


class PaywallExitConsumed implements PaywallEvent {
  const PaywallExitConsumed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallExitConsumed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaywallEvent.exitConsumed()';
}


}




/// @nodoc
mixin _$PaywallState {

 bool get isLoading; List<SubscriptionPlan> get plans; String? get selectedPlanId; bool get isSubmitting; PaywallError? get error;/// Set once onboarding is recorded as complete and the flow should leave
/// for home. Cleared by [PaywallExitConsumed].
 bool get shouldExit;
/// Create a copy of PaywallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaywallStateCopyWith<PaywallState> get copyWith => _$PaywallStateCopyWithImpl<PaywallState>(this as PaywallState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaywallState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.plans, plans)&&(identical(other.selectedPlanId, selectedPlanId) || other.selectedPlanId == selectedPlanId)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.error, error) || other.error == error)&&(identical(other.shouldExit, shouldExit) || other.shouldExit == shouldExit));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(plans),selectedPlanId,isSubmitting,error,shouldExit);

@override
String toString() {
  return 'PaywallState(isLoading: $isLoading, plans: $plans, selectedPlanId: $selectedPlanId, isSubmitting: $isSubmitting, error: $error, shouldExit: $shouldExit)';
}


}

/// @nodoc
abstract mixin class $PaywallStateCopyWith<$Res>  {
  factory $PaywallStateCopyWith(PaywallState value, $Res Function(PaywallState) _then) = _$PaywallStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<SubscriptionPlan> plans, String? selectedPlanId, bool isSubmitting, PaywallError? error, bool shouldExit
});




}
/// @nodoc
class _$PaywallStateCopyWithImpl<$Res>
    implements $PaywallStateCopyWith<$Res> {
  _$PaywallStateCopyWithImpl(this._self, this._then);

  final PaywallState _self;
  final $Res Function(PaywallState) _then;

/// Create a copy of PaywallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? plans = null,Object? selectedPlanId = freezed,Object? isSubmitting = null,Object? error = freezed,Object? shouldExit = null,}) {
  return _then(PaywallState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,plans: null == plans ? _self.plans : plans // ignore: cast_nullable_to_non_nullable
as List<SubscriptionPlan>,selectedPlanId: freezed == selectedPlanId ? _self.selectedPlanId : selectedPlanId // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as PaywallError?,shouldExit: null == shouldExit ? _self.shouldExit : shouldExit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PaywallState].
extension PaywallStatePatterns on PaywallState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaywallState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaywallState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaywallState value)  $default,){
final _that = this;
switch (_that) {
case _PaywallState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaywallState value)?  $default,){
final _that = this;
switch (_that) {
case _PaywallState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<SubscriptionPlan> plans,  String? selectedPlanId,  bool isSubmitting,  PaywallError? error,  bool shouldExit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaywallState() when $default != null:
return $default(_that.isLoading,_that.plans,_that.selectedPlanId,_that.isSubmitting,_that.error,_that.shouldExit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<SubscriptionPlan> plans,  String? selectedPlanId,  bool isSubmitting,  PaywallError? error,  bool shouldExit)  $default,) {final _that = this;
switch (_that) {
case _PaywallState():
return $default(_that.isLoading,_that.plans,_that.selectedPlanId,_that.isSubmitting,_that.error,_that.shouldExit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<SubscriptionPlan> plans,  String? selectedPlanId,  bool isSubmitting,  PaywallError? error,  bool shouldExit)?  $default,) {final _that = this;
switch (_that) {
case _PaywallState() when $default != null:
return $default(_that.isLoading,_that.plans,_that.selectedPlanId,_that.isSubmitting,_that.error,_that.shouldExit);case _:
  return null;

}
}

}

/// @nodoc


class _PaywallState extends PaywallState {
  const _PaywallState({this.isLoading = false,  List<SubscriptionPlan> plans = const <SubscriptionPlan>[], this.selectedPlanId = null, this.isSubmitting = false, this.error = null, this.shouldExit = false}): _plans = plans,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<SubscriptionPlan> _plans;
@override@JsonKey() List<SubscriptionPlan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}

@override@JsonKey() final  String? selectedPlanId;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  PaywallError? error;
/// Set once onboarding is recorded as complete and the flow should leave
/// for home. Cleared by [PaywallExitConsumed].
@override@JsonKey() final  bool shouldExit;

/// Create a copy of PaywallState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaywallStateCopyWith<_PaywallState> get copyWith => __$PaywallStateCopyWithImpl<_PaywallState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaywallState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._plans, _plans)&&(identical(other.selectedPlanId, selectedPlanId) || other.selectedPlanId == selectedPlanId)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.error, error) || other.error == error)&&(identical(other.shouldExit, shouldExit) || other.shouldExit == shouldExit));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_plans),selectedPlanId,isSubmitting,error,shouldExit);

@override
String toString() {
  return 'PaywallState(isLoading: $isLoading, plans: $plans, selectedPlanId: $selectedPlanId, isSubmitting: $isSubmitting, error: $error, shouldExit: $shouldExit)';
}


}

/// @nodoc
abstract mixin class _$PaywallStateCopyWith<$Res> implements $PaywallStateCopyWith<$Res> {
  factory _$PaywallStateCopyWith(_PaywallState value, $Res Function(_PaywallState) _then) = __$PaywallStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<SubscriptionPlan> plans, String? selectedPlanId, bool isSubmitting, PaywallError? error, bool shouldExit
});




}
/// @nodoc
class __$PaywallStateCopyWithImpl<$Res>
    implements _$PaywallStateCopyWith<$Res> {
  __$PaywallStateCopyWithImpl(this._self, this._then);

  final _PaywallState _self;
  final $Res Function(_PaywallState) _then;

/// Create a copy of PaywallState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? plans = null,Object? selectedPlanId = freezed,Object? isSubmitting = null,Object? error = freezed,Object? shouldExit = null,}) {
  return _then(_PaywallState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,plans: null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<SubscriptionPlan>,selectedPlanId: freezed == selectedPlanId ? _self.selectedPlanId : selectedPlanId // ignore: cast_nullable_to_non_nullable
as String?,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as PaywallError?,shouldExit: null == shouldExit ? _self.shouldExit : shouldExit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

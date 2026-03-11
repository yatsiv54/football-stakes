// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'matches_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MatchesCubitState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchesCubitState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchesCubitState()';
}


}

/// @nodoc
class $MatchesCubitStateCopyWith<$Res>  {
$MatchesCubitStateCopyWith(MatchesCubitState _, $Res Function(MatchesCubitState) __);
}


/// Adds pattern-matching-related methods to [MatchesCubitState].
extension MatchesCubitStatePatterns on MatchesCubitState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _MatchesLoaded value)?  matchesLoaded,TResult Function( _Failure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _MatchesLoaded() when matchesLoaded != null:
return matchesLoaded(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _MatchesLoaded value)  matchesLoaded,required TResult Function( _Failure value)  failure,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _MatchesLoaded():
return matchesLoaded(_that);case _Failure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _MatchesLoaded value)?  matchesLoaded,TResult? Function( _Failure value)?  failure,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _MatchesLoaded() when matchesLoaded != null:
return matchesLoaded(_that);case _Failure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<MatchEntity> matches,  List<MatchEntity> filteredMatches)?  matchesLoaded,TResult Function()?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _MatchesLoaded() when matchesLoaded != null:
return matchesLoaded(_that.matches,_that.filteredMatches);case _Failure() when failure != null:
return failure();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<MatchEntity> matches,  List<MatchEntity> filteredMatches)  matchesLoaded,required TResult Function()  failure,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _MatchesLoaded():
return matchesLoaded(_that.matches,_that.filteredMatches);case _Failure():
return failure();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<MatchEntity> matches,  List<MatchEntity> filteredMatches)?  matchesLoaded,TResult? Function()?  failure,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _MatchesLoaded() when matchesLoaded != null:
return matchesLoaded(_that.matches,_that.filteredMatches);case _Failure() when failure != null:
return failure();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements MatchesCubitState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchesCubitState.initial()';
}


}




/// @nodoc


class _Loading implements MatchesCubitState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchesCubitState.loading()';
}


}




/// @nodoc


class _MatchesLoaded implements MatchesCubitState {
  const _MatchesLoaded({required final  List<MatchEntity> matches, required final  List<MatchEntity> filteredMatches}): _matches = matches,_filteredMatches = filteredMatches;
  

 final  List<MatchEntity> _matches;
 List<MatchEntity> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}

 final  List<MatchEntity> _filteredMatches;
 List<MatchEntity> get filteredMatches {
  if (_filteredMatches is EqualUnmodifiableListView) return _filteredMatches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredMatches);
}


/// Create a copy of MatchesCubitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchesLoadedCopyWith<_MatchesLoaded> get copyWith => __$MatchesLoadedCopyWithImpl<_MatchesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchesLoaded&&const DeepCollectionEquality().equals(other._matches, _matches)&&const DeepCollectionEquality().equals(other._filteredMatches, _filteredMatches));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_matches),const DeepCollectionEquality().hash(_filteredMatches));

@override
String toString() {
  return 'MatchesCubitState.matchesLoaded(matches: $matches, filteredMatches: $filteredMatches)';
}


}

/// @nodoc
abstract mixin class _$MatchesLoadedCopyWith<$Res> implements $MatchesCubitStateCopyWith<$Res> {
  factory _$MatchesLoadedCopyWith(_MatchesLoaded value, $Res Function(_MatchesLoaded) _then) = __$MatchesLoadedCopyWithImpl;
@useResult
$Res call({
 List<MatchEntity> matches, List<MatchEntity> filteredMatches
});




}
/// @nodoc
class __$MatchesLoadedCopyWithImpl<$Res>
    implements _$MatchesLoadedCopyWith<$Res> {
  __$MatchesLoadedCopyWithImpl(this._self, this._then);

  final _MatchesLoaded _self;
  final $Res Function(_MatchesLoaded) _then;

/// Create a copy of MatchesCubitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? matches = null,Object? filteredMatches = null,}) {
  return _then(_MatchesLoaded(
matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<MatchEntity>,filteredMatches: null == filteredMatches ? _self._filteredMatches : filteredMatches // ignore: cast_nullable_to_non_nullable
as List<MatchEntity>,
  ));
}


}

/// @nodoc


class _Failure implements MatchesCubitState {
  const _Failure();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'MatchesCubitState.failure()';
}


}




// dart format on

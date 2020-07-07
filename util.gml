#region const

/// @constant {Number} TWOPI
/// @desc Also known as global.tau
/// @default 2*pi

global.tau = 2 * pi;
#macro TWOPI global.tau

/// @constant {Number} NV_MAGICCONST
/// @desc Also known as global.nv_magicconst. Used in normal variate random distribution.
/// @default 4 * exp( -0.5 ) / sqrt( 2.0 )

global.nv_magicconst = 4 * exp( -0.5 ) / sqrt( 2.0 )
#macro NV_MAGICCONST global.nv_magicconst

/// @constant {Number} SMALL_FACTORIALS
/// @desc Also known as global.small_factorials. Lookup table for int64 factorial values.
/// @default [0!..20!]

global.small_factorials = [ 1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880, 
		3628800, 39916800, 479001600, 6227020800, 87178291200, 1307674368000, 
		20922789888000, 355687428096000, 6402373705728000, 121645100408832000, 2432902008176640000 ];
#macro SMALL_FACTORIALS global.small_factorials

#endregion

#region test

/// @func assert
///
/// @desc Asserts that a condition is true. If it isn't it throws an error with the given message.
///
/// @arg {Bool} condidion
/// @arg {String} message

function assert( _condition, _message ) {
	if ( !_condition ) {
		show_error( _message, true );		
	}
}

/// @func assert_equals
///
/// @desc Asserts that two arguments are equal. If they are not, an error is thrown with the given message. 
///
/// @arg {Any} expected
/// @arg {Any} actuals
/// @arg {String} [message]

function assert_equals( _expected, _actual, _message ) {
	_message = is_undefined( _message ) ? "" : _message;
	if ( typeof( _expected ) == "array" ) {
		assert( array_equals( _expected, _actual ), _message );	
	} else {
		assert( _expected == _actual, _message );
	}
}

/// @func assert_array_equals
///
/// @desc Asserts that two arguments are equal. If they are not, an error is thrown with the given message. 
///
/// @arg {Array} expected
/// @arg {Array} actuals
/// @arg {String} [message]

function assert_array_equals( _expected, _actual, _message ) {
	_message = is_undefined( _message ) ? "" : _message;
	var _size = array_length( _expected );
	assert( _size == array_length( _actual ), _message );
	
	for ( var i = 0; i < _size; i++ ) {
		var _item = _expected[ i ];
		if ( typeof( _item ) == "array" ) {
			assert_array_equals(  _item, _actual[ i ], _message );
		} else {
			assert( _item == _actual[ i ], _message );
		}
	}
}

#endregion

#region data_structues

/// @function _list
/// @desc returns ds_list
/// @arg [...]

function _list( ) {
	var _ds = ds_list_create();
	var _n = argument_count;
	
	for (var i = 0; i < _n; i++ ) {
		_ds[| i ] = argument[ i ];
	}
	
	return _ds;
}

/// @function _stack
/// @desc returns ds_stack
/// @arg [...]

function _stack( ) {
	var _ds = ds_stack_create();
	var _n = argument_count;
	
	for (var i = 0; i < _n; i++ ) {
		ds_stack_push( _ds, argument[ i ] );
	}
	
	return _ds;
}

/// @function _queue
/// @desc returns ds_queue
/// @arg [...]

function _queue( ) {
	var _ds = ds_queue_create();
	var _n = argument_count;
	
	for (var i = 0; i < _n; i++ ) {
		ds_queue_enqueue( _ds, argument[ i ] );
	}
	
	return _ds;
}

/// @function _map
/// @desc returns ds_map
/// @arg {array} [...] key, value pairs

function _map( ) {
	var _ds = ds_map_create();
	var _n = argument_count;
	
	for (var i = 0; i < _n; i++ ) {
		var _t = argument[ i ];
		ds_map_add( _ds, _t[ 0 ], _t[ 1 ] );
	}
	
	return _ds;
}

/// @function _priority
/// @desc returns ds_priority
/// @arg {array} [...] value, priority pairs

function _priority( ) {
	var _ds = ds_priority_create();
	var _n = argument_count;
	
	for (var i = 0; i < _n; i++ ) {
		var _t = argument[ i ];
		ds_priority_add( _ds, _t[ 0 ], _t[ 1 ] );
	}
	
	return _ds;
}

#endregion

#region misc

/// @func apply
///
/// @desc Executes function with arguments passed as array. Up to 16 arguments supported.
///
/// @arg {Method} function
/// @arg {Array} arguments
///
/// @return {Any} Result returned by function
///
/// @example
/// apply( min, [ 1, 2, 3 ] ) --> 1

function apply( func, a ) {
	var size = array_length( a );
	switch ( size ) {
			case 0: return func( );
			case 1: return func( a[0] );
			case 2: return func( a[0], a[1] );
			case 3: return func( a[0], a[1], a[2] );
			case 4: return func( a[0], a[1], a[2], a[3] );
			case 5: return func( a[0], a[1], a[2], a[3], a[4] );
			case 6: return func( a[0], a[1], a[2], a[3], a[4], a[5] );
			case 7: return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6] );
			case 8: return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7] );
			case 9: return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8] );
			case 10: return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9] );
			case 11: return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10] );
			case 12: return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11] );
			case 13: return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12] );
			case 14: return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13] );
			case 15: return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14] );
			default:
				return func( a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15] );
		}
}

/// @func to_string
///
/// @desc Returs string representation of object
///
/// @arg {Any} object
/// @arg [separator]
///
/// @return {String}

function to_string( _object ) {
	switch typeof( _object ) {
		case "struct":
			if ( variable_struct_exists( _object, "to_string" ) ) {
				var _separator = ( argument_count > 1 ) ? argument[ 1 ] : "";
				return _object.to_string( _separator );
			}
			return string( _object );
			
		default:
			return string( _object );
	}
}

/// @func log
/// @desc Concatenates all arguments and outputs to console using show_debug_message
/// @arg {Any} [...]

function log() {
	var _s = "";

	for ( var i = 0; i < argument_count; i++ ) {
		_s += ( ( i > 0 ) ? " " : "" ) + to_string( argument[ i ] );
	}

	show_debug_message( _s );
}

#endregion

#region operators

/// @func _add
///
/// @desc Add values of two arguments
///
/// @arg {Number} a
/// @arg {Number} b
///
/// @return {Number} a + b
///
/// @example
/// _add( 2, 2 ) --> 4
///_add( "foo", "bar" ) --> "foobar:

function _add( a, b ) {
	return a + b;
}

/// @func bit_length
///
/// @desc Returns number of bits that are needed to represent a.
///
/// @arg {Number} a
///
/// @return {Number}
///
/// @example
/// bit_length( -37 ) --> 6 // -37 = -0b100101

function bit_length( a ) {
	return floor( log2 ( abs( a ) ) ) + 1;	
}

/// @func factorial
///
/// @desc Return x factorial as an integer.
///
/// @arg {Number} x
///
/// @return {Number}

function factorial( a ) {
	if ( ( a < 0 ) || ( a != floor( a ) ) ) {
		throw "factorial only supports positive integer values";
	}
	
	if ( a < 21 ) {
		return SMALL_FACTORIALS[ a ];	
	}
	
	var num_of_set_bits = function( i ) {
		i = i - ( ( i >> 1 ) & $55555555 );
		i = ( i & $33333333 ) + ( ( i >> 2 ) & $33333333 );
		return ( ( ( i + ( i >> 4 ) & $F0F0F0F ) * $1010101 ) & $ffffffff ) >> 24;
	}
	
	var _inner = 1;
	var _outer = 1;
	var n = bit_length( a );
	
	for ( var i = n; i >= 0; i-- ) {
		_inner *= range_prod( ( ( a >> ( i + 1 ) ) + 1 ) | 1, ( ( a >> i ) + 1 ) | 1, 2 );
		_outer *= _inner;
	}
	
	return 1.0 * _outer << ( a - num_of_set_bits( a ) );
}

/// @func _div
///
/// @desc Divides first argment by the secone one
/// @see _floordiv
///
/// @arg {Number} a
/// @arg {Number} b
///
/// @return {Number} a / b
///
/// @example
/// _div( 4, 2 ) --> 2

function _div( a, b ) {
	return a / b;
}

/// @func _floordiv
///
/// @desc Divides first argment by the secone one and returns integer part.
/// @see _div
///
/// @arg {Number} a
/// @arg {Number} b
///
/// @return {Number} a div b
///
/// @example
/// _div( 5, 2 ) --> 2.50
///_floordiv( 5, 2 ) --> 2

function _floordiv( a, b ) {
	return a div b;
}

/// @func _identity
///
/// @desc Function that returns it's argument
///
/// @arg {Any} a
///
/// @return {Any} a
///
/// @example
/// _identity( 10 ) --> 10

function _identity( a ) {
	return a;
}

/// @func is_between
///
/// @desc Check if value is in range [ a, b ]
///
/// @arg {Number} value
/// @arg {Number} a
/// @arg {Number} b
///
/// @return {Bool}

function is_between( _value, a, b ) {
	return ( b > a ) ? ( ( _value >= a ) && ( _value <= b ) ) : ( ( _value <= a ) && ( _value >= b ) );
}

/// @func _max
///
/// @desc Returns largest of the input values
///
/// @arg {Number} _a
/// @arg {Number} _b
/// @arg {Number} [...]
///
/// @return {Number} Largest of the input values
///
/// @example
/// _max( 1, 2, 3 ) --> 3

_max = function( _a, _b ) {
	var _result = _a;
	var _n = argument_count;
	
	for( var i = 1; i < _n; ++i ) {
		_result = max( _result, argument[ i ] );	
	}
	
	return _result;
}

/// @func _min
///
/// @desc Returns smallest of the input values
///
/// @arg {Number} _a
/// @arg {Number} _b
/// @arg {Number} [...]
///
/// @return {Number} Smallest of the input values
///
/// @example
/// _min( 1, 2, 3 ) --> 1

_min = function( _a, _b ) {
	var _result = _a;
	var _n = argument_count;
	
	for( var i = 1; i < _n; ++i ) {
		_result = min( _result, argument[ i ] );	
	}
	
	return _result;
}

/// @func _mod
///
/// @desc Divides first argment by the secone one and returns modulus.
/// @see _rem
///
/// @arg {Number} a
/// @arg {Number} b
///
/// @return {Number} modulus of a divided by b
///
/// @example
/// _mod( 4, 2 ) --> 0

function _mod( a, b ) {
	return ( ( a % b ) + b ) % b;
}

/// @func _mul
///
/// @desc Multiplies argument values
///
/// @arg {Number} a
/// @arg {Number} b
///
/// @return {Number} a * b
///
/// @example
/// _mul( 2, 2 ) --> 4

function _mul( a, b ) {
	return a * b;
}

/// @func _rem
///
/// @desc Divides first argment by the secone one and returns remainder.
/// @see _mod
///
/// @arg {Number} a
/// @arg {Number} b
///
/// @return {Number} a % b
///
/// @example
/// _rem( 4, 2 ) --> 0

function _rem( a, b ) {
	return a % b;
}

/// @func _pow
///
/// @desc Substract second argument from the first one
///
/// @arg {Number} a
/// @arg {Number} b
///
/// @return {Number} power( a, b )
///
/// @example
/// _pow( 2, 2 ) --> 4

function _pow( a, b ) {
	return power( a, b );
}

/// @func _sub
///
/// @desc Substract second argument from the first one
///
/// @arg {Number} a
/// @arg {Number} b
///
/// @return {Number} a - b
///
/// @example
/// _sub( 4, 2 ) --> 2

function _sub( a, b ) {
	return a - b;
}

/// @func _truth
///
/// @desc Returns if argument is true
///
/// @arg {Any} a
///
/// @return {Bool} Boolean representation of object
///
/// @example
/// _truth( 1 ) --> true
///_truth( 0.2 ) --> false

function _truth( a ) {
	return bool( a );
}

#endregion
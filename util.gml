#region test

/// @func assert
///
/// @desc Asserts that a condition is true. If it isn't it throws an error with the given message.
///
/// @arg {Bool} condidion
/// @arg {String} message

assert = function( _condition, _message ) {
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

assert_equals = function( _expected, _actual, _message ) {
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

assert_array_equals = function( _expected, _actual, _message ) {
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

_list = function( ) {
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

_stack = function() {
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

_queue = function() {
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

_map = function() {
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

_priority = function() {
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

/// @func _min
/// @arg {Any} _a
/// @arg {Any} _b
/// @arg {Any} [...]

_min = function( _a, _b ) {
	var _result = _a;
	var _n = argument_count;
	
	for( var i = 1; i < _n; ++i ) {
		_result = min( _result, argument[ i ] );	
	}
	
	return _result;
}

/// @func _max
/// @arg {Any} _a
/// @arg {Any} _b
/// @arg {Any} [...]

_max = function( _a, _b ) {
	var _result = _a;
	var _n = argument_count;
	
	for( var i = 1; i < _n; ++i ) {
		_result = max( _result, argument[ i ] );	
	}
	
	return _result;
}

/// @func to_string
/// @desc Returs string representation of object
/// @arg object
/// @arg [separator]

to_string = function( _object, _separator ) {
	switch typeof( _object ) {
		case "struct":
			if ( variable_struct_exists( _object, "to_string" ) ) {
				return _object.to_string( _separator );
			}
			return string( _object );
			
		default:
			return string( _object );
	}
}

/// @func log
/// @desc Concatenates all arguments and outputs to console using show_debug_message
/// @arg {Any} ...

function log() {
	var _s = "";

	for ( var i = 0; i < argument_count; i++ ) {
		_s += ( i > 0 ) ? " " + to_string( argument[ i ] ) : to_string( argument[ i ] );
	}

	show_debug_message( _s );
}

#endregion

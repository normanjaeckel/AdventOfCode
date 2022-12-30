(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}




var _List_Nil = { $: 0 };
var _List_Nil_UNUSED = { $: '[]' };

function _List_Cons(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons_UNUSED(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === $elm$core$Basics$EQ ? 0 : ord === $elm$core$Basics$LT ? -1 : 1;
	}));
});



var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log = F2(function(tag, value)
{
	return value;
});

var _Debug_log_UNUSED = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString(value)
{
	return '<internals>';
}

function _Debug_toString_UNUSED(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof DataView === 'function' && value instanceof DataView)
	{
		return _Debug_stringColor(ansi, '<' + value.byteLength + ' bytes>');
	}

	if (typeof File !== 'undefined' && value instanceof File)
	{
		return _Debug_internalColor(ansi, '<' + value.name + '>');
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[36m' + string + '\x1b[0m' : string;
}

function _Debug_toHexDigit(n)
{
	return String.fromCharCode(n < 10 ? 48 + n : 55 + n);
}


// CRASH


function _Debug_crash(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash_UNUSED(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.J.aR === region.al.aR)
	{
		return 'on line ' + region.J.aR;
	}
	return 'on lines ' + region.J.aR + ' through ' + region.al.aR;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	/**_UNUSED/
	if (x.$ === 'Set_elm_builtin')
	{
		x = $elm$core$Set$toList(x);
		y = $elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	/**/
	if (x.$ < 0)
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**_UNUSED/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**/
	if (typeof x.$ === 'undefined')
	//*/
	/**_UNUSED/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? $elm$core$Basics$LT : n ? $elm$core$Basics$GT : $elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0 = 0;
var _Utils_Tuple0_UNUSED = { $: '#0' };

function _Utils_Tuple2(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2_UNUSED(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3_UNUSED(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr(c) { return c; }
function _Utils_chr_UNUSED(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return !isNaN(word)
		? $elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: $elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return $elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? $elm$core$Maybe$Nothing
		: $elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return $elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? $elm$core$Maybe$Just(n) : $elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800, code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



/**_UNUSED/
function _Json_errorToString(error)
{
	return $elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

function _Json_decodePrim(decoder)
{
	return { $: 2, b: decoder };
}

var _Json_decodeInt = _Json_decodePrim(function(value) {
	return (typeof value !== 'number')
		? _Json_expecting('an INT', value)
		:
	(-2147483647 < value && value < 2147483647 && (value | 0) === value)
		? $elm$core$Result$Ok(value)
		:
	(isFinite(value) && !(value % 1))
		? $elm$core$Result$Ok(value)
		: _Json_expecting('an INT', value);
});

var _Json_decodeBool = _Json_decodePrim(function(value) {
	return (typeof value === 'boolean')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a BOOL', value);
});

var _Json_decodeFloat = _Json_decodePrim(function(value) {
	return (typeof value === 'number')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a FLOAT', value);
});

var _Json_decodeValue = _Json_decodePrim(function(value) {
	return $elm$core$Result$Ok(_Json_wrap(value));
});

var _Json_decodeString = _Json_decodePrim(function(value) {
	return (typeof value === 'string')
		? $elm$core$Result$Ok(value)
		: (value instanceof String)
			? $elm$core$Result$Ok(value + '')
			: _Json_expecting('a STRING', value);
});

function _Json_decodeList(decoder) { return { $: 3, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 4, b: decoder }; }

function _Json_decodeNull(value) { return { $: 5, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 6,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 7,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 8,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 9,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 10,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 11,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 2:
			return decoder.b(value);

		case 5:
			return (value === null)
				? $elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 3:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 4:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 6:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, field, result.a));

		case 7:
			var index = decoder.e;
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, index, result.a));

		case 8:
			if (typeof value !== 'object' || value === null || _Json_isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!$elm$core$Result$isOk(result))
					{
						return $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return $elm$core$Result$Ok($elm$core$List$reverse(keyValuePairs));

		case 9:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!$elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return $elm$core$Result$Ok(answer);

		case 10:
			var result = _Json_runHelp(decoder.b, value);
			return (!$elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 11:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if ($elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return $elm$core$Result$Err($elm$json$Json$Decode$OneOf($elm$core$List$reverse(errors)));

		case 1:
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return $elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!$elm$core$Result$isOk(result))
		{
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return $elm$core$Result$Ok(toElmValue(array));
}

function _Json_isArray(value)
{
	return Array.isArray(value) || (typeof FileList !== 'undefined' && value instanceof FileList);
}

function _Json_toElmArray(array)
{
	return A2($elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 2:
			return x.b === y.b;

		case 5:
			return x.c === y.c;

		case 3:
		case 4:
		case 8:
			return _Json_equality(x.b, y.b);

		case 6:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 7:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 9:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 10:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 11:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap_UNUSED(value) { return { $: 0, a: value }; }
function _Json_unwrap_UNUSED(value) { return value.a; }

function _Json_wrap(value) { return value; }
function _Json_unwrap(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.c0,
		impl.dx,
		impl.dr,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**_UNUSED/, _Json_errorToString(result.a) /**/);
	var managers = {};
	var initPair = init(result.a);
	var model = initPair.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		var pair = A2(update, msg, model);
		stepper(model = pair.a, viewMetadata);
		_Platform_enqueueEffects(managers, pair.b, subscriptions(model));
	}

	_Platform_enqueueEffects(managers, initPair.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS
//
// Effects must be queued!
//
// Say your init contains a synchronous command, like Time.now or Time.here
//
//   - This will produce a batch of effects (FX_1)
//   - The synchronous task triggers the subsequent `update` call
//   - This will produce a batch of effects (FX_2)
//
// If we just start dispatching FX_2, subscriptions from FX_2 can be processed
// before subscriptions from FX_1. No good! Earlier versions of this code had
// this problem, leading to these reports:
//
//   https://github.com/elm/core/issues/980
//   https://github.com/elm/core/pull/981
//   https://github.com/elm/compiler/issues/1776
//
// The queue is necessary to avoid ordering issues for synchronous commands.


// Why use true/false here? Why not just check the length of the queue?
// The goal is to detect "are we currently dispatching effects?" If we
// are, we need to bail and let the ongoing while loop handle things.
//
// Now say the queue has 1 element. When we dequeue the final element,
// the queue will be empty, but we are still actively dispatching effects.
// So you could get queue jumping in a really tricky category of cases.
//
var _Platform_effectsQueue = [];
var _Platform_effectsActive = false;


function _Platform_enqueueEffects(managers, cmdBag, subBag)
{
	_Platform_effectsQueue.push({ p: managers, q: cmdBag, r: subBag });

	if (_Platform_effectsActive) return;

	_Platform_effectsActive = true;
	for (var fx; fx = _Platform_effectsQueue.shift(); )
	{
		_Platform_dispatchEffects(fx.p, fx.q, fx.r);
	}
	_Platform_effectsActive = false;
}


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				s: bag.n,
				t: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.t)
		{
			x = temp.s(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		u: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		u: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		$elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}




// HELPERS


var _VirtualDom_divertHrefToApp;

var _VirtualDom_doc = typeof document !== 'undefined' ? document : {};


function _VirtualDom_appendChild(parent, child)
{
	parent.appendChild(child);
}

var _VirtualDom_init = F4(function(virtualNode, flagDecoder, debugMetadata, args)
{
	// NOTE: this function needs _Platform_export available to work

	/**/
	var node = args['node'];
	//*/
	/**_UNUSED/
	var node = args && args['node'] ? args['node'] : _Debug_crash(0);
	//*/

	node.parentNode.replaceChild(
		_VirtualDom_render(virtualNode, function() {}),
		node
	);

	return {};
});



// TEXT


function _VirtualDom_text(string)
{
	return {
		$: 0,
		a: string
	};
}



// NODE


var _VirtualDom_nodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 1,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_node = _VirtualDom_nodeNS(undefined);



// KEYED NODE


var _VirtualDom_keyedNodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 2,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_keyedNode = _VirtualDom_keyedNodeNS(undefined);



// CUSTOM


function _VirtualDom_custom(factList, model, render, diff)
{
	return {
		$: 3,
		d: _VirtualDom_organizeFacts(factList),
		g: model,
		h: render,
		i: diff
	};
}



// MAP


var _VirtualDom_map = F2(function(tagger, node)
{
	return {
		$: 4,
		j: tagger,
		k: node,
		b: 1 + (node.b || 0)
	};
});



// LAZY


function _VirtualDom_thunk(refs, thunk)
{
	return {
		$: 5,
		l: refs,
		m: thunk,
		k: undefined
	};
}

var _VirtualDom_lazy = F2(function(func, a)
{
	return _VirtualDom_thunk([func, a], function() {
		return func(a);
	});
});

var _VirtualDom_lazy2 = F3(function(func, a, b)
{
	return _VirtualDom_thunk([func, a, b], function() {
		return A2(func, a, b);
	});
});

var _VirtualDom_lazy3 = F4(function(func, a, b, c)
{
	return _VirtualDom_thunk([func, a, b, c], function() {
		return A3(func, a, b, c);
	});
});

var _VirtualDom_lazy4 = F5(function(func, a, b, c, d)
{
	return _VirtualDom_thunk([func, a, b, c, d], function() {
		return A4(func, a, b, c, d);
	});
});

var _VirtualDom_lazy5 = F6(function(func, a, b, c, d, e)
{
	return _VirtualDom_thunk([func, a, b, c, d, e], function() {
		return A5(func, a, b, c, d, e);
	});
});

var _VirtualDom_lazy6 = F7(function(func, a, b, c, d, e, f)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f], function() {
		return A6(func, a, b, c, d, e, f);
	});
});

var _VirtualDom_lazy7 = F8(function(func, a, b, c, d, e, f, g)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g], function() {
		return A7(func, a, b, c, d, e, f, g);
	});
});

var _VirtualDom_lazy8 = F9(function(func, a, b, c, d, e, f, g, h)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g, h], function() {
		return A8(func, a, b, c, d, e, f, g, h);
	});
});



// FACTS


var _VirtualDom_on = F2(function(key, handler)
{
	return {
		$: 'a0',
		n: key,
		o: handler
	};
});
var _VirtualDom_style = F2(function(key, value)
{
	return {
		$: 'a1',
		n: key,
		o: value
	};
});
var _VirtualDom_property = F2(function(key, value)
{
	return {
		$: 'a2',
		n: key,
		o: value
	};
});
var _VirtualDom_attribute = F2(function(key, value)
{
	return {
		$: 'a3',
		n: key,
		o: value
	};
});
var _VirtualDom_attributeNS = F3(function(namespace, key, value)
{
	return {
		$: 'a4',
		n: key,
		o: { f: namespace, o: value }
	};
});



// XSS ATTACK VECTOR CHECKS
//
// For some reason, tabs can appear in href protocols and it still works.
// So '\tjava\tSCRIPT:alert("!!!")' and 'javascript:alert("!!!")' are the same
// in practice. That is why _VirtualDom_RE_js and _VirtualDom_RE_js_html look
// so freaky.
//
// Pulling the regular expressions out to the top level gives a slight speed
// boost in small benchmarks (4-10%) but hoisting values to reduce allocation
// can be unpredictable in large programs where JIT may have a harder time with
// functions are not fully self-contained. The benefit is more that the js and
// js_html ones are so weird that I prefer to see them near each other.


var _VirtualDom_RE_script = /^script$/i;
var _VirtualDom_RE_on_formAction = /^(on|formAction$)/i;
var _VirtualDom_RE_js = /^\s*j\s*a\s*v\s*a\s*s\s*c\s*r\s*i\s*p\s*t\s*:/i;
var _VirtualDom_RE_js_html = /^\s*(j\s*a\s*v\s*a\s*s\s*c\s*r\s*i\s*p\s*t\s*:|d\s*a\s*t\s*a\s*:\s*t\s*e\s*x\s*t\s*\/\s*h\s*t\s*m\s*l\s*(,|;))/i;


function _VirtualDom_noScript(tag)
{
	return _VirtualDom_RE_script.test(tag) ? 'p' : tag;
}

function _VirtualDom_noOnOrFormAction(key)
{
	return _VirtualDom_RE_on_formAction.test(key) ? 'data-' + key : key;
}

function _VirtualDom_noInnerHtmlOrFormAction(key)
{
	return key == 'innerHTML' || key == 'formAction' ? 'data-' + key : key;
}

function _VirtualDom_noJavaScriptUri(value)
{
	return _VirtualDom_RE_js.test(value)
		? /**/''//*//**_UNUSED/'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'//*/
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlUri(value)
{
	return _VirtualDom_RE_js_html.test(value)
		? /**/''//*//**_UNUSED/'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'//*/
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlJson(value)
{
	return (typeof _Json_unwrap(value) === 'string' && _VirtualDom_RE_js_html.test(_Json_unwrap(value)))
		? _Json_wrap(
			/**/''//*//**_UNUSED/'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'//*/
		) : value;
}



// MAP FACTS


var _VirtualDom_mapAttribute = F2(function(func, attr)
{
	return (attr.$ === 'a0')
		? A2(_VirtualDom_on, attr.n, _VirtualDom_mapHandler(func, attr.o))
		: attr;
});

function _VirtualDom_mapHandler(func, handler)
{
	var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

	// 0 = Normal
	// 1 = MayStopPropagation
	// 2 = MayPreventDefault
	// 3 = Custom

	return {
		$: handler.$,
		a:
			!tag
				? A2($elm$json$Json$Decode$map, func, handler.a)
				:
			A3($elm$json$Json$Decode$map2,
				tag < 3
					? _VirtualDom_mapEventTuple
					: _VirtualDom_mapEventRecord,
				$elm$json$Json$Decode$succeed(func),
				handler.a
			)
	};
}

var _VirtualDom_mapEventTuple = F2(function(func, tuple)
{
	return _Utils_Tuple2(func(tuple.a), tuple.b);
});

var _VirtualDom_mapEventRecord = F2(function(func, record)
{
	return {
		aa: func(record.aa),
		bH: record.bH,
		bE: record.bE
	}
});



// ORGANIZE FACTS


function _VirtualDom_organizeFacts(factList)
{
	for (var facts = {}; factList.b; factList = factList.b) // WHILE_CONS
	{
		var entry = factList.a;

		var tag = entry.$;
		var key = entry.n;
		var value = entry.o;

		if (tag === 'a2')
		{
			(key === 'className')
				? _VirtualDom_addClass(facts, key, _Json_unwrap(value))
				: facts[key] = _Json_unwrap(value);

			continue;
		}

		var subFacts = facts[tag] || (facts[tag] = {});
		(tag === 'a3' && key === 'class')
			? _VirtualDom_addClass(subFacts, key, value)
			: subFacts[key] = value;
	}

	return facts;
}

function _VirtualDom_addClass(object, key, newClass)
{
	var classes = object[key];
	object[key] = classes ? classes + ' ' + newClass : newClass;
}



// RENDER


function _VirtualDom_render(vNode, eventNode)
{
	var tag = vNode.$;

	if (tag === 5)
	{
		return _VirtualDom_render(vNode.k || (vNode.k = vNode.m()), eventNode);
	}

	if (tag === 0)
	{
		return _VirtualDom_doc.createTextNode(vNode.a);
	}

	if (tag === 4)
	{
		var subNode = vNode.k;
		var tagger = vNode.j;

		while (subNode.$ === 4)
		{
			typeof tagger !== 'object'
				? tagger = [tagger, subNode.j]
				: tagger.push(subNode.j);

			subNode = subNode.k;
		}

		var subEventRoot = { j: tagger, p: eventNode };
		var domNode = _VirtualDom_render(subNode, subEventRoot);
		domNode.elm_event_node_ref = subEventRoot;
		return domNode;
	}

	if (tag === 3)
	{
		var domNode = vNode.h(vNode.g);
		_VirtualDom_applyFacts(domNode, eventNode, vNode.d);
		return domNode;
	}

	// at this point `tag` must be 1 or 2

	var domNode = vNode.f
		? _VirtualDom_doc.createElementNS(vNode.f, vNode.c)
		: _VirtualDom_doc.createElement(vNode.c);

	if (_VirtualDom_divertHrefToApp && vNode.c == 'a')
	{
		domNode.addEventListener('click', _VirtualDom_divertHrefToApp(domNode));
	}

	_VirtualDom_applyFacts(domNode, eventNode, vNode.d);

	for (var kids = vNode.e, i = 0; i < kids.length; i++)
	{
		_VirtualDom_appendChild(domNode, _VirtualDom_render(tag === 1 ? kids[i] : kids[i].b, eventNode));
	}

	return domNode;
}



// APPLY FACTS


function _VirtualDom_applyFacts(domNode, eventNode, facts)
{
	for (var key in facts)
	{
		var value = facts[key];

		key === 'a1'
			? _VirtualDom_applyStyles(domNode, value)
			:
		key === 'a0'
			? _VirtualDom_applyEvents(domNode, eventNode, value)
			:
		key === 'a3'
			? _VirtualDom_applyAttrs(domNode, value)
			:
		key === 'a4'
			? _VirtualDom_applyAttrsNS(domNode, value)
			:
		((key !== 'value' && key !== 'checked') || domNode[key] !== value) && (domNode[key] = value);
	}
}



// APPLY STYLES


function _VirtualDom_applyStyles(domNode, styles)
{
	var domNodeStyle = domNode.style;

	for (var key in styles)
	{
		domNodeStyle[key] = styles[key];
	}
}



// APPLY ATTRS


function _VirtualDom_applyAttrs(domNode, attrs)
{
	for (var key in attrs)
	{
		var value = attrs[key];
		typeof value !== 'undefined'
			? domNode.setAttribute(key, value)
			: domNode.removeAttribute(key);
	}
}



// APPLY NAMESPACED ATTRS


function _VirtualDom_applyAttrsNS(domNode, nsAttrs)
{
	for (var key in nsAttrs)
	{
		var pair = nsAttrs[key];
		var namespace = pair.f;
		var value = pair.o;

		typeof value !== 'undefined'
			? domNode.setAttributeNS(namespace, key, value)
			: domNode.removeAttributeNS(namespace, key);
	}
}



// APPLY EVENTS


function _VirtualDom_applyEvents(domNode, eventNode, events)
{
	var allCallbacks = domNode.elmFs || (domNode.elmFs = {});

	for (var key in events)
	{
		var newHandler = events[key];
		var oldCallback = allCallbacks[key];

		if (!newHandler)
		{
			domNode.removeEventListener(key, oldCallback);
			allCallbacks[key] = undefined;
			continue;
		}

		if (oldCallback)
		{
			var oldHandler = oldCallback.q;
			if (oldHandler.$ === newHandler.$)
			{
				oldCallback.q = newHandler;
				continue;
			}
			domNode.removeEventListener(key, oldCallback);
		}

		oldCallback = _VirtualDom_makeCallback(eventNode, newHandler);
		domNode.addEventListener(key, oldCallback,
			_VirtualDom_passiveSupported
			&& { passive: $elm$virtual_dom$VirtualDom$toHandlerInt(newHandler) < 2 }
		);
		allCallbacks[key] = oldCallback;
	}
}



// PASSIVE EVENTS


var _VirtualDom_passiveSupported;

try
{
	window.addEventListener('t', null, Object.defineProperty({}, 'passive', {
		get: function() { _VirtualDom_passiveSupported = true; }
	}));
}
catch(e) {}



// EVENT HANDLERS


function _VirtualDom_makeCallback(eventNode, initialHandler)
{
	function callback(event)
	{
		var handler = callback.q;
		var result = _Json_runHelp(handler.a, event);

		if (!$elm$core$Result$isOk(result))
		{
			return;
		}

		var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

		// 0 = Normal
		// 1 = MayStopPropagation
		// 2 = MayPreventDefault
		// 3 = Custom

		var value = result.a;
		var message = !tag ? value : tag < 3 ? value.a : value.aa;
		var stopPropagation = tag == 1 ? value.b : tag == 3 && value.bH;
		var currentEventNode = (
			stopPropagation && event.stopPropagation(),
			(tag == 2 ? value.b : tag == 3 && value.bE) && event.preventDefault(),
			eventNode
		);
		var tagger;
		var i;
		while (tagger = currentEventNode.j)
		{
			if (typeof tagger == 'function')
			{
				message = tagger(message);
			}
			else
			{
				for (var i = tagger.length; i--; )
				{
					message = tagger[i](message);
				}
			}
			currentEventNode = currentEventNode.p;
		}
		currentEventNode(message, stopPropagation); // stopPropagation implies isSync
	}

	callback.q = initialHandler;

	return callback;
}

function _VirtualDom_equalEvents(x, y)
{
	return x.$ == y.$ && _Json_equality(x.a, y.a);
}



// DIFF


// TODO: Should we do patches like in iOS?
//
// type Patch
//   = At Int Patch
//   | Batch (List Patch)
//   | Change ...
//
// How could it not be better?
//
function _VirtualDom_diff(x, y)
{
	var patches = [];
	_VirtualDom_diffHelp(x, y, patches, 0);
	return patches;
}


function _VirtualDom_pushPatch(patches, type, index, data)
{
	var patch = {
		$: type,
		r: index,
		s: data,
		t: undefined,
		u: undefined
	};
	patches.push(patch);
	return patch;
}


function _VirtualDom_diffHelp(x, y, patches, index)
{
	if (x === y)
	{
		return;
	}

	var xType = x.$;
	var yType = y.$;

	// Bail if you run into different types of nodes. Implies that the
	// structure has changed significantly and it's not worth a diff.
	if (xType !== yType)
	{
		if (xType === 1 && yType === 2)
		{
			y = _VirtualDom_dekey(y);
			yType = 1;
		}
		else
		{
			_VirtualDom_pushPatch(patches, 0, index, y);
			return;
		}
	}

	// Now we know that both nodes are the same $.
	switch (yType)
	{
		case 5:
			var xRefs = x.l;
			var yRefs = y.l;
			var i = xRefs.length;
			var same = i === yRefs.length;
			while (same && i--)
			{
				same = xRefs[i] === yRefs[i];
			}
			if (same)
			{
				y.k = x.k;
				return;
			}
			y.k = y.m();
			var subPatches = [];
			_VirtualDom_diffHelp(x.k, y.k, subPatches, 0);
			subPatches.length > 0 && _VirtualDom_pushPatch(patches, 1, index, subPatches);
			return;

		case 4:
			// gather nested taggers
			var xTaggers = x.j;
			var yTaggers = y.j;
			var nesting = false;

			var xSubNode = x.k;
			while (xSubNode.$ === 4)
			{
				nesting = true;

				typeof xTaggers !== 'object'
					? xTaggers = [xTaggers, xSubNode.j]
					: xTaggers.push(xSubNode.j);

				xSubNode = xSubNode.k;
			}

			var ySubNode = y.k;
			while (ySubNode.$ === 4)
			{
				nesting = true;

				typeof yTaggers !== 'object'
					? yTaggers = [yTaggers, ySubNode.j]
					: yTaggers.push(ySubNode.j);

				ySubNode = ySubNode.k;
			}

			// Just bail if different numbers of taggers. This implies the
			// structure of the virtual DOM has changed.
			if (nesting && xTaggers.length !== yTaggers.length)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			// check if taggers are "the same"
			if (nesting ? !_VirtualDom_pairwiseRefEqual(xTaggers, yTaggers) : xTaggers !== yTaggers)
			{
				_VirtualDom_pushPatch(patches, 2, index, yTaggers);
			}

			// diff everything below the taggers
			_VirtualDom_diffHelp(xSubNode, ySubNode, patches, index + 1);
			return;

		case 0:
			if (x.a !== y.a)
			{
				_VirtualDom_pushPatch(patches, 3, index, y.a);
			}
			return;

		case 1:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKids);
			return;

		case 2:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKeyedKids);
			return;

		case 3:
			if (x.h !== y.h)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
			factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

			var patch = y.i(x.g, y.g);
			patch && _VirtualDom_pushPatch(patches, 5, index, patch);

			return;
	}
}

// assumes the incoming arrays are the same length
function _VirtualDom_pairwiseRefEqual(as, bs)
{
	for (var i = 0; i < as.length; i++)
	{
		if (as[i] !== bs[i])
		{
			return false;
		}
	}

	return true;
}

function _VirtualDom_diffNodes(x, y, patches, index, diffKids)
{
	// Bail if obvious indicators have changed. Implies more serious
	// structural changes such that it's not worth it to diff.
	if (x.c !== y.c || x.f !== y.f)
	{
		_VirtualDom_pushPatch(patches, 0, index, y);
		return;
	}

	var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
	factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

	diffKids(x, y, patches, index);
}



// DIFF FACTS


// TODO Instead of creating a new diff object, it's possible to just test if
// there *is* a diff. During the actual patch, do the diff again and make the
// modifications directly. This way, there's no new allocations. Worth it?
function _VirtualDom_diffFacts(x, y, category)
{
	var diff;

	// look for changes and removals
	for (var xKey in x)
	{
		if (xKey === 'a1' || xKey === 'a0' || xKey === 'a3' || xKey === 'a4')
		{
			var subDiff = _VirtualDom_diffFacts(x[xKey], y[xKey] || {}, xKey);
			if (subDiff)
			{
				diff = diff || {};
				diff[xKey] = subDiff;
			}
			continue;
		}

		// remove if not in the new facts
		if (!(xKey in y))
		{
			diff = diff || {};
			diff[xKey] =
				!category
					? (typeof x[xKey] === 'string' ? '' : null)
					:
				(category === 'a1')
					? ''
					:
				(category === 'a0' || category === 'a3')
					? undefined
					:
				{ f: x[xKey].f, o: undefined };

			continue;
		}

		var xValue = x[xKey];
		var yValue = y[xKey];

		// reference equal, so don't worry about it
		if (xValue === yValue && xKey !== 'value' && xKey !== 'checked'
			|| category === 'a0' && _VirtualDom_equalEvents(xValue, yValue))
		{
			continue;
		}

		diff = diff || {};
		diff[xKey] = yValue;
	}

	// add new stuff
	for (var yKey in y)
	{
		if (!(yKey in x))
		{
			diff = diff || {};
			diff[yKey] = y[yKey];
		}
	}

	return diff;
}



// DIFF KIDS


function _VirtualDom_diffKids(xParent, yParent, patches, index)
{
	var xKids = xParent.e;
	var yKids = yParent.e;

	var xLen = xKids.length;
	var yLen = yKids.length;

	// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

	if (xLen > yLen)
	{
		_VirtualDom_pushPatch(patches, 6, index, {
			v: yLen,
			i: xLen - yLen
		});
	}
	else if (xLen < yLen)
	{
		_VirtualDom_pushPatch(patches, 7, index, {
			v: xLen,
			e: yKids
		});
	}

	// PAIRWISE DIFF EVERYTHING ELSE

	for (var minLen = xLen < yLen ? xLen : yLen, i = 0; i < minLen; i++)
	{
		var xKid = xKids[i];
		_VirtualDom_diffHelp(xKid, yKids[i], patches, ++index);
		index += xKid.b || 0;
	}
}



// KEYED DIFF


function _VirtualDom_diffKeyedKids(xParent, yParent, patches, rootIndex)
{
	var localPatches = [];

	var changes = {}; // Dict String Entry
	var inserts = []; // Array { index : Int, entry : Entry }
	// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

	var xKids = xParent.e;
	var yKids = yParent.e;
	var xLen = xKids.length;
	var yLen = yKids.length;
	var xIndex = 0;
	var yIndex = 0;

	var index = rootIndex;

	while (xIndex < xLen && yIndex < yLen)
	{
		var x = xKids[xIndex];
		var y = yKids[yIndex];

		var xKey = x.a;
		var yKey = y.a;
		var xNode = x.b;
		var yNode = y.b;

		var newMatch = undefined;
		var oldMatch = undefined;

		// check if keys match

		if (xKey === yKey)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNode, localPatches, index);
			index += xNode.b || 0;

			xIndex++;
			yIndex++;
			continue;
		}

		// look ahead 1 to detect insertions and removals.

		var xNext = xKids[xIndex + 1];
		var yNext = yKids[yIndex + 1];

		if (xNext)
		{
			var xNextKey = xNext.a;
			var xNextNode = xNext.b;
			oldMatch = yKey === xNextKey;
		}

		if (yNext)
		{
			var yNextKey = yNext.a;
			var yNextNode = yNext.b;
			newMatch = xKey === yNextKey;
		}


		// swap x and y
		if (newMatch && oldMatch)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			_VirtualDom_insertNode(changes, localPatches, xKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNextNode, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		// insert y
		if (newMatch)
		{
			index++;
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			index += xNode.b || 0;

			xIndex += 1;
			yIndex += 2;
			continue;
		}

		// remove x
		if (oldMatch)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 1;
			continue;
		}

		// remove x, insert y
		if (xNext && xNextKey === yNextKey)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNextNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		break;
	}

	// eat up any remaining nodes with removeNode and insertNode

	while (xIndex < xLen)
	{
		index++;
		var x = xKids[xIndex];
		var xNode = x.b;
		_VirtualDom_removeNode(changes, localPatches, x.a, xNode, index);
		index += xNode.b || 0;
		xIndex++;
	}

	while (yIndex < yLen)
	{
		var endInserts = endInserts || [];
		var y = yKids[yIndex];
		_VirtualDom_insertNode(changes, localPatches, y.a, y.b, undefined, endInserts);
		yIndex++;
	}

	if (localPatches.length > 0 || inserts.length > 0 || endInserts)
	{
		_VirtualDom_pushPatch(patches, 8, rootIndex, {
			w: localPatches,
			x: inserts,
			y: endInserts
		});
	}
}



// CHANGES FROM KEYED DIFF


var _VirtualDom_POSTFIX = '_elmW6BL';


function _VirtualDom_insertNode(changes, localPatches, key, vnode, yIndex, inserts)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		entry = {
			c: 0,
			z: vnode,
			r: yIndex,
			s: undefined
		};

		inserts.push({ r: yIndex, A: entry });
		changes[key] = entry;

		return;
	}

	// this key was removed earlier, a match!
	if (entry.c === 1)
	{
		inserts.push({ r: yIndex, A: entry });

		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(entry.z, vnode, subPatches, entry.r);
		entry.r = yIndex;
		entry.s.s = {
			w: subPatches,
			A: entry
		};

		return;
	}

	// this key has already been inserted or moved, a duplicate!
	_VirtualDom_insertNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, yIndex, inserts);
}


function _VirtualDom_removeNode(changes, localPatches, key, vnode, index)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		var patch = _VirtualDom_pushPatch(localPatches, 9, index, undefined);

		changes[key] = {
			c: 1,
			z: vnode,
			r: index,
			s: patch
		};

		return;
	}

	// this key was inserted earlier, a match!
	if (entry.c === 0)
	{
		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(vnode, entry.z, subPatches, index);

		_VirtualDom_pushPatch(localPatches, 9, index, {
			w: subPatches,
			A: entry
		});

		return;
	}

	// this key has already been removed or moved, a duplicate!
	_VirtualDom_removeNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, index);
}



// ADD DOM NODES
//
// Each DOM node has an "index" assigned in order of traversal. It is important
// to minimize our crawl over the actual DOM, so these indexes (along with the
// descendantsCount of virtual nodes) let us skip touching entire subtrees of
// the DOM if we know there are no patches there.


function _VirtualDom_addDomNodes(domNode, vNode, patches, eventNode)
{
	_VirtualDom_addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.b, eventNode);
}


// assumes `patches` is non-empty and indexes increase monotonically.
function _VirtualDom_addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
{
	var patch = patches[i];
	var index = patch.r;

	while (index === low)
	{
		var patchType = patch.$;

		if (patchType === 1)
		{
			_VirtualDom_addDomNodes(domNode, vNode.k, patch.s, eventNode);
		}
		else if (patchType === 8)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var subPatches = patch.s.w;
			if (subPatches.length > 0)
			{
				_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
			}
		}
		else if (patchType === 9)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var data = patch.s;
			if (data)
			{
				data.A.s = domNode;
				var subPatches = data.w;
				if (subPatches.length > 0)
				{
					_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
		}
		else
		{
			patch.t = domNode;
			patch.u = eventNode;
		}

		i++;

		if (!(patch = patches[i]) || (index = patch.r) > high)
		{
			return i;
		}
	}

	var tag = vNode.$;

	if (tag === 4)
	{
		var subNode = vNode.k;

		while (subNode.$ === 4)
		{
			subNode = subNode.k;
		}

		return _VirtualDom_addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);
	}

	// tag must be 1 or 2 at this point

	var vKids = vNode.e;
	var childNodes = domNode.childNodes;
	for (var j = 0; j < vKids.length; j++)
	{
		low++;
		var vKid = tag === 1 ? vKids[j] : vKids[j].b;
		var nextLow = low + (vKid.b || 0);
		if (low <= index && index <= nextLow)
		{
			i = _VirtualDom_addDomNodesHelp(childNodes[j], vKid, patches, i, low, nextLow, eventNode);
			if (!(patch = patches[i]) || (index = patch.r) > high)
			{
				return i;
			}
		}
		low = nextLow;
	}
	return i;
}



// APPLY PATCHES


function _VirtualDom_applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
{
	if (patches.length === 0)
	{
		return rootDomNode;
	}

	_VirtualDom_addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
	return _VirtualDom_applyPatchesHelp(rootDomNode, patches);
}

function _VirtualDom_applyPatchesHelp(rootDomNode, patches)
{
	for (var i = 0; i < patches.length; i++)
	{
		var patch = patches[i];
		var localDomNode = patch.t
		var newNode = _VirtualDom_applyPatch(localDomNode, patch);
		if (localDomNode === rootDomNode)
		{
			rootDomNode = newNode;
		}
	}
	return rootDomNode;
}

function _VirtualDom_applyPatch(domNode, patch)
{
	switch (patch.$)
	{
		case 0:
			return _VirtualDom_applyPatchRedraw(domNode, patch.s, patch.u);

		case 4:
			_VirtualDom_applyFacts(domNode, patch.u, patch.s);
			return domNode;

		case 3:
			domNode.replaceData(0, domNode.length, patch.s);
			return domNode;

		case 1:
			return _VirtualDom_applyPatchesHelp(domNode, patch.s);

		case 2:
			if (domNode.elm_event_node_ref)
			{
				domNode.elm_event_node_ref.j = patch.s;
			}
			else
			{
				domNode.elm_event_node_ref = { j: patch.s, p: patch.u };
			}
			return domNode;

		case 6:
			var data = patch.s;
			for (var i = 0; i < data.i; i++)
			{
				domNode.removeChild(domNode.childNodes[data.v]);
			}
			return domNode;

		case 7:
			var data = patch.s;
			var kids = data.e;
			var i = data.v;
			var theEnd = domNode.childNodes[i];
			for (; i < kids.length; i++)
			{
				domNode.insertBefore(_VirtualDom_render(kids[i], patch.u), theEnd);
			}
			return domNode;

		case 9:
			var data = patch.s;
			if (!data)
			{
				domNode.parentNode.removeChild(domNode);
				return domNode;
			}
			var entry = data.A;
			if (typeof entry.r !== 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
			}
			entry.s = _VirtualDom_applyPatchesHelp(domNode, data.w);
			return domNode;

		case 8:
			return _VirtualDom_applyPatchReorder(domNode, patch);

		case 5:
			return patch.s(domNode);

		default:
			_Debug_crash(10); // 'Ran into an unknown patch!'
	}
}


function _VirtualDom_applyPatchRedraw(domNode, vNode, eventNode)
{
	var parentNode = domNode.parentNode;
	var newNode = _VirtualDom_render(vNode, eventNode);

	if (!newNode.elm_event_node_ref)
	{
		newNode.elm_event_node_ref = domNode.elm_event_node_ref;
	}

	if (parentNode && newNode !== domNode)
	{
		parentNode.replaceChild(newNode, domNode);
	}
	return newNode;
}


function _VirtualDom_applyPatchReorder(domNode, patch)
{
	var data = patch.s;

	// remove end inserts
	var frag = _VirtualDom_applyPatchReorderEndInsertsHelp(data.y, patch);

	// removals
	domNode = _VirtualDom_applyPatchesHelp(domNode, data.w);

	// inserts
	var inserts = data.x;
	for (var i = 0; i < inserts.length; i++)
	{
		var insert = inserts[i];
		var entry = insert.A;
		var node = entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u);
		domNode.insertBefore(node, domNode.childNodes[insert.r]);
	}

	// add end inserts
	if (frag)
	{
		_VirtualDom_appendChild(domNode, frag);
	}

	return domNode;
}


function _VirtualDom_applyPatchReorderEndInsertsHelp(endInserts, patch)
{
	if (!endInserts)
	{
		return;
	}

	var frag = _VirtualDom_doc.createDocumentFragment();
	for (var i = 0; i < endInserts.length; i++)
	{
		var insert = endInserts[i];
		var entry = insert.A;
		_VirtualDom_appendChild(frag, entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u)
		);
	}
	return frag;
}


function _VirtualDom_virtualize(node)
{
	// TEXT NODES

	if (node.nodeType === 3)
	{
		return _VirtualDom_text(node.textContent);
	}


	// WEIRD NODES

	if (node.nodeType !== 1)
	{
		return _VirtualDom_text('');
	}


	// ELEMENT NODES

	var attrList = _List_Nil;
	var attrs = node.attributes;
	for (var i = attrs.length; i--; )
	{
		var attr = attrs[i];
		var name = attr.name;
		var value = attr.value;
		attrList = _List_Cons( A2(_VirtualDom_attribute, name, value), attrList );
	}

	var tag = node.tagName.toLowerCase();
	var kidList = _List_Nil;
	var kids = node.childNodes;

	for (var i = kids.length; i--; )
	{
		kidList = _List_Cons(_VirtualDom_virtualize(kids[i]), kidList);
	}
	return A3(_VirtualDom_node, tag, attrList, kidList);
}

function _VirtualDom_dekey(keyedNode)
{
	var keyedKids = keyedNode.e;
	var len = keyedKids.length;
	var kids = new Array(len);
	for (var i = 0; i < len; i++)
	{
		kids[i] = keyedKids[i].b;
	}

	return {
		$: 1,
		c: keyedNode.c,
		d: keyedNode.d,
		e: kids,
		f: keyedNode.f,
		b: keyedNode.b
	};
}




// ELEMENT


var _Debugger_element;

var _Browser_element = _Debugger_element || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.c0,
		impl.dx,
		impl.dr,
		function(sendToApp, initialModel) {
			var view = impl.dy;
			/**/
			var domNode = args['node'];
			//*/
			/**_UNUSED/
			var domNode = args && args['node'] ? args['node'] : _Debug_crash(0);
			//*/
			var currNode = _VirtualDom_virtualize(domNode);

			return _Browser_makeAnimator(initialModel, function(model)
			{
				var nextNode = view(model);
				var patches = _VirtualDom_diff(currNode, nextNode);
				domNode = _VirtualDom_applyPatches(domNode, currNode, patches, sendToApp);
				currNode = nextNode;
			});
		}
	);
});



// DOCUMENT


var _Debugger_document;

var _Browser_document = _Debugger_document || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.c0,
		impl.dx,
		impl.dr,
		function(sendToApp, initialModel) {
			var divertHrefToApp = impl.bG && impl.bG(sendToApp)
			var view = impl.dy;
			var title = _VirtualDom_doc.title;
			var bodyNode = _VirtualDom_doc.body;
			var currNode = _VirtualDom_virtualize(bodyNode);
			return _Browser_makeAnimator(initialModel, function(model)
			{
				_VirtualDom_divertHrefToApp = divertHrefToApp;
				var doc = view(model);
				var nextNode = _VirtualDom_node('body')(_List_Nil)(doc.cK);
				var patches = _VirtualDom_diff(currNode, nextNode);
				bodyNode = _VirtualDom_applyPatches(bodyNode, currNode, patches, sendToApp);
				currNode = nextNode;
				_VirtualDom_divertHrefToApp = 0;
				(title !== doc.du) && (_VirtualDom_doc.title = title = doc.du);
			});
		}
	);
});



// ANIMATION


var _Browser_cancelAnimationFrame =
	typeof cancelAnimationFrame !== 'undefined'
		? cancelAnimationFrame
		: function(id) { clearTimeout(id); };

var _Browser_requestAnimationFrame =
	typeof requestAnimationFrame !== 'undefined'
		? requestAnimationFrame
		: function(callback) { return setTimeout(callback, 1000 / 60); };


function _Browser_makeAnimator(model, draw)
{
	draw(model);

	var state = 0;

	function updateIfNeeded()
	{
		state = state === 1
			? 0
			: ( _Browser_requestAnimationFrame(updateIfNeeded), draw(model), 1 );
	}

	return function(nextModel, isSync)
	{
		model = nextModel;

		isSync
			? ( draw(model),
				state === 2 && (state = 1)
				)
			: ( state === 0 && _Browser_requestAnimationFrame(updateIfNeeded),
				state = 2
				);
	};
}



// APPLICATION


function _Browser_application(impl)
{
	var onUrlChange = impl.dg;
	var onUrlRequest = impl.dh;
	var key = function() { key.a(onUrlChange(_Browser_getUrl())); };

	return _Browser_document({
		bG: function(sendToApp)
		{
			key.a = sendToApp;
			_Browser_window.addEventListener('popstate', key);
			_Browser_window.navigator.userAgent.indexOf('Trident') < 0 || _Browser_window.addEventListener('hashchange', key);

			return F2(function(domNode, event)
			{
				if (!event.ctrlKey && !event.metaKey && !event.shiftKey && event.button < 1 && !domNode.target && !domNode.hasAttribute('download'))
				{
					event.preventDefault();
					var href = domNode.href;
					var curr = _Browser_getUrl();
					var next = $elm$url$Url$fromString(href).a;
					sendToApp(onUrlRequest(
						(next
							&& curr.cm === next.cm
							&& curr.b3 === next.b3
							&& curr.ci.a === next.ci.a
						)
							? $elm$browser$Browser$Internal(next)
							: $elm$browser$Browser$External(href)
					));
				}
			});
		},
		c0: function(flags)
		{
			return A3(impl.c0, flags, _Browser_getUrl(), key);
		},
		dy: impl.dy,
		dx: impl.dx,
		dr: impl.dr
	});
}

function _Browser_getUrl()
{
	return $elm$url$Url$fromString(_VirtualDom_doc.location.href).a || _Debug_crash(1);
}

var _Browser_go = F2(function(key, n)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		n && history.go(n);
		key();
	}));
});

var _Browser_pushUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.pushState({}, '', url);
		key();
	}));
});

var _Browser_replaceUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.replaceState({}, '', url);
		key();
	}));
});



// GLOBAL EVENTS


var _Browser_fakeNode = { addEventListener: function() {}, removeEventListener: function() {} };
var _Browser_doc = typeof document !== 'undefined' ? document : _Browser_fakeNode;
var _Browser_window = typeof window !== 'undefined' ? window : _Browser_fakeNode;

var _Browser_on = F3(function(node, eventName, sendToSelf)
{
	return _Scheduler_spawn(_Scheduler_binding(function(callback)
	{
		function handler(event)	{ _Scheduler_rawSpawn(sendToSelf(event)); }
		node.addEventListener(eventName, handler, _VirtualDom_passiveSupported && { passive: true });
		return function() { node.removeEventListener(eventName, handler); };
	}));
});

var _Browser_decodeEvent = F2(function(decoder, event)
{
	var result = _Json_runHelp(decoder, event);
	return $elm$core$Result$isOk(result) ? $elm$core$Maybe$Just(result.a) : $elm$core$Maybe$Nothing;
});



// PAGE VISIBILITY


function _Browser_visibilityInfo()
{
	return (typeof _VirtualDom_doc.hidden !== 'undefined')
		? { cZ: 'hidden', cN: 'visibilitychange' }
		:
	(typeof _VirtualDom_doc.mozHidden !== 'undefined')
		? { cZ: 'mozHidden', cN: 'mozvisibilitychange' }
		:
	(typeof _VirtualDom_doc.msHidden !== 'undefined')
		? { cZ: 'msHidden', cN: 'msvisibilitychange' }
		:
	(typeof _VirtualDom_doc.webkitHidden !== 'undefined')
		? { cZ: 'webkitHidden', cN: 'webkitvisibilitychange' }
		: { cZ: 'hidden', cN: 'visibilitychange' };
}



// ANIMATION FRAMES


function _Browser_rAF()
{
	return _Scheduler_binding(function(callback)
	{
		var id = _Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(Date.now()));
		});

		return function() {
			_Browser_cancelAnimationFrame(id);
		};
	});
}


function _Browser_now()
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(Date.now()));
	});
}



// DOM STUFF


function _Browser_withNode(id, doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			var node = document.getElementById(id);
			callback(node
				? _Scheduler_succeed(doStuff(node))
				: _Scheduler_fail($elm$browser$Browser$Dom$NotFound(id))
			);
		});
	});
}


function _Browser_withWindow(doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(doStuff()));
		});
	});
}


// FOCUS and BLUR


var _Browser_call = F2(function(functionName, id)
{
	return _Browser_withNode(id, function(node) {
		node[functionName]();
		return _Utils_Tuple0;
	});
});



// WINDOW VIEWPORT


function _Browser_getViewport()
{
	return {
		ct: _Browser_getScene(),
		cB: {
			cD: _Browser_window.pageXOffset,
			cE: _Browser_window.pageYOffset,
			bo: _Browser_doc.documentElement.clientWidth,
			aB: _Browser_doc.documentElement.clientHeight
		}
	};
}

function _Browser_getScene()
{
	var body = _Browser_doc.body;
	var elem = _Browser_doc.documentElement;
	return {
		bo: Math.max(body.scrollWidth, body.offsetWidth, elem.scrollWidth, elem.offsetWidth, elem.clientWidth),
		aB: Math.max(body.scrollHeight, body.offsetHeight, elem.scrollHeight, elem.offsetHeight, elem.clientHeight)
	};
}

var _Browser_setViewport = F2(function(x, y)
{
	return _Browser_withWindow(function()
	{
		_Browser_window.scroll(x, y);
		return _Utils_Tuple0;
	});
});



// ELEMENT VIEWPORT


function _Browser_getViewportOf(id)
{
	return _Browser_withNode(id, function(node)
	{
		return {
			ct: {
				bo: node.scrollWidth,
				aB: node.scrollHeight
			},
			cB: {
				cD: node.scrollLeft,
				cE: node.scrollTop,
				bo: node.clientWidth,
				aB: node.clientHeight
			}
		};
	});
}


var _Browser_setViewportOf = F3(function(id, x, y)
{
	return _Browser_withNode(id, function(node)
	{
		node.scrollLeft = x;
		node.scrollTop = y;
		return _Utils_Tuple0;
	});
});



// ELEMENT


function _Browser_getElement(id)
{
	return _Browser_withNode(id, function(node)
	{
		var rect = node.getBoundingClientRect();
		var x = _Browser_window.pageXOffset;
		var y = _Browser_window.pageYOffset;
		return {
			ct: _Browser_getScene(),
			cB: {
				cD: x,
				cE: y,
				bo: _Browser_doc.documentElement.clientWidth,
				aB: _Browser_doc.documentElement.clientHeight
			},
			cT: {
				cD: x + rect.left,
				cE: y + rect.top,
				bo: rect.width,
				aB: rect.height
			}
		};
	});
}



// LOAD and RELOAD


function _Browser_reload(skipCache)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		_VirtualDom_doc.location.reload(skipCache);
	}));
}

function _Browser_load(url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		try
		{
			_Browser_window.location = url;
		}
		catch(err)
		{
			// Only Firefox can throw a NS_ERROR_MALFORMED_URI exception here.
			// Other browsers reload the page, so let's be consistent about that.
			_VirtualDom_doc.location.reload(false);
		}
	}));
}




// STRINGS


var _Parser_isSubString = F5(function(smallString, offset, row, col, bigString)
{
	var smallLength = smallString.length;
	var isGood = offset + smallLength <= bigString.length;

	for (var i = 0; isGood && i < smallLength; )
	{
		var code = bigString.charCodeAt(offset);
		isGood =
			smallString[i++] === bigString[offset++]
			&& (
				code === 0x000A /* \n */
					? ( row++, col=1 )
					: ( col++, (code & 0xF800) === 0xD800 ? smallString[i++] === bigString[offset++] : 1 )
			)
	}

	return _Utils_Tuple3(isGood ? offset : -1, row, col);
});



// CHARS


var _Parser_isSubChar = F3(function(predicate, offset, string)
{
	return (
		string.length <= offset
			? -1
			:
		(string.charCodeAt(offset) & 0xF800) === 0xD800
			? (predicate(_Utils_chr(string.substr(offset, 2))) ? offset + 2 : -1)
			:
		(predicate(_Utils_chr(string[offset]))
			? ((string[offset] === '\n') ? -2 : (offset + 1))
			: -1
		)
	);
});


var _Parser_isAsciiCode = F3(function(code, offset, string)
{
	return string.charCodeAt(offset) === code;
});



// NUMBERS


var _Parser_chompBase10 = F2(function(offset, string)
{
	for (; offset < string.length; offset++)
	{
		var code = string.charCodeAt(offset);
		if (code < 0x30 || 0x39 < code)
		{
			return offset;
		}
	}
	return offset;
});


var _Parser_consumeBase = F3(function(base, offset, string)
{
	for (var total = 0; offset < string.length; offset++)
	{
		var digit = string.charCodeAt(offset) - 0x30;
		if (digit < 0 || base <= digit) break;
		total = base * total + digit;
	}
	return _Utils_Tuple2(offset, total);
});


var _Parser_consumeBase16 = F2(function(offset, string)
{
	for (var total = 0; offset < string.length; offset++)
	{
		var code = string.charCodeAt(offset);
		if (0x30 <= code && code <= 0x39)
		{
			total = 16 * total + code - 0x30;
		}
		else if (0x41 <= code && code <= 0x46)
		{
			total = 16 * total + code - 55;
		}
		else if (0x61 <= code && code <= 0x66)
		{
			total = 16 * total + code - 87;
		}
		else
		{
			break;
		}
	}
	return _Utils_Tuple2(offset, total);
});



// FIND STRING


var _Parser_findSubString = F5(function(smallString, offset, row, col, bigString)
{
	var newOffset = bigString.indexOf(smallString, offset);
	var target = newOffset < 0 ? bigString.length : newOffset + smallString.length;

	while (offset < target)
	{
		var code = bigString.charCodeAt(offset++);
		code === 0x000A /* \n */
			? ( col=1, row++ )
			: ( col++, (code & 0xF800) === 0xD800 && offset++ )
	}

	return _Utils_Tuple3(newOffset, row, col);
});



var _Bitwise_and = F2(function(a, b)
{
	return a & b;
});

var _Bitwise_or = F2(function(a, b)
{
	return a | b;
});

var _Bitwise_xor = F2(function(a, b)
{
	return a ^ b;
});

function _Bitwise_complement(a)
{
	return ~a;
};

var _Bitwise_shiftLeftBy = F2(function(offset, a)
{
	return a << offset;
});

var _Bitwise_shiftRightBy = F2(function(offset, a)
{
	return a >> offset;
});

var _Bitwise_shiftRightZfBy = F2(function(offset, a)
{
	return a >>> offset;
});
var $author$project$Main$Day = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $author$project$Main$Model = F2(
	function (puzzleInput, day) {
		return {bt: day, bb: puzzleInput};
	});
var $elm$core$Basics$EQ = 1;
var $elm$core$Basics$LT = 0;
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (!node.$) {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldr,
			helper,
			A3($elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var $elm$core$Array$toList = function (array) {
	return A3($elm$core$Array$foldr, $elm$core$List$cons, _List_Nil, array);
};
var $elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === -2) {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var $elm$core$Dict$toList = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					$elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Dict$keys = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2($elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Set$toList = function (_v0) {
	var dict = _v0;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$GT = 2;
var $author$project$Main$notImplementedFn = function (_v0) {
	return _Utils_Tuple2('Not implemented', 'Not implemented');
};
var $author$project$Main$init = A2(
	$author$project$Main$Model,
	'',
	A2($author$project$Main$Day, 0, $author$project$Main$notImplementedFn));
var $elm$core$Result$Err = function (a) {
	return {$: 1, a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 3, a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 0, a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 2, a: a};
};
var $elm$core$Basics$False = 1;
var $elm$core$Basics$add = _Basics_add;
var $elm$core$Maybe$Just = function (a) {
	return {$: 0, a: a};
};
var $elm$core$Maybe$Nothing = {$: 1};
var $elm$core$String$all = _String_all;
var $elm$core$Basics$and = _Basics_and;
var $elm$core$Basics$append = _Utils_append;
var $elm$json$Json$Encode$encode = _Json_encode;
var $elm$core$String$fromInt = _String_fromNumber;
var $elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var $elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var $elm$json$Json$Decode$indent = function (str) {
	return A2(
		$elm$core$String$join,
		'\n    ',
		A2($elm$core$String$split, '\n', str));
};
var $elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var $elm$core$List$length = function (xs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var $elm$core$List$map2 = _List_map2;
var $elm$core$Basics$le = _Utils_le;
var $elm$core$Basics$sub = _Basics_sub;
var $elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2($elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var $elm$core$List$range = F2(
	function (lo, hi) {
		return A3($elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var $elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$map2,
			f,
			A2(
				$elm$core$List$range,
				0,
				$elm$core$List$length(xs) - 1),
			xs);
	});
var $elm$core$Char$toCode = _Char_toCode;
var $elm$core$Char$isLower = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var $elm$core$Char$isUpper = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var $elm$core$Basics$or = _Basics_or;
var $elm$core$Char$isAlpha = function (_char) {
	return $elm$core$Char$isLower(_char) || $elm$core$Char$isUpper(_char);
};
var $elm$core$Char$isDigit = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var $elm$core$Char$isAlphaNum = function (_char) {
	return $elm$core$Char$isLower(_char) || ($elm$core$Char$isUpper(_char) || $elm$core$Char$isDigit(_char));
};
var $elm$core$List$reverse = function (list) {
	return A3($elm$core$List$foldl, $elm$core$List$cons, _List_Nil, list);
};
var $elm$core$String$uncons = _String_uncons;
var $elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + ($elm$core$String$fromInt(i + 1) + (') ' + $elm$json$Json$Decode$indent(
			$elm$json$Json$Decode$errorToString(error))));
	});
var $elm$json$Json$Decode$errorToString = function (error) {
	return A2($elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var $elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 0:
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 1) {
							return false;
						} else {
							var _v2 = _v1.a;
							var _char = _v2.a;
							var rest = _v2.b;
							return $elm$core$Char$isAlpha(_char) && A2($elm$core$String$all, $elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 1:
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 2:
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									$elm$core$String$join,
									'',
									$elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										$elm$core$String$join,
										'',
										$elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + ($elm$core$String$fromInt(
								$elm$core$List$length(errors)) + ' ways:'));
							return A2(
								$elm$core$String$join,
								'\n\n',
								A2(
									$elm$core$List$cons,
									introduction,
									A2($elm$core$List$indexedMap, $elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								$elm$core$String$join,
								'',
								$elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + ($elm$json$Json$Decode$indent(
						A2($elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var $elm$core$Array$branchFactor = 32;
var $elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 0, a: a, b: b, c: c, d: d};
	});
var $elm$core$Elm$JsArray$empty = _JsArray_empty;
var $elm$core$Basics$ceiling = _Basics_ceiling;
var $elm$core$Basics$fdiv = _Basics_fdiv;
var $elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var $elm$core$Basics$toFloat = _Basics_toFloat;
var $elm$core$Array$shiftStep = $elm$core$Basics$ceiling(
	A2($elm$core$Basics$logBase, 2, $elm$core$Array$branchFactor));
var $elm$core$Array$empty = A4($elm$core$Array$Array_elm_builtin, 0, $elm$core$Array$shiftStep, $elm$core$Elm$JsArray$empty, $elm$core$Elm$JsArray$empty);
var $elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var $elm$core$Array$Leaf = function (a) {
	return {$: 1, a: a};
};
var $elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var $elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var $elm$core$Basics$eq = _Utils_equal;
var $elm$core$Basics$floor = _Basics_floor;
var $elm$core$Elm$JsArray$length = _JsArray_length;
var $elm$core$Basics$gt = _Utils_gt;
var $elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var $elm$core$Basics$mul = _Basics_mul;
var $elm$core$Array$SubTree = function (a) {
	return {$: 0, a: a};
};
var $elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var $elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodes);
			var node = _v0.a;
			var remainingNodes = _v0.b;
			var newAcc = A2(
				$elm$core$List$cons,
				$elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return $elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var $elm$core$Tuple$first = function (_v0) {
	var x = _v0.a;
	return x;
};
var $elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = $elm$core$Basics$ceiling(nodeListSize / $elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2($elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var $elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.l) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.n),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.n);
		} else {
			var treeLen = builder.l * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.o) : builder.o;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.l);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.n) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.n);
		}
	});
var $elm$core$Basics$idiv = _Basics_idiv;
var $elm$core$Basics$lt = _Utils_lt;
var $elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					false,
					{o: nodeList, l: (len / $elm$core$Array$branchFactor) | 0, n: tail});
			} else {
				var leaf = $elm$core$Array$Leaf(
					A3($elm$core$Elm$JsArray$initialize, $elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - $elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2($elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var $elm$core$Basics$remainderBy = _Basics_remainderBy;
var $elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return $elm$core$Array$empty;
		} else {
			var tailLen = len % $elm$core$Array$branchFactor;
			var tail = A3($elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - $elm$core$Array$branchFactor;
			return A5($elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var $elm$core$Basics$True = 0;
var $elm$core$Result$isOk = function (result) {
	if (!result.$) {
		return true;
	} else {
		return false;
	}
};
var $elm$json$Json$Decode$map = _Json_map1;
var $elm$json$Json$Decode$map2 = _Json_map2;
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $elm$virtual_dom$VirtualDom$toHandlerInt = function (handler) {
	switch (handler.$) {
		case 0:
			return 0;
		case 1:
			return 1;
		case 2:
			return 2;
		default:
			return 3;
	}
};
var $elm$browser$Browser$External = function (a) {
	return {$: 1, a: a};
};
var $elm$browser$Browser$Internal = function (a) {
	return {$: 0, a: a};
};
var $elm$core$Basics$identity = function (x) {
	return x;
};
var $elm$browser$Browser$Dom$NotFound = $elm$core$Basics$identity;
var $elm$url$Url$Http = 0;
var $elm$url$Url$Https = 1;
var $elm$url$Url$Url = F6(
	function (protocol, host, port_, path, query, fragment) {
		return {b_: fragment, b3: host, cg: path, ci: port_, cm: protocol, cn: query};
	});
var $elm$core$String$contains = _String_contains;
var $elm$core$String$length = _String_length;
var $elm$core$String$slice = _String_slice;
var $elm$core$String$dropLeft = F2(
	function (n, string) {
		return (n < 1) ? string : A3(
			$elm$core$String$slice,
			n,
			$elm$core$String$length(string),
			string);
	});
var $elm$core$String$indexes = _String_indexes;
var $elm$core$String$isEmpty = function (string) {
	return string === '';
};
var $elm$core$String$left = F2(
	function (n, string) {
		return (n < 1) ? '' : A3($elm$core$String$slice, 0, n, string);
	});
var $elm$core$String$toInt = _String_toInt;
var $elm$url$Url$chompBeforePath = F5(
	function (protocol, path, params, frag, str) {
		if ($elm$core$String$isEmpty(str) || A2($elm$core$String$contains, '@', str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, ':', str);
			if (!_v0.b) {
				return $elm$core$Maybe$Just(
					A6($elm$url$Url$Url, protocol, str, $elm$core$Maybe$Nothing, path, params, frag));
			} else {
				if (!_v0.b.b) {
					var i = _v0.a;
					var _v1 = $elm$core$String$toInt(
						A2($elm$core$String$dropLeft, i + 1, str));
					if (_v1.$ === 1) {
						return $elm$core$Maybe$Nothing;
					} else {
						var port_ = _v1;
						return $elm$core$Maybe$Just(
							A6(
								$elm$url$Url$Url,
								protocol,
								A2($elm$core$String$left, i, str),
								port_,
								path,
								params,
								frag));
					}
				} else {
					return $elm$core$Maybe$Nothing;
				}
			}
		}
	});
var $elm$url$Url$chompBeforeQuery = F4(
	function (protocol, params, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '/', str);
			if (!_v0.b) {
				return A5($elm$url$Url$chompBeforePath, protocol, '/', params, frag, str);
			} else {
				var i = _v0.a;
				return A5(
					$elm$url$Url$chompBeforePath,
					protocol,
					A2($elm$core$String$dropLeft, i, str),
					params,
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompBeforeFragment = F3(
	function (protocol, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '?', str);
			if (!_v0.b) {
				return A4($elm$url$Url$chompBeforeQuery, protocol, $elm$core$Maybe$Nothing, frag, str);
			} else {
				var i = _v0.a;
				return A4(
					$elm$url$Url$chompBeforeQuery,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompAfterProtocol = F2(
	function (protocol, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '#', str);
			if (!_v0.b) {
				return A3($elm$url$Url$chompBeforeFragment, protocol, $elm$core$Maybe$Nothing, str);
			} else {
				var i = _v0.a;
				return A3(
					$elm$url$Url$chompBeforeFragment,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$core$String$startsWith = _String_startsWith;
var $elm$url$Url$fromString = function (str) {
	return A2($elm$core$String$startsWith, 'http://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		0,
		A2($elm$core$String$dropLeft, 7, str)) : (A2($elm$core$String$startsWith, 'https://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		1,
		A2($elm$core$String$dropLeft, 8, str)) : $elm$core$Maybe$Nothing);
};
var $elm$core$Basics$never = function (_v0) {
	never:
	while (true) {
		var nvr = _v0;
		var $temp$_v0 = nvr;
		_v0 = $temp$_v0;
		continue never;
	}
};
var $elm$core$Task$Perform = $elm$core$Basics$identity;
var $elm$core$Task$succeed = _Scheduler_succeed;
var $elm$core$Task$init = $elm$core$Task$succeed(0);
var $elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							$elm$core$List$foldl,
							fn,
							acc,
							$elm$core$List$reverse(r4)) : A4($elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var $elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4($elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var $elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						$elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var $elm$core$Task$andThen = _Scheduler_andThen;
var $elm$core$Task$map = F2(
	function (func, taskA) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return $elm$core$Task$succeed(
					func(a));
			},
			taskA);
	});
var $elm$core$Task$map2 = F3(
	function (func, taskA, taskB) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return A2(
					$elm$core$Task$andThen,
					function (b) {
						return $elm$core$Task$succeed(
							A2(func, a, b));
					},
					taskB);
			},
			taskA);
	});
var $elm$core$Task$sequence = function (tasks) {
	return A3(
		$elm$core$List$foldr,
		$elm$core$Task$map2($elm$core$List$cons),
		$elm$core$Task$succeed(_List_Nil),
		tasks);
};
var $elm$core$Platform$sendToApp = _Platform_sendToApp;
var $elm$core$Task$spawnCmd = F2(
	function (router, _v0) {
		var task = _v0;
		return _Scheduler_spawn(
			A2(
				$elm$core$Task$andThen,
				$elm$core$Platform$sendToApp(router),
				task));
	});
var $elm$core$Task$onEffects = F3(
	function (router, commands, state) {
		return A2(
			$elm$core$Task$map,
			function (_v0) {
				return 0;
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Task$spawnCmd(router),
					commands)));
	});
var $elm$core$Task$onSelfMsg = F3(
	function (_v0, _v1, _v2) {
		return $elm$core$Task$succeed(0);
	});
var $elm$core$Task$cmdMap = F2(
	function (tagger, _v0) {
		var task = _v0;
		return A2($elm$core$Task$map, tagger, task);
	});
_Platform_effectManagers['Task'] = _Platform_createManager($elm$core$Task$init, $elm$core$Task$onEffects, $elm$core$Task$onSelfMsg, $elm$core$Task$cmdMap);
var $elm$core$Task$command = _Platform_leaf('Task');
var $elm$core$Task$perform = F2(
	function (toMessage, task) {
		return $elm$core$Task$command(
			A2($elm$core$Task$map, toMessage, task));
	});
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $elm$core$Platform$Sub$batch = _Platform_batch;
var $elm$core$Platform$Sub$none = $elm$core$Platform$Sub$batch(_List_Nil);
var $elm$browser$Browser$sandbox = function (impl) {
	return _Browser_element(
		{
			c0: function (_v0) {
				return _Utils_Tuple2(impl.c0, $elm$core$Platform$Cmd$none);
			},
			dr: function (_v1) {
				return $elm$core$Platform$Sub$none;
			},
			dx: F2(
				function (msg, model) {
					return _Utils_Tuple2(
						A2(impl.dx, msg, model),
						$elm$core$Platform$Cmd$none);
				}),
			dy: impl.dy
		});
};
var $elm$core$Dict$RBEmpty_elm_builtin = {$: -2};
var $elm$core$Dict$empty = $elm$core$Dict$RBEmpty_elm_builtin;
var $elm$core$Dict$Black = 1;
var $elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: -1, a: a, b: b, c: c, d: d, e: e};
	});
var $elm$core$Dict$Red = 0;
var $elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === -1) && (!right.a)) {
			var _v1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === -1) && (!left.a)) {
				var _v3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					0,
					key,
					value,
					A5($elm$core$Dict$RBNode_elm_builtin, 1, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, 1, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5($elm$core$Dict$RBNode_elm_builtin, 0, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === -1) && (!left.a)) && (left.d.$ === -1)) && (!left.d.a)) {
				var _v5 = left.a;
				var lK = left.b;
				var lV = left.c;
				var _v6 = left.d;
				var _v7 = _v6.a;
				var llK = _v6.b;
				var llV = _v6.c;
				var llLeft = _v6.d;
				var llRight = _v6.e;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					0,
					lK,
					lV,
					A5($elm$core$Dict$RBNode_elm_builtin, 1, llK, llV, llLeft, llRight),
					A5($elm$core$Dict$RBNode_elm_builtin, 1, key, value, lRight, right));
			} else {
				return A5($elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var $elm$core$Basics$compare = _Utils_compare;
var $elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === -2) {
			return A5($elm$core$Dict$RBNode_elm_builtin, 0, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _v1 = A2($elm$core$Basics$compare, key, nKey);
			switch (_v1) {
				case 0:
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3($elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 1:
					return A5($elm$core$Dict$RBNode_elm_builtin, nColor, nKey, value, nLeft, nRight);
				default:
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						nLeft,
						A3($elm$core$Dict$insertHelp, key, value, nRight));
			}
		}
	});
var $elm$core$Dict$insert = F3(
	function (key, value, dict) {
		var _v0 = A3($elm$core$Dict$insertHelp, key, value, dict);
		if ((_v0.$ === -1) && (!_v0.a)) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, 1, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $elm$core$Dict$fromList = function (assocs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, dict) {
				var key = _v0.a;
				var value = _v0.b;
				return A3($elm$core$Dict$insert, key, value, dict);
			}),
		$elm$core$Dict$empty,
		assocs);
};
var $elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var $elm$core$List$sortBy = _List_sortBy;
var $elm$core$List$sort = function (xs) {
	return A2($elm$core$List$sortBy, $elm$core$Basics$identity, xs);
};
var $elm$core$List$sum = function (numbers) {
	return A3($elm$core$List$foldl, $elm$core$Basics$add, 0, numbers);
};
var $elm$core$List$takeReverse = F3(
	function (n, list, kept) {
		takeReverse:
		while (true) {
			if (n <= 0) {
				return kept;
			} else {
				if (!list.b) {
					return kept;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs,
						$temp$kept = A2($elm$core$List$cons, x, kept);
					n = $temp$n;
					list = $temp$list;
					kept = $temp$kept;
					continue takeReverse;
				}
			}
		}
	});
var $elm$core$List$takeTailRec = F2(
	function (n, list) {
		return $elm$core$List$reverse(
			A3($elm$core$List$takeReverse, n, list, _List_Nil));
	});
var $elm$core$List$takeFast = F3(
	function (ctr, n, list) {
		if (n <= 0) {
			return _List_Nil;
		} else {
			var _v0 = _Utils_Tuple2(n, list);
			_v0$1:
			while (true) {
				_v0$5:
				while (true) {
					if (!_v0.b.b) {
						return list;
					} else {
						if (_v0.b.b.b) {
							switch (_v0.a) {
								case 1:
									break _v0$1;
								case 2:
									var _v2 = _v0.b;
									var x = _v2.a;
									var _v3 = _v2.b;
									var y = _v3.a;
									return _List_fromArray(
										[x, y]);
								case 3:
									if (_v0.b.b.b.b) {
										var _v4 = _v0.b;
										var x = _v4.a;
										var _v5 = _v4.b;
										var y = _v5.a;
										var _v6 = _v5.b;
										var z = _v6.a;
										return _List_fromArray(
											[x, y, z]);
									} else {
										break _v0$5;
									}
								default:
									if (_v0.b.b.b.b && _v0.b.b.b.b.b) {
										var _v7 = _v0.b;
										var x = _v7.a;
										var _v8 = _v7.b;
										var y = _v8.a;
										var _v9 = _v8.b;
										var z = _v9.a;
										var _v10 = _v9.b;
										var w = _v10.a;
										var tl = _v10.b;
										return (ctr > 1000) ? A2(
											$elm$core$List$cons,
											x,
											A2(
												$elm$core$List$cons,
												y,
												A2(
													$elm$core$List$cons,
													z,
													A2(
														$elm$core$List$cons,
														w,
														A2($elm$core$List$takeTailRec, n - 4, tl))))) : A2(
											$elm$core$List$cons,
											x,
											A2(
												$elm$core$List$cons,
												y,
												A2(
													$elm$core$List$cons,
													z,
													A2(
														$elm$core$List$cons,
														w,
														A3($elm$core$List$takeFast, ctr + 1, n - 4, tl)))));
									} else {
										break _v0$5;
									}
							}
						} else {
							if (_v0.a === 1) {
								break _v0$1;
							} else {
								break _v0$5;
							}
						}
					}
				}
				return list;
			}
			var _v1 = _v0.b;
			var x = _v1.a;
			return _List_fromArray(
				[x]);
		}
	});
var $elm$core$List$take = F2(
	function (n, list) {
		return A3($elm$core$List$takeFast, 0, n, list);
	});
var $elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (!maybe.$) {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var $author$project$Day01$innerRun = F2(
	function (puzzleInput, count) {
		return $elm$core$String$fromInt(
			$elm$core$List$sum(
				A2(
					$elm$core$List$take,
					count,
					$elm$core$List$reverse(
						$elm$core$List$sort(
							A2(
								$elm$core$List$map,
								A2(
									$elm$core$Basics$composeR,
									$elm$core$String$split('\n'),
									A2(
										$elm$core$Basics$composeR,
										$elm$core$List$map(
											A2(
												$elm$core$Basics$composeR,
												$elm$core$String$toInt,
												$elm$core$Maybe$withDefault(0))),
										A2($elm$core$List$foldl, $elm$core$Basics$add, 0))),
								A2($elm$core$String$split, '\n\n', puzzleInput)))))));
	});
var $author$project$Day01$run = function (content) {
	return _Utils_Tuple2(
		A2($author$project$Day01$innerRun, content, 1),
		A2($author$project$Day01$innerRun, content, 3));
};
var $author$project$Day02$Element = F2(
	function (opponent, you) {
		return {ap: opponent, bp: you};
	});
var $author$project$Day02$Invalid = 3;
var $author$project$Day02$Paper = 1;
var $author$project$Day02$Rock = 0;
var $author$project$Day02$Scissors = 2;
var $author$project$Day02$parseElement = function (l) {
	if (l.b && l.b.b) {
		var char1 = l.a;
		var _v1 = l.b;
		var char2 = _v1.a;
		var y = (char2 === 'X') ? 0 : ((char2 === 'Y') ? 1 : ((char2 === 'Z') ? 2 : 3));
		var o = (char1 === 'A') ? 0 : ((char1 === 'B') ? 1 : ((char1 === 'C') ? 2 : 3));
		return A2($author$project$Day02$Element, o, y);
	} else {
		return A2($author$project$Day02$Element, 3, 3);
	}
};
var $author$project$Day02$scoreShape = function (s) {
	switch (s) {
		case 0:
			return 1;
		case 1:
			return 2;
		case 2:
			return 3;
		default:
			return 0;
	}
};
var $author$project$Day02$scoreWin = function (el) {
	var _v0 = el.bp;
	switch (_v0) {
		case 0:
			var _v1 = el.ap;
			switch (_v1) {
				case 0:
					return 3;
				case 1:
					return 0;
				case 2:
					return 6;
				default:
					return 0;
			}
		case 1:
			var _v2 = el.ap;
			switch (_v2) {
				case 0:
					return 6;
				case 1:
					return 3;
				case 2:
					return 0;
				default:
					return 0;
			}
		case 2:
			var _v3 = el.ap;
			switch (_v3) {
				case 0:
					return 0;
				case 1:
					return 6;
				case 2:
					return 3;
				default:
					return 0;
			}
		default:
			return 0;
	}
};
var $author$project$Day02$transformElement = function (el) {
	var _v0 = el.bp;
	switch (_v0) {
		case 0:
			var _v1 = el.ap;
			switch (_v1) {
				case 0:
					return A2($author$project$Day02$Element, 0, 2);
				case 1:
					return A2($author$project$Day02$Element, 1, 0);
				case 2:
					return A2($author$project$Day02$Element, 2, 1);
				default:
					return A2($author$project$Day02$Element, 3, 3);
			}
		case 1:
			var _v2 = el.ap;
			switch (_v2) {
				case 0:
					return A2($author$project$Day02$Element, 0, 0);
				case 1:
					return A2($author$project$Day02$Element, 1, 1);
				case 2:
					return A2($author$project$Day02$Element, 2, 2);
				default:
					return A2($author$project$Day02$Element, 3, 3);
			}
		case 2:
			var _v3 = el.ap;
			switch (_v3) {
				case 0:
					return A2($author$project$Day02$Element, 0, 1);
				case 1:
					return A2($author$project$Day02$Element, 1, 2);
				case 2:
					return A2($author$project$Day02$Element, 2, 0);
				default:
					return A2($author$project$Day02$Element, 3, 3);
			}
		default:
			return A2($author$project$Day02$Element, 3, 3);
	}
};
var $author$project$Day02$innerRun = F2(
	function (content, toBeTransformed) {
		var transformFn = toBeTransformed ? $author$project$Day02$transformElement : $elm$core$Basics$identity;
		var fn = F2(
			function (el, acc) {
				return (acc + $author$project$Day02$scoreShape(el.bp)) + $author$project$Day02$scoreWin(el);
			});
		return $elm$core$String$fromInt(
			A3(
				$elm$core$List$foldl,
				fn,
				0,
				A2(
					$elm$core$List$map,
					A2(
						$elm$core$Basics$composeR,
						$elm$core$String$split(' '),
						A2(
							$elm$core$Basics$composeR,
							$elm$core$List$take(2),
							A2($elm$core$Basics$composeR, $author$project$Day02$parseElement, transformFn))),
					A2($elm$core$String$split, '\n', content))));
	});
var $author$project$Day02$run = function (content) {
	return _Utils_Tuple2(
		A2($author$project$Day02$innerRun, content, false),
		A2($author$project$Day02$innerRun, content, true));
};
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $elm$core$String$dropRight = F2(
	function (n, string) {
		return (n < 1) ? string : A3($elm$core$String$slice, 0, -n, string);
	});
var $elm$core$Set$Set_elm_builtin = $elm$core$Basics$identity;
var $elm$core$Set$empty = $elm$core$Dict$empty;
var $elm$core$Set$insert = F2(
	function (key, _v0) {
		var dict = _v0;
		return A3($elm$core$Dict$insert, key, 0, dict);
	});
var $elm$core$Set$fromList = function (list) {
	return A3($elm$core$List$foldl, $elm$core$Set$insert, $elm$core$Set$empty, list);
};
var $elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === -2) {
				return $elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _v1 = A2($elm$core$Basics$compare, targetKey, key);
				switch (_v1) {
					case 0:
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 1:
						return $elm$core$Maybe$Just(value);
					default:
						var $temp$targetKey = targetKey,
							$temp$dict = right;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
				}
			}
		}
	});
var $elm$core$List$head = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(x);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $elm$core$Dict$foldl = F3(
	function (func, acc, dict) {
		foldl:
		while (true) {
			if (dict.$ === -2) {
				return acc;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldl, func, acc, left)),
					$temp$dict = right;
				func = $temp$func;
				acc = $temp$acc;
				dict = $temp$dict;
				continue foldl;
			}
		}
	});
var $elm$core$Dict$filter = F2(
	function (isGood, dict) {
		return A3(
			$elm$core$Dict$foldl,
			F3(
				function (k, v, d) {
					return A2(isGood, k, v) ? A3($elm$core$Dict$insert, k, v, d) : d;
				}),
			$elm$core$Dict$empty,
			dict);
	});
var $elm$core$Dict$member = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$get, key, dict);
		if (!_v0.$) {
			return true;
		} else {
			return false;
		}
	});
var $elm$core$Dict$intersect = F2(
	function (t1, t2) {
		return A2(
			$elm$core$Dict$filter,
			F2(
				function (k, _v0) {
					return A2($elm$core$Dict$member, k, t2);
				}),
			t1);
	});
var $elm$core$Set$intersect = F2(
	function (_v0, _v1) {
		var dict1 = _v0;
		var dict2 = _v1;
		return A2($elm$core$Dict$intersect, dict1, dict2);
	});
var $elm$core$Tuple$pair = F2(
	function (a, b) {
		return _Utils_Tuple2(a, b);
	});
var $author$project$Day03$prio = function () {
	var nums = A2($elm$core$List$range, 1, 52);
	var alphas = A2($elm$core$String$split, '', 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');
	return $elm$core$Dict$fromList(
		A3($elm$core$List$map2, $elm$core$Tuple$pair, alphas, nums));
}();
var $author$project$Day03$fnPartA = function (line) {
	var half = ($elm$core$String$length(line) / 2) | 0;
	var left = $elm$core$Set$fromList(
		A2(
			$elm$core$String$split,
			'',
			A2($elm$core$String$dropRight, half, line)));
	var right = $elm$core$Set$fromList(
		A2(
			$elm$core$String$split,
			'',
			A2($elm$core$String$dropLeft, half, line)));
	return A2(
		$elm$core$Maybe$withDefault,
		0,
		A2(
			$elm$core$Dict$get,
			A2(
				$elm$core$Maybe$withDefault,
				'',
				$elm$core$List$head(
					$elm$core$Set$toList(
						A2($elm$core$Set$intersect, left, right)))),
			$author$project$Day03$prio));
};
var $author$project$Day03$innerRunPartA = function (content) {
	return $elm$core$String$fromInt(
		$elm$core$List$sum(
			A2($elm$core$List$map, $author$project$Day03$fnPartA, content)));
};
var $author$project$Day03$parseGroup = F3(
	function (first, second, third) {
		var s = A2(
			$elm$core$Basics$composeR,
			$elm$core$String$split(''),
			$elm$core$Set$fromList);
		return A2(
			$elm$core$Maybe$withDefault,
			0,
			A2(
				$elm$core$Dict$get,
				A2(
					$elm$core$Maybe$withDefault,
					'',
					$elm$core$List$head(
						$elm$core$Set$toList(
							A2(
								$elm$core$Set$intersect,
								s(third),
								A2(
									$elm$core$Set$intersect,
									s(first),
									s(second)))))),
				$author$project$Day03$prio));
	});
var $author$project$Day03$walk = function (all) {
	if ((all.b && all.b.b) && all.b.b.b) {
		var first = all.a;
		var _v1 = all.b;
		var second = _v1.a;
		var _v2 = _v1.b;
		var third = _v2.a;
		var rest = _v2.b;
		return A3($author$project$Day03$parseGroup, first, second, third) + $author$project$Day03$walk(rest);
	} else {
		return 0;
	}
};
var $author$project$Day03$innerRunPartB = function (content) {
	return $elm$core$String$fromInt(
		$author$project$Day03$walk(content));
};
var $author$project$Day03$run = function (puzzleInput) {
	var c = A2($elm$core$String$split, '\n', puzzleInput);
	return _Utils_Tuple2(
		$author$project$Day03$innerRunPartA(c),
		$author$project$Day03$innerRunPartB(c));
};
var $elm$core$Basics$ge = _Utils_ge;
var $author$project$Day04$checkPartOne = F2(
	function (first, second) {
		var _v0 = _Utils_Tuple2(first, second);
		if (_v0.a.$ === 1) {
			if (_v0.b.$ === 1) {
				var _v1 = _v0.a;
				var _v2 = _v0.b;
				return 0;
			} else {
				var _v3 = _v0.a;
				return 0;
			}
		} else {
			if (_v0.b.$ === 1) {
				var _v4 = _v0.b;
				return 0;
			} else {
				var f = _v0.a.a;
				var s = _v0.b.a;
				return ((_Utils_cmp(f.J, s.J) < 1) && (_Utils_cmp(f.al, s.al) > -1)) ? 1 : (((_Utils_cmp(s.J, f.J) < 1) && (_Utils_cmp(s.al, f.al) > -1)) ? 1 : 0);
			}
		}
	});
var $author$project$Day04$checkPartTwo = F2(
	function (first, second) {
		var _v0 = _Utils_Tuple2(first, second);
		if (_v0.a.$ === 1) {
			if (_v0.b.$ === 1) {
				var _v1 = _v0.a;
				var _v2 = _v0.b;
				return 0;
			} else {
				var _v3 = _v0.a;
				return 0;
			}
		} else {
			if (_v0.b.$ === 1) {
				var _v4 = _v0.b;
				return 0;
			} else {
				var f = _v0.a.a;
				var s = _v0.b.a;
				return ((_Utils_cmp(f.J, s.J) < 1) && (_Utils_cmp(s.J, f.al) < 1)) ? 1 : (((_Utils_cmp(s.J, f.J) < 1) && (_Utils_cmp(f.J, s.al) < 1)) ? 1 : 0);
			}
		}
	});
var $elm$core$Maybe$andThen = F2(
	function (callback, maybeValue) {
		if (!maybeValue.$) {
			var value = maybeValue.a;
			return callback(value);
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $elm$core$List$drop = F2(
	function (n, list) {
		drop:
		while (true) {
			if (n <= 0) {
				return list;
			} else {
				if (!list.b) {
					return list;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs;
					n = $temp$n;
					list = $temp$list;
					continue drop;
				}
			}
		}
	});
var $author$project$Day04$IDs = F2(
	function (start, end) {
		return {al: end, J: start};
	});
var $author$project$Day04$toIDs = function (s) {
	return $elm$core$Maybe$Just(
		A2(
			$author$project$Day04$IDs,
			A2(
				$elm$core$Maybe$withDefault,
				0,
				A2(
					$elm$core$Maybe$andThen,
					$elm$core$String$toInt,
					$elm$core$List$head(
						A2($elm$core$String$split, '-', s)))),
			A2(
				$elm$core$Maybe$withDefault,
				0,
				A2(
					$elm$core$Maybe$andThen,
					$elm$core$String$toInt,
					$elm$core$List$head(
						A2(
							$elm$core$List$drop,
							1,
							A2($elm$core$String$split, '-', s)))))));
};
var $author$project$Day04$parseLine = F2(
	function (fn, line) {
		var second = A2(
			$elm$core$Maybe$andThen,
			$author$project$Day04$toIDs,
			$elm$core$List$head(
				A2(
					$elm$core$List$drop,
					1,
					A2($elm$core$String$split, ',', line))));
		var first = A2(
			$elm$core$Maybe$andThen,
			$author$project$Day04$toIDs,
			$elm$core$List$head(
				A2($elm$core$String$split, ',', line)));
		return A2(fn, first, second);
	});
var $author$project$Day04$runPart = F2(
	function (fn, puzzleInput) {
		return $elm$core$String$fromInt(
			$elm$core$List$sum(
				A2(
					$elm$core$List$map,
					$author$project$Day04$parseLine(fn),
					A2($elm$core$String$split, '\n', puzzleInput))));
	});
var $author$project$Day04$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A2($author$project$Day04$runPart, $author$project$Day04$checkPartOne, puzzleInput),
		A2($author$project$Day04$runPart, $author$project$Day04$checkPartTwo, puzzleInput));
};
var $elm$core$String$cons = _String_cons;
var $elm$core$String$fromChar = function (_char) {
	return A2($elm$core$String$cons, _char, '');
};
var $elm$core$Dict$values = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, valueList) {
				return A2($elm$core$List$cons, value, valueList);
			}),
		_List_Nil,
		dict);
};
var $author$project$Day05$extractTop = function (crates) {
	return A2(
		$elm$core$String$join,
		'',
		A2(
			$elm$core$List$map,
			$elm$core$String$fromChar,
			A2(
				$elm$core$List$map,
				A2(
					$elm$core$Basics$composeR,
					$elm$core$List$head,
					$elm$core$Maybe$withDefault('?')),
				$elm$core$Dict$values(crates))));
};
var $author$project$Day05$applyStepsOnCratesA = F2(
	function (steps, crates) {
		var to = F2(
			function (i, _v2) {
				var ch = _v2.a;
				var c = _v2.b;
				return A3(
					$elm$core$Dict$insert,
					i,
					A2(
						$elm$core$List$cons,
						ch,
						A2(
							$elm$core$Maybe$withDefault,
							_List_Nil,
							A2($elm$core$Dict$get, i, c))),
					c);
			});
		var from = F2(
			function (i, c) {
				var _v1 = A2(
					$elm$core$Maybe$withDefault,
					_List_Nil,
					A2($elm$core$Dict$get, i, c));
				if (_v1.b) {
					var ch = _v1.a;
					var rest = _v1.b;
					return _Utils_Tuple2(
						ch,
						A3($elm$core$Dict$insert, i, rest, c));
				} else {
					return _Utils_Tuple2('?', c);
				}
			});
		var fn = F2(
			function (step, acc1) {
				var fnInner = F2(
					function (_v0, accInner) {
						return A2(
							to,
							step.bM,
							A2(from, step.bw, accInner));
					});
				return A3(
					$elm$core$List$foldl,
					fnInner,
					acc1,
					A2($elm$core$List$range, 1, step.by));
			});
		return $author$project$Day05$extractTop(
			A3($elm$core$List$foldl, fn, crates, steps));
	});
var $author$project$Day05$applyStepsOnCratesB = F2(
	function (steps, crates) {
		var to = F2(
			function (i, _v0) {
				var chs = _v0.a;
				var c = _v0.b;
				return A3(
					$elm$core$Dict$insert,
					i,
					_Utils_ap(
						chs,
						A2(
							$elm$core$Maybe$withDefault,
							_List_Nil,
							A2($elm$core$Dict$get, i, c))),
					c);
			});
		var from = F3(
			function (i, howMany, c) {
				var stack = A2(
					$elm$core$Maybe$withDefault,
					_List_Nil,
					A2($elm$core$Dict$get, i, c));
				return _Utils_Tuple2(
					A2($elm$core$List$take, howMany, stack),
					A3(
						$elm$core$Dict$insert,
						i,
						A2($elm$core$List$drop, howMany, stack),
						c));
			});
		var fn = F2(
			function (step, acc) {
				return A2(
					to,
					step.bM,
					A3(from, step.bw, step.by, acc));
			});
		return $author$project$Day05$extractTop(
			A3($elm$core$List$foldl, fn, crates, steps));
	});
var $elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var $author$project$Day05$ParseHelper = F3(
	function (chars, allChars, count) {
		return {a3: allChars, br: chars, bs: count};
	});
var $elm$parser$Parser$UnexpectedChar = {$: 11};
var $elm$parser$Parser$Advanced$Bad = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $elm$parser$Parser$Advanced$Good = F3(
	function (a, b, c) {
		return {$: 0, a: a, b: b, c: c};
	});
var $elm$parser$Parser$Advanced$Parser = $elm$core$Basics$identity;
var $elm$parser$Parser$Advanced$AddRight = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $elm$parser$Parser$Advanced$DeadEnd = F4(
	function (row, col, problem, contextStack) {
		return {bU: col, cP: contextStack, cj: problem, cr: row};
	});
var $elm$parser$Parser$Advanced$Empty = {$: 0};
var $elm$parser$Parser$Advanced$fromState = F2(
	function (s, x) {
		return A2(
			$elm$parser$Parser$Advanced$AddRight,
			$elm$parser$Parser$Advanced$Empty,
			A4($elm$parser$Parser$Advanced$DeadEnd, s.cr, s.bU, x, s.e));
	});
var $elm$parser$Parser$Advanced$isSubChar = _Parser_isSubChar;
var $elm$parser$Parser$Advanced$chompIf = F2(
	function (isGood, expecting) {
		return function (s) {
			var newOffset = A3($elm$parser$Parser$Advanced$isSubChar, isGood, s.c, s.b);
			return _Utils_eq(newOffset, -1) ? A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : (_Utils_eq(newOffset, -2) ? A3(
				$elm$parser$Parser$Advanced$Good,
				true,
				0,
				{bU: 1, e: s.e, f: s.f, c: s.c + 1, cr: s.cr + 1, b: s.b}) : A3(
				$elm$parser$Parser$Advanced$Good,
				true,
				0,
				{bU: s.bU + 1, e: s.e, f: s.f, c: newOffset, cr: s.cr, b: s.b}));
		};
	});
var $elm$parser$Parser$chompIf = function (isGood) {
	return A2($elm$parser$Parser$Advanced$chompIf, isGood, $elm$parser$Parser$UnexpectedChar);
};
var $elm$parser$Parser$ExpectingEnd = {$: 10};
var $elm$parser$Parser$Advanced$end = function (x) {
	return function (s) {
		return _Utils_eq(
			$elm$core$String$length(s.b),
			s.c) ? A3($elm$parser$Parser$Advanced$Good, false, 0, s) : A2(
			$elm$parser$Parser$Advanced$Bad,
			false,
			A2($elm$parser$Parser$Advanced$fromState, s, x));
	};
};
var $elm$parser$Parser$end = $elm$parser$Parser$Advanced$end($elm$parser$Parser$ExpectingEnd);
var $elm$core$Basics$always = F2(
	function (a, _v0) {
		return a;
	});
var $elm$parser$Parser$Advanced$mapChompedString = F2(
	function (func, _v0) {
		var parse = _v0;
		return function (s0) {
			var _v1 = parse(s0);
			if (_v1.$ === 1) {
				var p = _v1.a;
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, p, x);
			} else {
				var p = _v1.a;
				var a = _v1.b;
				var s1 = _v1.c;
				return A3(
					$elm$parser$Parser$Advanced$Good,
					p,
					A2(
						func,
						A3($elm$core$String$slice, s0.c, s1.c, s0.b),
						a),
					s1);
			}
		};
	});
var $elm$parser$Parser$Advanced$getChompedString = function (parser) {
	return A2($elm$parser$Parser$Advanced$mapChompedString, $elm$core$Basics$always, parser);
};
var $elm$parser$Parser$getChompedString = $elm$parser$Parser$Advanced$getChompedString;
var $elm$parser$Parser$Advanced$map2 = F3(
	function (func, _v0, _v1) {
		var parseA = _v0;
		var parseB = _v1;
		return function (s0) {
			var _v2 = parseA(s0);
			if (_v2.$ === 1) {
				var p = _v2.a;
				var x = _v2.b;
				return A2($elm$parser$Parser$Advanced$Bad, p, x);
			} else {
				var p1 = _v2.a;
				var a = _v2.b;
				var s1 = _v2.c;
				var _v3 = parseB(s1);
				if (_v3.$ === 1) {
					var p2 = _v3.a;
					var x = _v3.b;
					return A2($elm$parser$Parser$Advanced$Bad, p1 || p2, x);
				} else {
					var p2 = _v3.a;
					var b = _v3.b;
					var s2 = _v3.c;
					return A3(
						$elm$parser$Parser$Advanced$Good,
						p1 || p2,
						A2(func, a, b),
						s2);
				}
			}
		};
	});
var $elm$parser$Parser$Advanced$ignorer = F2(
	function (keepParser, ignoreParser) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$core$Basics$always, keepParser, ignoreParser);
	});
var $elm$parser$Parser$ignorer = $elm$parser$Parser$Advanced$ignorer;
var $elm$parser$Parser$Advanced$keeper = F2(
	function (parseFunc, parseArg) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$core$Basics$apL, parseFunc, parseArg);
	});
var $elm$parser$Parser$keeper = $elm$parser$Parser$Advanced$keeper;
var $elm$parser$Parser$Advanced$chompWhileHelp = F5(
	function (isGood, offset, row, col, s0) {
		chompWhileHelp:
		while (true) {
			var newOffset = A3($elm$parser$Parser$Advanced$isSubChar, isGood, offset, s0.b);
			if (_Utils_eq(newOffset, -1)) {
				return A3(
					$elm$parser$Parser$Advanced$Good,
					_Utils_cmp(s0.c, offset) < 0,
					0,
					{bU: col, e: s0.e, f: s0.f, c: offset, cr: row, b: s0.b});
			} else {
				if (_Utils_eq(newOffset, -2)) {
					var $temp$isGood = isGood,
						$temp$offset = offset + 1,
						$temp$row = row + 1,
						$temp$col = 1,
						$temp$s0 = s0;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					s0 = $temp$s0;
					continue chompWhileHelp;
				} else {
					var $temp$isGood = isGood,
						$temp$offset = newOffset,
						$temp$row = row,
						$temp$col = col + 1,
						$temp$s0 = s0;
					isGood = $temp$isGood;
					offset = $temp$offset;
					row = $temp$row;
					col = $temp$col;
					s0 = $temp$s0;
					continue chompWhileHelp;
				}
			}
		}
	});
var $elm$parser$Parser$Advanced$chompWhile = function (isGood) {
	return function (s) {
		return A5($elm$parser$Parser$Advanced$chompWhileHelp, isGood, s.c, s.cr, s.bU, s);
	};
};
var $elm$parser$Parser$Advanced$spaces = $elm$parser$Parser$Advanced$chompWhile(
	function (c) {
		return (c === ' ') || ((c === '\n') || (c === '\r'));
	});
var $elm$parser$Parser$spaces = $elm$parser$Parser$Advanced$spaces;
var $elm$parser$Parser$Advanced$succeed = function (a) {
	return function (s) {
		return A3($elm$parser$Parser$Advanced$Good, false, a, s);
	};
};
var $elm$parser$Parser$succeed = $elm$parser$Parser$Advanced$succeed;
var $elm$parser$Parser$ExpectingSymbol = function (a) {
	return {$: 8, a: a};
};
var $elm$parser$Parser$Advanced$Token = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $elm$parser$Parser$Advanced$isSubString = _Parser_isSubString;
var $elm$core$Basics$not = _Basics_not;
var $elm$parser$Parser$Advanced$token = function (_v0) {
	var str = _v0.a;
	var expecting = _v0.b;
	var progress = !$elm$core$String$isEmpty(str);
	return function (s) {
		var _v1 = A5($elm$parser$Parser$Advanced$isSubString, str, s.c, s.cr, s.bU, s.b);
		var newOffset = _v1.a;
		var newRow = _v1.b;
		var newCol = _v1.c;
		return _Utils_eq(newOffset, -1) ? A2(
			$elm$parser$Parser$Advanced$Bad,
			false,
			A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : A3(
			$elm$parser$Parser$Advanced$Good,
			progress,
			0,
			{bU: newCol, e: s.e, f: s.f, c: newOffset, cr: newRow, b: s.b});
	};
};
var $elm$parser$Parser$Advanced$symbol = $elm$parser$Parser$Advanced$token;
var $elm$parser$Parser$symbol = function (str) {
	return $elm$parser$Parser$Advanced$symbol(
		A2(
			$elm$parser$Parser$Advanced$Token,
			str,
			$elm$parser$Parser$ExpectingSymbol(str)));
};
var $elm$core$String$foldr = _String_foldr;
var $elm$core$String$toList = function (string) {
	return A3($elm$core$String$foldr, $elm$core$List$cons, _List_Nil, string);
};
var $author$project$Day05$cratesObjParser = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$ignorer,
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed(
				A2(
					$elm$core$Basics$composeR,
					$elm$core$String$toList,
					A2(
						$elm$core$Basics$composeR,
						$elm$core$List$head,
						$elm$core$Maybe$withDefault('?')))),
			$elm$parser$Parser$spaces),
		$elm$parser$Parser$symbol('[')),
	A2(
		$elm$parser$Parser$ignorer,
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$getChompedString(
				$elm$parser$Parser$chompIf($elm$core$Char$isAlpha)),
			$elm$parser$Parser$symbol(']')),
		$elm$parser$Parser$end));
var $elm$core$String$fromList = _String_fromList;
var $elm$parser$Parser$DeadEnd = F3(
	function (row, col, problem) {
		return {bU: col, cj: problem, cr: row};
	});
var $elm$parser$Parser$problemToDeadEnd = function (p) {
	return A3($elm$parser$Parser$DeadEnd, p.cr, p.bU, p.cj);
};
var $elm$parser$Parser$Advanced$bagToList = F2(
	function (bag, list) {
		bagToList:
		while (true) {
			switch (bag.$) {
				case 0:
					return list;
				case 1:
					var bag1 = bag.a;
					var x = bag.b;
					var $temp$bag = bag1,
						$temp$list = A2($elm$core$List$cons, x, list);
					bag = $temp$bag;
					list = $temp$list;
					continue bagToList;
				default:
					var bag1 = bag.a;
					var bag2 = bag.b;
					var $temp$bag = bag1,
						$temp$list = A2($elm$parser$Parser$Advanced$bagToList, bag2, list);
					bag = $temp$bag;
					list = $temp$list;
					continue bagToList;
			}
		}
	});
var $elm$parser$Parser$Advanced$run = F2(
	function (_v0, src) {
		var parse = _v0;
		var _v1 = parse(
			{bU: 1, e: _List_Nil, f: 1, c: 0, cr: 1, b: src});
		if (!_v1.$) {
			var value = _v1.b;
			return $elm$core$Result$Ok(value);
		} else {
			var bag = _v1.b;
			return $elm$core$Result$Err(
				A2($elm$parser$Parser$Advanced$bagToList, bag, _List_Nil));
		}
	});
var $elm$parser$Parser$run = F2(
	function (parser, source) {
		var _v0 = A2($elm$parser$Parser$Advanced$run, parser, source);
		if (!_v0.$) {
			var a = _v0.a;
			return $elm$core$Result$Ok(a);
		} else {
			var problems = _v0.a;
			return $elm$core$Result$Err(
				A2($elm$core$List$map, $elm$parser$Parser$problemToDeadEnd, problems));
		}
	});
var $author$project$Day05$parseCratesLine = function (input) {
	var fn3 = F2(
		function (a, b) {
			return _Utils_Tuple2(b, a);
		});
	var fn2 = function (el) {
		var _v0 = A2(
			$elm$parser$Parser$run,
			$author$project$Day05$cratesObjParser,
			$elm$core$String$fromList(el));
		if (!_v0.$) {
			var v = _v0.a;
			return $elm$core$Maybe$Just(v);
		} else {
			return $elm$core$Maybe$Nothing;
		}
	};
	var fn1 = F2(
		function (ch, ph) {
			return (ph.bs <= 4) ? A3(
				$author$project$Day05$ParseHelper,
				_Utils_ap(
					ph.br,
					_List_fromArray(
						[ch])),
				ph.a3,
				ph.bs + 1) : A3(
				$author$project$Day05$ParseHelper,
				_List_fromArray(
					[ch]),
				_Utils_ap(
					ph.a3,
					_List_fromArray(
						[ph.br])),
				2);
		});
	var ll = A2(
		$elm$core$List$map,
		fn2,
		A3(
			$elm$core$List$foldl,
			fn1,
			A3($author$project$Day05$ParseHelper, _List_Nil, _List_Nil, 1),
			$elm$core$String$toList(' ' + (input + ' '))).a3);
	return $elm$core$Dict$fromList(
		A3(
			$elm$core$List$map2,
			fn3,
			ll,
			A2(
				$elm$core$List$range,
				1,
				$elm$core$List$length(ll))));
};
var $author$project$Day05$parseCrates = function (input) {
	var newCrates = $elm$core$Dict$empty;
	var lines = A2($elm$core$String$split, '\n', input);
	var fn = F2(
		function (cratesLine, acc1) {
			return A3(
				$elm$core$List$foldl,
				F2(
					function (_v0, acc2) {
						var i = _v0.a;
						var el = _v0.b;
						if (!el.$) {
							var ch = el.a;
							var current = A2(
								$elm$core$Maybe$withDefault,
								_List_Nil,
								A2($elm$core$Dict$get, i, acc2));
							return A3(
								$elm$core$Dict$insert,
								i,
								A2($elm$core$List$cons, ch, current),
								acc2);
						} else {
							return acc2;
						}
					}),
				acc1,
				$elm$core$Dict$toList(cratesLine));
		});
	return A3(
		$elm$core$List$foldl,
		fn,
		newCrates,
		$elm$core$List$reverse(
			A2(
				$elm$core$List$map,
				$author$project$Day05$parseCratesLine,
				A2(
					$elm$core$List$take,
					$elm$core$List$length(lines) - 1,
					lines))));
};
var $author$project$Day05$Step = F3(
	function (howMany, from, to) {
		return {bw: from, by: howMany, bM: to};
	});
var $elm$parser$Parser$ExpectingInt = {$: 1};
var $elm$parser$Parser$Advanced$consumeBase = _Parser_consumeBase;
var $elm$parser$Parser$Advanced$consumeBase16 = _Parser_consumeBase16;
var $elm$parser$Parser$Advanced$bumpOffset = F2(
	function (newOffset, s) {
		return {bU: s.bU + (newOffset - s.c), e: s.e, f: s.f, c: newOffset, cr: s.cr, b: s.b};
	});
var $elm$parser$Parser$Advanced$chompBase10 = _Parser_chompBase10;
var $elm$parser$Parser$Advanced$isAsciiCode = _Parser_isAsciiCode;
var $elm$parser$Parser$Advanced$consumeExp = F2(
	function (offset, src) {
		if (A3($elm$parser$Parser$Advanced$isAsciiCode, 101, offset, src) || A3($elm$parser$Parser$Advanced$isAsciiCode, 69, offset, src)) {
			var eOffset = offset + 1;
			var expOffset = (A3($elm$parser$Parser$Advanced$isAsciiCode, 43, eOffset, src) || A3($elm$parser$Parser$Advanced$isAsciiCode, 45, eOffset, src)) ? (eOffset + 1) : eOffset;
			var newOffset = A2($elm$parser$Parser$Advanced$chompBase10, expOffset, src);
			return _Utils_eq(expOffset, newOffset) ? (-newOffset) : newOffset;
		} else {
			return offset;
		}
	});
var $elm$parser$Parser$Advanced$consumeDotAndExp = F2(
	function (offset, src) {
		return A3($elm$parser$Parser$Advanced$isAsciiCode, 46, offset, src) ? A2(
			$elm$parser$Parser$Advanced$consumeExp,
			A2($elm$parser$Parser$Advanced$chompBase10, offset + 1, src),
			src) : A2($elm$parser$Parser$Advanced$consumeExp, offset, src);
	});
var $elm$parser$Parser$Advanced$finalizeInt = F5(
	function (invalid, handler, startOffset, _v0, s) {
		var endOffset = _v0.a;
		var n = _v0.b;
		if (handler.$ === 1) {
			var x = handler.a;
			return A2(
				$elm$parser$Parser$Advanced$Bad,
				true,
				A2($elm$parser$Parser$Advanced$fromState, s, x));
		} else {
			var toValue = handler.a;
			return _Utils_eq(startOffset, endOffset) ? A2(
				$elm$parser$Parser$Advanced$Bad,
				_Utils_cmp(s.c, startOffset) < 0,
				A2($elm$parser$Parser$Advanced$fromState, s, invalid)) : A3(
				$elm$parser$Parser$Advanced$Good,
				true,
				toValue(n),
				A2($elm$parser$Parser$Advanced$bumpOffset, endOffset, s));
		}
	});
var $elm$parser$Parser$Advanced$fromInfo = F4(
	function (row, col, x, context) {
		return A2(
			$elm$parser$Parser$Advanced$AddRight,
			$elm$parser$Parser$Advanced$Empty,
			A4($elm$parser$Parser$Advanced$DeadEnd, row, col, x, context));
	});
var $elm$core$String$toFloat = _String_toFloat;
var $elm$parser$Parser$Advanced$finalizeFloat = F6(
	function (invalid, expecting, intSettings, floatSettings, intPair, s) {
		var intOffset = intPair.a;
		var floatOffset = A2($elm$parser$Parser$Advanced$consumeDotAndExp, intOffset, s.b);
		if (floatOffset < 0) {
			return A2(
				$elm$parser$Parser$Advanced$Bad,
				true,
				A4($elm$parser$Parser$Advanced$fromInfo, s.cr, s.bU - (floatOffset + s.c), invalid, s.e));
		} else {
			if (_Utils_eq(s.c, floatOffset)) {
				return A2(
					$elm$parser$Parser$Advanced$Bad,
					false,
					A2($elm$parser$Parser$Advanced$fromState, s, expecting));
			} else {
				if (_Utils_eq(intOffset, floatOffset)) {
					return A5($elm$parser$Parser$Advanced$finalizeInt, invalid, intSettings, s.c, intPair, s);
				} else {
					if (floatSettings.$ === 1) {
						var x = floatSettings.a;
						return A2(
							$elm$parser$Parser$Advanced$Bad,
							true,
							A2($elm$parser$Parser$Advanced$fromState, s, invalid));
					} else {
						var toValue = floatSettings.a;
						var _v1 = $elm$core$String$toFloat(
							A3($elm$core$String$slice, s.c, floatOffset, s.b));
						if (_v1.$ === 1) {
							return A2(
								$elm$parser$Parser$Advanced$Bad,
								true,
								A2($elm$parser$Parser$Advanced$fromState, s, invalid));
						} else {
							var n = _v1.a;
							return A3(
								$elm$parser$Parser$Advanced$Good,
								true,
								toValue(n),
								A2($elm$parser$Parser$Advanced$bumpOffset, floatOffset, s));
						}
					}
				}
			}
		}
	});
var $elm$parser$Parser$Advanced$number = function (c) {
	return function (s) {
		if (A3($elm$parser$Parser$Advanced$isAsciiCode, 48, s.c, s.b)) {
			var zeroOffset = s.c + 1;
			var baseOffset = zeroOffset + 1;
			return A3($elm$parser$Parser$Advanced$isAsciiCode, 120, zeroOffset, s.b) ? A5(
				$elm$parser$Parser$Advanced$finalizeInt,
				c.c1,
				c.b2,
				baseOffset,
				A2($elm$parser$Parser$Advanced$consumeBase16, baseOffset, s.b),
				s) : (A3($elm$parser$Parser$Advanced$isAsciiCode, 111, zeroOffset, s.b) ? A5(
				$elm$parser$Parser$Advanced$finalizeInt,
				c.c1,
				c.cf,
				baseOffset,
				A3($elm$parser$Parser$Advanced$consumeBase, 8, baseOffset, s.b),
				s) : (A3($elm$parser$Parser$Advanced$isAsciiCode, 98, zeroOffset, s.b) ? A5(
				$elm$parser$Parser$Advanced$finalizeInt,
				c.c1,
				c.bR,
				baseOffset,
				A3($elm$parser$Parser$Advanced$consumeBase, 2, baseOffset, s.b),
				s) : A6(
				$elm$parser$Parser$Advanced$finalizeFloat,
				c.c1,
				c.bY,
				c.b6,
				c.bZ,
				_Utils_Tuple2(zeroOffset, 0),
				s)));
		} else {
			return A6(
				$elm$parser$Parser$Advanced$finalizeFloat,
				c.c1,
				c.bY,
				c.b6,
				c.bZ,
				A3($elm$parser$Parser$Advanced$consumeBase, 10, s.c, s.b),
				s);
		}
	};
};
var $elm$parser$Parser$Advanced$int = F2(
	function (expecting, invalid) {
		return $elm$parser$Parser$Advanced$number(
			{
				bR: $elm$core$Result$Err(invalid),
				bY: expecting,
				bZ: $elm$core$Result$Err(invalid),
				b2: $elm$core$Result$Err(invalid),
				b6: $elm$core$Result$Ok($elm$core$Basics$identity),
				c1: invalid,
				cf: $elm$core$Result$Err(invalid)
			});
	});
var $elm$parser$Parser$int = A2($elm$parser$Parser$Advanced$int, $elm$parser$Parser$ExpectingInt, $elm$parser$Parser$ExpectingInt);
var $elm$parser$Parser$Expecting = function (a) {
	return {$: 0, a: a};
};
var $elm$parser$Parser$toToken = function (str) {
	return A2(
		$elm$parser$Parser$Advanced$Token,
		str,
		$elm$parser$Parser$Expecting(str));
};
var $elm$parser$Parser$token = function (str) {
	return $elm$parser$Parser$Advanced$token(
		$elm$parser$Parser$toToken(str));
};
var $author$project$Day05$parseStepLine = function (l) {
	var p = A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed($author$project$Day05$Step),
						$elm$parser$Parser$token('move')),
					$elm$parser$Parser$spaces),
				A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$ignorer,
						A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
						$elm$parser$Parser$token('from')),
					$elm$parser$Parser$spaces)),
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
					$elm$parser$Parser$token('to')),
				$elm$parser$Parser$spaces)),
		A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$end));
	var _v0 = A2($elm$parser$Parser$run, p, l);
	if (!_v0.$) {
		var v = _v0.a;
		return v;
	} else {
		return A3($author$project$Day05$Step, 0, 0, 0);
	}
};
var $author$project$Day05$parseSteps = function (input) {
	return A2(
		$elm$core$List$map,
		$author$project$Day05$parseStepLine,
		A2($elm$core$String$split, '\n', input));
};
var $author$project$Day05$runPartA = F2(
	function (puzzleInput, applyFn) {
		var steps = A2(
			$elm$core$Maybe$andThen,
			A2($elm$core$Basics$composeL, $elm$core$Maybe$Just, $author$project$Day05$parseSteps),
			$elm$core$List$head(
				A2(
					$elm$core$List$drop,
					1,
					A2($elm$core$String$split, '\n\n', puzzleInput))));
		var crates = A2(
			$elm$core$Maybe$andThen,
			A2($elm$core$Basics$composeL, $elm$core$Maybe$Just, $author$project$Day05$parseCrates),
			$elm$core$List$head(
				A2($elm$core$String$split, '\n\n', puzzleInput)));
		var _v0 = _Utils_Tuple2(crates, steps);
		if ((!_v0.a.$) && (!_v0.b.$)) {
			var c = _v0.a.a;
			var s = _v0.b.a;
			return A2(applyFn, s, c);
		} else {
			return 'Error';
		}
	});
var $author$project$Day05$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A2($author$project$Day05$runPartA, puzzleInput, $author$project$Day05$applyStepsOnCratesA),
		A2($author$project$Day05$runPartA, puzzleInput, $author$project$Day05$applyStepsOnCratesB));
};
var $elm$core$Tuple$second = function (_v0) {
	var y = _v0.b;
	return y;
};
var $elm$core$Dict$sizeHelp = F2(
	function (n, dict) {
		sizeHelp:
		while (true) {
			if (dict.$ === -2) {
				return n;
			} else {
				var left = dict.d;
				var right = dict.e;
				var $temp$n = A2($elm$core$Dict$sizeHelp, n + 1, right),
					$temp$dict = left;
				n = $temp$n;
				dict = $temp$dict;
				continue sizeHelp;
			}
		}
	});
var $elm$core$Dict$size = function (dict) {
	return A2($elm$core$Dict$sizeHelp, 0, dict);
};
var $elm$core$Set$size = function (_v0) {
	var dict = _v0;
	return $elm$core$Dict$size(dict);
};
var $author$project$Day06$runPartA = F2(
	function (puzzleInput, count) {
		var puzzleSolved = function (partList) {
			return _Utils_eq(
				$elm$core$Set$size(
					$elm$core$Set$fromList(
						A2($elm$core$List$map, $elm$core$Tuple$second, partList))),
				count);
		};
		var l = A2(
			$elm$core$List$indexedMap,
			$elm$core$Tuple$pair,
			$elm$core$String$toList(puzzleInput));
		var fn = F2(
			function (element, partList) {
				return puzzleSolved(partList) ? partList : (_Utils_eq(
					$elm$core$List$length(partList),
					count) ? _Utils_ap(
					A2($elm$core$List$drop, 1, partList),
					_List_fromArray(
						[element])) : _Utils_ap(
					partList,
					_List_fromArray(
						[element])));
			});
		return $elm$core$String$fromInt(
			1 + A2(
				$elm$core$Maybe$withDefault,
				_Utils_Tuple2(0, '?'),
				$elm$core$List$head(
					A2(
						$elm$core$List$drop,
						count - 1,
						A3($elm$core$List$foldl, fn, _List_Nil, l)))).a);
	});
var $author$project$Day06$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A2($author$project$Day06$runPartA, puzzleInput, 4),
		A2($author$project$Day06$runPartA, puzzleInput, 14));
};
var $author$project$Day07$Container = F2(
	function (cwd, dir) {
		return {X: cwd, a6: dir};
	});
var $author$project$Day07$Dir = function (a) {
	return {$: 0, a: a};
};
var $author$project$Day07$buildFilesystem = function (commands) {
	var goDown = F3(
		function (pwd, dir, files) {
			if (!pwd.b) {
				return files;
			} else {
				var a = pwd.a;
				var restPwd = pwd.b;
				var innerDict = function () {
					var _v1 = A2(
						$elm$core$Maybe$withDefault,
						$author$project$Day07$Dir($elm$core$Dict$empty),
						A2($elm$core$Dict$get, a, dir));
					if (!_v1.$) {
						var d = _v1.a;
						return d;
					} else {
						return $elm$core$Dict$empty;
					}
				}();
				return A3(
					$elm$core$Dict$insert,
					a,
					$author$project$Day07$Dir(
						A3(goDown, restPwd, innerDict, files)),
					dir);
			}
		});
	var fn = F2(
		function (cmd, acc) {
			if (!cmd.$) {
				var pattern = cmd.a;
				return (pattern === '/') ? _Utils_update(
					acc,
					{X: _List_Nil}) : ((pattern === '..') ? _Utils_update(
					acc,
					{
						X: A2(
							$elm$core$List$take,
							$elm$core$List$length(acc.X) - 1,
							acc.X)
					}) : _Utils_update(
					acc,
					{
						X: _Utils_ap(
							acc.X,
							_List_fromArray(
								[pattern]))
					}));
			} else {
				var files = cmd.a;
				return _Utils_update(
					acc,
					{
						a6: A3(goDown, acc.X, acc.a6, files)
					});
			}
		});
	return A3(
		$elm$core$List$foldl,
		fn,
		A2($author$project$Day07$Container, _List_Nil, $elm$core$Dict$empty),
		commands).a6;
};
var $elm$core$Dict$union = F2(
	function (t1, t2) {
		return A3($elm$core$Dict$foldl, $elm$core$Dict$insert, t2, t1);
	});
var $author$project$Day07$countDirectories = F2(
	function (name, dir) {
		var fn = F3(
			function (innerName, innerType, acc) {
				if (innerType.$ === 1) {
					var size = innerType.a;
					return A3(
						$elm$core$Dict$insert,
						name,
						A2(
							$elm$core$Maybe$withDefault,
							0,
							A2($elm$core$Dict$get, name, acc)) + size,
						acc);
				} else {
					var d = innerType.a;
					var innerDict = A2($author$project$Day07$countDirectories, name + ('/' + innerName), d);
					return A2(
						$elm$core$Dict$union,
						innerDict,
						A3(
							$elm$core$Dict$insert,
							name,
							A2(
								$elm$core$Maybe$withDefault,
								0,
								A2($elm$core$Dict$get, name, acc)) + A2(
								$elm$core$Maybe$withDefault,
								0,
								A2($elm$core$Dict$get, name + ('/' + innerName), innerDict)),
							acc));
				}
			});
		return A3($elm$core$Dict$foldl, fn, $elm$core$Dict$empty, dir);
	});
var $author$project$Day07$filterAtMost = F2(
	function (count, d) {
		return $elm$core$Dict$values(
			A2(
				$elm$core$Dict$filter,
				F2(
					function (_v0, v) {
						return _Utils_cmp(v, count) < 1;
					}),
				d));
	});
var $author$project$Day07$CD = function (a) {
	return {$: 0, a: a};
};
var $author$project$Day07$Datafile = function (a) {
	return {$: 1, a: a};
};
var $author$project$Day07$LS = function (a) {
	return {$: 1, a: a};
};
var $elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _v0 = f(mx);
		if (!_v0.$) {
			var x = _v0.a;
			return A2($elm$core$List$cons, x, xs);
		} else {
			return xs;
		}
	});
var $elm$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			$elm$core$List$maybeCons(f),
			_List_Nil,
			xs);
	});
var $author$project$Day07$parseCommands = function (puzzleInput) {
	var parseLS = function (s) {
		return $elm$core$Dict$fromList(
			A2(
				$elm$core$List$filterMap,
				function (sub) {
					if (A2($elm$core$String$startsWith, 'dir', sub)) {
						return $elm$core$Maybe$Just(
							_Utils_Tuple2(
								A2($elm$core$String$dropLeft, 4, sub),
								$author$project$Day07$Dir($elm$core$Dict$empty)));
					} else {
						var _v0 = A2($elm$core$String$split, ' ', sub);
						if (_v0.b && _v0.b.b) {
							var a = _v0.a;
							var _v1 = _v0.b;
							var b = _v1.a;
							return $elm$core$Maybe$Just(
								_Utils_Tuple2(
									b,
									$author$project$Day07$Datafile(
										A2(
											$elm$core$Maybe$withDefault,
											0,
											$elm$core$String$toInt(a)))));
						} else {
							return $elm$core$Maybe$Nothing;
						}
					}
				},
				A2($elm$core$String$split, '\n', s)));
	};
	var parseCommand = function (input) {
		return A2($elm$core$String$startsWith, 'cd', input) ? $elm$core$Maybe$Just(
			$author$project$Day07$CD(
				A2($elm$core$String$dropLeft, 3, input))) : (A2($elm$core$String$startsWith, 'ls', input) ? $elm$core$Maybe$Just(
			$author$project$Day07$LS(
				parseLS(
					A2($elm$core$String$dropLeft, 3, input)))) : $elm$core$Maybe$Nothing);
	};
	return A2(
		$elm$core$List$filterMap,
		parseCommand,
		A2($elm$core$String$split, '\n$ ', '\n' + puzzleInput));
};
var $author$project$Day07$runPartA = function (puzzleInput) {
	return $elm$core$String$fromInt(
		$elm$core$List$sum(
			A2(
				$author$project$Day07$filterAtMost,
				100000,
				A2(
					$author$project$Day07$countDirectories,
					'/',
					$author$project$Day07$buildFilesystem(
						$author$project$Day07$parseCommands(puzzleInput))))));
};
var $elm$core$List$filter = F2(
	function (isGood, list) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, xs) {
					return isGood(x) ? A2($elm$core$List$cons, x, xs) : xs;
				}),
			_List_Nil,
			list);
	});
var $author$project$Day07$getResult = function (d) {
	var free = 70000000 - A2(
		$elm$core$Maybe$withDefault,
		0,
		A2($elm$core$Dict$get, '/', d));
	return A2(
		$elm$core$Maybe$withDefault,
		0,
		$elm$core$List$head(
			A2(
				$elm$core$List$filter,
				function (e) {
					return _Utils_cmp(e, 30000000 - free) > -1;
				},
				$elm$core$List$sort(
					$elm$core$Dict$values(d)))));
};
var $author$project$Day07$runPartB = function (puzzleInput) {
	return $elm$core$String$fromInt(
		$author$project$Day07$getResult(
			A2(
				$author$project$Day07$countDirectories,
				'/',
				$author$project$Day07$buildFilesystem(
					$author$project$Day07$parseCommands(puzzleInput)))));
};
var $author$project$Day07$run = function (puzzleInput) {
	return _Utils_Tuple2(
		$author$project$Day07$runPartA(puzzleInput),
		$author$project$Day07$runPartB(puzzleInput));
};
var $author$project$Day08$countVisibils = function (forrest) {
	var fn2 = F2(
		function (tree, count) {
			var _v0 = tree.bn;
			if (!_v0) {
				return count + 1;
			} else {
				return count;
			}
		});
	var fn1 = F2(
		function (line, count) {
			return A3($elm$core$List$foldl, fn2, count, line);
		});
	return A3($elm$core$List$foldl, fn1, 0, forrest);
};
var $elm$core$String$lines = _String_lines;
var $author$project$Day08$Invisible = 1;
var $author$project$Day08$transformLine = function (line) {
	var transformTree = function (s) {
		return {
			aB: A2(
				$elm$core$Maybe$withDefault,
				0,
				$elm$core$String$toInt(s)),
			aY: 1,
			bn: 1
		};
	};
	return A2(
		$elm$core$List$map,
		transformTree,
		A2($elm$core$String$split, '', line));
};
var $elm$core$List$tail = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(xs);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Day08$transpose = function (l) {
	transpose:
	while (true) {
		if (l.b) {
			if (l.a.b) {
				var _v1 = l.a;
				var x = _v1.a;
				var xs = _v1.b;
				var xxs = l.b;
				var tails = A2($elm$core$List$filterMap, $elm$core$List$tail, xxs);
				var heads = A2($elm$core$List$filterMap, $elm$core$List$head, xxs);
				return A2(
					$elm$core$List$cons,
					A2($elm$core$List$cons, x, heads),
					$author$project$Day08$transpose(
						A2($elm$core$List$cons, xs, tails)));
			} else {
				var xxs = l.b;
				var $temp$l = xxs;
				l = $temp$l;
				continue transpose;
			}
		} else {
			return _List_Nil;
		}
	}
};
var $author$project$Day08$Visible = 0;
var $author$project$Day08$walkInLineA = F2(
	function (currentHeight, line) {
		if (!line.b) {
			return line;
		} else {
			var tree = line.a;
			var rest = line.b;
			return (_Utils_cmp(tree.aB, currentHeight) > 0) ? A2(
				$elm$core$List$cons,
				_Utils_update(
					tree,
					{bn: 0}),
				A2($author$project$Day08$walkInLineA, tree.aB, rest)) : A2(
				$elm$core$List$cons,
				tree,
				A2($author$project$Day08$walkInLineA, currentHeight, rest));
		}
	});
var $author$project$Day08$visibilityFromLeft = function (forrest) {
	return A2(
		$elm$core$List$map,
		$author$project$Day08$walkInLineA(-1),
		forrest);
};
var $author$project$Day08$visibilityFromRight = function (forrest) {
	return A2(
		$elm$core$List$map,
		A2(
			$elm$core$Basics$composeR,
			$elm$core$List$reverse,
			A2(
				$elm$core$Basics$composeR,
				$author$project$Day08$walkInLineA(-1),
				$elm$core$List$reverse)),
		forrest);
};
var $author$project$Day08$solvePartA = function (forrest) {
	return $elm$core$String$fromInt(
		$author$project$Day08$countVisibils(
			$author$project$Day08$visibilityFromRight(
				$author$project$Day08$visibilityFromLeft(
					$author$project$Day08$transpose(
						$author$project$Day08$visibilityFromRight(
							$author$project$Day08$visibilityFromLeft(
								A2(
									$elm$core$List$map,
									$author$project$Day08$transformLine,
									$elm$core$String$lines(forrest)))))))));
};
var $elm$core$List$maximum = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(
			A3($elm$core$List$foldl, $elm$core$Basics$max, x, xs));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Day08$maxScenicScore = function (forrest) {
	var fn = F2(
		function (line, count) {
			var maxInThisLine = A2(
				$elm$core$Maybe$withDefault,
				0,
				$elm$core$List$maximum(
					A2(
						$elm$core$List$map,
						function ($) {
							return $.aY;
						},
						line)));
			return (_Utils_cmp(count, maxInThisLine) < 0) ? maxInThisLine : count;
		});
	return A3($elm$core$List$foldl, fn, 0, forrest);
};
var $author$project$Day08$haveALook = F3(
	function (height, lastTrees, count) {
		haveALook:
		while (true) {
			if (lastTrees.b) {
				var l = lastTrees.a;
				var rest = lastTrees.b;
				if (_Utils_cmp(height, l) < 1) {
					return count + 1;
				} else {
					var $temp$height = height,
						$temp$lastTrees = rest,
						$temp$count = count + 1;
					height = $temp$height;
					lastTrees = $temp$lastTrees;
					count = $temp$count;
					continue haveALook;
				}
			} else {
				return count;
			}
		}
	});
var $author$project$Day08$walkInLineB = F2(
	function (lastTrees, line) {
		if (!line.b) {
			return line;
		} else {
			var tree = line.a;
			var rest = line.b;
			return A2(
				$elm$core$List$cons,
				_Utils_update(
					tree,
					{
						aY: tree.aY * A3($author$project$Day08$haveALook, tree.aB, lastTrees, 0)
					}),
				A2(
					$author$project$Day08$walkInLineB,
					A2($elm$core$List$cons, tree.aB, lastTrees),
					rest));
		}
	});
var $author$project$Day08$scenicScoreFromLeft = function (forrest) {
	return A2(
		$elm$core$List$map,
		$author$project$Day08$walkInLineB(_List_Nil),
		forrest);
};
var $author$project$Day08$scenicScoreFromRight = function (forrest) {
	return A2(
		$elm$core$List$map,
		A2(
			$elm$core$Basics$composeR,
			$elm$core$List$reverse,
			A2(
				$elm$core$Basics$composeR,
				$author$project$Day08$walkInLineB(_List_Nil),
				$elm$core$List$reverse)),
		forrest);
};
var $author$project$Day08$solvePartB = function (forrest) {
	return $elm$core$String$fromInt(
		$author$project$Day08$maxScenicScore(
			$author$project$Day08$scenicScoreFromRight(
				$author$project$Day08$scenicScoreFromLeft(
					$author$project$Day08$transpose(
						$author$project$Day08$scenicScoreFromRight(
							$author$project$Day08$scenicScoreFromLeft(
								A2(
									$elm$core$List$map,
									$author$project$Day08$transformLine,
									$elm$core$String$lines(forrest)))))))));
};
var $author$project$Day08$run = function (forrest) {
	return _Utils_Tuple2(
		$author$project$Day08$solvePartA(forrest),
		$author$project$Day08$solvePartB(forrest));
};
var $elm$core$List$repeatHelp = F3(
	function (result, n, value) {
		repeatHelp:
		while (true) {
			if (n <= 0) {
				return result;
			} else {
				var $temp$result = A2($elm$core$List$cons, value, result),
					$temp$n = n - 1,
					$temp$value = value;
				result = $temp$result;
				n = $temp$n;
				value = $temp$value;
				continue repeatHelp;
			}
		}
	});
var $elm$core$List$repeat = F2(
	function (n, value) {
		return A3($elm$core$List$repeatHelp, _List_Nil, n, value);
	});
var $author$project$Day09$diagonalMove = F2(
	function (_v0, _v1) {
		var x1 = _v0.a;
		var y1 = _v0.b;
		var x2 = _v1.a;
		var y2 = _v1.b;
		return _Utils_Tuple2(
			(_Utils_cmp(x2, x1) > 0) ? (x1 + 1) : (x1 - 1),
			(_Utils_cmp(y2, y1) > 0) ? (y1 + 1) : (y1 - 1));
	});
var $author$project$Day09$directMove = F2(
	function (_v0, _v1) {
		var x1 = _v0.a;
		var y1 = _v0.b;
		var x2 = _v1.a;
		var y2 = _v1.b;
		return _Utils_eq(x1, x2) ? _Utils_Tuple2(
			x1,
			(_Utils_cmp(y2, y1) > 0) ? (y1 + 1) : (y1 - 1)) : _Utils_Tuple2(
			(_Utils_cmp(x2, x1) > 0) ? (x1 + 1) : (x1 - 1),
			y1);
	});
var $elm$core$Basics$abs = function (n) {
	return (n < 0) ? (-n) : n;
};
var $author$project$Day09$isAdjacentTo = F2(
	function (_v0, _v1) {
		var x1 = _v0.a;
		var y1 = _v0.b;
		var x2 = _v1.a;
		var y2 = _v1.b;
		return ($elm$core$Basics$abs(x1 - x2) <= 1) && ($elm$core$Basics$abs(y1 - y2) <= 1);
	});
var $author$project$Day09$isInLineWith = F2(
	function (_v0, _v1) {
		var x1 = _v0.a;
		var y1 = _v0.b;
		var x2 = _v1.a;
		var y2 = _v1.b;
		return _Utils_eq(x1, x2) || _Utils_eq(y1, y2);
	});
var $author$project$Day09$innerMove = F3(
	function (moveFunc, id, rope) {
		var _v0 = A2($elm$core$Dict$get, id, rope);
		if (_v0.$ === 1) {
			return rope;
		} else {
			var element = _v0.a;
			var _v1 = A2($elm$core$Dict$get, id - 1, rope);
			if (_v1.$ === 1) {
				return A3(
					$elm$core$Dict$insert,
					id,
					moveFunc(element),
					rope);
			} else {
				var parent = _v1.a;
				return A2($author$project$Day09$isAdjacentTo, parent, element) ? rope : (A2($author$project$Day09$isInLineWith, parent, element) ? A3(
					$elm$core$Dict$insert,
					id,
					A2($author$project$Day09$directMove, element, parent),
					rope) : A3(
					$elm$core$Dict$insert,
					id,
					A2($author$project$Day09$diagonalMove, element, parent),
					rope));
			}
		}
	});
var $author$project$Day09$singleMove = F4(
	function (length, moveFunc, _v0, grid) {
		var newRope = A3(
			$elm$core$List$foldl,
			$author$project$Day09$innerMove(moveFunc),
			grid.bd,
			A2($elm$core$List$range, 0, length - 1));
		var newVisited = function () {
			var _v1 = A2($elm$core$Dict$get, length - 1, newRope);
			if (!_v1.$) {
				var pos = _v1.a;
				return A2($elm$core$Set$insert, pos, grid.aF);
			} else {
				return grid.aF;
			}
		}();
		return _Utils_update(
			grid,
			{bd: newRope, aF: newVisited});
	});
var $author$project$Day09$toDown = function (_v0) {
	var x = _v0.a;
	var y = _v0.b;
	return _Utils_Tuple2(x, y - 1);
};
var $author$project$Day09$toLeft = function (_v0) {
	var x = _v0.a;
	var y = _v0.b;
	return _Utils_Tuple2(x - 1, y);
};
var $author$project$Day09$toRight = function (_v0) {
	var x = _v0.a;
	var y = _v0.b;
	return _Utils_Tuple2(x + 1, y);
};
var $author$project$Day09$toUp = function (_v0) {
	var x = _v0.a;
	var y = _v0.b;
	return _Utils_Tuple2(x, y + 1);
};
var $author$project$Day09$move = F3(
	function (length, m, grid) {
		switch (m.$) {
			case 0:
				var i = m.a;
				return A3(
					$elm$core$List$foldl,
					A2($author$project$Day09$singleMove, length, $author$project$Day09$toRight),
					grid,
					A2($elm$core$List$repeat, i, 0));
			case 1:
				var i = m.a;
				return A3(
					$elm$core$List$foldl,
					A2($author$project$Day09$singleMove, length, $author$project$Day09$toLeft),
					grid,
					A2($elm$core$List$repeat, i, 0));
			case 2:
				var i = m.a;
				return A3(
					$elm$core$List$foldl,
					A2($author$project$Day09$singleMove, length, $author$project$Day09$toUp),
					grid,
					A2($elm$core$List$repeat, i, 0));
			default:
				var i = m.a;
				return A3(
					$elm$core$List$foldl,
					A2($author$project$Day09$singleMove, length, $author$project$Day09$toDown),
					grid,
					A2($elm$core$List$repeat, i, 0));
		}
	});
var $author$project$Day09$Down = function (a) {
	return {$: 3, a: a};
};
var $author$project$Day09$Left = function (a) {
	return {$: 1, a: a};
};
var $author$project$Day09$Right = function (a) {
	return {$: 0, a: a};
};
var $author$project$Day09$Up = function (a) {
	return {$: 2, a: a};
};
var $author$project$Day09$parseMoves = function (puzzleInput) {
	return A2(
		$elm$core$List$filterMap,
		function (line) {
			var elements = A2($elm$core$String$split, ' ', line);
			var getChar = $elm$core$List$head(elements);
			var getNum = A2(
				$elm$core$Maybe$andThen,
				$elm$core$String$toInt,
				$elm$core$List$head(
					A2($elm$core$List$drop, 1, elements)));
			return A2(
				$elm$core$Maybe$andThen,
				function (num) {
					return A2(
						$elm$core$Maybe$andThen,
						function (_char) {
							switch (_char) {
								case 'R':
									return $elm$core$Maybe$Just(
										$author$project$Day09$Right(num));
								case 'L':
									return $elm$core$Maybe$Just(
										$author$project$Day09$Left(num));
								case 'U':
									return $elm$core$Maybe$Just(
										$author$project$Day09$Up(num));
								case 'D':
									return $elm$core$Maybe$Just(
										$author$project$Day09$Down(num));
								default:
									return $elm$core$Maybe$Nothing;
							}
						},
						getChar);
				},
				getNum);
		},
		$elm$core$String$lines(puzzleInput));
};
var $author$project$Day09$startGrid = function (length) {
	var newRope = $elm$core$Dict$fromList(
		A2(
			$elm$core$List$map,
			function (_v0) {
				var a = _v0.a;
				var b = _v0.b;
				return _Utils_Tuple2(b, a);
			},
			A2(
				$elm$core$List$map,
				$elm$core$Tuple$pair(
					_Utils_Tuple2(0, 0)),
				A2($elm$core$List$range, 0, length - 1))));
	return {bd: newRope, aF: $elm$core$Set$empty};
};
var $author$project$Day09$runInner = F2(
	function (puzzleInput, length) {
		return $elm$core$String$fromInt(
			$elm$core$Set$size(
				A3(
					$elm$core$List$foldl,
					$author$project$Day09$move(length),
					$author$project$Day09$startGrid(length),
					$author$project$Day09$parseMoves(puzzleInput)).aF));
	});
var $author$project$Day09$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A2($author$project$Day09$runInner, puzzleInput, 2),
		A2($author$project$Day09$runInner, puzzleInput, 10));
};
var $elm$core$Bitwise$and = _Bitwise_and;
var $elm$core$Bitwise$shiftRightZfBy = _Bitwise_shiftRightZfBy;
var $elm$core$Array$bitMask = 4294967295 >>> (32 - $elm$core$Array$shiftStep);
var $elm$core$Elm$JsArray$unsafeGet = _JsArray_unsafeGet;
var $elm$core$Array$getHelp = F3(
	function (shift, index, tree) {
		getHelp:
		while (true) {
			var pos = $elm$core$Array$bitMask & (index >>> shift);
			var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (!_v0.$) {
				var subTree = _v0.a;
				var $temp$shift = shift - $elm$core$Array$shiftStep,
					$temp$index = index,
					$temp$tree = subTree;
				shift = $temp$shift;
				index = $temp$index;
				tree = $temp$tree;
				continue getHelp;
			} else {
				var values = _v0.a;
				return A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, values);
			}
		}
	});
var $elm$core$Bitwise$shiftLeftBy = _Bitwise_shiftLeftBy;
var $elm$core$Array$tailIndex = function (len) {
	return (len >>> 5) << 5;
};
var $elm$core$Array$get = F2(
	function (index, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		return ((index < 0) || (_Utils_cmp(index, len) > -1)) ? $elm$core$Maybe$Nothing : ((_Utils_cmp(
			index,
			$elm$core$Array$tailIndex(len)) > -1) ? $elm$core$Maybe$Just(
			A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, tail)) : $elm$core$Maybe$Just(
			A3($elm$core$Array$getHelp, startShift, index, tree)));
	});
var $author$project$Day10$signalStrengthNumber = _List_fromArray(
	[20, 60, 100, 140, 180, 220]);
var $author$project$Day10$getSignalStrength = function (a) {
	return $elm$core$List$sum(
		A2(
			$elm$core$List$map,
			function (n) {
				return A2(
					$elm$core$Maybe$withDefault,
					0,
					A2($elm$core$Array$get, n - 1, a)) * n;
			},
			$author$project$Day10$signalStrengthNumber));
};
var $author$project$Day10$Addx = function (a) {
	return {$: 1, a: a};
};
var $author$project$Day10$Noop = {$: 0};
var $elm$parser$Parser$Advanced$Append = F2(
	function (a, b) {
		return {$: 2, a: a, b: b};
	});
var $elm$parser$Parser$Advanced$oneOfHelp = F3(
	function (s0, bag, parsers) {
		oneOfHelp:
		while (true) {
			if (!parsers.b) {
				return A2($elm$parser$Parser$Advanced$Bad, false, bag);
			} else {
				var parse = parsers.a;
				var remainingParsers = parsers.b;
				var _v1 = parse(s0);
				if (!_v1.$) {
					var step = _v1;
					return step;
				} else {
					var step = _v1;
					var p = step.a;
					var x = step.b;
					if (p) {
						return step;
					} else {
						var $temp$s0 = s0,
							$temp$bag = A2($elm$parser$Parser$Advanced$Append, bag, x),
							$temp$parsers = remainingParsers;
						s0 = $temp$s0;
						bag = $temp$bag;
						parsers = $temp$parsers;
						continue oneOfHelp;
					}
				}
			}
		}
	});
var $elm$parser$Parser$Advanced$oneOf = function (parsers) {
	return function (s) {
		return A3($elm$parser$Parser$Advanced$oneOfHelp, s, $elm$parser$Parser$Advanced$Empty, parsers);
	};
};
var $elm$parser$Parser$oneOf = $elm$parser$Parser$Advanced$oneOf;
var $elm$core$Result$toMaybe = function (result) {
	if (!result.$) {
		var v = result.a;
		return $elm$core$Maybe$Just(v);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Day10$parseCommand = function (line) {
	var p = A2(
		$elm$parser$Parser$keeper,
		$elm$parser$Parser$succeed($elm$core$Basics$identity),
		$elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed($author$project$Day10$Noop),
						$elm$parser$Parser$token('noop')),
					$elm$parser$Parser$end),
					A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$ignorer,
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$succeed($author$project$Day10$Addx),
							$elm$parser$Parser$token('addx')),
						$elm$parser$Parser$spaces),
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$oneOf(
							_List_fromArray(
								[
									A2(
									$elm$parser$Parser$keeper,
									A2(
										$elm$parser$Parser$ignorer,
										$elm$parser$Parser$succeed($elm$core$Basics$negate),
										$elm$parser$Parser$symbol('-')),
									$elm$parser$Parser$int),
									$elm$parser$Parser$int
								])),
						$elm$parser$Parser$end))
				])));
	return $elm$core$Result$toMaybe(
		A2($elm$parser$Parser$run, p, line));
};
var $elm$core$Array$fromListHelp = F3(
	function (list, nodeList, nodeListSize) {
		fromListHelp:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, list);
			var jsArray = _v0.a;
			var remainingItems = _v0.b;
			if (_Utils_cmp(
				$elm$core$Elm$JsArray$length(jsArray),
				$elm$core$Array$branchFactor) < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					true,
					{o: nodeList, l: nodeListSize, n: jsArray});
			} else {
				var $temp$list = remainingItems,
					$temp$nodeList = A2(
					$elm$core$List$cons,
					$elm$core$Array$Leaf(jsArray),
					nodeList),
					$temp$nodeListSize = nodeListSize + 1;
				list = $temp$list;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue fromListHelp;
			}
		}
	});
var $elm$core$Array$fromList = function (list) {
	if (!list.b) {
		return $elm$core$Array$empty;
	} else {
		return A3($elm$core$Array$fromListHelp, list, _List_Nil, 0);
	}
};
var $elm$core$Array$length = function (_v0) {
	var len = _v0.a;
	return len;
};
var $elm$core$Elm$JsArray$push = _JsArray_push;
var $elm$core$Elm$JsArray$singleton = _JsArray_singleton;
var $elm$core$Elm$JsArray$unsafeSet = _JsArray_unsafeSet;
var $elm$core$Array$insertTailInTree = F4(
	function (shift, index, tail, tree) {
		var pos = $elm$core$Array$bitMask & (index >>> shift);
		if (_Utils_cmp(
			pos,
			$elm$core$Elm$JsArray$length(tree)) > -1) {
			if (shift === 5) {
				return A2(
					$elm$core$Elm$JsArray$push,
					$elm$core$Array$Leaf(tail),
					tree);
			} else {
				var newSub = $elm$core$Array$SubTree(
					A4($elm$core$Array$insertTailInTree, shift - $elm$core$Array$shiftStep, index, tail, $elm$core$Elm$JsArray$empty));
				return A2($elm$core$Elm$JsArray$push, newSub, tree);
			}
		} else {
			var value = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (!value.$) {
				var subTree = value.a;
				var newSub = $elm$core$Array$SubTree(
					A4($elm$core$Array$insertTailInTree, shift - $elm$core$Array$shiftStep, index, tail, subTree));
				return A3($elm$core$Elm$JsArray$unsafeSet, pos, newSub, tree);
			} else {
				var newSub = $elm$core$Array$SubTree(
					A4(
						$elm$core$Array$insertTailInTree,
						shift - $elm$core$Array$shiftStep,
						index,
						tail,
						$elm$core$Elm$JsArray$singleton(value)));
				return A3($elm$core$Elm$JsArray$unsafeSet, pos, newSub, tree);
			}
		}
	});
var $elm$core$Array$unsafeReplaceTail = F2(
	function (newTail, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		var originalTailLen = $elm$core$Elm$JsArray$length(tail);
		var newTailLen = $elm$core$Elm$JsArray$length(newTail);
		var newArrayLen = len + (newTailLen - originalTailLen);
		if (_Utils_eq(newTailLen, $elm$core$Array$branchFactor)) {
			var overflow = _Utils_cmp(newArrayLen >>> $elm$core$Array$shiftStep, 1 << startShift) > 0;
			if (overflow) {
				var newShift = startShift + $elm$core$Array$shiftStep;
				var newTree = A4(
					$elm$core$Array$insertTailInTree,
					newShift,
					len,
					newTail,
					$elm$core$Elm$JsArray$singleton(
						$elm$core$Array$SubTree(tree)));
				return A4($elm$core$Array$Array_elm_builtin, newArrayLen, newShift, newTree, $elm$core$Elm$JsArray$empty);
			} else {
				return A4(
					$elm$core$Array$Array_elm_builtin,
					newArrayLen,
					startShift,
					A4($elm$core$Array$insertTailInTree, startShift, len, newTail, tree),
					$elm$core$Elm$JsArray$empty);
			}
		} else {
			return A4($elm$core$Array$Array_elm_builtin, newArrayLen, startShift, tree, newTail);
		}
	});
var $elm$core$Array$push = F2(
	function (a, array) {
		var tail = array.d;
		return A2(
			$elm$core$Array$unsafeReplaceTail,
			A2($elm$core$Elm$JsArray$push, a, tail),
			array);
	});
var $author$project$Day10$processCommands = function (l) {
	var fn = F2(
		function (cmd, a) {
			var parent = A2(
				$elm$core$Maybe$withDefault,
				0,
				A2(
					$elm$core$Array$get,
					$elm$core$Array$length(a) - 1,
					a));
			if (!cmd.$) {
				return A2($elm$core$Array$push, parent, a);
			} else {
				var i = cmd.a;
				return A2(
					$elm$core$Array$push,
					parent + i,
					A2($elm$core$Array$push, parent, a));
			}
		});
	return A3(
		$elm$core$List$foldl,
		fn,
		$elm$core$Array$fromList(
			_List_fromArray(
				[1])),
		l);
};
var $author$project$Day10$runPartA = function (puzzleInput) {
	return $elm$core$String$fromInt(
		$author$project$Day10$getSignalStrength(
			$author$project$Day10$processCommands(
				A2(
					$elm$core$List$filterMap,
					$author$project$Day10$parseCommand,
					$elm$core$String$lines(puzzleInput)))));
};
var $author$project$Day10$addNewlines = function (l) {
	var fn = F2(
		function (n, ll) {
			return _Utils_ap(
				A2($elm$core$List$take, n, ll),
				A2(
					$elm$core$List$cons,
					'\n',
					A2($elm$core$List$drop, n, ll)));
		});
	return A3(
		$elm$core$List$foldl,
		fn,
		l,
		_List_fromArray(
			[40, 81, 122, 163, 204]));
};
var $elm$core$String$concat = function (strings) {
	return A2($elm$core$String$join, '', strings);
};
var $author$project$Day10$parseScreen = function (a) {
	return $elm$core$String$concat(
		$author$project$Day10$addNewlines(
			A2(
				$elm$core$List$map,
				function (n) {
					var xFromN = n - (((n / 40) | 0) * 40);
					var sprite = A2(
						$elm$core$Maybe$withDefault,
						0,
						A2($elm$core$Array$get, n, a));
					return ($elm$core$Basics$abs(sprite - xFromN) <= 1) ? '#' : '.';
				},
				A2($elm$core$List$range, 0, 239))));
};
var $author$project$Day10$runPartB = function (puzzleInput) {
	return $author$project$Day10$parseScreen(
		$author$project$Day10$processCommands(
			A2(
				$elm$core$List$filterMap,
				$author$project$Day10$parseCommand,
				$elm$core$String$lines(puzzleInput))));
};
var $author$project$Day10$run = function (puzzleInput) {
	return _Utils_Tuple2(
		$author$project$Day10$runPartA(puzzleInput),
		$author$project$Day10$runPartB(puzzleInput));
};
var $author$project$Day11$PuzzlePartA = function (a) {
	return {$: 0, a: a};
};
var $author$project$Day11$PuzzlePartB = {$: 1};
var $elm$core$Result$fromMaybe = F2(
	function (err, maybe) {
		if (!maybe.$) {
			var v = maybe.a;
			return $elm$core$Result$Ok(v);
		} else {
			return $elm$core$Result$Err(err);
		}
	});
var $elm$core$Result$map2 = F3(
	function (func, ra, rb) {
		if (ra.$ === 1) {
			var x = ra.a;
			return $elm$core$Result$Err(x);
		} else {
			var a = ra.a;
			if (rb.$ === 1) {
				var x = rb.a;
				return $elm$core$Result$Err(x);
			} else {
				var b = rb.a;
				return $elm$core$Result$Ok(
					A2(func, a, b));
			}
		}
	});
var $elm$parser$Parser$Forbidden = 0;
var $elm$parser$Parser$Advanced$andThen = F2(
	function (callback, _v0) {
		var parseA = _v0;
		return function (s0) {
			var _v1 = parseA(s0);
			if (_v1.$ === 1) {
				var p = _v1.a;
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, p, x);
			} else {
				var p1 = _v1.a;
				var a = _v1.b;
				var s1 = _v1.c;
				var _v2 = callback(a);
				var parseB = _v2;
				var _v3 = parseB(s1);
				if (_v3.$ === 1) {
					var p2 = _v3.a;
					var x = _v3.b;
					return A2($elm$parser$Parser$Advanced$Bad, p1 || p2, x);
				} else {
					var p2 = _v3.a;
					var b = _v3.b;
					var s2 = _v3.c;
					return A3($elm$parser$Parser$Advanced$Good, p1 || p2, b, s2);
				}
			}
		};
	});
var $elm$parser$Parser$Advanced$loopHelp = F4(
	function (p, state, callback, s0) {
		loopHelp:
		while (true) {
			var _v0 = callback(state);
			var parse = _v0;
			var _v1 = parse(s0);
			if (!_v1.$) {
				var p1 = _v1.a;
				var step = _v1.b;
				var s1 = _v1.c;
				if (!step.$) {
					var newState = step.a;
					var $temp$p = p || p1,
						$temp$state = newState,
						$temp$callback = callback,
						$temp$s0 = s1;
					p = $temp$p;
					state = $temp$state;
					callback = $temp$callback;
					s0 = $temp$s0;
					continue loopHelp;
				} else {
					var result = step.a;
					return A3($elm$parser$Parser$Advanced$Good, p || p1, result, s1);
				}
			} else {
				var p1 = _v1.a;
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, p || p1, x);
			}
		}
	});
var $elm$parser$Parser$Advanced$loop = F2(
	function (state, callback) {
		return function (s) {
			return A4($elm$parser$Parser$Advanced$loopHelp, false, state, callback, s);
		};
	});
var $elm$parser$Parser$Advanced$map = F2(
	function (func, _v0) {
		var parse = _v0;
		return function (s0) {
			var _v1 = parse(s0);
			if (!_v1.$) {
				var p = _v1.a;
				var a = _v1.b;
				var s1 = _v1.c;
				return A3(
					$elm$parser$Parser$Advanced$Good,
					p,
					func(a),
					s1);
			} else {
				var p = _v1.a;
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, p, x);
			}
		};
	});
var $elm$parser$Parser$Advanced$Done = function (a) {
	return {$: 1, a: a};
};
var $elm$parser$Parser$Advanced$Loop = function (a) {
	return {$: 0, a: a};
};
var $elm$parser$Parser$Advanced$revAlways = F2(
	function (_v0, b) {
		return b;
	});
var $elm$parser$Parser$Advanced$skip = F2(
	function (iParser, kParser) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$parser$Parser$Advanced$revAlways, iParser, kParser);
	});
var $elm$parser$Parser$Advanced$sequenceEndForbidden = F5(
	function (ender, ws, parseItem, sep, revItems) {
		var chompRest = function (item) {
			return A5(
				$elm$parser$Parser$Advanced$sequenceEndForbidden,
				ender,
				ws,
				parseItem,
				sep,
				A2($elm$core$List$cons, item, revItems));
		};
		return A2(
			$elm$parser$Parser$Advanced$skip,
			ws,
			$elm$parser$Parser$Advanced$oneOf(
				_List_fromArray(
					[
						A2(
						$elm$parser$Parser$Advanced$skip,
						sep,
						A2(
							$elm$parser$Parser$Advanced$skip,
							ws,
							A2(
								$elm$parser$Parser$Advanced$map,
								function (item) {
									return $elm$parser$Parser$Advanced$Loop(
										A2($elm$core$List$cons, item, revItems));
								},
								parseItem))),
						A2(
						$elm$parser$Parser$Advanced$map,
						function (_v0) {
							return $elm$parser$Parser$Advanced$Done(
								$elm$core$List$reverse(revItems));
						},
						ender)
					])));
	});
var $elm$parser$Parser$Advanced$sequenceEndMandatory = F4(
	function (ws, parseItem, sep, revItems) {
		return $elm$parser$Parser$Advanced$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$Advanced$map,
					function (item) {
						return $elm$parser$Parser$Advanced$Loop(
							A2($elm$core$List$cons, item, revItems));
					},
					A2(
						$elm$parser$Parser$Advanced$ignorer,
						parseItem,
						A2(
							$elm$parser$Parser$Advanced$ignorer,
							ws,
							A2($elm$parser$Parser$Advanced$ignorer, sep, ws)))),
					A2(
					$elm$parser$Parser$Advanced$map,
					function (_v0) {
						return $elm$parser$Parser$Advanced$Done(
							$elm$core$List$reverse(revItems));
					},
					$elm$parser$Parser$Advanced$succeed(0))
				]));
	});
var $elm$parser$Parser$Advanced$sequenceEndOptional = F5(
	function (ender, ws, parseItem, sep, revItems) {
		var parseEnd = A2(
			$elm$parser$Parser$Advanced$map,
			function (_v0) {
				return $elm$parser$Parser$Advanced$Done(
					$elm$core$List$reverse(revItems));
			},
			ender);
		return A2(
			$elm$parser$Parser$Advanced$skip,
			ws,
			$elm$parser$Parser$Advanced$oneOf(
				_List_fromArray(
					[
						A2(
						$elm$parser$Parser$Advanced$skip,
						sep,
						A2(
							$elm$parser$Parser$Advanced$skip,
							ws,
							$elm$parser$Parser$Advanced$oneOf(
								_List_fromArray(
									[
										A2(
										$elm$parser$Parser$Advanced$map,
										function (item) {
											return $elm$parser$Parser$Advanced$Loop(
												A2($elm$core$List$cons, item, revItems));
										},
										parseItem),
										parseEnd
									])))),
						parseEnd
					])));
	});
var $elm$parser$Parser$Advanced$sequenceEnd = F5(
	function (ender, ws, parseItem, sep, trailing) {
		var chompRest = function (item) {
			switch (trailing) {
				case 0:
					return A2(
						$elm$parser$Parser$Advanced$loop,
						_List_fromArray(
							[item]),
						A4($elm$parser$Parser$Advanced$sequenceEndForbidden, ender, ws, parseItem, sep));
				case 1:
					return A2(
						$elm$parser$Parser$Advanced$loop,
						_List_fromArray(
							[item]),
						A4($elm$parser$Parser$Advanced$sequenceEndOptional, ender, ws, parseItem, sep));
				default:
					return A2(
						$elm$parser$Parser$Advanced$ignorer,
						A2(
							$elm$parser$Parser$Advanced$skip,
							ws,
							A2(
								$elm$parser$Parser$Advanced$skip,
								sep,
								A2(
									$elm$parser$Parser$Advanced$skip,
									ws,
									A2(
										$elm$parser$Parser$Advanced$loop,
										_List_fromArray(
											[item]),
										A3($elm$parser$Parser$Advanced$sequenceEndMandatory, ws, parseItem, sep))))),
						ender);
			}
		};
		return $elm$parser$Parser$Advanced$oneOf(
			_List_fromArray(
				[
					A2($elm$parser$Parser$Advanced$andThen, chompRest, parseItem),
					A2(
					$elm$parser$Parser$Advanced$map,
					function (_v0) {
						return _List_Nil;
					},
					ender)
				]));
	});
var $elm$parser$Parser$Advanced$sequence = function (i) {
	return A2(
		$elm$parser$Parser$Advanced$skip,
		$elm$parser$Parser$Advanced$token(i.J),
		A2(
			$elm$parser$Parser$Advanced$skip,
			i.dq,
			A5(
				$elm$parser$Parser$Advanced$sequenceEnd,
				$elm$parser$Parser$Advanced$token(i.al),
				i.dq,
				i.c2,
				$elm$parser$Parser$Advanced$token(i.dp),
				i.dv)));
};
var $elm$parser$Parser$Advanced$Forbidden = 0;
var $elm$parser$Parser$Advanced$Mandatory = 2;
var $elm$parser$Parser$Advanced$Optional = 1;
var $elm$parser$Parser$toAdvancedTrailing = function (trailing) {
	switch (trailing) {
		case 0:
			return 0;
		case 1:
			return 1;
		default:
			return 2;
	}
};
var $elm$parser$Parser$sequence = function (i) {
	return $elm$parser$Parser$Advanced$sequence(
		{
			al: $elm$parser$Parser$toToken(i.al),
			c2: i.c2,
			dp: $elm$parser$Parser$toToken(i.dp),
			dq: i.dq,
			J: $elm$parser$Parser$toToken(i.J),
			dv: $elm$parser$Parser$toAdvancedTrailing(i.dv)
		});
};
var $author$project$Day11$parseItemList = $elm$parser$Parser$sequence(
	{al: '', c2: $elm$parser$Parser$int, dp: ',', dq: $elm$parser$Parser$spaces, J: '', dv: 0});
var $author$project$Day11$Addition = F2(
	function (a, b) {
		return {$: 0, a: a, b: b};
	});
var $author$project$Day11$Const = function (a) {
	return {$: 1, a: a};
};
var $author$project$Day11$Multiplication = F2(
	function (a, b) {
		return {$: 1, a: a, b: b};
	});
var $author$project$Day11$Self = {$: 0};
var $author$project$Day11$parseOperation = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed(
				F3(
					function (op1, opn, op2) {
						return A2(opn, op1, op2);
					})),
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$oneOf(
					_List_fromArray(
						[
							A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$succeed($author$project$Day11$Self),
							$elm$parser$Parser$token('old')),
							A2(
							$elm$parser$Parser$keeper,
							$elm$parser$Parser$succeed($author$project$Day11$Const),
							$elm$parser$Parser$int)
						])),
				$elm$parser$Parser$spaces)),
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$oneOf(
				_List_fromArray(
					[
						A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed($author$project$Day11$Addition),
						$elm$parser$Parser$token('+')),
						A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed($author$project$Day11$Multiplication),
						$elm$parser$Parser$token('*'))
					])),
			$elm$parser$Parser$spaces)),
	$elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed($author$project$Day11$Self),
				$elm$parser$Parser$token('old')),
				A2(
				$elm$parser$Parser$keeper,
				$elm$parser$Parser$succeed($author$project$Day11$Const),
				$elm$parser$Parser$int)
			])));
var $author$project$Day11$monkeyParser = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$ignorer,
							A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed(
									F6(
										function (monkeyId, items, operation, testDiv, targetIfTrue, targetIfFalse) {
											return _Utils_Tuple2(
												monkeyId,
												{aP: 0, ao: items, bD: operation, bJ: targetIfFalse, bK: targetIfTrue, bi: testDiv});
										})),
								$elm$parser$Parser$token('Monkey')),
							$elm$parser$Parser$spaces),
						A2(
							$elm$parser$Parser$ignorer,
							A2(
								$elm$parser$Parser$ignorer,
								A2(
									$elm$parser$Parser$ignorer,
									A2(
										$elm$parser$Parser$ignorer,
										$elm$parser$Parser$int,
										$elm$parser$Parser$token(':')),
									$elm$parser$Parser$spaces),
								$elm$parser$Parser$token('Starting items:')),
							$elm$parser$Parser$spaces)),
					A2(
						$elm$parser$Parser$ignorer,
						A2(
							$elm$parser$Parser$ignorer,
							A2($elm$parser$Parser$ignorer, $author$project$Day11$parseItemList, $elm$parser$Parser$spaces),
							$elm$parser$Parser$token('Operation: new =')),
						$elm$parser$Parser$spaces)),
				A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$ignorer,
						A2($elm$parser$Parser$ignorer, $author$project$Day11$parseOperation, $elm$parser$Parser$spaces),
						$elm$parser$Parser$token('Test: divisible by')),
					$elm$parser$Parser$spaces)),
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
					$elm$parser$Parser$token('If true: throw to monkey')),
				$elm$parser$Parser$spaces)),
		A2(
			$elm$parser$Parser$ignorer,
			A2(
				$elm$parser$Parser$ignorer,
				A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
				$elm$parser$Parser$token('If false: throw to monkey')),
			$elm$parser$Parser$spaces)),
	$elm$parser$Parser$int);
var $author$project$Day11$parseInputPart = function (input) {
	return A2($elm$parser$Parser$run, $author$project$Day11$monkeyParser, input);
};
var $author$project$Day11$parseInput = function (input) {
	var fn = F2(
		function (part, monkeys) {
			var result = $author$project$Day11$parseInputPart(part);
			return A3(
				$elm$core$Result$map2,
				F2(
					function (innerMonkeys, _v0) {
						var monkeyId = _v0.a;
						var monkey = _v0.b;
						return A3($elm$core$Dict$insert, monkeyId, monkey, innerMonkeys);
					}),
				monkeys,
				result);
		});
	return A3(
		$elm$core$List$foldl,
		fn,
		A2(
			$elm$core$Result$fromMaybe,
			_List_Nil,
			$elm$core$Maybe$Just($elm$core$Dict$empty)),
		A2($elm$core$String$split, '\n\n', input));
};
var $author$project$Day11$Monkey = F6(
	function (items, operation, testDiv, targetIfTrue, targetIfFalse, hasInspected) {
		return {aP: hasInspected, ao: items, bD: operation, bJ: targetIfFalse, bK: targetIfTrue, bi: testDiv};
	});
var $author$project$Day11$fakeMonkey = A6(
	$author$project$Day11$Monkey,
	_List_Nil,
	A2($author$project$Day11$Addition, $author$project$Day11$Self, $author$project$Day11$Self),
	0,
	0,
	0,
	0);
var $elm$core$Basics$modBy = _Basics_modBy;
var $author$project$Day11$getOperand = F2(
	function (op, item) {
		if (!op.$) {
			return item;
		} else {
			var c = op.a;
			return c;
		}
	});
var $author$project$Day11$processOperation = F2(
	function (operation, item) {
		if (!operation.$) {
			var op1 = operation.a;
			var op2 = operation.b;
			return A2($author$project$Day11$getOperand, op1, item) + A2($author$project$Day11$getOperand, op2, item);
		} else {
			var op1 = operation.a;
			var op2 = operation.b;
			return A2($author$project$Day11$getOperand, op1, item) * A2($author$project$Day11$getOperand, op2, item);
		}
	});
var $author$project$Day11$runDivTest = F2(
	function (divy, item) {
		return !A2($elm$core$Basics$modBy, divy, item);
	});
var $author$project$Day11$throwToMonkey = F3(
	function (monkeyId, monkeys, item) {
		var m = A2($elm$core$Dict$get, monkeyId, monkeys);
		if (m.$ === 1) {
			return monkeys;
		} else {
			var mon = m.a;
			return A3(
				$elm$core$Dict$insert,
				monkeyId,
				_Utils_update(
					mon,
					{
						ao: _Utils_ap(
							mon.ao,
							_List_fromArray(
								[item]))
					}),
				monkeys);
		}
	});
var $author$project$Day11$playRound = F3(
	function (puzzlePart, _v0, monkeys) {
		var oskarHelpMeHere = function (item) {
			if (!puzzlePart.$) {
				var i = puzzlePart.a;
				return (item / i) | 0;
			} else {
				return A2(
					$elm$core$Basics$modBy,
					A3(
						$elm$core$List$foldl,
						F2(
							function (a, b) {
								return a * b;
							}),
						1,
						A2(
							$elm$core$List$map,
							function ($) {
								return $.bi;
							},
							$elm$core$Dict$values(monkeys))),
					item);
			}
		};
		var fn2 = F3(
			function (monkey, item, all) {
				var newItem = oskarHelpMeHere(
					A2($author$project$Day11$processOperation, monkey.bD, item));
				return A2($author$project$Day11$runDivTest, monkey.bi, newItem) ? A3($author$project$Day11$throwToMonkey, monkey.bK, all, newItem) : A3($author$project$Day11$throwToMonkey, monkey.bJ, all, newItem);
			});
		var fn1 = F2(
			function (monkeyId, all) {
				var monkey = A2(
					$elm$core$Maybe$withDefault,
					$author$project$Day11$fakeMonkey,
					A2($elm$core$Dict$get, monkeyId, all));
				return A3(
					$elm$core$Dict$insert,
					monkeyId,
					_Utils_update(
						monkey,
						{
							aP: monkey.aP + $elm$core$List$length(monkey.ao),
							ao: _List_Nil
						}),
					A3(
						$elm$core$List$foldl,
						fn2(monkey),
						all,
						monkey.ao));
			});
		return A3(
			$elm$core$List$foldl,
			fn1,
			monkeys,
			$elm$core$Dict$keys(monkeys));
	});
var $author$project$Day11$playRounds = F3(
	function (count, puzzlePart, monkeys) {
		return A3(
			$elm$core$List$foldl,
			$author$project$Day11$playRound(puzzlePart),
			monkeys,
			A2($elm$core$List$repeat, count, 0));
	});
var $author$project$Day11$productOfInspectionOfMostActiveMonkeys = function (monkeys) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (a, b) {
				return a * b;
			}),
		1,
		A2(
			$elm$core$List$take,
			2,
			$elm$core$List$reverse(
				$elm$core$List$sort(
					A2(
						$elm$core$List$map,
						function ($) {
							return $.aP;
						},
						$elm$core$Dict$values(monkeys))))));
};
var $author$project$Day11$runPuzzle = F3(
	function (puzzleInput, rounds, puzzlePart) {
		var _v0 = $author$project$Day11$parseInput(puzzleInput);
		if (!_v0.$) {
			var monkeys = _v0.a;
			return $elm$core$String$fromInt(
				$author$project$Day11$productOfInspectionOfMostActiveMonkeys(
					A3($author$project$Day11$playRounds, rounds, puzzlePart, monkeys)));
		} else {
			return 'Error while parsing';
		}
	});
var $author$project$Day11$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A3(
			$author$project$Day11$runPuzzle,
			puzzleInput,
			20,
			$author$project$Day11$PuzzlePartA(3)),
		A3($author$project$Day11$runPuzzle, puzzleInput, 10000, $author$project$Day11$PuzzlePartB));
};
var $author$project$Day12$PartA = 0;
var $author$project$Day12$PartB = 1;
var $elm$parser$Parser$Done = function (a) {
	return {$: 1, a: a};
};
var $author$project$Day12$End = {$: 1};
var $elm$parser$Parser$Loop = function (a) {
	return {$: 0, a: a};
};
var $author$project$Day12$OnTheWay = function (a) {
	return {$: 2, a: a};
};
var $author$project$Day12$Start = {$: 0};
var $elm$parser$Parser$Advanced$getPosition = function (s) {
	return A3(
		$elm$parser$Parser$Advanced$Good,
		false,
		_Utils_Tuple2(s.cr, s.bU),
		s);
};
var $elm$parser$Parser$getPosition = $elm$parser$Parser$Advanced$getPosition;
var $elm$parser$Parser$andThen = $elm$parser$Parser$Advanced$andThen;
var $elm$parser$Parser$Problem = function (a) {
	return {$: 12, a: a};
};
var $elm$parser$Parser$Advanced$problem = function (x) {
	return function (s) {
		return A2(
			$elm$parser$Parser$Advanced$Bad,
			false,
			A2($elm$parser$Parser$Advanced$fromState, s, x));
	};
};
var $elm$parser$Parser$problem = function (msg) {
	return $elm$parser$Parser$Advanced$problem(
		$elm$parser$Parser$Problem(msg));
};
var $author$project$Day12$heightParser = function () {
	var fn = function (s) {
		var _v0 = $elm$core$List$head(
			$elm$core$String$toList(s));
		if (_v0.$ === 1) {
			return $elm$parser$Parser$problem('invalid case which can not appear');
		} else {
			var ch = _v0.a;
			return $elm$parser$Parser$succeed(
				$elm$core$Char$toCode(ch));
		}
	};
	return A2(
		$elm$parser$Parser$andThen,
		fn,
		$elm$parser$Parser$getChompedString(
			$elm$parser$Parser$chompIf($elm$core$Char$isLower)));
}();
var $elm$parser$Parser$map = $elm$parser$Parser$Advanced$map;
var $author$project$Day12$gridParserHelper = function (grid) {
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						F2(
							function (p, s) {
								return $elm$parser$Parser$Loop(
									A3($elm$core$Dict$insert, p, s, grid));
							})),
					$elm$parser$Parser$getPosition),
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed($author$project$Day12$Start),
								$elm$parser$Parser$symbol('S')),
								A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed($author$project$Day12$End),
								$elm$parser$Parser$symbol('E')),
								A2(
								$elm$parser$Parser$keeper,
								$elm$parser$Parser$succeed($author$project$Day12$OnTheWay),
								$author$project$Day12$heightParser)
							])),
					$elm$parser$Parser$spaces)),
				A2(
				$elm$parser$Parser$map,
				function (_v0) {
					return $elm$parser$Parser$Done(grid);
				},
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed(0),
					$elm$parser$Parser$end))
			]));
};
var $elm$parser$Parser$toAdvancedStep = function (step) {
	if (!step.$) {
		var s = step.a;
		return $elm$parser$Parser$Advanced$Loop(s);
	} else {
		var a = step.a;
		return $elm$parser$Parser$Advanced$Done(a);
	}
};
var $elm$parser$Parser$loop = F2(
	function (state, callback) {
		return A2(
			$elm$parser$Parser$Advanced$loop,
			state,
			function (s) {
				return A2(
					$elm$parser$Parser$map,
					$elm$parser$Parser$toAdvancedStep,
					callback(s));
			});
	});
var $author$project$Day12$gridParser = A2($elm$parser$Parser$loop, $elm$core$Dict$empty, $author$project$Day12$gridParserHelper);
var $elm$core$Dict$isEmpty = function (dict) {
	if (dict.$ === -2) {
		return true;
	} else {
		return false;
	}
};
var $author$project$Day12$getStartPositions = F2(
	function (part, grid) {
		var filterFn = function () {
			if (!part) {
				return F2(
					function (_v1, squ) {
						if (!squ.$) {
							return true;
						} else {
							return false;
						}
					});
			} else {
				return F2(
					function (_v3, squ) {
						switch (squ.$) {
							case 0:
								return true;
							case 2:
								var h = squ.a;
								return _Utils_eq(
									h,
									$elm$core$Char$toCode('a'));
							default:
								return false;
						}
					});
			}
		}();
		return $elm$core$Set$fromList(
			$elm$core$Dict$keys(
				A2($elm$core$Dict$filter, filterFn, grid)));
	});
var $elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var $author$project$Day12$foundEnd = F2(
	function (grid, positions) {
		return A2(
			$elm$core$List$any,
			function (pos) {
				var _v0 = A2($elm$core$Dict$get, pos, grid);
				if ((!_v0.$) && (_v0.a.$ === 1)) {
					var _v1 = _v0.a;
					return true;
				} else {
					return false;
				}
			},
			$elm$core$Set$toList(positions));
	});
var $elm$core$Dict$getMin = function (dict) {
	getMin:
	while (true) {
		if ((dict.$ === -1) && (dict.d.$ === -1)) {
			var left = dict.d;
			var $temp$dict = left;
			dict = $temp$dict;
			continue getMin;
		} else {
			return dict;
		}
	}
};
var $elm$core$Dict$moveRedLeft = function (dict) {
	if (((dict.$ === -1) && (dict.d.$ === -1)) && (dict.e.$ === -1)) {
		if ((dict.e.d.$ === -1) && (!dict.e.d.a)) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var lLeft = _v1.d;
			var lRight = _v1.e;
			var _v2 = dict.e;
			var rClr = _v2.a;
			var rK = _v2.b;
			var rV = _v2.c;
			var rLeft = _v2.d;
			var _v3 = rLeft.a;
			var rlK = rLeft.b;
			var rlV = rLeft.c;
			var rlL = rLeft.d;
			var rlR = rLeft.e;
			var rRight = _v2.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				0,
				rlK,
				rlV,
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					1,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, 0, lK, lV, lLeft, lRight),
					rlL),
				A5($elm$core$Dict$RBNode_elm_builtin, 1, rK, rV, rlR, rRight));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v4 = dict.d;
			var lClr = _v4.a;
			var lK = _v4.b;
			var lV = _v4.c;
			var lLeft = _v4.d;
			var lRight = _v4.e;
			var _v5 = dict.e;
			var rClr = _v5.a;
			var rK = _v5.b;
			var rV = _v5.c;
			var rLeft = _v5.d;
			var rRight = _v5.e;
			if (clr === 1) {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					1,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, 0, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, 0, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					1,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, 0, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, 0, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$moveRedRight = function (dict) {
	if (((dict.$ === -1) && (dict.d.$ === -1)) && (dict.e.$ === -1)) {
		if ((dict.d.d.$ === -1) && (!dict.d.d.a)) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var _v2 = _v1.d;
			var _v3 = _v2.a;
			var llK = _v2.b;
			var llV = _v2.c;
			var llLeft = _v2.d;
			var llRight = _v2.e;
			var lRight = _v1.e;
			var _v4 = dict.e;
			var rClr = _v4.a;
			var rK = _v4.b;
			var rV = _v4.c;
			var rLeft = _v4.d;
			var rRight = _v4.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				0,
				lK,
				lV,
				A5($elm$core$Dict$RBNode_elm_builtin, 1, llK, llV, llLeft, llRight),
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					1,
					k,
					v,
					lRight,
					A5($elm$core$Dict$RBNode_elm_builtin, 0, rK, rV, rLeft, rRight)));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v5 = dict.d;
			var lClr = _v5.a;
			var lK = _v5.b;
			var lV = _v5.c;
			var lLeft = _v5.d;
			var lRight = _v5.e;
			var _v6 = dict.e;
			var rClr = _v6.a;
			var rK = _v6.b;
			var rV = _v6.c;
			var rLeft = _v6.d;
			var rRight = _v6.e;
			if (clr === 1) {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					1,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, 0, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, 0, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					1,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, 0, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, 0, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$removeHelpPrepEQGT = F7(
	function (targetKey, dict, color, key, value, left, right) {
		if ((left.$ === -1) && (!left.a)) {
			var _v1 = left.a;
			var lK = left.b;
			var lV = left.c;
			var lLeft = left.d;
			var lRight = left.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				lK,
				lV,
				lLeft,
				A5($elm$core$Dict$RBNode_elm_builtin, 0, key, value, lRight, right));
		} else {
			_v2$2:
			while (true) {
				if ((right.$ === -1) && (right.a === 1)) {
					if (right.d.$ === -1) {
						if (right.d.a === 1) {
							var _v3 = right.a;
							var _v4 = right.d;
							var _v5 = _v4.a;
							return $elm$core$Dict$moveRedRight(dict);
						} else {
							break _v2$2;
						}
					} else {
						var _v6 = right.a;
						var _v7 = right.d;
						return $elm$core$Dict$moveRedRight(dict);
					}
				} else {
					break _v2$2;
				}
			}
			return dict;
		}
	});
var $elm$core$Dict$removeMin = function (dict) {
	if ((dict.$ === -1) && (dict.d.$ === -1)) {
		var color = dict.a;
		var key = dict.b;
		var value = dict.c;
		var left = dict.d;
		var lColor = left.a;
		var lLeft = left.d;
		var right = dict.e;
		if (lColor === 1) {
			if ((lLeft.$ === -1) && (!lLeft.a)) {
				var _v3 = lLeft.a;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					key,
					value,
					$elm$core$Dict$removeMin(left),
					right);
			} else {
				var _v4 = $elm$core$Dict$moveRedLeft(dict);
				if (_v4.$ === -1) {
					var nColor = _v4.a;
					var nKey = _v4.b;
					var nValue = _v4.c;
					var nLeft = _v4.d;
					var nRight = _v4.e;
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						$elm$core$Dict$removeMin(nLeft),
						nRight);
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			}
		} else {
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				key,
				value,
				$elm$core$Dict$removeMin(left),
				right);
		}
	} else {
		return $elm$core$Dict$RBEmpty_elm_builtin;
	}
};
var $elm$core$Dict$removeHelp = F2(
	function (targetKey, dict) {
		if (dict.$ === -2) {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		} else {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_cmp(targetKey, key) < 0) {
				if ((left.$ === -1) && (left.a === 1)) {
					var _v4 = left.a;
					var lLeft = left.d;
					if ((lLeft.$ === -1) && (!lLeft.a)) {
						var _v6 = lLeft.a;
						return A5(
							$elm$core$Dict$RBNode_elm_builtin,
							color,
							key,
							value,
							A2($elm$core$Dict$removeHelp, targetKey, left),
							right);
					} else {
						var _v7 = $elm$core$Dict$moveRedLeft(dict);
						if (_v7.$ === -1) {
							var nColor = _v7.a;
							var nKey = _v7.b;
							var nValue = _v7.c;
							var nLeft = _v7.d;
							var nRight = _v7.e;
							return A5(
								$elm$core$Dict$balance,
								nColor,
								nKey,
								nValue,
								A2($elm$core$Dict$removeHelp, targetKey, nLeft),
								nRight);
						} else {
							return $elm$core$Dict$RBEmpty_elm_builtin;
						}
					}
				} else {
					return A5(
						$elm$core$Dict$RBNode_elm_builtin,
						color,
						key,
						value,
						A2($elm$core$Dict$removeHelp, targetKey, left),
						right);
				}
			} else {
				return A2(
					$elm$core$Dict$removeHelpEQGT,
					targetKey,
					A7($elm$core$Dict$removeHelpPrepEQGT, targetKey, dict, color, key, value, left, right));
			}
		}
	});
var $elm$core$Dict$removeHelpEQGT = F2(
	function (targetKey, dict) {
		if (dict.$ === -1) {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_eq(targetKey, key)) {
				var _v1 = $elm$core$Dict$getMin(right);
				if (_v1.$ === -1) {
					var minKey = _v1.b;
					var minValue = _v1.c;
					return A5(
						$elm$core$Dict$balance,
						color,
						minKey,
						minValue,
						left,
						$elm$core$Dict$removeMin(right));
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			} else {
				return A5(
					$elm$core$Dict$balance,
					color,
					key,
					value,
					left,
					A2($elm$core$Dict$removeHelp, targetKey, right));
			}
		} else {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		}
	});
var $elm$core$Dict$remove = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$removeHelp, key, dict);
		if ((_v0.$ === -1) && (!_v0.a)) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, 1, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $elm$core$Dict$diff = F2(
	function (t1, t2) {
		return A3(
			$elm$core$Dict$foldl,
			F3(
				function (k, v, t) {
					return A2($elm$core$Dict$remove, k, t);
				}),
			t1,
			t2);
	});
var $elm$core$Set$diff = F2(
	function (_v0, _v1) {
		var dict1 = _v0;
		var dict2 = _v1;
		return A2($elm$core$Dict$diff, dict1, dict2);
	});
var $elm$core$Set$foldl = F3(
	function (func, initialState, _v0) {
		var dict = _v0;
		return A3(
			$elm$core$Dict$foldl,
			F3(
				function (key, _v1, state) {
					return A2(func, key, state);
				}),
			initialState,
			dict);
	});
var $author$project$Day12$getNeighbours = F3(
	function (grid, height, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		var filterFn = function (pos) {
			var _v1 = A2($elm$core$Dict$get, pos, grid);
			_v1$2:
			while (true) {
				if (!_v1.$) {
					switch (_v1.a.$) {
						case 1:
							var _v2 = _v1.a;
							return _Utils_cmp(
								height + 1,
								$elm$core$Char$toCode('z')) > -1;
						case 2:
							var i = _v1.a.a;
							return _Utils_cmp(height + 1, i) > -1;
						default:
							break _v1$2;
					}
				} else {
					break _v1$2;
				}
			}
			return false;
		};
		return $elm$core$Set$fromList(
			A2(
				$elm$core$List$filter,
				filterFn,
				_List_fromArray(
					[
						_Utils_Tuple2(x - 1, y),
						_Utils_Tuple2(x + 1, y),
						_Utils_Tuple2(x, y - 1),
						_Utils_Tuple2(x, y + 1)
					])));
	});
var $elm$core$Set$union = F2(
	function (_v0, _v1) {
		var dict1 = _v0;
		var dict2 = _v1;
		return A2($elm$core$Dict$union, dict1, dict2);
	});
var $author$project$Day12$nextLayer = F3(
	function (grid, visited, current) {
		var fn = F2(
			function (position, all) {
				var _v0 = A2($elm$core$Dict$get, position, grid);
				_v0$2:
				while (true) {
					if (!_v0.$) {
						switch (_v0.a.$) {
							case 2:
								var h = _v0.a.a;
								return A2(
									$elm$core$Set$diff,
									A2(
										$elm$core$Set$union,
										all,
										A3($author$project$Day12$getNeighbours, grid, h, position)),
									visited);
							case 0:
								var _v1 = _v0.a;
								return A2(
									$elm$core$Set$diff,
									A2(
										$elm$core$Set$union,
										all,
										A3(
											$author$project$Day12$getNeighbours,
											grid,
											$elm$core$Char$toCode('a'),
											position)),
									visited);
							default:
								break _v0$2;
						}
					} else {
						break _v0$2;
					}
				}
				return $elm$core$Set$empty;
			});
		return A3($elm$core$Set$foldl, fn, $elm$core$Set$empty, current);
	});
var $author$project$Day12$walk = F3(
	function (grid, visited, positions) {
		if (A2($author$project$Day12$foundEnd, grid, positions)) {
			return 0;
		} else {
			var newVisited = A2($elm$core$Set$union, visited, positions);
			return A3(
				$author$project$Day12$walk,
				grid,
				newVisited,
				A3($author$project$Day12$nextLayer, grid, newVisited, positions)) + 1;
		}
	});
var $author$project$Day12$searchShortestPath = F2(
	function (part, grid) {
		return A3(
			$author$project$Day12$walk,
			grid,
			$elm$core$Set$empty,
			A2($author$project$Day12$getStartPositions, part, grid));
	});
var $author$project$Day12$solvePuzzle = F2(
	function (puzzleInput, part) {
		var _v0 = A2($elm$parser$Parser$run, $author$project$Day12$gridParser, puzzleInput);
		if (!_v0.$) {
			var grid = _v0.a;
			return $elm$core$Dict$isEmpty(grid) ? 'empty grid' : $elm$core$String$fromInt(
				A2($author$project$Day12$searchShortestPath, part, grid));
		} else {
			return 'Error';
		}
	});
var $author$project$Day12$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A2($author$project$Day12$solvePuzzle, puzzleInput, 0),
		A2($author$project$Day12$solvePuzzle, puzzleInput, 1));
};
var $author$project$Day13$Multi = function (a) {
	return {$: 1, a: a};
};
var $author$project$Day13$Single = function (a) {
	return {$: 0, a: a};
};
var $author$project$Day13$inRightOrder = function (pair) {
	inRightOrder:
	while (true) {
		var _v0 = pair.K;
		if (!_v0.b) {
			return (!$elm$core$List$length(pair.I)) ? 1 : 0;
		} else {
			var l1 = _v0.a;
			var restLeft = _v0.b;
			var _v1 = pair.I;
			if (!_v1.b) {
				return 2;
			} else {
				var r1 = _v1.a;
				var restRight = _v1.b;
				var _v2 = _Utils_Tuple2(l1, r1);
				if (!_v2.a.$) {
					if (!_v2.b.$) {
						var a = _v2.a.a;
						var b = _v2.b.a;
						if (_Utils_cmp(a, b) < 0) {
							return 0;
						} else {
							if (_Utils_cmp(a, b) > 0) {
								return 2;
							} else {
								var $temp$pair = {K: restLeft, I: restRight};
								pair = $temp$pair;
								continue inRightOrder;
							}
						}
					} else {
						var a = _v2.a.a;
						var $temp$pair = {
							K: A2(
								$elm$core$List$cons,
								$author$project$Day13$Multi(
									_List_fromArray(
										[
											$author$project$Day13$Single(a)
										])),
								restLeft),
							I: pair.I
						};
						pair = $temp$pair;
						continue inRightOrder;
					}
				} else {
					if (!_v2.b.$) {
						var b = _v2.b.a;
						var $temp$pair = {
							K: pair.K,
							I: A2(
								$elm$core$List$cons,
								$author$project$Day13$Multi(
									_List_fromArray(
										[
											$author$project$Day13$Single(b)
										])),
								restRight)
						};
						pair = $temp$pair;
						continue inRightOrder;
					} else {
						var a = _v2.a.a;
						var b = _v2.b.a;
						var _v3 = $author$project$Day13$inRightOrder(
							{K: a, I: b});
						switch (_v3) {
							case 0:
								return 0;
							case 2:
								return 2;
							default:
								var $temp$pair = {K: restLeft, I: restRight};
								pair = $temp$pair;
								continue inRightOrder;
						}
					}
				}
			}
		}
	}
};
var $elm$core$Maybe$map2 = F3(
	function (func, ma, mb) {
		if (ma.$ === 1) {
			return $elm$core$Maybe$Nothing;
		} else {
			var a = ma.a;
			if (mb.$ === 1) {
				return $elm$core$Maybe$Nothing;
			} else {
				var b = mb.a;
				return $elm$core$Maybe$Just(
					A2(func, a, b));
			}
		}
	});
var $elm$parser$Parser$Advanced$lazy = function (thunk) {
	return function (s) {
		var _v0 = thunk(0);
		var parse = _v0;
		return parse(s);
	};
};
var $elm$parser$Parser$lazy = $elm$parser$Parser$Advanced$lazy;
function $author$project$Day13$cyclic$parserListElement() {
	return $elm$parser$Parser$sequence(
		{
			al: ']',
			c2: $author$project$Day13$cyclic$parserElement(),
			dp: ',',
			dq: $elm$parser$Parser$spaces,
			J: '[',
			dv: 0
		});
}
function $author$project$Day13$cyclic$parserElement() {
	return $elm$parser$Parser$oneOf(
		_List_fromArray(
			[
				A2($elm$parser$Parser$map, $author$project$Day13$Single, $elm$parser$Parser$int),
				A2(
				$elm$parser$Parser$map,
				$author$project$Day13$Multi,
				$elm$parser$Parser$lazy(
					function (_v0) {
						return $author$project$Day13$cyclic$parserListElement();
					}))
			]));
}
var $author$project$Day13$parserListElement = $author$project$Day13$cyclic$parserListElement();
$author$project$Day13$cyclic$parserListElement = function () {
	return $author$project$Day13$parserListElement;
};
var $author$project$Day13$parserElement = $author$project$Day13$cyclic$parserElement();
$author$project$Day13$cyclic$parserElement = function () {
	return $author$project$Day13$parserElement;
};
var $author$project$Day13$parseList = function (s) {
	return $elm$core$Result$toMaybe(
		A2($elm$parser$Parser$run, $author$project$Day13$parserListElement, s));
};
var $author$project$Day13$parsePairs = function (s) {
	var _v0 = A2(
		$elm$core$List$take,
		2,
		A2($elm$core$String$split, '\n', s));
	if (_v0.b && _v0.b.b) {
		var left = _v0.a;
		var _v1 = _v0.b;
		var right = _v1.a;
		return A3(
			$elm$core$Maybe$map2,
			F2(
				function (l, r) {
					return {K: l, I: r};
				}),
			$author$project$Day13$parseList(left),
			$author$project$Day13$parseList(right));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Day13$runPartA = function (puzzleInput) {
	return $elm$core$String$fromInt(
		$elm$core$List$sum(
			A2(
				$elm$core$List$map,
				$elm$core$Tuple$first,
				A2(
					$elm$core$List$filter,
					function (_v0) {
						var p = _v0.b;
						var _v1 = $author$project$Day13$inRightOrder(p);
						if (!_v1) {
							return true;
						} else {
							return false;
						}
					},
					A2(
						$elm$core$List$indexedMap,
						F2(
							function (i, p) {
								return _Utils_Tuple2(i + 1, p);
							}),
						A2(
							$elm$core$List$filterMap,
							$author$project$Day13$parsePairs,
							A2($elm$core$String$split, '\n\n', puzzleInput)))))));
};
var $author$project$Day13$dividerPacketA = '[[2]]';
var $author$project$Day13$dividerPacketATransformed = _List_fromArray(
	[
		$author$project$Day13$Multi(
		_List_fromArray(
			[
				$author$project$Day13$Single(2)
			]))
	]);
var $author$project$Day13$dividerPacketB = '[[6]]';
var $author$project$Day13$dividerPacketBTransformed = _List_fromArray(
	[
		$author$project$Day13$Multi(
		_List_fromArray(
			[
				$author$project$Day13$Single(6)
			]))
	]);
var $elm$core$List$sortWith = _List_sortWith;
var $author$project$Day13$runPartB = function (puzzleInput) {
	return $elm$core$String$fromInt(
		A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, res) {
					var i = _v0.a;
					var e = _v0.b;
					return (_Utils_eq(e, $author$project$Day13$dividerPacketATransformed) || _Utils_eq(e, $author$project$Day13$dividerPacketBTransformed)) ? (i * res) : res;
				}),
			1,
			A2(
				$elm$core$List$indexedMap,
				F2(
					function (i, p) {
						return _Utils_Tuple2(i + 1, p);
					}),
				A2(
					$elm$core$List$sortWith,
					F2(
						function (a, b) {
							return $author$project$Day13$inRightOrder(
								{K: a, I: b});
						}),
					A2(
						$elm$core$List$filterMap,
						$author$project$Day13$parseList,
						A2(
							$elm$core$List$cons,
							$author$project$Day13$dividerPacketA,
							A2(
								$elm$core$List$cons,
								$author$project$Day13$dividerPacketB,
								A2($elm$core$String$split, '\n', puzzleInput))))))));
};
var $author$project$Day13$run = function (puzzleInput) {
	return _Utils_Tuple2(
		$author$project$Day13$runPartA(puzzleInput),
		$author$project$Day13$runPartB(puzzleInput));
};
var $author$project$Day14$PuzzlePartA = 0;
var $author$project$Day14$PuzzlePartB = 1;
var $elm$core$Set$member = F2(
	function (key, _v0) {
		var dict = _v0;
		return A2($elm$core$Dict$member, key, dict);
	});
var $author$project$Day14$sandUntil = F4(
	function (puzzlePart, lowest, points, _v0) {
		sandUntil:
		while (true) {
			var x = _v0.a;
			var y = _v0.b;
			if (_Utils_cmp(y, lowest) > 0) {
				if (!puzzlePart) {
					return points;
				} else {
					return A2(
						$elm$core$Set$insert,
						_Utils_Tuple2(x, y),
						points);
				}
			} else {
				if (!A2(
					$elm$core$Set$member,
					_Utils_Tuple2(x, y + 1),
					points)) {
					var $temp$puzzlePart = puzzlePart,
						$temp$lowest = lowest,
						$temp$points = points,
						$temp$_v0 = _Utils_Tuple2(x, y + 1);
					puzzlePart = $temp$puzzlePart;
					lowest = $temp$lowest;
					points = $temp$points;
					_v0 = $temp$_v0;
					continue sandUntil;
				} else {
					if (!A2(
						$elm$core$Set$member,
						_Utils_Tuple2(x - 1, y + 1),
						points)) {
						var $temp$puzzlePart = puzzlePart,
							$temp$lowest = lowest,
							$temp$points = points,
							$temp$_v0 = _Utils_Tuple2(x - 1, y + 1);
						puzzlePart = $temp$puzzlePart;
						lowest = $temp$lowest;
						points = $temp$points;
						_v0 = $temp$_v0;
						continue sandUntil;
					} else {
						if (!A2(
							$elm$core$Set$member,
							_Utils_Tuple2(x + 1, y + 1),
							points)) {
							var $temp$puzzlePart = puzzlePart,
								$temp$lowest = lowest,
								$temp$points = points,
								$temp$_v0 = _Utils_Tuple2(x + 1, y + 1);
							puzzlePart = $temp$puzzlePart;
							lowest = $temp$lowest;
							points = $temp$points;
							_v0 = $temp$_v0;
							continue sandUntil;
						} else {
							if (!y) {
								return A2(
									$elm$core$Set$insert,
									_Utils_Tuple2(x, y),
									points);
							} else {
								return A2(
									$elm$core$Set$insert,
									_Utils_Tuple2(x, y),
									points);
							}
						}
					}
				}
			}
		}
	});
var $author$project$Day14$walk = F3(
	function (puzzlePart, lowest, points) {
		walk:
		while (true) {
			var newPoints = A4(
				$author$project$Day14$sandUntil,
				puzzlePart,
				lowest,
				points,
				_Utils_Tuple2(500, 0));
			var condition = function () {
				if (!puzzlePart) {
					return _Utils_eq(
						$elm$core$Set$size(newPoints),
						$elm$core$Set$size(points));
				} else {
					return A2(
						$elm$core$Set$member,
						_Utils_Tuple2(500, 0),
						newPoints);
				}
			}();
			if (condition) {
				return newPoints;
			} else {
				var $temp$puzzlePart = puzzlePart,
					$temp$lowest = lowest,
					$temp$points = newPoints;
				puzzlePart = $temp$puzzlePart;
				lowest = $temp$lowest;
				points = $temp$points;
				continue walk;
			}
		}
	});
var $author$project$Day14$dropSand = F2(
	function (puzzlePart, rocks) {
		var lowestRock = A2(
			$elm$core$Maybe$withDefault,
			0,
			$elm$core$List$head(
				$elm$core$List$reverse(
					$elm$core$List$sort(
						A2(
							$elm$core$List$map,
							$elm$core$Tuple$second,
							$elm$core$Set$toList(rocks))))));
		var newPoints = A3($author$project$Day14$walk, puzzlePart, lowestRock, rocks);
		return _Utils_Tuple2(
			$elm$core$Set$size(newPoints) - $elm$core$Set$size(rocks),
			newPoints);
	});
var $elm$parser$Parser$chompWhile = $elm$parser$Parser$Advanced$chompWhile;
var $author$project$Day14$rockPathParser = $elm$parser$Parser$sequence(
	{
		al: '\n',
		c2: A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				$elm$parser$Parser$succeed(
					F2(
						function (a, b) {
							return _Utils_Tuple2(a, b);
						})),
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$int,
					$elm$parser$Parser$symbol(','))),
			$elm$parser$Parser$int),
		dp: '->',
		dq: $elm$parser$Parser$chompWhile(
			function (c) {
				return c === ' ';
			}),
		J: '',
		dv: 0
	});
var $author$project$Day14$puzzleInputParser = A2(
	$elm$parser$Parser$loop,
	_List_Nil,
	function (rockPathList) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					function (rp) {
						return $elm$parser$Parser$Loop(
							A2($elm$core$List$cons, rp, rockPathList));
					},
					$author$project$Day14$rockPathParser),
					A2(
					$elm$parser$Parser$map,
					function (_v0) {
						return $elm$parser$Parser$Done(
							$elm$core$List$reverse(rockPathList));
					},
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed(0),
						$elm$parser$Parser$end))
				]));
	});
var $author$project$Day14$rockLine = F2(
	function (_v0, _v1) {
		var x1 = _v0.a;
		var y1 = _v0.b;
		var x2 = _v1.a;
		var y2 = _v1.b;
		return $elm$core$Set$fromList(
			_Utils_eq(x1, x2) ? A2(
				$elm$core$List$map,
				function (y) {
					return _Utils_Tuple2(x1, y);
				},
				(_Utils_cmp(y1, y2) < 0) ? A2($elm$core$List$range, y1, y2) : A2($elm$core$List$range, y2, y1)) : (_Utils_eq(y1, y2) ? A2(
				$elm$core$List$map,
				function (x) {
					return _Utils_Tuple2(x, y1);
				},
				(_Utils_cmp(x1, x2) < 0) ? A2($elm$core$List$range, x1, x2) : A2($elm$core$List$range, x2, x1)) : _List_Nil));
	});
var $author$project$Day14$toRockPoints = function (rockPaths) {
	var pointFunc = F2(
		function (point, acc) {
			return {
				bF: $elm$core$Maybe$Just(point),
				aX: function () {
					var _v0 = acc.bF;
					if (_v0.$ === 1) {
						return A2($elm$core$Set$insert, point, acc.aX);
					} else {
						var oldPoint = _v0.a;
						return A2(
							$elm$core$Set$union,
							A2($author$project$Day14$rockLine, oldPoint, point),
							acc.aX);
					}
				}()
			};
		});
	var pathFunc = F2(
		function (path, acc) {
			return A3(
				$elm$core$List$foldl,
				pointFunc,
				{bF: $elm$core$Maybe$Nothing, aX: acc},
				path).aX;
		});
	return A3($elm$core$List$foldl, pathFunc, $elm$core$Set$empty, rockPaths);
};
var $author$project$Day14$runPart = F2(
	function (puzzleInput, puzzlePart) {
		var _v0 = A2($elm$parser$Parser$run, $author$project$Day14$puzzleInputParser, puzzleInput);
		if (!_v0.$) {
			var rockPaths = _v0.a;
			var rocks = $author$project$Day14$toRockPoints(rockPaths);
			return $elm$core$String$fromInt(
				A2($author$project$Day14$dropSand, puzzlePart, rocks).a);
		} else {
			return 'Error';
		}
	});
var $author$project$Day14$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A2($author$project$Day14$runPart, puzzleInput, 0),
		A2($author$project$Day14$runPart, puzzleInput, 1));
};
var $author$project$Day15$calcForField = F2(
	function (row, field) {
		var yField = field.as.b;
		var xSideStep = field.Y - $elm$core$Basics$abs(row - yField);
		var xField = field.as.a;
		return A3(
			$elm$core$List$foldl,
			F2(
				function (x, set) {
					return A2(
						$elm$core$Set$insert,
						_Utils_Tuple2(xField - x, row),
						A2(
							$elm$core$Set$insert,
							_Utils_Tuple2(xField + x, row),
							set));
				}),
			$elm$core$Set$empty,
			A2($elm$core$List$range, 0, xSideStep));
	});
var $elm$core$Set$filter = F2(
	function (isGood, _v0) {
		var dict = _v0;
		return A2(
			$elm$core$Dict$filter,
			F2(
				function (key, _v1) {
					return isGood(key);
				}),
			dict);
	});
var $author$project$Day15$calcForRow = F2(
	function (row, fields) {
		var fn = F2(
			function (field, result) {
				return A2(
					$elm$core$Set$union,
					A2($author$project$Day15$calcForField, row, field),
					result);
			});
		var beaconsInRow = $elm$core$Set$size(
			A2(
				$elm$core$Set$filter,
				function (beacon) {
					return _Utils_eq(beacon.b, row);
				},
				A3(
					$elm$core$List$foldl,
					F2(
						function (field, set) {
							return A2($elm$core$Set$insert, field.bq, set);
						}),
					$elm$core$Set$empty,
					fields)));
		return $elm$core$Set$size(
			A3($elm$core$List$foldl, fn, $elm$core$Set$empty, fields)) - beaconsInRow;
	});
var $author$project$Day15$myInt = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed($elm$core$Basics$negate),
				$elm$parser$Parser$symbol('-')),
			$elm$parser$Parser$int),
			$elm$parser$Parser$int
		]));
var $author$project$Day15$parserLine = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed(
						F4(
							function (x1, y1, x2, y2) {
								return _Utils_Tuple2(
									_Utils_Tuple2(x1, y1),
									_Utils_Tuple2(x2, y2));
							})),
					$elm$parser$Parser$token('Sensor at x=')),
				A2(
					$elm$parser$Parser$ignorer,
					$author$project$Day15$myInt,
					$elm$parser$Parser$token(', y='))),
			A2(
				$elm$parser$Parser$ignorer,
				$author$project$Day15$myInt,
				$elm$parser$Parser$token(': closest beacon is at x='))),
		A2(
			$elm$parser$Parser$ignorer,
			$author$project$Day15$myInt,
			$elm$parser$Parser$token(', y='))),
	A2(
		$elm$parser$Parser$ignorer,
		$author$project$Day15$myInt,
		$elm$parser$Parser$symbol('\n')));
var $author$project$Day15$puzzleParser = A2(
	$elm$parser$Parser$loop,
	_List_Nil,
	function (all) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					function (line) {
						return $elm$parser$Parser$Loop(
							A2($elm$core$List$cons, line, all));
					},
					$author$project$Day15$parserLine),
					A2(
					$elm$parser$Parser$map,
					function (_v0) {
						return $elm$parser$Parser$Done(
							$elm$core$List$reverse(all));
					},
					$elm$parser$Parser$succeed(0))
				]));
	});
var $author$project$Day15$distanceBetween = F2(
	function (_v0, _v1) {
		var x1 = _v0.a;
		var y1 = _v0.b;
		var x2 = _v1.a;
		var y2 = _v1.b;
		return $elm$core$Basics$abs(x1 - x2) + $elm$core$Basics$abs(y1 - y2);
	});
var $author$project$Day15$toField = F2(
	function (sensor, beacon) {
		return {
			bq: beacon,
			Y: A2($author$project$Day15$distanceBetween, sensor, beacon),
			as: sensor
		};
	});
var $author$project$Day15$runPartA = F2(
	function (puzzleInput, row) {
		var _v0 = A2($elm$parser$Parser$run, $author$project$Day15$puzzleParser, puzzleInput);
		if (!_v0.$) {
			var l = _v0.a;
			return $elm$core$String$fromInt(
				A2(
					$author$project$Day15$calcForRow,
					row,
					A2(
						$elm$core$List$map,
						function (_v1) {
							var sensor = _v1.a;
							var beacon = _v1.b;
							return A2($author$project$Day15$toField, sensor, beacon);
						},
						l)));
		} else {
			return 'Error';
		}
	});
var $author$project$Day15$checkIsOutside = F3(
	function (allFields, cave, points) {
		var fn = F2(
			function (point, result) {
				if (!result.$) {
					var found = result.a;
					return $elm$core$Maybe$Just(found);
				} else {
					return ((point.a < 0) || ((_Utils_cmp(point.a, cave) > 0) || ((point.b < 0) || (_Utils_cmp(point.b, cave) > 0)))) ? $elm$core$Maybe$Nothing : (A2(
						$elm$core$List$any,
						function (field) {
							return _Utils_cmp(
								field.Y,
								A2($author$project$Day15$distanceBetween, field.as, point)) > -1;
						},
						allFields) ? $elm$core$Maybe$Nothing : $elm$core$Maybe$Just(point));
				}
			});
		return A3($elm$core$Set$foldl, fn, $elm$core$Maybe$Nothing, points);
	});
var $author$project$Day15$RightDown = 0;
var $author$project$Day15$RightUp = 1;
var $author$project$Day15$getLine = F3(
	function (diagonal, _v0, _v1) {
		var x1 = _v0.a;
		var y1 = _v0.b;
		var x2 = _v1.a;
		var y2 = _v1.b;
		var i = $elm$core$Basics$abs(x1 - x2);
		return $elm$core$Set$fromList(
			A2(
				$elm$core$List$map,
				function (n) {
					if (!diagonal) {
						return _Utils_Tuple2(x1 + n, y1 + n);
					} else {
						return _Utils_Tuple2(x1 + n, y1 - n);
					}
				},
				A2($elm$core$List$range, 0, i)));
	});
var $author$project$Day15$getBorderPoints = function (field) {
	var y = field.as.b;
	var x = field.as.a;
	var west = _Utils_Tuple2((x - field.Y) - 1, y);
	var south = _Utils_Tuple2(x, (y + field.Y) + 1);
	var north = _Utils_Tuple2(x, (y - field.Y) - 1);
	var east = _Utils_Tuple2((x + field.Y) + 1, y);
	return A2(
		$elm$core$Set$union,
		A3($author$project$Day15$getLine, 1, west, north),
		A2(
			$elm$core$Set$union,
			A3($author$project$Day15$getLine, 0, west, south),
			A2(
				$elm$core$Set$union,
				A3($author$project$Day15$getLine, 1, south, east),
				A3($author$project$Day15$getLine, 0, north, east))));
};
var $author$project$Day15$walk = F3(
	function (allFields, cave, fields) {
		walk:
		while (true) {
			if (fields.b) {
				var field = fields.a;
				var rest = fields.b;
				var _v1 = A3(
					$author$project$Day15$checkIsOutside,
					allFields,
					cave,
					$author$project$Day15$getBorderPoints(field));
				if (!_v1.$) {
					var point = _v1.a;
					return $elm$core$Maybe$Just(point);
				} else {
					var $temp$allFields = allFields,
						$temp$cave = cave,
						$temp$fields = rest;
					allFields = $temp$allFields;
					cave = $temp$cave;
					fields = $temp$fields;
					continue walk;
				}
			} else {
				return $elm$core$Maybe$Nothing;
			}
		}
	});
var $author$project$Day15$solvePartB = F2(
	function (cave, fields) {
		return A2(
			$elm$core$Maybe$withDefault,
			_Utils_Tuple2(0, 0),
			A3($author$project$Day15$walk, fields, cave, fields));
	});
var $author$project$Day15$runPartB = F2(
	function (puzzleInput, cave) {
		var _v0 = A2($elm$parser$Parser$run, $author$project$Day15$puzzleParser, puzzleInput);
		if (!_v0.$) {
			var l = _v0.a;
			return $elm$core$String$fromInt(
				function (_v2) {
					var x = _v2.a;
					var y = _v2.b;
					return (x * 4000000) + y;
				}(
					A2(
						$author$project$Day15$solvePartB,
						cave,
						A2(
							$elm$core$List$map,
							function (_v1) {
								var sensor = _v1.a;
								var beacon = _v1.b;
								return A2($author$project$Day15$toField, sensor, beacon);
							},
							l))));
		} else {
			return 'Error';
		}
	});
var $author$project$Day15$run = function (puzzleInput) {
	var _v0 = A2($elm$core$String$startsWith, 'Sensor at x=2,', puzzleInput) ? _Utils_Tuple2(10, 20) : _Utils_Tuple2(2000000, 4000000);
	var row = _v0.a;
	var cave = _v0.b;
	return _Utils_Tuple2(
		A2($author$project$Day15$runPartA, puzzleInput, row),
		A2($author$project$Day15$runPartB, puzzleInput, cave));
};
var $author$project$Day16$PuzzlePartA = 0;
var $author$project$Day16$PuzzlePartB = 1;
var $author$project$Day16$startingDistances = function (valves) {
	var fn = F3(
		function (valveID1, valve, distances) {
			return A2(
				$elm$core$Dict$union,
				distances,
				$elm$core$Dict$fromList(
					A2(
						$elm$core$List$map,
						function (valveID2) {
							return _Utils_Tuple2(
								_Utils_Tuple2(valveID1, valveID2),
								1);
						},
						valve.bB)));
		});
	return A3($elm$core$Dict$foldl, fn, $elm$core$Dict$empty, valves);
};
var $author$project$Day16$calcDistances = function (valves) {
	var valveIDs = $elm$core$Dict$keys(valves);
	var fnForEndValveIDs = F4(
		function (inBetween, startValveID, endValveID, distances) {
			var half2 = A2(
				$elm$core$Dict$get,
				_Utils_Tuple2(inBetween, endValveID),
				distances);
			var half1 = A2(
				$elm$core$Dict$get,
				_Utils_Tuple2(startValveID, inBetween),
				distances);
			var full = A2(
				$elm$core$Dict$get,
				_Utils_Tuple2(startValveID, endValveID),
				distances);
			if (full.$ === 1) {
				var _v1 = _Utils_Tuple2(half1, half2);
				if ((!_v1.a.$) && (!_v1.b.$)) {
					var d2 = _v1.a.a;
					var d3 = _v1.b.a;
					return A3(
						$elm$core$Dict$insert,
						_Utils_Tuple2(startValveID, endValveID),
						d2 + d3,
						distances);
				} else {
					return distances;
				}
			} else {
				var d1 = full.a;
				var _v2 = _Utils_Tuple2(half1, half2);
				if ((!_v2.a.$) && (!_v2.b.$)) {
					var d2 = _v2.a.a;
					var d3 = _v2.b.a;
					return (_Utils_cmp(d1, d2 + d3) > 0) ? A3(
						$elm$core$Dict$insert,
						_Utils_Tuple2(startValveID, endValveID),
						d2 + d3,
						distances) : distances;
				} else {
					return distances;
				}
			}
		});
	var fnForStartValveIDs = F3(
		function (inBetween, startValveID, distances) {
			return A3(
				$elm$core$List$foldl,
				A2(fnForEndValveIDs, inBetween, startValveID),
				distances,
				A2(
					$elm$core$List$filter,
					A2(
						$elm$core$Basics$composeL,
						$elm$core$Basics$not,
						$elm$core$Basics$eq(startValveID)),
					valveIDs));
		});
	var fnForInBetween = F2(
		function (inBetweenValveID, distances) {
			return A3(
				$elm$core$List$foldl,
				fnForStartValveIDs(inBetweenValveID),
				distances,
				valveIDs);
		});
	return A3(
		$elm$core$List$foldl,
		fnForInBetween,
		$author$project$Day16$startingDistances(valves),
		valveIDs);
};
var $author$project$Day16$valveIDParser = $elm$parser$Parser$getChompedString(
	A2(
		$elm$parser$Parser$ignorer,
		$elm$parser$Parser$succeed(0),
		$elm$parser$Parser$chompWhile($elm$core$Char$isUpper)));
var $author$project$Day16$valveParser = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed(
						F3(
							function (valveID, rate, nextValves) {
								return _Utils_Tuple2(
									valveID,
									{bB: nextValves, aW: rate});
							})),
					$elm$parser$Parser$token('Valve')),
				$elm$parser$Parser$spaces),
			A2(
				$elm$parser$Parser$ignorer,
				A2($elm$parser$Parser$ignorer, $author$project$Day16$valveIDParser, $elm$parser$Parser$spaces),
				$elm$parser$Parser$token('has flow rate='))),
		A2(
			$elm$parser$Parser$ignorer,
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$int,
					$elm$parser$Parser$symbol(';')),
				$elm$parser$Parser$spaces),
			$elm$parser$Parser$oneOf(
				_List_fromArray(
					[
						$elm$parser$Parser$token('tunnels lead to valves'),
						$elm$parser$Parser$token('tunnel leads to valve')
					])))),
	$elm$parser$Parser$sequence(
		{
			al: '',
			c2: $author$project$Day16$valveIDParser,
			dp: ',',
			dq: $elm$parser$Parser$chompWhile(
				$elm$core$Basics$eq(' ')),
			J: '',
			dv: 0
		}));
var $author$project$Day16$puzzleParser = A2(
	$elm$parser$Parser$loop,
	$elm$core$Dict$empty,
	function (all) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						function (_v0) {
							var id = _v0.a;
							var valve = _v0.b;
							return $elm$parser$Parser$Loop(
								A3($elm$core$Dict$insert, id, valve, all));
						}),
					A2(
						$elm$parser$Parser$ignorer,
						$author$project$Day16$valveParser,
						$elm$parser$Parser$symbol('\n'))),
					A2(
					$elm$parser$Parser$map,
					$elm$core$Basics$always(
						$elm$parser$Parser$Done(all)),
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed(0),
						$elm$parser$Parser$end))
				]));
	});
var $author$project$Day16$getRate = F2(
	function (valveID, valves) {
		return A2(
			$elm$core$Maybe$withDefault,
			0,
			A2(
				$elm$core$Maybe$andThen,
				A2(
					$elm$core$Basics$composeL,
					$elm$core$Maybe$Just,
					function ($) {
						return $.aW;
					}),
				A2($elm$core$Dict$get, valveID, valves)));
	});
var $author$project$Day16$globalStartValveID = 'AA';
var $author$project$Day16$globalTime = function (part) {
	if (!part) {
		return 30;
	} else {
		return 26;
	}
};
var $elm$core$Set$isEmpty = function (_v0) {
	var dict = _v0;
	return $elm$core$Dict$isEmpty(dict);
};
var $elm$core$Set$remove = F2(
	function (key, _v0) {
		var dict = _v0;
		return A2($elm$core$Dict$remove, key, dict);
	});
var $author$project$Day16$tryToGoTo = F4(
	function (valves, distances, teamMember, targetValveID) {
		var newTime = (teamMember.bk - A2(
			$elm$core$Maybe$withDefault,
			0,
			A2(
				$elm$core$Dict$get,
				_Utils_Tuple2(teamMember.bm, targetValveID),
				distances))) - 1;
		var newPresure = teamMember.aC + (newTime * A2($author$project$Day16$getRate, targetValveID, valves));
		return (newTime <= 0) ? $elm$core$Maybe$Nothing : $elm$core$Maybe$Just(
			_Utils_Tuple2(newTime, newPresure));
	});
var $author$project$Day16$walk = F4(
	function (valves, distances, team, unVisited) {
		var fn = F2(
			function (u, innerTeam) {
				var fn2 = F2(
					function (_v3, acc) {
						if (acc.aN) {
							return acc;
						} else {
							var _v0 = acc.U.R;
							if (!_v0.b) {
								return acc;
							} else {
								var onTurn = _v0.a;
								var rest = _v0.b;
								var _v1 = A4($author$project$Day16$tryToGoTo, valves, distances, onTurn, u);
								if (_v1.$ === 1) {
									return {
										aN: false,
										U: {
											t: acc.U.t,
											R: rest,
											T: A2($elm$core$List$cons, onTurn, acc.U.T)
										}
									};
								} else {
									var _v2 = _v1.a;
									var newTime = _v2.a;
									var newPresure = _v2.b;
									return {
										aN: true,
										U: {
											t: acc.U.t,
											R: _Utils_ap(
												rest,
												_List_fromArray(
													[
														_Utils_update(
														onTurn,
														{aC: newPresure, bk: newTime, bm: u})
													])),
											T: acc.U.T
										}
									};
								}
							}
						}
					});
				var container = A3(
					$elm$core$List$foldl,
					fn2,
					{aN: false, U: innerTeam},
					A2(
						$elm$core$List$range,
						1,
						$elm$core$List$length(innerTeam.R)));
				if (container.aN) {
					var bp = A4(
						$author$project$Day16$walk,
						valves,
						distances,
						container.U,
						A2($elm$core$Set$remove, u, unVisited)).t;
					return _Utils_update(
						innerTeam,
						{t: bp});
				} else {
					return _Utils_update(
						innerTeam,
						{
							t: A2(
								$elm$core$Basics$max,
								$elm$core$List$sum(
									A2(
										$elm$core$List$map,
										function ($) {
											return $.aC;
										},
										_Utils_ap(innerTeam.R, innerTeam.T))),
								innerTeam.t)
						});
				}
			});
		return $elm$core$Set$isEmpty(unVisited) ? _Utils_update(
			team,
			{
				t: A2(
					$elm$core$Basics$max,
					$elm$core$List$sum(
						A2(
							$elm$core$List$map,
							function ($) {
								return $.aC;
							},
							_Utils_ap(team.R, team.T))),
					team.t)
			}) : A3($elm$core$Set$foldl, fn, team, unVisited);
	});
var $author$project$Day16$searchBest = F3(
	function (distances, puzzlePart, valves) {
		var startingTeam = function () {
			var oneMember = {
				aC: 0,
				bk: $author$project$Day16$globalTime(puzzlePart),
				bm: $author$project$Day16$globalStartValveID
			};
			if (!puzzlePart) {
				return {
					t: 0,
					R: _List_fromArray(
						[oneMember]),
					T: _List_Nil
				};
			} else {
				return {
					t: 0,
					R: _List_fromArray(
						[oneMember, oneMember]),
					T: _List_Nil
				};
			}
		}();
		var rateOfStart = A2($author$project$Day16$getRate, $author$project$Day16$globalStartValveID, valves);
		var allRelevantValves = $elm$core$Set$fromList(
			$elm$core$Dict$keys(
				A2(
					$elm$core$Dict$filter,
					F2(
						function (_v0, valve) {
							return valve.aW > 0;
						}),
					valves)));
		return (!rateOfStart) ? A4($author$project$Day16$walk, valves, distances, startingTeam, allRelevantValves).t : 0;
	});
var $author$project$Day16$runPart = F2(
	function (puzzleInput, puzzlePart) {
		var _v0 = A2($elm$parser$Parser$run, $author$project$Day16$puzzleParser, puzzleInput);
		if (!_v0.$) {
			var valves = _v0.a;
			var distances = $author$project$Day16$calcDistances(valves);
			return $elm$core$String$fromInt(
				A3(
					$author$project$Day16$searchBest,
					distances,
					puzzlePart,
					A2(
						$elm$core$Dict$filter,
						F2(
							function (_v1, valve) {
								return valve.aW > 0;
							}),
						valves)));
		} else {
			return 'Error';
		}
	});
var $author$project$Day16$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A2($author$project$Day16$runPart, puzzleInput, 0),
		A2($author$project$Day16$runPart, puzzleInput, 1));
};
var $author$project$Day17$heightOf = function (cave) {
	return A2(
		$elm$core$Maybe$withDefault,
		0,
		$elm$core$List$maximum(
			A2(
				$elm$core$List$map,
				$elm$core$Tuple$second,
				$elm$core$Set$toList(cave))));
};
var $author$project$Day17$newRock = F2(
	function (rock, row) {
		return $elm$core$Set$fromList(
			function () {
				switch (rock) {
					case 0:
						return _List_fromArray(
							[
								_Utils_Tuple2(3, row),
								_Utils_Tuple2(4, row),
								_Utils_Tuple2(5, row),
								_Utils_Tuple2(6, row)
							]);
					case 1:
						return _List_fromArray(
							[
								_Utils_Tuple2(4, row),
								_Utils_Tuple2(3, row + 1),
								_Utils_Tuple2(4, row + 1),
								_Utils_Tuple2(5, row + 1),
								_Utils_Tuple2(4, row + 2)
							]);
					case 2:
						return _List_fromArray(
							[
								_Utils_Tuple2(3, row),
								_Utils_Tuple2(4, row),
								_Utils_Tuple2(5, row),
								_Utils_Tuple2(5, row + 1),
								_Utils_Tuple2(5, row + 2)
							]);
					case 3:
						return _List_fromArray(
							[
								_Utils_Tuple2(3, row),
								_Utils_Tuple2(3, row + 1),
								_Utils_Tuple2(3, row + 2),
								_Utils_Tuple2(3, row + 3)
							]);
					default:
						return _List_fromArray(
							[
								_Utils_Tuple2(3, row),
								_Utils_Tuple2(4, row),
								_Utils_Tuple2(3, row + 1),
								_Utils_Tuple2(4, row + 1)
							]);
				}
			}());
	});
var $author$project$Day17$collidesWith = F2(
	function (cave, rock) {
		return !$elm$core$Set$isEmpty(
			A2($elm$core$Set$intersect, cave, rock));
	});
var $elm$core$Set$map = F2(
	function (func, set) {
		return $elm$core$Set$fromList(
			A3(
				$elm$core$Set$foldl,
				F2(
					function (x, xs) {
						return A2(
							$elm$core$List$cons,
							func(x),
							xs);
					}),
				_List_Nil,
				set));
	});
var $author$project$Day17$blowTo = F3(
	function (cave, direction, rock) {
		var dirFn = function () {
			switch (direction) {
				case '<':
					return function (i) {
						return i - 1;
					};
				case '>':
					return $elm$core$Basics$add(1);
				default:
					return $elm$core$Basics$identity;
			}
		}();
		var movedRock = A2(
			$elm$core$Set$map,
			function (_v1) {
				var x = _v1.a;
				var y = _v1.b;
				return _Utils_Tuple2(
					dirFn(x),
					y);
			},
			rock);
		return (A2(
			$elm$core$List$any,
			function (_v0) {
				var x = _v0.a;
				return (x < 1) || (x > 7);
			},
			$elm$core$Set$toList(movedRock)) || A2($author$project$Day17$collidesWith, cave, movedRock)) ? rock : movedRock;
	});
var $author$project$Day17$rockFalls = F5(
	function (allJets, rockNum, hotGasIndex, rock, cave) {
		rockFalls:
		while (true) {
			var nextDirection = A2(
				$elm$core$Maybe$withDefault,
				'?',
				A2(
					$elm$core$Array$get,
					A2(
						$elm$core$Basics$modBy,
						$elm$core$Array$length(allJets),
						hotGasIndex),
					allJets));
			var newRockA = A3($author$project$Day17$blowTo, cave, nextDirection, rock);
			var newRockB = A2(
				$elm$core$Set$map,
				function (_v0) {
					var x = _v0.a;
					var y = _v0.b;
					return _Utils_Tuple2(x, y - 1);
				},
				newRockA);
			if (A2($author$project$Day17$collidesWith, cave, newRockB)) {
				return {
					y: A2($elm$core$Set$union, newRockA, cave),
					Q: hotGasIndex + 1,
					E: rockNum + 1
				};
			} else {
				var $temp$allJets = allJets,
					$temp$rockNum = rockNum,
					$temp$hotGasIndex = hotGasIndex + 1,
					$temp$rock = newRockB,
					$temp$cave = cave;
				allJets = $temp$allJets;
				rockNum = $temp$rockNum;
				hotGasIndex = $temp$hotGasIndex;
				rock = $temp$rock;
				cave = $temp$cave;
				continue rockFalls;
			}
		}
	});
var $author$project$Day17$Bar = 3;
var $author$project$Day17$Box = 4;
var $author$project$Day17$Minus = 0;
var $author$project$Day17$Nook = 2;
var $author$project$Day17$Plus = 1;
var $author$project$Day17$rockType = function (i) {
	switch (i) {
		case 0:
			return 0;
		case 1:
			return 1;
		case 2:
			return 2;
		case 3:
			return 3;
		default:
			return 4;
	}
};
var $author$project$Day17$rockInCave = F2(
	function (allJets, acc) {
		var nextRock = $author$project$Day17$rockType(
			A2($elm$core$Basics$modBy, 5, acc.E));
		var rockPos = A2(
			$author$project$Day17$newRock,
			nextRock,
			$author$project$Day17$heightOf(acc.y) + 4);
		return A5($author$project$Day17$rockFalls, allJets, acc.E, acc.Q, rockPos, acc.y);
	});
var $author$project$Day17$rocksDown = F3(
	function (allJets, lastRock, acc) {
		rocksDown:
		while (true) {
			if (_Utils_cmp(acc.E, lastRock) > 0) {
				return acc;
			} else {
				var newAcc = A2($author$project$Day17$rockInCave, allJets, acc);
				var $temp$allJets = allJets,
					$temp$lastRock = lastRock,
					$temp$acc = newAcc;
				allJets = $temp$allJets;
				lastRock = $temp$lastRock;
				acc = $temp$acc;
				continue rocksDown;
			}
		}
	});
var $elm$core$String$trim = _String_trim;
var $author$project$Day17$runPartA = function (puzzleInput) {
	var startCave = $elm$core$Set$fromList(
		_List_fromArray(
			[
				_Utils_Tuple2(1, 0),
				_Utils_Tuple2(2, 0),
				_Utils_Tuple2(3, 0),
				_Utils_Tuple2(4, 0),
				_Utils_Tuple2(5, 0),
				_Utils_Tuple2(6, 0),
				_Utils_Tuple2(7, 0)
			]));
	var lastRockIndex = 2022 - 1;
	var allJets = $elm$core$Array$fromList(
		$elm$core$String$toList(
			$elm$core$String$trim(puzzleInput)));
	return $elm$core$String$fromInt(
		A2(
			$elm$core$Maybe$withDefault,
			0,
			$elm$core$List$maximum(
				A2(
					$elm$core$List$map,
					$elm$core$Tuple$second,
					$elm$core$Set$toList(
						A3(
							$author$project$Day17$rocksDown,
							allJets,
							lastRockIndex,
							{y: startCave, Q: 0, E: 0}).y)))));
};
var $author$project$Day17$walk = F3(
	function (allJets, container, acc) {
		walk:
		while (true) {
			var _v0 = A2(
				$elm$core$Dict$get,
				A2(
					$elm$core$Basics$modBy,
					$elm$core$Array$length(allJets),
					acc.Q),
				container);
			if (_v0.$ === 1) {
				var newContainer = A3(
					$elm$core$Dict$insert,
					A2(
						$elm$core$Basics$modBy,
						$elm$core$Array$length(allJets),
						acc.Q),
					_Utils_Tuple2(
						acc.E,
						$author$project$Day17$heightOf(acc.y)),
					container);
				var newAcc = A2($author$project$Day17$rockInCave, allJets, acc);
				var $temp$allJets = allJets,
					$temp$container = newContainer,
					$temp$acc = newAcc;
				allJets = $temp$allJets;
				container = $temp$container;
				acc = $temp$acc;
				continue walk;
			} else {
				var _v1 = _v0.a;
				var startRockIndex = _v1.a;
				var heightAtStartRockIndex = _v1.b;
				if (_Utils_eq(
					A2($elm$core$Basics$modBy, 5, acc.E),
					A2($elm$core$Basics$modBy, 5, startRockIndex))) {
					return {
						bN: acc,
						aB: $author$project$Day17$heightOf(acc.y) - heightAtStartRockIndex,
						a9: acc.E - startRockIndex,
						bh: startRockIndex
					};
				} else {
					var newContainer = A3(
						$elm$core$Dict$insert,
						A2(
							$elm$core$Basics$modBy,
							$elm$core$Array$length(allJets),
							acc.Q),
						_Utils_Tuple2(
							acc.E,
							$author$project$Day17$heightOf(acc.y)),
						container);
					var newAcc = A2($author$project$Day17$rockInCave, allJets, acc);
					var $temp$allJets = allJets,
						$temp$container = newContainer,
						$temp$acc = newAcc;
					allJets = $temp$allJets;
					container = $temp$container;
					acc = $temp$acc;
					continue walk;
				}
			}
		}
	});
var $author$project$Day17$findPattern = F2(
	function (allJets, acc) {
		return A3($author$project$Day17$walk, allJets, $elm$core$Dict$empty, acc);
	});
var $author$project$Day17$runPartB = function (puzzleInput) {
	var startCave = $elm$core$Set$fromList(
		_List_fromArray(
			[
				_Utils_Tuple2(1, 0),
				_Utils_Tuple2(2, 0),
				_Utils_Tuple2(3, 0),
				_Utils_Tuple2(4, 0),
				_Utils_Tuple2(5, 0),
				_Utils_Tuple2(6, 0),
				_Utils_Tuple2(7, 0)
			]));
	var offsetRocksIndex = 100 - 1;
	var allJets = $elm$core$Array$fromList(
		$elm$core$String$toList(
			$elm$core$String$trim(puzzleInput)));
	var accAfterOffset = A3(
		$author$project$Day17$rocksDown,
		allJets,
		offsetRocksIndex,
		{y: startCave, Q: 0, E: 0});
	var pattern = A2($author$project$Day17$findPattern, allJets, accAfterOffset);
	var a = 1000000000000 - pattern.bh;
	var b = $elm$core$Basics$floor(a / pattern.a9);
	var c = b * pattern.aB;
	var d = a % pattern.a9;
	var e = $author$project$Day17$heightOf(
		A3(
			$author$project$Day17$rocksDown,
			allJets,
			(pattern.bh - 1) + d,
			{y: startCave, Q: 0, E: 0}).y);
	return $elm$core$String$fromInt(c + e);
};
var $author$project$Day17$run = function (puzzleInput) {
	return (puzzleInput === '') ? _Utils_Tuple2('No input', 'No input') : _Utils_Tuple2(
		$author$project$Day17$runPartA(puzzleInput),
		$author$project$Day17$runPartB(puzzleInput));
};
var $author$project$Day18$Cube = F3(
	function (a, b, c) {
		return {$: 0, a: a, b: b, c: c};
	});
var $author$project$Day18$toString = function (_v0) {
	var x = _v0.a;
	var y = _v0.b;
	var z = _v0.c;
	return A2(
		$elm$core$String$join,
		',',
		A2(
			$elm$core$List$map,
			$elm$core$String$fromInt,
			_List_fromArray(
				[x, y, z])));
};
var $author$project$Day18$neighbours = F2(
	function (space, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		var z = _v0.c;
		var z2 = A3($author$project$Day18$Cube, x, y, z + 1);
		var z1 = A3($author$project$Day18$Cube, x, y, z - 1);
		var y2 = A3($author$project$Day18$Cube, x, y + 1, z);
		var y1 = A3($author$project$Day18$Cube, x, y - 1, z);
		var x2 = A3($author$project$Day18$Cube, x + 1, y, z);
		var x1 = A3($author$project$Day18$Cube, x - 1, y, z);
		return $elm$core$List$length(
			A2(
				$elm$core$List$filter,
				function (n) {
					return A2(
						$elm$core$Set$member,
						$author$project$Day18$toString(n),
						space);
				},
				_List_fromArray(
					[x1, x2, y1, y2, z1, z2])));
	});
var $author$project$Day18$foldFn = F2(
	function (cube, _v0) {
		var space = _v0.a;
		var surface = _v0.b;
		var newSurface = (surface + 6) - (2 * A2($author$project$Day18$neighbours, space, cube));
		return _Utils_Tuple2(
			A2(
				$elm$core$Set$insert,
				$author$project$Day18$toString(cube),
				space),
			newSurface);
	});
var $author$project$Day18$getSurface = function (cubes) {
	return A3(
		$elm$core$List$foldl,
		$author$project$Day18$foldFn,
		_Utils_Tuple2($elm$core$Set$empty, 0),
		cubes).b;
};
var $author$project$Day18$cubeParser = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed(
				F3(
					function (x, y, z) {
						return A3($author$project$Day18$Cube, x, y, z);
					})),
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$int,
				$elm$parser$Parser$symbol(','))),
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$int,
			$elm$parser$Parser$symbol(','))),
	$elm$parser$Parser$int);
var $author$project$Day18$puzzleParser = A2(
	$elm$parser$Parser$loop,
	_List_Nil,
	function (all) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						function (cube) {
							return $elm$parser$Parser$Loop(
								A2($elm$core$List$cons, cube, all));
						}),
					A2(
						$elm$parser$Parser$ignorer,
						$author$project$Day18$cubeParser,
						$elm$parser$Parser$symbol('\n'))),
					A2(
					$elm$parser$Parser$map,
					$elm$core$Basics$always(
						$elm$parser$Parser$Done(
							$elm$core$List$reverse(all))),
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed(0),
						$elm$parser$Parser$end))
				]));
	});
var $author$project$Day18$runPartA = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day18$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var cubes = _v0.a;
		return $elm$core$String$fromInt(
			$author$project$Day18$getSurface(cubes));
	} else {
		return 'Error';
	}
};
var $elm$core$Basics$min = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) < 0) ? x : y;
	});
var $author$project$Day18$getMinMax = function (cubes) {
	var fn = F2(
		function (_v0, result) {
			var x = _v0.a;
			var y = _v0.b;
			var z = _v0.c;
			return {
				av: A2($elm$core$Basics$max, x, result.av),
				ah: A2($elm$core$Basics$min, x, result.ah),
				aw: A2($elm$core$Basics$max, y, result.aw),
				ai: A2($elm$core$Basics$min, y, result.ai),
				ax: A2($elm$core$Basics$max, z, result.ax),
				aj: A2($elm$core$Basics$min, z, result.aj)
			};
		});
	var m = A3(
		$elm$core$List$foldl,
		fn,
		{av: 0, ah: 100000, aw: 0, ai: 100000, ax: 0, aj: 100000},
		cubes);
	return {av: m.av + 1, ah: m.ah - 1, aw: m.aw + 1, ai: m.ai - 1, ax: m.ax + 1, aj: m.aj - 1};
};
var $elm$core$Dict$singleton = F2(
	function (key, value) {
		return A5($elm$core$Dict$RBNode_elm_builtin, 1, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
	});
var $elm$core$Set$singleton = function (key) {
	return A2($elm$core$Dict$singleton, key, 0);
};
var $author$project$Day18$adjacent = function (_v0) {
	var x = _v0.a;
	var y = _v0.b;
	var z = _v0.c;
	return _List_fromArray(
		[
			A3($author$project$Day18$Cube, x - 1, y, z),
			A3($author$project$Day18$Cube, x + 1, y, z),
			A3($author$project$Day18$Cube, x, y - 1, z),
			A3($author$project$Day18$Cube, x, y + 1, z),
			A3($author$project$Day18$Cube, x, y, z - 1),
			A3($author$project$Day18$Cube, x, y, z + 1)
		]);
};
var $elm$core$List$member = F2(
	function (x, xs) {
		return A2(
			$elm$core$List$any,
			function (a) {
				return _Utils_eq(a, x);
			},
			xs);
	});
var $author$project$Day18$walk = F3(
	function (cubes, m, acc) {
		walk:
		while (true) {
			var outOf = function (_v3) {
				var x = _v3.a;
				var y = _v3.b;
				var z = _v3.c;
				return (_Utils_cmp(x, m.ah) < 0) || ((_Utils_cmp(y, m.ai) < 0) || ((_Utils_cmp(z, m.aj) < 0) || ((_Utils_cmp(x, m.av) > 0) || ((_Utils_cmp(y, m.aw) > 0) || (_Utils_cmp(z, m.ax) > 0)))));
			};
			var fn2 = F2(
				function (cube, _v2) {
					var n = _v2.a;
					var s = _v2.b;
					return A2(
						$elm$core$Set$member,
						$author$project$Day18$toString(cube),
						cubes) ? _Utils_Tuple2(n, s + 1) : _Utils_Tuple2(
						A2($elm$core$List$cons, cube, n),
						s);
				});
			var fn1 = F2(
				function (cube, _v1) {
					var n = _v1.a;
					var s = _v1.b;
					return A3(
						$elm$core$List$foldl,
						fn2,
						_Utils_Tuple2(n, s),
						A2(
							$elm$core$List$filter,
							function (c) {
								return !A2(
									$elm$core$Set$member,
									$author$project$Day18$toString(c),
									acc.a2);
							},
							A2(
								$elm$core$List$filter,
								function (c) {
									return !A2($elm$core$List$member, c, n);
								},
								A2(
									$elm$core$List$filter,
									A2($elm$core$Basics$composeL, $elm$core$Basics$not, outOf),
									$author$project$Day18$adjacent(cube)))));
				});
			var _v0 = A3(
				$elm$core$List$foldl,
				fn1,
				_Utils_Tuple2(_List_Nil, 0),
				acc.aT);
			var possibleNext = _v0.a;
			var newSurface = _v0.b;
			var newAcc = _Utils_update(
				acc,
				{
					aT: possibleNext,
					aZ: acc.aZ + newSurface,
					a2: A2(
						$elm$core$Set$union,
						$elm$core$Set$fromList(
							A2($elm$core$List$map, $author$project$Day18$toString, possibleNext)),
						acc.a2)
				});
			if (!$elm$core$List$length(newAcc.aT)) {
				return newAcc;
			} else {
				var $temp$cubes = cubes,
					$temp$m = m,
					$temp$acc = newAcc;
				cubes = $temp$cubes;
				m = $temp$m;
				acc = $temp$acc;
				continue walk;
			}
		}
	});
var $author$project$Day18$getOuterSurface = function (cubes) {
	var m = $author$project$Day18$getMinMax(cubes);
	var firstWater = A3($author$project$Day18$Cube, m.ah, m.ai, m.aj);
	var cubeSet = $elm$core$Set$fromList(
		A2($elm$core$List$map, $author$project$Day18$toString, cubes));
	return A2(
		$elm$core$Set$member,
		$author$project$Day18$toString(firstWater),
		cubeSet) ? (-1) : A3(
		$author$project$Day18$walk,
		cubeSet,
		m,
		{
			aT: _List_fromArray(
				[firstWater]),
			aZ: 0,
			a2: $elm$core$Set$singleton(
				$author$project$Day18$toString(firstWater))
		}).aZ;
};
var $author$project$Day18$runPartB = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day18$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var cubes = _v0.a;
		return $elm$core$String$fromInt(
			$author$project$Day18$getOuterSurface(cubes));
	} else {
		return 'Error';
	}
};
var $author$project$Day18$run = function (puzzleInput) {
	return _Utils_Tuple2(
		$author$project$Day18$runPartA(puzzleInput),
		$author$project$Day18$runPartB(puzzleInput));
};
var $elm$core$Dict$map = F2(
	function (func, dict) {
		if (dict.$ === -2) {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		} else {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				key,
				A2(func, key, value),
				A2($elm$core$Dict$map, func, left),
				A2($elm$core$Dict$map, func, right));
		}
	});
var $author$project$Day19$blueprintParser = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$keeper,
							A2(
								$elm$parser$Parser$ignorer,
								A2(
									$elm$parser$Parser$ignorer,
									$elm$parser$Parser$succeed(
										F7(
											function (id, a, b, c, d, e, f) {
												return _Utils_Tuple2(
													id,
													{
														a4: b,
														aO: _Utils_Tuple2(e, f),
														aV: _Utils_Tuple2(c, d),
														ba: a
													});
											})),
									$elm$parser$Parser$token('Blueprint')),
								$elm$parser$Parser$spaces),
							A2(
								$elm$parser$Parser$ignorer,
								A2(
									$elm$parser$Parser$ignorer,
									A2(
										$elm$parser$Parser$ignorer,
										A2(
											$elm$parser$Parser$ignorer,
											$elm$parser$Parser$int,
											$elm$parser$Parser$symbol(':')),
										$elm$parser$Parser$spaces),
									$elm$parser$Parser$token('Each ore robot costs')),
								$elm$parser$Parser$spaces)),
						A2(
							$elm$parser$Parser$ignorer,
							A2(
								$elm$parser$Parser$ignorer,
								A2(
									$elm$parser$Parser$ignorer,
									A2(
										$elm$parser$Parser$ignorer,
										A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
										$elm$parser$Parser$token('ore.')),
									$elm$parser$Parser$spaces),
								$elm$parser$Parser$token('Each clay robot costs')),
							$elm$parser$Parser$spaces)),
					A2(
						$elm$parser$Parser$ignorer,
						A2(
							$elm$parser$Parser$ignorer,
							A2(
								$elm$parser$Parser$ignorer,
								A2(
									$elm$parser$Parser$ignorer,
									A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
									$elm$parser$Parser$token('ore.')),
								$elm$parser$Parser$spaces),
							$elm$parser$Parser$token('Each obsidian robot costs')),
						$elm$parser$Parser$spaces)),
				A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$ignorer,
						A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
						$elm$parser$Parser$token('ore and')),
					$elm$parser$Parser$spaces)),
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					A2(
						$elm$parser$Parser$ignorer,
						A2(
							$elm$parser$Parser$ignorer,
							A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
							$elm$parser$Parser$token('clay.')),
						$elm$parser$Parser$spaces),
					$elm$parser$Parser$token('Each geode robot costs')),
				$elm$parser$Parser$spaces)),
		A2(
			$elm$parser$Parser$ignorer,
			A2(
				$elm$parser$Parser$ignorer,
				A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
				$elm$parser$Parser$token('ore and')),
			$elm$parser$Parser$spaces)),
	A2(
		$elm$parser$Parser$ignorer,
		A2(
			$elm$parser$Parser$ignorer,
			A2($elm$parser$Parser$ignorer, $elm$parser$Parser$int, $elm$parser$Parser$spaces),
			$elm$parser$Parser$token('obsidian.')),
		$elm$parser$Parser$spaces));
var $author$project$Day19$puzzleParser = A2(
	$elm$parser$Parser$loop,
	$elm$core$Dict$empty,
	function (blueprints) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						function (_v0) {
							var id = _v0.a;
							var bp = _v0.b;
							return $elm$parser$Parser$Loop(
								A3($elm$core$Dict$insert, id, bp, blueprints));
						}),
					$author$project$Day19$blueprintParser),
					A2(
					$elm$parser$Parser$map,
					$elm$core$Basics$always(
						$elm$parser$Parser$Done(blueprints)),
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed(0),
						$elm$parser$Parser$end))
				]));
	});
var $author$project$Day19$startingResources = {z: 0, C: 0, D: 0, i: 0};
var $author$project$Day19$startingRobots = {z: 0, C: 0, D: 0, i: 1};
var $author$project$Day19$addOne = F2(
	function (robot, robots) {
		switch (robot) {
			case 0:
				return _Utils_update(
					robots,
					{i: robots.i + 1});
			case 1:
				return _Utils_update(
					robots,
					{z: robots.z + 1});
			case 2:
				return _Utils_update(
					robots,
					{D: robots.D + 1});
			default:
				return _Utils_update(
					robots,
					{C: robots.C + 1});
		}
	});
var $author$project$Day19$Build = function (a) {
	return {$: 1, a: a};
};
var $author$project$Day19$Skip = {$: 0};
var $author$project$Day19$mapToOptionWithSkip = function (robots) {
	return A2(
		$elm$core$List$cons,
		$author$project$Day19$Skip,
		A2($elm$core$List$map, $author$project$Day19$Build, robots));
};
var $author$project$Day19$maxProductionInTimeWith = F2(
	function (geodeRobots, time) {
		return (geodeRobots * time) + (((time * (time - 1)) / 2) | 0);
	});
var $author$project$Day19$Geode = 3;
var $author$project$Day19$onlyGeodeRobotIfPresent = function (options) {
	return A2(
		$elm$core$List$member,
		$author$project$Day19$Build(3),
		options) ? _List_fromArray(
		[
			$author$project$Day19$Build(3)
		]) : options;
};
var $author$project$Day19$produceRobot = F3(
	function (blueprint, robot, resources) {
		switch (robot) {
			case 0:
				return _Utils_update(
					resources,
					{i: resources.i - blueprint.ba});
			case 1:
				return _Utils_update(
					resources,
					{i: resources.i - blueprint.a4});
			case 2:
				return _Utils_update(
					resources,
					{z: resources.z - blueprint.aV.b, i: resources.i - blueprint.aV.a});
			default:
				return _Utils_update(
					resources,
					{D: resources.D - blueprint.aO.b, i: resources.i - blueprint.aO.a});
		}
	});
var $author$project$Day19$produceWith = F2(
	function (robots, resources) {
		return {z: resources.z + robots.z, C: resources.C + robots.C, D: resources.D + robots.D, i: resources.i + robots.i};
	});
var $author$project$Day19$Clay = 1;
var $author$project$Day19$Obsidian = 2;
var $author$project$Day19$Ore = 0;
var $author$project$Day19$whatCanIProduce = F2(
	function (blueprint, resources) {
		return A2(
			$elm$core$List$filter,
			function (r) {
				switch (r) {
					case 0:
						return _Utils_cmp(blueprint.ba, resources.i) < 1;
					case 1:
						return _Utils_cmp(blueprint.a4, resources.i) < 1;
					case 2:
						return function (_v1) {
							var a = _v1.a;
							var b = _v1.b;
							return (_Utils_cmp(a, resources.i) < 1) && (_Utils_cmp(b, resources.z) < 1);
						}(blueprint.aV);
					default:
						return function (_v2) {
							var a = _v2.a;
							var b = _v2.b;
							return (_Utils_cmp(a, resources.i) < 1) && (_Utils_cmp(b, resources.D) < 1);
						}(blueprint.aO);
				}
			},
			_List_fromArray(
				[0, 1, 2, 3]));
	});
var $author$project$Day19$walk = F6(
	function (blueprint, bestCase, time, robots, forbidden, resources) {
		if (time === 1) {
			return A2(
				$elm$core$Basics$max,
				bestCase,
				A2($author$project$Day19$produceWith, robots, resources).C);
		} else {
			if (_Utils_cmp(
				A2($author$project$Day19$maxProductionInTimeWith, robots.C, time) + resources.C,
				bestCase) < 1) {
				return bestCase;
			} else {
				var robotsList = A2($author$project$Day19$whatCanIProduce, blueprint, resources);
				var optionList = $author$project$Day19$onlyGeodeRobotIfPresent(
					$author$project$Day19$mapToOptionWithSkip(
						A2(
							$elm$core$List$filter,
							function (robot) {
								return !A2($elm$core$List$member, robot, forbidden);
							},
							robotsList)));
				var fn = F2(
					function (opt, bc) {
						if (opt.$ === 1) {
							var robot = opt.a;
							return A6(
								$author$project$Day19$walk,
								blueprint,
								bc,
								time - 1,
								A2($author$project$Day19$addOne, robot, robots),
								_List_Nil,
								A2(
									$author$project$Day19$produceWith,
									robots,
									A3($author$project$Day19$produceRobot, blueprint, robot, resources)));
						} else {
							return A6(
								$author$project$Day19$walk,
								blueprint,
								bc,
								time - 1,
								robots,
								robotsList,
								A2($author$project$Day19$produceWith, robots, resources));
						}
					});
				return A3($elm$core$List$foldl, fn, bestCase, optionList);
			}
		}
	});
var $author$project$Day19$runPartA = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day19$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var blueprints = _v0.a;
		return $elm$core$String$fromInt(
			A3(
				$elm$core$Dict$foldl,
				F3(
					function (k, v, totalQualityLevel) {
						return (k * v) + totalQualityLevel;
					}),
				0,
				A2(
					$elm$core$Dict$map,
					F2(
						function (_v1, bp) {
							return A6($author$project$Day19$walk, bp, 0, 24, $author$project$Day19$startingRobots, _List_Nil, $author$project$Day19$startingResources);
						}),
					blueprints)));
	} else {
		return 'Error';
	}
};
var $author$project$Day19$runPartB = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day19$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var blueprints = _v0.a;
		return $elm$core$String$fromInt(
			A3(
				$elm$core$Dict$foldl,
				F3(
					function (_v3, v, totalQualityLevel) {
						return v * totalQualityLevel;
					}),
				1,
				A2(
					$elm$core$Dict$map,
					F2(
						function (_v2, bp) {
							return A6($author$project$Day19$walk, bp, 0, 32, $author$project$Day19$startingRobots, _List_Nil, $author$project$Day19$startingResources);
						}),
					A2(
						$elm$core$Dict$filter,
						F2(
							function (k, _v1) {
								return k <= 3;
							}),
						blueprints))));
	} else {
		return 'Error';
	}
};
var $author$project$Day19$run = function (puzzleInput) {
	return _Utils_Tuple2(
		$author$project$Day19$runPartA(puzzleInput),
		$author$project$Day19$runPartB(puzzleInput));
};
var $elm$core$Elm$JsArray$appendN = _JsArray_appendN;
var $elm$core$Elm$JsArray$slice = _JsArray_slice;
var $elm$core$Array$appendHelpBuilder = F2(
	function (tail, builder) {
		var tailLen = $elm$core$Elm$JsArray$length(tail);
		var notAppended = ($elm$core$Array$branchFactor - $elm$core$Elm$JsArray$length(builder.n)) - tailLen;
		var appended = A3($elm$core$Elm$JsArray$appendN, $elm$core$Array$branchFactor, builder.n, tail);
		return (notAppended < 0) ? {
			o: A2(
				$elm$core$List$cons,
				$elm$core$Array$Leaf(appended),
				builder.o),
			l: builder.l + 1,
			n: A3($elm$core$Elm$JsArray$slice, notAppended, tailLen, tail)
		} : ((!notAppended) ? {
			o: A2(
				$elm$core$List$cons,
				$elm$core$Array$Leaf(appended),
				builder.o),
			l: builder.l + 1,
			n: $elm$core$Elm$JsArray$empty
		} : {o: builder.o, l: builder.l, n: appended});
	});
var $elm$core$Array$appendHelpTree = F2(
	function (toAppend, array) {
		var len = array.a;
		var tree = array.c;
		var tail = array.d;
		var itemsToAppend = $elm$core$Elm$JsArray$length(toAppend);
		var notAppended = ($elm$core$Array$branchFactor - $elm$core$Elm$JsArray$length(tail)) - itemsToAppend;
		var appended = A3($elm$core$Elm$JsArray$appendN, $elm$core$Array$branchFactor, tail, toAppend);
		var newArray = A2($elm$core$Array$unsafeReplaceTail, appended, array);
		if (notAppended < 0) {
			var nextTail = A3($elm$core$Elm$JsArray$slice, notAppended, itemsToAppend, toAppend);
			return A2($elm$core$Array$unsafeReplaceTail, nextTail, newArray);
		} else {
			return newArray;
		}
	});
var $elm$core$Elm$JsArray$foldl = _JsArray_foldl;
var $elm$core$Array$builderFromArray = function (_v0) {
	var len = _v0.a;
	var tree = _v0.c;
	var tail = _v0.d;
	var helper = F2(
		function (node, acc) {
			if (!node.$) {
				var subTree = node.a;
				return A3($elm$core$Elm$JsArray$foldl, helper, acc, subTree);
			} else {
				return A2($elm$core$List$cons, node, acc);
			}
		});
	return {
		o: A3($elm$core$Elm$JsArray$foldl, helper, _List_Nil, tree),
		l: (len / $elm$core$Array$branchFactor) | 0,
		n: tail
	};
};
var $elm$core$Array$append = F2(
	function (a, _v0) {
		var aTail = a.d;
		var bLen = _v0.a;
		var bTree = _v0.c;
		var bTail = _v0.d;
		if (_Utils_cmp(bLen, $elm$core$Array$branchFactor * 4) < 1) {
			var foldHelper = F2(
				function (node, array) {
					if (!node.$) {
						var tree = node.a;
						return A3($elm$core$Elm$JsArray$foldl, foldHelper, array, tree);
					} else {
						var leaf = node.a;
						return A2($elm$core$Array$appendHelpTree, leaf, array);
					}
				});
			return A2(
				$elm$core$Array$appendHelpTree,
				bTail,
				A3($elm$core$Elm$JsArray$foldl, foldHelper, a, bTree));
		} else {
			var foldHelper = F2(
				function (node, builder) {
					if (!node.$) {
						var tree = node.a;
						return A3($elm$core$Elm$JsArray$foldl, foldHelper, builder, tree);
					} else {
						var leaf = node.a;
						return A2($elm$core$Array$appendHelpBuilder, leaf, builder);
					}
				});
			return A2(
				$elm$core$Array$builderToArray,
				true,
				A2(
					$elm$core$Array$appendHelpBuilder,
					bTail,
					A3(
						$elm$core$Elm$JsArray$foldl,
						foldHelper,
						$elm$core$Array$builderFromArray(a),
						bTree)));
		}
	});
var $elm$core$Array$toIndexedList = function (array) {
	var len = array.a;
	var helper = F2(
		function (entry, _v0) {
			var index = _v0.a;
			var list = _v0.b;
			return _Utils_Tuple2(
				index - 1,
				A2(
					$elm$core$List$cons,
					_Utils_Tuple2(index, entry),
					list));
		});
	return A3(
		$elm$core$Array$foldr,
		helper,
		_Utils_Tuple2(len - 1, _List_Nil),
		array).b;
};
var $author$project$Day20$findIndexFor = F2(
	function (value, data) {
		return A2(
			$elm$core$Maybe$withDefault,
			0,
			$elm$core$List$head(
				A2(
					$elm$core$List$map,
					$elm$core$Tuple$first,
					A2(
						$elm$core$List$filter,
						function (_v0) {
							var v = _v0.b;
							return _Utils_eq(v, value);
						},
						$elm$core$Array$toIndexedList(data)))));
	});
var $elm$core$Elm$JsArray$map = _JsArray_map;
var $elm$core$Array$map = F2(
	function (func, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = function (node) {
			if (!node.$) {
				var subTree = node.a;
				return $elm$core$Array$SubTree(
					A2($elm$core$Elm$JsArray$map, helper, subTree));
			} else {
				var values = node.a;
				return $elm$core$Array$Leaf(
					A2($elm$core$Elm$JsArray$map, func, values));
			}
		};
		return A4(
			$elm$core$Array$Array_elm_builtin,
			len,
			startShift,
			A2($elm$core$Elm$JsArray$map, helper, tree),
			A2($elm$core$Elm$JsArray$map, func, tail));
	});
var $elm$core$Array$sliceLeft = F2(
	function (from, array) {
		var len = array.a;
		var tree = array.c;
		var tail = array.d;
		if (!from) {
			return array;
		} else {
			if (_Utils_cmp(
				from,
				$elm$core$Array$tailIndex(len)) > -1) {
				return A4(
					$elm$core$Array$Array_elm_builtin,
					len - from,
					$elm$core$Array$shiftStep,
					$elm$core$Elm$JsArray$empty,
					A3(
						$elm$core$Elm$JsArray$slice,
						from - $elm$core$Array$tailIndex(len),
						$elm$core$Elm$JsArray$length(tail),
						tail));
			} else {
				var skipNodes = (from / $elm$core$Array$branchFactor) | 0;
				var helper = F2(
					function (node, acc) {
						if (!node.$) {
							var subTree = node.a;
							return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
						} else {
							var leaf = node.a;
							return A2($elm$core$List$cons, leaf, acc);
						}
					});
				var leafNodes = A3(
					$elm$core$Elm$JsArray$foldr,
					helper,
					_List_fromArray(
						[tail]),
					tree);
				var nodesToInsert = A2($elm$core$List$drop, skipNodes, leafNodes);
				if (!nodesToInsert.b) {
					return $elm$core$Array$empty;
				} else {
					var head = nodesToInsert.a;
					var rest = nodesToInsert.b;
					var firstSlice = from - (skipNodes * $elm$core$Array$branchFactor);
					var initialBuilder = {
						o: _List_Nil,
						l: 0,
						n: A3(
							$elm$core$Elm$JsArray$slice,
							firstSlice,
							$elm$core$Elm$JsArray$length(head),
							head)
					};
					return A2(
						$elm$core$Array$builderToArray,
						true,
						A3($elm$core$List$foldl, $elm$core$Array$appendHelpBuilder, initialBuilder, rest));
				}
			}
		}
	});
var $elm$core$Array$fetchNewTail = F4(
	function (shift, end, treeEnd, tree) {
		fetchNewTail:
		while (true) {
			var pos = $elm$core$Array$bitMask & (treeEnd >>> shift);
			var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (!_v0.$) {
				var sub = _v0.a;
				var $temp$shift = shift - $elm$core$Array$shiftStep,
					$temp$end = end,
					$temp$treeEnd = treeEnd,
					$temp$tree = sub;
				shift = $temp$shift;
				end = $temp$end;
				treeEnd = $temp$treeEnd;
				tree = $temp$tree;
				continue fetchNewTail;
			} else {
				var values = _v0.a;
				return A3($elm$core$Elm$JsArray$slice, 0, $elm$core$Array$bitMask & end, values);
			}
		}
	});
var $elm$core$Array$hoistTree = F3(
	function (oldShift, newShift, tree) {
		hoistTree:
		while (true) {
			if ((_Utils_cmp(oldShift, newShift) < 1) || (!$elm$core$Elm$JsArray$length(tree))) {
				return tree;
			} else {
				var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, 0, tree);
				if (!_v0.$) {
					var sub = _v0.a;
					var $temp$oldShift = oldShift - $elm$core$Array$shiftStep,
						$temp$newShift = newShift,
						$temp$tree = sub;
					oldShift = $temp$oldShift;
					newShift = $temp$newShift;
					tree = $temp$tree;
					continue hoistTree;
				} else {
					return tree;
				}
			}
		}
	});
var $elm$core$Array$sliceTree = F3(
	function (shift, endIdx, tree) {
		var lastPos = $elm$core$Array$bitMask & (endIdx >>> shift);
		var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, lastPos, tree);
		if (!_v0.$) {
			var sub = _v0.a;
			var newSub = A3($elm$core$Array$sliceTree, shift - $elm$core$Array$shiftStep, endIdx, sub);
			return (!$elm$core$Elm$JsArray$length(newSub)) ? A3($elm$core$Elm$JsArray$slice, 0, lastPos, tree) : A3(
				$elm$core$Elm$JsArray$unsafeSet,
				lastPos,
				$elm$core$Array$SubTree(newSub),
				A3($elm$core$Elm$JsArray$slice, 0, lastPos + 1, tree));
		} else {
			return A3($elm$core$Elm$JsArray$slice, 0, lastPos, tree);
		}
	});
var $elm$core$Array$sliceRight = F2(
	function (end, array) {
		var len = array.a;
		var startShift = array.b;
		var tree = array.c;
		var tail = array.d;
		if (_Utils_eq(end, len)) {
			return array;
		} else {
			if (_Utils_cmp(
				end,
				$elm$core$Array$tailIndex(len)) > -1) {
				return A4(
					$elm$core$Array$Array_elm_builtin,
					end,
					startShift,
					tree,
					A3($elm$core$Elm$JsArray$slice, 0, $elm$core$Array$bitMask & end, tail));
			} else {
				var endIdx = $elm$core$Array$tailIndex(end);
				var depth = $elm$core$Basics$floor(
					A2(
						$elm$core$Basics$logBase,
						$elm$core$Array$branchFactor,
						A2($elm$core$Basics$max, 1, endIdx - 1)));
				var newShift = A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep);
				return A4(
					$elm$core$Array$Array_elm_builtin,
					end,
					newShift,
					A3(
						$elm$core$Array$hoistTree,
						startShift,
						newShift,
						A3($elm$core$Array$sliceTree, startShift, endIdx, tree)),
					A4($elm$core$Array$fetchNewTail, startShift, end, endIdx, tree));
			}
		}
	});
var $elm$core$Array$translateIndex = F2(
	function (index, _v0) {
		var len = _v0.a;
		var posIndex = (index < 0) ? (len + index) : index;
		return (posIndex < 0) ? 0 : ((_Utils_cmp(posIndex, len) > 0) ? len : posIndex);
	});
var $elm$core$Array$slice = F3(
	function (from, to, array) {
		var correctTo = A2($elm$core$Array$translateIndex, to, array);
		var correctFrom = A2($elm$core$Array$translateIndex, from, array);
		return (_Utils_cmp(correctFrom, correctTo) > 0) ? $elm$core$Array$empty : A2(
			$elm$core$Array$sliceLeft,
			correctFrom,
			A2($elm$core$Array$sliceRight, correctTo, array));
	});
var $author$project$Day20$decryptWith = F3(
	function (rounds, indices, encryptedData) {
		var len = $elm$core$List$length(encryptedData);
		var indexEncryptedData = A2($elm$core$List$indexedMap, $elm$core$Tuple$pair, encryptedData);
		var fn = F2(
			function (value, data) {
				var oldIndex = A2($author$project$Day20$findIndexFor, value, data);
				var newIndex = A2($elm$core$Basics$modBy, len - 1, oldIndex + value.b);
				return (_Utils_cmp(oldIndex, newIndex) < 0) ? A2(
					$elm$core$Array$append,
					A2(
						$elm$core$Array$push,
						value,
						A2(
							$elm$core$Array$append,
							A3($elm$core$Array$slice, 0, oldIndex, data),
							A3($elm$core$Array$slice, oldIndex + 1, newIndex + 1, data))),
					A3($elm$core$Array$slice, newIndex + 1, len, data)) : A2(
					$elm$core$Array$append,
					A2(
						$elm$core$Array$append,
						A2(
							$elm$core$Array$push,
							value,
							A3($elm$core$Array$slice, 0, newIndex, data)),
						A3($elm$core$Array$slice, newIndex, oldIndex, data)),
					A3($elm$core$Array$slice, oldIndex + 1, len, data));
			});
		var mixedData = A3(
			$elm$core$List$foldl,
			F2(
				function (s, innerMixedData) {
					return A3(
						$elm$core$List$foldl,
						fn,
						innerMixedData,
						A2($elm$core$Basics$always, indexEncryptedData, s));
				}),
			$elm$core$Array$fromList(indexEncryptedData),
			A2($elm$core$List$repeat, rounds, 0));
		var startIndex = A2(
			$author$project$Day20$findIndexFor,
			0,
			A2($elm$core$Array$map, $elm$core$Tuple$second, mixedData));
		return $elm$core$List$sum(
			A2(
				$elm$core$List$map,
				$elm$core$Tuple$second,
				A2(
					$elm$core$List$filterMap,
					function (i) {
						return A2($elm$core$Array$get, i, mixedData);
					},
					A2(
						$elm$core$List$map,
						function (i) {
							return A2($elm$core$Basics$modBy, len, startIndex + i);
						},
						indices))));
	});
var $elm$core$List$isEmpty = function (xs) {
	if (!xs.b) {
		return true;
	} else {
		return false;
	}
};
var $author$project$Day20$myIntParser = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed($elm$core$Basics$negate),
				$elm$parser$Parser$symbol('-')),
			$elm$parser$Parser$int),
			$elm$parser$Parser$int
		]));
var $author$project$Day20$puzzleParser = A2(
	$elm$parser$Parser$loop,
	_List_Nil,
	function (l) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						function (i) {
							return $elm$parser$Parser$Loop(
								A2($elm$core$List$cons, i, l));
						}),
					A2($elm$parser$Parser$ignorer, $author$project$Day20$myIntParser, $elm$parser$Parser$spaces)),
					A2(
					$elm$parser$Parser$map,
					function (_v0) {
						return $elm$parser$Parser$Done(
							$elm$core$List$reverse(l));
					},
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed(0),
						$elm$parser$Parser$end))
				]));
	});
var $author$project$Day20$runPartA = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day20$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var encryptedData = _v0.a;
		return $elm$core$List$isEmpty(encryptedData) ? 'No input' : $elm$core$String$fromInt(
			A3(
				$author$project$Day20$decryptWith,
				1,
				_List_fromArray(
					[1000, 2000, 3000]),
				encryptedData));
	} else {
		return 'Error';
	}
};
var $author$project$Day20$runPartB = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day20$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var encryptedData = _v0.a;
		return $elm$core$List$isEmpty(encryptedData) ? 'No input' : $elm$core$String$fromInt(
			A3(
				$author$project$Day20$decryptWith,
				10,
				_List_fromArray(
					[1000, 2000, 3000]),
				A2(
					$elm$core$List$map,
					$elm$core$Basics$mul(811589153),
					encryptedData)));
	} else {
		return 'Error';
	}
};
var $author$project$Day20$run = function (puzzleInput) {
	return _Utils_Tuple2(
		$author$project$Day20$runPartA(puzzleInput),
		$author$project$Day20$runPartB(puzzleInput));
};
var $author$project$Day21$AfterRoot = 1;
var $elm$core$String$fromFloat = _String_fromNumber;
var $author$project$Day21$Addition = F3(
	function (a, b, c) {
		return {$: 0, a: a, b: b, c: c};
	});
var $author$project$Day21$Division = F3(
	function (a, b, c) {
		return {$: 3, a: a, b: b, c: c};
	});
var $author$project$Day21$Equation = function (a) {
	return {$: 1, a: a};
};
var $author$project$Day21$Multiplication = F3(
	function (a, b, c) {
		return {$: 2, a: a, b: b, c: c};
	});
var $author$project$Day21$Subtraction = F3(
	function (a, b, c) {
		return {$: 1, a: a, b: b, c: c};
	});
var $author$project$Day21$Value = function (a) {
	return {$: 0, a: a};
};
var $elm$parser$Parser$Advanced$backtrackable = function (_v0) {
	var parse = _v0;
	return function (s0) {
		var _v1 = parse(s0);
		if (_v1.$ === 1) {
			var x = _v1.b;
			return A2($elm$parser$Parser$Advanced$Bad, false, x);
		} else {
			var a = _v1.b;
			var s1 = _v1.c;
			return A3($elm$parser$Parser$Advanced$Good, false, a, s1);
		}
	};
};
var $elm$parser$Parser$backtrackable = $elm$parser$Parser$Advanced$backtrackable;
var $elm$parser$Parser$ExpectingFloat = {$: 5};
var $elm$parser$Parser$Advanced$float = F2(
	function (expecting, invalid) {
		return $elm$parser$Parser$Advanced$number(
			{
				bR: $elm$core$Result$Err(invalid),
				bY: expecting,
				bZ: $elm$core$Result$Ok($elm$core$Basics$identity),
				b2: $elm$core$Result$Err(invalid),
				b6: $elm$core$Result$Ok($elm$core$Basics$toFloat),
				c1: invalid,
				cf: $elm$core$Result$Err(invalid)
			});
	});
var $elm$parser$Parser$float = A2($elm$parser$Parser$Advanced$float, $elm$parser$Parser$ExpectingFloat, $elm$parser$Parser$ExpectingFloat);
var $author$project$Day21$operandParser = $elm$parser$Parser$getChompedString(
	A2(
		$elm$parser$Parser$ignorer,
		A2(
			$elm$parser$Parser$ignorer,
			A2(
				$elm$parser$Parser$ignorer,
				A2(
					$elm$parser$Parser$ignorer,
					$elm$parser$Parser$succeed(0),
					$elm$parser$Parser$chompIf(
						function (c) {
							return $elm$core$Char$isLower(c);
						})),
				$elm$parser$Parser$chompIf(
					function (c) {
						return $elm$core$Char$isLower(c);
					})),
			$elm$parser$Parser$chompIf(
				function (c) {
					return $elm$core$Char$isLower(c);
				})),
		$elm$parser$Parser$chompIf(
			function (c) {
				return $elm$core$Char$isLower(c);
			})));
var $author$project$Day21$By = 3;
var $author$project$Day21$Minus = 1;
var $author$project$Day21$Plus = 0;
var $author$project$Day21$Times = 2;
var $author$project$Day21$operatorParser = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed(0),
			$elm$parser$Parser$symbol('+')),
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed(1),
			$elm$parser$Parser$symbol('-')),
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed(2),
			$elm$parser$Parser$symbol('*')),
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed(3),
			$elm$parser$Parser$symbol('/'))
		]));
var $author$project$Day21$expressionParser = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			$elm$parser$Parser$backtrackable(
			A2(
				$elm$parser$Parser$map,
				function (_v1) {
					var op = _v1.a;
					var eq = _v1.b;
					return _Utils_Tuple2(
						op,
						$author$project$Day21$Equation(eq));
				},
				A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$keeper,
							A2(
								$elm$parser$Parser$keeper,
								$elm$parser$Parser$succeed(
									F4(
										function (op, a, operator, b) {
											switch (operator) {
												case 0:
													return _Utils_Tuple2(
														op,
														A3($author$project$Day21$Addition, a, b, ''));
												case 1:
													return _Utils_Tuple2(
														op,
														A3($author$project$Day21$Subtraction, a, b, ''));
												case 2:
													return _Utils_Tuple2(
														op,
														A3($author$project$Day21$Multiplication, a, b, ''));
												default:
													return _Utils_Tuple2(
														op,
														A3($author$project$Day21$Division, a, b, ''));
											}
										})),
								A2(
									$elm$parser$Parser$ignorer,
									A2(
										$elm$parser$Parser$ignorer,
										$author$project$Day21$operandParser,
										$elm$parser$Parser$symbol(':')),
									$elm$parser$Parser$spaces)),
							A2($elm$parser$Parser$ignorer, $author$project$Day21$operandParser, $elm$parser$Parser$spaces)),
						A2($elm$parser$Parser$ignorer, $author$project$Day21$operatorParser, $elm$parser$Parser$spaces)),
					A2($elm$parser$Parser$ignorer, $author$project$Day21$operandParser, $elm$parser$Parser$spaces)))),
			$elm$parser$Parser$backtrackable(
			A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						F2(
							function (op, value) {
								return _Utils_Tuple2(
									op,
									$author$project$Day21$Value(value));
							})),
					A2(
						$elm$parser$Parser$ignorer,
						A2(
							$elm$parser$Parser$ignorer,
							$author$project$Day21$operandParser,
							$elm$parser$Parser$symbol(':')),
						$elm$parser$Parser$spaces)),
				A2($elm$parser$Parser$ignorer, $elm$parser$Parser$float, $elm$parser$Parser$spaces)))
		]));
var $author$project$Day21$puzzleParser = A2(
	$elm$parser$Parser$loop,
	$elm$core$Dict$empty,
	function (exps) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					function (_v0) {
						var op = _v0.a;
						var exp = _v0.b;
						return $elm$parser$Parser$Loop(
							A3($elm$core$Dict$insert, op, exp, exps));
					},
					$author$project$Day21$expressionParser),
					A2(
					$elm$parser$Parser$map,
					function (_v1) {
						return $elm$parser$Parser$Done(exps);
					},
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$succeed(0),
						$elm$parser$Parser$end))
				]));
	});
var $author$project$Day21$BeforeRoot = 0;
var $author$project$Day21$exec = F3(
	function (fn, mba, mbb) {
		return A2(
			$elm$core$Maybe$andThen,
			function (a) {
				return A2(
					$elm$core$Maybe$andThen,
					function (b) {
						return $elm$core$Maybe$Just(
							A2(fn, a, b));
					},
					mbb);
			},
			mba);
	});
var $elm$core$Basics$neq = _Utils_notEqual;
var $author$project$Day21$resolve = F3(
	function (all, phase, operand) {
		var mexp = function () {
			if (!phase) {
				return A2($elm$core$Dict$get, operand, all.bc);
			} else {
				return A2($elm$core$Dict$get, operand, all.a5);
			}
		}();
		return A2(
			$elm$core$Maybe$andThen,
			function (exp) {
				if (!exp.$) {
					var v = exp.a;
					return $elm$core$Maybe$Just(v);
				} else {
					var eq = exp.a;
					var newPhase = F2(
						function (op, l) {
							return ((phase === 1) || (!_Utils_eq(op, l))) ? 1 : 0;
						});
					switch (eq.$) {
						case 0:
							var a = eq.a;
							var b = eq.b;
							var l = eq.c;
							return A3(
								$author$project$Day21$exec,
								$elm$core$Basics$add,
								A3(
									$author$project$Day21$resolve,
									all,
									A2(newPhase, a, l),
									a),
								A3(
									$author$project$Day21$resolve,
									all,
									A2(newPhase, b, l),
									b));
						case 1:
							var a = eq.a;
							var b = eq.b;
							var l = eq.c;
							return A3(
								$author$project$Day21$exec,
								$elm$core$Basics$sub,
								A3(
									$author$project$Day21$resolve,
									all,
									A2(newPhase, a, l),
									a),
								A3(
									$author$project$Day21$resolve,
									all,
									A2(newPhase, b, l),
									b));
						case 2:
							var a = eq.a;
							var b = eq.b;
							var l = eq.c;
							return A3(
								$author$project$Day21$exec,
								$elm$core$Basics$mul,
								A3(
									$author$project$Day21$resolve,
									all,
									A2(newPhase, a, l),
									a),
								A3(
									$author$project$Day21$resolve,
									all,
									A2(newPhase, b, l),
									b));
						case 3:
							var a = eq.a;
							var b = eq.b;
							var l = eq.c;
							return A3(
								$author$project$Day21$exec,
								$elm$core$Basics$fdiv,
								A3(
									$author$project$Day21$resolve,
									all,
									A2(newPhase, a, l),
									a),
								A3(
									$author$project$Day21$resolve,
									all,
									A2(newPhase, b, l),
									b));
						default:
							var a = eq.a;
							return A3($author$project$Day21$resolve, all, 1, a);
					}
				}
			},
			mexp);
	});
var $author$project$Day21$runPartA = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day21$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var exps = _v0.a;
		var _v1 = A3(
			$author$project$Day21$resolve,
			{a5: exps, bc: $elm$core$Dict$empty},
			1,
			'root');
		if (!_v1.$) {
			var result = _v1.a;
			return $elm$core$String$fromFloat(result);
		} else {
			return 'No result A';
		}
	} else {
		return 'Error';
	}
};
var $author$project$Day21$Equal = function (a) {
	return {$: 4, a: a};
};
var $author$project$Day21$dictInsertIfNotExists = F3(
	function (k, v, d) {
		return A2($elm$core$Dict$member, k, d) ? d : A3($elm$core$Dict$insert, k, v, d);
	});
var $author$project$Day21$transform = function (exps) {
	var fn = F3(
		function (op, exp, newExps) {
			if (!exp.$) {
				var v = exp.a;
				return A3(
					$elm$core$Dict$insert,
					op,
					$author$project$Day21$Value(v),
					newExps);
			} else {
				var eq = exp.a;
				switch (eq.$) {
					case 0:
						var a = eq.a;
						var b = eq.b;
						return (op === 'root') ? A3(
							$elm$core$Dict$insert,
							b,
							$author$project$Day21$Equation(
								$author$project$Day21$Equal(a)),
							A3(
								$elm$core$Dict$insert,
								a,
								$author$project$Day21$Equation(
									$author$project$Day21$Equal(b)),
								newExps)) : A3(
							$author$project$Day21$dictInsertIfNotExists,
							b,
							$author$project$Day21$Equation(
								A3($author$project$Day21$Subtraction, op, a, op)),
							A3(
								$author$project$Day21$dictInsertIfNotExists,
								a,
								$author$project$Day21$Equation(
									A3($author$project$Day21$Subtraction, op, b, op)),
								newExps));
					case 1:
						var a = eq.a;
						var b = eq.b;
						return A3(
							$author$project$Day21$dictInsertIfNotExists,
							b,
							$author$project$Day21$Equation(
								A3($author$project$Day21$Subtraction, a, op, op)),
							A3(
								$author$project$Day21$dictInsertIfNotExists,
								a,
								$author$project$Day21$Equation(
									A3($author$project$Day21$Addition, op, b, op)),
								newExps));
					case 2:
						var a = eq.a;
						var b = eq.b;
						return A3(
							$author$project$Day21$dictInsertIfNotExists,
							b,
							$author$project$Day21$Equation(
								A3($author$project$Day21$Division, op, a, op)),
							A3(
								$author$project$Day21$dictInsertIfNotExists,
								a,
								$author$project$Day21$Equation(
									A3($author$project$Day21$Division, op, b, op)),
								newExps));
					case 3:
						var a = eq.a;
						var b = eq.b;
						return A3(
							$author$project$Day21$dictInsertIfNotExists,
							b,
							$author$project$Day21$Equation(
								A3($author$project$Day21$Division, a, op, op)),
							A3(
								$author$project$Day21$dictInsertIfNotExists,
								a,
								$author$project$Day21$Equation(
									A3($author$project$Day21$Multiplication, op, b, op)),
								newExps));
					default:
						return newExps;
				}
			}
		});
	return A3($elm$core$Dict$foldl, fn, $elm$core$Dict$empty, exps);
};
var $author$project$Day21$runPartB = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day21$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var exps = _v0.a;
		var filteredExps = A2($elm$core$Dict$remove, 'humn', exps);
		var _v1 = A3(
			$author$project$Day21$resolve,
			{
				a5: filteredExps,
				bc: $author$project$Day21$transform(filteredExps)
			},
			0,
			'humn');
		if (!_v1.$) {
			var result = _v1.a;
			return $elm$core$String$fromFloat(result);
		} else {
			return 'No result B';
		}
	} else {
		return 'Error';
	}
};
var $author$project$Day21$run = function (puzzleInput) {
	return _Utils_Tuple2(
		$author$project$Day21$runPartA(puzzleInput),
		$author$project$Day21$runPartB(puzzleInput));
};
var $author$project$Day22$PuzzlePartA = 0;
var $author$project$Day22$PuzzlePartB = 1;
var $author$project$Day22$East = 3;
var $author$project$Day22$directionToFacing = function (dir) {
	switch (dir) {
		case 0:
			return 3;
		case 1:
			return 1;
		case 2:
			return 2;
		default:
			return 0;
	}
};
var $author$project$Day22$TurnLeft = {$: 1};
var $author$project$Day22$TurnRight = {$: 0};
var $author$project$Day22$Walk = function (a) {
	return {$: 2, a: a};
};
var $author$project$Day22$commandParser = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed($author$project$Day22$TurnRight),
			$elm$parser$Parser$symbol('R')),
			A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$succeed($author$project$Day22$TurnLeft),
			$elm$parser$Parser$symbol('L')),
			A2(
			$elm$parser$Parser$keeper,
			$elm$parser$Parser$succeed(
				function (i) {
					return $author$project$Day22$Walk(i);
				}),
			$elm$parser$Parser$int)
		]));
var $author$project$Day22$commandListParser = A2(
	$elm$parser$Parser$loop,
	_List_Nil,
	function (list) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					function (c) {
						return $elm$parser$Parser$Loop(
							A2($elm$core$List$cons, c, list));
					},
					$author$project$Day22$commandParser),
					A2(
					$elm$parser$Parser$map,
					function (_v0) {
						return $elm$parser$Parser$Done(
							$elm$core$List$reverse(list));
					},
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								$elm$parser$Parser$symbol('\n'),
								$elm$parser$Parser$end
							])))
				]));
	});
var $author$project$Day22$Open = 0;
var $author$project$Day22$Wall = 1;
var $author$project$Day22$locationsToMap = function (locations) {
	var _v0 = A3(
		$elm$core$List$foldl,
		F2(
			function (_v1, _v2) {
				var x = _v1.a;
				var y = _v1.b;
				var w = _v2.a;
				var h = _v2.b;
				return _Utils_Tuple2(
					A2($elm$core$Basics$max, x, w),
					A2($elm$core$Basics$max, y, h));
			}),
		_Utils_Tuple2(0, 0),
		$elm$core$Dict$keys(locations));
	var width = _v0.a;
	var height = _v0.b;
	return {aB: height + 2, aS: locations, bo: width + 2};
};
var $author$project$Day22$mapParser = A2(
	$elm$parser$Parser$loop,
	$elm$core$Dict$empty,
	function (dict) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$map,
					function (_v0) {
						return $elm$parser$Parser$Done(
							$author$project$Day22$locationsToMap(dict));
					},
					$elm$parser$Parser$symbol('\n\n')),
					A2(
					$elm$parser$Parser$map,
					function (_v1) {
						return $elm$parser$Parser$Loop(dict);
					},
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								$elm$parser$Parser$symbol(' '),
								$elm$parser$Parser$symbol('\n')
							]))),
					A2(
					$elm$parser$Parser$keeper,
					A2(
						$elm$parser$Parser$keeper,
						$elm$parser$Parser$succeed(
							F2(
								function (_v2, location) {
									var line = _v2.a;
									var column = _v2.b;
									return $elm$parser$Parser$Loop(
										A3(
											$elm$core$Dict$insert,
											_Utils_Tuple2(column - 1, line - 1),
											location,
											dict));
								})),
						$elm$parser$Parser$getPosition),
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed(1),
								$elm$parser$Parser$symbol('#')),
								A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed(0),
								$elm$parser$Parser$symbol('.'))
							])))
				]));
	});
var $author$project$Day22$puzzleParser = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$keeper,
		$elm$parser$Parser$succeed($elm$core$Tuple$pair),
		$author$project$Day22$mapParser),
	$author$project$Day22$commandListParser);
var $author$project$Day22$North = 0;
var $author$project$Day22$South = 1;
var $author$project$Day22$West = 2;
var $author$project$Day22$turnLeft = function (dir) {
	switch (dir) {
		case 0:
			return 2;
		case 1:
			return 3;
		case 2:
			return 1;
		default:
			return 0;
	}
};
var $author$project$Day22$turnRight = function (dir) {
	switch (dir) {
		case 0:
			return 3;
		case 1:
			return 2;
		case 2:
			return 0;
		default:
			return 1;
	}
};
var $author$project$Day22$PuzzleInput = 1;
var $author$project$Day22$Bottom = 2;
var $author$project$Day22$Front = 0;
var $author$project$Day22$Left = 3;
var $author$project$Day22$Rear = 5;
var $author$project$Day22$Right = 4;
var $author$project$Day22$Top = 1;
var $author$project$Day22$getCube = F2(
	function (inputType, _v0) {
		var _v1 = _v0.a;
		var x = _v1.a;
		var y = _v1.b;
		if (inputType === 1) {
			return (y < 50) ? ((x < 100) ? 1 : 4) : ((y < 100) ? 0 : ((y < 150) ? ((x < 50) ? 3 : 2) : 5));
		} else {
			return (y < 4) ? 1 : ((y < 8) ? ((x < 4) ? 5 : ((x < 8) ? 3 : 0)) : ((x < 12) ? 2 : 4));
		}
	});
var $author$project$Day22$nextLocationHelperA = F2(
	function (map, _v0) {
		var _v1 = _v0.a;
		var x = _v1.a;
		var y = _v1.b;
		var currentDirection = _v0.b;
		return _Utils_Tuple2(
			function () {
				switch (currentDirection) {
					case 0:
						return _Utils_Tuple2(
							x,
							A2($elm$core$Basics$modBy, map.aB, y - 1));
					case 1:
						return _Utils_Tuple2(
							x,
							A2($elm$core$Basics$modBy, map.aB, y + 1));
					case 2:
						return _Utils_Tuple2(
							A2($elm$core$Basics$modBy, map.bo, x - 1),
							y);
					default:
						return _Utils_Tuple2(
							A2($elm$core$Basics$modBy, map.bo, x + 1),
							y);
				}
			}(),
			currentDirection);
	});
var $author$project$Day22$switchCube = F3(
	function (inputType, whereAmI, _v0) {
		var _v1 = _v0.a;
		var x = _v1.a;
		var y = _v1.b;
		var currentDirection = _v0.b;
		if (inputType === 1) {
			var _v3 = _Utils_Tuple2(whereAmI, currentDirection);
			switch (_v3.b) {
				case 0:
					switch (_v3.a) {
						case 0:
							var _v4 = _v3.a;
							var _v5 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								0);
						case 1:
							var _v12 = _v3.a;
							var _v13 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(0, x + 100),
								3);
						case 2:
							var _v20 = _v3.a;
							var _v21 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								0);
						case 3:
							var _v28 = _v3.a;
							var _v29 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(50, x + 50),
								3);
						case 4:
							var _v36 = _v3.a;
							var _v37 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x - 100, 199),
								0);
						default:
							var _v44 = _v3.a;
							var _v45 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								0);
					}
				case 1:
					switch (_v3.a) {
						case 0:
							var _v6 = _v3.a;
							var _v7 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								1);
						case 1:
							var _v14 = _v3.a;
							var _v15 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								1);
						case 2:
							var _v22 = _v3.a;
							var _v23 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(49, x + 100),
								2);
						case 3:
							var _v30 = _v3.a;
							var _v31 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								1);
						case 4:
							var _v38 = _v3.a;
							var _v39 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(99, x - 50),
								2);
						default:
							var _v46 = _v3.a;
							var _v47 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x + 100, 0),
								1);
					}
				case 2:
					switch (_v3.a) {
						case 0:
							var _v8 = _v3.a;
							var _v9 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(y - 50, 100),
								1);
						case 1:
							var _v16 = _v3.a;
							var _v17 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(0, 149 - y),
								3);
						case 2:
							var _v24 = _v3.a;
							var _v25 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								2);
						case 3:
							var _v32 = _v3.a;
							var _v33 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(50, 149 - y),
								3);
						case 4:
							var _v40 = _v3.a;
							var _v41 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								2);
						default:
							var _v48 = _v3.a;
							var _v49 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(y - 100, 0),
								1);
					}
				default:
					switch (_v3.a) {
						case 0:
							var _v10 = _v3.a;
							var _v11 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(y + 50, 49),
								0);
						case 1:
							var _v18 = _v3.a;
							var _v19 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								3);
						case 2:
							var _v26 = _v3.a;
							var _v27 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(149, 149 - y),
								2);
						case 3:
							var _v34 = _v3.a;
							var _v35 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								3);
						case 4:
							var _v42 = _v3.a;
							var _v43 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(99, 149 - y),
								2);
						default:
							var _v50 = _v3.a;
							var _v51 = _v3.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(y - 100, 149),
								0);
					}
			}
		} else {
			var _v52 = _Utils_Tuple2(whereAmI, currentDirection);
			switch (_v52.b) {
				case 0:
					switch (_v52.a) {
						case 0:
							var _v53 = _v52.a;
							var _v54 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								0);
						case 1:
							var _v61 = _v52.a;
							var _v62 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(11 - x, 4),
								1);
						case 2:
							var _v69 = _v52.a;
							var _v70 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								0);
						case 3:
							var _v77 = _v52.a;
							var _v78 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(8, x - 4),
								3);
						case 4:
							var _v85 = _v52.a;
							var _v86 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(11, 19 - x),
								2);
						default:
							var _v93 = _v52.a;
							var _v94 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(11 - x, 0),
								1);
					}
				case 1:
					switch (_v52.a) {
						case 0:
							var _v55 = _v52.a;
							var _v56 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								1);
						case 1:
							var _v63 = _v52.a;
							var _v64 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								1);
						case 2:
							var _v71 = _v52.a;
							var _v72 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(11 - x, 7),
								0);
						case 3:
							var _v79 = _v52.a;
							var _v80 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(8, 15 - x),
								3);
						case 4:
							var _v87 = _v52.a;
							var _v88 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(0, 19 - x),
								3);
						default:
							var _v95 = _v52.a;
							var _v96 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(11 - x, 11),
								0);
					}
				case 2:
					switch (_v52.a) {
						case 0:
							var _v57 = _v52.a;
							var _v58 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								2);
						case 1:
							var _v65 = _v52.a;
							var _v66 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(y + 4, 4),
								1);
						case 2:
							var _v73 = _v52.a;
							var _v74 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(15 - y, 7),
								0);
						case 3:
							var _v81 = _v52.a;
							var _v82 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								2);
						case 4:
							var _v89 = _v52.a;
							var _v90 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								2);
						default:
							var _v97 = _v52.a;
							var _v98 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(19 - y, 11),
								0);
					}
				default:
					switch (_v52.a) {
						case 0:
							var _v59 = _v52.a;
							var _v60 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(19 - y, 8),
								1);
						case 1:
							var _v67 = _v52.a;
							var _v68 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(15, 11 - y),
								2);
						case 2:
							var _v75 = _v52.a;
							var _v76 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								3);
						case 3:
							var _v83 = _v52.a;
							var _v84 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								3);
						case 4:
							var _v91 = _v52.a;
							var _v92 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(11, 11 - y),
								2);
						default:
							var _v99 = _v52.a;
							var _v100 = _v52.b;
							return _Utils_Tuple2(
								_Utils_Tuple2(x, y),
								3);
					}
			}
		}
	});
var $author$project$Day22$nextLocation = F3(
	function (puzzlePart, map, vector) {
		nextLocation:
		while (true) {
			var _v0 = A2($author$project$Day22$nextLocationHelperA, map, vector);
			var nextLoc = _v0.a;
			var nextDir = _v0.b;
			var _v1 = A2($elm$core$Dict$get, nextLoc, map.aS);
			if (!_v1.$) {
				if (_v1.a === 1) {
					var _v2 = _v1.a;
					return $elm$core$Maybe$Nothing;
				} else {
					var _v3 = _v1.a;
					return $elm$core$Maybe$Just(
						_Utils_Tuple2(nextLoc, nextDir));
				}
			} else {
				if (!puzzlePart) {
					var $temp$puzzlePart = puzzlePart,
						$temp$map = map,
						$temp$vector = _Utils_Tuple2(nextLoc, nextDir);
					puzzlePart = $temp$puzzlePart;
					map = $temp$map;
					vector = $temp$vector;
					continue nextLocation;
				} else {
					var inputType = 1;
					var _v5 = A3(
						$author$project$Day22$switchCube,
						inputType,
						A2($author$project$Day22$getCube, inputType, vector),
						vector);
					var newLoc = _v5.a;
					var newDir = _v5.b;
					var _v6 = A2($elm$core$Dict$get, newLoc, map.aS);
					if (!_v6.$) {
						if (_v6.a === 1) {
							var _v7 = _v6.a;
							return $elm$core$Maybe$Nothing;
						} else {
							var _v8 = _v6.a;
							return $elm$core$Maybe$Just(
								_Utils_Tuple2(newLoc, newDir));
						}
					} else {
						return $elm$core$Maybe$Nothing;
					}
				}
			}
		}
	});
var $author$project$Day22$walkStep = F4(
	function (puzzlePart, map, steps, vector) {
		walkStep:
		while (true) {
			if (!steps) {
				return vector;
			} else {
				var _v0 = A3($author$project$Day22$nextLocation, puzzlePart, map, vector);
				if (_v0.$ === 1) {
					return vector;
				} else {
					var _new = _v0.a;
					var $temp$puzzlePart = puzzlePart,
						$temp$map = map,
						$temp$steps = steps - 1,
						$temp$vector = _new;
					puzzlePart = $temp$puzzlePart;
					map = $temp$map;
					steps = $temp$steps;
					vector = $temp$vector;
					continue walkStep;
				}
			}
		}
	});
var $author$project$Day22$walk = F4(
	function (puzzlePart, map, commands, _v0) {
		walk:
		while (true) {
			var currentPos = _v0.a;
			var currentDirection = _v0.b;
			if (!commands.b) {
				return _Utils_Tuple2(currentPos, currentDirection);
			} else {
				switch (commands.a.$) {
					case 0:
						var _v2 = commands.a;
						var nextCommands = commands.b;
						var $temp$puzzlePart = puzzlePart,
							$temp$map = map,
							$temp$commands = nextCommands,
							$temp$_v0 = _Utils_Tuple2(
							currentPos,
							$author$project$Day22$turnRight(currentDirection));
						puzzlePart = $temp$puzzlePart;
						map = $temp$map;
						commands = $temp$commands;
						_v0 = $temp$_v0;
						continue walk;
					case 1:
						var _v3 = commands.a;
						var nextCommands = commands.b;
						var $temp$puzzlePart = puzzlePart,
							$temp$map = map,
							$temp$commands = nextCommands,
							$temp$_v0 = _Utils_Tuple2(
							currentPos,
							$author$project$Day22$turnLeft(currentDirection));
						puzzlePart = $temp$puzzlePart;
						map = $temp$map;
						commands = $temp$commands;
						_v0 = $temp$_v0;
						continue walk;
					default:
						var steps = commands.a.a;
						var nextCommands = commands.b;
						return A4(
							$author$project$Day22$walk,
							puzzlePart,
							map,
							nextCommands,
							A4(
								$author$project$Day22$walkStep,
								puzzlePart,
								map,
								steps,
								_Utils_Tuple2(currentPos, currentDirection)));
				}
			}
		}
	});
var $author$project$Day22$runPart = F2(
	function (puzzlePart, puzzleInput) {
		var _v0 = A2($elm$parser$Parser$run, $author$project$Day22$puzzleParser, puzzleInput);
		if (!_v0.$) {
			var _v1 = _v0.a;
			var map = _v1.a;
			var commands = _v1.b;
			var startPos = A2(
				$elm$core$Maybe$withDefault,
				_Utils_Tuple2(0, 0),
				$elm$core$List$head(
					A2(
						$elm$core$List$filter,
						function (_v4) {
							var line = _v4.b;
							return !line;
						},
						$elm$core$Dict$keys(map.aS))));
			var _v2 = A4(
				$author$project$Day22$walk,
				puzzlePart,
				map,
				commands,
				_Utils_Tuple2(startPos, 3));
			var _v3 = _v2.a;
			var x = _v3.a;
			var y = _v3.b;
			var direction = _v2.b;
			return $elm$core$String$fromInt(
				(((y + 1) * 1000) + ((x + 1) * 4)) + $author$project$Day22$directionToFacing(direction));
		} else {
			return 'Error';
		}
	});
var $author$project$Day22$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A2($author$project$Day22$runPart, 0, puzzleInput),
		A2($author$project$Day22$runPart, 1, puzzleInput));
};
var $elm$core$List$minimum = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(
			A3($elm$core$List$foldl, $elm$core$Basics$min, x, xs));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Day23$DontMove = {$: 0};
var $author$project$Day23$East = 3;
var $author$project$Day23$Move = function (a) {
	return {$: 1, a: a};
};
var $author$project$Day23$North = 0;
var $author$project$Day23$South = 1;
var $author$project$Day23$West = 2;
var $author$project$Day23$actionPriority = function (round) {
	var _v0 = A2($elm$core$Basics$modBy, 4, round);
	switch (_v0) {
		case 0:
			return _List_fromArray(
				[
					$author$project$Day23$DontMove,
					$author$project$Day23$Move(0),
					$author$project$Day23$Move(1),
					$author$project$Day23$Move(2),
					$author$project$Day23$Move(3)
				]);
		case 1:
			return _List_fromArray(
				[
					$author$project$Day23$DontMove,
					$author$project$Day23$Move(1),
					$author$project$Day23$Move(2),
					$author$project$Day23$Move(3),
					$author$project$Day23$Move(0)
				]);
		case 2:
			return _List_fromArray(
				[
					$author$project$Day23$DontMove,
					$author$project$Day23$Move(2),
					$author$project$Day23$Move(3),
					$author$project$Day23$Move(0),
					$author$project$Day23$Move(1)
				]);
		case 3:
			return _List_fromArray(
				[
					$author$project$Day23$DontMove,
					$author$project$Day23$Move(3),
					$author$project$Day23$Move(0),
					$author$project$Day23$Move(1),
					$author$project$Day23$Move(2)
				]);
		default:
			return _List_fromArray(
				[$author$project$Day23$DontMove]);
	}
};
var $author$project$Day23$checkCollision = function (movingElves) {
	var foldFn = F3(
		function (move, _v5, _v6) {
			var x = _v5.a;
			var y = _v5.b;
			var _new = _v6.a;
			var rest = _v6.b;
			switch (move) {
				case 0:
					return A2(
						$elm$core$Set$member,
						_Utils_Tuple2(x, y - 2),
						movingElves.ae) ? _Utils_Tuple2(
						_new,
						A2(
							$elm$core$Set$insert,
							_Utils_Tuple2(x, y),
							rest)) : _Utils_Tuple2(
						A2(
							$elm$core$Set$insert,
							_Utils_Tuple2(x, y),
							_new),
						rest);
				case 1:
					return A2(
						$elm$core$Set$member,
						_Utils_Tuple2(x, y + 2),
						movingElves.ab) ? _Utils_Tuple2(
						_new,
						A2(
							$elm$core$Set$insert,
							_Utils_Tuple2(x, y),
							rest)) : _Utils_Tuple2(
						A2(
							$elm$core$Set$insert,
							_Utils_Tuple2(x, y),
							_new),
						rest);
				case 2:
					return A2(
						$elm$core$Set$member,
						_Utils_Tuple2(x - 2, y),
						movingElves.Z) ? _Utils_Tuple2(
						_new,
						A2(
							$elm$core$Set$insert,
							_Utils_Tuple2(x, y),
							rest)) : _Utils_Tuple2(
						A2(
							$elm$core$Set$insert,
							_Utils_Tuple2(x, y),
							_new),
						rest);
				default:
					return A2(
						$elm$core$Set$member,
						_Utils_Tuple2(x + 2, y),
						movingElves.ag) ? _Utils_Tuple2(
						_new,
						A2(
							$elm$core$Set$insert,
							_Utils_Tuple2(x, y),
							rest)) : _Utils_Tuple2(
						A2(
							$elm$core$Set$insert,
							_Utils_Tuple2(x, y),
							_new),
						rest);
			}
		});
	var _v0 = A3(
		$elm$core$Set$foldl,
		foldFn(2),
		_Utils_Tuple2($elm$core$Set$empty, $elm$core$Set$empty),
		movingElves.ag);
	var newWest = _v0.a;
	var restFromWest = _v0.b;
	var _v1 = A3(
		$elm$core$Set$foldl,
		foldFn(1),
		_Utils_Tuple2($elm$core$Set$empty, $elm$core$Set$empty),
		movingElves.ae);
	var newSouth = _v1.a;
	var restFromSouth = _v1.b;
	var _v2 = A3(
		$elm$core$Set$foldl,
		foldFn(0),
		_Utils_Tuple2($elm$core$Set$empty, $elm$core$Set$empty),
		movingElves.ab);
	var newNorth = _v2.a;
	var restFromNorth = _v2.b;
	var _v3 = A3(
		$elm$core$Set$foldl,
		foldFn(3),
		_Utils_Tuple2($elm$core$Set$empty, $elm$core$Set$empty),
		movingElves.Z);
	var newEast = _v3.a;
	var restFromEast = _v3.b;
	return {
		P: A2(
			$elm$core$Set$union,
			restFromEast,
			A2(
				$elm$core$Set$union,
				restFromWest,
				A2(
					$elm$core$Set$union,
					restFromSouth,
					A2($elm$core$Set$union, restFromNorth, movingElves.P)))),
		Z: newEast,
		ab: newNorth,
		ae: newSouth,
		ag: newWest
	};
};
var $author$project$Day23$emptyMove = {P: $elm$core$Set$empty, Z: $elm$core$Set$empty, ab: $elm$core$Set$empty, ae: $elm$core$Set$empty, ag: $elm$core$Set$empty};
var $author$project$Day23$processMove = function (movingElves) {
	var w = A2(
		$elm$core$Set$map,
		function (_v3) {
			var x = _v3.a;
			var y = _v3.b;
			return _Utils_Tuple2(x - 1, y);
		},
		movingElves.ag);
	var s = A2(
		$elm$core$Set$map,
		function (_v2) {
			var x = _v2.a;
			var y = _v2.b;
			return _Utils_Tuple2(x, y + 1);
		},
		movingElves.ae);
	var n = A2(
		$elm$core$Set$map,
		function (_v1) {
			var x = _v1.a;
			var y = _v1.b;
			return _Utils_Tuple2(x, y - 1);
		},
		movingElves.ab);
	var e = A2(
		$elm$core$Set$map,
		function (_v0) {
			var x = _v0.a;
			var y = _v0.b;
			return _Utils_Tuple2(x + 1, y);
		},
		movingElves.Z);
	return A2(
		$elm$core$Set$union,
		e,
		A2(
			$elm$core$Set$union,
			w,
			A2(
				$elm$core$Set$union,
				s,
				A2($elm$core$Set$union, n, movingElves.P))));
};
var $author$project$Day23$E = 7;
var $author$project$Day23$N = 0;
var $author$project$Day23$NE = 1;
var $author$project$Day23$NW = 2;
var $author$project$Day23$S = 3;
var $author$project$Day23$SE = 4;
var $author$project$Day23$SW = 5;
var $author$project$Day23$W = 6;
var $author$project$Day23$free = F3(
	function (elves, directions, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return !A2(
			$elm$core$List$any,
			function (dir) {
				return A2(
					$elm$core$Set$member,
					function () {
						switch (dir) {
							case 0:
								return _Utils_Tuple2(x, y - 1);
							case 1:
								return _Utils_Tuple2(x + 1, y - 1);
							case 2:
								return _Utils_Tuple2(x - 1, y - 1);
							case 3:
								return _Utils_Tuple2(x, y + 1);
							case 4:
								return _Utils_Tuple2(x + 1, y + 1);
							case 5:
								return _Utils_Tuple2(x - 1, y + 1);
							case 6:
								return _Utils_Tuple2(x - 1, y);
							default:
								return _Utils_Tuple2(x + 1, y);
						}
					}(),
					elves);
			},
			directions);
	});
var $author$project$Day23$whereToMove = F4(
	function (elves, actions, elve, movingElves) {
		whereToMove:
		while (true) {
			if (!actions.b) {
				return _Utils_update(
					movingElves,
					{
						P: A2($elm$core$Set$insert, elve, movingElves.P)
					});
			} else {
				var action = actions.a;
				var nextActions = actions.b;
				if (!action.$) {
					if (A3(
						$author$project$Day23$free,
						elves,
						_List_fromArray(
							[0, 2, 1, 3, 4, 5, 6, 7]),
						elve)) {
						return _Utils_update(
							movingElves,
							{
								P: A2($elm$core$Set$insert, elve, movingElves.P)
							});
					} else {
						var $temp$elves = elves,
							$temp$actions = nextActions,
							$temp$elve = elve,
							$temp$movingElves = movingElves;
						elves = $temp$elves;
						actions = $temp$actions;
						elve = $temp$elve;
						movingElves = $temp$movingElves;
						continue whereToMove;
					}
				} else {
					switch (action.a) {
						case 0:
							var _v2 = action.a;
							if (A3(
								$author$project$Day23$free,
								elves,
								_List_fromArray(
									[0, 2, 1]),
								elve)) {
								return _Utils_update(
									movingElves,
									{
										ab: A2($elm$core$Set$insert, elve, movingElves.ab)
									});
							} else {
								var $temp$elves = elves,
									$temp$actions = nextActions,
									$temp$elve = elve,
									$temp$movingElves = movingElves;
								elves = $temp$elves;
								actions = $temp$actions;
								elve = $temp$elve;
								movingElves = $temp$movingElves;
								continue whereToMove;
							}
						case 1:
							var _v3 = action.a;
							if (A3(
								$author$project$Day23$free,
								elves,
								_List_fromArray(
									[3, 4, 5]),
								elve)) {
								return _Utils_update(
									movingElves,
									{
										ae: A2($elm$core$Set$insert, elve, movingElves.ae)
									});
							} else {
								var $temp$elves = elves,
									$temp$actions = nextActions,
									$temp$elve = elve,
									$temp$movingElves = movingElves;
								elves = $temp$elves;
								actions = $temp$actions;
								elve = $temp$elve;
								movingElves = $temp$movingElves;
								continue whereToMove;
							}
						case 2:
							var _v4 = action.a;
							if (A3(
								$author$project$Day23$free,
								elves,
								_List_fromArray(
									[6, 2, 5]),
								elve)) {
								return _Utils_update(
									movingElves,
									{
										ag: A2($elm$core$Set$insert, elve, movingElves.ag)
									});
							} else {
								var $temp$elves = elves,
									$temp$actions = nextActions,
									$temp$elve = elve,
									$temp$movingElves = movingElves;
								elves = $temp$elves;
								actions = $temp$actions;
								elve = $temp$elve;
								movingElves = $temp$movingElves;
								continue whereToMove;
							}
						default:
							var _v5 = action.a;
							if (A3(
								$author$project$Day23$free,
								elves,
								_List_fromArray(
									[7, 1, 4]),
								elve)) {
								return _Utils_update(
									movingElves,
									{
										Z: A2($elm$core$Set$insert, elve, movingElves.Z)
									});
							} else {
								var $temp$elves = elves,
									$temp$actions = nextActions,
									$temp$elve = elve,
									$temp$movingElves = movingElves;
								elves = $temp$elves;
								actions = $temp$actions;
								elve = $temp$elve;
								movingElves = $temp$movingElves;
								continue whereToMove;
							}
					}
				}
			}
		}
	});
var $author$project$Day23$moveOneRound = F2(
	function (round, elves) {
		return $author$project$Day23$processMove(
			$author$project$Day23$checkCollision(
				A3(
					$elm$core$Set$foldl,
					A2(
						$author$project$Day23$whereToMove,
						elves,
						$author$project$Day23$actionPriority(round)),
					$author$project$Day23$emptyMove,
					elves)));
	});
var $author$project$Day23$moveElves = F2(
	function (rounds, elves) {
		return A3(
			$elm$core$List$foldl,
			$author$project$Day23$moveOneRound,
			elves,
			A2($elm$core$List$range, 0, rounds - 1));
	});
var $author$project$Day23$puzzleParser = A2(
	$elm$parser$Parser$loop,
	$elm$core$Set$empty,
	function (elves) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					$elm$parser$Parser$backtrackable(
					A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$succeed(
								function (_v0) {
									var row = _v0.a;
									var col = _v0.b;
									return $elm$parser$Parser$Loop(
										A2(
											$elm$core$Set$insert,
											_Utils_Tuple2(col, row),
											elves));
								}),
							$elm$parser$Parser$chompWhile(
								function (c) {
									return c !== '#';
								})),
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$getPosition,
							$elm$parser$Parser$symbol('#')))),
					A2(
					$elm$parser$Parser$map,
					function (_v1) {
						return $elm$parser$Parser$Done(elves);
					},
					A2(
						$elm$parser$Parser$ignorer,
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$succeed(0),
							$elm$parser$Parser$chompWhile(
								function (c) {
									return c !== '#';
								})),
						$elm$parser$Parser$end))
				]));
	});
var $author$project$Day23$runPartA = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day23$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var elves = _v0.a;
		var movedElves = A2($author$project$Day23$moveElves, 10, elves);
		var xValues = A2(
			$elm$core$List$map,
			$elm$core$Tuple$first,
			$elm$core$Set$toList(movedElves));
		var yValues = A2(
			$elm$core$List$map,
			$elm$core$Tuple$second,
			$elm$core$Set$toList(movedElves));
		var diff = function (values) {
			var min = $elm$core$List$minimum(values);
			var max = $elm$core$List$maximum(values);
			var _v1 = _Utils_Tuple2(max, min);
			if ((!_v1.a.$) && (!_v1.b.$)) {
				var maxi = _v1.a.a;
				var mini = _v1.b.a;
				return (maxi - mini) + 1;
			} else {
				return 0;
			}
		};
		return $elm$core$String$fromInt(
			(diff(xValues) * diff(yValues)) - $elm$core$Set$size(movedElves));
	} else {
		return 'Error';
	}
};
var $author$project$Day23$moveForever = F2(
	function (elves, index) {
		moveForever:
		while (true) {
			var movedElves = A2($author$project$Day23$moveOneRound, index, elves);
			if (_Utils_eq(elves, movedElves)) {
				return index + 1;
			} else {
				var $temp$elves = movedElves,
					$temp$index = index + 1;
				elves = $temp$elves;
				index = $temp$index;
				continue moveForever;
			}
		}
	});
var $author$project$Day23$runPartB = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day23$puzzleParser, puzzleInput);
	if (!_v0.$) {
		var elves = _v0.a;
		return $elm$core$String$fromInt(
			A2($author$project$Day23$moveForever, elves, 0));
	} else {
		return 'Error';
	}
};
var $author$project$Day23$run = function (puzzleInput) {
	return _Utils_Tuple2(
		$author$project$Day23$runPartA(puzzleInput),
		$author$project$Day23$runPartB(puzzleInput));
};
var $author$project$Day24$PuzzlePartA = 0;
var $author$project$Day24$PuzzlePartB = 1;
var $author$project$Day24$East = 3;
var $author$project$Day24$North = 0;
var $author$project$Day24$South = 1;
var $author$project$Day24$West = 2;
var $author$project$Day24$toDirection = function (arrow) {
	switch (arrow) {
		case '<':
			return 2;
		case '>':
			return 3;
		case '^':
			return 0;
		default:
			return 1;
	}
};
var $author$project$Day24$parserValleyLine = A2(
	$elm$parser$Parser$loop,
	_List_Nil,
	function (blizzards) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						function (mbb) {
							if (!mbb.$) {
								var blizz = mbb.a;
								return $elm$parser$Parser$Loop(
									A2($elm$core$List$cons, blizz, blizzards));
							} else {
								return $elm$parser$Parser$Loop(blizzards);
							}
						}),
					$elm$parser$Parser$oneOf(
						_List_fromArray(
							[
								A2(
								$elm$parser$Parser$keeper,
								A2(
									$elm$parser$Parser$keeper,
									$elm$parser$Parser$succeed(
										F2(
											function (_v1, arrow) {
												var row = _v1.a;
												var col = _v1.b;
												return $elm$core$Maybe$Just(
													{
														bv: $author$project$Day24$toDirection(arrow),
														ad: _Utils_Tuple2(col - 1, row - 1)
													});
											})),
									$elm$parser$Parser$getPosition),
								$elm$parser$Parser$getChompedString(
									$elm$parser$Parser$chompIf(
										function (c) {
											return (c === '<') || ((c === '>') || ((c === 'v') || (c === '^')));
										}))),
								A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed($elm$core$Maybe$Nothing),
								$elm$parser$Parser$symbol('.'))
							]))),
					A2(
					$elm$parser$Parser$map,
					function (_v2) {
						return $elm$parser$Parser$Done(
							$elm$core$List$reverse(blizzards));
					},
					$elm$parser$Parser$succeed(0))
				]));
	});
var $author$project$Day24$middleParser = A2(
	$elm$parser$Parser$loop,
	_List_Nil,
	function (blizzards) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					$elm$parser$Parser$backtrackable(
					A2(
						$elm$parser$Parser$keeper,
						A2(
							$elm$parser$Parser$ignorer,
							$elm$parser$Parser$succeed(
								function (line) {
									return $elm$parser$Parser$Loop(
										_Utils_ap(blizzards, line));
								}),
							$elm$parser$Parser$symbol('#')),
						A2(
							$elm$parser$Parser$ignorer,
							$author$project$Day24$parserValleyLine,
							$elm$parser$Parser$symbol('#\n')))),
					A2(
					$elm$parser$Parser$map,
					function (_v0) {
						return $elm$parser$Parser$Done(blizzards);
					},
					$elm$parser$Parser$succeed(0))
				]));
	});
var $author$project$Day24$startOrEndParser = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$ignorer,
		$elm$parser$Parser$succeed(
			function (_v0) {
				var row = _v0.a;
				var col = _v0.b;
				return _Utils_Tuple2(col - 1, row - 1);
			}),
		$elm$parser$Parser$chompWhile(
			$elm$core$Basics$eq('#'))),
	A2(
		$elm$parser$Parser$ignorer,
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$getPosition,
			$elm$parser$Parser$symbol('.')),
		$elm$parser$Parser$chompWhile(
			$elm$core$Basics$eq('#'))));
var $author$project$Day24$puzzleParser = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				$elm$parser$Parser$succeed(
					F4(
						function (start, middle, end, _v0) {
							var row = _v0.a;
							var col = _v0.b;
							return {aK: middle, aM: start, az: end, aB: row, bo: col - 1};
						})),
				A2(
					$elm$parser$Parser$ignorer,
					$author$project$Day24$startOrEndParser,
					$elm$parser$Parser$symbol('\n'))),
			$author$project$Day24$middleParser),
		$author$project$Day24$startOrEndParser),
	A2(
		$elm$parser$Parser$ignorer,
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$getPosition,
			$elm$parser$Parser$symbol('\n')),
		$elm$parser$Parser$end));
var $author$project$Day24$extendPositions = F2(
	function (_v0, all) {
		var x = _v0.a;
		var y = _v0.b;
		return A2(
			$elm$core$Set$union,
			all,
			$elm$core$Set$fromList(
				_List_fromArray(
					[
						_Utils_Tuple2(x, y),
						_Utils_Tuple2(x + 1, y),
						_Utils_Tuple2(x - 1, y),
						_Utils_Tuple2(x, y + 1),
						_Utils_Tuple2(x, y - 1)
					])));
	});
var $author$project$Day24$isBlizzard = F2(
	function (valley, pos) {
		return A2(
			$elm$core$List$any,
			function (blizz) {
				return _Utils_eq(blizz.ad, pos);
			},
			valley.aK);
	});
var $author$project$Day24$isWallOf = F2(
	function (valley, pos) {
		var x = pos.a;
		var y = pos.b;
		return ((x <= 0) || (_Utils_cmp(x, valley.bo - 1) > -1)) ? true : (((y <= 0) && (!_Utils_eq(pos, valley.aM))) ? true : (((_Utils_cmp(y, valley.aB - 1) > -1) && (!_Utils_eq(pos, valley.az))) ? true : false));
	});
var $author$project$Day24$freePosition = F2(
	function (valley, pos) {
		return A2($author$project$Day24$isWallOf, valley, pos) ? false : (A2($author$project$Day24$isBlizzard, valley, pos) ? false : true);
	});
var $elm$core$Tuple$mapBoth = F3(
	function (funcA, funcB, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			funcA(x),
			funcB(y));
	});
var $elm$core$Tuple$mapFirst = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			func(x),
			y);
	});
var $elm$core$Tuple$mapSecond = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			x,
			func(y));
	});
var $author$project$Day24$walk = F4(
	function (valley, targets, currentPos, currentPath) {
		walk:
		while (true) {
			if (!targets.b) {
				return currentPath - 1;
			} else {
				var target = targets.a;
				var nextTargets = targets.b;
				var newBlizzards = A2(
					$elm$core$List$map,
					function (blizz) {
						var newBlizzPos = A3(
							$elm$core$Tuple$mapBoth,
							function (x) {
								return 1 + A2($elm$core$Basics$modBy, valley.bo - 2, x - 1);
							},
							function (y) {
								return 1 + A2($elm$core$Basics$modBy, valley.aB - 2, y - 1);
							},
							function () {
								var _v1 = blizz.bv;
								switch (_v1) {
									case 0:
										return A2(
											$elm$core$Tuple$mapSecond,
											$elm$core$Basics$add(-1),
											blizz.ad);
									case 1:
										return A2(
											$elm$core$Tuple$mapSecond,
											$elm$core$Basics$add(1),
											blizz.ad);
									case 2:
										return A2(
											$elm$core$Tuple$mapFirst,
											$elm$core$Basics$add(-1),
											blizz.ad);
									default:
										return A2(
											$elm$core$Tuple$mapFirst,
											$elm$core$Basics$add(1),
											blizz.ad);
								}
							}());
						return _Utils_update(
							blizz,
							{ad: newBlizzPos});
					},
					valley.aK);
				var newValley = _Utils_update(
					valley,
					{aK: newBlizzards});
				var newPos = function (curPos) {
					return A2(
						$elm$core$Set$filter,
						$author$project$Day24$freePosition(newValley),
						A3($elm$core$Set$foldl, $author$project$Day24$extendPositions, $elm$core$Set$empty, curPos));
				};
				if (A2($elm$core$Set$member, target, currentPos)) {
					var $temp$valley = newValley,
						$temp$targets = nextTargets,
						$temp$currentPos = newPos(
						$elm$core$Set$singleton(target)),
						$temp$currentPath = currentPath + 1;
					valley = $temp$valley;
					targets = $temp$targets;
					currentPos = $temp$currentPos;
					currentPath = $temp$currentPath;
					continue walk;
				} else {
					var $temp$valley = newValley,
						$temp$targets = targets,
						$temp$currentPos = newPos(currentPos),
						$temp$currentPath = currentPath + 1;
					valley = $temp$valley;
					targets = $temp$targets;
					currentPos = $temp$currentPos;
					currentPath = $temp$currentPath;
					continue walk;
				}
			}
		}
	});
var $author$project$Day24$runPart = F2(
	function (puzzleInput, puzzlePart) {
		var _v0 = A2($elm$parser$Parser$run, $author$project$Day24$puzzleParser, puzzleInput);
		if (_v0.$ === 1) {
			return 'Error';
		} else {
			var valley = _v0.a;
			var targets = function () {
				if (!puzzlePart) {
					return _List_fromArray(
						[valley.az]);
				} else {
					return _List_fromArray(
						[valley.az, valley.aM, valley.az]);
				}
			}();
			var currentPos = $elm$core$Set$singleton(valley.aM);
			var currentPath = 0;
			return $elm$core$String$fromInt(
				A4($author$project$Day24$walk, valley, targets, currentPos, currentPath));
		}
	});
var $author$project$Day24$run = function (puzzleInput) {
	return _Utils_Tuple2(
		A2($author$project$Day24$runPart, puzzleInput, 0),
		A2($author$project$Day24$runPart, puzzleInput, 1));
};
var $author$project$Day25$Zero = 2;
var $elm$core$List$append = F2(
	function (xs, ys) {
		if (!ys.b) {
			return xs;
		} else {
			return A3($elm$core$List$foldr, $elm$core$List$cons, ys, xs);
		}
	});
var $author$project$Day25$MinusOne = 1;
var $author$project$Day25$MinusTwo = 0;
var $author$project$Day25$One = 3;
var $author$project$Day25$Two = 4;
var $author$project$Day25$addSNAFUDigits = F2(
	function (a, b) {
		switch (a) {
			case 0:
				switch (b) {
					case 0:
						return _Utils_Tuple2(3, 1);
					case 1:
						return _Utils_Tuple2(4, 1);
					case 2:
						return _Utils_Tuple2(0, 2);
					case 3:
						return _Utils_Tuple2(1, 2);
					default:
						return _Utils_Tuple2(2, 2);
				}
			case 1:
				switch (b) {
					case 0:
						return _Utils_Tuple2(4, 1);
					case 1:
						return _Utils_Tuple2(0, 2);
					case 2:
						return _Utils_Tuple2(1, 2);
					case 3:
						return _Utils_Tuple2(2, 2);
					default:
						return _Utils_Tuple2(3, 2);
				}
			case 2:
				return _Utils_Tuple2(b, 2);
			case 3:
				switch (b) {
					case 0:
						return _Utils_Tuple2(1, 2);
					case 1:
						return _Utils_Tuple2(2, 2);
					case 2:
						return _Utils_Tuple2(3, 2);
					case 3:
						return _Utils_Tuple2(4, 2);
					default:
						return _Utils_Tuple2(0, 3);
				}
			default:
				switch (b) {
					case 0:
						return _Utils_Tuple2(2, 2);
					case 1:
						return _Utils_Tuple2(3, 2);
					case 2:
						return _Utils_Tuple2(4, 2);
					case 3:
						return _Utils_Tuple2(0, 3);
					default:
						return _Utils_Tuple2(1, 3);
				}
		}
	});
var $author$project$Day25$fn = F2(
	function (_v0, _v1) {
		var a = _v0.a;
		var b = _v0.b;
		var sum = _v1.a;
		var carry = _v1.b;
		var _v2 = A2($author$project$Day25$addSNAFUDigits, a, carry);
		var s1 = _v2.a;
		var c1 = _v2.b;
		var _v3 = A2($author$project$Day25$addSNAFUDigits, s1, b);
		var s2 = _v3.a;
		var c2 = _v3.b;
		return _Utils_Tuple2(
			A2($elm$core$List$cons, s2, sum),
			A2($author$project$Day25$addSNAFUDigits, c1, c2).a);
	});
var $author$project$Day25$addSNAFU = F2(
	function (a, b) {
		var lenB = $elm$core$List$length(b);
		var lenA = $elm$core$List$length(a);
		var offset = A2(
			$elm$core$List$repeat,
			$elm$core$Basics$abs(lenA - lenB),
			2);
		var aAndB = A3(
			$elm$core$List$map2,
			$elm$core$Tuple$pair,
			$elm$core$List$reverse(
				A2($elm$core$List$append, offset, a)),
			$elm$core$List$reverse(
				A2($elm$core$List$append, offset, b)));
		var _v0 = A3(
			$elm$core$List$foldl,
			$author$project$Day25$fn,
			_Utils_Tuple2(_List_Nil, 2),
			aAndB);
		var sum = _v0.a;
		var carry = _v0.b;
		if (carry === 2) {
			return sum;
		} else {
			return A2($elm$core$List$cons, carry, sum);
		}
	});
var $author$project$Day25$fromSNAFUToDigit = function (s) {
	switch (s) {
		case 0:
			return '=';
		case 1:
			return '-';
		case 2:
			return '0';
		case 3:
			return '1';
		default:
			return '2';
	}
};
var $author$project$Day25$fromSNAFUToString = function (num) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (ch, s) {
				return _Utils_ap(
					s,
					$elm$core$String$fromChar(ch));
			}),
		'',
		A2($elm$core$List$map, $author$project$Day25$fromSNAFUToDigit, num));
};
var $author$project$Day25$toSNAFUDigit = function (ch) {
	switch (ch) {
		case '=':
			return $elm$core$Maybe$Just(0);
		case '-':
			return $elm$core$Maybe$Just(1);
		case '0':
			return $elm$core$Maybe$Just(2);
		case '1':
			return $elm$core$Maybe$Just(3);
		case '2':
			return $elm$core$Maybe$Just(4);
		default:
			return $elm$core$Maybe$Nothing;
	}
};
var $author$project$Day25$toSNAFUNumber = F2(
	function (mbnum, chars) {
		return A2(
			$elm$core$Maybe$andThen,
			function (num) {
				if (!chars.b) {
					return $elm$core$Maybe$Just(
						$elm$core$List$reverse(num));
				} else {
					var one = chars.a;
					var rest = chars.b;
					return A2(
						$author$project$Day25$toSNAFUNumber,
						A2(
							$elm$core$Maybe$andThen,
							function (ch) {
								return $elm$core$Maybe$Just(
									A2($elm$core$List$cons, ch, num));
							},
							$author$project$Day25$toSNAFUDigit(one)),
						rest);
				}
			},
			mbnum);
	});
var $author$project$Day25$puzzleParser = A2(
	$elm$parser$Parser$loop,
	_List_Nil,
	function (list) {
		return $elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed(
						function (s) {
							var _v0 = A2(
								$author$project$Day25$toSNAFUNumber,
								$elm$core$Maybe$Just(_List_Nil),
								$elm$core$String$toList(s));
							if (!_v0.$) {
								var num = _v0.a;
								return $elm$parser$Parser$Loop(
									A2($elm$core$List$cons, num, list));
							} else {
								return $elm$parser$Parser$Loop(list);
							}
						}),
					A2(
						$elm$parser$Parser$ignorer,
						$elm$parser$Parser$getChompedString(
							A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed(0),
								$elm$parser$Parser$chompWhile(
									function (c) {
										return A2(
											$elm$core$List$any,
											$elm$core$Basics$eq(c),
											_List_fromArray(
												['=', '-', '0', '1', '2']));
									}))),
						$elm$parser$Parser$symbol('\n'))),
					A2(
					$elm$parser$Parser$map,
					function (_v1) {
						return $elm$parser$Parser$Done(
							$elm$core$List$reverse(list));
					},
					$elm$parser$Parser$succeed(0))
				]));
	});
var $author$project$Day25$runPartA = function (puzzleInput) {
	var _v0 = A2($elm$parser$Parser$run, $author$project$Day25$puzzleParser, puzzleInput);
	if (_v0.$ === 1) {
		return 'Error';
	} else {
		var numbers = _v0.a;
		return $author$project$Day25$fromSNAFUToString(
			A3(
				$elm$core$List$foldl,
				$author$project$Day25$addSNAFU,
				_List_fromArray(
					[2]),
				numbers));
	}
};
var $author$project$Day25$run = function (puzzleInput) {
	return _Utils_Tuple2(
		$author$project$Day25$runPartA(puzzleInput),
		'No solution');
};
var $author$project$Main$allDays = $elm$core$Dict$fromList(
	_List_fromArray(
		[
			_Utils_Tuple2(1, $author$project$Day01$run),
			_Utils_Tuple2(2, $author$project$Day02$run),
			_Utils_Tuple2(3, $author$project$Day03$run),
			_Utils_Tuple2(4, $author$project$Day04$run),
			_Utils_Tuple2(5, $author$project$Day05$run),
			_Utils_Tuple2(6, $author$project$Day06$run),
			_Utils_Tuple2(7, $author$project$Day07$run),
			_Utils_Tuple2(8, $author$project$Day08$run),
			_Utils_Tuple2(9, $author$project$Day09$run),
			_Utils_Tuple2(10, $author$project$Day10$run),
			_Utils_Tuple2(11, $author$project$Day11$run),
			_Utils_Tuple2(12, $author$project$Day12$run),
			_Utils_Tuple2(13, $author$project$Day13$run),
			_Utils_Tuple2(14, $author$project$Day14$run),
			_Utils_Tuple2(15, $author$project$Day15$run),
			_Utils_Tuple2(16, $author$project$Day16$run),
			_Utils_Tuple2(17, $author$project$Day17$run),
			_Utils_Tuple2(18, $author$project$Day18$run),
			_Utils_Tuple2(19, $author$project$Day19$run),
			_Utils_Tuple2(20, $author$project$Day20$run),
			_Utils_Tuple2(21, $author$project$Day21$run),
			_Utils_Tuple2(22, $author$project$Day22$run),
			_Utils_Tuple2(23, $author$project$Day23$run),
			_Utils_Tuple2(24, $author$project$Day24$run),
			_Utils_Tuple2(25, $author$project$Day25$run)
		]));
var $author$project$Main$update = F2(
	function (msg, model) {
		if (!msg.$) {
			var c = msg.a;
			return _Utils_update(
				model,
				{bb: c});
		} else {
			var d = msg.a;
			var fn = A2(
				$elm$core$Maybe$withDefault,
				$author$project$Main$notImplementedFn,
				A2($elm$core$Dict$get, d, $author$project$Main$allDays));
			return _Utils_update(
				model,
				{
					bt: A2($author$project$Main$Day, d, fn)
				});
		}
	});
var $author$project$Main$FormDay = function (a) {
	return {$: 1, a: a};
};
var $author$project$Main$FormField = function (a) {
	return {$: 0, a: a};
};
var $elm$virtual_dom$VirtualDom$attribute = F2(
	function (key, value) {
		return A2(
			_VirtualDom_attribute,
			_VirtualDom_noOnOrFormAction(key),
			_VirtualDom_noJavaScriptOrHtmlUri(value));
	});
var $elm$html$Html$Attributes$attribute = $elm$virtual_dom$VirtualDom$attribute;
var $elm$json$Json$Encode$string = _Json_wrap;
var $elm$html$Html$Attributes$stringProperty = F2(
	function (key, string) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$string(string));
	});
var $elm$html$Html$Attributes$class = $elm$html$Html$Attributes$stringProperty('className');
var $elm$html$Html$Attributes$classList = function (classes) {
	return $elm$html$Html$Attributes$class(
		A2(
			$elm$core$String$join,
			' ',
			A2(
				$elm$core$List$map,
				$elm$core$Tuple$first,
				A2($elm$core$List$filter, $elm$core$Tuple$second, classes))));
};
var $author$project$Main$classes = function (s) {
	var cl = A2(
		$elm$core$List$map,
		function (c) {
			return _Utils_Tuple2(c, true);
		},
		A2($elm$core$String$split, ' ', s));
	return $elm$html$Html$Attributes$classList(cl);
};
var $elm$json$Json$Encode$bool = _Json_wrap;
var $elm$html$Html$Attributes$boolProperty = F2(
	function (key, bool) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$bool(bool));
	});
var $elm$html$Html$Attributes$disabled = $elm$html$Html$Attributes$boolProperty('disabled');
var $elm$html$Html$div = _VirtualDom_node('div');
var $elm$html$Html$form = _VirtualDom_node('form');
var $elm$html$Html$h1 = _VirtualDom_node('h1');
var $elm$html$Html$h2 = _VirtualDom_node('h2');
var $elm$html$Html$main_ = _VirtualDom_node('main');
var $elm$html$Html$Events$alwaysStop = function (x) {
	return _Utils_Tuple2(x, true);
};
var $elm$virtual_dom$VirtualDom$MayStopPropagation = function (a) {
	return {$: 1, a: a};
};
var $elm$virtual_dom$VirtualDom$on = _VirtualDom_on;
var $elm$html$Html$Events$stopPropagationOn = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$MayStopPropagation(decoder));
	});
var $elm$json$Json$Decode$field = _Json_decodeField;
var $elm$json$Json$Decode$at = F2(
	function (fields, decoder) {
		return A3($elm$core$List$foldr, $elm$json$Json$Decode$field, decoder, fields);
	});
var $elm$json$Json$Decode$string = _Json_decodeString;
var $elm$html$Html$Events$targetValue = A2(
	$elm$json$Json$Decode$at,
	_List_fromArray(
		['target', 'value']),
	$elm$json$Json$Decode$string);
var $elm$html$Html$Events$onInput = function (tagger) {
	return A2(
		$elm$html$Html$Events$stopPropagationOn,
		'input',
		A2(
			$elm$json$Json$Decode$map,
			$elm$html$Html$Events$alwaysStop,
			A2($elm$json$Json$Decode$map, tagger, $elm$html$Html$Events$targetValue)));
};
var $elm$html$Html$option = _VirtualDom_node('option');
var $elm$html$Html$Attributes$placeholder = $elm$html$Html$Attributes$stringProperty('placeholder');
var $elm$html$Html$Attributes$required = $elm$html$Html$Attributes$boolProperty('required');
var $elm$html$Html$Attributes$rows = function (n) {
	return A2(
		_VirtualDom_attribute,
		'rows',
		$elm$core$String$fromInt(n));
};
var $elm$html$Html$select = _VirtualDom_node('select');
var $elm$html$Html$Attributes$selected = $elm$html$Html$Attributes$boolProperty('selected');
var $elm$virtual_dom$VirtualDom$text = _VirtualDom_text;
var $elm$html$Html$text = $elm$virtual_dom$VirtualDom$text;
var $elm$html$Html$textarea = _VirtualDom_node('textarea');
var $elm$html$Html$Attributes$value = $elm$html$Html$Attributes$stringProperty('value');
var $author$project$Main$view = function (model) {
	var result = function () {
		var _v0 = model.bt;
		var i = _v0.a;
		var fn = _v0.b;
		return _Utils_Tuple2(
			i,
			fn(model.bb));
	}();
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				$author$project$Main$classes('container p-3 pb-5')
			]),
		_List_fromArray(
			[
				A2(
				$elm$html$Html$main_,
				_List_Nil,
				_Utils_ap(
					_List_fromArray(
						[
							A2(
							$elm$html$Html$h1,
							_List_fromArray(
								[
									$elm$html$Html$Attributes$class('pb-5')
								]),
							_List_fromArray(
								[
									$elm$html$Html$text('Advent Of Code 2022')
								])),
							A2(
							$elm$html$Html$form,
							_List_fromArray(
								[
									$author$project$Main$classes('row mb-5')
								]),
							_List_fromArray(
								[
									A2(
									$elm$html$Html$div,
									_List_fromArray(
										[
											$elm$html$Html$Attributes$class('col-4')
										]),
									_List_fromArray(
										[
											A2(
											$elm$html$Html$select,
											_List_fromArray(
												[
													$elm$html$Html$Attributes$class('form-select'),
													A2($elm$html$Html$Attributes$attribute, 'aria-label', 'Select day'),
													$elm$html$Html$Events$onInput(
													A2(
														$elm$core$Basics$composeR,
														$elm$core$String$toInt,
														A2(
															$elm$core$Basics$composeR,
															$elm$core$Maybe$withDefault(0),
															$author$project$Main$FormDay)))
												]),
											A2(
												$elm$core$List$cons,
												A2(
													$elm$html$Html$option,
													_List_fromArray(
														[
															$elm$html$Html$Attributes$selected(true),
															$elm$html$Html$Attributes$disabled(true)
														]),
													_List_fromArray(
														[
															$elm$html$Html$text('Select day')
														])),
												A2(
													$elm$core$List$map,
													function (i) {
														return A2(
															$elm$html$Html$option,
															_List_fromArray(
																[
																	$elm$html$Html$Attributes$value(
																	$elm$core$String$fromInt(i))
																]),
															_List_fromArray(
																[
																	$elm$html$Html$text(
																	$elm$core$String$fromInt(i))
																]));
													},
													A2($elm$core$List$range, 1, 25))))
										]))
								]))
						]),
					(result.a > 0) ? _List_fromArray(
						[
							A2(
							$elm$html$Html$div,
							_List_Nil,
							_List_fromArray(
								[
									A2(
									$elm$html$Html$h2,
									_List_fromArray(
										[
											$elm$html$Html$Attributes$class('mb-3')
										]),
									_List_fromArray(
										[
											$elm$html$Html$text(
											'Result for day ' + $elm$core$String$fromInt(result.a))
										])),
									A2(
									$elm$html$Html$form,
									_List_fromArray(
										[
											$author$project$Main$classes('row mb-5')
										]),
									_List_fromArray(
										[
											A2(
											$elm$html$Html$div,
											_List_fromArray(
												[
													$author$project$Main$classes('col-4')
												]),
											_List_fromArray(
												[
													A2(
													$elm$html$Html$textarea,
													_List_fromArray(
														[
															$elm$html$Html$Attributes$class('form-control'),
															$elm$html$Html$Attributes$rows(5),
															$elm$html$Html$Attributes$placeholder('Puzzle input'),
															A2($elm$html$Html$Attributes$attribute, 'aria-label', 'Puzzle input'),
															$elm$html$Html$Attributes$required(true),
															$elm$html$Html$Events$onInput($author$project$Main$FormField),
															$elm$html$Html$Attributes$value(model.bb)
														]),
													_List_Nil)
												])),
											A2(
											$elm$html$Html$div,
											_List_fromArray(
												[
													$elm$html$Html$Attributes$class('col-4')
												]),
											_List_fromArray(
												[
													$elm$html$Html$text(result.b.a)
												])),
											A2(
											$elm$html$Html$div,
											_List_fromArray(
												[
													$author$project$Main$classes('col-4 font-monospace')
												]),
											_List_fromArray(
												[
													$elm$html$Html$text(result.b.b)
												]))
										]))
								]))
						]) : _List_Nil))
			]));
};
var $author$project$Main$main = $elm$browser$Browser$sandbox(
	{c0: $author$project$Main$init, dx: $author$project$Main$update, dy: $author$project$Main$view});
_Platform_export({'Main':{'init':$author$project$Main$main(
	$elm$json$Json$Decode$succeed(0))(0)}});}(this));
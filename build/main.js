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

console.warn('Compiled in DEV mode. Follow the advice at https://elm-lang.org/0.19.1/optimize for better performance and smaller assets.');


var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


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

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
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

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
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


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
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
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
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

	/**/
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

	/**_UNUSED/
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

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (typeof x.$ === 'undefined')
	//*/
	/**/
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

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


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



/**/
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

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

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
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**/, _Json_errorToString(result.a) /**/);
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


function _Platform_export_UNUSED(exports)
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


function _Platform_export(exports)
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


// CREATE

var _Regex_never = /.^/;

var _Regex_fromStringWith = F2(function(options, string)
{
	var flags = 'g';
	if (options.multiline) { flags += 'm'; }
	if (options.caseInsensitive) { flags += 'i'; }

	try
	{
		return $elm$core$Maybe$Just(new RegExp(string, flags));
	}
	catch(error)
	{
		return $elm$core$Maybe$Nothing;
	}
});


// USE

var _Regex_contains = F2(function(re, string)
{
	return string.match(re) !== null;
});


var _Regex_findAtMost = F3(function(n, re, str)
{
	var out = [];
	var number = 0;
	var string = str;
	var lastIndex = re.lastIndex;
	var prevLastIndex = -1;
	var result;
	while (number++ < n && (result = re.exec(string)))
	{
		if (prevLastIndex == re.lastIndex) break;
		var i = result.length - 1;
		var subs = new Array(i);
		while (i > 0)
		{
			var submatch = result[i];
			subs[--i] = submatch
				? $elm$core$Maybe$Just(submatch)
				: $elm$core$Maybe$Nothing;
		}
		out.push(A4($elm$regex$Regex$Match, result[0], result.index, number, _List_fromArray(subs)));
		prevLastIndex = re.lastIndex;
	}
	re.lastIndex = lastIndex;
	return _List_fromArray(out);
});


var _Regex_replaceAtMost = F4(function(n, re, replacer, string)
{
	var count = 0;
	function jsReplacer(match)
	{
		if (count++ >= n)
		{
			return match;
		}
		var i = arguments.length - 3;
		var submatches = new Array(i);
		while (i > 0)
		{
			var submatch = arguments[i];
			submatches[--i] = submatch
				? $elm$core$Maybe$Just(submatch)
				: $elm$core$Maybe$Nothing;
		}
		return replacer(A4($elm$regex$Regex$Match, match, arguments[arguments.length - 2], count, _List_fromArray(submatches)));
	}
	return string.replace(re, jsReplacer);
});

var _Regex_splitAtMost = F3(function(n, re, str)
{
	var string = str;
	var out = [];
	var start = re.lastIndex;
	var restoreLastIndex = re.lastIndex;
	while (n--)
	{
		var result = re.exec(string);
		if (!result) break;
		out.push(string.slice(start, result.index));
		start = re.lastIndex;
	}
	out.push(string.slice(start));
	re.lastIndex = restoreLastIndex;
	return _List_fromArray(out);
});

var _Regex_infinity = Infinity;




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
var $elm$core$Basics$EQ = {$: 'EQ'};
var $elm$core$Basics$LT = {$: 'LT'};
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
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
			if (t.$ === 'RBEmpty_elm_builtin') {
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
	var dict = _v0.a;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$GT = {$: 'GT'};
var $elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var $elm$core$Basics$False = {$: 'False'};
var $elm$core$Basics$add = _Basics_add;
var $elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var $elm$core$Maybe$Nothing = {$: 'Nothing'};
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
				case 'Field':
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 'Nothing') {
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
				case 'Index':
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'OneOf':
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
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
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
	return {$: 'Leaf', a: a};
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
	return {$: 'SubTree', a: a};
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
		if (!builder.nodeListSize) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.tail);
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
					{nodeList: nodeList, nodeListSize: (len / $elm$core$Array$branchFactor) | 0, tail: tail});
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
var $elm$core$Basics$True = {$: 'True'};
var $elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $author$project$Main$init = function (_v0) {
	return _Utils_Tuple2(
		{},
		$elm$core$Platform$Cmd$none);
};
var $elm$core$Basics$identity = function (x) {
	return x;
};
var $author$project$Main$GotSpec = function (a) {
	return {$: 'GotSpec', a: a};
};
var $elm$json$Json$Decode$value = _Json_decodeValue;
var $author$project$Main$gotSpec = _Platform_incomingPort('gotSpec', $elm$json$Json$Decode$value);
var $author$project$Main$subscriptions = function (model) {
	return $author$project$Main$gotSpec($author$project$Main$GotSpec);
};
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $stil4m$elm_syntax$Elm$Syntax$Declaration$AliasDeclaration = function (a) {
	return {$: 'AliasDeclaration', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$Declaration = function (a) {
	return {$: 'Declaration', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$NotExposed = {$: 'NotExposed'};
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
var $elm$core$String$left = F2(
	function (n, string) {
		return (n < 1) ? '' : A3($elm$core$String$slice, 0, n, string);
	});
var $elm$core$String$toUpper = _String_toUpper;
var $mdgriffith$elm_codegen$Internal$Format$formatType = function (str) {
	return _Utils_ap(
		$elm$core$String$toUpper(
			A2($elm$core$String$left, 1, str)),
		A2($elm$core$String$dropLeft, 1, str));
};
var $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports = function (_v0) {
	var details = _v0.a;
	return details.imports;
};
var $elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
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
var $elm$core$List$append = F2(
	function (xs, ys) {
		if (!ys.b) {
			return xs;
		} else {
			return A3($elm$core$List$foldr, $elm$core$List$cons, ys, xs);
		}
	});
var $elm$core$List$concat = function (lists) {
	return A3($elm$core$List$foldr, $elm$core$List$append, _List_Nil, lists);
};
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
var $elm$core$List$concatMap = F2(
	function (f, list) {
		return $elm$core$List$concat(
			A2($elm$core$List$map, f, list));
	});
var $stil4m$elm_syntax$Elm$Syntax$Node$value = function (_v0) {
	var v = _v0.b;
	return v;
};
var $mdgriffith$elm_codegen$Internal$Compiler$denode = $stil4m$elm_syntax$Elm$Syntax$Node$value;
var $mdgriffith$elm_codegen$Internal$Compiler$getGenericsHelper = function (ann) {
	switch (ann.$) {
		case 'GenericType':
			var str = ann.a;
			return _List_fromArray(
				[str]);
		case 'Typed':
			var modName = ann.a;
			var anns = ann.b;
			return A2(
				$elm$core$List$concatMap,
				A2($elm$core$Basics$composeL, $mdgriffith$elm_codegen$Internal$Compiler$getGenericsHelper, $mdgriffith$elm_codegen$Internal$Compiler$denode),
				anns);
		case 'Unit':
			return _List_Nil;
		case 'Tupled':
			var tupled = ann.a;
			return A2(
				$elm$core$List$concatMap,
				A2($elm$core$Basics$composeL, $mdgriffith$elm_codegen$Internal$Compiler$getGenericsHelper, $mdgriffith$elm_codegen$Internal$Compiler$denode),
				tupled);
		case 'Record':
			var recordDefinition = ann.a;
			return A2(
				$elm$core$List$concatMap,
				function (nodedField) {
					var _v1 = $mdgriffith$elm_codegen$Internal$Compiler$denode(nodedField);
					var name = _v1.a;
					var field = _v1.b;
					return $mdgriffith$elm_codegen$Internal$Compiler$getGenericsHelper(
						$mdgriffith$elm_codegen$Internal$Compiler$denode(field));
				},
				recordDefinition);
		case 'GenericRecord':
			var recordName = ann.a;
			var recordDefinition = ann.b;
			return A2(
				$elm$core$List$concatMap,
				function (nodedField) {
					var _v2 = $mdgriffith$elm_codegen$Internal$Compiler$denode(nodedField);
					var name = _v2.a;
					var field = _v2.b;
					return $mdgriffith$elm_codegen$Internal$Compiler$getGenericsHelper(
						$mdgriffith$elm_codegen$Internal$Compiler$denode(field));
				},
				$mdgriffith$elm_codegen$Internal$Compiler$denode(recordDefinition));
		default:
			var one = ann.a;
			var two = ann.b;
			return A2(
				$elm$core$List$concatMap,
				$mdgriffith$elm_codegen$Internal$Compiler$getGenericsHelper,
				_List_fromArray(
					[
						$mdgriffith$elm_codegen$Internal$Compiler$denode(one),
						$mdgriffith$elm_codegen$Internal$Compiler$denode(two)
					]));
	}
};
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
var $elm$core$List$member = F2(
	function (x, xs) {
		return A2(
			$elm$core$List$any,
			function (a) {
				return _Utils_eq(a, x);
			},
			xs);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$uniqueHelp = F4(
	function (f, existing, remaining, accumulator) {
		uniqueHelp:
		while (true) {
			if (!remaining.b) {
				return $elm$core$List$reverse(accumulator);
			} else {
				var first = remaining.a;
				var rest = remaining.b;
				var computedFirst = f(first);
				if (A2($elm$core$List$member, computedFirst, existing)) {
					var $temp$f = f,
						$temp$existing = existing,
						$temp$remaining = rest,
						$temp$accumulator = accumulator;
					f = $temp$f;
					existing = $temp$existing;
					remaining = $temp$remaining;
					accumulator = $temp$accumulator;
					continue uniqueHelp;
				} else {
					var $temp$f = f,
						$temp$existing = A2($elm$core$List$cons, computedFirst, existing),
						$temp$remaining = rest,
						$temp$accumulator = A2($elm$core$List$cons, first, accumulator);
					f = $temp$f;
					existing = $temp$existing;
					remaining = $temp$remaining;
					accumulator = $temp$accumulator;
					continue uniqueHelp;
				}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$unique = function (list) {
	return A4($mdgriffith$elm_codegen$Internal$Compiler$uniqueHelp, $elm$core$Basics$identity, _List_Nil, list, _List_Nil);
};
var $mdgriffith$elm_codegen$Internal$Compiler$getGenerics = function (_v0) {
	var details = _v0.a;
	return $mdgriffith$elm_codegen$Internal$Compiler$unique(
		$mdgriffith$elm_codegen$Internal$Compiler$getGenericsHelper(details.annotation));
};
var $mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation = function (_v0) {
	var details = _v0.a;
	return details.annotation;
};
var $stil4m$elm_syntax$Elm$Syntax$Node$Node = F2(
	function (a, b) {
		return {$: 'Node', a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange = {
	end: {column: 0, row: 0},
	start: {column: 0, row: 0}
};
var $mdgriffith$elm_codegen$Internal$Compiler$nodify = function (exp) {
	return A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, exp);
};
var $mdgriffith$elm_codegen$Elm$alias = F2(
	function (name, innerAnnotation) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Declaration(
			{
				docs: $elm$core$Maybe$Nothing,
				exposed: $mdgriffith$elm_codegen$Internal$Compiler$NotExposed,
				imports: $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports(innerAnnotation),
				name: name,
				toBody: function (index) {
					return {
						additionalImports: _List_Nil,
						declaration: $stil4m$elm_syntax$Elm$Syntax$Declaration$AliasDeclaration(
							{
								documentation: $elm$core$Maybe$Nothing,
								generics: A2(
									$elm$core$List$map,
									$mdgriffith$elm_codegen$Internal$Compiler$nodify,
									$mdgriffith$elm_codegen$Internal$Compiler$getGenerics(innerAnnotation)),
								name: $mdgriffith$elm_codegen$Internal$Compiler$nodify(
									$mdgriffith$elm_codegen$Internal$Format$formatType(name)),
								typeAnnotation: $mdgriffith$elm_codegen$Internal$Compiler$nodify(
									$mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation(innerAnnotation))
							}),
						warning: $elm$core$Maybe$Nothing
					};
				}
			});
	});
var $mdgriffith$elm_codegen$Internal$Compiler$Annotation = function (a) {
	return {$: 'Annotation', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed = F2(
	function (a, b) {
		return {$: 'Typed', a: a, b: b};
	});
var $mdgriffith$elm_codegen$Internal$Compiler$formatAliasKey = F2(
	function (mod, name) {
		return A2($elm$core$String$join, '.', mod) + ('.' + name);
	});
var $elm$core$Dict$Black = {$: 'Black'};
var $elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: 'RBNode_elm_builtin', a: a, b: b, c: c, d: d, e: e};
	});
var $elm$core$Dict$RBEmpty_elm_builtin = {$: 'RBEmpty_elm_builtin'};
var $elm$core$Dict$Red = {$: 'Red'};
var $elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Red')) {
			var _v1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
				var _v3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					key,
					value,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) && (left.d.$ === 'RBNode_elm_builtin')) && (left.d.a.$ === 'Red')) {
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
					$elm$core$Dict$Red,
					lK,
					lV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, key, value, lRight, right));
			} else {
				return A5($elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var $elm$core$Basics$compare = _Utils_compare;
var $elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _v1 = A2($elm$core$Basics$compare, key, nKey);
			switch (_v1.$) {
				case 'LT':
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3($elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 'EQ':
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
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$addAlias = F4(
	function (mod, name, ann, aliasCache) {
		var annDetails = ann.a;
		return A3(
			$elm$core$Dict$insert,
			A2($mdgriffith$elm_codegen$Internal$Compiler$formatAliasKey, mod, name),
			{
				target: annDetails.annotation,
				variables: $mdgriffith$elm_codegen$Internal$Compiler$getGenerics(ann)
			},
			aliasCache);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$getAliases = function (_v0) {
	var ann = _v0.a;
	return ann.aliases;
};
var $elm$core$Dict$foldl = F3(
	function (func, acc, dict) {
		foldl:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
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
var $elm$core$Dict$union = F2(
	function (t1, t2) {
		return A3($elm$core$Dict$foldl, $elm$core$Dict$insert, t2, t1);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$mergeAliases = $elm$core$Dict$union;
var $mdgriffith$elm_codegen$Elm$Annotation$alias = F4(
	function (mod, name, vars, target) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Annotation(
			{
				aliases: A4(
					$mdgriffith$elm_codegen$Internal$Compiler$addAlias,
					mod,
					name,
					target,
					A3(
						$elm$core$List$foldl,
						F2(
							function (ann, aliases) {
								return A2(
									$mdgriffith$elm_codegen$Internal$Compiler$mergeAliases,
									$mdgriffith$elm_codegen$Internal$Compiler$getAliases(ann),
									aliases);
							}),
						$mdgriffith$elm_codegen$Internal$Compiler$getAliases(target),
						vars)),
				annotation: A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(
						_Utils_Tuple2(
							mod,
							$mdgriffith$elm_codegen$Internal$Format$formatType(name))),
					A2(
						$elm$core$List$map,
						A2($elm$core$Basics$composeL, $mdgriffith$elm_codegen$Internal$Compiler$nodify, $mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation),
						vars)),
				imports: function () {
					if (!mod.b) {
						return A2($elm$core$List$concatMap, $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports, vars);
					} else {
						return _Utils_ap(
							_List_fromArray(
								[mod]),
							A2($elm$core$List$concatMap, $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports, vars));
					}
				}()
			});
	});
var $elm$core$Dict$empty = $elm$core$Dict$RBEmpty_elm_builtin;
var $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases = $elm$core$Dict$empty;
var $mdgriffith$elm_codegen$Elm$Annotation$getAliases = function (_v0) {
	var ann = _v0.a;
	return ann.aliases;
};
var $mdgriffith$elm_codegen$Internal$Compiler$nodifyAll = $elm$core$List$map($mdgriffith$elm_codegen$Internal$Compiler$nodify);
var $mdgriffith$elm_codegen$Elm$Annotation$typed = F3(
	function (mod, name, args) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Annotation(
			{
				aliases: A3(
					$elm$core$List$foldl,
					F2(
						function (ann, aliases) {
							return A2(
								$mdgriffith$elm_codegen$Internal$Compiler$mergeAliases,
								$mdgriffith$elm_codegen$Elm$Annotation$getAliases(ann),
								aliases);
						}),
					$mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
					args),
				annotation: A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(
						_Utils_Tuple2(mod, name)),
					$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
						A2($elm$core$List$map, $mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation, args))),
				imports: A2($elm$core$List$concatMap, $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports, args)
			});
	});
var $mdgriffith$elm_codegen$Elm$Annotation$int = A3($mdgriffith$elm_codegen$Elm$Annotation$typed, _List_Nil, 'Int', _List_Nil);
var $author$project$Gen$Http$moduleName_ = _List_fromArray(
	['Http']);
var $mdgriffith$elm_codegen$Elm$Annotation$namedWith = F3(
	function (mod, name, args) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Annotation(
			{
				aliases: A3(
					$elm$core$List$foldl,
					F2(
						function (ann, aliases) {
							return A2(
								$mdgriffith$elm_codegen$Internal$Compiler$mergeAliases,
								$mdgriffith$elm_codegen$Elm$Annotation$getAliases(ann),
								aliases);
						}),
					$mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
					args),
				annotation: A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(
						_Utils_Tuple2(
							mod,
							$mdgriffith$elm_codegen$Internal$Format$formatType(name))),
					$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
						A2($elm$core$List$map, $mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation, args))),
				imports: A2(
					$elm$core$List$cons,
					mod,
					A2($elm$core$List$concatMap, $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports, args))
			});
	});
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record = function (a) {
	return {$: 'Record', a: a};
};
var $elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var $mdgriffith$elm_codegen$Internal$Format$sanitize = function (str) {
	switch (str) {
		case 'in':
			return 'in_';
		case 'type':
			return 'type_';
		case 'case':
			return 'case_';
		case 'let':
			return 'let_';
		case 'module':
			return 'module_';
		case 'exposing':
			return 'exposing_';
		case 'where':
			return 'where_';
		case 'main':
			return 'main_';
		case 'port':
			return 'port_';
		case 'as':
			return 'as_';
		case 'if':
			return 'if_';
		case 'import':
			return 'import_';
		default:
			return str;
	}
};
var $elm$core$String$toLower = _String_toLower;
var $mdgriffith$elm_codegen$Internal$Format$formatValue = function (str) {
	var formatted = _Utils_ap(
		$elm$core$String$toLower(
			A2($elm$core$String$left, 1, str)),
		A2($elm$core$String$dropLeft, 1, str));
	return $mdgriffith$elm_codegen$Internal$Format$sanitize(formatted);
};
var $elm$core$Tuple$second = function (_v0) {
	var y = _v0.b;
	return y;
};
var $mdgriffith$elm_codegen$Elm$Annotation$record = function (fields) {
	return $mdgriffith$elm_codegen$Internal$Compiler$Annotation(
		{
			aliases: A3(
				$elm$core$List$foldl,
				F2(
					function (_v0, aliases) {
						var ann = _v0.b;
						return A2(
							$mdgriffith$elm_codegen$Internal$Compiler$mergeAliases,
							$mdgriffith$elm_codegen$Elm$Annotation$getAliases(ann),
							aliases);
					}),
				$mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
				fields),
			annotation: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(
				$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
					A2(
						$elm$core$List$map,
						function (_v1) {
							var name = _v1.a;
							var ann = _v1.b;
							return _Utils_Tuple2(
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(
									$mdgriffith$elm_codegen$Internal$Format$formatValue(name)),
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(
									$mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation(ann)));
						},
						fields))),
			imports: A2(
				$elm$core$List$concatMap,
				A2($elm$core$Basics$composeR, $elm$core$Tuple$second, $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports),
				fields)
		});
};
var $mdgriffith$elm_codegen$Elm$Annotation$string = A3($mdgriffith$elm_codegen$Elm$Annotation$typed, _List_Nil, 'String', _List_Nil);
var $author$project$Gen$Http$annotation_ = {
	body: A3(
		$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
		_List_fromArray(
			['Http']),
		'Body',
		_List_Nil),
	error: A3(
		$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
		_List_fromArray(
			['Http']),
		'Error',
		_List_Nil),
	expect: function (expectArg0) {
		return A3(
			$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
			_List_fromArray(
				['Http']),
			'Expect',
			_List_fromArray(
				[expectArg0]));
	},
	header: A3(
		$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
		_List_fromArray(
			['Http']),
		'Header',
		_List_Nil),
	metadata: A4(
		$mdgriffith$elm_codegen$Elm$Annotation$alias,
		$author$project$Gen$Http$moduleName_,
		'Metadata',
		_List_Nil,
		$mdgriffith$elm_codegen$Elm$Annotation$record(
			_List_fromArray(
				[
					_Utils_Tuple2('url', $mdgriffith$elm_codegen$Elm$Annotation$string),
					_Utils_Tuple2('statusCode', $mdgriffith$elm_codegen$Elm$Annotation$int),
					_Utils_Tuple2('statusText', $mdgriffith$elm_codegen$Elm$Annotation$string),
					_Utils_Tuple2(
					'headers',
					A3(
						$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
						_List_fromArray(
							['Dict']),
						'Dict',
						_List_fromArray(
							[$mdgriffith$elm_codegen$Elm$Annotation$string, $mdgriffith$elm_codegen$Elm$Annotation$string])))
				]))),
	part: A3(
		$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
		_List_fromArray(
			['Http']),
		'Part',
		_List_Nil),
	progress: A3(
		$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
		_List_fromArray(
			['Http']),
		'Progress',
		_List_Nil),
	resolver: F2(
		function (resolverArg0, resolverArg1) {
			return A3(
				$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
				_List_fromArray(
					['Http']),
				'Resolver',
				_List_fromArray(
					[resolverArg0, resolverArg1]));
		}),
	response: function (responseArg0) {
		return A3(
			$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
			_List_fromArray(
				['Http']),
			'Response',
			_List_fromArray(
				[responseArg0]));
	}
};
var $author$project$Gen$Json$Decode$moduleName_ = _List_fromArray(
	['Json', 'Decode']);
var $author$project$Gen$Json$Decode$annotation_ = {
	decoder: function (decoderArg0) {
		return A3(
			$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
			_List_fromArray(
				['Json', 'Decode']),
			'Decoder',
			_List_fromArray(
				[decoderArg0]));
	},
	error: A3(
		$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
		_List_fromArray(
			['Json', 'Decode']),
		'Error',
		_List_Nil),
	value: A4(
		$mdgriffith$elm_codegen$Elm$Annotation$alias,
		$author$project$Gen$Json$Decode$moduleName_,
		'Value',
		_List_Nil,
		A3(
			$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
			_List_fromArray(
				['Json', 'Encode']),
			'Value',
			_List_Nil))
};
var $author$project$Gen$Json$Encode$annotation_ = {
	value: A3(
		$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
		_List_fromArray(
			['Json', 'Encode']),
		'Value',
		_List_Nil)
};
var $author$project$Gen$Result$annotation_ = {
	result: F2(
		function (resultArg0, resultArg1) {
			return A3(
				$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
				_List_Nil,
				'Result',
				_List_fromArray(
					[resultArg0, resultArg1]));
		})
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$Application = function (a) {
	return {$: 'Application', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$FunctionAppliedToTooManyArgs = F2(
	function (a, b) {
		return {$: 'FunctionAppliedToTooManyArgs', a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType = function (a) {
	return {$: 'GenericType', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord = F2(
	function (a, b) {
		return {$: 'GenericRecord', a: a, b: b};
	});
var $mdgriffith$elm_codegen$Internal$Compiler$containsFieldByName = F2(
	function (_v0, _v2) {
		var _v1 = _v0.a;
		var oneName = _v1.b;
		var _v3 = _v2.a;
		var twoName = _v3.b;
		return _Utils_eq(oneName, twoName);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$mergeFieldLists = F2(
	function (fieldOne, fieldTwo) {
		return A3(
			$elm$core$List$foldl,
			F2(
				function (_new, existing) {
					var newField = _new.b;
					return A2(
						$elm$core$List$any,
						A2(
							$elm$core$Basics$composeL,
							$mdgriffith$elm_codegen$Internal$Compiler$containsFieldByName(newField),
							$mdgriffith$elm_codegen$Internal$Compiler$denode),
						existing) ? existing : A2($elm$core$List$cons, _new, existing);
				}),
			fieldOne,
			fieldTwo);
	});
var $elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return $elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _v1 = A2($elm$core$Basics$compare, targetKey, key);
				switch (_v1.$) {
					case 'LT':
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 'EQ':
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
var $elm$core$Dict$getMin = function (dict) {
	getMin:
	while (true) {
		if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
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
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.e.d.$ === 'RBNode_elm_builtin') && (dict.e.d.a.$ === 'Red')) {
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
				$elm$core$Dict$Red,
				rlK,
				rlV,
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					rlL),
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rlR, rRight));
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
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$moveRedRight = function (dict) {
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.d.d.$ === 'RBNode_elm_builtin') && (dict.d.d.a.$ === 'Red')) {
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
				$elm$core$Dict$Red,
				lK,
				lV,
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					lRight,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight)));
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
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$removeHelpPrepEQGT = F7(
	function (targetKey, dict, color, key, value, left, right) {
		if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
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
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, lRight, right));
		} else {
			_v2$2:
			while (true) {
				if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Black')) {
					if (right.d.$ === 'RBNode_elm_builtin') {
						if (right.d.a.$ === 'Black') {
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
	if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
		var color = dict.a;
		var key = dict.b;
		var value = dict.c;
		var left = dict.d;
		var lColor = left.a;
		var lLeft = left.d;
		var right = dict.e;
		if (lColor.$ === 'Black') {
			if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
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
				if (_v4.$ === 'RBNode_elm_builtin') {
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
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		} else {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_cmp(targetKey, key) < 0) {
				if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Black')) {
					var _v4 = left.a;
					var lLeft = left.d;
					if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
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
						if (_v7.$ === 'RBNode_elm_builtin') {
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
		if (dict.$ === 'RBNode_elm_builtin') {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_eq(targetKey, key)) {
				var _v1 = $elm$core$Dict$getMin(right);
				if (_v1.$ === 'RBNode_elm_builtin') {
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
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $elm$core$Dict$update = F3(
	function (targetKey, alter, dictionary) {
		var _v0 = alter(
			A2($elm$core$Dict$get, targetKey, dictionary));
		if (_v0.$ === 'Just') {
			var value = _v0.a;
			return A3($elm$core$Dict$insert, targetKey, value, dictionary);
		} else {
			return A2($elm$core$Dict$remove, targetKey, dictionary);
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$addInference = F3(
	function (key, value, infs) {
		return A3(
			$elm$core$Dict$update,
			key,
			function (maybeValue) {
				if (maybeValue.$ === 'Nothing') {
					return $elm$core$Maybe$Just(value);
				} else {
					if (maybeValue.a.$ === 'GenericRecord') {
						var _v1 = maybeValue.a;
						var _v2 = _v1.a;
						var range = _v2.a;
						var recordName = _v2.b;
						var _v3 = _v1.b;
						var fieldRange = _v3.a;
						var fields = _v3.b;
						if (value.$ === 'GenericRecord') {
							var _v5 = value.a;
							var existingRange = _v5.a;
							var existingRecordName = _v5.b;
							var _v6 = value.b;
							var existingFieldRange = _v6.a;
							var existingFields = _v6.b;
							return $elm$core$Maybe$Just(
								A2(
									$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord,
									A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, range, recordName),
									A2(
										$stil4m$elm_syntax$Elm$Syntax$Node$Node,
										fieldRange,
										A2($mdgriffith$elm_codegen$Internal$Compiler$mergeFieldLists, fields, existingFields))));
						} else {
							return maybeValue;
						}
					} else {
						var existing = maybeValue.a;
						return $elm$core$Maybe$Just(existing);
					}
				}
			},
			infs);
	});
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation = F2(
	function (a, b) {
		return {$: 'FunctionTypeAnnotation', a: a, b: b};
	});
var $mdgriffith$elm_codegen$Internal$Compiler$makeFunctionReversedHelper = F2(
	function (last, reversedArgs) {
		makeFunctionReversedHelper:
		while (true) {
			if (!reversedArgs.b) {
				return last;
			} else {
				if (!reversedArgs.b.b) {
					var penUlt = reversedArgs.a;
					return A2(
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
						A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, penUlt),
						A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, last));
				} else {
					var penUlt = reversedArgs.a;
					var remain = reversedArgs.b;
					var $temp$last = A2(
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
						A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, penUlt),
						A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, last)),
						$temp$reversedArgs = remain;
					last = $temp$last;
					reversedArgs = $temp$reversedArgs;
					continue makeFunctionReversedHelper;
				}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$makeFunction = F2(
	function (result, args) {
		return A2(
			$mdgriffith$elm_codegen$Internal$Compiler$makeFunctionReversedHelper,
			result,
			$elm$core$List$reverse(args));
	});
var $mdgriffith$elm_codegen$Internal$Compiler$MismatchedTypeVariables = {$: 'MismatchedTypeVariables'};
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled = function (a) {
	return {$: 'Tupled', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify = F2(
	function (a, b) {
		return {$: 'UnableToUnify', a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Unit = {$: 'Unit'};
var $elm$core$Set$Set_elm_builtin = function (a) {
	return {$: 'Set_elm_builtin', a: a};
};
var $elm$core$Set$empty = $elm$core$Set$Set_elm_builtin($elm$core$Dict$empty);
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
var $mdgriffith$elm_codegen$Internal$Compiler$getAlias = F2(
	function (_v0, cache) {
		var _v1 = _v0.b;
		var modName = _v1.a;
		var name = _v1.b;
		return A2(
			$elm$core$Dict$get,
			A2($mdgriffith$elm_codegen$Internal$Compiler$formatAliasKey, modName, name),
			cache);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$CouldNotFindField = function (a) {
	return {$: 'CouldNotFindField', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$getField = F4(
	function (name, val, fields, captured) {
		getField:
		while (true) {
			if (!fields.b) {
				return $elm$core$Result$Err(
					$mdgriffith$elm_codegen$Internal$Compiler$CouldNotFindField(
						{
							existingFields: A2(
								$elm$core$List$map,
								A2(
									$elm$core$Basics$composeR,
									$mdgriffith$elm_codegen$Internal$Compiler$denode,
									A2($elm$core$Basics$composeR, $elm$core$Tuple$first, $mdgriffith$elm_codegen$Internal$Compiler$denode)),
								captured),
							field: name
						}));
			} else {
				var top = fields.a;
				var remain = fields.b;
				var _v1 = $mdgriffith$elm_codegen$Internal$Compiler$denode(top);
				var topFieldName = _v1.a;
				var topFieldVal = _v1.b;
				var topName = $mdgriffith$elm_codegen$Internal$Compiler$denode(topFieldName);
				var topVal = $mdgriffith$elm_codegen$Internal$Compiler$denode(topFieldVal);
				if (_Utils_eq(topName, name)) {
					return $elm$core$Result$Ok(
						_Utils_Tuple2(
							topVal,
							_Utils_ap(captured, remain)));
				} else {
					var $temp$name = name,
						$temp$val = val,
						$temp$fields = remain,
						$temp$captured = A2($elm$core$List$cons, top, captured);
					name = $temp$name;
					val = $temp$val;
					fields = $temp$fields;
					captured = $temp$captured;
					continue getField;
				}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$isAppendable = function (annotation) {
	_v0$2:
	while (true) {
		if ((annotation.$ === 'Typed') && (!annotation.a.b.a.b)) {
			switch (annotation.a.b.b) {
				case 'String':
					var _v1 = annotation.a;
					var _v2 = _v1.b;
					return true;
				case 'List':
					if (annotation.b.b && (!annotation.b.b.b)) {
						var _v3 = annotation.a;
						var _v4 = _v3.b;
						var _v5 = annotation.b;
						var _v6 = _v5.a;
						var inner = _v6.b;
						return true;
					} else {
						break _v0$2;
					}
				default:
					break _v0$2;
			}
		} else {
			break _v0$2;
		}
	}
	return false;
};
var $elm$core$Basics$not = _Basics_not;
var $elm$core$List$all = F2(
	function (isOkay, list) {
		return !A2(
			$elm$core$List$any,
			A2($elm$core$Basics$composeL, $elm$core$Basics$not, isOkay),
			list);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$isComparable = function (annotation) {
	isComparable:
	while (true) {
		_v0$6:
		while (true) {
			switch (annotation.$) {
				case 'Typed':
					if (annotation.a.b.a.b) {
						if (((annotation.a.b.a.a === 'Char') && (!annotation.a.b.a.b.b)) && (annotation.a.b.b === 'Char')) {
							var _v5 = annotation.a;
							var _v6 = _v5.b;
							var _v7 = _v6.a;
							return true;
						} else {
							break _v0$6;
						}
					} else {
						switch (annotation.a.b.b) {
							case 'Int':
								var _v1 = annotation.a;
								var _v2 = _v1.b;
								return true;
							case 'Float':
								var _v3 = annotation.a;
								var _v4 = _v3.b;
								return true;
							case 'String':
								var _v8 = annotation.a;
								var _v9 = _v8.b;
								return true;
							case 'List':
								if (annotation.b.b && (!annotation.b.b.b)) {
									var _v10 = annotation.a;
									var _v11 = _v10.b;
									var _v12 = annotation.b;
									var _v13 = _v12.a;
									var inner = _v13.b;
									var $temp$annotation = inner;
									annotation = $temp$annotation;
									continue isComparable;
								} else {
									break _v0$6;
								}
							default:
								break _v0$6;
						}
					}
				case 'Tupled':
					var innerList = annotation.a;
					return A2(
						$elm$core$List$all,
						A2($elm$core$Basics$composeL, $mdgriffith$elm_codegen$Internal$Compiler$isComparable, $mdgriffith$elm_codegen$Internal$Compiler$denode),
						innerList);
				default:
					break _v0$6;
			}
		}
		return false;
	}
};
var $mdgriffith$elm_codegen$Internal$Compiler$isNumber = function (annotation) {
	_v0$2:
	while (true) {
		if ((annotation.$ === 'Typed') && (!annotation.a.b.a.b)) {
			switch (annotation.a.b.b) {
				case 'Int':
					var _v1 = annotation.a;
					var _v2 = _v1.b;
					return true;
				case 'Float':
					var _v3 = annotation.a;
					var _v4 = _v3.b;
					return true;
				default:
					break _v0$2;
			}
		} else {
			break _v0$2;
		}
	}
	return false;
};
var $elm$core$Bitwise$and = _Bitwise_and;
var $elm$core$Bitwise$shiftRightBy = _Bitwise_shiftRightBy;
var $elm$core$String$repeatHelp = F3(
	function (n, chunk, result) {
		return (n <= 0) ? result : A3(
			$elm$core$String$repeatHelp,
			n >> 1,
			_Utils_ap(chunk, chunk),
			(!(n & 1)) ? result : _Utils_ap(result, chunk));
	});
var $elm$core$String$repeat = F2(
	function (n, chunk) {
		return A3($elm$core$String$repeatHelp, n, chunk, '');
	});
var $stil4m$structured_writer$StructuredWriter$asIndent = function (amount) {
	return A2($elm$core$String$repeat, amount, ' ');
};
var $elm$core$String$concat = function (strings) {
	return A2($elm$core$String$join, '', strings);
};
var $stil4m$structured_writer$StructuredWriter$writeIndented = F2(
	function (indent_, w) {
		switch (w.$) {
			case 'Sep':
				var _v1 = w.a;
				var pre = _v1.a;
				var sep = _v1.b;
				var post = _v1.c;
				var differentLines = w.b;
				var items = w.c;
				var seperator = differentLines ? ('\n' + ($stil4m$structured_writer$StructuredWriter$asIndent(indent_) + sep)) : sep;
				return $elm$core$String$concat(
					_List_fromArray(
						[
							pre,
							A2(
							$elm$core$String$join,
							seperator,
							A2(
								$elm$core$List$map,
								A2(
									$elm$core$Basics$composeR,
									$elm$core$Basics$identity,
									$stil4m$structured_writer$StructuredWriter$writeIndented(indent_)),
								items)),
							post
						]));
			case 'Breaked':
				var items = w.a;
				return A2(
					$elm$core$String$join,
					'\n' + $stil4m$structured_writer$StructuredWriter$asIndent(indent_),
					A2(
						$elm$core$List$concatMap,
						A2(
							$elm$core$Basics$composeR,
							$stil4m$structured_writer$StructuredWriter$writeIndented(0),
							$elm$core$String$split('\n')),
						items));
			case 'Str':
				var s = w.a;
				return s;
			case 'Indent':
				var n = w.a;
				var next = w.b;
				return _Utils_ap(
					$stil4m$structured_writer$StructuredWriter$asIndent(n + indent_),
					A2($stil4m$structured_writer$StructuredWriter$writeIndented, n + indent_, next));
			case 'Spaced':
				var items = w.a;
				return A2(
					$elm$core$String$join,
					' ',
					A2(
						$elm$core$List$map,
						$stil4m$structured_writer$StructuredWriter$writeIndented(indent_),
						items));
			case 'Joined':
				var items = w.a;
				return $elm$core$String$concat(
					A2(
						$elm$core$List$map,
						$stil4m$structured_writer$StructuredWriter$writeIndented(indent_),
						items));
			default:
				var x = w.a;
				var y = w.b;
				return _Utils_ap(
					A2($stil4m$structured_writer$StructuredWriter$writeIndented, indent_, x),
					A2($stil4m$structured_writer$StructuredWriter$writeIndented, indent_, y));
		}
	});
var $stil4m$structured_writer$StructuredWriter$write = $stil4m$structured_writer$StructuredWriter$writeIndented(0);
var $stil4m$elm_syntax$Elm$Writer$write = $stil4m$structured_writer$StructuredWriter$write;
var $stil4m$structured_writer$StructuredWriter$Sep = F3(
	function (a, b, c) {
		return {$: 'Sep', a: a, b: b, c: c};
	});
var $stil4m$structured_writer$StructuredWriter$bracesComma = $stil4m$structured_writer$StructuredWriter$Sep(
	_Utils_Tuple3('{', ', ', '}'));
var $stil4m$structured_writer$StructuredWriter$Joined = function (a) {
	return {$: 'Joined', a: a};
};
var $stil4m$structured_writer$StructuredWriter$join = $stil4m$structured_writer$StructuredWriter$Joined;
var $stil4m$structured_writer$StructuredWriter$parensComma = $stil4m$structured_writer$StructuredWriter$Sep(
	_Utils_Tuple3('(', ', ', ')'));
var $elm$core$String$contains = _String_contains;
var $stil4m$structured_writer$StructuredWriter$Str = function (a) {
	return {$: 'Str', a: a};
};
var $stil4m$structured_writer$StructuredWriter$string = $stil4m$structured_writer$StructuredWriter$Str;
var $stil4m$elm_syntax$Elm$Writer$parensIfContainsSpaces = function (w) {
	return A2(
		$elm$core$String$contains,
		' ',
		$stil4m$structured_writer$StructuredWriter$write(w)) ? $stil4m$structured_writer$StructuredWriter$join(
		_List_fromArray(
			[
				$stil4m$structured_writer$StructuredWriter$string('('),
				w,
				$stil4m$structured_writer$StructuredWriter$string(')')
			])) : w;
};
var $stil4m$structured_writer$StructuredWriter$sepByComma = $stil4m$structured_writer$StructuredWriter$Sep(
	_Utils_Tuple3('', ', ', ''));
var $stil4m$structured_writer$StructuredWriter$Spaced = function (a) {
	return {$: 'Spaced', a: a};
};
var $stil4m$structured_writer$StructuredWriter$spaced = $stil4m$structured_writer$StructuredWriter$Spaced;
var $stil4m$elm_syntax$Elm$Writer$writeRecordField = function (_v4) {
	var _v5 = _v4.b;
	var name = _v5.a;
	var ref = _v5.b;
	return $stil4m$structured_writer$StructuredWriter$spaced(
		_List_fromArray(
			[
				$stil4m$structured_writer$StructuredWriter$string(
				$stil4m$elm_syntax$Elm$Syntax$Node$value(name)),
				$stil4m$structured_writer$StructuredWriter$string(':'),
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(ref)
			]));
};
var $stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation = function (_v0) {
	var typeAnnotation = _v0.b;
	switch (typeAnnotation.$) {
		case 'GenericType':
			var s = typeAnnotation.a;
			return $stil4m$structured_writer$StructuredWriter$string(s);
		case 'Typed':
			var moduleNameAndName = typeAnnotation.a;
			var args = typeAnnotation.b;
			var moduleName = $stil4m$elm_syntax$Elm$Syntax$Node$value(moduleNameAndName).a;
			var k = $stil4m$elm_syntax$Elm$Syntax$Node$value(moduleNameAndName).b;
			return $stil4m$structured_writer$StructuredWriter$spaced(
				A2(
					$elm$core$List$cons,
					$stil4m$structured_writer$StructuredWriter$string(
						A2(
							$elm$core$String$join,
							'.',
							_Utils_ap(
								moduleName,
								_List_fromArray(
									[k])))),
					A2(
						$elm$core$List$map,
						A2($elm$core$Basics$composeR, $stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation, $stil4m$elm_syntax$Elm$Writer$parensIfContainsSpaces),
						args)));
		case 'Unit':
			return $stil4m$structured_writer$StructuredWriter$string('()');
		case 'Tupled':
			var xs = typeAnnotation.a;
			return A2(
				$stil4m$structured_writer$StructuredWriter$parensComma,
				false,
				A2($elm$core$List$map, $stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation, xs));
		case 'Record':
			var xs = typeAnnotation.a;
			return A2(
				$stil4m$structured_writer$StructuredWriter$bracesComma,
				false,
				A2($elm$core$List$map, $stil4m$elm_syntax$Elm$Writer$writeRecordField, xs));
		case 'GenericRecord':
			var name = typeAnnotation.a;
			var fields = typeAnnotation.b;
			return $stil4m$structured_writer$StructuredWriter$spaced(
				_List_fromArray(
					[
						$stil4m$structured_writer$StructuredWriter$string('{'),
						$stil4m$structured_writer$StructuredWriter$string(
						$stil4m$elm_syntax$Elm$Syntax$Node$value(name)),
						$stil4m$structured_writer$StructuredWriter$string('|'),
						A2(
						$stil4m$structured_writer$StructuredWriter$sepByComma,
						false,
						A2(
							$elm$core$List$map,
							$stil4m$elm_syntax$Elm$Writer$writeRecordField,
							$stil4m$elm_syntax$Elm$Syntax$Node$value(fields))),
						$stil4m$structured_writer$StructuredWriter$string('}')
					]));
		default:
			var left = typeAnnotation.a;
			var right = typeAnnotation.b;
			var addParensForSubTypeAnnotation = function (type_) {
				if (type_.b.$ === 'FunctionTypeAnnotation') {
					var _v3 = type_.b;
					return $stil4m$structured_writer$StructuredWriter$join(
						_List_fromArray(
							[
								$stil4m$structured_writer$StructuredWriter$string('('),
								$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(type_),
								$stil4m$structured_writer$StructuredWriter$string(')')
							]));
				} else {
					return $stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(type_);
				}
			};
			return $stil4m$structured_writer$StructuredWriter$spaced(
				_List_fromArray(
					[
						addParensForSubTypeAnnotation(left),
						$stil4m$structured_writer$StructuredWriter$string('->'),
						addParensForSubTypeAnnotation(right)
					]));
	}
};
var $mdgriffith$elm_codegen$Internal$Compiler$checkRestrictions = F2(
	function (restrictions, type_) {
		switch (restrictions.$) {
			case 'NoRestrictions':
				return $elm$core$Result$Ok(type_);
			case 'Overconstrainted':
				var constraints = restrictions.a;
				return $elm$core$Result$Err(
					$stil4m$elm_syntax$Elm$Writer$write(
						$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
							$mdgriffith$elm_codegen$Internal$Compiler$nodify(type_))) + (' needs to be: ' + (A2(
						$elm$core$String$join,
						', ',
						A2(
							$elm$core$List$concatMap,
							function (constraint) {
								switch (constraint.$) {
									case 'NoRestrictions':
										return _List_Nil;
									case 'Overconstrainted':
										return _List_Nil;
									case 'IsNumber':
										return _List_fromArray(
											['a number']);
									case 'IsComparable':
										return _List_fromArray(
											['comparable']);
									case 'IsAppendable':
										return _List_fromArray(
											['appendable']);
									default:
										return _List_fromArray(
											['appendable and comparable']);
								}
							},
							constraints)) + '\n\nbut that\'s impossible!  Or Elm Codegen\'s s typechecker is off.')));
			case 'IsNumber':
				return $mdgriffith$elm_codegen$Internal$Compiler$isNumber(type_) ? $elm$core$Result$Ok(type_) : $elm$core$Result$Err(
					$stil4m$elm_syntax$Elm$Writer$write(
						$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
							$mdgriffith$elm_codegen$Internal$Compiler$nodify(type_))) + ' is not a number');
			case 'IsComparable':
				return $mdgriffith$elm_codegen$Internal$Compiler$isComparable(type_) ? $elm$core$Result$Ok(type_) : $elm$core$Result$Err(
					$stil4m$elm_syntax$Elm$Writer$write(
						$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
							$mdgriffith$elm_codegen$Internal$Compiler$nodify(type_))) + ' is not comparable.  Only Ints, Floats, Chars, Strings and Lists and Tuples of those things are comparable.');
			case 'IsAppendable':
				return $mdgriffith$elm_codegen$Internal$Compiler$isAppendable(type_) ? $elm$core$Result$Ok(type_) : $elm$core$Result$Err(
					$stil4m$elm_syntax$Elm$Writer$write(
						$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
							$mdgriffith$elm_codegen$Internal$Compiler$nodify(type_))) + ' is not appendable.  Only Strings and Lists are appendable.');
			default:
				return ($mdgriffith$elm_codegen$Internal$Compiler$isComparable(type_) || $mdgriffith$elm_codegen$Internal$Compiler$isAppendable(type_)) ? $elm$core$Result$Ok(type_) : $elm$core$Result$Err(
					$stil4m$elm_syntax$Elm$Writer$write(
						$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
							$mdgriffith$elm_codegen$Internal$Compiler$nodify(type_))) + ' is not appendable/comparable.  Only Strings and Lists are allowed here.');
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$NoRestrictions = {$: 'NoRestrictions'};
var $mdgriffith$elm_codegen$Internal$Compiler$IsAppendable = {$: 'IsAppendable'};
var $mdgriffith$elm_codegen$Internal$Compiler$IsAppendableComparable = {$: 'IsAppendableComparable'};
var $mdgriffith$elm_codegen$Internal$Compiler$IsComparable = {$: 'IsComparable'};
var $mdgriffith$elm_codegen$Internal$Compiler$IsNumber = {$: 'IsNumber'};
var $elm$core$String$startsWith = _String_startsWith;
var $mdgriffith$elm_codegen$Internal$Compiler$nameToRestrictions = function (name) {
	return A2($elm$core$String$startsWith, 'number', name) ? $mdgriffith$elm_codegen$Internal$Compiler$IsNumber : (A2($elm$core$String$startsWith, 'comparable', name) ? $mdgriffith$elm_codegen$Internal$Compiler$IsComparable : (A2($elm$core$String$startsWith, 'appendable', name) ? $mdgriffith$elm_codegen$Internal$Compiler$IsAppendable : (A2($elm$core$String$startsWith, 'compappend', name) ? $mdgriffith$elm_codegen$Internal$Compiler$IsAppendableComparable : $mdgriffith$elm_codegen$Internal$Compiler$NoRestrictions)));
};
var $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted = function (a) {
	return {$: 'Overconstrainted', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$restrictFurther = F2(
	function (restriction, newRestriction) {
		switch (restriction.$) {
			case 'NoRestrictions':
				return newRestriction;
			case 'Overconstrainted':
				var constraints = restriction.a;
				switch (newRestriction.$) {
					case 'Overconstrainted':
						var newConstraints = newRestriction.a;
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							_Utils_ap(constraints, newConstraints));
					case 'NoRestrictions':
						return restriction;
					default:
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							A2($elm$core$List$cons, newRestriction, constraints));
				}
			case 'IsNumber':
				switch (newRestriction.$) {
					case 'IsNumber':
						return newRestriction;
					case 'NoRestrictions':
						return restriction;
					case 'Overconstrainted':
						var constraints = newRestriction.a;
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							A2($elm$core$List$cons, restriction, constraints));
					default:
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							_List_fromArray(
								[restriction, newRestriction]));
				}
			case 'IsComparable':
				switch (newRestriction.$) {
					case 'NoRestrictions':
						return restriction;
					case 'IsAppendableComparable':
						return newRestriction;
					case 'IsComparable':
						return newRestriction;
					case 'Overconstrainted':
						var constraints = newRestriction.a;
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							A2($elm$core$List$cons, restriction, constraints));
					default:
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							_List_fromArray(
								[restriction, newRestriction]));
				}
			case 'IsAppendable':
				switch (newRestriction.$) {
					case 'NoRestrictions':
						return restriction;
					case 'IsAppendableComparable':
						return newRestriction;
					case 'IsComparable':
						return newRestriction;
					case 'Overconstrainted':
						var constraints = newRestriction.a;
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							A2($elm$core$List$cons, restriction, constraints));
					default:
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							_List_fromArray(
								[restriction, newRestriction]));
				}
			default:
				switch (newRestriction.$) {
					case 'NoRestrictions':
						return restriction;
					case 'IsAppendableComparable':
						return newRestriction;
					case 'IsComparable':
						return newRestriction;
					case 'IsAppendable':
						return newRestriction;
					case 'Overconstrainted':
						var constraints = newRestriction.a;
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							A2($elm$core$List$cons, restriction, constraints));
					default:
						return $mdgriffith$elm_codegen$Internal$Compiler$Overconstrainted(
							_List_fromArray(
								[restriction, newRestriction]));
				}
		}
	});
var $elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$getRestrictionsHelper = F3(
	function (existingRestrictions, notation, cache) {
		getRestrictionsHelper:
		while (true) {
			switch (notation.$) {
				case 'FunctionTypeAnnotation':
					var _v1 = notation.a;
					var oneCoords = _v1.a;
					var one = _v1.b;
					var _v2 = notation.b;
					var twoCoords = _v2.a;
					var two = _v2.b;
					return existingRestrictions;
				case 'GenericType':
					var name = notation.a;
					var $temp$existingRestrictions = A2(
						$mdgriffith$elm_codegen$Internal$Compiler$restrictFurther,
						existingRestrictions,
						$mdgriffith$elm_codegen$Internal$Compiler$nameToRestrictions(name)),
						$temp$notation = A2(
						$elm$core$Maybe$withDefault,
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Unit,
						A2($elm$core$Dict$get, name, cache)),
						$temp$cache = cache;
					existingRestrictions = $temp$existingRestrictions;
					notation = $temp$notation;
					cache = $temp$cache;
					continue getRestrictionsHelper;
				case 'Typed':
					var nodedModuleName = notation.a;
					var vars = notation.b;
					return existingRestrictions;
				case 'Unit':
					return existingRestrictions;
				case 'Tupled':
					var nodes = notation.a;
					return existingRestrictions;
				case 'Record':
					var fields = notation.a;
					return existingRestrictions;
				default:
					var baseName = notation.a;
					var _v3 = notation.b;
					var recordNode = _v3.a;
					var fields = _v3.b;
					return existingRestrictions;
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$getRestrictions = F2(
	function (notation, cache) {
		return A3($mdgriffith$elm_codegen$Internal$Compiler$getRestrictionsHelper, $mdgriffith$elm_codegen$Internal$Compiler$NoRestrictions, notation, cache);
	});
var $elm$core$Set$insert = F2(
	function (key, _v0) {
		var dict = _v0.a;
		return $elm$core$Set$Set_elm_builtin(
			A3($elm$core$Dict$insert, key, _Utils_Tuple0, dict));
	});
var $elm$core$Result$map = F2(
	function (func, ra) {
		if (ra.$ === 'Ok') {
			var a = ra.a;
			return $elm$core$Result$Ok(
				func(a));
		} else {
			var e = ra.a;
			return $elm$core$Result$Err(e);
		}
	});
var $elm$core$Result$map2 = F3(
	function (func, ra, rb) {
		if (ra.$ === 'Err') {
			var x = ra.a;
			return $elm$core$Result$Err(x);
		} else {
			var a = ra.a;
			if (rb.$ === 'Err') {
				var x = rb.a;
				return $elm$core$Result$Err(x);
			} else {
				var b = rb.a;
				return $elm$core$Result$Ok(
					A2(func, a, b));
			}
		}
	});
var $elm$core$Dict$member = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$get, key, dict);
		if (_v0.$ === 'Just') {
			return true;
		} else {
			return false;
		}
	});
var $elm$core$Set$member = F2(
	function (key, _v0) {
		var dict = _v0.a;
		return A2($elm$core$Dict$member, key, dict);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$resolveVariableList = F4(
	function (visited, cache, nodes, processed) {
		resolveVariableList:
		while (true) {
			if (!nodes.b) {
				return $elm$core$Result$Ok(
					$elm$core$List$reverse(processed));
			} else {
				var _v17 = nodes.a;
				var coords = _v17.a;
				var top = _v17.b;
				var remain = nodes.b;
				var _v18 = A3($mdgriffith$elm_codegen$Internal$Compiler$resolveVariables, visited, cache, top);
				if (_v18.$ === 'Ok') {
					var resolved = _v18.a;
					var $temp$visited = visited,
						$temp$cache = cache,
						$temp$nodes = remain,
						$temp$processed = A2(
						$elm$core$List$cons,
						A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, coords, resolved),
						processed);
					visited = $temp$visited;
					cache = $temp$cache;
					nodes = $temp$nodes;
					processed = $temp$processed;
					continue resolveVariableList;
				} else {
					var err = _v18.a;
					return $elm$core$Result$Err(err);
				}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$resolveVariables = F3(
	function (visited, cache, annotation) {
		resolveVariables:
		while (true) {
			switch (annotation.$) {
				case 'FunctionTypeAnnotation':
					var _v1 = annotation.a;
					var oneCoords = _v1.a;
					var one = _v1.b;
					var _v2 = annotation.b;
					var twoCoords = _v2.a;
					var two = _v2.b;
					return A3(
						$elm$core$Result$map2,
						F2(
							function (oneResolved, twoResolved) {
								return A2(
									$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
									A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, oneCoords, oneResolved),
									A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, twoCoords, twoResolved));
							}),
						A3($mdgriffith$elm_codegen$Internal$Compiler$resolveVariables, visited, cache, one),
						A3($mdgriffith$elm_codegen$Internal$Compiler$resolveVariables, visited, cache, two));
				case 'GenericType':
					var name = annotation.a;
					if (A2($elm$core$Set$member, name, visited)) {
						return $elm$core$Result$Err('Infinite type inference loop!  Whoops.  This is an issue with elm-codegen.  If you can report this to the elm-codegen repo, that would be appreciated!');
					} else {
						var _v3 = A2($elm$core$Dict$get, name, cache);
						if (_v3.$ === 'Nothing') {
							return $elm$core$Result$Ok(annotation);
						} else {
							var newType = _v3.a;
							var $temp$visited = A2($elm$core$Set$insert, name, visited),
								$temp$cache = cache,
								$temp$annotation = newType;
							visited = $temp$visited;
							cache = $temp$cache;
							annotation = $temp$annotation;
							continue resolveVariables;
						}
					}
				case 'Typed':
					var nodedModuleName = annotation.a;
					var vars = annotation.b;
					return A2(
						$elm$core$Result$map,
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed(nodedModuleName),
						A4($mdgriffith$elm_codegen$Internal$Compiler$resolveVariableList, visited, cache, vars, _List_Nil));
				case 'Unit':
					return $elm$core$Result$Ok($stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Unit);
				case 'Tupled':
					var nodes = annotation.a;
					return A2(
						$elm$core$Result$map,
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled,
						A4($mdgriffith$elm_codegen$Internal$Compiler$resolveVariableList, visited, cache, nodes, _List_Nil));
				case 'Record':
					var fields = annotation.a;
					return A2(
						$elm$core$Result$map,
						A2($elm$core$Basics$composeL, $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record, $elm$core$List$reverse),
						A3(
							$elm$core$List$foldl,
							F2(
								function (_v4, found) {
									var fieldRange = _v4.a;
									var _v5 = _v4.b;
									var name = _v5.a;
									var _v6 = _v5.b;
									var fieldTypeRange = _v6.a;
									var fieldType = _v6.b;
									if (found.$ === 'Err') {
										var err = found.a;
										return $elm$core$Result$Err(err);
									} else {
										var processedFields = found.a;
										var _v8 = A3($mdgriffith$elm_codegen$Internal$Compiler$resolveVariables, visited, cache, fieldType);
										if (_v8.$ === 'Err') {
											var err = _v8.a;
											return $elm$core$Result$Err(err);
										} else {
											var resolvedField = _v8.a;
											var restrictions = A2($mdgriffith$elm_codegen$Internal$Compiler$getRestrictions, annotation, cache);
											var _v9 = A2($mdgriffith$elm_codegen$Internal$Compiler$checkRestrictions, restrictions, resolvedField);
											if (_v9.$ === 'Ok') {
												return $elm$core$Result$Ok(
													A2(
														$elm$core$List$cons,
														A2(
															$stil4m$elm_syntax$Elm$Syntax$Node$Node,
															fieldRange,
															_Utils_Tuple2(
																name,
																A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, fieldTypeRange, resolvedField))),
														processedFields));
											} else {
												var err = _v9.a;
												return $elm$core$Result$Err(err);
											}
										}
									}
								}),
							$elm$core$Result$Ok(_List_Nil),
							fields));
				default:
					var baseName = annotation.a;
					var _v10 = annotation.b;
					var recordNode = _v10.a;
					var fields = _v10.b;
					var newFieldResult = A3(
						$elm$core$List$foldl,
						F2(
							function (_v11, found) {
								var fieldRange = _v11.a;
								var _v12 = _v11.b;
								var name = _v12.a;
								var _v13 = _v12.b;
								var fieldTypeRange = _v13.a;
								var fieldType = _v13.b;
								if (found.$ === 'Err') {
									var err = found.a;
									return $elm$core$Result$Err(err);
								} else {
									var processedFields = found.a;
									var _v15 = A3($mdgriffith$elm_codegen$Internal$Compiler$resolveVariables, visited, cache, fieldType);
									if (_v15.$ === 'Err') {
										var err = _v15.a;
										return $elm$core$Result$Err(err);
									} else {
										var resolvedField = _v15.a;
										var restrictions = A2($mdgriffith$elm_codegen$Internal$Compiler$getRestrictions, annotation, cache);
										return $elm$core$Result$Ok(
											A2(
												$elm$core$List$cons,
												A2(
													$stil4m$elm_syntax$Elm$Syntax$Node$Node,
													fieldRange,
													_Utils_Tuple2(
														name,
														A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, fieldTypeRange, resolvedField))),
												processedFields));
									}
								}
							}),
						$elm$core$Result$Ok(_List_Nil),
						fields);
					return A2(
						$elm$core$Result$map,
						function (newFields) {
							return A2(
								$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord,
								baseName,
								A2(
									$stil4m$elm_syntax$Elm$Syntax$Node$Node,
									recordNode,
									$elm$core$List$reverse(newFields)));
						},
						newFieldResult);
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$unifiable = F4(
	function (aliases, vars, one, two) {
		unifiable:
		while (true) {
			switch (one.$) {
				case 'GenericType':
					var varName = one.a;
					var _v21 = A2($elm$core$Dict$get, varName, vars);
					if (_v21.$ === 'Nothing') {
						if (two.$ === 'GenericType') {
							var varNameB = two.a;
							return _Utils_eq(varNameB, varName) ? _Utils_Tuple2(
								vars,
								$elm$core$Result$Ok(one)) : _Utils_Tuple2(
								A3($mdgriffith$elm_codegen$Internal$Compiler$addInference, varName, two, vars),
								$elm$core$Result$Ok(two));
						} else {
							return _Utils_Tuple2(
								A3($mdgriffith$elm_codegen$Internal$Compiler$addInference, varName, two, vars),
								$elm$core$Result$Ok(two));
						}
					} else {
						var found = _v21.a;
						if (two.$ === 'GenericType') {
							var varNameB = two.a;
							if (_Utils_eq(varNameB, varName)) {
								return _Utils_Tuple2(
									vars,
									$elm$core$Result$Ok(one));
							} else {
								var _v24 = A2($elm$core$Dict$get, varNameB, vars);
								if (_v24.$ === 'Nothing') {
									return _Utils_Tuple2(
										A3($mdgriffith$elm_codegen$Internal$Compiler$addInference, varNameB, found, vars),
										$elm$core$Result$Ok(two));
								} else {
									var foundTwo = _v24.a;
									var $temp$aliases = aliases,
										$temp$vars = vars,
										$temp$one = found,
										$temp$two = foundTwo;
									aliases = $temp$aliases;
									vars = $temp$vars;
									one = $temp$one;
									two = $temp$two;
									continue unifiable;
								}
							}
						} else {
							var $temp$aliases = aliases,
								$temp$vars = vars,
								$temp$one = found,
								$temp$two = two;
							aliases = $temp$aliases;
							vars = $temp$vars;
							one = $temp$one;
							two = $temp$two;
							continue unifiable;
						}
					}
				case 'Typed':
					var oneName = one.a;
					var oneVars = one.b;
					switch (two.$) {
						case 'Typed':
							var twoName = two.a;
							var twoContents = two.b;
							if (_Utils_eq(
								$mdgriffith$elm_codegen$Internal$Compiler$denode(oneName),
								$mdgriffith$elm_codegen$Internal$Compiler$denode(twoName))) {
								var _v26 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifiableLists, aliases, vars, oneVars, twoContents, _List_Nil);
								if (_v26.b.$ === 'Ok') {
									var newVars = _v26.a;
									var unifiedContent = _v26.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Ok(
											A2($stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed, twoName, unifiedContent)));
								} else {
									var newVars = _v26.a;
									var err = _v26.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Err(err));
								}
							} else {
								return _Utils_Tuple2(
									vars,
									$elm$core$Result$Err(
										A2($mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify, one, two)));
							}
						case 'GenericType':
							var b = two.a;
							return _Utils_Tuple2(
								A3($mdgriffith$elm_codegen$Internal$Compiler$addInference, b, one, vars),
								$elm$core$Result$Ok(one));
						default:
							var _v27 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifyWithAlias, aliases, vars, oneName, oneVars, two);
							if (_v27.$ === 'Nothing') {
								return _Utils_Tuple2(
									vars,
									$elm$core$Result$Err(
										A2($mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify, one, two)));
							} else {
								var unified = _v27.a;
								return unified;
							}
					}
				case 'Unit':
					switch (two.$) {
						case 'GenericType':
							var b = two.a;
							var _v29 = A2($elm$core$Dict$get, b, vars);
							if (_v29.$ === 'Nothing') {
								return _Utils_Tuple2(
									A3($mdgriffith$elm_codegen$Internal$Compiler$addInference, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v29.a;
								var $temp$aliases = aliases,
									$temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								aliases = $temp$aliases;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiable;
							}
						case 'Unit':
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Ok($stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Unit));
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err(
									A2($mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify, one, two)));
					}
				case 'Tupled':
					var valsA = one.a;
					switch (two.$) {
						case 'GenericType':
							var b = two.a;
							var _v31 = A2($elm$core$Dict$get, b, vars);
							if (_v31.$ === 'Nothing') {
								return _Utils_Tuple2(
									A3($mdgriffith$elm_codegen$Internal$Compiler$addInference, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v31.a;
								var $temp$aliases = aliases,
									$temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								aliases = $temp$aliases;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiable;
							}
						case 'Tupled':
							var valsB = two.a;
							var _v32 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifiableLists, aliases, vars, valsA, valsB, _List_Nil);
							if (_v32.b.$ === 'Ok') {
								var newVars = _v32.a;
								var unified = _v32.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Ok(
										$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled(unified)));
							} else {
								var newVars = _v32.a;
								var err = _v32.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Err(err));
							}
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err(
									A2($mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify, one, two)));
					}
				case 'Record':
					var fieldsA = one.a;
					switch (two.$) {
						case 'GenericType':
							var b = two.a;
							var _v34 = A2($elm$core$Dict$get, b, vars);
							if (_v34.$ === 'Nothing') {
								return _Utils_Tuple2(
									A3($mdgriffith$elm_codegen$Internal$Compiler$addInference, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v34.a;
								var $temp$aliases = aliases,
									$temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								aliases = $temp$aliases;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiable;
							}
						case 'GenericRecord':
							var _v35 = two.a;
							var twoRecName = _v35.b;
							var _v36 = two.b;
							var fieldsB = _v36.b;
							var _v37 = A2($elm$core$Dict$get, twoRecName, vars);
							if (_v37.$ === 'Nothing') {
								var _v38 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifiableFields, aliases, vars, fieldsA, fieldsB, _List_Nil);
								if (_v38.b.$ === 'Ok') {
									var newVars = _v38.a;
									var unifiedFields = _v38.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Ok(
											$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(unifiedFields)));
								} else {
									var newVars = _v38.a;
									var err = _v38.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Err(err));
								}
							} else {
								var knownType = _v37.a;
								var _v39 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifiableFields, aliases, vars, fieldsA, fieldsB, _List_Nil);
								if (_v39.b.$ === 'Ok') {
									var newVars = _v39.a;
									var unifiedFields = _v39.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Ok(
											$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(unifiedFields)));
								} else {
									var newVars = _v39.a;
									var err = _v39.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Err(err));
								}
							}
						case 'Record':
							var fieldsB = two.a;
							var _v40 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifiableFields, aliases, vars, fieldsA, fieldsB, _List_Nil);
							if (_v40.b.$ === 'Ok') {
								var newVars = _v40.a;
								var unifiedFields = _v40.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Ok(
										$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(unifiedFields)));
							} else {
								var newVars = _v40.a;
								var err = _v40.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Err(err));
							}
						case 'Typed':
							var twoName = two.a;
							var twoVars = two.b;
							var _v41 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifyWithAlias, aliases, vars, twoName, twoVars, one);
							if (_v41.$ === 'Nothing') {
								return _Utils_Tuple2(
									vars,
									$elm$core$Result$Err(
										A2($mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify, one, two)));
							} else {
								var unified = _v41.a;
								return unified;
							}
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err(
									A2($mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify, one, two)));
					}
				case 'GenericRecord':
					var _v42 = one.a;
					var reVarName = _v42.b;
					var _v43 = one.b;
					var fieldsARange = _v43.a;
					var fieldsA = _v43.b;
					switch (two.$) {
						case 'GenericType':
							var b = two.a;
							var _v45 = A2($elm$core$Dict$get, b, vars);
							if (_v45.$ === 'Nothing') {
								return _Utils_Tuple2(
									A3($mdgriffith$elm_codegen$Internal$Compiler$addInference, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v45.a;
								var $temp$aliases = aliases,
									$temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								aliases = $temp$aliases;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiable;
							}
						case 'GenericRecord':
							var _v46 = two.a;
							var twoRecName = _v46.b;
							var _v47 = two.b;
							var fieldsB = _v47.b;
							var _v48 = A2($elm$core$Dict$get, twoRecName, vars);
							if (_v48.$ === 'Nothing') {
								var _v49 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifiableFields, aliases, vars, fieldsA, fieldsB, _List_Nil);
								if (_v49.b.$ === 'Ok') {
									var newVars = _v49.a;
									var unifiedFields = _v49.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Ok(
											$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(unifiedFields)));
								} else {
									var newVars = _v49.a;
									var err = _v49.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Err(err));
								}
							} else {
								var knownType = _v48.a;
								var _v50 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifiableFields, aliases, vars, fieldsA, fieldsB, _List_Nil);
								if (_v50.b.$ === 'Ok') {
									var newVars = _v50.a;
									var unifiedFields = _v50.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Ok(
											$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(unifiedFields)));
								} else {
									var newVars = _v50.a;
									var err = _v50.b.a;
									return _Utils_Tuple2(
										newVars,
										$elm$core$Result$Err(err));
								}
							}
						case 'Record':
							var fieldsB = two.a;
							var _v51 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifiableFields, aliases, vars, fieldsA, fieldsB, _List_Nil);
							if (_v51.b.$ === 'Ok') {
								var newVars = _v51.a;
								var unifiedFields = _v51.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Ok(
										$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(unifiedFields)));
							} else {
								var newVars = _v51.a;
								var err = _v51.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Err(err));
							}
						case 'Typed':
							var twoName = two.a;
							var twoVars = two.b;
							var _v52 = A5($mdgriffith$elm_codegen$Internal$Compiler$unifyWithAlias, aliases, vars, twoName, twoVars, one);
							if (_v52.$ === 'Nothing') {
								return _Utils_Tuple2(
									vars,
									$elm$core$Result$Err(
										A2($mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify, one, two)));
							} else {
								var unified = _v52.a;
								return unified;
							}
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err(
									A2($mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify, one, two)));
					}
				default:
					var oneA = one.a;
					var oneB = one.b;
					switch (two.$) {
						case 'GenericType':
							var b = two.a;
							var _v54 = A2($elm$core$Dict$get, b, vars);
							if (_v54.$ === 'Nothing') {
								return _Utils_Tuple2(
									A3($mdgriffith$elm_codegen$Internal$Compiler$addInference, b, one, vars),
									$elm$core$Result$Ok(one));
							} else {
								var foundTwo = _v54.a;
								var $temp$aliases = aliases,
									$temp$vars = vars,
									$temp$one = one,
									$temp$two = foundTwo;
								aliases = $temp$aliases;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								continue unifiable;
							}
						case 'FunctionTypeAnnotation':
							var twoA = two.a;
							var twoB = two.b;
							var _v55 = A4(
								$mdgriffith$elm_codegen$Internal$Compiler$unifiable,
								aliases,
								vars,
								$mdgriffith$elm_codegen$Internal$Compiler$denode(oneA),
								$mdgriffith$elm_codegen$Internal$Compiler$denode(twoA));
							if (_v55.b.$ === 'Ok') {
								var aVars = _v55.a;
								var unifiedA = _v55.b.a;
								var _v56 = A4(
									$mdgriffith$elm_codegen$Internal$Compiler$unifiable,
									aliases,
									aVars,
									$mdgriffith$elm_codegen$Internal$Compiler$denode(oneB),
									$mdgriffith$elm_codegen$Internal$Compiler$denode(twoB));
								if (_v56.b.$ === 'Ok') {
									var bVars = _v56.a;
									var unifiedB = _v56.b.a;
									return _Utils_Tuple2(
										bVars,
										$elm$core$Result$Ok(
											A2(
												$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
												$mdgriffith$elm_codegen$Internal$Compiler$nodify(unifiedA),
												$mdgriffith$elm_codegen$Internal$Compiler$nodify(unifiedB))));
								} else {
									var otherwise = _v56;
									return otherwise;
								}
							} else {
								var otherwise = _v55;
								return otherwise;
							}
						default:
							return _Utils_Tuple2(
								vars,
								$elm$core$Result$Err(
									A2($mdgriffith$elm_codegen$Internal$Compiler$UnableToUnify, one, two)));
					}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$unifiableFields = F5(
	function (aliases, vars, one, two, unified) {
		unifiableFields:
		while (true) {
			var _v13 = _Utils_Tuple2(one, two);
			if (!_v13.a.b) {
				if (!_v13.b.b) {
					return _Utils_Tuple2(
						vars,
						$elm$core$Result$Ok(
							$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
								$elm$core$List$reverse(unified))));
				} else {
					return _Utils_Tuple2(
						vars,
						$elm$core$Result$Err($mdgriffith$elm_codegen$Internal$Compiler$MismatchedTypeVariables));
				}
			} else {
				var _v14 = _v13.a;
				var oneX = _v14.a;
				var oneRemain = _v14.b;
				var twoFields = _v13.b;
				var _v15 = $mdgriffith$elm_codegen$Internal$Compiler$denode(oneX);
				var oneFieldName = _v15.a;
				var oneFieldVal = _v15.b;
				var oneName = $mdgriffith$elm_codegen$Internal$Compiler$denode(oneFieldName);
				var oneVal = $mdgriffith$elm_codegen$Internal$Compiler$denode(oneFieldVal);
				var _v16 = A4($mdgriffith$elm_codegen$Internal$Compiler$getField, oneName, oneVal, twoFields, _List_Nil);
				if (_v16.$ === 'Ok') {
					var _v17 = _v16.a;
					var matchingFieldVal = _v17.a;
					var remainingTwo = _v17.b;
					var _v18 = A4($mdgriffith$elm_codegen$Internal$Compiler$unifiable, aliases, vars, oneVal, matchingFieldVal);
					var newVars = _v18.a;
					var unifiedFieldResult = _v18.b;
					if (unifiedFieldResult.$ === 'Ok') {
						var unifiedField = unifiedFieldResult.a;
						var $temp$aliases = aliases,
							$temp$vars = newVars,
							$temp$one = oneRemain,
							$temp$two = remainingTwo,
							$temp$unified = A2(
							$elm$core$List$cons,
							_Utils_Tuple2(
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(oneName),
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(unifiedField)),
							unified);
						aliases = $temp$aliases;
						vars = $temp$vars;
						one = $temp$one;
						two = $temp$two;
						unified = $temp$unified;
						continue unifiableFields;
					} else {
						var err = unifiedFieldResult.a;
						return _Utils_Tuple2(
							newVars,
							$elm$core$Result$Err(err));
					}
				} else {
					var notFound = _v16.a;
					return _Utils_Tuple2(
						vars,
						$elm$core$Result$Err(notFound));
				}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$unifiableLists = F5(
	function (aliases, vars, one, two, unified) {
		unifiableLists:
		while (true) {
			var _v6 = _Utils_Tuple2(one, two);
			_v6$3:
			while (true) {
				if (!_v6.a.b) {
					if (!_v6.b.b) {
						return _Utils_Tuple2(
							vars,
							$elm$core$Result$Ok(
								$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
									$elm$core$List$reverse(unified))));
					} else {
						break _v6$3;
					}
				} else {
					if (_v6.b.b) {
						if ((!_v6.a.b.b) && (!_v6.b.b.b)) {
							var _v7 = _v6.a;
							var oneX = _v7.a;
							var _v8 = _v6.b;
							var twoX = _v8.a;
							var _v9 = A4(
								$mdgriffith$elm_codegen$Internal$Compiler$unifiable,
								aliases,
								vars,
								$mdgriffith$elm_codegen$Internal$Compiler$denode(oneX),
								$mdgriffith$elm_codegen$Internal$Compiler$denode(twoX));
							if (_v9.b.$ === 'Ok') {
								var newVars = _v9.a;
								var un = _v9.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Ok(
										$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
											$elm$core$List$reverse(
												A2($elm$core$List$cons, un, unified)))));
							} else {
								var newVars = _v9.a;
								var err = _v9.b.a;
								return _Utils_Tuple2(
									newVars,
									$elm$core$Result$Err(err));
							}
						} else {
							var _v10 = _v6.a;
							var oneX = _v10.a;
							var oneRemain = _v10.b;
							var _v11 = _v6.b;
							var twoX = _v11.a;
							var twoRemain = _v11.b;
							var _v12 = A4(
								$mdgriffith$elm_codegen$Internal$Compiler$unifiable,
								aliases,
								vars,
								$mdgriffith$elm_codegen$Internal$Compiler$denode(oneX),
								$mdgriffith$elm_codegen$Internal$Compiler$denode(twoX));
							if (_v12.b.$ === 'Ok') {
								var newVars = _v12.a;
								var un = _v12.b.a;
								var $temp$aliases = aliases,
									$temp$vars = newVars,
									$temp$one = oneRemain,
									$temp$two = twoRemain,
									$temp$unified = A2($elm$core$List$cons, un, unified);
								aliases = $temp$aliases;
								vars = $temp$vars;
								one = $temp$one;
								two = $temp$two;
								unified = $temp$unified;
								continue unifiableLists;
							} else {
								var newVars = _v12.a;
								var err = _v12.b.a;
								return _Utils_Tuple2(
									vars,
									$elm$core$Result$Err(err));
							}
						}
					} else {
						break _v6$3;
					}
				}
			}
			return _Utils_Tuple2(
				vars,
				$elm$core$Result$Err($mdgriffith$elm_codegen$Internal$Compiler$MismatchedTypeVariables));
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$unifyWithAlias = F5(
	function (aliases, vars, typename, typeVars, typeToUnifyWith) {
		var _v0 = A2($mdgriffith$elm_codegen$Internal$Compiler$getAlias, typename, aliases);
		if (_v0.$ === 'Nothing') {
			return $elm$core$Maybe$Nothing;
		} else {
			var foundAlias = _v0.a;
			var fullAliasedType = function () {
				var _v3 = foundAlias.variables;
				if (!_v3.b) {
					return foundAlias.target;
				} else {
					var makeAliasVarCache = F2(
						function (varName, _v5) {
							var varType = _v5.b;
							return _Utils_Tuple2(varName, varType);
						});
					var _v4 = A3(
						$mdgriffith$elm_codegen$Internal$Compiler$resolveVariables,
						$elm$core$Set$empty,
						$elm$core$Dict$fromList(
							A3($elm$core$List$map2, makeAliasVarCache, foundAlias.variables, typeVars)),
						foundAlias.target);
					if (_v4.$ === 'Ok') {
						var resolvedType = _v4.a;
						return resolvedType;
					} else {
						return foundAlias.target;
					}
				}
			}();
			var _v1 = A4($mdgriffith$elm_codegen$Internal$Compiler$unifiable, aliases, vars, fullAliasedType, typeToUnifyWith);
			var returnedVars = _v1.a;
			var unifiedResult = _v1.b;
			if (unifiedResult.$ === 'Ok') {
				var finalInference = unifiedResult.a;
				return $elm$core$Maybe$Just(
					_Utils_Tuple2(
						returnedVars,
						$elm$core$Result$Ok(fullAliasedType)));
			} else {
				var err = unifiedResult.a;
				return $elm$core$Maybe$Nothing;
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$applyTypeHelper = F4(
	function (aliases, cache, fn, args) {
		applyTypeHelper:
		while (true) {
			switch (fn.$) {
				case 'FunctionTypeAnnotation':
					var one = fn.a;
					var two = fn.b;
					if (!args.b) {
						return $elm$core$Result$Ok(
							{aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases, inferences: cache, type_: fn});
					} else {
						var top = args.a;
						var rest = args.b;
						var _v2 = A4(
							$mdgriffith$elm_codegen$Internal$Compiler$unifiable,
							aliases,
							cache,
							$mdgriffith$elm_codegen$Internal$Compiler$denode(one),
							top);
						if (_v2.b.$ === 'Ok') {
							var variableCache = _v2.a;
							var $temp$aliases = aliases,
								$temp$cache = variableCache,
								$temp$fn = $mdgriffith$elm_codegen$Internal$Compiler$denode(two),
								$temp$args = rest;
							aliases = $temp$aliases;
							cache = $temp$cache;
							fn = $temp$fn;
							args = $temp$args;
							continue applyTypeHelper;
						} else {
							var varCache = _v2.a;
							var err = _v2.b.a;
							return $elm$core$Result$Err(
								_List_fromArray(
									[err]));
						}
					}
				case 'GenericType':
					var varName = fn.a;
					if (!args.b) {
						return $elm$core$Result$Ok(
							{aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases, inferences: cache, type_: fn});
					} else {
						var resultType = $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(varName + '_result');
						return $elm$core$Result$Ok(
							{
								aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
								inferences: A3(
									$mdgriffith$elm_codegen$Internal$Compiler$addInference,
									varName,
									A2($mdgriffith$elm_codegen$Internal$Compiler$makeFunction, resultType, args),
									cache),
								type_: resultType
							});
					}
				default:
					var _final = fn;
					if (!args.b) {
						return $elm$core$Result$Ok(
							{aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases, inferences: cache, type_: fn});
					} else {
						return $elm$core$Result$Err(
							_List_fromArray(
								[
									A2($mdgriffith$elm_codegen$Internal$Compiler$FunctionAppliedToTooManyArgs, _final, args)
								]));
					}
			}
		}
	});
var $elm$core$Dict$merge = F6(
	function (leftStep, bothStep, rightStep, leftDict, rightDict, initialResult) {
		var stepState = F3(
			function (rKey, rValue, _v0) {
				stepState:
				while (true) {
					var list = _v0.a;
					var result = _v0.b;
					if (!list.b) {
						return _Utils_Tuple2(
							list,
							A3(rightStep, rKey, rValue, result));
					} else {
						var _v2 = list.a;
						var lKey = _v2.a;
						var lValue = _v2.b;
						var rest = list.b;
						if (_Utils_cmp(lKey, rKey) < 0) {
							var $temp$rKey = rKey,
								$temp$rValue = rValue,
								$temp$_v0 = _Utils_Tuple2(
								rest,
								A3(leftStep, lKey, lValue, result));
							rKey = $temp$rKey;
							rValue = $temp$rValue;
							_v0 = $temp$_v0;
							continue stepState;
						} else {
							if (_Utils_cmp(lKey, rKey) > 0) {
								return _Utils_Tuple2(
									list,
									A3(rightStep, rKey, rValue, result));
							} else {
								return _Utils_Tuple2(
									rest,
									A4(bothStep, lKey, lValue, rValue, result));
							}
						}
					}
				}
			});
		var _v3 = A3(
			$elm$core$Dict$foldl,
			stepState,
			_Utils_Tuple2(
				$elm$core$Dict$toList(leftDict),
				initialResult),
			rightDict);
		var leftovers = _v3.a;
		var intermediateResult = _v3.b;
		return A3(
			$elm$core$List$foldl,
			F2(
				function (_v4, result) {
					var k = _v4.a;
					var v = _v4.b;
					return A3(leftStep, k, v, result);
				}),
			intermediateResult,
			leftovers);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$mergeInferences = F2(
	function (one, two) {
		return A6(
			$elm$core$Dict$merge,
			$elm$core$Dict$insert,
			F4(
				function (key, oneVal, twoVal, d) {
					if (oneVal.$ === 'GenericRecord') {
						var recordName = oneVal.a;
						var _v1 = oneVal.b;
						var oneRange = _v1.a;
						var recordDefinition = _v1.b;
						if (twoVal.$ === 'GenericRecord') {
							var twoRecordName = twoVal.a;
							var _v3 = twoVal.b;
							var twoRange = _v3.a;
							var twoRecordDefinition = _v3.b;
							return A3(
								$elm$core$Dict$insert,
								key,
								A2(
									$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord,
									recordName,
									A2(
										$stil4m$elm_syntax$Elm$Syntax$Node$Node,
										oneRange,
										_Utils_ap(recordDefinition, twoRecordDefinition))),
								d);
						} else {
							return A3($elm$core$Dict$insert, key, oneVal, d);
						}
					} else {
						return A3($elm$core$Dict$insert, key, oneVal, d);
					}
				}),
			$elm$core$Dict$insert,
			one,
			two,
			$elm$core$Dict$empty);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$mergeArgInferences = F3(
	function (expressions, annotations, inferences) {
		mergeArgInferences:
		while (true) {
			if (!expressions.b) {
				return $elm$core$Result$Ok(
					{
						inferences: inferences,
						types: $elm$core$List$reverse(annotations)
					});
			} else {
				var top = expressions.a;
				var remain = expressions.b;
				var _v1 = top.annotation;
				if (_v1.$ === 'Ok') {
					var ann = _v1.a;
					var $temp$expressions = remain,
						$temp$annotations = A2($elm$core$List$cons, ann.type_, annotations),
						$temp$inferences = A2($mdgriffith$elm_codegen$Internal$Compiler$mergeInferences, inferences, ann.inferences);
					expressions = $temp$expressions;
					annotations = $temp$annotations;
					inferences = $temp$inferences;
					continue mergeArgInferences;
				} else {
					var err = _v1.a;
					return $elm$core$Result$Err(err);
				}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Index$typecheck = function (_v0) {
	var top = _v0.a;
	var tail = _v0.b;
	var scope = _v0.c;
	var check = _v0.d;
	return check;
};
var $mdgriffith$elm_codegen$Internal$Compiler$applyType = F3(
	function (index, annotation, args) {
		if (annotation.$ === 'Err') {
			var err = annotation.a;
			return $elm$core$Result$Err(err);
		} else {
			var fnAnnotation = annotation.a;
			if ($mdgriffith$elm_codegen$Internal$Index$typecheck(index)) {
				var _v1 = A3($mdgriffith$elm_codegen$Internal$Compiler$mergeArgInferences, args, _List_Nil, fnAnnotation.inferences);
				if (_v1.$ === 'Ok') {
					var mergedArgs = _v1.a;
					return A4($mdgriffith$elm_codegen$Internal$Compiler$applyTypeHelper, fnAnnotation.aliases, mergedArgs.inferences, fnAnnotation.type_, mergedArgs.types);
				} else {
					var err = _v1.a;
					return $elm$core$Result$Err(err);
				}
			} else {
				return $elm$core$Result$Err(_List_Nil);
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$Expression = function (a) {
	return {$: 'Expression', a: a};
};
var $mdgriffith$elm_codegen$Internal$Index$Index = F4(
	function (a, b, c, d) {
		return {$: 'Index', a: a, b: b, c: c, d: d};
	});
var $mdgriffith$elm_codegen$Internal$Index$dive = function (_v0) {
	var top = _v0.a;
	var tail = _v0.b;
	var scope = _v0.c;
	var check = _v0.d;
	return A4(
		$mdgriffith$elm_codegen$Internal$Index$Index,
		0,
		A2($elm$core$List$cons, top, tail),
		scope,
		check);
};
var $mdgriffith$elm_codegen$Internal$Compiler$expression = function (toExp) {
	return $mdgriffith$elm_codegen$Internal$Compiler$Expression(
		function (index) {
			return toExp(
				$mdgriffith$elm_codegen$Internal$Index$dive(index));
		});
};
var $mdgriffith$elm_codegen$Internal$Compiler$getImports = function (exp) {
	return exp.imports;
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression = function (a) {
	return {$: 'ParenthesizedExpression', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$parens = function (expr) {
	switch (expr.$) {
		case 'UnitExpr':
			return expr;
		case 'Integer':
			var i = expr.a;
			return expr;
		case 'Literal':
			return expr;
		case 'Hex':
			return expr;
		case 'Floatable':
			return expr;
		case 'TupledExpression':
			return expr;
		case 'ParenthesizedExpression':
			return expr;
		case 'CharLiteral':
			return expr;
		case 'ListExpr':
			return expr;
		case 'FunctionOrValue':
			return expr;
		case 'RecordAccessFunction':
			return expr;
		case 'RecordUpdateExpression':
			return expr;
		case 'RecordExpr':
			return expr;
		case 'LambdaExpression':
			return expr;
		default:
			return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
				$mdgriffith$elm_codegen$Internal$Compiler$nodify(expr));
	}
};
var $mdgriffith$elm_codegen$Internal$Index$next = function (_v0) {
	var top = _v0.a;
	var tail = _v0.b;
	var scope = _v0.c;
	var check = _v0.d;
	return A4($mdgriffith$elm_codegen$Internal$Index$Index, top + 1, tail, scope, check);
};
var $mdgriffith$elm_codegen$Internal$Compiler$threadHelper = F3(
	function (index, exps, rendered) {
		threadHelper:
		while (true) {
			if (!exps.b) {
				return $elm$core$List$reverse(rendered);
			} else {
				var toExpDetails = exps.a.a;
				var remain = exps.b;
				var $temp$index = $mdgriffith$elm_codegen$Internal$Index$next(index),
					$temp$exps = remain,
					$temp$rendered = A2(
					$elm$core$List$cons,
					toExpDetails(index),
					rendered);
				index = $temp$index;
				exps = $temp$exps;
				rendered = $temp$rendered;
				continue threadHelper;
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$thread = F2(
	function (index, exps) {
		return A3($mdgriffith$elm_codegen$Internal$Compiler$threadHelper, index, exps, _List_Nil);
	});
var $mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails = F2(
	function (index, _v0) {
		var toExp = _v0.a;
		return _Utils_Tuple2(
			$mdgriffith$elm_codegen$Internal$Index$next(index),
			toExp(index));
	});
var $mdgriffith$elm_codegen$Elm$apply = F2(
	function (fnExp, argExpressions) {
		return $mdgriffith$elm_codegen$Internal$Compiler$expression(
			function (index) {
				var _v0 = A2($mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails, index, fnExp);
				var annotationIndex = _v0.a;
				var fnDetails = _v0.b;
				var args = A2($mdgriffith$elm_codegen$Internal$Compiler$thread, annotationIndex, argExpressions);
				return {
					annotation: A3($mdgriffith$elm_codegen$Internal$Compiler$applyType, index, fnDetails.annotation, args),
					expression: $stil4m$elm_syntax$Elm$Syntax$Expression$Application(
						$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
							A2(
								$elm$core$List$cons,
								fnDetails.expression,
								A2(
									$elm$core$List$map,
									A2(
										$elm$core$Basics$composeL,
										$mdgriffith$elm_codegen$Internal$Compiler$parens,
										function ($) {
											return $.expression;
										}),
									args)))),
					imports: _Utils_ap(
						fnDetails.imports,
						A2($elm$core$List$concatMap, $mdgriffith$elm_codegen$Internal$Compiler$getImports, args))
				};
			});
	});
var $elm$regex$Regex$Match = F4(
	function (match, index, number, submatches) {
		return {index: index, match: match, number: number, submatches: submatches};
	});
var $elm$regex$Regex$fromStringWith = _Regex_fromStringWith;
var $elm$regex$Regex$fromString = function (string) {
	return A2(
		$elm$regex$Regex$fromStringWith,
		{caseInsensitive: false, multiline: false},
		string);
};
var $elm$regex$Regex$never = _Regex_never;
var $elm_community$string_extra$String$Extra$regexFromString = A2(
	$elm$core$Basics$composeR,
	$elm$regex$Regex$fromString,
	$elm$core$Maybe$withDefault($elm$regex$Regex$never));
var $elm$regex$Regex$replace = _Regex_replaceAtMost(_Regex_infinity);
var $elm$core$String$trim = _String_trim;
var $elm_community$string_extra$String$Extra$camelize = function (string) {
	return A3(
		$elm$regex$Regex$replace,
		$elm_community$string_extra$String$Extra$regexFromString('[-_\\s]+(.)?'),
		function (_v0) {
			var submatches = _v0.submatches;
			if (submatches.b && (submatches.a.$ === 'Just')) {
				var match = submatches.a.a;
				return $elm$core$String$toUpper(match);
			} else {
				return '';
			}
		},
		$elm$core$String$trim(string));
};
var $author$project$OpenApi$components = function (_v0) {
	var openApi = _v0.a;
	return openApi.components;
};
var $author$project$OpenApi$OpenApi = function (a) {
	return {$: 'OpenApi', a: a};
};
var $author$project$OpenApi$Components$Components = function (a) {
	return {$: 'Components', a: a};
};
var $author$project$OpenApi$SecurityScheme$SecurityScheme = function (a) {
	return {$: 'SecurityScheme', a: a};
};
var $elm$json$Json$Decode$andThen = _Json_andThen;
var $author$project$OpenApi$SecurityScheme$ApiKey = function (a) {
	return {$: 'ApiKey', a: a};
};
var $author$project$OpenApi$SecurityScheme$Cookie = {$: 'Cookie'};
var $author$project$OpenApi$SecurityScheme$Header = {$: 'Header'};
var $author$project$OpenApi$SecurityScheme$Query = {$: 'Query'};
var $elm$json$Json$Decode$fail = _Json_fail;
var $elm$json$Json$Decode$string = _Json_decodeString;
var $author$project$OpenApi$SecurityScheme$decodeSecuritySchemeIn = A2(
	$elm$json$Json$Decode$andThen,
	function (inStr) {
		switch (inStr) {
			case 'query':
				return $elm$json$Json$Decode$succeed($author$project$OpenApi$SecurityScheme$Query);
			case 'header':
				return $elm$json$Json$Decode$succeed($author$project$OpenApi$SecurityScheme$Header);
			case 'cookie':
				return $elm$json$Json$Decode$succeed($author$project$OpenApi$SecurityScheme$Cookie);
			default:
				return $elm$json$Json$Decode$fail('Unkown Security Scheme apikey in value: ' + inStr);
		}
	},
	$elm$json$Json$Decode$string);
var $elm$json$Json$Decode$field = _Json_decodeField;
var $elm$json$Json$Decode$map2 = _Json_map2;
var $author$project$OpenApi$SecurityScheme$decodeApiKey = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (name_, in__) {
			return $author$project$OpenApi$SecurityScheme$ApiKey(
				{in_: in__, name: name_});
		}),
	A2($elm$json$Json$Decode$field, 'name', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'in', $author$project$OpenApi$SecurityScheme$decodeSecuritySchemeIn));
var $author$project$OpenApi$SecurityScheme$Http = function (a) {
	return {$: 'Http', a: a};
};
var $elm$json$Json$Decode$decodeValue = _Json_run;
var $elm$json$Json$Decode$map = _Json_map1;
var $elm_community$json_extra$Json$Decode$Extra$optionalField = F2(
	function (fieldName, decoder) {
		var finishDecoding = function (json) {
			var _v0 = A2(
				$elm$json$Json$Decode$decodeValue,
				A2($elm$json$Json$Decode$field, fieldName, $elm$json$Json$Decode$value),
				json);
			if (_v0.$ === 'Ok') {
				var val = _v0.a;
				return A2(
					$elm$json$Json$Decode$map,
					$elm$core$Maybe$Just,
					A2($elm$json$Json$Decode$field, fieldName, decoder));
			} else {
				return $elm$json$Json$Decode$succeed($elm$core$Maybe$Nothing);
			}
		};
		return A2($elm$json$Json$Decode$andThen, finishDecoding, $elm$json$Json$Decode$value);
	});
var $author$project$OpenApi$SecurityScheme$decodeHttp = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (scheme_, bearerFormat_) {
			return $author$project$OpenApi$SecurityScheme$Http(
				{bearerFormat: bearerFormat_, scheme: scheme_});
		}),
	A2($elm$json$Json$Decode$field, 'scheme', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'bearerFormat', $elm$json$Json$Decode$string));
var $author$project$OpenApi$SecurityScheme$MutualTls = {$: 'MutualTls'};
var $author$project$OpenApi$SecurityScheme$decodeMutualTls = $elm$json$Json$Decode$succeed($author$project$OpenApi$SecurityScheme$MutualTls);
var $author$project$OpenApi$SecurityScheme$Oauth2 = function (a) {
	return {$: 'Oauth2', a: a};
};
var $author$project$OpenApi$OauthFlow$OauthFlows = function (a) {
	return {$: 'OauthFlows', a: a};
};
var $author$project$OpenApi$OauthFlow$AuthorizationCodeFlow = function (a) {
	return {$: 'AuthorizationCodeFlow', a: a};
};
var $elm$json$Json$Decode$keyValuePairs = _Json_decodeKeyValuePairs;
var $elm$json$Json$Decode$dict = function (decoder) {
	return A2(
		$elm$json$Json$Decode$map,
		$elm$core$Dict$fromList,
		$elm$json$Json$Decode$keyValuePairs(decoder));
};
var $author$project$OpenApi$OauthFlow$decodeScopes = $elm$json$Json$Decode$dict($elm$json$Json$Decode$string);
var $elm$json$Json$Decode$map4 = _Json_map4;
var $author$project$OpenApi$OauthFlow$decodeAuthorizationCode = A5(
	$elm$json$Json$Decode$map4,
	F4(
		function (authorizationUrl_, tokenUrl_, refreshUrl_, scopes_) {
			return $author$project$OpenApi$OauthFlow$AuthorizationCodeFlow(
				{authorizationUrl: authorizationUrl_, refreshUrl: refreshUrl_, scopes: scopes_, tokenUrl: tokenUrl_});
		}),
	A2($elm$json$Json$Decode$field, 'authorizationUrl', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'tokenUrl', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'refreshUrl', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'scopes', $author$project$OpenApi$OauthFlow$decodeScopes));
var $author$project$OpenApi$OauthFlow$ClientCredentialsFlow = function (a) {
	return {$: 'ClientCredentialsFlow', a: a};
};
var $elm$json$Json$Decode$map3 = _Json_map3;
var $author$project$OpenApi$OauthFlow$decodeClientCredentials = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (tokenUrl_, refreshUrl_, scopes_) {
			return $author$project$OpenApi$OauthFlow$ClientCredentialsFlow(
				{refreshUrl: refreshUrl_, scopes: scopes_, tokenUrl: tokenUrl_});
		}),
	A2($elm$json$Json$Decode$field, 'tokenUrl', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'refreshUrl', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'scopes', $author$project$OpenApi$OauthFlow$decodeScopes));
var $author$project$OpenApi$OauthFlow$ImplicitFlow = function (a) {
	return {$: 'ImplicitFlow', a: a};
};
var $author$project$OpenApi$OauthFlow$decodeImplicit = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (authorizationUrl_, refreshUrl_, scopes_) {
			return $author$project$OpenApi$OauthFlow$ImplicitFlow(
				{authorizationUrl: authorizationUrl_, refreshUrl: refreshUrl_, scopes: scopes_});
		}),
	A2($elm$json$Json$Decode$field, 'authorizationUrl', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'refreshUrl', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'scopes', $author$project$OpenApi$OauthFlow$decodeScopes));
var $author$project$OpenApi$OauthFlow$PasswordFlow = function (a) {
	return {$: 'PasswordFlow', a: a};
};
var $author$project$OpenApi$OauthFlow$decodePassword = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (tokenUrl_, refreshUrl_, scopes_) {
			return $author$project$OpenApi$OauthFlow$PasswordFlow(
				{refreshUrl: refreshUrl_, scopes: scopes_, tokenUrl: tokenUrl_});
		}),
	A2($elm$json$Json$Decode$field, 'tokenUrl', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'refreshUrl', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'scopes', $author$project$OpenApi$OauthFlow$decodeScopes));
var $author$project$OpenApi$OauthFlow$decodeFlows = A5(
	$elm$json$Json$Decode$map4,
	F4(
		function (implicit_, password_, clientCredentials_, authorizationCode_) {
			return $author$project$OpenApi$OauthFlow$OauthFlows(
				{authorizationCode: authorizationCode_, clientCredentials: clientCredentials_, implicit: implicit_, password: password_});
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'implicit', $author$project$OpenApi$OauthFlow$decodeImplicit),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'password', $author$project$OpenApi$OauthFlow$decodePassword),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'clientCredentials', $author$project$OpenApi$OauthFlow$decodeClientCredentials),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'authorizationCode', $author$project$OpenApi$OauthFlow$decodeAuthorizationCode));
var $author$project$OpenApi$SecurityScheme$decodeOauth2 = A2(
	$elm$json$Json$Decode$map,
	function (flows_) {
		return $author$project$OpenApi$SecurityScheme$Oauth2(
			{flows: flows_});
	},
	A2($elm$json$Json$Decode$field, 'flows', $author$project$OpenApi$OauthFlow$decodeFlows));
var $author$project$OpenApi$SecurityScheme$OpenIdConnect = function (a) {
	return {$: 'OpenIdConnect', a: a};
};
var $author$project$OpenApi$SecurityScheme$decodeOpenIdConnect = A2(
	$elm$json$Json$Decode$map,
	function (openIdConnectUrl_) {
		return $author$project$OpenApi$SecurityScheme$OpenIdConnect(
			{openIdConnectUrl: openIdConnectUrl_});
	},
	A2($elm$json$Json$Decode$field, 'openIdConnectUrl', $elm$json$Json$Decode$string));
var $author$project$OpenApi$SecurityScheme$decodeType = A2(
	$elm$json$Json$Decode$andThen,
	function (typeStr) {
		switch (typeStr) {
			case 'apiKey':
				return $author$project$OpenApi$SecurityScheme$decodeApiKey;
			case 'http':
				return $author$project$OpenApi$SecurityScheme$decodeHttp;
			case 'mutualTLS':
				return $author$project$OpenApi$SecurityScheme$decodeMutualTls;
			case 'oauth2':
				return $author$project$OpenApi$SecurityScheme$decodeOauth2;
			case 'openIdConnect':
				return $author$project$OpenApi$SecurityScheme$decodeOpenIdConnect;
			default:
				return $elm$json$Json$Decode$fail('Unknown Security Scheme type: ' + typeStr);
		}
	},
	A2($elm$json$Json$Decode$field, 'type', $elm$json$Json$Decode$string));
var $author$project$OpenApi$SecurityScheme$decode = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (type__, description_) {
			return $author$project$OpenApi$SecurityScheme$SecurityScheme(
				{description: description_, type_: type__});
		}),
	$author$project$OpenApi$SecurityScheme$decodeType,
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string));
var $author$project$OpenApi$Types$Callback = function (a) {
	return {$: 'Callback', a: a};
};
var $author$project$OpenApi$Types$Operation = function (a) {
	return {$: 'Operation', a: a};
};
var $author$project$OpenApi$Types$Path = function (a) {
	return {$: 'Path', a: a};
};
var $elm$json$Json$Decode$bool = _Json_decodeBool;
var $author$project$OpenApi$Types$ExternalDocumentation = function (a) {
	return {$: 'ExternalDocumentation', a: a};
};
var $author$project$OpenApi$Types$decodeExternalDocumentation = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (description_, url_) {
			return $author$project$OpenApi$Types$ExternalDocumentation(
				{description: description_, url: url_});
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'url', $elm$json$Json$Decode$string));
var $NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom = $elm$json$Json$Decode$map2($elm$core$Basics$apR);
var $elm$json$Json$Decode$at = F2(
	function (fields, decoder) {
		return A3($elm$core$List$foldr, $elm$json$Json$Decode$field, decoder, fields);
	});
var $elm$json$Json$Decode$null = _Json_decodeNull;
var $elm$json$Json$Decode$oneOf = _Json_oneOf;
var $NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optionalDecoder = F3(
	function (path, valDecoder, fallback) {
		var nullOr = function (decoder) {
			return $elm$json$Json$Decode$oneOf(
				_List_fromArray(
					[
						decoder,
						$elm$json$Json$Decode$null(fallback)
					]));
		};
		var handleResult = function (input) {
			var _v0 = A2(
				$elm$json$Json$Decode$decodeValue,
				A2($elm$json$Json$Decode$at, path, $elm$json$Json$Decode$value),
				input);
			if (_v0.$ === 'Ok') {
				var rawValue = _v0.a;
				var _v1 = A2(
					$elm$json$Json$Decode$decodeValue,
					nullOr(valDecoder),
					rawValue);
				if (_v1.$ === 'Ok') {
					var finalResult = _v1.a;
					return $elm$json$Json$Decode$succeed(finalResult);
				} else {
					return A2(
						$elm$json$Json$Decode$at,
						path,
						nullOr(valDecoder));
				}
			} else {
				return $elm$json$Json$Decode$succeed(fallback);
			}
		};
		return A2($elm$json$Json$Decode$andThen, handleResult, $elm$json$Json$Decode$value);
	});
var $NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional = F4(
	function (key, valDecoder, fallback, decoder) {
		return A2(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
			A3(
				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optionalDecoder,
				_List_fromArray(
					[key]),
				valDecoder,
				fallback),
			decoder);
	});
var $author$project$OpenApi$Types$decodeOptionalDict = F2(
	function (field, decoder) {
		return A3(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
			field,
			$elm$json$Json$Decode$dict(decoder),
			$elm$core$Dict$empty);
	});
var $author$project$OpenApi$Types$Parameter = function (a) {
	return {$: 'Parameter', a: a};
};
var $author$project$OpenApi$Types$Example = function (a) {
	return {$: 'Example', a: a};
};
var $author$project$OpenApi$Types$decodeExample = A5(
	$elm$json$Json$Decode$map4,
	F4(
		function (summary_, description_, value_, externalValue_) {
			return $author$project$OpenApi$Types$Example(
				{description: description_, externalValue: externalValue_, summary: summary_, value: value_});
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'summary', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'value', $elm$json$Json$Decode$value),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'externalValue', $elm$json$Json$Decode$string));
var $author$project$OpenApi$Types$LocCookie = function (a) {
	return {$: 'LocCookie', a: a};
};
var $author$project$OpenApi$Types$decodeCookie = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (style, explode, required) {
			var style_ = A2($elm$core$Maybe$withDefault, 'form', style);
			return _Utils_Tuple2(
				$author$project$OpenApi$Types$LocCookie(
					{
						explode: A2($elm$core$Maybe$withDefault, style_ === 'form', explode),
						style: style_
					}),
				A2($elm$core$Maybe$withDefault, false, required));
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'style', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'explode', $elm$json$Json$Decode$bool),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'required', $elm$json$Json$Decode$bool));
var $author$project$OpenApi$Types$LocHeader = function (a) {
	return {$: 'LocHeader', a: a};
};
var $author$project$OpenApi$Types$decodeLocHeader = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (style, explode, required) {
			var style_ = A2($elm$core$Maybe$withDefault, 'simple', style);
			return _Utils_Tuple2(
				$author$project$OpenApi$Types$LocHeader(
					{
						explode: A2($elm$core$Maybe$withDefault, style_ === 'form', explode),
						style: style_
					}),
				A2($elm$core$Maybe$withDefault, false, required));
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'style', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'explode', $elm$json$Json$Decode$bool),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'required', $elm$json$Json$Decode$bool));
var $author$project$OpenApi$Types$LocPath = function (a) {
	return {$: 'LocPath', a: a};
};
var $author$project$Internal$andThen3 = F4(
	function (f, decoderA, decoderB, decoderC) {
		return A2(
			$elm$json$Json$Decode$andThen,
			function (_v0) {
				var a = _v0.a;
				var b = _v0.b;
				var c = _v0.c;
				return A3(f, a, b, c);
			},
			A4(
				$elm$json$Json$Decode$map3,
				F3(
					function (a, b, c) {
						return _Utils_Tuple3(a, b, c);
					}),
				decoderA,
				decoderB,
				decoderC));
	});
var $author$project$OpenApi$Types$decodeLocPath = A4(
	$author$project$Internal$andThen3,
	F3(
		function (style, explode, required) {
			if (required) {
				var style_ = A2($elm$core$Maybe$withDefault, 'simple', style);
				return $elm$json$Json$Decode$succeed(
					_Utils_Tuple2(
						$author$project$OpenApi$Types$LocPath(
							{
								explode: A2($elm$core$Maybe$withDefault, style_ === 'form', explode),
								style: style_
							}),
						required));
			} else {
				return $elm$json$Json$Decode$fail('If the location (`in`) is `path`, then `required` MUST be true');
			}
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'style', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'explode', $elm$json$Json$Decode$bool),
	A2($elm$json$Json$Decode$field, 'required', $elm$json$Json$Decode$bool));
var $author$project$OpenApi$Types$LocQuery = function (a) {
	return {$: 'LocQuery', a: a};
};
var $author$project$OpenApi$Types$decodeQuery = A5(
	$elm$json$Json$Decode$map4,
	F4(
		function (style, explode, allowReserved, required) {
			var style_ = A2($elm$core$Maybe$withDefault, 'form', style);
			return _Utils_Tuple2(
				$author$project$OpenApi$Types$LocQuery(
					{
						allowReserved: A2($elm$core$Maybe$withDefault, false, allowReserved),
						explode: A2($elm$core$Maybe$withDefault, style_ === 'form', explode),
						style: style_
					}),
				A2($elm$core$Maybe$withDefault, false, required));
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'style', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'explode', $elm$json$Json$Decode$bool),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'allowReserved', $elm$json$Json$Decode$bool),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'required', $elm$json$Json$Decode$bool));
var $author$project$OpenApi$Types$decodeLocation = A2(
	$elm$json$Json$Decode$andThen,
	function (in_) {
		switch (in_) {
			case 'query':
				return $author$project$OpenApi$Types$decodeQuery;
			case 'header':
				return $author$project$OpenApi$Types$decodeLocHeader;
			case 'path':
				return $author$project$OpenApi$Types$decodeLocPath;
			case 'cookie':
				return $author$project$OpenApi$Types$decodeCookie;
			default:
				return $elm$json$Json$Decode$fail('Unknown location `in` of ' + in_);
		}
	},
	A2($elm$json$Json$Decode$field, 'in', $elm$json$Json$Decode$string));
var $author$project$OpenApi$Types$Encoding = function (a) {
	return {$: 'Encoding', a: a};
};
var $author$project$OpenApi$Types$Header = function (a) {
	return {$: 'Header', a: a};
};
var $author$project$OpenApi$Types$MediaType = function (a) {
	return {$: 'MediaType', a: a};
};
var $author$project$OpenApi$Types$Other = function (a) {
	return {$: 'Other', a: a};
};
var $author$project$OpenApi$Types$Ref = function (a) {
	return {$: 'Ref', a: a};
};
var $author$project$OpenApi$Types$Reference = function (a) {
	return {$: 'Reference', a: a};
};
var $author$project$OpenApi$Types$decodeReference = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (ref_, summary_, description_) {
			return $author$project$OpenApi$Types$Reference(
				{description: description_, ref: ref_, summary: summary_});
		}),
	A2($elm$json$Json$Decode$field, '$ref', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'summary', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string));
var $author$project$OpenApi$Types$decodeRefOr = function (decoder) {
	return $elm$json$Json$Decode$oneOf(
		_List_fromArray(
			[
				A2($elm$json$Json$Decode$map, $author$project$OpenApi$Types$Ref, $author$project$OpenApi$Types$decodeReference),
				A2($elm$json$Json$Decode$map, $author$project$OpenApi$Types$Other, decoder)
			]));
};
var $author$project$OpenApi$Types$Schema = function (a) {
	return {$: 'Schema', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$AnyType = {$: 'AnyType'};
var $json_tools$json_schema$Json$Schema$Definitions$ArrayOfItems = function (a) {
	return {$: 'ArrayOfItems', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$ArrayPropNames = function (a) {
	return {$: 'ArrayPropNames', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$BoolBoundary = function (a) {
	return {$: 'BoolBoundary', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$BooleanSchema = function (a) {
	return {$: 'BooleanSchema', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$ItemDefinition = function (a) {
	return {$: 'ItemDefinition', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$NoItems = {$: 'NoItems'};
var $json_tools$json_schema$Json$Schema$Definitions$NumberBoundary = function (a) {
	return {$: 'NumberBoundary', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$ObjectSchema = function (a) {
	return {$: 'ObjectSchema', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$PropSchema = function (a) {
	return {$: 'PropSchema', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$Schemata = function (a) {
	return {$: 'Schemata', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$SingleType = function (a) {
	return {$: 'SingleType', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$SubSchema = function (type_) {
	return function (id) {
		return function (ref) {
			return function (title) {
				return function (description) {
					return function (_default) {
						return function (examples) {
							return function (definitions) {
								return function (multipleOf) {
									return function (maximum) {
										return function (exclusiveMaximum) {
											return function (minimum) {
												return function (exclusiveMinimum) {
													return function (maxLength) {
														return function (minLength) {
															return function (pattern) {
																return function (format) {
																	return function (items) {
																		return function (additionalItems) {
																			return function (maxItems) {
																				return function (minItems) {
																					return function (uniqueItems) {
																						return function (contains) {
																							return function (maxProperties) {
																								return function (minProperties) {
																									return function (required) {
																										return function (properties) {
																											return function (patternProperties) {
																												return function (additionalProperties) {
																													return function (dependencies) {
																														return function (propertyNames) {
																															return function (_enum) {
																																return function (_const) {
																																	return function (allOf) {
																																		return function (anyOf) {
																																			return function (oneOf) {
																																				return function (not) {
																																					return function (source) {
																																						return {additionalItems: additionalItems, additionalProperties: additionalProperties, allOf: allOf, anyOf: anyOf, _const: _const, contains: contains, _default: _default, definitions: definitions, dependencies: dependencies, description: description, _enum: _enum, examples: examples, exclusiveMaximum: exclusiveMaximum, exclusiveMinimum: exclusiveMinimum, format: format, id: id, items: items, maxItems: maxItems, maxLength: maxLength, maxProperties: maxProperties, maximum: maximum, minItems: minItems, minLength: minLength, minProperties: minProperties, minimum: minimum, multipleOf: multipleOf, not: not, oneOf: oneOf, pattern: pattern, patternProperties: patternProperties, properties: properties, propertyNames: propertyNames, ref: ref, required: required, source: source, title: title, type_: type_, uniqueItems: uniqueItems};
																																					};
																																				};
																																			};
																																		};
																																	};
																																};
																															};
																														};
																													};
																												};
																											};
																										};
																									};
																								};
																							};
																						};
																					};
																				};
																			};
																		};
																	};
																};
															};
														};
													};
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
};
var $elm$core$List$isEmpty = function (xs) {
	if (!xs.b) {
		return true;
	} else {
		return false;
	}
};
var $json_tools$json_schema$Json$Schema$Definitions$failIfEmpty = function (l) {
	return $elm$core$List$isEmpty(l) ? $elm$json$Json$Decode$fail('List is empty') : $elm$json$Json$Decode$succeed(l);
};
var $elm$json$Json$Decode$float = _Json_decodeFloat;
var $elm$json$Json$Decode$lazy = function (thunk) {
	return A2(
		$elm$json$Json$Decode$andThen,
		thunk,
		$elm$json$Json$Decode$succeed(_Utils_Tuple0));
};
var $elm$json$Json$Decode$list = _Json_decodeList;
var $elm$json$Json$Decode$maybe = function (decoder) {
	return $elm$json$Json$Decode$oneOf(
		_List_fromArray(
			[
				A2($elm$json$Json$Decode$map, $elm$core$Maybe$Just, decoder),
				$elm$json$Json$Decode$succeed($elm$core$Maybe$Nothing)
			]));
};
var $json_tools$json_schema$Json$Schema$Definitions$NullableType = function (a) {
	return {$: 'NullableType', a: a};
};
var $json_tools$json_schema$Json$Schema$Definitions$UnionType = function (a) {
	return {$: 'UnionType', a: a};
};
var $elm$core$Result$andThen = F2(
	function (callback, result) {
		if (result.$ === 'Ok') {
			var value = result.a;
			return callback(value);
		} else {
			var msg = result.a;
			return $elm$core$Result$Err(msg);
		}
	});
var $json_tools$json_schema$Util$foldResults = function (results) {
	return A2(
		$elm$core$Result$map,
		$elm$core$List$reverse,
		A3(
			$elm$core$List$foldl,
			function (t) {
				return $elm$core$Result$andThen(
					function (r) {
						return A2(
							$elm$core$Result$map,
							function (a) {
								return A2($elm$core$List$cons, a, r);
							},
							t);
					});
			},
			$elm$core$Result$Ok(_List_Nil),
			results));
};
var $json_tools$json_schema$Util$resultToDecoder = function (res) {
	if (res.$ === 'Ok') {
		var a = res.a;
		return $elm$json$Json$Decode$succeed(a);
	} else {
		var e = res.a;
		return $elm$json$Json$Decode$fail(e);
	}
};
var $json_tools$json_schema$Json$Schema$Definitions$ArrayType = {$: 'ArrayType'};
var $json_tools$json_schema$Json$Schema$Definitions$BooleanType = {$: 'BooleanType'};
var $json_tools$json_schema$Json$Schema$Definitions$IntegerType = {$: 'IntegerType'};
var $json_tools$json_schema$Json$Schema$Definitions$NullType = {$: 'NullType'};
var $json_tools$json_schema$Json$Schema$Definitions$NumberType = {$: 'NumberType'};
var $json_tools$json_schema$Json$Schema$Definitions$ObjectType = {$: 'ObjectType'};
var $json_tools$json_schema$Json$Schema$Definitions$StringType = {$: 'StringType'};
var $json_tools$json_schema$Json$Schema$Definitions$stringToType = function (s) {
	switch (s) {
		case 'integer':
			return $elm$core$Result$Ok($json_tools$json_schema$Json$Schema$Definitions$IntegerType);
		case 'number':
			return $elm$core$Result$Ok($json_tools$json_schema$Json$Schema$Definitions$NumberType);
		case 'string':
			return $elm$core$Result$Ok($json_tools$json_schema$Json$Schema$Definitions$StringType);
		case 'boolean':
			return $elm$core$Result$Ok($json_tools$json_schema$Json$Schema$Definitions$BooleanType);
		case 'array':
			return $elm$core$Result$Ok($json_tools$json_schema$Json$Schema$Definitions$ArrayType);
		case 'object':
			return $elm$core$Result$Ok($json_tools$json_schema$Json$Schema$Definitions$ObjectType);
		case 'null':
			return $elm$core$Result$Ok($json_tools$json_schema$Json$Schema$Definitions$NullType);
		default:
			return $elm$core$Result$Err('Unknown type: ' + s);
	}
};
var $json_tools$json_schema$Json$Schema$Definitions$singleTypeDecoder = function (s) {
	var _v0 = $json_tools$json_schema$Json$Schema$Definitions$stringToType(s);
	if (_v0.$ === 'Ok') {
		var st = _v0.a;
		return $elm$json$Json$Decode$succeed(st);
	} else {
		var msg = _v0.a;
		return $elm$json$Json$Decode$fail(msg);
	}
};
var $elm$core$List$sortBy = _List_sortBy;
var $elm$core$List$sort = function (xs) {
	return A2($elm$core$List$sortBy, $elm$core$Basics$identity, xs);
};
var $json_tools$json_schema$Json$Schema$Definitions$multipleTypesDecoder = function (lst) {
	_v0$3:
	while (true) {
		if (lst.b) {
			if (lst.b.b) {
				if (!lst.b.b.b) {
					if (lst.b.a === 'null') {
						var x = lst.a;
						var _v1 = lst.b;
						return A2(
							$elm$json$Json$Decode$map,
							$json_tools$json_schema$Json$Schema$Definitions$NullableType,
							$json_tools$json_schema$Json$Schema$Definitions$singleTypeDecoder(x));
					} else {
						if (lst.a === 'null') {
							var _v2 = lst.b;
							var x = _v2.a;
							return A2(
								$elm$json$Json$Decode$map,
								$json_tools$json_schema$Json$Schema$Definitions$NullableType,
								$json_tools$json_schema$Json$Schema$Definitions$singleTypeDecoder(x));
						} else {
							break _v0$3;
						}
					}
				} else {
					break _v0$3;
				}
			} else {
				var x = lst.a;
				return A2(
					$elm$json$Json$Decode$map,
					$json_tools$json_schema$Json$Schema$Definitions$SingleType,
					$json_tools$json_schema$Json$Schema$Definitions$singleTypeDecoder(x));
			}
		} else {
			break _v0$3;
		}
	}
	var otherList = lst;
	return $json_tools$json_schema$Util$resultToDecoder(
		A2(
			$elm$core$Result$andThen,
			A2($elm$core$Basics$composeL, $elm$core$Result$Ok, $json_tools$json_schema$Json$Schema$Definitions$UnionType),
			$json_tools$json_schema$Util$foldResults(
				A2(
					$elm$core$List$map,
					$json_tools$json_schema$Json$Schema$Definitions$stringToType,
					$elm$core$List$sort(otherList)))));
};
var $json_tools$json_schema$Json$Schema$Definitions$failIfValuesAreNotUnique = function (l) {
	return $elm$json$Json$Decode$succeed(l);
};
var $json_tools$json_schema$Json$Schema$Definitions$nonEmptyUniqueArrayOfValuesDecoder = A2(
	$elm$json$Json$Decode$andThen,
	$json_tools$json_schema$Json$Schema$Definitions$failIfEmpty,
	A2(
		$elm$json$Json$Decode$andThen,
		$json_tools$json_schema$Json$Schema$Definitions$failIfValuesAreNotUnique,
		$elm$json$Json$Decode$list($elm$json$Json$Decode$value)));
var $elm$core$Basics$ge = _Utils_ge;
var $elm$json$Json$Decode$int = _Json_decodeInt;
var $json_tools$json_schema$Json$Schema$Definitions$nonNegativeInt = A2(
	$elm$json$Json$Decode$andThen,
	function (x) {
		return (x >= 0) ? $elm$json$Json$Decode$succeed(x) : $elm$json$Json$Decode$fail('Expected non-negative int');
	},
	$elm$json$Json$Decode$int);
var $elm$json$Json$Decode$nullable = function (decoder) {
	return $elm$json$Json$Decode$oneOf(
		_List_fromArray(
			[
				$elm$json$Json$Decode$null($elm$core$Maybe$Nothing),
				A2($elm$json$Json$Decode$map, $elm$core$Maybe$Just, decoder)
			]));
};
var $NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$requiredAt = F3(
	function (path, valDecoder, decoder) {
		return A2(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
			A2($elm$json$Json$Decode$at, path, valDecoder),
			decoder);
	});
function $json_tools$json_schema$Json$Schema$Definitions$cyclic$itemsDecoder() {
	return $elm$json$Json$Decode$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$json$Json$Decode$map,
				$json_tools$json_schema$Json$Schema$Definitions$ArrayOfItems,
				$elm$json$Json$Decode$list(
					$json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder())),
				A2(
				$elm$json$Json$Decode$map,
				$json_tools$json_schema$Json$Schema$Definitions$ItemDefinition,
				$json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder())
			]));
}
function $json_tools$json_schema$Json$Schema$Definitions$cyclic$dependenciesDecoder() {
	return $elm$json$Json$Decode$keyValuePairs(
		$elm$json$Json$Decode$oneOf(
			_List_fromArray(
				[
					A2(
					$elm$json$Json$Decode$map,
					$json_tools$json_schema$Json$Schema$Definitions$ArrayPropNames,
					$elm$json$Json$Decode$list($elm$json$Json$Decode$string)),
					A2(
					$elm$json$Json$Decode$map,
					$json_tools$json_schema$Json$Schema$Definitions$PropSchema,
					$json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder())
				])));
}
function $json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder() {
	var singleType = A2($elm$json$Json$Decode$andThen, $json_tools$json_schema$Json$Schema$Definitions$singleTypeDecoder, $elm$json$Json$Decode$string);
	var multipleTypes = A2(
		$elm$json$Json$Decode$andThen,
		$json_tools$json_schema$Json$Schema$Definitions$multipleTypesDecoder,
		$elm$json$Json$Decode$list($elm$json$Json$Decode$string));
	var exclusiveBoundaryDecoder = $elm$json$Json$Decode$oneOf(
		_List_fromArray(
			[
				A2($elm$json$Json$Decode$map, $json_tools$json_schema$Json$Schema$Definitions$BoolBoundary, $elm$json$Json$Decode$bool),
				A2($elm$json$Json$Decode$map, $json_tools$json_schema$Json$Schema$Definitions$NumberBoundary, $elm$json$Json$Decode$float)
			]));
	var objectSchemaDecoder = A3(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$requiredAt,
		_List_Nil,
		$elm$json$Json$Decode$value,
		A4(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
			'not',
			$elm$json$Json$Decode$nullable(
				$elm$json$Json$Decode$lazy(
					function (_v14) {
						return $json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder();
					})),
			$elm$core$Maybe$Nothing,
			A4(
				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
				'oneOf',
				$elm$json$Json$Decode$nullable(
					$elm$json$Json$Decode$lazy(
						function (_v13) {
							return $json_tools$json_schema$Json$Schema$Definitions$cyclic$nonEmptyListOfSchemas();
						})),
				$elm$core$Maybe$Nothing,
				A4(
					$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
					'anyOf',
					$elm$json$Json$Decode$nullable(
						$elm$json$Json$Decode$lazy(
							function (_v12) {
								return $json_tools$json_schema$Json$Schema$Definitions$cyclic$nonEmptyListOfSchemas();
							})),
					$elm$core$Maybe$Nothing,
					A4(
						$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
						'allOf',
						$elm$json$Json$Decode$nullable(
							$elm$json$Json$Decode$lazy(
								function (_v11) {
									return $json_tools$json_schema$Json$Schema$Definitions$cyclic$nonEmptyListOfSchemas();
								})),
						$elm$core$Maybe$Nothing,
						A4(
							$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
							'const',
							A2($elm$json$Json$Decode$map, $elm$core$Maybe$Just, $elm$json$Json$Decode$value),
							$elm$core$Maybe$Nothing,
							A4(
								$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
								'enum',
								$elm$json$Json$Decode$nullable($json_tools$json_schema$Json$Schema$Definitions$nonEmptyUniqueArrayOfValuesDecoder),
								$elm$core$Maybe$Nothing,
								A4(
									$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
									'propertyNames',
									$elm$json$Json$Decode$nullable(
										$elm$json$Json$Decode$lazy(
											function (_v10) {
												return $json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder();
											})),
									$elm$core$Maybe$Nothing,
									A4(
										$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
										'dependencies',
										$elm$json$Json$Decode$lazy(
											function (_v9) {
												return $json_tools$json_schema$Json$Schema$Definitions$cyclic$dependenciesDecoder();
											}),
										_List_Nil,
										A4(
											$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
											'additionalProperties',
											$elm$json$Json$Decode$nullable(
												$elm$json$Json$Decode$lazy(
													function (_v8) {
														return $json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder();
													})),
											$elm$core$Maybe$Nothing,
											A4(
												$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
												'patternProperties',
												$elm$json$Json$Decode$nullable(
													$elm$json$Json$Decode$lazy(
														function (_v7) {
															return $json_tools$json_schema$Json$Schema$Definitions$cyclic$schemataDecoder();
														})),
												$elm$core$Maybe$Nothing,
												A4(
													$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
													'properties',
													$elm$json$Json$Decode$nullable(
														$elm$json$Json$Decode$lazy(
															function (_v6) {
																return $json_tools$json_schema$Json$Schema$Definitions$cyclic$schemataDecoder();
															})),
													$elm$core$Maybe$Nothing,
													A4(
														$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
														'required',
														$elm$json$Json$Decode$nullable(
															$elm$json$Json$Decode$list($elm$json$Json$Decode$string)),
														$elm$core$Maybe$Nothing,
														A4(
															$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
															'minProperties',
															$elm$json$Json$Decode$nullable($json_tools$json_schema$Json$Schema$Definitions$nonNegativeInt),
															$elm$core$Maybe$Nothing,
															A4(
																$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																'maxProperties',
																$elm$json$Json$Decode$nullable($json_tools$json_schema$Json$Schema$Definitions$nonNegativeInt),
																$elm$core$Maybe$Nothing,
																A4(
																	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																	'contains',
																	$elm$json$Json$Decode$nullable(
																		$elm$json$Json$Decode$lazy(
																			function (_v5) {
																				return $json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder();
																			})),
																	$elm$core$Maybe$Nothing,
																	A4(
																		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																		'uniqueItems',
																		$elm$json$Json$Decode$nullable($elm$json$Json$Decode$bool),
																		$elm$core$Maybe$Nothing,
																		A4(
																			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																			'minItems',
																			$elm$json$Json$Decode$nullable($json_tools$json_schema$Json$Schema$Definitions$nonNegativeInt),
																			$elm$core$Maybe$Nothing,
																			A4(
																				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																				'maxItems',
																				$elm$json$Json$Decode$nullable($json_tools$json_schema$Json$Schema$Definitions$nonNegativeInt),
																				$elm$core$Maybe$Nothing,
																				A4(
																					$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																					'additionalItems',
																					$elm$json$Json$Decode$nullable(
																						$elm$json$Json$Decode$lazy(
																							function (_v4) {
																								return $json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder();
																							})),
																					$elm$core$Maybe$Nothing,
																					A4(
																						$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																						'items',
																						$elm$json$Json$Decode$lazy(
																							function (_v3) {
																								return $json_tools$json_schema$Json$Schema$Definitions$cyclic$itemsDecoder();
																							}),
																						$json_tools$json_schema$Json$Schema$Definitions$NoItems,
																						A4(
																							$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																							'format',
																							$elm$json$Json$Decode$nullable($elm$json$Json$Decode$string),
																							$elm$core$Maybe$Nothing,
																							A4(
																								$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																								'pattern',
																								$elm$json$Json$Decode$nullable($elm$json$Json$Decode$string),
																								$elm$core$Maybe$Nothing,
																								A4(
																									$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																									'minLength',
																									$elm$json$Json$Decode$nullable($json_tools$json_schema$Json$Schema$Definitions$nonNegativeInt),
																									$elm$core$Maybe$Nothing,
																									A4(
																										$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																										'maxLength',
																										$elm$json$Json$Decode$nullable($json_tools$json_schema$Json$Schema$Definitions$nonNegativeInt),
																										$elm$core$Maybe$Nothing,
																										A4(
																											$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																											'exclusiveMinimum',
																											$elm$json$Json$Decode$nullable(exclusiveBoundaryDecoder),
																											$elm$core$Maybe$Nothing,
																											A4(
																												$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																												'minimum',
																												$elm$json$Json$Decode$nullable($elm$json$Json$Decode$float),
																												$elm$core$Maybe$Nothing,
																												A4(
																													$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																													'exclusiveMaximum',
																													$elm$json$Json$Decode$nullable(exclusiveBoundaryDecoder),
																													$elm$core$Maybe$Nothing,
																													A4(
																														$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																														'maximum',
																														$elm$json$Json$Decode$nullable($elm$json$Json$Decode$float),
																														$elm$core$Maybe$Nothing,
																														A4(
																															$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																															'multipleOf',
																															$elm$json$Json$Decode$nullable($elm$json$Json$Decode$float),
																															$elm$core$Maybe$Nothing,
																															A4(
																																$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																																'definitions',
																																$elm$json$Json$Decode$nullable(
																																	$elm$json$Json$Decode$lazy(
																																		function (_v2) {
																																			return $json_tools$json_schema$Json$Schema$Definitions$cyclic$schemataDecoder();
																																		})),
																																$elm$core$Maybe$Nothing,
																																A4(
																																	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																																	'examples',
																																	$elm$json$Json$Decode$nullable(
																																		$elm$json$Json$Decode$list($elm$json$Json$Decode$value)),
																																	$elm$core$Maybe$Nothing,
																																	A4(
																																		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																																		'default',
																																		A2($elm$json$Json$Decode$map, $elm$core$Maybe$Just, $elm$json$Json$Decode$value),
																																		$elm$core$Maybe$Nothing,
																																		A4(
																																			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																																			'description',
																																			$elm$json$Json$Decode$nullable($elm$json$Json$Decode$string),
																																			$elm$core$Maybe$Nothing,
																																			A4(
																																				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																																				'title',
																																				$elm$json$Json$Decode$nullable($elm$json$Json$Decode$string),
																																				$elm$core$Maybe$Nothing,
																																				A4(
																																					$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																																					'$ref',
																																					$elm$json$Json$Decode$nullable($elm$json$Json$Decode$string),
																																					$elm$core$Maybe$Nothing,
																																					A2(
																																						$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
																																						A3(
																																							$elm$json$Json$Decode$map2,
																																							F2(
																																								function (a, b) {
																																									return _Utils_eq(a, $elm$core$Maybe$Nothing) ? b : a;
																																								}),
																																							$elm$json$Json$Decode$maybe(
																																								A2($elm$json$Json$Decode$field, '$id', $elm$json$Json$Decode$string)),
																																							$elm$json$Json$Decode$maybe(
																																								A2($elm$json$Json$Decode$field, 'id', $elm$json$Json$Decode$string))),
																																						A4(
																																							$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
																																							'type',
																																							$elm$json$Json$Decode$oneOf(
																																								_List_fromArray(
																																									[
																																										multipleTypes,
																																										A2($elm$json$Json$Decode$map, $json_tools$json_schema$Json$Schema$Definitions$SingleType, singleType)
																																									])),
																																							$json_tools$json_schema$Json$Schema$Definitions$AnyType,
																																							$elm$json$Json$Decode$succeed($json_tools$json_schema$Json$Schema$Definitions$SubSchema)))))))))))))))))))))))))))))))))))))));
	var booleanSchemaDecoder = A2(
		$elm$json$Json$Decode$andThen,
		function (b) {
			return b ? $elm$json$Json$Decode$succeed(
				$json_tools$json_schema$Json$Schema$Definitions$BooleanSchema(true)) : $elm$json$Json$Decode$succeed(
				$json_tools$json_schema$Json$Schema$Definitions$BooleanSchema(false));
		},
		$elm$json$Json$Decode$bool);
	return $elm$json$Json$Decode$oneOf(
		_List_fromArray(
			[
				booleanSchemaDecoder,
				A2(
				$elm$json$Json$Decode$andThen,
				function (b) {
					return $elm$json$Json$Decode$succeed(
						$json_tools$json_schema$Json$Schema$Definitions$ObjectSchema(b));
				},
				objectSchemaDecoder)
			]));
}
function $json_tools$json_schema$Json$Schema$Definitions$cyclic$nonEmptyListOfSchemas() {
	return A2(
		$elm$json$Json$Decode$andThen,
		$json_tools$json_schema$Json$Schema$Definitions$failIfEmpty,
		$elm$json$Json$Decode$list(
			$elm$json$Json$Decode$lazy(
				function (_v1) {
					return $json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder();
				})));
}
function $json_tools$json_schema$Json$Schema$Definitions$cyclic$schemataDecoder() {
	return A2(
		$elm$json$Json$Decode$map,
		$json_tools$json_schema$Json$Schema$Definitions$Schemata,
		$elm$json$Json$Decode$keyValuePairs(
			$elm$json$Json$Decode$lazy(
				function (_v0) {
					return $json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder();
				})));
}
try {
	var $json_tools$json_schema$Json$Schema$Definitions$itemsDecoder = $json_tools$json_schema$Json$Schema$Definitions$cyclic$itemsDecoder();
	$json_tools$json_schema$Json$Schema$Definitions$cyclic$itemsDecoder = function () {
		return $json_tools$json_schema$Json$Schema$Definitions$itemsDecoder;
	};
	var $json_tools$json_schema$Json$Schema$Definitions$dependenciesDecoder = $json_tools$json_schema$Json$Schema$Definitions$cyclic$dependenciesDecoder();
	$json_tools$json_schema$Json$Schema$Definitions$cyclic$dependenciesDecoder = function () {
		return $json_tools$json_schema$Json$Schema$Definitions$dependenciesDecoder;
	};
	var $json_tools$json_schema$Json$Schema$Definitions$decoder = $json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder();
	$json_tools$json_schema$Json$Schema$Definitions$cyclic$decoder = function () {
		return $json_tools$json_schema$Json$Schema$Definitions$decoder;
	};
	var $json_tools$json_schema$Json$Schema$Definitions$nonEmptyListOfSchemas = $json_tools$json_schema$Json$Schema$Definitions$cyclic$nonEmptyListOfSchemas();
	$json_tools$json_schema$Json$Schema$Definitions$cyclic$nonEmptyListOfSchemas = function () {
		return $json_tools$json_schema$Json$Schema$Definitions$nonEmptyListOfSchemas;
	};
	var $json_tools$json_schema$Json$Schema$Definitions$schemataDecoder = $json_tools$json_schema$Json$Schema$Definitions$cyclic$schemataDecoder();
	$json_tools$json_schema$Json$Schema$Definitions$cyclic$schemataDecoder = function () {
		return $json_tools$json_schema$Json$Schema$Definitions$schemataDecoder;
	};
} catch ($) {
	throw 'Some top-level definitions from `Json.Schema.Definitions` are causing infinite recursion:\n\n  ┌─────┐\n  │    itemsDecoder\n  │     ↓\n  │    dependenciesDecoder\n  │     ↓\n  │    decoder\n  │     ↓\n  │    nonEmptyListOfSchemas\n  │     ↓\n  │    schemataDecoder\n  └─────┘\n\nThese errors are very tricky, so read https://elm-lang.org/0.19.1/bad-recursion to learn how to fix it!';}
var $author$project$OpenApi$Types$decodeSchema = A2($elm$json$Json$Decode$map, $author$project$OpenApi$Types$Schema, $json_tools$json_schema$Json$Schema$Definitions$decoder);
var $elm$json$Json$Decode$map5 = _Json_map5;
var $author$project$OpenApi$Types$optionalNothing = F2(
	function (fieldName, decoder) {
		return A3(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
			fieldName,
			A2($elm$json$Json$Decode$map, $elm$core$Maybe$Just, decoder),
			$elm$core$Maybe$Nothing);
	});
function $author$project$OpenApi$Types$cyclic$decodeHeader() {
	return A4(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
		'examples',
		$elm$json$Json$Decode$dict(
			$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeExample)),
		$elm$core$Dict$empty,
		A3(
			$author$project$OpenApi$Types$optionalNothing,
			'example',
			$elm$json$Json$Decode$value,
			A4(
				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
				'content',
				$elm$json$Json$Decode$dict(
					$author$project$OpenApi$Types$cyclic$decodeMediaType()),
				$elm$core$Dict$empty,
				A3(
					$author$project$OpenApi$Types$optionalNothing,
					'schema',
					$author$project$OpenApi$Types$decodeSchema,
					A4(
						$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
						'allowEmptyValue',
						A2(
							$elm$json$Json$Decode$map,
							$elm$core$Maybe$withDefault(false),
							$elm$json$Json$Decode$maybe($elm$json$Json$Decode$bool)),
						false,
						A4(
							$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
							'deprecated',
							A2(
								$elm$json$Json$Decode$map,
								$elm$core$Maybe$withDefault(false),
								$elm$json$Json$Decode$maybe($elm$json$Json$Decode$bool)),
							false,
							A3(
								$author$project$OpenApi$Types$optionalNothing,
								'description',
								$elm$json$Json$Decode$string,
								A4(
									$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
									'required',
									$elm$json$Json$Decode$bool,
									false,
									A4(
										$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
										'explode',
										$elm$json$Json$Decode$bool,
										false,
										A3(
											$author$project$OpenApi$Types$optionalNothing,
											'style',
											$elm$json$Json$Decode$string,
											$elm$json$Json$Decode$succeed(
												function (style) {
													return function (explode) {
														return function (required) {
															return function (description) {
																return function (deprecated) {
																	return function (allowEmptyValue) {
																		return function (schema) {
																			return function (content) {
																				return function (example) {
																					return function (examples) {
																						return $author$project$OpenApi$Types$Header(
																							{allowEmptyValue: allowEmptyValue, content: content, deprecated: deprecated, description: description, example: example, examples: examples, explode: explode, required: required, schema: schema, style: style});
																					};
																				};
																			};
																		};
																	};
																};
															};
														};
													};
												})))))))))));
}
function $author$project$OpenApi$Types$cyclic$decodeMediaType() {
	return A5(
		$elm$json$Json$Decode$map4,
		F4(
			function (schema_, example_, examples_, encoding_) {
				return $author$project$OpenApi$Types$MediaType(
					{encoding: encoding_, example: example_, examples: examples_, schema: schema_});
			}),
		A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'schema', $author$project$OpenApi$Types$decodeSchema),
		A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'example', $elm$json$Json$Decode$value),
		A2(
			$elm$json$Json$Decode$map,
			$elm$core$Maybe$withDefault($elm$core$Dict$empty),
			A2(
				$elm_community$json_extra$Json$Decode$Extra$optionalField,
				'examples',
				$elm$json$Json$Decode$dict(
					$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeExample)))),
		A2(
			$elm$json$Json$Decode$map,
			$elm$core$Maybe$withDefault($elm$core$Dict$empty),
			A2(
				$elm_community$json_extra$Json$Decode$Extra$optionalField,
				'encoding',
				$elm$json$Json$Decode$dict(
					$author$project$OpenApi$Types$cyclic$decodeEncoding()))));
}
function $author$project$OpenApi$Types$cyclic$decodeEncoding() {
	return A6(
		$elm$json$Json$Decode$map5,
		F5(
			function (contentType_, headers_, style_, explode_, allowReserved_) {
				return $author$project$OpenApi$Types$Encoding(
					{
						allowReserved: A2($elm$core$Maybe$withDefault, false, allowReserved_),
						contentType: contentType_,
						explode: A2(
							$elm$core$Maybe$withDefault,
							_Utils_eq(
								style_,
								$elm$core$Maybe$Just('form')),
							explode_),
						headers: headers_,
						style: style_
					});
			}),
		A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'contentType', $elm$json$Json$Decode$string),
		A2(
			$elm$json$Json$Decode$map,
			$elm$core$Maybe$withDefault($elm$core$Dict$empty),
			A2(
				$elm_community$json_extra$Json$Decode$Extra$optionalField,
				'headers',
				$elm$json$Json$Decode$dict(
					$author$project$OpenApi$Types$decodeRefOr(
						$elm$json$Json$Decode$lazy(
							function (_v0) {
								return $author$project$OpenApi$Types$cyclic$decodeHeader();
							}))))),
		A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'style', $elm$json$Json$Decode$string),
		A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'explode', $elm$json$Json$Decode$bool),
		A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'allowReserved', $elm$json$Json$Decode$bool));
}
try {
	var $author$project$OpenApi$Types$decodeHeader = $author$project$OpenApi$Types$cyclic$decodeHeader();
	$author$project$OpenApi$Types$cyclic$decodeHeader = function () {
		return $author$project$OpenApi$Types$decodeHeader;
	};
	var $author$project$OpenApi$Types$decodeMediaType = $author$project$OpenApi$Types$cyclic$decodeMediaType();
	$author$project$OpenApi$Types$cyclic$decodeMediaType = function () {
		return $author$project$OpenApi$Types$decodeMediaType;
	};
	var $author$project$OpenApi$Types$decodeEncoding = $author$project$OpenApi$Types$cyclic$decodeEncoding();
	$author$project$OpenApi$Types$cyclic$decodeEncoding = function () {
		return $author$project$OpenApi$Types$decodeEncoding;
	};
} catch ($) {
	throw 'Some top-level definitions from `OpenApi.Types` are causing infinite recursion:\n\n  ┌─────┐\n  │    decodeHeader\n  │     ↓\n  │    decodeMediaType\n  │     ↓\n  │    decodeEncoding\n  └─────┘\n\nThese errors are very tricky, so read https://elm-lang.org/0.19.1/bad-recursion to learn how to fix it!';}
var $NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required = F3(
	function (key, valDecoder, decoder) {
		return A2(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
			A2($elm$json$Json$Decode$field, key, valDecoder),
			decoder);
	});
var $author$project$OpenApi$Types$decodeParameter = A4(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
	'examples',
	$elm$json$Json$Decode$dict(
		$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeExample)),
	$elm$core$Dict$empty,
	A3(
		$author$project$OpenApi$Types$optionalNothing,
		'example',
		$elm$json$Json$Decode$value,
		A4(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
			'content',
			$elm$json$Json$Decode$dict($author$project$OpenApi$Types$decodeMediaType),
			$elm$core$Dict$empty,
			A3(
				$author$project$OpenApi$Types$optionalNothing,
				'schema',
				$author$project$OpenApi$Types$decodeSchema,
				A4(
					$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
					'allowEmptyValue',
					A2(
						$elm$json$Json$Decode$map,
						$elm$core$Maybe$withDefault(false),
						$elm$json$Json$Decode$maybe($elm$json$Json$Decode$bool)),
					false,
					A4(
						$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
						'deprecated',
						A2(
							$elm$json$Json$Decode$map,
							$elm$core$Maybe$withDefault(false),
							$elm$json$Json$Decode$maybe($elm$json$Json$Decode$bool)),
						false,
						A3(
							$author$project$OpenApi$Types$optionalNothing,
							'description',
							$elm$json$Json$Decode$string,
							A2(
								$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$custom,
								$author$project$OpenApi$Types$decodeLocation,
								A3(
									$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
									'name',
									$elm$json$Json$Decode$string,
									$elm$json$Json$Decode$succeed(
										F9(
											function (name, _v0, description, deprecated, allowEmptyValue, schema, content, example, examples) {
												var in_ = _v0.a;
												var required = _v0.b;
												return $author$project$OpenApi$Types$Parameter(
													{allowEmptyValue: allowEmptyValue, content: content, deprecated: deprecated, description: description, example: example, examples: examples, in_: in_, name: name, required: required, schema: schema});
											})))))))))));
var $author$project$OpenApi$Types$RequestBody = function (a) {
	return {$: 'RequestBody', a: a};
};
var $author$project$OpenApi$Types$decodeRequestBody = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (description_, content_, required_) {
			return $author$project$OpenApi$Types$RequestBody(
				{content: content_, description: description_, required: required_});
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string),
	A2(
		$elm$json$Json$Decode$map,
		$elm$core$Maybe$withDefault($elm$core$Dict$empty),
		A2(
			$elm_community$json_extra$Json$Decode$Extra$optionalField,
			'content',
			$elm$json$Json$Decode$dict($author$project$OpenApi$Types$decodeMediaType))),
	A2(
		$elm$json$Json$Decode$map,
		$elm$core$Maybe$withDefault(false),
		A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'required', $elm$json$Json$Decode$bool)));
var $author$project$OpenApi$Types$Response = function (a) {
	return {$: 'Response', a: a};
};
var $author$project$OpenApi$Types$Link = function (a) {
	return {$: 'Link', a: a};
};
var $author$project$OpenApi$Types$LinkId = function (a) {
	return {$: 'LinkId', a: a};
};
var $author$project$OpenApi$Types$LinkRef = function (a) {
	return {$: 'LinkRef', a: a};
};
var $elm$core$Tuple$pair = F2(
	function (a, b) {
		return _Utils_Tuple2(a, b);
	});
var $author$project$Internal$andThen2 = F3(
	function (f, decoderA, decoderB) {
		return A2(
			$elm$json$Json$Decode$andThen,
			function (_v0) {
				var a = _v0.a;
				var b = _v0.b;
				return A2(f, a, b);
			},
			A3($elm$json$Json$Decode$map2, $elm$core$Tuple$pair, decoderA, decoderB));
	});
var $author$project$OpenApi$Types$decodeLinkRefOrId = A3(
	$author$project$Internal$andThen2,
	F2(
		function (operationRef_, operationId_) {
			var _v0 = _Utils_Tuple2(operationRef_, operationId_);
			if (_v0.a.$ === 'Nothing') {
				if (_v0.b.$ === 'Nothing') {
					var _v1 = _v0.a;
					var _v2 = _v0.b;
					return $elm$json$Json$Decode$succeed($elm$core$Maybe$Nothing);
				} else {
					var _v4 = _v0.a;
					var id = _v0.b.a;
					return $elm$json$Json$Decode$succeed(
						$elm$core$Maybe$Just(
							$author$project$OpenApi$Types$LinkId(id)));
				}
			} else {
				if (_v0.b.$ === 'Nothing') {
					var ref = _v0.a.a;
					var _v3 = _v0.b;
					return $elm$json$Json$Decode$succeed(
						$elm$core$Maybe$Just(
							$author$project$OpenApi$Types$LinkRef(ref)));
				} else {
					return $elm$json$Json$Decode$fail('A Link Object cannot have both an operationRef and an operationId, but I found both.');
				}
			}
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'operationRef', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'operationId', $elm$json$Json$Decode$string));
var $author$project$OpenApi$Types$Server = function (a) {
	return {$: 'Server', a: a};
};
var $author$project$OpenApi$Types$Variable = function (a) {
	return {$: 'Variable', a: a};
};
var $author$project$OpenApi$Types$decodeServerVariable = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (description_, default_, enum_) {
			return $author$project$OpenApi$Types$Variable(
				{_default: default_, description: description_, _enum: enum_});
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'default', $elm$json$Json$Decode$string),
	A2(
		$elm$json$Json$Decode$map,
		$elm$core$Maybe$withDefault(_List_Nil),
		A2(
			$elm_community$json_extra$Json$Decode$Extra$optionalField,
			'enum',
			$elm$json$Json$Decode$list($elm$json$Json$Decode$string))));
var $author$project$OpenApi$Types$decodeServer = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (description_, url_, variables_) {
			return $author$project$OpenApi$Types$Server(
				{description: description_, url: url_, variables: variables_});
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'url', $elm$json$Json$Decode$string),
	A2(
		$elm$json$Json$Decode$map,
		$elm$core$Maybe$withDefault($elm$core$Dict$empty),
		A2(
			$elm_community$json_extra$Json$Decode$Extra$optionalField,
			'variables',
			$elm$json$Json$Decode$dict($author$project$OpenApi$Types$decodeServerVariable))));
var $author$project$OpenApi$Types$decodeLink = A6(
	$elm$json$Json$Decode$map5,
	F5(
		function (operationRefOrId_, parameters_, requestBody_, description_, server_) {
			return $author$project$OpenApi$Types$Link(
				{description: description_, operationRefOrId: operationRefOrId_, parameters: parameters_, requestBody: requestBody_, server: server_});
		}),
	$author$project$OpenApi$Types$decodeLinkRefOrId,
	A2(
		$elm$json$Json$Decode$map,
		$elm$core$Maybe$withDefault($elm$core$Dict$empty),
		A2(
			$elm_community$json_extra$Json$Decode$Extra$optionalField,
			'parameters',
			$elm$json$Json$Decode$dict($elm$json$Json$Decode$value))),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'requestBody', $elm$json$Json$Decode$value),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'server', $author$project$OpenApi$Types$decodeServer));
var $author$project$OpenApi$Types$decodeResponse = A5(
	$elm$json$Json$Decode$map4,
	F4(
		function (description_, headers_, content_, links_) {
			return $author$project$OpenApi$Types$Response(
				{content: content_, description: description_, headers: headers_, links: links_});
		}),
	A2($elm$json$Json$Decode$field, 'description', $elm$json$Json$Decode$string),
	A2(
		$elm$json$Json$Decode$map,
		$elm$core$Maybe$withDefault($elm$core$Dict$empty),
		A2(
			$elm_community$json_extra$Json$Decode$Extra$optionalField,
			'headers',
			$elm$json$Json$Decode$dict(
				$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeHeader)))),
	A2(
		$elm$json$Json$Decode$map,
		$elm$core$Maybe$withDefault($elm$core$Dict$empty),
		A2(
			$elm_community$json_extra$Json$Decode$Extra$optionalField,
			'content',
			$elm$json$Json$Decode$dict($author$project$OpenApi$Types$decodeMediaType))),
	A2(
		$elm$json$Json$Decode$map,
		$elm$core$Maybe$withDefault($elm$core$Dict$empty),
		A2(
			$elm_community$json_extra$Json$Decode$Extra$optionalField,
			'links',
			$elm$json$Json$Decode$dict(
				$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeLink)))));
var $author$project$OpenApi$Types$SecurityRequirement = function (a) {
	return {$: 'SecurityRequirement', a: a};
};
var $author$project$OpenApi$Types$decodeSecurityRequirement = A2(
	$elm$json$Json$Decode$map,
	$author$project$OpenApi$Types$SecurityRequirement,
	$elm$json$Json$Decode$dict(
		$elm$json$Json$Decode$list($elm$json$Json$Decode$string)));
var $elm$core$Dict$isEmpty = function (dict) {
	if (dict.$ === 'RBEmpty_elm_builtin') {
		return true;
	} else {
		return false;
	}
};
function $author$project$OpenApi$Types$cyclic$decodePath() {
	return A4(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
		'parameters',
		$elm$json$Json$Decode$list(
			$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeParameter)),
		_List_Nil,
		A4(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
			'servers',
			$elm$json$Json$Decode$list($author$project$OpenApi$Types$decodeServer),
			_List_Nil,
			A3(
				$author$project$OpenApi$Types$optionalNothing,
				'trace',
				$author$project$OpenApi$Types$cyclic$decodeOperation(),
				A3(
					$author$project$OpenApi$Types$optionalNothing,
					'patch',
					$author$project$OpenApi$Types$cyclic$decodeOperation(),
					A3(
						$author$project$OpenApi$Types$optionalNothing,
						'head',
						$author$project$OpenApi$Types$cyclic$decodeOperation(),
						A3(
							$author$project$OpenApi$Types$optionalNothing,
							'options',
							$author$project$OpenApi$Types$cyclic$decodeOperation(),
							A3(
								$author$project$OpenApi$Types$optionalNothing,
								'delete',
								$author$project$OpenApi$Types$cyclic$decodeOperation(),
								A3(
									$author$project$OpenApi$Types$optionalNothing,
									'post',
									$author$project$OpenApi$Types$cyclic$decodeOperation(),
									A3(
										$author$project$OpenApi$Types$optionalNothing,
										'put',
										$author$project$OpenApi$Types$cyclic$decodeOperation(),
										A3(
											$author$project$OpenApi$Types$optionalNothing,
											'get',
											$author$project$OpenApi$Types$cyclic$decodeOperation(),
											A3(
												$author$project$OpenApi$Types$optionalNothing,
												'description',
												$elm$json$Json$Decode$string,
												A3(
													$author$project$OpenApi$Types$optionalNothing,
													'summary',
													$elm$json$Json$Decode$string,
													$elm$json$Json$Decode$succeed(
														function (summary) {
															return function (description) {
																return function (get) {
																	return function (put) {
																		return function (post) {
																			return function (_delete) {
																				return function (options) {
																					return function (head) {
																						return function (patch) {
																							return function (trace) {
																								return function (servers) {
																									return function (parameters) {
																										return $author$project$OpenApi$Types$Path(
																											{_delete: _delete, description: description, get: get, head: head, options: options, parameters: parameters, patch: patch, post: post, put: put, servers: servers, summary: summary, trace: trace});
																									};
																								};
																							};
																						};
																					};
																				};
																			};
																		};
																	};
																};
															};
														})))))))))))));
}
function $author$project$OpenApi$Types$cyclic$decodeOperation() {
	return A2(
		$elm$json$Json$Decode$andThen,
		function (operation) {
			return $elm$core$Dict$isEmpty(operation.responses) ? $elm$json$Json$Decode$fail('At least 1 response is required for an operation, none were found') : $elm$json$Json$Decode$succeed(
				$author$project$OpenApi$Types$Operation(operation));
		},
		A4(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
			'servers',
			$elm$json$Json$Decode$list($author$project$OpenApi$Types$decodeServer),
			_List_Nil,
			A4(
				$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
				'security',
				$elm$json$Json$Decode$list($author$project$OpenApi$Types$decodeSecurityRequirement),
				_List_Nil,
				A4(
					$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
					'deprecated',
					$elm$json$Json$Decode$bool,
					false,
					A4(
						$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
						'callbacks',
						$elm$json$Json$Decode$dict(
							$author$project$OpenApi$Types$decodeRefOr(
								$author$project$OpenApi$Types$cyclic$decodeCallback())),
						$elm$core$Dict$empty,
						A3(
							$author$project$OpenApi$Types$decodeOptionalDict,
							'responses',
							$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeResponse),
							A3(
								$author$project$OpenApi$Types$optionalNothing,
								'requestBody',
								$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeRequestBody),
								A4(
									$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
									'parameters',
									$elm$json$Json$Decode$list(
										$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeParameter)),
									_List_Nil,
									A3(
										$author$project$OpenApi$Types$optionalNothing,
										'operationId',
										$elm$json$Json$Decode$string,
										A3(
											$author$project$OpenApi$Types$optionalNothing,
											'externalDocs',
											$author$project$OpenApi$Types$decodeExternalDocumentation,
											A3(
												$author$project$OpenApi$Types$optionalNothing,
												'description',
												$elm$json$Json$Decode$string,
												A3(
													$author$project$OpenApi$Types$optionalNothing,
													'summary',
													$elm$json$Json$Decode$string,
													A4(
														$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
														'tags',
														$elm$json$Json$Decode$list($elm$json$Json$Decode$string),
														_List_Nil,
														$elm$json$Json$Decode$succeed(
															function (tags) {
																return function (summary) {
																	return function (description) {
																		return function (externalDocs) {
																			return function (operationId) {
																				return function (parameters) {
																					return function (requestBody) {
																						return function (responses) {
																							return function (callbacks) {
																								return function (deprecated) {
																									return function (security) {
																										return function (servers) {
																											return {callbacks: callbacks, deprecated: deprecated, description: description, externalDocs: externalDocs, operationId: operationId, parameters: parameters, requestBody: requestBody, responses: responses, security: security, servers: servers, summary: summary, tags: tags};
																										};
																									};
																								};
																							};
																						};
																					};
																				};
																			};
																		};
																	};
																};
															}))))))))))))));
}
function $author$project$OpenApi$Types$cyclic$decodeCallback() {
	return A2(
		$elm$json$Json$Decode$andThen,
		function (dict) {
			var _v1 = $elm$core$Dict$toList(dict);
			if (_v1.b && (!_v1.b.b)) {
				var _v2 = _v1.a;
				var expression = _v2.a;
				var refOrPath = _v2.b;
				return $elm$json$Json$Decode$succeed(
					$author$project$OpenApi$Types$Callback(
						{expression: expression, refOrPath: refOrPath}));
			} else {
				return $elm$json$Json$Decode$fail('Expected a single expression but found zero or multiple');
			}
		},
		$elm$json$Json$Decode$dict(
			$elm$json$Json$Decode$lazy(
				function (_v0) {
					return $author$project$OpenApi$Types$decodeRefOr(
						$author$project$OpenApi$Types$cyclic$decodePath());
				})));
}
try {
	var $author$project$OpenApi$Types$decodePath = $author$project$OpenApi$Types$cyclic$decodePath();
	$author$project$OpenApi$Types$cyclic$decodePath = function () {
		return $author$project$OpenApi$Types$decodePath;
	};
	var $author$project$OpenApi$Types$decodeOperation = $author$project$OpenApi$Types$cyclic$decodeOperation();
	$author$project$OpenApi$Types$cyclic$decodeOperation = function () {
		return $author$project$OpenApi$Types$decodeOperation;
	};
	var $author$project$OpenApi$Types$decodeCallback = $author$project$OpenApi$Types$cyclic$decodeCallback();
	$author$project$OpenApi$Types$cyclic$decodeCallback = function () {
		return $author$project$OpenApi$Types$decodeCallback;
	};
} catch ($) {
	throw 'Some top-level definitions from `OpenApi.Types` are causing infinite recursion:\n\n  ┌─────┐\n  │    decodePath\n  │     ↓\n  │    decodeOperation\n  │     ↓\n  │    decodeCallback\n  └─────┘\n\nThese errors are very tricky, so read https://elm-lang.org/0.19.1/bad-recursion to learn how to fix it!';}
var $author$project$OpenApi$Components$decode = A3(
	$author$project$OpenApi$Types$decodeOptionalDict,
	'pathItems',
	$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodePath),
	A3(
		$author$project$OpenApi$Types$decodeOptionalDict,
		'callbacks',
		$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeCallback),
		A3(
			$author$project$OpenApi$Types$decodeOptionalDict,
			'links',
			$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeLink),
			A3(
				$author$project$OpenApi$Types$decodeOptionalDict,
				'securitySchemes',
				$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$SecurityScheme$decode),
				A3(
					$author$project$OpenApi$Types$decodeOptionalDict,
					'headers',
					$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeHeader),
					A3(
						$author$project$OpenApi$Types$decodeOptionalDict,
						'requestBodies',
						$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeRequestBody),
						A3(
							$author$project$OpenApi$Types$decodeOptionalDict,
							'examples',
							$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeExample),
							A3(
								$author$project$OpenApi$Types$decodeOptionalDict,
								'parameters',
								$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeParameter),
								A3(
									$author$project$OpenApi$Types$decodeOptionalDict,
									'responses',
									$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodeResponse),
									A3(
										$author$project$OpenApi$Types$decodeOptionalDict,
										'schemas',
										$author$project$OpenApi$Types$decodeSchema,
										$elm$json$Json$Decode$succeed(
											function (schemas_) {
												return function (responses_) {
													return function (parameters_) {
														return function (examples_) {
															return function (requestBodies_) {
																return function (headers_) {
																	return function (securitySchemes_) {
																		return function (links_) {
																			return function (callbacks_) {
																				return function (pathItems_) {
																					return $author$project$OpenApi$Components$Components(
																						{callbacks: callbacks_, examples: examples_, headers: headers_, links: links_, parameters: parameters_, pathItems: pathItems_, requestBodies: requestBodies_, responses: responses_, schemas: schemas_, securitySchemes: securitySchemes_});
																				};
																			};
																		};
																	};
																};
															};
														};
													};
												};
											})))))))))));
var $author$project$OpenApi$ExternalDocumentation$decode = $author$project$OpenApi$Types$decodeExternalDocumentation;
var $author$project$OpenApi$Info$Info = function (a) {
	return {$: 'Info', a: a};
};
var $author$project$OpenApi$Contact$Contact = function (a) {
	return {$: 'Contact', a: a};
};
var $author$project$OpenApi$Contact$decode = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (name_, url_, email_) {
			return $author$project$OpenApi$Contact$Contact(
				{email: email_, name: name_, url: url_});
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'name', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'url', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'email', $elm$json$Json$Decode$string));
var $author$project$OpenApi$License$JustIdentifier = function (a) {
	return {$: 'JustIdentifier', a: a};
};
var $author$project$OpenApi$License$JustUrl = function (a) {
	return {$: 'JustUrl', a: a};
};
var $author$project$OpenApi$License$License = function (a) {
	return {$: 'License', a: a};
};
var $author$project$OpenApi$License$decode = A3(
	$elm$json$Json$Decode$map2,
	F2(
		function (name_, identifierOrUrl_) {
			return $author$project$OpenApi$License$License(
				{identifierOrUrl: identifierOrUrl_, name: name_});
		}),
	A2($elm$json$Json$Decode$field, 'name', $elm$json$Json$Decode$string),
	A3(
		$author$project$Internal$andThen2,
		F2(
			function (identifier_, url_) {
				var _v0 = _Utils_Tuple2(identifier_, url_);
				if (_v0.a.$ === 'Nothing') {
					if (_v0.b.$ === 'Nothing') {
						var _v1 = _v0.a;
						var _v2 = _v0.b;
						return $elm$json$Json$Decode$succeed($elm$core$Maybe$Nothing);
					} else {
						var _v4 = _v0.a;
						var u = _v0.b.a;
						return $elm$json$Json$Decode$succeed(
							$elm$core$Maybe$Just(
								$author$project$OpenApi$License$JustUrl(u)));
					}
				} else {
					if (_v0.b.$ === 'Nothing') {
						var id = _v0.a.a;
						var _v3 = _v0.b;
						return $elm$json$Json$Decode$succeed(
							$elm$core$Maybe$Just(
								$author$project$OpenApi$License$JustIdentifier(id)));
					} else {
						return $elm$json$Json$Decode$fail('A license is not allowed to have both an identifier and a url');
					}
				}
			}),
		A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'identifier', $elm$json$Json$Decode$string),
		A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'url', $elm$json$Json$Decode$string)));
var $elm$json$Json$Decode$map7 = _Json_map7;
var $author$project$OpenApi$Info$decode = A8(
	$elm$json$Json$Decode$map7,
	F7(
		function (title_, summary_, description_, termsOfService_, contact_, license_, version_) {
			return $author$project$OpenApi$Info$Info(
				{contact: contact_, description: description_, license: license_, summary: summary_, termsOfService: termsOfService_, title: title_, version: version_});
		}),
	A2($elm$json$Json$Decode$field, 'title', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'summary', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'termsOfService', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'contact', $author$project$OpenApi$Contact$decode),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'license', $author$project$OpenApi$License$decode),
	A2($elm$json$Json$Decode$field, 'version', $elm$json$Json$Decode$string));
var $author$project$OpenApi$Server$decode = $author$project$OpenApi$Types$decodeServer;
var $author$project$OpenApi$Tag$Tag = function (a) {
	return {$: 'Tag', a: a};
};
var $author$project$OpenApi$Tag$decode = A4(
	$elm$json$Json$Decode$map3,
	F3(
		function (description_, name_, externalDocs_) {
			return $author$project$OpenApi$Tag$Tag(
				{description: description_, externalDocs: externalDocs_, name: name_});
		}),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'description', $elm$json$Json$Decode$string),
	A2($elm$json$Json$Decode$field, 'name', $elm$json$Json$Decode$string),
	A2($elm_community$json_extra$Json$Decode$Extra$optionalField, 'externalDocs', $author$project$OpenApi$Types$decodeExternalDocumentation));
var $dividat$elm_semver$Semver$Version = F5(
	function (major, minor, patch, prerelease, build) {
		return {build: build, major: major, minor: minor, patch: patch, prerelease: prerelease};
	});
var $elm$parser$Parser$Advanced$Bad = F2(
	function (a, b) {
		return {$: 'Bad', a: a, b: b};
	});
var $elm$parser$Parser$Advanced$Good = F3(
	function (a, b, c) {
		return {$: 'Good', a: a, b: b, c: c};
	});
var $elm$parser$Parser$Advanced$Parser = function (a) {
	return {$: 'Parser', a: a};
};
var $elm$parser$Parser$Advanced$backtrackable = function (_v0) {
	var parse = _v0.a;
	return $elm$parser$Parser$Advanced$Parser(
		function (s0) {
			var _v1 = parse(s0);
			if (_v1.$ === 'Bad') {
				var x = _v1.b;
				return A2($elm$parser$Parser$Advanced$Bad, false, x);
			} else {
				var a = _v1.b;
				var s1 = _v1.c;
				return A3($elm$parser$Parser$Advanced$Good, false, a, s1);
			}
		});
};
var $elm$parser$Parser$backtrackable = $elm$parser$Parser$Advanced$backtrackable;
var $elm$parser$Parser$UnexpectedChar = {$: 'UnexpectedChar'};
var $elm$parser$Parser$Advanced$AddRight = F2(
	function (a, b) {
		return {$: 'AddRight', a: a, b: b};
	});
var $elm$parser$Parser$Advanced$DeadEnd = F4(
	function (row, col, problem, contextStack) {
		return {col: col, contextStack: contextStack, problem: problem, row: row};
	});
var $elm$parser$Parser$Advanced$Empty = {$: 'Empty'};
var $elm$parser$Parser$Advanced$fromState = F2(
	function (s, x) {
		return A2(
			$elm$parser$Parser$Advanced$AddRight,
			$elm$parser$Parser$Advanced$Empty,
			A4($elm$parser$Parser$Advanced$DeadEnd, s.row, s.col, x, s.context));
	});
var $elm$parser$Parser$Advanced$isSubChar = _Parser_isSubChar;
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $elm$parser$Parser$Advanced$chompIf = F2(
	function (isGood, expecting) {
		return $elm$parser$Parser$Advanced$Parser(
			function (s) {
				var newOffset = A3($elm$parser$Parser$Advanced$isSubChar, isGood, s.offset, s.src);
				return _Utils_eq(newOffset, -1) ? A2(
					$elm$parser$Parser$Advanced$Bad,
					false,
					A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : (_Utils_eq(newOffset, -2) ? A3(
					$elm$parser$Parser$Advanced$Good,
					true,
					_Utils_Tuple0,
					{col: 1, context: s.context, indent: s.indent, offset: s.offset + 1, row: s.row + 1, src: s.src}) : A3(
					$elm$parser$Parser$Advanced$Good,
					true,
					_Utils_Tuple0,
					{col: s.col + 1, context: s.context, indent: s.indent, offset: newOffset, row: s.row, src: s.src}));
			});
	});
var $elm$parser$Parser$chompIf = function (isGood) {
	return A2($elm$parser$Parser$Advanced$chompIf, isGood, $elm$parser$Parser$UnexpectedChar);
};
var $elm$parser$Parser$Advanced$chompWhileHelp = F5(
	function (isGood, offset, row, col, s0) {
		chompWhileHelp:
		while (true) {
			var newOffset = A3($elm$parser$Parser$Advanced$isSubChar, isGood, offset, s0.src);
			if (_Utils_eq(newOffset, -1)) {
				return A3(
					$elm$parser$Parser$Advanced$Good,
					_Utils_cmp(s0.offset, offset) < 0,
					_Utils_Tuple0,
					{col: col, context: s0.context, indent: s0.indent, offset: offset, row: row, src: s0.src});
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
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A5($elm$parser$Parser$Advanced$chompWhileHelp, isGood, s.offset, s.row, s.col, s);
		});
};
var $elm$parser$Parser$chompWhile = $elm$parser$Parser$Advanced$chompWhile;
var $elm$core$Basics$always = F2(
	function (a, _v0) {
		return a;
	});
var $elm$parser$Parser$Advanced$mapChompedString = F2(
	function (func, _v0) {
		var parse = _v0.a;
		return $elm$parser$Parser$Advanced$Parser(
			function (s0) {
				var _v1 = parse(s0);
				if (_v1.$ === 'Bad') {
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
							A3($elm$core$String$slice, s0.offset, s1.offset, s0.src),
							a),
						s1);
				}
			});
	});
var $elm$parser$Parser$Advanced$getChompedString = function (parser) {
	return A2($elm$parser$Parser$Advanced$mapChompedString, $elm$core$Basics$always, parser);
};
var $elm$parser$Parser$getChompedString = $elm$parser$Parser$Advanced$getChompedString;
var $elm$parser$Parser$Advanced$map2 = F3(
	function (func, _v0, _v1) {
		var parseA = _v0.a;
		var parseB = _v1.a;
		return $elm$parser$Parser$Advanced$Parser(
			function (s0) {
				var _v2 = parseA(s0);
				if (_v2.$ === 'Bad') {
					var p = _v2.a;
					var x = _v2.b;
					return A2($elm$parser$Parser$Advanced$Bad, p, x);
				} else {
					var p1 = _v2.a;
					var a = _v2.b;
					var s1 = _v2.c;
					var _v3 = parseB(s1);
					if (_v3.$ === 'Bad') {
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
			});
	});
var $elm$parser$Parser$Advanced$ignorer = F2(
	function (keepParser, ignoreParser) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$core$Basics$always, keepParser, ignoreParser);
	});
var $elm$parser$Parser$ignorer = $elm$parser$Parser$Advanced$ignorer;
var $dividat$elm_semver$Semver$isBetween = F3(
	function (low, high, _char) {
		var code = $elm$core$Char$toCode(_char);
		return (_Utils_cmp(
			code,
			$elm$core$Char$toCode(low)) > -1) && (_Utils_cmp(
			code,
			$elm$core$Char$toCode(high)) < 1);
	});
var $dividat$elm_semver$Semver$isDigit = A2(
	$dividat$elm_semver$Semver$isBetween,
	_Utils_chr('0'),
	_Utils_chr('9'));
var $dividat$elm_semver$Semver$isNonDigit = function (c) {
	return _Utils_eq(
		c,
		_Utils_chr('-')) || (A3(
		$dividat$elm_semver$Semver$isBetween,
		_Utils_chr('a'),
		_Utils_chr('z'),
		c) || A3(
		$dividat$elm_semver$Semver$isBetween,
		_Utils_chr('A'),
		_Utils_chr('Z'),
		c));
};
var $dividat$elm_semver$Semver$isIdentifierCharacter = function (c) {
	return $dividat$elm_semver$Semver$isDigit(c) || $dividat$elm_semver$Semver$isNonDigit(c);
};
var $dividat$elm_semver$Semver$alphanumericIdentifier = $elm$parser$Parser$getChompedString(
	A2(
		$elm$parser$Parser$ignorer,
		A2(
			$elm$parser$Parser$ignorer,
			$elm$parser$Parser$backtrackable(
				$elm$parser$Parser$chompWhile($dividat$elm_semver$Semver$isDigit)),
			$elm$parser$Parser$chompIf($dividat$elm_semver$Semver$isNonDigit)),
		$elm$parser$Parser$chompWhile($dividat$elm_semver$Semver$isIdentifierCharacter)));
var $dividat$elm_semver$Semver$digits = $elm$parser$Parser$getChompedString(
	A2(
		$elm$parser$Parser$ignorer,
		$elm$parser$Parser$chompIf($dividat$elm_semver$Semver$isDigit),
		$elm$parser$Parser$chompWhile($dividat$elm_semver$Semver$isDigit)));
var $elm$parser$Parser$Advanced$Append = F2(
	function (a, b) {
		return {$: 'Append', a: a, b: b};
	});
var $elm$parser$Parser$Advanced$oneOfHelp = F3(
	function (s0, bag, parsers) {
		oneOfHelp:
		while (true) {
			if (!parsers.b) {
				return A2($elm$parser$Parser$Advanced$Bad, false, bag);
			} else {
				var parse = parsers.a.a;
				var remainingParsers = parsers.b;
				var _v1 = parse(s0);
				if (_v1.$ === 'Good') {
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
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A3($elm$parser$Parser$Advanced$oneOfHelp, s, $elm$parser$Parser$Advanced$Empty, parsers);
		});
};
var $elm$parser$Parser$oneOf = $elm$parser$Parser$Advanced$oneOf;
var $dividat$elm_semver$Semver$buildMetadataIdentifier = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[$dividat$elm_semver$Semver$alphanumericIdentifier, $dividat$elm_semver$Semver$digits]));
var $elm$parser$Parser$ExpectingEnd = {$: 'ExpectingEnd'};
var $elm$parser$Parser$Advanced$end = function (x) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return _Utils_eq(
				$elm$core$String$length(s.src),
				s.offset) ? A3($elm$parser$Parser$Advanced$Good, false, _Utils_Tuple0, s) : A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, x));
		});
};
var $elm$parser$Parser$end = $elm$parser$Parser$Advanced$end($elm$parser$Parser$ExpectingEnd);
var $elm$parser$Parser$Advanced$andThen = F2(
	function (callback, _v0) {
		var parseA = _v0.a;
		return $elm$parser$Parser$Advanced$Parser(
			function (s0) {
				var _v1 = parseA(s0);
				if (_v1.$ === 'Bad') {
					var p = _v1.a;
					var x = _v1.b;
					return A2($elm$parser$Parser$Advanced$Bad, p, x);
				} else {
					var p1 = _v1.a;
					var a = _v1.b;
					var s1 = _v1.c;
					var _v2 = callback(a);
					var parseB = _v2.a;
					var _v3 = parseB(s1);
					if (_v3.$ === 'Bad') {
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
			});
	});
var $elm$parser$Parser$andThen = $elm$parser$Parser$Advanced$andThen;
var $elm$parser$Parser$Done = function (a) {
	return {$: 'Done', a: a};
};
var $elm$parser$Parser$Loop = function (a) {
	return {$: 'Loop', a: a};
};
var $elm$parser$Parser$Advanced$keeper = F2(
	function (parseFunc, parseArg) {
		return A3($elm$parser$Parser$Advanced$map2, $elm$core$Basics$apL, parseFunc, parseArg);
	});
var $elm$parser$Parser$keeper = $elm$parser$Parser$Advanced$keeper;
var $elm$parser$Parser$Advanced$loopHelp = F4(
	function (p, state, callback, s0) {
		loopHelp:
		while (true) {
			var _v0 = callback(state);
			var parse = _v0.a;
			var _v1 = parse(s0);
			if (_v1.$ === 'Good') {
				var p1 = _v1.a;
				var step = _v1.b;
				var s1 = _v1.c;
				if (step.$ === 'Loop') {
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
		return $elm$parser$Parser$Advanced$Parser(
			function (s) {
				return A4($elm$parser$Parser$Advanced$loopHelp, false, state, callback, s);
			});
	});
var $elm$parser$Parser$Advanced$map = F2(
	function (func, _v0) {
		var parse = _v0.a;
		return $elm$parser$Parser$Advanced$Parser(
			function (s0) {
				var _v1 = parse(s0);
				if (_v1.$ === 'Good') {
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
			});
	});
var $elm$parser$Parser$map = $elm$parser$Parser$Advanced$map;
var $elm$parser$Parser$Advanced$Done = function (a) {
	return {$: 'Done', a: a};
};
var $elm$parser$Parser$Advanced$Loop = function (a) {
	return {$: 'Loop', a: a};
};
var $elm$parser$Parser$toAdvancedStep = function (step) {
	if (step.$ === 'Loop') {
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
var $elm$parser$Parser$Advanced$succeed = function (a) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A3($elm$parser$Parser$Advanced$Good, false, a, s);
		});
};
var $elm$parser$Parser$succeed = $elm$parser$Parser$Advanced$succeed;
var $dividat$elm_semver$Semver$identifierSeriesTail = F2(
	function (identifier, firstItem) {
		return A2(
			$elm$parser$Parser$loop,
			_List_fromArray(
				[firstItem]),
			function (segments) {
				return $elm$parser$Parser$oneOf(
					_List_fromArray(
						[
							A2(
							$elm$parser$Parser$keeper,
							A2(
								$elm$parser$Parser$ignorer,
								$elm$parser$Parser$succeed(
									function (item) {
										return $elm$parser$Parser$Loop(
											A2($elm$core$List$cons, item, segments));
									}),
								$elm$parser$Parser$chompIf(
									$elm$core$Basics$eq(
										_Utils_chr('.')))),
							identifier),
							$elm$parser$Parser$succeed(
							$elm$parser$Parser$Done(
								$elm$core$List$reverse(segments)))
						]));
			});
	});
var $dividat$elm_semver$Semver$identifierSeries = F2(
	function (identifier, seperator) {
		return A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$succeed($elm$core$Basics$identity),
				seperator),
			A2(
				$elm$parser$Parser$andThen,
				$dividat$elm_semver$Semver$identifierSeriesTail(identifier),
				identifier));
	});
var $dividat$elm_semver$Semver$isPositiveDigit = A2(
	$dividat$elm_semver$Semver$isBetween,
	_Utils_chr('1'),
	_Utils_chr('9'));
var $dividat$elm_semver$Semver$numericIdentifier = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[
			$elm$parser$Parser$getChompedString(
			A2(
				$elm$parser$Parser$ignorer,
				$elm$parser$Parser$chompIf($dividat$elm_semver$Semver$isPositiveDigit),
				$elm$parser$Parser$chompWhile($dividat$elm_semver$Semver$isDigit))),
			$elm$parser$Parser$getChompedString(
			$elm$parser$Parser$chompIf(
				$elm$core$Basics$eq(
					_Utils_chr('0'))))
		]));
var $elm$parser$Parser$Problem = function (a) {
	return {$: 'Problem', a: a};
};
var $elm$parser$Parser$Advanced$problem = function (x) {
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			return A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, x));
		});
};
var $elm$parser$Parser$problem = function (msg) {
	return $elm$parser$Parser$Advanced$problem(
		$elm$parser$Parser$Problem(msg));
};
var $elm$core$String$toInt = _String_toInt;
var $dividat$elm_semver$Semver$nat = A2(
	$elm$parser$Parser$andThen,
	function (natStr) {
		var _v0 = $elm$core$String$toInt(natStr);
		if (_v0.$ === 'Just') {
			var num = _v0.a;
			return $elm$parser$Parser$succeed(num);
		} else {
			return $elm$parser$Parser$problem('Not a natural number: ' + natStr);
		}
	},
	A2(
		$elm$parser$Parser$keeper,
		$elm$parser$Parser$succeed($elm$core$Basics$identity),
		$dividat$elm_semver$Semver$numericIdentifier));
var $dividat$elm_semver$Semver$preReleaseIdentifier = $elm$parser$Parser$oneOf(
	_List_fromArray(
		[$dividat$elm_semver$Semver$alphanumericIdentifier, $dividat$elm_semver$Semver$numericIdentifier]));
var $elm$parser$Parser$ExpectingSymbol = function (a) {
	return {$: 'ExpectingSymbol', a: a};
};
var $elm$parser$Parser$Advanced$Token = F2(
	function (a, b) {
		return {$: 'Token', a: a, b: b};
	});
var $elm$core$String$isEmpty = function (string) {
	return string === '';
};
var $elm$parser$Parser$Advanced$isSubString = _Parser_isSubString;
var $elm$parser$Parser$Advanced$token = function (_v0) {
	var str = _v0.a;
	var expecting = _v0.b;
	var progress = !$elm$core$String$isEmpty(str);
	return $elm$parser$Parser$Advanced$Parser(
		function (s) {
			var _v1 = A5($elm$parser$Parser$Advanced$isSubString, str, s.offset, s.row, s.col, s.src);
			var newOffset = _v1.a;
			var newRow = _v1.b;
			var newCol = _v1.c;
			return _Utils_eq(newOffset, -1) ? A2(
				$elm$parser$Parser$Advanced$Bad,
				false,
				A2($elm$parser$Parser$Advanced$fromState, s, expecting)) : A3(
				$elm$parser$Parser$Advanced$Good,
				progress,
				_Utils_Tuple0,
				{col: newCol, context: s.context, indent: s.indent, offset: newOffset, row: newRow, src: s.src});
		});
};
var $elm$parser$Parser$Advanced$symbol = $elm$parser$Parser$Advanced$token;
var $elm$parser$Parser$symbol = function (str) {
	return $elm$parser$Parser$Advanced$symbol(
		A2(
			$elm$parser$Parser$Advanced$Token,
			str,
			$elm$parser$Parser$ExpectingSymbol(str)));
};
var $dividat$elm_semver$Semver$parser = A2(
	$elm$parser$Parser$keeper,
	A2(
		$elm$parser$Parser$keeper,
		A2(
			$elm$parser$Parser$keeper,
			A2(
				$elm$parser$Parser$keeper,
				A2(
					$elm$parser$Parser$keeper,
					$elm$parser$Parser$succeed($dividat$elm_semver$Semver$Version),
					A2(
						$elm$parser$Parser$ignorer,
						$dividat$elm_semver$Semver$nat,
						$elm$parser$Parser$symbol('.'))),
				A2(
					$elm$parser$Parser$ignorer,
					$dividat$elm_semver$Semver$nat,
					$elm$parser$Parser$symbol('.'))),
			$dividat$elm_semver$Semver$nat),
		$elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$dividat$elm_semver$Semver$identifierSeries,
					$dividat$elm_semver$Semver$preReleaseIdentifier,
					$elm$parser$Parser$symbol('-')),
					$elm$parser$Parser$succeed(_List_Nil)
				]))),
	A2(
		$elm$parser$Parser$ignorer,
		$elm$parser$Parser$oneOf(
			_List_fromArray(
				[
					A2(
					$dividat$elm_semver$Semver$identifierSeries,
					$dividat$elm_semver$Semver$buildMetadataIdentifier,
					$elm$parser$Parser$symbol('+')),
					$elm$parser$Parser$succeed(_List_Nil)
				])),
		$elm$parser$Parser$end));
var $elm$parser$Parser$DeadEnd = F3(
	function (row, col, problem) {
		return {col: col, problem: problem, row: row};
	});
var $elm$parser$Parser$problemToDeadEnd = function (p) {
	return A3($elm$parser$Parser$DeadEnd, p.row, p.col, p.problem);
};
var $elm$parser$Parser$Advanced$bagToList = F2(
	function (bag, list) {
		bagToList:
		while (true) {
			switch (bag.$) {
				case 'Empty':
					return list;
				case 'AddRight':
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
		var parse = _v0.a;
		var _v1 = parse(
			{col: 1, context: _List_Nil, indent: 1, offset: 0, row: 1, src: src});
		if (_v1.$ === 'Good') {
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
		if (_v0.$ === 'Ok') {
			var a = _v0.a;
			return $elm$core$Result$Ok(a);
		} else {
			var problems = _v0.a;
			return $elm$core$Result$Err(
				A2($elm$core$List$map, $elm$parser$Parser$problemToDeadEnd, problems));
		}
	});
var $elm$core$Result$toMaybe = function (result) {
	if (result.$ === 'Ok') {
		var v = result.a;
		return $elm$core$Maybe$Just(v);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $dividat$elm_semver$Semver$parse = function (versionString) {
	return $elm$core$Result$toMaybe(
		A2($elm$parser$Parser$run, $dividat$elm_semver$Semver$parser, versionString));
};
var $author$project$OpenApi$decodeVersion = A2(
	$elm$json$Json$Decode$andThen,
	function (str) {
		var _v0 = $dividat$elm_semver$Semver$parse(str);
		if (_v0.$ === 'Nothing') {
			return $elm$json$Json$Decode$fail('Invalid version format');
		} else {
			var version_ = _v0.a;
			return $elm$json$Json$Decode$succeed(version_);
		}
	},
	$elm$json$Json$Decode$string);
var $author$project$OpenApi$decode = A4(
	$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
	'webhooks',
	$elm$json$Json$Decode$dict(
		$author$project$OpenApi$Types$decodeRefOr($author$project$OpenApi$Types$decodePath)),
	$elm$core$Dict$empty,
	A4(
		$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
		'security',
		$elm$json$Json$Decode$list($author$project$OpenApi$Types$decodeSecurityRequirement),
		_List_Nil,
		A4(
			$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
			'paths',
			$elm$json$Json$Decode$dict($author$project$OpenApi$Types$decodePath),
			$elm$core$Dict$empty,
			A3(
				$author$project$OpenApi$Types$optionalNothing,
				'components',
				$author$project$OpenApi$Components$decode,
				A4(
					$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
					'servers',
					$elm$json$Json$Decode$list($author$project$OpenApi$Server$decode),
					_List_Nil,
					A4(
						$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$optional,
						'tags',
						$elm$json$Json$Decode$list($author$project$OpenApi$Tag$decode),
						_List_Nil,
						A3(
							$author$project$OpenApi$Types$optionalNothing,
							'externalDocs',
							$author$project$OpenApi$ExternalDocumentation$decode,
							A3(
								$author$project$OpenApi$Types$optionalNothing,
								'jsonSchemaDialect',
								$elm$json$Json$Decode$string,
								A3(
									$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
									'info',
									$author$project$OpenApi$Info$decode,
									A3(
										$NoRedInk$elm_json_decode_pipeline$Json$Decode$Pipeline$required,
										'openapi',
										$author$project$OpenApi$decodeVersion,
										$elm$json$Json$Decode$succeed(
											function (version_) {
												return function (info_) {
													return function (jsonSchemaDialect_) {
														return function (externalDocs_) {
															return function (tags_) {
																return function (servers_) {
																	return function (components_) {
																		return function (paths_) {
																			return function (security_) {
																				return function (webhooks_) {
																					return $author$project$OpenApi$OpenApi(
																						{components: components_, externalDocs: externalDocs_, info: info_, jsonSchemaDialect: jsonSchemaDialect_, paths: paths_, security: security_, servers: servers_, tags: tags_, version: version_, webhooks: webhooks_});
																				};
																			};
																		};
																	};
																};
															};
														};
													};
												};
											})))))))))));
var $mdgriffith$elm_codegen$Elm$Annotation$function = F2(
	function (anns, _return) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Annotation(
			{
				aliases: A3(
					$elm$core$List$foldl,
					F2(
						function (ann, aliases) {
							return A2(
								$mdgriffith$elm_codegen$Internal$Compiler$mergeAliases,
								$mdgriffith$elm_codegen$Elm$Annotation$getAliases(ann),
								aliases);
						}),
					$mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
					A2($elm$core$List$cons, _return, anns)),
				annotation: A3(
					$elm$core$List$foldr,
					F2(
						function (ann, fn) {
							return A2(
								$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(ann),
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(fn));
						}),
					$mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation(_return),
					A2($elm$core$List$map, $mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation, anns)),
				imports: _Utils_ap(
					$mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports(_return),
					A2($elm$core$List$concatMap, $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports, anns))
			});
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression = function (a) {
	return {$: 'LambdaExpression', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$VarPattern = function (a) {
	return {$: 'VarPattern', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue = F2(
	function (a, b) {
		return {$: 'FunctionOrValue', a: a, b: b};
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$RecordAccessFunction = function (a) {
	return {$: 'RecordAccessFunction', a: a};
};
var $mdgriffith$elm_codegen$Elm$popLastAndDenodeLast = function (lst) {
	var _v0 = $elm$core$List$reverse(lst);
	if (!_v0.b) {
		return $elm$core$Maybe$Nothing;
	} else {
		var last = _v0.a;
		var initReverse = _v0.b;
		return $elm$core$Maybe$Just(
			_Utils_Tuple2(
				$elm$core$List$reverse(initReverse),
				$mdgriffith$elm_codegen$Internal$Compiler$denode(last)));
	}
};
var $mdgriffith$elm_codegen$Elm$betaReduce = function (e) {
	var extractLastArg = function (arg) {
		_v0$2:
		while (true) {
			switch (arg.$) {
				case 'FunctionOrValue':
					if (!arg.a.b) {
						var n = arg.b;
						return $elm$core$Maybe$Just(n);
					} else {
						break _v0$2;
					}
				case 'ParenthesizedExpression':
					var p = arg.a;
					return extractLastArg(
						$mdgriffith$elm_codegen$Internal$Compiler$denode(p));
				default:
					break _v0$2;
			}
		}
		return $elm$core$Maybe$Nothing;
	};
	if (e.$ === 'LambdaExpression') {
		var expression = e.a.expression;
		var args = e.a.args;
		var _v2 = $mdgriffith$elm_codegen$Elm$popLastAndDenodeLast(args);
		if ((_v2.$ === 'Just') && (_v2.a.b.$ === 'VarPattern')) {
			var _v3 = _v2.a;
			var initLambdaArgs = _v3.a;
			var lastLambdaArg = _v3.b.a;
			var _v4 = $mdgriffith$elm_codegen$Internal$Compiler$denode(expression);
			switch (_v4.$) {
				case 'RecordAccess':
					var argNode = _v4.a;
					var fieldNode = _v4.b;
					var fieldName = $mdgriffith$elm_codegen$Internal$Compiler$denode(fieldNode);
					var arg = $mdgriffith$elm_codegen$Internal$Compiler$denode(argNode);
					if ((arg.$ === 'FunctionOrValue') && (!arg.a.b)) {
						var argName = arg.b;
						return _Utils_eq(argName, lastLambdaArg) ? $stil4m$elm_syntax$Elm$Syntax$Expression$RecordAccessFunction('.' + fieldName) : e;
					} else {
						return e;
					}
				case 'Application':
					var applicationArgs = _v4.a;
					var _v6 = $mdgriffith$elm_codegen$Elm$popLastAndDenodeLast(applicationArgs);
					if (_v6.$ === 'Just') {
						if (!_v6.a.a.b) {
							var _v7 = _v6.a;
							var uniqueApplicationArg = _v7.b;
							return _Utils_eq(
								extractLastArg(uniqueApplicationArg),
								$elm$core$Maybe$Just(lastLambdaArg)) ? A2($stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue, _List_Nil, 'identity') : e;
						} else {
							var _v8 = _v6.a;
							var initApplicationArgs = _v8.a;
							var lastApplicationArg = _v8.b;
							if (_Utils_eq(
								extractLastArg(lastApplicationArg),
								$elm$core$Maybe$Just(lastLambdaArg))) {
								if ($elm$core$List$isEmpty(initLambdaArgs)) {
									if (initApplicationArgs.b && (!initApplicationArgs.b.b)) {
										var s = initApplicationArgs.a;
										return $mdgriffith$elm_codegen$Elm$betaReduce(
											$mdgriffith$elm_codegen$Internal$Compiler$denode(s));
									} else {
										return $stil4m$elm_syntax$Elm$Syntax$Expression$Application(initApplicationArgs);
									}
								} else {
									return $mdgriffith$elm_codegen$Elm$betaReduce(
										$stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression(
											{
												args: initLambdaArgs,
												expression: $mdgriffith$elm_codegen$Internal$Compiler$nodify(
													$stil4m$elm_syntax$Elm$Syntax$Expression$Application(initApplicationArgs))
											}));
								}
							} else {
								return e;
							}
						}
					} else {
						return e;
					}
				default:
					return e;
			}
		} else {
			return e;
		}
	} else {
		return e;
	}
};
var $mdgriffith$elm_codegen$Internal$Index$indexToString = function (_v0) {
	var top = _v0.a;
	var tail = _v0.b;
	var scope = _v0.c;
	var check = _v0.d;
	return _Utils_ap(
		(!top) ? '' : ('_' + $elm$core$String$fromInt(top)),
		function () {
			if (!tail.b) {
				return '';
			} else {
				if (!tail.b.b) {
					var one = tail.a;
					return '_' + $elm$core$String$fromInt(one);
				} else {
					if (!tail.b.b.b) {
						var one = tail.a;
						var _v2 = tail.b;
						var two = _v2.a;
						return '_' + ($elm$core$String$fromInt(one) + ('_' + $elm$core$String$fromInt(two)));
					} else {
						if (!tail.b.b.b.b) {
							var one = tail.a;
							var _v3 = tail.b;
							var two = _v3.a;
							var _v4 = _v3.b;
							var three = _v4.a;
							return '_' + ($elm$core$String$fromInt(one) + ('_' + ($elm$core$String$fromInt(two) + ('_' + $elm$core$String$fromInt(three)))));
						} else {
							return '_' + A2(
								$elm$core$String$join,
								'_',
								A2($elm$core$List$map, $elm$core$String$fromInt, tail));
						}
					}
				}
			}
		}());
};
var $mdgriffith$elm_codegen$Internal$Index$getName = F2(
	function (desiredName, index) {
		var top = index.a;
		var tail = index.b;
		var scope = index.c;
		var check = index.d;
		var formattedName = $mdgriffith$elm_codegen$Internal$Format$formatValue(desiredName);
		if (!A2($elm$core$Set$member, formattedName, scope)) {
			return _Utils_Tuple2(
				formattedName,
				A4(
					$mdgriffith$elm_codegen$Internal$Index$Index,
					top,
					tail,
					A2($elm$core$Set$insert, formattedName, scope),
					check));
		} else {
			var protectedName = _Utils_ap(
				formattedName,
				$elm$core$String$fromInt(top));
			if (!A2($elm$core$Set$member, protectedName, scope)) {
				return _Utils_Tuple2(
					protectedName,
					A4(
						$mdgriffith$elm_codegen$Internal$Index$Index,
						top + 1,
						tail,
						A2($elm$core$Set$insert, protectedName, scope),
						check));
			} else {
				var protectedNameLevel2 = _Utils_ap(
					formattedName,
					$mdgriffith$elm_codegen$Internal$Index$indexToString(index));
				return _Utils_Tuple2(
					protectedNameLevel2,
					A4(
						$mdgriffith$elm_codegen$Internal$Index$Index,
						top + 1,
						tail,
						A2($elm$core$Set$insert, protectedNameLevel2, scope),
						check));
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$mapNode = F2(
	function (fn, _v0) {
		var range = _v0.a;
		var n = _v0.b;
		return A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			range,
			fn(n));
	});
var $mdgriffith$elm_codegen$Internal$Compiler$protectAnnotation = F2(
	function (index, ann) {
		switch (ann.$) {
			case 'GenericType':
				var str = ann.a;
				return $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(
					_Utils_ap(
						str,
						$mdgriffith$elm_codegen$Internal$Index$indexToString(index)));
			case 'Typed':
				var modName = ann.a;
				var anns = ann.b;
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
					modName,
					A2(
						$elm$core$List$map,
						$mdgriffith$elm_codegen$Internal$Compiler$mapNode(
							$mdgriffith$elm_codegen$Internal$Compiler$protectAnnotation(index)),
						anns));
			case 'Unit':
				return $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Unit;
			case 'Tupled':
				var tupled = ann.a;
				return $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled(
					A2(
						$elm$core$List$map,
						$mdgriffith$elm_codegen$Internal$Compiler$mapNode(
							$mdgriffith$elm_codegen$Internal$Compiler$protectAnnotation(index)),
						tupled));
			case 'Record':
				var recordDefinition = ann.a;
				return $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(
					A2(
						$elm$core$List$map,
						$mdgriffith$elm_codegen$Internal$Compiler$protectField(index),
						recordDefinition));
			case 'GenericRecord':
				var recordName = ann.a;
				var _v3 = ann.b;
				var recordRange = _v3.a;
				var recordDefinition = _v3.b;
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord,
					A2(
						$mdgriffith$elm_codegen$Internal$Compiler$mapNode,
						function (n) {
							return _Utils_ap(
								n,
								$mdgriffith$elm_codegen$Internal$Index$indexToString(index));
						},
						recordName),
					A2(
						$stil4m$elm_syntax$Elm$Syntax$Node$Node,
						recordRange,
						A2(
							$elm$core$List$map,
							$mdgriffith$elm_codegen$Internal$Compiler$protectField(index),
							recordDefinition)));
			default:
				var one = ann.a;
				var two = ann.b;
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
					A2(
						$mdgriffith$elm_codegen$Internal$Compiler$mapNode,
						$mdgriffith$elm_codegen$Internal$Compiler$protectAnnotation(index),
						one),
					A2(
						$mdgriffith$elm_codegen$Internal$Compiler$mapNode,
						$mdgriffith$elm_codegen$Internal$Compiler$protectAnnotation(index),
						two));
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$protectField = F2(
	function (index, _v0) {
		var nodeRange = _v0.a;
		var _v1 = _v0.b;
		var nodedName = _v1.a;
		var nodedType = _v1.b;
		return A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			nodeRange,
			_Utils_Tuple2(
				nodedName,
				A2(
					$mdgriffith$elm_codegen$Internal$Compiler$mapNode,
					$mdgriffith$elm_codegen$Internal$Compiler$protectAnnotation(index),
					nodedType)));
	});
var $mdgriffith$elm_codegen$Internal$Compiler$getInnerInference = F2(
	function (index, _v0) {
		var details = _v0.a;
		return {
			aliases: details.aliases,
			inferences: $elm$core$Dict$empty,
			type_: A2($mdgriffith$elm_codegen$Internal$Compiler$protectAnnotation, index, details.annotation)
		};
	});
var $mdgriffith$elm_codegen$Internal$Index$protectTypeName = F2(
	function (base, index) {
		var top = index.a;
		var tail = index.b;
		var scope = index.c;
		var check = index.d;
		if (!tail.b) {
			return $mdgriffith$elm_codegen$Internal$Format$formatValue(base);
		} else {
			return $mdgriffith$elm_codegen$Internal$Format$formatValue(
				_Utils_ap(
					base,
					$mdgriffith$elm_codegen$Internal$Index$indexToString(index)));
		}
	});
var $mdgriffith$elm_codegen$Elm$value = function (details) {
	return $mdgriffith$elm_codegen$Internal$Compiler$Expression(
		function (index) {
			return {
				annotation: function () {
					var _v0 = details.annotation;
					if (_v0.$ === 'Nothing') {
						var typename = A2($mdgriffith$elm_codegen$Internal$Index$protectTypeName, details.name, index);
						return $elm$core$Result$Ok(
							{
								aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
								inferences: $elm$core$Dict$empty,
								type_: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(typename)
							});
					} else {
						var ann = _v0.a;
						return $elm$core$Result$Ok(
							A2($mdgriffith$elm_codegen$Internal$Compiler$getInnerInference, index, ann));
					}
				}(),
				expression: A2(
					$stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue,
					details.importFrom,
					$mdgriffith$elm_codegen$Internal$Format$sanitize(details.name)),
				imports: function () {
					var _v1 = details.annotation;
					if (_v1.$ === 'Nothing') {
						var _v2 = details.importFrom;
						if (!_v2.b) {
							return _List_Nil;
						} else {
							return _List_fromArray(
								[details.importFrom]);
						}
					} else {
						var ann = _v1.a;
						var _v3 = details.importFrom;
						if (!_v3.b) {
							return $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports(ann);
						} else {
							return A2(
								$elm$core$List$cons,
								details.importFrom,
								$mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports(ann));
						}
					}
				}()
			};
		});
};
var $mdgriffith$elm_codegen$Elm$Annotation$var = function (a) {
	return $mdgriffith$elm_codegen$Internal$Compiler$Annotation(
		{
			aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
			annotation: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(
				$mdgriffith$elm_codegen$Internal$Format$formatValue(a)),
			imports: _List_Nil
		});
};
var $mdgriffith$elm_codegen$Elm$functionReduced = F2(
	function (argBaseName, toExpression) {
		return $mdgriffith$elm_codegen$Internal$Compiler$expression(
			function (index) {
				var _v0 = A2($mdgriffith$elm_codegen$Internal$Index$getName, argBaseName, index);
				var arg1Name = _v0.a;
				var newIndex = _v0.b;
				var argType = $mdgriffith$elm_codegen$Elm$Annotation$var(arg1Name);
				var arg1 = $mdgriffith$elm_codegen$Elm$value(
					{
						annotation: $elm$core$Maybe$Just(argType),
						importFrom: _List_Nil,
						name: arg1Name
					});
				var _v1 = toExpression(arg1);
				var toExpr = _v1.a;
				var _return = toExpr(newIndex);
				return {
					annotation: function () {
						var _v2 = _return.annotation;
						if (_v2.$ === 'Err') {
							var err = _v2.a;
							return _return.annotation;
						} else {
							var returnAnnotation = _v2.a;
							return $elm$core$Result$Ok(
								{
									aliases: returnAnnotation.aliases,
									inferences: returnAnnotation.inferences,
									type_: A2(
										$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
										$mdgriffith$elm_codegen$Internal$Compiler$nodify(
											$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(arg1Name)),
										$mdgriffith$elm_codegen$Internal$Compiler$nodify(returnAnnotation.type_))
								});
						}
					}(),
					expression: $mdgriffith$elm_codegen$Elm$betaReduce(
						$stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression(
							{
								args: _List_fromArray(
									[
										$mdgriffith$elm_codegen$Internal$Compiler$nodify(
										$stil4m$elm_syntax$Elm$Syntax$Pattern$VarPattern(arg1Name))
									]),
								expression: $mdgriffith$elm_codegen$Internal$Compiler$nodify(_return.expression)
							})),
					imports: _return.imports
				};
			});
	});
var $author$project$Gen$Http$expectJson = F2(
	function (expectJsonArg, expectJsonArg0) {
		return A2(
			$mdgriffith$elm_codegen$Elm$apply,
			$mdgriffith$elm_codegen$Elm$value(
				{
					annotation: $elm$core$Maybe$Just(
						A2(
							$mdgriffith$elm_codegen$Elm$Annotation$function,
							_List_fromArray(
								[
									A2(
									$mdgriffith$elm_codegen$Elm$Annotation$function,
									_List_fromArray(
										[
											A3(
											$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
											_List_fromArray(
												['Result']),
											'Result',
											_List_fromArray(
												[
													A3(
													$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
													_List_fromArray(
														['Http']),
													'Error',
													_List_Nil),
													$mdgriffith$elm_codegen$Elm$Annotation$var('a')
												]))
										]),
									$mdgriffith$elm_codegen$Elm$Annotation$var('msg')),
									A3(
									$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
									_List_fromArray(
										['Json', 'Decode']),
									'Decoder',
									_List_fromArray(
										[
											$mdgriffith$elm_codegen$Elm$Annotation$var('a')
										]))
								]),
							A3(
								$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
								_List_fromArray(
									['Http']),
								'Expect',
								_List_fromArray(
									[
										$mdgriffith$elm_codegen$Elm$Annotation$var('msg')
									])))),
					importFrom: _List_fromArray(
						['Http']),
					name: 'expectJson'
				}),
			_List_fromArray(
				[
					A2($mdgriffith$elm_codegen$Elm$functionReduced, 'expectJsonUnpack', expectJsonArg),
					expectJsonArg0
				]));
	});
var $stil4m$elm_syntax$Elm$Syntax$Exposing$All = function (a) {
	return {$: 'All', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit = function (a) {
	return {$: 'Explicit', a: a};
};
var $mdgriffith$elm_codegen$Internal$Comments$Markdown = function (a) {
	return {$: 'Markdown', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Module$NormalModule = function (a) {
	return {$: 'NormalModule', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Module$PortModule = function (a) {
	return {$: 'PortModule', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$RenderedBlock = function (a) {
	return {$: 'RenderedBlock', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$RenderedComment = function (a) {
	return {$: 'RenderedComment', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$RenderedDecl = function (a) {
	return {$: 'RenderedDecl', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Declaration$CustomTypeDeclaration = function (a) {
	return {$: 'CustomTypeDeclaration', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration = function (a) {
	return {$: 'FunctionDeclaration', a: a};
};
var $mdgriffith$elm_codegen$Internal$Render$addDocs = F2(
	function (maybeDoc, decl) {
		if (maybeDoc.$ === 'Nothing') {
			return decl;
		} else {
			var doc = maybeDoc.a;
			switch (decl.$) {
				case 'FunctionDeclaration':
					var func = decl.a;
					return $stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration(
						_Utils_update(
							func,
							{
								documentation: $elm$core$Maybe$Just(
									$mdgriffith$elm_codegen$Internal$Compiler$nodify(doc))
							}));
				case 'AliasDeclaration':
					var typealias = decl.a;
					return $stil4m$elm_syntax$Elm$Syntax$Declaration$AliasDeclaration(
						_Utils_update(
							typealias,
							{
								documentation: $elm$core$Maybe$Just(
									$mdgriffith$elm_codegen$Internal$Compiler$nodify(doc))
							}));
				case 'CustomTypeDeclaration':
					var typeDecl = decl.a;
					return $stil4m$elm_syntax$Elm$Syntax$Declaration$CustomTypeDeclaration(
						_Utils_update(
							typeDecl,
							{
								documentation: $elm$core$Maybe$Just(
									$mdgriffith$elm_codegen$Internal$Compiler$nodify(doc))
							}));
				case 'PortDeclaration':
					var sig = decl.a;
					return decl;
				case 'InfixDeclaration':
					return decl;
				default:
					return decl;
			}
		}
	});
var $stil4m$elm_syntax$Elm$Syntax$Exposing$FunctionExpose = function (a) {
	return {$: 'FunctionExpose', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose = function (a) {
	return {$: 'TypeExpose', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Exposing$TypeOrAliasExpose = function (a) {
	return {$: 'TypeOrAliasExpose', a: a};
};
var $mdgriffith$elm_codegen$Internal$Render$addExposed = F3(
	function (exposed, declaration, otherExposes) {
		if (exposed.$ === 'NotExposed') {
			return otherExposes;
		} else {
			var details = exposed.a;
			switch (declaration.$) {
				case 'FunctionDeclaration':
					var fn = declaration.a;
					var fnName = $mdgriffith$elm_codegen$Internal$Compiler$denode(
						function ($) {
							return $.name;
						}(
							$mdgriffith$elm_codegen$Internal$Compiler$denode(fn.declaration)));
					return A2(
						$elm$core$List$cons,
						$stil4m$elm_syntax$Elm$Syntax$Exposing$FunctionExpose(fnName),
						otherExposes);
				case 'AliasDeclaration':
					var synonym = declaration.a;
					var aliasName = $mdgriffith$elm_codegen$Internal$Compiler$denode(synonym.name);
					return A2(
						$elm$core$List$cons,
						$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeOrAliasExpose(aliasName),
						otherExposes);
				case 'CustomTypeDeclaration':
					var myType = declaration.a;
					var typeName = $mdgriffith$elm_codegen$Internal$Compiler$denode(myType.name);
					return details.exposeConstructor ? A2(
						$elm$core$List$cons,
						$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeExpose(
							{
								name: typeName,
								open: $elm$core$Maybe$Just($stil4m$elm_syntax$Elm$Syntax$Range$emptyRange)
							}),
						otherExposes) : A2(
						$elm$core$List$cons,
						$stil4m$elm_syntax$Elm$Syntax$Exposing$TypeOrAliasExpose(typeName),
						otherExposes);
				case 'PortDeclaration':
					var myPort = declaration.a;
					var typeName = $mdgriffith$elm_codegen$Internal$Compiler$denode(myPort.name);
					return A2(
						$elm$core$List$cons,
						$stil4m$elm_syntax$Elm$Syntax$Exposing$FunctionExpose(typeName),
						otherExposes);
				case 'InfixDeclaration':
					var inf = declaration.a;
					return otherExposes;
				default:
					return otherExposes;
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Comments$Comment = function (a) {
	return {$: 'Comment', a: a};
};
var $mdgriffith$elm_codegen$Internal$Comments$addPart = F2(
	function (_v0, part) {
		var parts = _v0.a;
		return $mdgriffith$elm_codegen$Internal$Comments$Comment(
			A2($elm$core$List$cons, part, parts));
	});
var $mdgriffith$elm_codegen$Internal$Compiler$fullModName = function (name) {
	return A2($elm$core$String$join, '.', name);
};
var $mdgriffith$elm_codegen$Internal$Render$dedupImports = function (mods) {
	return A2(
		$elm$core$List$sortBy,
		$mdgriffith$elm_codegen$Internal$Compiler$fullModName,
		A3(
			$elm$core$List$foldl,
			F2(
				function (mod, _v0) {
					var set = _v0.a;
					var gathered = _v0.b;
					var stringName = $mdgriffith$elm_codegen$Internal$Compiler$fullModName(mod);
					return A2($elm$core$Set$member, stringName, set) ? _Utils_Tuple2(set, gathered) : _Utils_Tuple2(
						A2($elm$core$Set$insert, stringName, set),
						A2($elm$core$List$cons, mod, gathered));
				}),
			_Utils_Tuple2($elm$core$Set$empty, _List_Nil),
			mods).b);
};
var $mdgriffith$elm_codegen$Internal$Comments$emptyComment = $mdgriffith$elm_codegen$Internal$Comments$Comment(_List_Nil);
var $elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _v0 = f(mx);
		if (_v0.$ === 'Just') {
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
var $mdgriffith$elm_codegen$Internal$Render$matchName = F2(
	function (one, two) {
		if (one.$ === 'Nothing') {
			if (two.$ === 'Nothing') {
				return true;
			} else {
				return false;
			}
		} else {
			var oneName = one.a;
			if (two.$ === 'Nothing') {
				return false;
			} else {
				var twoName = two.a;
				return _Utils_eq(oneName, twoName);
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Render$groupExposing = function (items) {
	return A3(
		$elm$core$List$foldr,
		F2(
			function (_v0, acc) {
				var maybeGroup = _v0.a;
				var name = _v0.b;
				if (!acc.b) {
					return _List_fromArray(
						[
							{
							group: maybeGroup,
							members: _List_fromArray(
								[name])
						}
						]);
				} else {
					var top = acc.a;
					var groups = acc.b;
					return A2($mdgriffith$elm_codegen$Internal$Render$matchName, maybeGroup, top.group) ? A2(
						$elm$core$List$cons,
						{
							group: top.group,
							members: A2($elm$core$List$cons, name, top.members)
						},
						groups) : A2(
						$elm$core$List$cons,
						{
							group: maybeGroup,
							members: _List_fromArray(
								[name])
						},
						acc);
				}
			}),
		_List_Nil,
		items);
};
var $mdgriffith$elm_codegen$Internal$Compiler$builtIn = function (name) {
	_v0$4:
	while (true) {
		if (name.b && (!name.b.b)) {
			switch (name.a) {
				case 'List':
					return true;
				case 'Maybe':
					return true;
				case 'String':
					return true;
				case 'Basics':
					return true;
				default:
					break _v0$4;
			}
		} else {
			break _v0$4;
		}
	}
	return false;
};
var $mdgriffith$elm_codegen$Internal$Compiler$findAlias = F2(
	function (modName, aliases) {
		findAlias:
		while (true) {
			if (!aliases.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				var _v1 = aliases.a;
				var aliasModName = _v1.a;
				var alias = _v1.b;
				var remain = aliases.b;
				if (_Utils_eq(modName, aliasModName)) {
					return $elm$core$Maybe$Just(alias);
				} else {
					var $temp$modName = modName,
						$temp$aliases = remain;
					modName = $temp$modName;
					aliases = $temp$aliases;
					continue findAlias;
				}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$makeImport = F2(
	function (aliases, name) {
		if (!name.b) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v1 = A2($mdgriffith$elm_codegen$Internal$Compiler$findAlias, name, aliases);
			if (_v1.$ === 'Nothing') {
				return $mdgriffith$elm_codegen$Internal$Compiler$builtIn(name) ? $elm$core$Maybe$Nothing : $elm$core$Maybe$Just(
					{
						exposingList: $elm$core$Maybe$Nothing,
						moduleAlias: $elm$core$Maybe$Nothing,
						moduleName: $mdgriffith$elm_codegen$Internal$Compiler$nodify(name)
					});
			} else {
				var alias = _v1.a;
				return $elm$core$Maybe$Just(
					{
						exposingList: $elm$core$Maybe$Nothing,
						moduleAlias: $elm$core$Maybe$Just(
							$mdgriffith$elm_codegen$Internal$Compiler$nodify(
								_List_fromArray(
									[alias]))),
						moduleName: $mdgriffith$elm_codegen$Internal$Compiler$nodify(name)
					});
			}
		}
	});
var $the_sett$elm_pretty_printer$Internals$Concatenate = F2(
	function (a, b) {
		return {$: 'Concatenate', a: a, b: b};
	});
var $the_sett$elm_pretty_printer$Pretty$append = F2(
	function (doc1, doc2) {
		return A2(
			$the_sett$elm_pretty_printer$Internals$Concatenate,
			function (_v0) {
				return doc1;
			},
			function (_v1) {
				return doc2;
			});
	});
var $elm_community$basics_extra$Basics$Extra$flip = F3(
	function (f, b, a) {
		return A2(f, a, b);
	});
var $the_sett$elm_pretty_printer$Pretty$a = $elm_community$basics_extra$Basics$Extra$flip($the_sett$elm_pretty_printer$Pretty$append);
var $the_sett$elm_pretty_printer$Internals$Line = F2(
	function (a, b) {
		return {$: 'Line', a: a, b: b};
	});
var $the_sett$elm_pretty_printer$Pretty$line = A2($the_sett$elm_pretty_printer$Internals$Line, ' ', '');
var $the_sett$elm_pretty_printer$Internals$Empty = {$: 'Empty'};
var $the_sett$elm_pretty_printer$Pretty$empty = $the_sett$elm_pretty_printer$Internals$Empty;
var $the_sett$elm_pretty_printer$Pretty$join = F2(
	function (sep, docs) {
		join:
		while (true) {
			if (!docs.b) {
				return $the_sett$elm_pretty_printer$Pretty$empty;
			} else {
				if (docs.a.$ === 'Empty') {
					var _v1 = docs.a;
					var ds = docs.b;
					var $temp$sep = sep,
						$temp$docs = ds;
					sep = $temp$sep;
					docs = $temp$docs;
					continue join;
				} else {
					var d = docs.a;
					var ds = docs.b;
					var step = F2(
						function (x, rest) {
							if (x.$ === 'Empty') {
								return rest;
							} else {
								var doc = x;
								return A2(
									$the_sett$elm_pretty_printer$Pretty$append,
									sep,
									A2($the_sett$elm_pretty_printer$Pretty$append, doc, rest));
							}
						});
					var spersed = A3($elm$core$List$foldr, step, $the_sett$elm_pretty_printer$Pretty$empty, ds);
					return A2($the_sett$elm_pretty_printer$Pretty$append, d, spersed);
				}
			}
		}
	});
var $the_sett$elm_pretty_printer$Pretty$lines = $the_sett$elm_pretty_printer$Pretty$join($the_sett$elm_pretty_printer$Pretty$line);
var $elm$core$Maybe$map = F2(
	function (f, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return $elm$core$Maybe$Just(
				f(value));
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$denodeMaybe = $elm$core$Maybe$map($mdgriffith$elm_codegen$Internal$Compiler$denode);
var $mdgriffith$elm_codegen$Internal$Compiler$denodeAll = $elm$core$List$map($mdgriffith$elm_codegen$Internal$Compiler$denode);
var $the_sett$elm_pretty_printer$Internals$Text = F2(
	function (a, b) {
		return {$: 'Text', a: a, b: b};
	});
var $elm$core$String$cons = _String_cons;
var $elm$core$String$fromChar = function (_char) {
	return A2($elm$core$String$cons, _char, '');
};
var $the_sett$elm_pretty_printer$Pretty$char = function (c) {
	return A2(
		$the_sett$elm_pretty_printer$Internals$Text,
		$elm$core$String$fromChar(c),
		$elm$core$Maybe$Nothing);
};
var $the_sett$elm_pretty_printer$Pretty$surround = F3(
	function (left, right, doc) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$append,
			A2($the_sett$elm_pretty_printer$Pretty$append, left, doc),
			right);
	});
var $the_sett$elm_pretty_printer$Pretty$parens = function (doc) {
	return A3(
		$the_sett$elm_pretty_printer$Pretty$surround,
		$the_sett$elm_pretty_printer$Pretty$char(
			_Utils_chr('(')),
		$the_sett$elm_pretty_printer$Pretty$char(
			_Utils_chr(')')),
		doc);
};
var $the_sett$elm_pretty_printer$Pretty$string = function (val) {
	return A2($the_sett$elm_pretty_printer$Internals$Text, val, $elm$core$Maybe$Nothing);
};
var $mdgriffith$elm_codegen$Internal$Write$prettyTopLevelExpose = function (tlExpose) {
	switch (tlExpose.$) {
		case 'InfixExpose':
			var val = tlExpose.a;
			return $the_sett$elm_pretty_printer$Pretty$parens(
				$the_sett$elm_pretty_printer$Pretty$string(val));
		case 'FunctionExpose':
			var val = tlExpose.a;
			return $the_sett$elm_pretty_printer$Pretty$string(val);
		case 'TypeOrAliasExpose':
			var val = tlExpose.a;
			return $the_sett$elm_pretty_printer$Pretty$string(val);
		default:
			var exposedType = tlExpose.a;
			var _v1 = exposedType.open;
			if (_v1.$ === 'Nothing') {
				return $the_sett$elm_pretty_printer$Pretty$string(exposedType.name);
			} else {
				return A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$string('(..)'),
					$the_sett$elm_pretty_printer$Pretty$string(exposedType.name));
			}
	}
};
var $mdgriffith$elm_codegen$Internal$Write$prettyTopLevelExposes = function (exposes) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$join,
		$the_sett$elm_pretty_printer$Pretty$string(', '),
		A2($elm$core$List$map, $mdgriffith$elm_codegen$Internal$Write$prettyTopLevelExpose, exposes));
};
var $stil4m$elm_syntax$Elm$Syntax$Exposing$InfixExpose = function (a) {
	return {$: 'InfixExpose', a: a};
};
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$combineTopLevelExposes = function (exposes) {
	if (!exposes.b) {
		return $stil4m$elm_syntax$Elm$Syntax$Exposing$InfixExpose('');
	} else {
		var hd = exposes.a;
		var tl = exposes.b;
		return A3(
			$elm$core$List$foldl,
			F2(
				function (exp, result) {
					var _v1 = _Utils_Tuple2(exp, result);
					if (_v1.a.$ === 'TypeExpose') {
						var typeExpose = _v1.a.a;
						var _v2 = typeExpose.open;
						if (_v2.$ === 'Just') {
							return exp;
						} else {
							return result;
						}
					} else {
						if (_v1.b.$ === 'TypeExpose') {
							var typeExpose = _v1.b.a;
							var _v3 = typeExpose.open;
							if (_v3.$ === 'Just') {
								return result;
							} else {
								return exp;
							}
						} else {
							return result;
						}
					}
				}),
			hd,
			tl);
	}
};
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$topLevelExposeName = function (tle) {
	switch (tle.$) {
		case 'InfixExpose':
			var val = tle.a;
			return val;
		case 'FunctionExpose':
			var val = tle.a;
			return val;
		case 'TypeOrAliasExpose':
			var val = tle.a;
			return val;
		default:
			var exposedType = tle.a;
			return exposedType.name;
	}
};
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$groupByExposingName = function (innerImports) {
	var _v0 = function () {
		if (!innerImports.b) {
			return _Utils_Tuple3(
				'',
				_List_Nil,
				_List_fromArray(
					[_List_Nil]));
		} else {
			var hd = innerImports.a;
			return A3(
				$elm$core$List$foldl,
				F2(
					function (exp, _v2) {
						var currName = _v2.a;
						var currAccum = _v2.b;
						var accum = _v2.c;
						var nextName = $mdgriffith$elm_codegen$Internal$ImportsAndExposing$topLevelExposeName(exp);
						return _Utils_eq(nextName, currName) ? _Utils_Tuple3(
							currName,
							A2($elm$core$List$cons, exp, currAccum),
							accum) : _Utils_Tuple3(
							nextName,
							_List_fromArray(
								[exp]),
							A2($elm$core$List$cons, currAccum, accum));
					}),
				_Utils_Tuple3(
					$mdgriffith$elm_codegen$Internal$ImportsAndExposing$topLevelExposeName(hd),
					_List_Nil,
					_List_Nil),
				innerImports);
		}
	}();
	var hdGroup = _v0.b;
	var remGroups = _v0.c;
	return $elm$core$List$reverse(
		A2($elm$core$List$cons, hdGroup, remGroups));
};
var $elm$core$List$sortWith = _List_sortWith;
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$topLevelExposeOrder = F2(
	function (tlel, tler) {
		var _v0 = _Utils_Tuple2(tlel, tler);
		if (_v0.a.$ === 'InfixExpose') {
			if (_v0.b.$ === 'InfixExpose') {
				return A2(
					$elm$core$Basics$compare,
					$mdgriffith$elm_codegen$Internal$ImportsAndExposing$topLevelExposeName(tlel),
					$mdgriffith$elm_codegen$Internal$ImportsAndExposing$topLevelExposeName(tler));
			} else {
				return $elm$core$Basics$LT;
			}
		} else {
			if (_v0.b.$ === 'InfixExpose') {
				return $elm$core$Basics$GT;
			} else {
				return A2(
					$elm$core$Basics$compare,
					$mdgriffith$elm_codegen$Internal$ImportsAndExposing$topLevelExposeName(tlel),
					$mdgriffith$elm_codegen$Internal$ImportsAndExposing$topLevelExposeName(tler));
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$sortAndDedupExposings = function (tlExposings) {
	return A2(
		$elm$core$List$map,
		$mdgriffith$elm_codegen$Internal$ImportsAndExposing$combineTopLevelExposes,
		$mdgriffith$elm_codegen$Internal$ImportsAndExposing$groupByExposingName(
			A2($elm$core$List$sortWith, $mdgriffith$elm_codegen$Internal$ImportsAndExposing$topLevelExposeOrder, tlExposings)));
};
var $the_sett$elm_pretty_printer$Pretty$space = $the_sett$elm_pretty_printer$Pretty$char(
	_Utils_chr(' '));
var $mdgriffith$elm_codegen$Internal$Write$prettyExposing = function (exposing_) {
	var exposings = function () {
		if (exposing_.$ === 'All') {
			return $the_sett$elm_pretty_printer$Pretty$parens(
				$the_sett$elm_pretty_printer$Pretty$string('..'));
		} else {
			var tll = exposing_.a;
			return $the_sett$elm_pretty_printer$Pretty$parens(
				$mdgriffith$elm_codegen$Internal$Write$prettyTopLevelExposes(
					$mdgriffith$elm_codegen$Internal$ImportsAndExposing$sortAndDedupExposings(
						$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(tll))));
		}
	}();
	return A2(
		$the_sett$elm_pretty_printer$Pretty$a,
		exposings,
		A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('exposing')));
};
var $mdgriffith$elm_codegen$Internal$Write$prettyMaybe = F2(
	function (prettyFn, maybeVal) {
		return A2(
			$elm$core$Maybe$withDefault,
			$the_sett$elm_pretty_printer$Pretty$empty,
			A2($elm$core$Maybe$map, prettyFn, maybeVal));
	});
var $mdgriffith$elm_codegen$Internal$Write$dot = $the_sett$elm_pretty_printer$Pretty$string('.');
var $mdgriffith$elm_codegen$Internal$Write$prettyModuleName = function (name) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$join,
		$mdgriffith$elm_codegen$Internal$Write$dot,
		A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, name));
};
var $mdgriffith$elm_codegen$Internal$Write$prettyModuleNameAlias = function (name) {
	if (!name.b) {
		return $the_sett$elm_pretty_printer$Pretty$empty;
	} else {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			A2(
				$the_sett$elm_pretty_printer$Pretty$join,
				$mdgriffith$elm_codegen$Internal$Write$dot,
				A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, name)),
			$the_sett$elm_pretty_printer$Pretty$string('as '));
	}
};
var $mdgriffith$elm_codegen$Internal$Write$prettyImport = function (import_) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$join,
		$the_sett$elm_pretty_printer$Pretty$space,
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('import'),
				$mdgriffith$elm_codegen$Internal$Write$prettyModuleName(
				$mdgriffith$elm_codegen$Internal$Compiler$denode(import_.moduleName)),
				A2(
				$mdgriffith$elm_codegen$Internal$Write$prettyMaybe,
				$mdgriffith$elm_codegen$Internal$Write$prettyModuleNameAlias,
				$mdgriffith$elm_codegen$Internal$Compiler$denodeMaybe(import_.moduleAlias)),
				A2(
				$mdgriffith$elm_codegen$Internal$Write$prettyMaybe,
				$mdgriffith$elm_codegen$Internal$Write$prettyExposing,
				$mdgriffith$elm_codegen$Internal$Compiler$denodeMaybe(import_.exposingList))
			]));
};
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$denode = $stil4m$elm_syntax$Elm$Syntax$Node$value;
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$denodeMaybe = $elm$core$Maybe$map($mdgriffith$elm_codegen$Internal$ImportsAndExposing$denode);
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$denodeAll = $elm$core$List$map($mdgriffith$elm_codegen$Internal$ImportsAndExposing$denode);
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodify = function (exp) {
	return A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, exp);
};
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodifyAll = $elm$core$List$map($mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodify);
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$joinExposings = F2(
	function (left, right) {
		var _v0 = _Utils_Tuple2(left, right);
		if (_v0.a.$ === 'All') {
			var range = _v0.a.a;
			return $stil4m$elm_syntax$Elm$Syntax$Exposing$All(range);
		} else {
			if (_v0.b.$ === 'All') {
				var range = _v0.b.a;
				return $stil4m$elm_syntax$Elm$Syntax$Exposing$All(range);
			} else {
				var leftNodes = _v0.a.a;
				var rightNodes = _v0.b.a;
				return $stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
					$mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodifyAll(
						A2(
							$elm$core$List$append,
							$mdgriffith$elm_codegen$Internal$ImportsAndExposing$denodeAll(leftNodes),
							$mdgriffith$elm_codegen$Internal$ImportsAndExposing$denodeAll(rightNodes))));
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$joinMaybeExposings = F2(
	function (maybeLeft, maybeRight) {
		var _v0 = _Utils_Tuple2(maybeLeft, maybeRight);
		if (_v0.a.$ === 'Nothing') {
			if (_v0.b.$ === 'Nothing') {
				var _v1 = _v0.a;
				var _v2 = _v0.b;
				return $elm$core$Maybe$Nothing;
			} else {
				var _v4 = _v0.a;
				var right = _v0.b.a;
				return $elm$core$Maybe$Just(right);
			}
		} else {
			if (_v0.b.$ === 'Nothing') {
				var left = _v0.a.a;
				var _v3 = _v0.b;
				return $elm$core$Maybe$Just(left);
			} else {
				var left = _v0.a.a;
				var right = _v0.b.a;
				return $elm$core$Maybe$Just(
					A2($mdgriffith$elm_codegen$Internal$ImportsAndExposing$joinExposings, left, right));
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodifyMaybe = $elm$core$Maybe$map($mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodify);
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$or = F2(
	function (ma, mb) {
		if (ma.$ === 'Nothing') {
			return mb;
		} else {
			return ma;
		}
	});
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$sortAndDedupExposing = function (exp) {
	if (exp.$ === 'All') {
		var range = exp.a;
		return $stil4m$elm_syntax$Elm$Syntax$Exposing$All(range);
	} else {
		var nodes = exp.a;
		return $stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
			$mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodifyAll(
				$mdgriffith$elm_codegen$Internal$ImportsAndExposing$sortAndDedupExposings(
					$mdgriffith$elm_codegen$Internal$ImportsAndExposing$denodeAll(nodes))));
	}
};
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$combineImports = function (innerImports) {
	if (!innerImports.b) {
		return {
			exposingList: $elm$core$Maybe$Nothing,
			moduleAlias: $elm$core$Maybe$Nothing,
			moduleName: $mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodify(_List_Nil)
		};
	} else {
		var hd = innerImports.a;
		var tl = innerImports.b;
		var combinedImports = A3(
			$elm$core$List$foldl,
			F2(
				function (imp, result) {
					return {
						exposingList: $mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodifyMaybe(
							A2(
								$mdgriffith$elm_codegen$Internal$ImportsAndExposing$joinMaybeExposings,
								$mdgriffith$elm_codegen$Internal$ImportsAndExposing$denodeMaybe(imp.exposingList),
								$mdgriffith$elm_codegen$Internal$ImportsAndExposing$denodeMaybe(result.exposingList))),
						moduleAlias: A2($mdgriffith$elm_codegen$Internal$ImportsAndExposing$or, imp.moduleAlias, result.moduleAlias),
						moduleName: imp.moduleName
					};
				}),
			hd,
			tl);
		return _Utils_update(
			combinedImports,
			{
				exposingList: A2(
					$elm$core$Maybe$map,
					A2(
						$elm$core$Basics$composeR,
						$mdgriffith$elm_codegen$Internal$ImportsAndExposing$denode,
						A2($elm$core$Basics$composeR, $mdgriffith$elm_codegen$Internal$ImportsAndExposing$sortAndDedupExposing, $mdgriffith$elm_codegen$Internal$ImportsAndExposing$nodify)),
					combinedImports.exposingList)
			});
	}
};
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$groupByModuleName = function (innerImports) {
	var _v0 = function () {
		if (!innerImports.b) {
			return _Utils_Tuple3(
				_List_Nil,
				_List_Nil,
				_List_fromArray(
					[_List_Nil]));
		} else {
			var hd = innerImports.a;
			return A3(
				$elm$core$List$foldl,
				F2(
					function (imp, _v2) {
						var currName = _v2.a;
						var currAccum = _v2.b;
						var accum = _v2.c;
						var nextName = $mdgriffith$elm_codegen$Internal$ImportsAndExposing$denode(imp.moduleName);
						return _Utils_eq(nextName, currName) ? _Utils_Tuple3(
							currName,
							A2($elm$core$List$cons, imp, currAccum),
							accum) : _Utils_Tuple3(
							nextName,
							_List_fromArray(
								[imp]),
							A2($elm$core$List$cons, currAccum, accum));
					}),
				_Utils_Tuple3(
					$mdgriffith$elm_codegen$Internal$ImportsAndExposing$denode(hd.moduleName),
					_List_Nil,
					_List_Nil),
				innerImports);
		}
	}();
	var hdGroup = _v0.b;
	var remGroups = _v0.c;
	return $elm$core$List$reverse(
		A2($elm$core$List$cons, hdGroup, remGroups));
};
var $mdgriffith$elm_codegen$Internal$ImportsAndExposing$sortAndDedupImports = function (imports) {
	var impName = function (imp) {
		return $mdgriffith$elm_codegen$Internal$ImportsAndExposing$denode(imp.moduleName);
	};
	return A2(
		$elm$core$List$map,
		$mdgriffith$elm_codegen$Internal$ImportsAndExposing$combineImports,
		$mdgriffith$elm_codegen$Internal$ImportsAndExposing$groupByModuleName(
			A2($elm$core$List$sortBy, impName, imports)));
};
var $mdgriffith$elm_codegen$Internal$Write$prettyImports = function (imports) {
	return $the_sett$elm_pretty_printer$Pretty$lines(
		A2(
			$elm$core$List$map,
			$mdgriffith$elm_codegen$Internal$Write$prettyImport,
			$mdgriffith$elm_codegen$Internal$ImportsAndExposing$sortAndDedupImports(imports)));
};
var $mdgriffith$elm_codegen$Internal$Write$importsPretty = function (imports) {
	if (!imports.b) {
		return $the_sett$elm_pretty_printer$Pretty$line;
	} else {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$line,
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$line,
					$mdgriffith$elm_codegen$Internal$Write$prettyImports(imports))));
	}
};
var $mdgriffith$elm_codegen$Internal$Write$prettyComments = function (comments) {
	if (!comments.b) {
		return $the_sett$elm_pretty_printer$Pretty$empty;
	} else {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$line,
				$the_sett$elm_pretty_printer$Pretty$lines(
					A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, comments))));
	}
};
var $the_sett$elm_pretty_printer$Internals$Nest = F2(
	function (a, b) {
		return {$: 'Nest', a: a, b: b};
	});
var $the_sett$elm_pretty_printer$Pretty$nest = F2(
	function (depth, doc) {
		return A2(
			$the_sett$elm_pretty_printer$Internals$Nest,
			depth,
			function (_v0) {
				return doc;
			});
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyDocumentation = function (docs) {
	return A2($elm$core$String$contains, '\n', docs) ? $the_sett$elm_pretty_printer$Pretty$string('{-| ' + (docs + '\n-}')) : $the_sett$elm_pretty_printer$Pretty$string('{-| ' + (docs + ' -}'));
};
var $the_sett$elm_pretty_printer$Internals$Union = F2(
	function (a, b) {
		return {$: 'Union', a: a, b: b};
	});
var $the_sett$elm_pretty_printer$Internals$flatten = function (doc) {
	flatten:
	while (true) {
		switch (doc.$) {
			case 'Concatenate':
				var doc1 = doc.a;
				var doc2 = doc.b;
				return A2(
					$the_sett$elm_pretty_printer$Internals$Concatenate,
					function (_v1) {
						return $the_sett$elm_pretty_printer$Internals$flatten(
							doc1(_Utils_Tuple0));
					},
					function (_v2) {
						return $the_sett$elm_pretty_printer$Internals$flatten(
							doc2(_Utils_Tuple0));
					});
			case 'Nest':
				var i = doc.a;
				var doc1 = doc.b;
				return A2(
					$the_sett$elm_pretty_printer$Internals$Nest,
					i,
					function (_v3) {
						return $the_sett$elm_pretty_printer$Internals$flatten(
							doc1(_Utils_Tuple0));
					});
			case 'Union':
				var doc1 = doc.a;
				var doc2 = doc.b;
				var $temp$doc = doc1;
				doc = $temp$doc;
				continue flatten;
			case 'Line':
				var hsep = doc.a;
				return A2($the_sett$elm_pretty_printer$Internals$Text, hsep, $elm$core$Maybe$Nothing);
			case 'Nesting':
				var fn = doc.a;
				var $temp$doc = fn(0);
				doc = $temp$doc;
				continue flatten;
			case 'Column':
				var fn = doc.a;
				var $temp$doc = fn(0);
				doc = $temp$doc;
				continue flatten;
			default:
				var x = doc;
				return x;
		}
	}
};
var $the_sett$elm_pretty_printer$Pretty$group = function (doc) {
	return A2(
		$the_sett$elm_pretty_printer$Internals$Union,
		$the_sett$elm_pretty_printer$Internals$flatten(doc),
		doc);
};
var $mdgriffith$elm_codegen$Internal$Write$isNakedCompound = function (typeAnn) {
	switch (typeAnn.$) {
		case 'Typed':
			if (!typeAnn.b.b) {
				return false;
			} else {
				var args = typeAnn.b;
				return true;
			}
		case 'FunctionTypeAnnotation':
			return true;
		default:
			return false;
	}
};
var $elm$core$Tuple$mapBoth = F3(
	function (funcA, funcB, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			funcA(x),
			funcB(y));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyModuleNameDot = F2(
	function (aliases, name) {
		if (!name.b) {
			return $the_sett$elm_pretty_printer$Pretty$empty;
		} else {
			var _v1 = A2($mdgriffith$elm_codegen$Internal$Compiler$findAlias, name, aliases);
			if (_v1.$ === 'Nothing') {
				return A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$mdgriffith$elm_codegen$Internal$Write$dot,
					A2(
						$the_sett$elm_pretty_printer$Pretty$join,
						$mdgriffith$elm_codegen$Internal$Write$dot,
						A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, name)));
			} else {
				var alias = _v1.a;
				return A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$mdgriffith$elm_codegen$Internal$Write$dot,
					$the_sett$elm_pretty_printer$Pretty$string(alias));
			}
		}
	});
var $the_sett$elm_pretty_printer$Pretty$separators = function (sep) {
	return $the_sett$elm_pretty_printer$Pretty$join(
		A2($the_sett$elm_pretty_printer$Internals$Line, sep, sep));
};
var $the_sett$elm_pretty_printer$Pretty$words = $the_sett$elm_pretty_printer$Pretty$join($the_sett$elm_pretty_printer$Pretty$space);
var $mdgriffith$elm_codegen$Internal$Write$prettyFieldTypeAnn = F2(
	function (aliases, _v8) {
		var name = _v8.a;
		var ann = _v8.b;
		return $the_sett$elm_pretty_printer$Pretty$group(
			A2(
				$the_sett$elm_pretty_printer$Pretty$nest,
				4,
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string(name),
									$the_sett$elm_pretty_printer$Pretty$string(':')
								])),
							A2($mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotation, aliases, ann)
						]))));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyFunctionTypeAnnotation = F3(
	function (aliases, left, right) {
		var expandLeft = function (ann) {
			if (ann.$ === 'FunctionTypeAnnotation') {
				return A2($mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotationParens, aliases, ann);
			} else {
				return A2($mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotation, aliases, ann);
			}
		};
		var innerFnTypeAnn = F2(
			function (innerLeft, innerRight) {
				var rightSide = expandRight(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(innerRight));
				if (rightSide.b) {
					var hd = rightSide.a;
					var tl = rightSide.b;
					return A2(
						$elm$core$List$cons,
						expandLeft(
							$mdgriffith$elm_codegen$Internal$Compiler$denode(innerLeft)),
						A2(
							$elm$core$List$cons,
							$the_sett$elm_pretty_printer$Pretty$words(
								_List_fromArray(
									[
										$the_sett$elm_pretty_printer$Pretty$string('->'),
										hd
									])),
							tl));
				} else {
					return _List_Nil;
				}
			});
		var expandRight = function (ann) {
			if (ann.$ === 'FunctionTypeAnnotation') {
				var innerLeft = ann.a;
				var innerRight = ann.b;
				return A2(innerFnTypeAnn, innerLeft, innerRight);
			} else {
				return _List_fromArray(
					[
						A2($mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotation, aliases, ann)
					]);
			}
		};
		return $the_sett$elm_pretty_printer$Pretty$group(
			$the_sett$elm_pretty_printer$Pretty$lines(
				A2(innerFnTypeAnn, left, right)));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyGenericRecord = F3(
	function (aliases, paramName, fields) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			$the_sett$elm_pretty_printer$Pretty$words(
				_List_fromArray(
					[
						$the_sett$elm_pretty_printer$Pretty$string('{'),
						$the_sett$elm_pretty_printer$Pretty$string(paramName)
					])));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string('}'),
			$the_sett$elm_pretty_printer$Pretty$line);
		var addBarToFirst = function (exprs) {
			if (!exprs.b) {
				return _List_Nil;
			} else {
				var hd = exprs.a;
				var tl = exprs.b;
				return A2(
					$elm$core$List$cons,
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						hd,
						$the_sett$elm_pretty_printer$Pretty$string('| ')),
					tl);
			}
		};
		if (!fields.b) {
			return $the_sett$elm_pretty_printer$Pretty$string('{}');
		} else {
			return $the_sett$elm_pretty_printer$Pretty$group(
				A3(
					$the_sett$elm_pretty_printer$Pretty$surround,
					$the_sett$elm_pretty_printer$Pretty$empty,
					close,
					A2(
						$the_sett$elm_pretty_printer$Pretty$nest,
						4,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							A2(
								$the_sett$elm_pretty_printer$Pretty$separators,
								', ',
								addBarToFirst(
									A2(
										$elm$core$List$map,
										$mdgriffith$elm_codegen$Internal$Write$prettyFieldTypeAnn(aliases),
										A2(
											$elm$core$List$map,
											A2($elm$core$Tuple$mapBoth, $mdgriffith$elm_codegen$Internal$Compiler$denode, $mdgriffith$elm_codegen$Internal$Compiler$denode),
											fields)))),
							open))));
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyRecord = F2(
	function (aliases, fields) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('{'));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string('}'),
			$the_sett$elm_pretty_printer$Pretty$line);
		if (!fields.b) {
			return $the_sett$elm_pretty_printer$Pretty$string('{}');
		} else {
			return $the_sett$elm_pretty_printer$Pretty$group(
				A3(
					$the_sett$elm_pretty_printer$Pretty$surround,
					open,
					close,
					A2(
						$the_sett$elm_pretty_printer$Pretty$separators,
						', ',
						A2(
							$elm$core$List$map,
							$mdgriffith$elm_codegen$Internal$Write$prettyFieldTypeAnn(aliases),
							A2(
								$elm$core$List$map,
								A2($elm$core$Tuple$mapBoth, $mdgriffith$elm_codegen$Internal$Compiler$denode, $mdgriffith$elm_codegen$Internal$Compiler$denode),
								fields)))));
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyTupled = F2(
	function (aliases, anns) {
		return $the_sett$elm_pretty_printer$Pretty$parens(
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$space,
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					A2(
						$the_sett$elm_pretty_printer$Pretty$join,
						$the_sett$elm_pretty_printer$Pretty$string(', '),
						A2(
							$elm$core$List$map,
							$mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotation(aliases),
							$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(anns))),
					$the_sett$elm_pretty_printer$Pretty$space)));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotation = F2(
	function (aliases, typeAnn) {
		switch (typeAnn.$) {
			case 'GenericType':
				var val = typeAnn.a;
				return $the_sett$elm_pretty_printer$Pretty$string(val);
			case 'Typed':
				var fqName = typeAnn.a;
				var anns = typeAnn.b;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyTyped, aliases, fqName, anns);
			case 'Unit':
				return $the_sett$elm_pretty_printer$Pretty$string('()');
			case 'Tupled':
				var anns = typeAnn.a;
				return A2($mdgriffith$elm_codegen$Internal$Write$prettyTupled, aliases, anns);
			case 'Record':
				var recordDef = typeAnn.a;
				return A2(
					$mdgriffith$elm_codegen$Internal$Write$prettyRecord,
					aliases,
					$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(recordDef));
			case 'GenericRecord':
				var paramName = typeAnn.a;
				var recordDef = typeAnn.b;
				return A3(
					$mdgriffith$elm_codegen$Internal$Write$prettyGenericRecord,
					aliases,
					$mdgriffith$elm_codegen$Internal$Compiler$denode(paramName),
					$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(
						$mdgriffith$elm_codegen$Internal$Compiler$denode(recordDef)));
			default:
				var fromAnn = typeAnn.a;
				var toAnn = typeAnn.b;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyFunctionTypeAnnotation, aliases, fromAnn, toAnn);
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotationParens = F2(
	function (aliases, typeAnn) {
		return $mdgriffith$elm_codegen$Internal$Write$isNakedCompound(typeAnn) ? $the_sett$elm_pretty_printer$Pretty$parens(
			A2($mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotation, aliases, typeAnn)) : A2($mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotation, aliases, typeAnn);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyTyped = F3(
	function (aliases, fqName, anns) {
		var argsDoc = $the_sett$elm_pretty_printer$Pretty$words(
			A2(
				$elm$core$List$map,
				$mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotationParens(aliases),
				$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(anns)));
		var _v0 = $mdgriffith$elm_codegen$Internal$Compiler$denode(fqName);
		var moduleName = _v0.a;
		var typeName = _v0.b;
		var typeDoc = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string(typeName),
			A2($mdgriffith$elm_codegen$Internal$Write$prettyModuleNameDot, aliases, moduleName));
		return $the_sett$elm_pretty_printer$Pretty$words(
			_List_fromArray(
				[typeDoc, argsDoc]));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyValueConstructor = F2(
	function (aliases, cons) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			$the_sett$elm_pretty_printer$Pretty$group(
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							$the_sett$elm_pretty_printer$Pretty$string(
							$mdgriffith$elm_codegen$Internal$Compiler$denode(cons.name)),
							$the_sett$elm_pretty_printer$Pretty$lines(
							A2(
								$elm$core$List$map,
								$mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotationParens(aliases),
								$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(cons._arguments)))
						]))));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyValueConstructors = F2(
	function (aliases, constructors) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$join,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$string('| '),
				$the_sett$elm_pretty_printer$Pretty$line),
			A2(
				$elm$core$List$map,
				$mdgriffith$elm_codegen$Internal$Write$prettyValueConstructor(aliases),
				constructors));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyCustomType = F2(
	function (aliases, type_) {
		var customTypePretty = A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				A2(
					$mdgriffith$elm_codegen$Internal$Write$prettyValueConstructors,
					aliases,
					$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(type_.constructors)),
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$string('= '),
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$line,
						$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string('type'),
									$the_sett$elm_pretty_printer$Pretty$string(
									$mdgriffith$elm_codegen$Internal$Compiler$denode(type_.name)),
									$the_sett$elm_pretty_printer$Pretty$words(
									A2(
										$elm$core$List$map,
										$the_sett$elm_pretty_printer$Pretty$string,
										$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(type_.generics)))
								]))))));
		return $the_sett$elm_pretty_printer$Pretty$lines(
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_codegen$Internal$Write$prettyMaybe,
					$mdgriffith$elm_codegen$Internal$Write$prettyDocumentation,
					$mdgriffith$elm_codegen$Internal$Compiler$denodeMaybe(type_.documentation)),
					customTypePretty
				]));
	});
var $mdgriffith$elm_codegen$Internal$Write$adjustExpressionParentheses = F2(
	function (context, expression) {
		var shouldRemove = function (expr) {
			var _v3 = _Utils_Tuple3(context.isTop, context.isLeftPipe, expr);
			_v3$1:
			while (true) {
				if (_v3.a) {
					return true;
				} else {
					switch (_v3.c.$) {
						case 'Application':
							if (_v3.b) {
								break _v3$1;
							} else {
								return (context.precedence < 11) ? true : false;
							}
						case 'FunctionOrValue':
							if (_v3.b) {
								break _v3$1;
							} else {
								var _v4 = _v3.c;
								return true;
							}
						case 'Integer':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'Hex':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'Floatable':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'Negation':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'Literal':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'CharLiteral':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'TupledExpression':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'RecordExpr':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'ListExpr':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'RecordAccess':
							if (_v3.b) {
								break _v3$1;
							} else {
								var _v5 = _v3.c;
								return true;
							}
						case 'RecordAccessFunction':
							if (_v3.b) {
								break _v3$1;
							} else {
								return true;
							}
						case 'RecordUpdateExpression':
							if (_v3.b) {
								break _v3$1;
							} else {
								var _v6 = _v3.c;
								return true;
							}
						default:
							if (_v3.b) {
								break _v3$1;
							} else {
								return false;
							}
					}
				}
			}
			return true;
		};
		var removeParens = function (expr) {
			if (expr.$ === 'ParenthesizedExpression') {
				var innerExpr = expr.a;
				return shouldRemove(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(innerExpr)) ? removeParens(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(innerExpr)) : expr;
			} else {
				return expr;
			}
		};
		var addParens = function (expr) {
			var _v1 = _Utils_Tuple3(context.isTop, context.isLeftPipe, expr);
			_v1$4:
			while (true) {
				if ((!_v1.a) && (!_v1.b)) {
					switch (_v1.c.$) {
						case 'LetExpression':
							return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(expr));
						case 'CaseExpression':
							return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(expr));
						case 'LambdaExpression':
							return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(expr));
						case 'IfBlock':
							var _v2 = _v1.c;
							return $stil4m$elm_syntax$Elm$Syntax$Expression$ParenthesizedExpression(
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(expr));
						default:
							break _v1$4;
					}
				} else {
					break _v1$4;
				}
			}
			return expr;
		};
		return addParens(
			removeParens(expression));
	});
var $the_sett$elm_pretty_printer$Internals$Column = function (a) {
	return {$: 'Column', a: a};
};
var $the_sett$elm_pretty_printer$Pretty$column = $the_sett$elm_pretty_printer$Internals$Column;
var $the_sett$elm_pretty_printer$Internals$Nesting = function (a) {
	return {$: 'Nesting', a: a};
};
var $the_sett$elm_pretty_printer$Pretty$nesting = $the_sett$elm_pretty_printer$Internals$Nesting;
var $the_sett$elm_pretty_printer$Pretty$align = function (doc) {
	return $the_sett$elm_pretty_printer$Pretty$column(
		function (currentColumn) {
			return $the_sett$elm_pretty_printer$Pretty$nesting(
				function (indentLvl) {
					return A2($the_sett$elm_pretty_printer$Pretty$nest, currentColumn - indentLvl, doc);
				});
		});
};
var $elm$core$Basics$modBy = _Basics_modBy;
var $mdgriffith$elm_codegen$Internal$Write$decrementIndent = F2(
	function (currentIndent, spaces) {
		var modded = A2($elm$core$Basics$modBy, 4, currentIndent - spaces);
		return (!modded) ? 4 : modded;
	});
var $mdgriffith$elm_codegen$Internal$Write$doubleLines = $the_sett$elm_pretty_printer$Pretty$join(
	A2($the_sett$elm_pretty_printer$Pretty$a, $the_sett$elm_pretty_printer$Pretty$line, $the_sett$elm_pretty_printer$Pretty$line));
var $mdgriffith$elm_codegen$Internal$Write$escapeChar = function (val) {
	switch (val.valueOf()) {
		case '\\':
			return '\\\\';
		case '\'':
			return '\\\'';
		case '\t':
			return '\\t';
		case '\n':
			return '\\n';
		default:
			var c = val;
			return $elm$core$String$fromChar(c);
	}
};
var $elm$core$String$fromFloat = _String_fromNumber;
var $the_sett$elm_pretty_printer$Internals$copy = F2(
	function (i, s) {
		return (!i) ? '' : _Utils_ap(
			s,
			A2($the_sett$elm_pretty_printer$Internals$copy, i - 1, s));
	});
var $the_sett$elm_pretty_printer$Pretty$hang = F2(
	function (spaces, doc) {
		return $the_sett$elm_pretty_printer$Pretty$align(
			A2($the_sett$elm_pretty_printer$Pretty$nest, spaces, doc));
	});
var $the_sett$elm_pretty_printer$Pretty$indent = F2(
	function (spaces, doc) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$hang,
			spaces,
			A2(
				$the_sett$elm_pretty_printer$Pretty$append,
				$the_sett$elm_pretty_printer$Pretty$string(
					A2($the_sett$elm_pretty_printer$Internals$copy, spaces, ' ')),
				doc));
	});
var $elm$core$Tuple$mapSecond = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			x,
			func(y));
	});
var $mdgriffith$elm_codegen$Internal$Write$optionalGroup = F2(
	function (flag, doc) {
		return flag ? doc : $the_sett$elm_pretty_printer$Pretty$group(doc);
	});
var $mdgriffith$elm_codegen$Internal$Write$precedence = function (symbol) {
	switch (symbol) {
		case '>>':
			return 9;
		case '<<':
			return 9;
		case '^':
			return 8;
		case '*':
			return 7;
		case '/':
			return 7;
		case '//':
			return 7;
		case '%':
			return 7;
		case 'rem':
			return 7;
		case '+':
			return 6;
		case '-':
			return 6;
		case '++':
			return 5;
		case '::':
			return 5;
		case '==':
			return 4;
		case '/=':
			return 4;
		case '<':
			return 4;
		case '>':
			return 4;
		case '<=':
			return 4;
		case '>=':
			return 4;
		case '&&':
			return 3;
		case '||':
			return 2;
		case '|>':
			return 0;
		case '<|':
			return 0;
		default:
			return 0;
	}
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$ParenthesizedPattern = function (a) {
	return {$: 'ParenthesizedPattern', a: a};
};
var $mdgriffith$elm_codegen$Internal$Write$adjustPatternParentheses = F2(
	function (isTop, pattern) {
		var shouldRemove = function (pat) {
			var _v5 = _Utils_Tuple2(isTop, pat);
			_v5$2:
			while (true) {
				switch (_v5.b.$) {
					case 'NamedPattern':
						if (!_v5.a) {
							var _v6 = _v5.b;
							return false;
						} else {
							break _v5$2;
						}
					case 'AsPattern':
						var _v7 = _v5.b;
						return false;
					default:
						break _v5$2;
				}
			}
			return isTop;
		};
		var removeParens = function (pat) {
			if (pat.$ === 'ParenthesizedPattern') {
				var innerPat = pat.a;
				return shouldRemove(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(innerPat)) ? removeParens(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(innerPat)) : pat;
			} else {
				return pat;
			}
		};
		var addParens = function (pat) {
			var _v1 = _Utils_Tuple2(isTop, pat);
			_v1$2:
			while (true) {
				if (!_v1.a) {
					switch (_v1.b.$) {
						case 'NamedPattern':
							if (_v1.b.b.b) {
								var _v2 = _v1.b;
								var _v3 = _v2.b;
								return $stil4m$elm_syntax$Elm$Syntax$Pattern$ParenthesizedPattern(
									$mdgriffith$elm_codegen$Internal$Compiler$nodify(pat));
							} else {
								break _v1$2;
							}
						case 'AsPattern':
							var _v4 = _v1.b;
							return $stil4m$elm_syntax$Elm$Syntax$Pattern$ParenthesizedPattern(
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(pat));
						default:
							break _v1$2;
					}
				} else {
					break _v1$2;
				}
			}
			return pat;
		};
		return addParens(
			removeParens(pattern));
	});
var $the_sett$elm_pretty_printer$Pretty$braces = function (doc) {
	return A3(
		$the_sett$elm_pretty_printer$Pretty$surround,
		$the_sett$elm_pretty_printer$Pretty$char(
			_Utils_chr('{')),
		$the_sett$elm_pretty_printer$Pretty$char(
			_Utils_chr('}')),
		doc);
};
var $mdgriffith$elm_codegen$Internal$Write$quotes = function (doc) {
	return A3(
		$the_sett$elm_pretty_printer$Pretty$surround,
		$the_sett$elm_pretty_printer$Pretty$char(
			_Utils_chr('\"')),
		$the_sett$elm_pretty_printer$Pretty$char(
			_Utils_chr('\"')),
		doc);
};
var $mdgriffith$elm_codegen$Internal$Write$singleQuotes = function (doc) {
	return A3(
		$the_sett$elm_pretty_printer$Pretty$surround,
		$the_sett$elm_pretty_printer$Pretty$char(
			_Utils_chr('\'')),
		$the_sett$elm_pretty_printer$Pretty$char(
			_Utils_chr('\'')),
		doc);
};
var $elm$core$String$fromList = _String_fromList;
var $rtfeldman$elm_hex$Hex$unsafeToDigit = function (num) {
	unsafeToDigit:
	while (true) {
		switch (num) {
			case 0:
				return _Utils_chr('0');
			case 1:
				return _Utils_chr('1');
			case 2:
				return _Utils_chr('2');
			case 3:
				return _Utils_chr('3');
			case 4:
				return _Utils_chr('4');
			case 5:
				return _Utils_chr('5');
			case 6:
				return _Utils_chr('6');
			case 7:
				return _Utils_chr('7');
			case 8:
				return _Utils_chr('8');
			case 9:
				return _Utils_chr('9');
			case 10:
				return _Utils_chr('a');
			case 11:
				return _Utils_chr('b');
			case 12:
				return _Utils_chr('c');
			case 13:
				return _Utils_chr('d');
			case 14:
				return _Utils_chr('e');
			case 15:
				return _Utils_chr('f');
			default:
				var $temp$num = num;
				num = $temp$num;
				continue unsafeToDigit;
		}
	}
};
var $rtfeldman$elm_hex$Hex$unsafePositiveToDigits = F2(
	function (digits, num) {
		unsafePositiveToDigits:
		while (true) {
			if (num < 16) {
				return A2(
					$elm$core$List$cons,
					$rtfeldman$elm_hex$Hex$unsafeToDigit(num),
					digits);
			} else {
				var $temp$digits = A2(
					$elm$core$List$cons,
					$rtfeldman$elm_hex$Hex$unsafeToDigit(
						A2($elm$core$Basics$modBy, 16, num)),
					digits),
					$temp$num = (num / 16) | 0;
				digits = $temp$digits;
				num = $temp$num;
				continue unsafePositiveToDigits;
			}
		}
	});
var $rtfeldman$elm_hex$Hex$toString = function (num) {
	return $elm$core$String$fromList(
		(num < 0) ? A2(
			$elm$core$List$cons,
			_Utils_chr('-'),
			A2($rtfeldman$elm_hex$Hex$unsafePositiveToDigits, _List_Nil, -num)) : A2($rtfeldman$elm_hex$Hex$unsafePositiveToDigits, _List_Nil, num));
};
var $mdgriffith$elm_codegen$Internal$Write$prettyPatternInner = F3(
	function (aliases, isTop, pattern) {
		var _v0 = A2($mdgriffith$elm_codegen$Internal$Write$adjustPatternParentheses, isTop, pattern);
		switch (_v0.$) {
			case 'AllPattern':
				return $the_sett$elm_pretty_printer$Pretty$string('_');
			case 'UnitPattern':
				return $the_sett$elm_pretty_printer$Pretty$string('()');
			case 'CharPattern':
				var val = _v0.a;
				return $mdgriffith$elm_codegen$Internal$Write$singleQuotes(
					$the_sett$elm_pretty_printer$Pretty$string(
						$mdgriffith$elm_codegen$Internal$Write$escapeChar(val)));
			case 'StringPattern':
				var val = _v0.a;
				return $mdgriffith$elm_codegen$Internal$Write$quotes(
					$the_sett$elm_pretty_printer$Pretty$string(val));
			case 'IntPattern':
				var val = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$string(
					$elm$core$String$fromInt(val));
			case 'HexPattern':
				var val = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$string(
					$rtfeldman$elm_hex$Hex$toString(val));
			case 'FloatPattern':
				var val = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$string(
					$elm$core$String$fromFloat(val));
			case 'TuplePattern':
				var vals = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$parens(
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$space,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							A2(
								$the_sett$elm_pretty_printer$Pretty$join,
								$the_sett$elm_pretty_printer$Pretty$string(', '),
								A2(
									$elm$core$List$map,
									A2($mdgriffith$elm_codegen$Internal$Write$prettyPatternInner, aliases, true),
									$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(vals))),
							$the_sett$elm_pretty_printer$Pretty$space)));
			case 'RecordPattern':
				var fields = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$braces(
					A3(
						$the_sett$elm_pretty_printer$Pretty$surround,
						$the_sett$elm_pretty_printer$Pretty$space,
						$the_sett$elm_pretty_printer$Pretty$space,
						A2(
							$the_sett$elm_pretty_printer$Pretty$join,
							$the_sett$elm_pretty_printer$Pretty$string(', '),
							A2(
								$elm$core$List$map,
								$the_sett$elm_pretty_printer$Pretty$string,
								$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(fields)))));
			case 'UnConsPattern':
				var hdPat = _v0.a;
				var tlPat = _v0.b;
				return $the_sett$elm_pretty_printer$Pretty$words(
					_List_fromArray(
						[
							A3(
							$mdgriffith$elm_codegen$Internal$Write$prettyPatternInner,
							aliases,
							false,
							$mdgriffith$elm_codegen$Internal$Compiler$denode(hdPat)),
							$the_sett$elm_pretty_printer$Pretty$string('::'),
							A3(
							$mdgriffith$elm_codegen$Internal$Write$prettyPatternInner,
							aliases,
							false,
							$mdgriffith$elm_codegen$Internal$Compiler$denode(tlPat))
						]));
			case 'ListPattern':
				var listPats = _v0.a;
				if (!listPats.b) {
					return $the_sett$elm_pretty_printer$Pretty$string('[]');
				} else {
					var open = A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$space,
						$the_sett$elm_pretty_printer$Pretty$string('['));
					var close = A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$string(']'),
						$the_sett$elm_pretty_printer$Pretty$space);
					return A3(
						$the_sett$elm_pretty_printer$Pretty$surround,
						open,
						close,
						A2(
							$the_sett$elm_pretty_printer$Pretty$join,
							$the_sett$elm_pretty_printer$Pretty$string(', '),
							A2(
								$elm$core$List$map,
								A2($mdgriffith$elm_codegen$Internal$Write$prettyPatternInner, aliases, false),
								$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(listPats))));
				}
			case 'VarPattern':
				var _var = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$string(_var);
			case 'NamedPattern':
				var qnRef = _v0.a;
				var listPats = _v0.b;
				return $the_sett$elm_pretty_printer$Pretty$words(
					A2(
						$elm$core$List$cons,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$string(qnRef.name),
							A2($mdgriffith$elm_codegen$Internal$Write$prettyModuleNameDot, aliases, qnRef.moduleName)),
						A2(
							$elm$core$List$map,
							A2($mdgriffith$elm_codegen$Internal$Write$prettyPatternInner, aliases, false),
							$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(listPats))));
			case 'AsPattern':
				var pat = _v0.a;
				var name = _v0.b;
				return $the_sett$elm_pretty_printer$Pretty$words(
					_List_fromArray(
						[
							A3(
							$mdgriffith$elm_codegen$Internal$Write$prettyPatternInner,
							aliases,
							false,
							$mdgriffith$elm_codegen$Internal$Compiler$denode(pat)),
							$the_sett$elm_pretty_printer$Pretty$string('as'),
							$the_sett$elm_pretty_printer$Pretty$string(
							$mdgriffith$elm_codegen$Internal$Compiler$denode(name))
						]));
			default:
				var pat = _v0.a;
				return $the_sett$elm_pretty_printer$Pretty$parens(
					A3(
						$mdgriffith$elm_codegen$Internal$Write$prettyPatternInner,
						aliases,
						true,
						$mdgriffith$elm_codegen$Internal$Compiler$denode(pat)));
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyArgs = F2(
	function (aliases, args) {
		return $the_sett$elm_pretty_printer$Pretty$words(
			A2(
				$elm$core$List$map,
				A2($mdgriffith$elm_codegen$Internal$Write$prettyPatternInner, aliases, false),
				args));
	});
var $elm$core$String$replace = F3(
	function (before, after, string) {
		return A2(
			$elm$core$String$join,
			after,
			A2($elm$core$String$split, before, string));
	});
var $mdgriffith$elm_codegen$Internal$Write$escape = function (val) {
	return A3(
		$elm$core$String$replace,
		'\t',
		'\\t',
		A3(
			$elm$core$String$replace,
			'\n',
			'\\n',
			A3(
				$elm$core$String$replace,
				'\"',
				'\\\"',
				A3($elm$core$String$replace, '\\', '\\\\', val))));
};
var $mdgriffith$elm_codegen$Internal$Write$tripleQuotes = function (doc) {
	return A3(
		$the_sett$elm_pretty_printer$Pretty$surround,
		$the_sett$elm_pretty_printer$Pretty$string('\"\"\"'),
		$the_sett$elm_pretty_printer$Pretty$string('\"\"\"'),
		doc);
};
var $mdgriffith$elm_codegen$Internal$Write$prettyLiteral = function (val) {
	return A2($elm$core$String$contains, '\n', val) ? $mdgriffith$elm_codegen$Internal$Write$tripleQuotes(
		$the_sett$elm_pretty_printer$Pretty$string(val)) : $mdgriffith$elm_codegen$Internal$Write$quotes(
		$the_sett$elm_pretty_printer$Pretty$string(
			$mdgriffith$elm_codegen$Internal$Write$escape(val)));
};
var $mdgriffith$elm_codegen$Internal$Write$prettyPattern = F2(
	function (aliases, pattern) {
		return A3($mdgriffith$elm_codegen$Internal$Write$prettyPatternInner, aliases, true, pattern);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettySignature = F2(
	function (aliases, sig) {
		return $the_sett$elm_pretty_printer$Pretty$group(
			A2(
				$the_sett$elm_pretty_printer$Pretty$nest,
				4,
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string(
									$mdgriffith$elm_codegen$Internal$Compiler$denode(sig.name)),
									$the_sett$elm_pretty_printer$Pretty$string(':')
								])),
							A2(
							$mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotation,
							aliases,
							$mdgriffith$elm_codegen$Internal$Compiler$denode(sig.typeAnnotation))
						]))));
	});
var $the_sett$elm_pretty_printer$Pretty$tightline = A2($the_sett$elm_pretty_printer$Internals$Line, '', '');
var $elm$core$String$padLeft = F3(
	function (n, _char, string) {
		return _Utils_ap(
			A2(
				$elm$core$String$repeat,
				n - $elm$core$String$length(string),
				$elm$core$String$fromChar(_char)),
			string);
	});
var $mdgriffith$elm_codegen$Internal$Write$toHexString = function (val) {
	var padWithZeros = function (str) {
		var length = $elm$core$String$length(str);
		return (length < 2) ? A3(
			$elm$core$String$padLeft,
			2,
			_Utils_chr('0'),
			str) : (((length > 2) && (length < 4)) ? A3(
			$elm$core$String$padLeft,
			4,
			_Utils_chr('0'),
			str) : (((length > 4) && (length < 8)) ? A3(
			$elm$core$String$padLeft,
			8,
			_Utils_chr('0'),
			str) : str));
	};
	return '0x' + padWithZeros(
		$elm$core$String$toUpper(
			$rtfeldman$elm_hex$Hex$toString(val)));
};
var $mdgriffith$elm_codegen$Internal$Write$topContext = {isLeftPipe: false, isTop: true, precedence: 11};
var $elm$core$List$unzip = function (pairs) {
	var step = F2(
		function (_v0, _v1) {
			var x = _v0.a;
			var y = _v0.b;
			var xs = _v1.a;
			var ys = _v1.b;
			return _Utils_Tuple2(
				A2($elm$core$List$cons, x, xs),
				A2($elm$core$List$cons, y, ys));
		});
	return A3(
		$elm$core$List$foldr,
		step,
		_Utils_Tuple2(_List_Nil, _List_Nil),
		pairs);
};
var $mdgriffith$elm_codegen$Internal$Write$prettyApplication = F3(
	function (aliases, indent, exprs) {
		var _v30 = A2(
			$elm$core$Tuple$mapSecond,
			$elm$core$List$any($elm$core$Basics$identity),
			$elm$core$List$unzip(
				A2(
					$elm$core$List$map,
					A3(
						$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
						aliases,
						{isLeftPipe: false, isTop: false, precedence: 11},
						4),
					$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(exprs))));
		var prettyExpressions = _v30.a;
		var alwaysBreak = _v30.b;
		return _Utils_Tuple2(
			A2(
				$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$align(
					A2(
						$the_sett$elm_pretty_printer$Pretty$nest,
						indent,
						$the_sett$elm_pretty_printer$Pretty$lines(prettyExpressions)))),
			alwaysBreak);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyCaseBlock = F3(
	function (aliases, indent, caseBlock) {
		var prettyCase = function (_v29) {
			var pattern = _v29.a;
			var expr = _v29.b;
			return A2(
				$the_sett$elm_pretty_printer$Pretty$indent,
				indent,
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					A2(
						$the_sett$elm_pretty_printer$Pretty$indent,
						4,
						A4(
							$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
							aliases,
							$mdgriffith$elm_codegen$Internal$Write$topContext,
							4,
							$mdgriffith$elm_codegen$Internal$Compiler$denode(expr)).a),
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$line,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$string(' ->'),
							A2(
								$mdgriffith$elm_codegen$Internal$Write$prettyPattern,
								aliases,
								$mdgriffith$elm_codegen$Internal$Compiler$denode(pattern))))));
		};
		var patternsPart = $mdgriffith$elm_codegen$Internal$Write$doubleLines(
			A2($elm$core$List$map, prettyCase, caseBlock.cases));
		var casePart = function () {
			var _v28 = A4(
				$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
				aliases,
				$mdgriffith$elm_codegen$Internal$Write$topContext,
				4,
				$mdgriffith$elm_codegen$Internal$Compiler$denode(caseBlock.expression));
			var caseExpression = _v28.a;
			var alwaysBreak = _v28.b;
			return A2(
				$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							A2(
							$the_sett$elm_pretty_printer$Pretty$nest,
							indent,
							A2(
								$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
								alwaysBreak,
								$the_sett$elm_pretty_printer$Pretty$lines(
									_List_fromArray(
										[
											$the_sett$elm_pretty_printer$Pretty$string('case'),
											caseExpression
										])))),
							$the_sett$elm_pretty_printer$Pretty$string('of')
						])));
		}();
		return _Utils_Tuple2(
			$the_sett$elm_pretty_printer$Pretty$align(
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[casePart, patternsPart]))),
			true);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyExpression = F2(
	function (aliases, expression) {
		return A4($mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner, aliases, $mdgriffith$elm_codegen$Internal$Write$topContext, 4, expression).a;
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner = F4(
	function (aliases, context, indent, expression) {
		var _v26 = A2($mdgriffith$elm_codegen$Internal$Write$adjustExpressionParentheses, context, expression);
		switch (_v26.$) {
			case 'UnitExpr':
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string('()'),
					false);
			case 'Application':
				var exprs = _v26.a;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyApplication, aliases, indent, exprs);
			case 'OperatorApplication':
				var symbol = _v26.a;
				var dir = _v26.b;
				var exprl = _v26.c;
				var exprr = _v26.d;
				return A6($mdgriffith$elm_codegen$Internal$Write$prettyOperatorApplication, aliases, indent, symbol, dir, exprl, exprr);
			case 'FunctionOrValue':
				var modl = _v26.a;
				var val = _v26.b;
				return _Utils_Tuple2(
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$string(val),
						A2($mdgriffith$elm_codegen$Internal$Write$prettyModuleNameDot, aliases, modl)),
					false);
			case 'IfBlock':
				var exprBool = _v26.a;
				var exprTrue = _v26.b;
				var exprFalse = _v26.c;
				return A5($mdgriffith$elm_codegen$Internal$Write$prettyIfBlock, aliases, indent, exprBool, exprTrue, exprFalse);
			case 'PrefixOperator':
				var symbol = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$parens(
						$the_sett$elm_pretty_printer$Pretty$string(symbol)),
					false);
			case 'Operator':
				var symbol = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(symbol),
					false);
			case 'Integer':
				var val = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(
						$elm$core$String$fromInt(val)),
					false);
			case 'Hex':
				var val = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(
						$mdgriffith$elm_codegen$Internal$Write$toHexString(val)),
					false);
			case 'Floatable':
				var val = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(
						$elm$core$String$fromFloat(val)),
					false);
			case 'Negation':
				var expr = _v26.a;
				var _v27 = A4(
					$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
					aliases,
					$mdgriffith$elm_codegen$Internal$Write$topContext,
					4,
					$mdgriffith$elm_codegen$Internal$Compiler$denode(expr));
				var prettyExpr = _v27.a;
				var alwaysBreak = _v27.b;
				return _Utils_Tuple2(
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						prettyExpr,
						$the_sett$elm_pretty_printer$Pretty$string('-')),
					alwaysBreak);
			case 'Literal':
				var val = _v26.a;
				return _Utils_Tuple2(
					$mdgriffith$elm_codegen$Internal$Write$prettyLiteral(val),
					false);
			case 'CharLiteral':
				var val = _v26.a;
				return _Utils_Tuple2(
					$mdgriffith$elm_codegen$Internal$Write$singleQuotes(
						$the_sett$elm_pretty_printer$Pretty$string(
							$mdgriffith$elm_codegen$Internal$Write$escapeChar(val))),
					false);
			case 'TupledExpression':
				var exprs = _v26.a;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyTupledExpression, aliases, indent, exprs);
			case 'ParenthesizedExpression':
				var expr = _v26.a;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyParenthesizedExpression, aliases, indent, expr);
			case 'LetExpression':
				var letBlock = _v26.a;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyLetBlock, aliases, indent, letBlock);
			case 'CaseExpression':
				var caseBlock = _v26.a;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyCaseBlock, aliases, indent, caseBlock);
			case 'LambdaExpression':
				var lambda = _v26.a;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyLambdaExpression, aliases, indent, lambda);
			case 'RecordExpr':
				var setters = _v26.a;
				return A2($mdgriffith$elm_codegen$Internal$Write$prettyRecordExpr, aliases, setters);
			case 'ListExpr':
				var exprs = _v26.a;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyList, aliases, indent, exprs);
			case 'RecordAccess':
				var expr = _v26.a;
				var field = _v26.b;
				return A3($mdgriffith$elm_codegen$Internal$Write$prettyRecordAccess, aliases, expr, field);
			case 'RecordAccessFunction':
				var field = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string(field),
					false);
			case 'RecordUpdateExpression':
				var _var = _v26.a;
				var setters = _v26.b;
				return A4($mdgriffith$elm_codegen$Internal$Write$prettyRecordUpdateExpression, aliases, indent, _var, setters);
			default:
				var val = _v26.a;
				return _Utils_Tuple2(
					$the_sett$elm_pretty_printer$Pretty$string('glsl'),
					true);
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyFun = F2(
	function (aliases, fn) {
		return $the_sett$elm_pretty_printer$Pretty$lines(
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_codegen$Internal$Write$prettyMaybe,
					$mdgriffith$elm_codegen$Internal$Write$prettyDocumentation,
					$mdgriffith$elm_codegen$Internal$Compiler$denodeMaybe(fn.documentation)),
					A2(
					$mdgriffith$elm_codegen$Internal$Write$prettyMaybe,
					$mdgriffith$elm_codegen$Internal$Write$prettySignature(aliases),
					$mdgriffith$elm_codegen$Internal$Compiler$denodeMaybe(fn.signature)),
					A2(
					$mdgriffith$elm_codegen$Internal$Write$prettyFunctionImplementation,
					aliases,
					$mdgriffith$elm_codegen$Internal$Compiler$denode(fn.declaration))
				]));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyFunctionImplementation = F2(
	function (aliases, impl) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				A2(
					$mdgriffith$elm_codegen$Internal$Write$prettyExpression,
					aliases,
					$mdgriffith$elm_codegen$Internal$Compiler$denode(impl.expression)),
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$line,
					$the_sett$elm_pretty_printer$Pretty$words(
						_List_fromArray(
							[
								$the_sett$elm_pretty_printer$Pretty$string(
								$mdgriffith$elm_codegen$Internal$Compiler$denode(impl.name)),
								A2(
								$mdgriffith$elm_codegen$Internal$Write$prettyArgs,
								aliases,
								$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(impl._arguments)),
								$the_sett$elm_pretty_printer$Pretty$string('=')
							])))));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyIfBlock = F5(
	function (aliases, indent, exprBool, exprTrue, exprFalse) {
		var innerIfBlock = F3(
			function (innerExprBool, innerExprTrue, innerExprFalse) {
				var truePart = A2(
					$the_sett$elm_pretty_printer$Pretty$indent,
					indent,
					A4(
						$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
						aliases,
						$mdgriffith$elm_codegen$Internal$Write$topContext,
						4,
						$mdgriffith$elm_codegen$Internal$Compiler$denode(innerExprTrue)).a);
				var ifPart = function () {
					var _v25 = A4(
						$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
						aliases,
						$mdgriffith$elm_codegen$Internal$Write$topContext,
						4,
						$mdgriffith$elm_codegen$Internal$Compiler$denode(innerExprBool));
					var prettyBoolExpr = _v25.a;
					var alwaysBreak = _v25.b;
					return A2(
						$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
						alwaysBreak,
						$the_sett$elm_pretty_printer$Pretty$lines(
							_List_fromArray(
								[
									A2(
									$the_sett$elm_pretty_printer$Pretty$nest,
									indent,
									A2(
										$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
										alwaysBreak,
										$the_sett$elm_pretty_printer$Pretty$lines(
											_List_fromArray(
												[
													$the_sett$elm_pretty_printer$Pretty$string('if'),
													A4(
													$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
													aliases,
													$mdgriffith$elm_codegen$Internal$Write$topContext,
													4,
													$mdgriffith$elm_codegen$Internal$Compiler$denode(innerExprBool)).a
												])))),
									$the_sett$elm_pretty_printer$Pretty$string('then')
								])));
				}();
				var falsePart = function () {
					var _v24 = $mdgriffith$elm_codegen$Internal$Compiler$denode(innerExprFalse);
					if (_v24.$ === 'IfBlock') {
						var nestedExprBool = _v24.a;
						var nestedExprTrue = _v24.b;
						var nestedExprFalse = _v24.c;
						return A3(innerIfBlock, nestedExprBool, nestedExprTrue, nestedExprFalse);
					} else {
						return _List_fromArray(
							[
								A2(
								$the_sett$elm_pretty_printer$Pretty$indent,
								indent,
								A4(
									$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
									aliases,
									$mdgriffith$elm_codegen$Internal$Write$topContext,
									4,
									$mdgriffith$elm_codegen$Internal$Compiler$denode(innerExprFalse)).a)
							]);
					}
				}();
				var elsePart = A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$string('else'),
					$the_sett$elm_pretty_printer$Pretty$line);
				var context = $mdgriffith$elm_codegen$Internal$Write$topContext;
				if (!falsePart.b) {
					return _List_Nil;
				} else {
					if (!falsePart.b.b) {
						var falseExpr = falsePart.a;
						return _List_fromArray(
							[ifPart, truePart, elsePart, falseExpr]);
					} else {
						var hd = falsePart.a;
						var tl = falsePart.b;
						return A2(
							$elm$core$List$append,
							_List_fromArray(
								[
									ifPart,
									truePart,
									$the_sett$elm_pretty_printer$Pretty$words(
									_List_fromArray(
										[elsePart, hd]))
								]),
							tl);
					}
				}
			});
		var prettyExpressions = A3(innerIfBlock, exprBool, exprTrue, exprFalse);
		return _Utils_Tuple2(
			$the_sett$elm_pretty_printer$Pretty$align(
				$the_sett$elm_pretty_printer$Pretty$lines(prettyExpressions)),
			true);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyLambdaExpression = F3(
	function (aliases, indent, lambda) {
		var _v22 = A4(
			$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
			aliases,
			$mdgriffith$elm_codegen$Internal$Write$topContext,
			4,
			$mdgriffith$elm_codegen$Internal$Compiler$denode(lambda.expression));
		var prettyExpr = _v22.a;
		var alwaysBreak = _v22.b;
		return _Utils_Tuple2(
			A2(
				$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$align(
					A2(
						$the_sett$elm_pretty_printer$Pretty$nest,
						indent,
						$the_sett$elm_pretty_printer$Pretty$lines(
							_List_fromArray(
								[
									A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									$the_sett$elm_pretty_printer$Pretty$string(' ->'),
									A2(
										$the_sett$elm_pretty_printer$Pretty$a,
										$the_sett$elm_pretty_printer$Pretty$words(
											A2(
												$elm$core$List$map,
												A2($mdgriffith$elm_codegen$Internal$Write$prettyPatternInner, aliases, false),
												$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(lambda.args))),
										$the_sett$elm_pretty_printer$Pretty$string('\\'))),
									prettyExpr
								]))))),
			alwaysBreak);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyLetBlock = F3(
	function (aliases, indent, letBlock) {
		return _Utils_Tuple2(
			$the_sett$elm_pretty_printer$Pretty$align(
				$the_sett$elm_pretty_printer$Pretty$lines(
					_List_fromArray(
						[
							$the_sett$elm_pretty_printer$Pretty$string('let'),
							A2(
							$the_sett$elm_pretty_printer$Pretty$indent,
							indent,
							$mdgriffith$elm_codegen$Internal$Write$doubleLines(
								A2(
									$elm$core$List$map,
									A2($mdgriffith$elm_codegen$Internal$Write$prettyLetDeclaration, aliases, indent),
									$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(letBlock.declarations)))),
							$the_sett$elm_pretty_printer$Pretty$string('in'),
							A4(
							$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
							aliases,
							$mdgriffith$elm_codegen$Internal$Write$topContext,
							4,
							$mdgriffith$elm_codegen$Internal$Compiler$denode(letBlock.expression)).a
						]))),
			true);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyLetDeclaration = F3(
	function (aliases, indent, letDecl) {
		if (letDecl.$ === 'LetFunction') {
			var fn = letDecl.a;
			return A2($mdgriffith$elm_codegen$Internal$Write$prettyFun, aliases, fn);
		} else {
			var pattern = letDecl.a;
			var expr = letDecl.b;
			return A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				A2(
					$the_sett$elm_pretty_printer$Pretty$indent,
					indent,
					A4(
						$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
						aliases,
						$mdgriffith$elm_codegen$Internal$Write$topContext,
						4,
						$mdgriffith$elm_codegen$Internal$Compiler$denode(expr)).a),
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$line,
					$the_sett$elm_pretty_printer$Pretty$words(
						_List_fromArray(
							[
								A3(
								$mdgriffith$elm_codegen$Internal$Write$prettyPatternInner,
								aliases,
								false,
								$mdgriffith$elm_codegen$Internal$Compiler$denode(pattern)),
								$the_sett$elm_pretty_printer$Pretty$string('=')
							]))));
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyList = F3(
	function (aliases, indent, exprs) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('['));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string(']'),
			$the_sett$elm_pretty_printer$Pretty$line);
		if (!exprs.b) {
			return _Utils_Tuple2(
				$the_sett$elm_pretty_printer$Pretty$string('[]'),
				false);
		} else {
			var _v20 = A2(
				$elm$core$Tuple$mapSecond,
				$elm$core$List$any($elm$core$Basics$identity),
				$elm$core$List$unzip(
					A2(
						$elm$core$List$map,
						A3(
							$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
							aliases,
							$mdgriffith$elm_codegen$Internal$Write$topContext,
							A2($mdgriffith$elm_codegen$Internal$Write$decrementIndent, indent, 2)),
						$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(exprs))));
			var prettyExpressions = _v20.a;
			var alwaysBreak = _v20.b;
			return _Utils_Tuple2(
				A2(
					$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$align(
						A3(
							$the_sett$elm_pretty_printer$Pretty$surround,
							open,
							close,
							A2($the_sett$elm_pretty_printer$Pretty$separators, ', ', prettyExpressions)))),
				alwaysBreak);
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyOperatorApplication = F6(
	function (aliases, indent, symbol, dir, exprl, exprr) {
		return (symbol === '<|') ? A6($mdgriffith$elm_codegen$Internal$Write$prettyOperatorApplicationLeft, aliases, indent, symbol, dir, exprl, exprr) : A6($mdgriffith$elm_codegen$Internal$Write$prettyOperatorApplicationRight, aliases, indent, symbol, dir, exprl, exprr);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyOperatorApplicationLeft = F6(
	function (aliases, indent, symbol, _v16, exprl, exprr) {
		var context = {
			isLeftPipe: true,
			isTop: false,
			precedence: $mdgriffith$elm_codegen$Internal$Write$precedence(symbol)
		};
		var _v17 = A4(
			$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
			aliases,
			context,
			4,
			$mdgriffith$elm_codegen$Internal$Compiler$denode(exprr));
		var prettyExpressionRight = _v17.a;
		var alwaysBreakRight = _v17.b;
		var _v18 = A4(
			$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
			aliases,
			context,
			4,
			$mdgriffith$elm_codegen$Internal$Compiler$denode(exprl));
		var prettyExpressionLeft = _v18.a;
		var alwaysBreakLeft = _v18.b;
		var alwaysBreak = alwaysBreakLeft || alwaysBreakRight;
		return _Utils_Tuple2(
			A2(
				$the_sett$elm_pretty_printer$Pretty$nest,
				4,
				A2(
					$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$lines(
						_List_fromArray(
							[
								$the_sett$elm_pretty_printer$Pretty$words(
								_List_fromArray(
									[
										prettyExpressionLeft,
										$the_sett$elm_pretty_printer$Pretty$string(symbol)
									])),
								prettyExpressionRight
							])))),
			alwaysBreak);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyOperatorApplicationRight = F6(
	function (aliases, indent, symbol, _v11, exprl, exprr) {
		var expandExpr = F3(
			function (innerIndent, context, expr) {
				if (expr.$ === 'OperatorApplication') {
					var sym = expr.a;
					var left = expr.c;
					var right = expr.d;
					return A4(innerOpApply, false, sym, left, right);
				} else {
					return _List_fromArray(
						[
							A4($mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner, aliases, context, innerIndent, expr)
						]);
				}
			});
		var innerOpApply = F4(
			function (isTop, sym, left, right) {
				var innerIndent = A2(
					$mdgriffith$elm_codegen$Internal$Write$decrementIndent,
					4,
					$elm$core$String$length(symbol) + 1);
				var leftIndent = isTop ? indent : innerIndent;
				var context = {
					isLeftPipe: '<|' === sym,
					isTop: false,
					precedence: $mdgriffith$elm_codegen$Internal$Write$precedence(sym)
				};
				var rightSide = A3(
					expandExpr,
					innerIndent,
					context,
					$mdgriffith$elm_codegen$Internal$Compiler$denode(right));
				if (rightSide.b) {
					var _v14 = rightSide.a;
					var hdExpr = _v14.a;
					var hdBreak = _v14.b;
					var tl = rightSide.b;
					return A2(
						$elm$core$List$append,
						A3(
							expandExpr,
							leftIndent,
							context,
							$mdgriffith$elm_codegen$Internal$Compiler$denode(left)),
						A2(
							$elm$core$List$cons,
							_Utils_Tuple2(
								A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									hdExpr,
									A2(
										$the_sett$elm_pretty_printer$Pretty$a,
										$the_sett$elm_pretty_printer$Pretty$space,
										$the_sett$elm_pretty_printer$Pretty$string(sym))),
								hdBreak),
							tl));
				} else {
					return _List_Nil;
				}
			});
		var _v12 = A2(
			$elm$core$Tuple$mapSecond,
			$elm$core$List$any($elm$core$Basics$identity),
			$elm$core$List$unzip(
				A4(innerOpApply, true, symbol, exprl, exprr)));
		var prettyExpressions = _v12.a;
		var alwaysBreak = _v12.b;
		return _Utils_Tuple2(
			A2(
				$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$align(
					A2(
						$the_sett$elm_pretty_printer$Pretty$join,
						A2($the_sett$elm_pretty_printer$Pretty$nest, indent, $the_sett$elm_pretty_printer$Pretty$line),
						prettyExpressions))),
			alwaysBreak);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyParenthesizedExpression = F3(
	function (aliases, indent, expr) {
		var open = $the_sett$elm_pretty_printer$Pretty$string('(');
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string(')'),
			$the_sett$elm_pretty_printer$Pretty$tightline);
		var _v10 = A4(
			$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
			aliases,
			$mdgriffith$elm_codegen$Internal$Write$topContext,
			A2($mdgriffith$elm_codegen$Internal$Write$decrementIndent, indent, 1),
			$mdgriffith$elm_codegen$Internal$Compiler$denode(expr));
		var prettyExpr = _v10.a;
		var alwaysBreak = _v10.b;
		return _Utils_Tuple2(
			A2(
				$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
				alwaysBreak,
				$the_sett$elm_pretty_printer$Pretty$align(
					A3(
						$the_sett$elm_pretty_printer$Pretty$surround,
						open,
						close,
						A2($the_sett$elm_pretty_printer$Pretty$nest, 1, prettyExpr)))),
			alwaysBreak);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyRecordAccess = F3(
	function (aliases, expr, field) {
		var _v9 = A4(
			$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
			aliases,
			$mdgriffith$elm_codegen$Internal$Write$topContext,
			4,
			$mdgriffith$elm_codegen$Internal$Compiler$denode(expr));
		var prettyExpr = _v9.a;
		var alwaysBreak = _v9.b;
		return _Utils_Tuple2(
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$the_sett$elm_pretty_printer$Pretty$string(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(field)),
				A2($the_sett$elm_pretty_printer$Pretty$a, $mdgriffith$elm_codegen$Internal$Write$dot, prettyExpr)),
			alwaysBreak);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyRecordExpr = F2(
	function (aliases, setters) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('{'));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string('}'),
			$the_sett$elm_pretty_printer$Pretty$line);
		if (!setters.b) {
			return _Utils_Tuple2(
				$the_sett$elm_pretty_printer$Pretty$string('{}'),
				false);
		} else {
			var _v8 = A2(
				$elm$core$Tuple$mapSecond,
				$elm$core$List$any($elm$core$Basics$identity),
				$elm$core$List$unzip(
					A2(
						$elm$core$List$map,
						$mdgriffith$elm_codegen$Internal$Write$prettySetter(aliases),
						$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(setters))));
			var prettyExpressions = _v8.a;
			var alwaysBreak = _v8.b;
			return _Utils_Tuple2(
				A2(
					$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$align(
						A3(
							$the_sett$elm_pretty_printer$Pretty$surround,
							open,
							close,
							A2($the_sett$elm_pretty_printer$Pretty$separators, ', ', prettyExpressions)))),
				alwaysBreak);
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyRecordUpdateExpression = F4(
	function (aliases, indent, _var, setters) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			$the_sett$elm_pretty_printer$Pretty$words(
				_List_fromArray(
					[
						$the_sett$elm_pretty_printer$Pretty$string('{'),
						$the_sett$elm_pretty_printer$Pretty$string(
						$mdgriffith$elm_codegen$Internal$Compiler$denode(_var))
					])));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string('}'),
			$the_sett$elm_pretty_printer$Pretty$line);
		var addBarToFirst = function (exprs) {
			if (!exprs.b) {
				return _List_Nil;
			} else {
				var hd = exprs.a;
				var tl = exprs.b;
				return A2(
					$elm$core$List$cons,
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						hd,
						$the_sett$elm_pretty_printer$Pretty$string('| ')),
					tl);
			}
		};
		if (!setters.b) {
			return _Utils_Tuple2(
				$the_sett$elm_pretty_printer$Pretty$string('{}'),
				false);
		} else {
			var _v5 = A2(
				$elm$core$Tuple$mapSecond,
				$elm$core$List$any($elm$core$Basics$identity),
				$elm$core$List$unzip(
					A2(
						$elm$core$List$map,
						$mdgriffith$elm_codegen$Internal$Write$prettySetter(aliases),
						$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(setters))));
			var prettyExpressions = _v5.a;
			var alwaysBreak = _v5.b;
			return _Utils_Tuple2(
				A2(
					$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$align(
						A3(
							$the_sett$elm_pretty_printer$Pretty$surround,
							$the_sett$elm_pretty_printer$Pretty$empty,
							close,
							A2(
								$the_sett$elm_pretty_printer$Pretty$nest,
								indent,
								A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									A2(
										$the_sett$elm_pretty_printer$Pretty$separators,
										', ',
										addBarToFirst(prettyExpressions)),
									open))))),
				alwaysBreak);
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettySetter = F2(
	function (aliases, _v2) {
		var fld = _v2.a;
		var val = _v2.b;
		var _v3 = A4(
			$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
			aliases,
			$mdgriffith$elm_codegen$Internal$Write$topContext,
			4,
			$mdgriffith$elm_codegen$Internal$Compiler$denode(val));
		var prettyExpr = _v3.a;
		var alwaysBreak = _v3.b;
		return _Utils_Tuple2(
			A2(
				$the_sett$elm_pretty_printer$Pretty$nest,
				4,
				A2(
					$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$lines(
						_List_fromArray(
							[
								$the_sett$elm_pretty_printer$Pretty$words(
								_List_fromArray(
									[
										$the_sett$elm_pretty_printer$Pretty$string(
										$mdgriffith$elm_codegen$Internal$Compiler$denode(fld)),
										$the_sett$elm_pretty_printer$Pretty$string('=')
									])),
								prettyExpr
							])))),
			alwaysBreak);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyTupledExpression = F3(
	function (aliases, indent, exprs) {
		var open = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$space,
			$the_sett$elm_pretty_printer$Pretty$string('('));
		var close = A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$string(')'),
			$the_sett$elm_pretty_printer$Pretty$line);
		if (!exprs.b) {
			return _Utils_Tuple2(
				$the_sett$elm_pretty_printer$Pretty$string('()'),
				false);
		} else {
			var _v1 = A2(
				$elm$core$Tuple$mapSecond,
				$elm$core$List$any($elm$core$Basics$identity),
				$elm$core$List$unzip(
					A2(
						$elm$core$List$map,
						A3(
							$mdgriffith$elm_codegen$Internal$Write$prettyExpressionInner,
							aliases,
							$mdgriffith$elm_codegen$Internal$Write$topContext,
							A2($mdgriffith$elm_codegen$Internal$Write$decrementIndent, indent, 2)),
						$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(exprs))));
			var prettyExpressions = _v1.a;
			var alwaysBreak = _v1.b;
			return _Utils_Tuple2(
				A2(
					$mdgriffith$elm_codegen$Internal$Write$optionalGroup,
					alwaysBreak,
					$the_sett$elm_pretty_printer$Pretty$align(
						A3(
							$the_sett$elm_pretty_printer$Pretty$surround,
							open,
							close,
							A2($the_sett$elm_pretty_printer$Pretty$separators, ', ', prettyExpressions)))),
				alwaysBreak);
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyDestructuring = F3(
	function (aliases, pattern, expr) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			$the_sett$elm_pretty_printer$Pretty$lines(
				_List_fromArray(
					[
						$the_sett$elm_pretty_printer$Pretty$words(
						_List_fromArray(
							[
								A2($mdgriffith$elm_codegen$Internal$Write$prettyPattern, aliases, pattern),
								$the_sett$elm_pretty_printer$Pretty$string('=')
							])),
						A2($mdgriffith$elm_codegen$Internal$Write$prettyExpression, aliases, expr)
					])));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyInfix = function (infix_) {
	var dirToString = function (direction) {
		switch (direction.$) {
			case 'Left':
				return 'left';
			case 'Right':
				return 'right';
			default:
				return 'non';
		}
	};
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('infix'),
				$the_sett$elm_pretty_printer$Pretty$string(
				dirToString(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(infix_.direction))),
				$the_sett$elm_pretty_printer$Pretty$string(
				$elm$core$String$fromInt(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(infix_.precedence))),
				$the_sett$elm_pretty_printer$Pretty$parens(
				$the_sett$elm_pretty_printer$Pretty$string(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(infix_.operator))),
				$the_sett$elm_pretty_printer$Pretty$string('='),
				$the_sett$elm_pretty_printer$Pretty$string(
				$mdgriffith$elm_codegen$Internal$Compiler$denode(infix_._function))
			]));
};
var $mdgriffith$elm_codegen$Internal$Write$prettyPortDeclaration = F2(
	function (aliases, sig) {
		return $the_sett$elm_pretty_printer$Pretty$words(
			_List_fromArray(
				[
					$the_sett$elm_pretty_printer$Pretty$string('port'),
					A2($mdgriffith$elm_codegen$Internal$Write$prettySignature, aliases, sig)
				]));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyTypeAlias = F2(
	function (aliases, tAlias) {
		var typeAliasPretty = A2(
			$the_sett$elm_pretty_printer$Pretty$nest,
			4,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				A2(
					$mdgriffith$elm_codegen$Internal$Write$prettyTypeAnnotation,
					aliases,
					$mdgriffith$elm_codegen$Internal$Compiler$denode(tAlias.typeAnnotation)),
				A2(
					$the_sett$elm_pretty_printer$Pretty$a,
					$the_sett$elm_pretty_printer$Pretty$line,
					$the_sett$elm_pretty_printer$Pretty$words(
						_List_fromArray(
							[
								$the_sett$elm_pretty_printer$Pretty$string('type alias'),
								$the_sett$elm_pretty_printer$Pretty$string(
								$mdgriffith$elm_codegen$Internal$Compiler$denode(tAlias.name)),
								$the_sett$elm_pretty_printer$Pretty$words(
								A2(
									$elm$core$List$map,
									$the_sett$elm_pretty_printer$Pretty$string,
									$mdgriffith$elm_codegen$Internal$Compiler$denodeAll(tAlias.generics))),
								$the_sett$elm_pretty_printer$Pretty$string('=')
							])))));
		return $the_sett$elm_pretty_printer$Pretty$lines(
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_codegen$Internal$Write$prettyMaybe,
					$mdgriffith$elm_codegen$Internal$Write$prettyDocumentation,
					$mdgriffith$elm_codegen$Internal$Compiler$denodeMaybe(tAlias.documentation)),
					typeAliasPretty
				]));
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyElmSyntaxDeclaration = F2(
	function (aliases, decl) {
		switch (decl.$) {
			case 'FunctionDeclaration':
				var fn = decl.a;
				return A2($mdgriffith$elm_codegen$Internal$Write$prettyFun, aliases, fn);
			case 'AliasDeclaration':
				var tAlias = decl.a;
				return A2($mdgriffith$elm_codegen$Internal$Write$prettyTypeAlias, aliases, tAlias);
			case 'CustomTypeDeclaration':
				var type_ = decl.a;
				return A2($mdgriffith$elm_codegen$Internal$Write$prettyCustomType, aliases, type_);
			case 'PortDeclaration':
				var sig = decl.a;
				return A2($mdgriffith$elm_codegen$Internal$Write$prettyPortDeclaration, aliases, sig);
			case 'InfixDeclaration':
				var infix_ = decl.a;
				return $mdgriffith$elm_codegen$Internal$Write$prettyInfix(infix_);
			default:
				var pattern = decl.a;
				var expr = decl.b;
				return A3(
					$mdgriffith$elm_codegen$Internal$Write$prettyDestructuring,
					aliases,
					$mdgriffith$elm_codegen$Internal$Compiler$denode(pattern),
					$mdgriffith$elm_codegen$Internal$Compiler$denode(expr));
		}
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyDeclarations = F2(
	function (aliases, decls) {
		return A3(
			$elm$core$List$foldl,
			F2(
				function (decl, doc) {
					switch (decl.$) {
						case 'RenderedComment':
							var content = decl.a;
							return A2(
								$the_sett$elm_pretty_printer$Pretty$a,
								$the_sett$elm_pretty_printer$Pretty$line,
								A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									$the_sett$elm_pretty_printer$Pretty$line,
									A2(
										$the_sett$elm_pretty_printer$Pretty$a,
										$the_sett$elm_pretty_printer$Pretty$string(content + '\n'),
										doc)));
						case 'RenderedBlock':
							var source = decl.a;
							return A2(
								$the_sett$elm_pretty_printer$Pretty$a,
								$the_sett$elm_pretty_printer$Pretty$line,
								A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									$the_sett$elm_pretty_printer$Pretty$line,
									A2(
										$the_sett$elm_pretty_printer$Pretty$a,
										$the_sett$elm_pretty_printer$Pretty$line,
										A2(
											$the_sett$elm_pretty_printer$Pretty$a,
											$the_sett$elm_pretty_printer$Pretty$string(source),
											doc))));
						default:
							var innerDecl = decl.a;
							return A2(
								$the_sett$elm_pretty_printer$Pretty$a,
								$the_sett$elm_pretty_printer$Pretty$line,
								A2(
									$the_sett$elm_pretty_printer$Pretty$a,
									$the_sett$elm_pretty_printer$Pretty$line,
									A2(
										$the_sett$elm_pretty_printer$Pretty$a,
										$the_sett$elm_pretty_printer$Pretty$line,
										A2(
											$the_sett$elm_pretty_printer$Pretty$a,
											A2($mdgriffith$elm_codegen$Internal$Write$prettyElmSyntaxDeclaration, aliases, innerDecl),
											doc))));
					}
				}),
			$the_sett$elm_pretty_printer$Pretty$empty,
			decls);
	});
var $mdgriffith$elm_codegen$Internal$Comments$delimeters = function (doc) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$a,
		$the_sett$elm_pretty_printer$Pretty$string('-}'),
		A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			$the_sett$elm_pretty_printer$Pretty$line,
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				doc,
				$the_sett$elm_pretty_printer$Pretty$string('{-| '))));
};
var $mdgriffith$elm_codegen$Internal$Comments$getParts = function (_v0) {
	var parts = _v0.a;
	return $elm$core$List$reverse(parts);
};
var $mdgriffith$elm_codegen$Internal$Comments$DocTags = function (a) {
	return {$: 'DocTags', a: a};
};
var $mdgriffith$elm_codegen$Internal$Comments$fitAndSplit = F2(
	function (width, tags) {
		if (!tags.b) {
			return _List_Nil;
		} else {
			var t = tags.a;
			var ts = tags.b;
			var _v1 = A3(
				$elm$core$List$foldl,
				F2(
					function (tag, _v2) {
						var allSplits = _v2.a;
						var curSplit = _v2.b;
						var remaining = _v2.c;
						return (_Utils_cmp(
							$elm$core$String$length(tag),
							remaining) < 1) ? _Utils_Tuple3(
							allSplits,
							A2($elm$core$List$cons, tag, curSplit),
							remaining - $elm$core$String$length(tag)) : _Utils_Tuple3(
							_Utils_ap(
								allSplits,
								_List_fromArray(
									[
										$elm$core$List$reverse(curSplit)
									])),
							_List_fromArray(
								[tag]),
							width - $elm$core$String$length(tag));
					}),
				_Utils_Tuple3(
					_List_Nil,
					_List_fromArray(
						[t]),
					width - $elm$core$String$length(t)),
				ts);
			var splitsExceptLast = _v1.a;
			var lastSplit = _v1.b;
			return _Utils_ap(
				splitsExceptLast,
				_List_fromArray(
					[
						$elm$core$List$reverse(lastSplit)
					]));
		}
	});
var $mdgriffith$elm_codegen$Internal$Comments$mergeDocTags = function (innerParts) {
	var _v0 = A3(
		$elm$core$List$foldr,
		F2(
			function (part, _v1) {
				var accum = _v1.a;
				var context = _v1.b;
				if (context.$ === 'Nothing') {
					if (part.$ === 'DocTags') {
						var tags = part.a;
						return _Utils_Tuple2(
							accum,
							$elm$core$Maybe$Just(tags));
					} else {
						var otherPart = part;
						return _Utils_Tuple2(
							A2($elm$core$List$cons, otherPart, accum),
							$elm$core$Maybe$Nothing);
					}
				} else {
					var contextTags = context.a;
					if (part.$ === 'DocTags') {
						var tags = part.a;
						return _Utils_Tuple2(
							accum,
							$elm$core$Maybe$Just(
								_Utils_ap(contextTags, tags)));
					} else {
						var otherPart = part;
						return _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								otherPart,
								A2(
									$elm$core$List$cons,
									$mdgriffith$elm_codegen$Internal$Comments$DocTags(
										$elm$core$List$sort(contextTags)),
									accum)),
							$elm$core$Maybe$Nothing);
					}
				}
			}),
		_Utils_Tuple2(_List_Nil, $elm$core$Maybe$Nothing),
		innerParts);
	var partsExceptMaybeFirst = _v0.a;
	var maybeFirstPart = _v0.b;
	if (maybeFirstPart.$ === 'Nothing') {
		return partsExceptMaybeFirst;
	} else {
		var tags = maybeFirstPart.a;
		return A2(
			$elm$core$List$cons,
			$mdgriffith$elm_codegen$Internal$Comments$DocTags(
				$elm$core$List$sort(tags)),
			partsExceptMaybeFirst);
	}
};
var $mdgriffith$elm_codegen$Internal$Comments$layoutTags = F2(
	function (width, parts) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (part, _v0) {
					var accumParts = _v0.a;
					var accumDocTags = _v0.b;
					if (part.$ === 'DocTags') {
						var tags = part.a;
						var splits = A2($mdgriffith$elm_codegen$Internal$Comments$fitAndSplit, width, tags);
						return _Utils_Tuple2(
							_Utils_ap(
								A2($elm$core$List$map, $mdgriffith$elm_codegen$Internal$Comments$DocTags, splits),
								accumParts),
							_Utils_ap(accumDocTags, splits));
					} else {
						var otherPart = part;
						return _Utils_Tuple2(
							A2($elm$core$List$cons, otherPart, accumParts),
							accumDocTags);
					}
				}),
			_Utils_Tuple2(_List_Nil, _List_Nil),
			$mdgriffith$elm_codegen$Internal$Comments$mergeDocTags(parts));
	});
var $the_sett$elm_pretty_printer$Internals$NLine = F3(
	function (a, b, c) {
		return {$: 'NLine', a: a, b: b, c: c};
	});
var $the_sett$elm_pretty_printer$Internals$NNil = {$: 'NNil'};
var $the_sett$elm_pretty_printer$Internals$NText = F3(
	function (a, b, c) {
		return {$: 'NText', a: a, b: b, c: c};
	});
var $the_sett$elm_pretty_printer$Internals$fits = F2(
	function (w, normal) {
		fits:
		while (true) {
			if (w < 0) {
				return false;
			} else {
				switch (normal.$) {
					case 'NNil':
						return true;
					case 'NText':
						var text = normal.a;
						var innerNormal = normal.b;
						var $temp$w = w - $elm$core$String$length(text),
							$temp$normal = innerNormal(_Utils_Tuple0);
						w = $temp$w;
						normal = $temp$normal;
						continue fits;
					default:
						return true;
				}
			}
		}
	});
var $the_sett$elm_pretty_printer$Internals$better = F4(
	function (w, k, doc, doc2Fn) {
		return A2($the_sett$elm_pretty_printer$Internals$fits, w - k, doc) ? doc : doc2Fn(_Utils_Tuple0);
	});
var $the_sett$elm_pretty_printer$Internals$best = F3(
	function (width, startCol, x) {
		var be = F3(
			function (w, k, docs) {
				be:
				while (true) {
					if (!docs.b) {
						return $the_sett$elm_pretty_printer$Internals$NNil;
					} else {
						switch (docs.a.b.$) {
							case 'Empty':
								var _v1 = docs.a;
								var i = _v1.a;
								var _v2 = _v1.b;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = ds;
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
							case 'Concatenate':
								var _v3 = docs.a;
								var i = _v3.a;
								var _v4 = _v3.b;
								var doc = _v4.a;
								var doc2 = _v4.b;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = A2(
									$elm$core$List$cons,
									_Utils_Tuple2(
										i,
										doc(_Utils_Tuple0)),
									A2(
										$elm$core$List$cons,
										_Utils_Tuple2(
											i,
											doc2(_Utils_Tuple0)),
										ds));
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
							case 'Nest':
								var _v5 = docs.a;
								var i = _v5.a;
								var _v6 = _v5.b;
								var j = _v6.a;
								var doc = _v6.b;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = A2(
									$elm$core$List$cons,
									_Utils_Tuple2(
										i + j,
										doc(_Utils_Tuple0)),
									ds);
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
							case 'Text':
								var _v7 = docs.a;
								var i = _v7.a;
								var _v8 = _v7.b;
								var text = _v8.a;
								var maybeTag = _v8.b;
								var ds = docs.b;
								return A3(
									$the_sett$elm_pretty_printer$Internals$NText,
									text,
									function (_v9) {
										return A3(
											be,
											w,
											k + $elm$core$String$length(text),
											ds);
									},
									maybeTag);
							case 'Line':
								var _v10 = docs.a;
								var i = _v10.a;
								var _v11 = _v10.b;
								var vsep = _v11.b;
								var ds = docs.b;
								return A3(
									$the_sett$elm_pretty_printer$Internals$NLine,
									i,
									vsep,
									function (_v12) {
										return A3(
											be,
											w,
											i + $elm$core$String$length(vsep),
											ds);
									});
							case 'Union':
								var _v13 = docs.a;
								var i = _v13.a;
								var _v14 = _v13.b;
								var doc = _v14.a;
								var doc2 = _v14.b;
								var ds = docs.b;
								return A4(
									$the_sett$elm_pretty_printer$Internals$better,
									w,
									k,
									A3(
										be,
										w,
										k,
										A2(
											$elm$core$List$cons,
											_Utils_Tuple2(i, doc),
											ds)),
									function (_v15) {
										return A3(
											be,
											w,
											k,
											A2(
												$elm$core$List$cons,
												_Utils_Tuple2(i, doc2),
												ds));
									});
							case 'Nesting':
								var _v16 = docs.a;
								var i = _v16.a;
								var fn = _v16.b.a;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = A2(
									$elm$core$List$cons,
									_Utils_Tuple2(
										i,
										fn(i)),
									ds);
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
							default:
								var _v17 = docs.a;
								var i = _v17.a;
								var fn = _v17.b.a;
								var ds = docs.b;
								var $temp$w = w,
									$temp$k = k,
									$temp$docs = A2(
									$elm$core$List$cons,
									_Utils_Tuple2(
										i,
										fn(k)),
									ds);
								w = $temp$w;
								k = $temp$k;
								docs = $temp$docs;
								continue be;
						}
					}
				}
			});
		return A3(
			be,
			width,
			startCol,
			_List_fromArray(
				[
					_Utils_Tuple2(0, x)
				]));
	});
var $the_sett$elm_pretty_printer$Internals$layout = function (normal) {
	var layoutInner = F2(
		function (normal2, acc) {
			layoutInner:
			while (true) {
				switch (normal2.$) {
					case 'NNil':
						return acc;
					case 'NText':
						var text = normal2.a;
						var innerNormal = normal2.b;
						var maybeTag = normal2.c;
						var $temp$normal2 = innerNormal(_Utils_Tuple0),
							$temp$acc = A2($elm$core$List$cons, text, acc);
						normal2 = $temp$normal2;
						acc = $temp$acc;
						continue layoutInner;
					default:
						var i = normal2.a;
						var sep = normal2.b;
						var innerNormal = normal2.c;
						var norm = innerNormal(_Utils_Tuple0);
						if (norm.$ === 'NLine') {
							var $temp$normal2 = innerNormal(_Utils_Tuple0),
								$temp$acc = A2($elm$core$List$cons, '\n' + sep, acc);
							normal2 = $temp$normal2;
							acc = $temp$acc;
							continue layoutInner;
						} else {
							var $temp$normal2 = innerNormal(_Utils_Tuple0),
								$temp$acc = A2(
								$elm$core$List$cons,
								'\n' + (A2($the_sett$elm_pretty_printer$Internals$copy, i, ' ') + sep),
								acc);
							normal2 = $temp$normal2;
							acc = $temp$acc;
							continue layoutInner;
						}
				}
			}
		});
	return $elm$core$String$concat(
		$elm$core$List$reverse(
			A2(layoutInner, normal, _List_Nil)));
};
var $the_sett$elm_pretty_printer$Pretty$pretty = F2(
	function (w, doc) {
		return $the_sett$elm_pretty_printer$Internals$layout(
			A3($the_sett$elm_pretty_printer$Internals$best, w, 0, doc));
	});
var $mdgriffith$elm_codegen$Internal$Comments$prettyCode = function (val) {
	return A2(
		$the_sett$elm_pretty_printer$Pretty$indent,
		4,
		$the_sett$elm_pretty_printer$Pretty$string(val));
};
var $mdgriffith$elm_codegen$Internal$Comments$prettyMarkdown = function (val) {
	return $the_sett$elm_pretty_printer$Pretty$string(val);
};
var $mdgriffith$elm_codegen$Internal$Comments$prettyTags = function (tags) {
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('@docs'),
				A2(
				$the_sett$elm_pretty_printer$Pretty$join,
				$the_sett$elm_pretty_printer$Pretty$string(', '),
				A2($elm$core$List$map, $the_sett$elm_pretty_printer$Pretty$string, tags))
			]));
};
var $mdgriffith$elm_codegen$Internal$Comments$prettyCommentPart = function (part) {
	switch (part.$) {
		case 'Markdown':
			var val = part.a;
			return $mdgriffith$elm_codegen$Internal$Comments$prettyMarkdown(val);
		case 'Code':
			var val = part.a;
			return $mdgriffith$elm_codegen$Internal$Comments$prettyCode(val);
		default:
			var tags = part.a;
			return $mdgriffith$elm_codegen$Internal$Comments$prettyTags(tags);
	}
};
var $mdgriffith$elm_codegen$Internal$Comments$prettyFileComment = F2(
	function (width, comment) {
		var _v0 = A2(
			$mdgriffith$elm_codegen$Internal$Comments$layoutTags,
			width,
			$mdgriffith$elm_codegen$Internal$Comments$getParts(comment));
		var parts = _v0.a;
		var splits = _v0.b;
		return _Utils_Tuple2(
			A2(
				$the_sett$elm_pretty_printer$Pretty$pretty,
				width,
				$mdgriffith$elm_codegen$Internal$Comments$delimeters(
					$the_sett$elm_pretty_printer$Pretty$lines(
						A2($elm$core$List$map, $mdgriffith$elm_codegen$Internal$Comments$prettyCommentPart, parts)))),
			splits);
	});
var $mdgriffith$elm_codegen$Internal$Write$prettyDefaultModuleData = function (moduleData) {
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('module'),
				$mdgriffith$elm_codegen$Internal$Write$prettyModuleName(
				$mdgriffith$elm_codegen$Internal$Compiler$denode(moduleData.moduleName)),
				$mdgriffith$elm_codegen$Internal$Write$prettyExposing(
				$mdgriffith$elm_codegen$Internal$Compiler$denode(moduleData.exposingList))
			]));
};
var $mdgriffith$elm_codegen$Internal$Write$prettyEffectModuleData = function (moduleData) {
	var prettyCmdAndSub = F2(
		function (maybeCmd, maybeSub) {
			var _v0 = _Utils_Tuple2(maybeCmd, maybeSub);
			if (_v0.a.$ === 'Just') {
				if (_v0.b.$ === 'Just') {
					var cmdName = _v0.a.a;
					var subName = _v0.b.a;
					return $elm$core$Maybe$Just(
						$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string('where { command ='),
									$the_sett$elm_pretty_printer$Pretty$string(cmdName),
									$the_sett$elm_pretty_printer$Pretty$string(','),
									$the_sett$elm_pretty_printer$Pretty$string('subscription ='),
									$the_sett$elm_pretty_printer$Pretty$string(subName),
									$the_sett$elm_pretty_printer$Pretty$string('}')
								])));
				} else {
					var cmdName = _v0.a.a;
					var _v3 = _v0.b;
					return $elm$core$Maybe$Just(
						$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string('where { command ='),
									$the_sett$elm_pretty_printer$Pretty$string(cmdName),
									$the_sett$elm_pretty_printer$Pretty$string('}')
								])));
				}
			} else {
				if (_v0.b.$ === 'Nothing') {
					var _v1 = _v0.a;
					var _v2 = _v0.b;
					return $elm$core$Maybe$Nothing;
				} else {
					var _v4 = _v0.a;
					var subName = _v0.b.a;
					return $elm$core$Maybe$Just(
						$the_sett$elm_pretty_printer$Pretty$words(
							_List_fromArray(
								[
									$the_sett$elm_pretty_printer$Pretty$string('where { subscription ='),
									$the_sett$elm_pretty_printer$Pretty$string(subName),
									$the_sett$elm_pretty_printer$Pretty$string('}')
								])));
				}
			}
		});
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('effect module'),
				$mdgriffith$elm_codegen$Internal$Write$prettyModuleName(
				$mdgriffith$elm_codegen$Internal$Compiler$denode(moduleData.moduleName)),
				A2(
				$mdgriffith$elm_codegen$Internal$Write$prettyMaybe,
				$elm$core$Basics$identity,
				A2(
					prettyCmdAndSub,
					$mdgriffith$elm_codegen$Internal$Compiler$denodeMaybe(moduleData.command),
					$mdgriffith$elm_codegen$Internal$Compiler$denodeMaybe(moduleData.subscription))),
				$mdgriffith$elm_codegen$Internal$Write$prettyExposing(
				$mdgriffith$elm_codegen$Internal$Compiler$denode(moduleData.exposingList))
			]));
};
var $mdgriffith$elm_codegen$Internal$Write$prettyPortModuleData = function (moduleData) {
	return $the_sett$elm_pretty_printer$Pretty$words(
		_List_fromArray(
			[
				$the_sett$elm_pretty_printer$Pretty$string('port module'),
				$mdgriffith$elm_codegen$Internal$Write$prettyModuleName(
				$mdgriffith$elm_codegen$Internal$Compiler$denode(moduleData.moduleName)),
				$mdgriffith$elm_codegen$Internal$Write$prettyExposing(
				$mdgriffith$elm_codegen$Internal$Compiler$denode(moduleData.exposingList))
			]));
};
var $mdgriffith$elm_codegen$Internal$Write$prettyModule = function (mod) {
	switch (mod.$) {
		case 'NormalModule':
			var defaultModuleData = mod.a;
			return $mdgriffith$elm_codegen$Internal$Write$prettyDefaultModuleData(defaultModuleData);
		case 'PortModule':
			var defaultModuleData = mod.a;
			return $mdgriffith$elm_codegen$Internal$Write$prettyPortModuleData(defaultModuleData);
		default:
			var effectModuleData = mod.a;
			return $mdgriffith$elm_codegen$Internal$Write$prettyEffectModuleData(effectModuleData);
	}
};
var $mdgriffith$elm_codegen$Internal$Write$prepareLayout = F2(
	function (width, file) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$a,
			A2($mdgriffith$elm_codegen$Internal$Write$prettyDeclarations, file.aliases, file.declarations),
			A2(
				$the_sett$elm_pretty_printer$Pretty$a,
				$mdgriffith$elm_codegen$Internal$Write$importsPretty(file.imports),
				function (doc) {
					var _v0 = file.comments;
					if (_v0.$ === 'Nothing') {
						return doc;
					} else {
						var fileComment = _v0.a;
						var _v1 = A2($mdgriffith$elm_codegen$Internal$Comments$prettyFileComment, width, fileComment);
						var fileCommentStr = _v1.a;
						var innerTags = _v1.b;
						return A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$line,
							A2(
								$the_sett$elm_pretty_printer$Pretty$a,
								$mdgriffith$elm_codegen$Internal$Write$prettyComments(
									_List_fromArray(
										[fileCommentStr])),
								doc));
					}
				}(
					A2(
						$the_sett$elm_pretty_printer$Pretty$a,
						$the_sett$elm_pretty_printer$Pretty$line,
						A2(
							$the_sett$elm_pretty_printer$Pretty$a,
							$the_sett$elm_pretty_printer$Pretty$line,
							$mdgriffith$elm_codegen$Internal$Write$prettyModule(file.moduleDefinition))))));
	});
var $mdgriffith$elm_codegen$Internal$Write$pretty = F2(
	function (width, file) {
		return A2(
			$the_sett$elm_pretty_printer$Pretty$pretty,
			width,
			A2($mdgriffith$elm_codegen$Internal$Write$prepareLayout, width, file));
	});
var $mdgriffith$elm_codegen$Internal$Write$write = $mdgriffith$elm_codegen$Internal$Write$pretty(80);
var $mdgriffith$elm_codegen$Internal$Render$render = F2(
	function (toDocComment, fileDetails) {
		var rendered = A3(
			$elm$core$List$foldl,
			F2(
				function (decl, gathered) {
					switch (decl.$) {
						case 'Comment':
							var comm = decl.a;
							return _Utils_update(
								gathered,
								{
									declarations: A2(
										$elm$core$List$cons,
										$mdgriffith$elm_codegen$Internal$Compiler$RenderedComment(comm),
										gathered.declarations)
								});
						case 'Block':
							var block = decl.a;
							return _Utils_update(
								gathered,
								{
									declarations: A2(
										$elm$core$List$cons,
										$mdgriffith$elm_codegen$Internal$Compiler$RenderedBlock(block),
										gathered.declarations)
								});
						default:
							var decDetails = decl.a;
							var result = decDetails.toBody(fileDetails.index);
							return {
								declarations: A2(
									$elm$core$List$cons,
									$mdgriffith$elm_codegen$Internal$Compiler$RenderedDecl(
										A2($mdgriffith$elm_codegen$Internal$Render$addDocs, decDetails.docs, result.declaration)),
									gathered.declarations),
								exposed: A3($mdgriffith$elm_codegen$Internal$Render$addExposed, decDetails.exposed, result.declaration, gathered.exposed),
								exposedGroups: function () {
									var _v5 = decDetails.exposed;
									if (_v5.$ === 'NotExposed') {
										return gathered.exposedGroups;
									} else {
										var details = _v5.a;
										return A2(
											$elm$core$List$cons,
											_Utils_Tuple2(details.group, decDetails.name),
											gathered.exposedGroups);
									}
								}(),
								hasPorts: function () {
									if (gathered.hasPorts) {
										return gathered.hasPorts;
									} else {
										var _v6 = result.declaration;
										if (_v6.$ === 'PortDeclaration') {
											return true;
										} else {
											return false;
										}
									}
								}(),
								imports: _Utils_ap(
									result.additionalImports,
									_Utils_ap(decDetails.imports, gathered.imports)),
								warnings: function () {
									var _v7 = result.warning;
									if (_v7.$ === 'Nothing') {
										return gathered.warnings;
									} else {
										var warn = _v7.a;
										return A2($elm$core$List$cons, warn, gathered.warnings);
									}
								}()
							};
					}
				}),
			{declarations: _List_Nil, exposed: _List_Nil, exposedGroups: _List_Nil, hasPorts: false, imports: _List_Nil, warnings: _List_Nil},
			fileDetails.declarations);
		var body = $mdgriffith$elm_codegen$Internal$Write$write(
			{
				aliases: fileDetails.aliases,
				comments: $elm$core$Maybe$Just(
					A2(
						$mdgriffith$elm_codegen$Internal$Comments$addPart,
						$mdgriffith$elm_codegen$Internal$Comments$emptyComment,
						$mdgriffith$elm_codegen$Internal$Comments$Markdown(
							function () {
								var _v0 = rendered.exposedGroups;
								if (!_v0.b) {
									return '';
								} else {
									return '\n' + A2(
										$elm$core$String$join,
										'\n\n',
										toDocComment(
											$mdgriffith$elm_codegen$Internal$Render$groupExposing(
												A2(
													$elm$core$List$sortBy,
													function (_v1) {
														var group = _v1.a;
														if (group.$ === 'Nothing') {
															return 'zzzzzzzzz';
														} else {
															var name = group.a;
															return name;
														}
													},
													rendered.exposedGroups))));
								}
							}()))),
				declarations: $elm$core$List$reverse(rendered.declarations),
				imports: A2(
					$elm$core$List$filterMap,
					$mdgriffith$elm_codegen$Internal$Compiler$makeImport(fileDetails.aliases),
					$mdgriffith$elm_codegen$Internal$Render$dedupImports(rendered.imports)),
				moduleDefinition: (rendered.hasPorts ? $stil4m$elm_syntax$Elm$Syntax$Module$PortModule : $stil4m$elm_syntax$Elm$Syntax$Module$NormalModule)(
					{
						exposingList: function () {
							var _v3 = rendered.exposed;
							if (!_v3.b) {
								return $mdgriffith$elm_codegen$Internal$Compiler$nodify(
									$stil4m$elm_syntax$Elm$Syntax$Exposing$All($stil4m$elm_syntax$Elm$Syntax$Range$emptyRange));
							} else {
								return $mdgriffith$elm_codegen$Internal$Compiler$nodify(
									$stil4m$elm_syntax$Elm$Syntax$Exposing$Explicit(
										$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(rendered.exposed)));
							}
						}(),
						moduleName: $mdgriffith$elm_codegen$Internal$Compiler$nodify(fileDetails.moduleName)
					})
			});
		return {
			contents: body,
			path: A2($elm$core$String$join, '/', fileDetails.moduleName) + '.elm',
			warnings: rendered.warnings
		};
	});
var $mdgriffith$elm_codegen$Elm$docs = function (group) {
	var _v0 = group.group;
	if (_v0.$ === 'Nothing') {
		return '@docs ' + A2($elm$core$String$join, ', ', group.members);
	} else {
		var groupName = _v0.a;
		return '## ' + (groupName + ('\n\n@docs ' + A2($elm$core$String$join, ', ', group.members)));
	}
};
var $mdgriffith$elm_codegen$Elm$renderStandardComment = function (groups) {
	return $elm$core$List$isEmpty(groups) ? _List_Nil : A2($elm$core$List$map, $mdgriffith$elm_codegen$Elm$docs, groups);
};
var $mdgriffith$elm_codegen$Internal$Index$startIndex = A4($mdgriffith$elm_codegen$Internal$Index$Index, 0, _List_Nil, $elm$core$Set$empty, true);
var $mdgriffith$elm_codegen$Elm$file = F2(
	function (mod, decs) {
		return A2(
			$mdgriffith$elm_codegen$Internal$Render$render,
			$mdgriffith$elm_codegen$Elm$renderStandardComment,
			{aliases: _List_Nil, declarations: decs, index: $mdgriffith$elm_codegen$Internal$Index$startIndex, moduleName: mod});
	});
var $stil4m$elm_syntax$Elm$Syntax$Node$map = F2(
	function (f, _v0) {
		var r = _v0.a;
		var a = _v0.b;
		return A2(
			$stil4m$elm_syntax$Elm$Syntax$Node$Node,
			r,
			f(a));
	});
var $mdgriffith$elm_codegen$Internal$Clean$doRename = F2(
	function (dict, ann) {
		switch (ann.$) {
			case 'GenericType':
				var generic = ann.a;
				var _v1 = A2($elm$core$Dict$get, generic, dict);
				if (_v1.$ === 'Nothing') {
					return ann;
				} else {
					var renamed = _v1.a;
					return $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(renamed);
				}
			case 'Typed':
				var name = ann.a;
				var nodedVars = ann.b;
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
					name,
					A2(
						$elm$core$List$map,
						$stil4m$elm_syntax$Elm$Syntax$Node$map(
							$mdgriffith$elm_codegen$Internal$Clean$doRename(dict)),
						nodedVars));
			case 'Unit':
				return ann;
			case 'Tupled':
				var nodedVars = ann.a;
				return $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled(
					A2(
						$elm$core$List$map,
						$stil4m$elm_syntax$Elm$Syntax$Node$map(
							$mdgriffith$elm_codegen$Internal$Clean$doRename(dict)),
						nodedVars));
			case 'Record':
				var record = ann.a;
				return $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(
					A2(
						$elm$core$List$map,
						$stil4m$elm_syntax$Elm$Syntax$Node$map(
							$elm$core$Tuple$mapSecond(
								$stil4m$elm_syntax$Elm$Syntax$Node$map(
									$mdgriffith$elm_codegen$Internal$Clean$doRename(dict)))),
						record));
			case 'GenericRecord':
				var name = ann.a;
				var _v2 = ann.b;
				var range = _v2.a;
				var record = _v2.b;
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord,
					name,
					A2(
						$stil4m$elm_syntax$Elm$Syntax$Node$Node,
						range,
						A2(
							$elm$core$List$map,
							$stil4m$elm_syntax$Elm$Syntax$Node$map(
								$elm$core$Tuple$mapSecond(
									$stil4m$elm_syntax$Elm$Syntax$Node$map(
										$mdgriffith$elm_codegen$Internal$Clean$doRename(dict)))),
							record)));
			default:
				var nodeOne = ann.a;
				var nodeTwo = ann.b;
				return A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
					A2(
						$stil4m$elm_syntax$Elm$Syntax$Node$map,
						$mdgriffith$elm_codegen$Internal$Clean$doRename(dict),
						nodeOne),
					A2(
						$stil4m$elm_syntax$Elm$Syntax$Node$map,
						$mdgriffith$elm_codegen$Internal$Clean$doRename(dict),
						nodeTwo));
		}
	});
var $mdgriffith$elm_codegen$Internal$Clean$prepareRename = F2(
	function (ann, dict) {
		switch (ann.$) {
			case 'GenericType':
				var generic = ann.a;
				return A2($elm$core$Set$insert, generic, dict);
			case 'Typed':
				var name = ann.a;
				var nodedVars = ann.b;
				return A3(
					$elm$core$List$foldl,
					F2(
						function (_v1, d) {
							var tipe = _v1.b;
							return A2($mdgriffith$elm_codegen$Internal$Clean$prepareRename, tipe, d);
						}),
					dict,
					nodedVars);
			case 'Unit':
				return dict;
			case 'Tupled':
				var nodedVars = ann.a;
				return A3(
					$elm$core$List$foldl,
					F2(
						function (_v2, d) {
							var tipe = _v2.b;
							return A2($mdgriffith$elm_codegen$Internal$Clean$prepareRename, tipe, d);
						}),
					dict,
					nodedVars);
			case 'Record':
				var record = ann.a;
				return A3(
					$elm$core$List$foldl,
					F2(
						function (_v3, d) {
							var _v4 = _v3.b;
							var _v5 = _v4.b;
							var field = _v5.b;
							return A2($mdgriffith$elm_codegen$Internal$Clean$prepareRename, field, d);
						}),
					dict,
					record);
			case 'GenericRecord':
				var name = ann.a;
				var _v6 = ann.b;
				var range = _v6.a;
				var record = _v6.b;
				return A3(
					$elm$core$List$foldl,
					F2(
						function (_v7, d) {
							var _v8 = _v7.b;
							var _v9 = _v8.b;
							var field = _v9.b;
							return A2($mdgriffith$elm_codegen$Internal$Clean$prepareRename, field, d);
						}),
					dict,
					record);
			default:
				var _v10 = ann.a;
				var one = _v10.b;
				var _v11 = ann.b;
				var two = _v11.b;
				return A2(
					$mdgriffith$elm_codegen$Internal$Clean$prepareRename,
					two,
					A2($mdgriffith$elm_codegen$Internal$Clean$prepareRename, one, dict));
		}
	});
var $mdgriffith$elm_codegen$Internal$Clean$findClean = F3(
	function (i, name, set) {
		findClean:
		while (true) {
			var newName = (!i) ? name : _Utils_ap(
				name,
				$elm$core$String$fromInt(i));
			if (A2($elm$core$Set$member, newName, set)) {
				var $temp$i = i + 1,
					$temp$name = name,
					$temp$set = set;
				i = $temp$i;
				name = $temp$name;
				set = $temp$set;
				continue findClean;
			} else {
				return name;
			}
		}
	});
var $elm$core$Set$foldl = F3(
	function (func, initialState, _v0) {
		var dict = _v0.a;
		return A3(
			$elm$core$Dict$foldl,
			F3(
				function (key, _v1, state) {
					return A2(func, key, state);
				}),
			initialState,
			dict);
	});
var $mdgriffith$elm_codegen$Internal$Clean$sanitized = function (str) {
	var _v0 = A2($elm$core$String$split, '_', str);
	if (!_v0.b) {
		return str;
	} else {
		var top = _v0.a;
		var remain = _v0.b;
		return top;
	}
};
var $mdgriffith$elm_codegen$Internal$Clean$verify = function (set) {
	return A3(
		$elm$core$Set$foldl,
		F2(
			function (name, gathered) {
				var newName = A3(
					$mdgriffith$elm_codegen$Internal$Clean$findClean,
					0,
					$mdgriffith$elm_codegen$Internal$Clean$sanitized(name),
					set);
				return A3($elm$core$Dict$insert, name, newName, gathered);
			}),
		$elm$core$Dict$empty,
		set);
};
var $mdgriffith$elm_codegen$Internal$Clean$clean = function (ann) {
	var renames = $mdgriffith$elm_codegen$Internal$Clean$verify(
		A2($mdgriffith$elm_codegen$Internal$Clean$prepareRename, ann, $elm$core$Set$empty));
	return A2($mdgriffith$elm_codegen$Internal$Clean$doRename, renames, ann);
};
var $mdgriffith$elm_codegen$Internal$Format$formatDeclarationName = function (str) {
	if (str === 'main') {
		return 'main';
	} else {
		return $mdgriffith$elm_codegen$Internal$Format$formatValue(str);
	}
};
var $elm$core$Result$mapError = F2(
	function (f, result) {
		if (result.$ === 'Ok') {
			var v = result.a;
			return $elm$core$Result$Ok(v);
		} else {
			var e = result.a;
			return $elm$core$Result$Err(
				f(e));
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$inferenceErrorToString = function (inf) {
	switch (inf.$) {
		case 'Todo':
			var str = inf.a;
			return 'Todo ' + str;
		case 'MismatchedList':
			var one = inf.a;
			var two = inf.b;
			return 'There are multiple different types in a list: \n\n' + ('    ' + ($stil4m$elm_syntax$Elm$Writer$write(
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(one))) + ('\n\n    ' + $stil4m$elm_syntax$Elm$Writer$write(
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(two))))));
		case 'RecordUpdateIncorrectFields':
			var details = inf.a;
			return 'Mismatched record update';
		case 'EmptyCaseStatement':
			return 'Case statement is empty';
		case 'FunctionAppliedToTooManyArgs':
			var fn = inf.a;
			var args = inf.b;
			return 'The following is being called as a function\n\n    ' + ($stil4m$elm_syntax$Elm$Writer$write(
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(fn))) + ('\n\nwith these arguments:\n\n    ' + (A2(
				$elm$core$String$join,
				' -> ',
				A2(
					$elm$core$List$map,
					function (arg) {
						return $stil4m$elm_syntax$Elm$Writer$write(
							$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(arg)));
					},
					args)) + '\n\nbut that\'s wrong, right?')));
		case 'DuplicateFieldInRecord':
			var fieldName = inf.a;
			return 'There is a duplicate field in a record: ' + fieldName;
		case 'CaseBranchesReturnDifferentTypes':
			return 'Case returns different types.';
		case 'CouldNotFindField':
			var found = inf.a;
			return 'I can\'t find .' + (found.field + (', this record only has these fields:\n\n    ' + A2($elm$core$String$join, '\n    ', found.existingFields)));
		case 'AttemptingToGetOnIncorrectType':
			var attempting = inf.a;
			return 'You\'re trying to access\n\n    .' + (attempting.field + ('\n\nbut this value isn\'t a record. It\'s a\n\n    ' + $stil4m$elm_syntax$Elm$Writer$write(
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(attempting.on)))));
		case 'AttemptingGetOnTypeNameNotAnAlias':
			var attempting = inf.a;
			return 'You\'re trying to access\n\n    .' + (attempting.field + ('\n\nbut this value isn\'t a record, it\'s a\n\n    ' + ($stil4m$elm_syntax$Elm$Writer$write(
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(attempting.on))) + '\n\nIs this value supposed to be an alias for a record? If so, check out Elm.alias!')));
		case 'LetFieldNotFound':
			var details = inf.a;
			return details.desiredField + ' not found, though I was trying to unpack it in a let expression.';
		case 'NotAppendable':
			var type_ = inf.a;
			return $stil4m$elm_syntax$Elm$Writer$write(
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(type_))) + ' is not appendable.  Only Strings and Lists are appendable';
		case 'NotComparable':
			var type_ = inf.a;
			return $stil4m$elm_syntax$Elm$Writer$write(
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(type_))) + ' is not appendable.  Only Strings and Lists are appendable';
		case 'UnableToUnify':
			var one = inf.a;
			var two = inf.b;
			return 'I found\n\n    ' + ($stil4m$elm_syntax$Elm$Writer$write(
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(one))) + ('\n\nBut I was expecting:\n\n    ' + $stil4m$elm_syntax$Elm$Writer$write(
				$stil4m$elm_syntax$Elm$Writer$writeTypeAnnotation(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(two)))));
		default:
			return 'Different lists of type variables';
	}
};
var $mdgriffith$elm_codegen$Elm$renderError = function (err) {
	if (!err.b) {
		return '';
	} else {
		return A2(
			$elm$core$String$join,
			'\n\n',
			A2($elm$core$List$map, $mdgriffith$elm_codegen$Internal$Compiler$inferenceErrorToString, err));
	}
};
var $elm$core$Set$fromList = function (list) {
	return A3($elm$core$List$foldl, $elm$core$Set$insert, $elm$core$Set$empty, list);
};
var $elm$core$Basics$neq = _Utils_notEqual;
var $mdgriffith$elm_codegen$Internal$Compiler$simplify = function (fullStr) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (piece, str) {
				var isDigit = A2($elm$core$String$all, $elm$core$Char$isDigit, piece);
				if (isDigit) {
					return str;
				} else {
					if (str === '') {
						return piece;
					} else {
						return str + ('_' + piece);
					}
				}
			}),
		'',
		A2($elm$core$String$split, '_', fullStr));
};
var $mdgriffith$elm_codegen$Internal$Compiler$rewriteTypeVariablesHelper = F3(
	function (existing, renames, type_) {
		switch (type_.$) {
			case 'GenericType':
				var varName = type_.a;
				var _v1 = A2($elm$core$Dict$get, varName, renames);
				if (_v1.$ === 'Nothing') {
					var simplified = $mdgriffith$elm_codegen$Internal$Compiler$simplify(varName);
					return (A2($elm$core$Set$member, simplified, existing) && (!_Utils_eq(varName, simplified))) ? _Utils_Tuple2(
						renames,
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(simplified)) : _Utils_Tuple2(
						A3($elm$core$Dict$insert, varName, simplified, renames),
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(simplified));
				} else {
					var rename = _v1.a;
					return _Utils_Tuple2(
						renames,
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(rename));
				}
			case 'Typed':
				var name = type_.a;
				var vars = type_.b;
				var _v2 = A3(
					$elm$core$List$foldl,
					F2(
						function (typevar, _v3) {
							var varUsed = _v3.a;
							var varList = _v3.b;
							var _v4 = A3(
								$mdgriffith$elm_codegen$Internal$Compiler$rewriteTypeVariablesHelper,
								existing,
								varUsed,
								$mdgriffith$elm_codegen$Internal$Compiler$denode(typevar));
							var oneUsed = _v4.a;
							var oneType = _v4.b;
							return _Utils_Tuple2(
								oneUsed,
								A2(
									$elm$core$List$cons,
									$mdgriffith$elm_codegen$Internal$Compiler$nodify(oneType),
									varList));
						}),
					_Utils_Tuple2(renames, _List_Nil),
					vars);
				var newUsed = _v2.a;
				var newVars = _v2.b;
				return _Utils_Tuple2(
					newUsed,
					A2(
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
						name,
						$elm$core$List$reverse(newVars)));
			case 'Unit':
				return _Utils_Tuple2(renames, type_);
			case 'Tupled':
				var valsA = type_.a;
				return _Utils_Tuple2(renames, type_);
			case 'Record':
				var fieldsA = type_.a;
				return _Utils_Tuple2(renames, type_);
			case 'GenericRecord':
				var _v5 = type_.a;
				var reVarName = _v5.b;
				var _v6 = type_.b;
				var fieldsARange = _v6.a;
				var fieldsA = _v6.b;
				return _Utils_Tuple2(renames, type_);
			default:
				var one = type_.a;
				var two = type_.b;
				var _v7 = A3(
					$mdgriffith$elm_codegen$Internal$Compiler$rewriteTypeVariablesHelper,
					existing,
					renames,
					$mdgriffith$elm_codegen$Internal$Compiler$denode(one));
				var oneUsed = _v7.a;
				var oneType = _v7.b;
				var _v8 = A3(
					$mdgriffith$elm_codegen$Internal$Compiler$rewriteTypeVariablesHelper,
					existing,
					oneUsed,
					$mdgriffith$elm_codegen$Internal$Compiler$denode(two));
				var twoUsed = _v8.a;
				var twoType = _v8.b;
				return _Utils_Tuple2(
					twoUsed,
					A2(
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
						$mdgriffith$elm_codegen$Internal$Compiler$nodify(oneType),
						$mdgriffith$elm_codegen$Internal$Compiler$nodify(twoType)));
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$rewriteTypeVariables = function (type_) {
	var existing = $elm$core$Set$fromList(
		$mdgriffith$elm_codegen$Internal$Compiler$getGenericsHelper(type_));
	return A3($mdgriffith$elm_codegen$Internal$Compiler$rewriteTypeVariablesHelper, existing, $elm$core$Dict$empty, type_).b;
};
var $mdgriffith$elm_codegen$Internal$Compiler$resolve = F3(
	function (index, cache, annotation) {
		if ($mdgriffith$elm_codegen$Internal$Index$typecheck(index)) {
			var restrictions = A2($mdgriffith$elm_codegen$Internal$Compiler$getRestrictions, annotation, cache);
			var _v0 = A3($mdgriffith$elm_codegen$Internal$Compiler$resolveVariables, $elm$core$Set$empty, cache, annotation);
			if (_v0.$ === 'Ok') {
				var newAnnotation = _v0.a;
				return A2(
					$mdgriffith$elm_codegen$Internal$Compiler$checkRestrictions,
					restrictions,
					$mdgriffith$elm_codegen$Internal$Compiler$rewriteTypeVariables(newAnnotation));
			} else {
				var err = _v0.a;
				return $elm$core$Result$Err(err);
			}
		} else {
			return $elm$core$Result$Err('Type inference skipped.');
		}
	});
var $mdgriffith$elm_codegen$Elm$declaration = F2(
	function (nameStr, _v0) {
		var toBody = _v0.a;
		var name = $mdgriffith$elm_codegen$Internal$Format$formatDeclarationName(nameStr);
		return $mdgriffith$elm_codegen$Internal$Compiler$Declaration(
			{
				docs: $elm$core$Maybe$Nothing,
				exposed: $mdgriffith$elm_codegen$Internal$Compiler$NotExposed,
				imports: _List_Nil,
				name: name,
				toBody: function (index) {
					var body = toBody(index);
					var resolvedType = A2(
						$elm$core$Result$andThen,
						function (sig) {
							return A3($mdgriffith$elm_codegen$Internal$Compiler$resolve, index, sig.inferences, sig.type_);
						},
						A2($elm$core$Result$mapError, $mdgriffith$elm_codegen$Elm$renderError, body.annotation));
					var maybeWarning = function () {
						if (resolvedType.$ === 'Ok') {
							var sig = resolvedType.a;
							var _v5 = body.annotation;
							if (_v5.$ === 'Ok') {
								var inference = _v5.a;
								return $elm$core$Maybe$Nothing;
							} else {
								if (!_v5.a.b) {
									return $elm$core$Maybe$Nothing;
								} else {
									var err = _v5.a;
									return $elm$core$Maybe$Just(
										{
											declaration: name,
											warning: $mdgriffith$elm_codegen$Elm$renderError(err)
										});
								}
							}
						} else {
							if (resolvedType.a === '') {
								return $elm$core$Maybe$Nothing;
							} else {
								var err = resolvedType.a;
								return $elm$core$Maybe$Just(
									{declaration: name, warning: err});
							}
						}
					}();
					return {
						additionalImports: body.imports,
						declaration: $stil4m$elm_syntax$Elm$Syntax$Declaration$FunctionDeclaration(
							{
								declaration: function () {
									var _v1 = body.expression;
									if (_v1.$ === 'LambdaExpression') {
										var lam = _v1.a;
										return $mdgriffith$elm_codegen$Internal$Compiler$nodify(
											{
												_arguments: lam.args,
												expression: lam.expression,
												name: $mdgriffith$elm_codegen$Internal$Compiler$nodify(name)
											});
									} else {
										return $mdgriffith$elm_codegen$Internal$Compiler$nodify(
											{
												_arguments: _List_Nil,
												expression: $mdgriffith$elm_codegen$Internal$Compiler$nodify(body.expression),
												name: $mdgriffith$elm_codegen$Internal$Compiler$nodify(name)
											});
									}
								}(),
								documentation: $elm$core$Maybe$Nothing,
								signature: function () {
									var _v2 = body.annotation;
									if (_v2.$ === 'Ok') {
										var sig = _v2.a;
										if (resolvedType.$ === 'Ok') {
											if (resolvedType.a.$ === 'GenericType') {
												var generic = resolvedType.a.a;
												return $elm$core$Maybe$Nothing;
											} else {
												var finalType = resolvedType.a;
												return $elm$core$Maybe$Just(
													$mdgriffith$elm_codegen$Internal$Compiler$nodify(
														{
															name: $mdgriffith$elm_codegen$Internal$Compiler$nodify(name),
															typeAnnotation: $mdgriffith$elm_codegen$Internal$Compiler$nodify(
																$mdgriffith$elm_codegen$Internal$Clean$clean(finalType))
														}));
											}
										} else {
											var errMsg = resolvedType.a;
											return $elm$core$Maybe$Nothing;
										}
									} else {
										return $elm$core$Maybe$Nothing;
									}
								}()
							}),
						warning: maybeWarning
					};
				}
			});
	});
var $mdgriffith$elm_codegen$Internal$Compiler$toVarMaybeType = F3(
	function (index, desiredName, maybeAnnotation) {
		var _v0 = A2($mdgriffith$elm_codegen$Internal$Index$getName, desiredName, index);
		var name = _v0.a;
		var newIndex = _v0.b;
		var _v1 = function () {
			if (maybeAnnotation.$ === 'Nothing') {
				return {
					aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
					annotation: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(
						A2($mdgriffith$elm_codegen$Internal$Index$protectTypeName, desiredName, index)),
					imports: _List_Nil
				};
			} else {
				var ann = maybeAnnotation.a.a;
				return ann;
			}
		}();
		var aliases = _v1.aliases;
		var annotation = _v1.annotation;
		var imports = _v1.imports;
		return {
			index: newIndex,
			name: name,
			type_: annotation,
			val: $mdgriffith$elm_codegen$Internal$Compiler$Expression(
				function (ignoredIndex_) {
					return {
						annotation: $elm$core$Result$Ok(
							{aliases: aliases, inferences: $elm$core$Dict$empty, type_: annotation}),
						expression: A2($stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue, _List_Nil, name),
						imports: imports
					};
				})
		};
	});
var $mdgriffith$elm_codegen$Elm$fn = F2(
	function (_v0, toExpression) {
		var oneBaseName = _v0.a;
		var maybeAnnotation = _v0.b;
		return $mdgriffith$elm_codegen$Internal$Compiler$expression(
			function (index) {
				var one = A3($mdgriffith$elm_codegen$Internal$Compiler$toVarMaybeType, index, oneBaseName, maybeAnnotation);
				var _v1 = toExpression(one.val);
				var toExpr = _v1.a;
				var _return = toExpr(one.index);
				return {
					annotation: function () {
						var _v2 = _return.annotation;
						if (_v2.$ === 'Err') {
							var err = _v2.a;
							return _return.annotation;
						} else {
							var returnAnnotation = _v2.a;
							return $elm$core$Result$Ok(
								{
									aliases: returnAnnotation.aliases,
									inferences: returnAnnotation.inferences,
									type_: A2(
										$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
										$mdgriffith$elm_codegen$Internal$Compiler$nodify(one.type_),
										$mdgriffith$elm_codegen$Internal$Compiler$nodify(returnAnnotation.type_))
								});
						}
					}(),
					expression: $stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression(
						{
							args: _List_fromArray(
								[
									$mdgriffith$elm_codegen$Internal$Compiler$nodify(
									$stil4m$elm_syntax$Elm$Syntax$Pattern$VarPattern(one.name))
								]),
							expression: $mdgriffith$elm_codegen$Internal$Compiler$nodify(_return.expression)
						}),
					imports: _return.imports
				};
			});
	});
var $mdgriffith$elm_codegen$Elm$Declare$fn = F3(
	function (name, one, toExp) {
		var funcExp = A2($mdgriffith$elm_codegen$Elm$fn, one, toExp);
		var call = F2(
			function (importFrom, argOne) {
				return A2(
					$mdgriffith$elm_codegen$Elm$apply,
					$mdgriffith$elm_codegen$Internal$Compiler$Expression(
						function (index) {
							var toFnExp = funcExp.a;
							var fnExp = toFnExp(index);
							return {
								annotation: fnExp.annotation,
								expression: A2(
									$stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue,
									importFrom,
									$mdgriffith$elm_codegen$Internal$Format$sanitize(name)),
								imports: fnExp.imports
							};
						}),
					_List_fromArray(
						[argOne]));
			});
		return {
			call: call(_List_Nil),
			callFrom: call,
			declaration: A2($mdgriffith$elm_codegen$Elm$declaration, name, funcExp)
		};
	});
var $mdgriffith$elm_codegen$Elm$function = F2(
	function (initialArgList, toFullExpression) {
		if (!initialArgList.b) {
			return toFullExpression(_List_Nil);
		} else {
			return $mdgriffith$elm_codegen$Internal$Compiler$expression(
				function (index) {
					var args = A3(
						$elm$core$List$foldl,
						F2(
							function (_v5, found) {
								var nameBase = _v5.a;
								var maybeType = _v5.b;
								var argType = A2(
									$elm$core$Maybe$withDefault,
									$mdgriffith$elm_codegen$Internal$Compiler$Annotation(
										{
											aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
											annotation: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(
												A2($mdgriffith$elm_codegen$Internal$Index$protectTypeName, nameBase, found.index)),
											imports: _List_Nil
										}),
									maybeType);
								var _v6 = A2($mdgriffith$elm_codegen$Internal$Index$getName, nameBase, found.index);
								var name = _v6.a;
								var newIndex = _v6.b;
								var arg = $mdgriffith$elm_codegen$Elm$value(
									{
										annotation: $elm$core$Maybe$Just(argType),
										importFrom: _List_Nil,
										name: name
									});
								return {
									args: A2($elm$core$List$cons, arg, found.args),
									index: newIndex,
									names: A2($elm$core$List$cons, name, found.names),
									types: A2(
										$elm$core$List$cons,
										$mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation(argType),
										found.types)
								};
							}),
						{args: _List_Nil, index: index, names: _List_Nil, types: _List_Nil},
						initialArgList);
					var fullExpression = toFullExpression(
						$elm$core$List$reverse(args.args));
					var expr = function () {
						var toExpr = fullExpression.a;
						return toExpr(index);
					}();
					return {
						annotation: function () {
							var _v1 = expr.annotation;
							if (_v1.$ === 'Err') {
								var err = _v1.a;
								return $elm$core$Result$Err(err);
							} else {
								var _return = _v1.a;
								return $elm$core$Result$Ok(
									{
										aliases: A3(
											$elm$core$List$foldl,
											F2(
												function (_v2, aliases) {
													var maybeAnn = _v2.b;
													if (maybeAnn.$ === 'Nothing') {
														return aliases;
													} else {
														var ann = maybeAnn.a;
														return A2(
															$mdgriffith$elm_codegen$Internal$Compiler$mergeAliases,
															$mdgriffith$elm_codegen$Internal$Compiler$getAliases(ann),
															aliases);
													}
												}),
											_return.aliases,
											initialArgList),
										inferences: _return.inferences,
										type_: A3(
											$elm$core$List$foldl,
											F2(
												function (ann, fnbody) {
													return A2(
														$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
														$mdgriffith$elm_codegen$Internal$Compiler$nodify(ann),
														$mdgriffith$elm_codegen$Internal$Compiler$nodify(fnbody));
												}),
											_return.type_,
											args.types)
									});
							}
						}(),
						expression: $stil4m$elm_syntax$Elm$Syntax$Expression$LambdaExpression(
							{
								args: A3(
									$elm$core$List$foldl,
									F2(
										function (n, names) {
											return A2(
												$elm$core$List$cons,
												$mdgriffith$elm_codegen$Internal$Compiler$nodify(
													$stil4m$elm_syntax$Elm$Syntax$Pattern$VarPattern(n)),
												names);
										}),
									_List_Nil,
									args.names),
								expression: $mdgriffith$elm_codegen$Internal$Compiler$nodify(expr.expression)
							}),
						imports: expr.imports
					};
				});
		}
	});
var $mdgriffith$elm_codegen$Elm$Declare$function = F3(
	function (name, params, toExp) {
		var funcExp = A2($mdgriffith$elm_codegen$Elm$function, params, toExp);
		var call = F2(
			function (importFrom, args) {
				return A2(
					$mdgriffith$elm_codegen$Elm$apply,
					$mdgriffith$elm_codegen$Internal$Compiler$Expression(
						function (index) {
							var toFnExp = funcExp.a;
							var fnExp = toFnExp(index);
							return {
								annotation: fnExp.annotation,
								expression: A2(
									$stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue,
									importFrom,
									$mdgriffith$elm_codegen$Internal$Format$sanitize(name)),
								imports: fnExp.imports
							};
						}),
					args);
			});
		return {
			call: call(_List_Nil),
			callFrom: call,
			declaration: A2($mdgriffith$elm_codegen$Elm$declaration, name, funcExp)
		};
	});
var $mdgriffith$elm_codegen$Internal$Compiler$DuplicateFieldInRecord = function (a) {
	return {$: 'DuplicateFieldInRecord', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$RecordExpr = function (a) {
	return {$: 'RecordExpr', a: a};
};
var $mdgriffith$elm_codegen$Elm$record = function (fields) {
	return $mdgriffith$elm_codegen$Internal$Compiler$expression(
		function (index) {
			var unified = A3(
				$elm$core$List$foldl,
				F2(
					function (_v4, found) {
						var unformattedFieldName = _v4.a;
						var fieldExpression = _v4.b;
						var fieldName = $mdgriffith$elm_codegen$Internal$Format$formatValue(unformattedFieldName);
						var _v5 = A2($mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails, found.index, fieldExpression);
						var newIndex = _v5.a;
						var exp = _v5.b;
						return {
							errors: function () {
								if (A2($elm$core$Set$member, fieldName, found.passed)) {
									return A2(
										$elm$core$List$cons,
										$mdgriffith$elm_codegen$Internal$Compiler$DuplicateFieldInRecord(fieldName),
										found.errors);
								} else {
									var _v6 = exp.annotation;
									if (_v6.$ === 'Err') {
										if (!_v6.a.b) {
											return found.errors;
										} else {
											var errs = _v6.a;
											return _Utils_ap(errs, found.errors);
										}
									} else {
										var ann = _v6.a;
										return found.errors;
									}
								}
							}(),
							fieldAnnotations: function () {
								var _v7 = exp.annotation;
								if (_v7.$ === 'Err') {
									var err = _v7.a;
									return found.fieldAnnotations;
								} else {
									var ann = _v7.a;
									return A2(
										$elm$core$List$cons,
										_Utils_Tuple2(
											$mdgriffith$elm_codegen$Internal$Format$formatValue(fieldName),
											ann),
										found.fieldAnnotations);
								}
							}(),
							fields: A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									$mdgriffith$elm_codegen$Internal$Compiler$nodify(fieldName),
									$mdgriffith$elm_codegen$Internal$Compiler$nodify(exp.expression)),
								found.fields),
							imports: _Utils_ap(exp.imports, found.imports),
							index: newIndex,
							passed: A2($elm$core$Set$insert, fieldName, found.passed)
						};
					}),
				{errors: _List_Nil, fieldAnnotations: _List_Nil, fields: _List_Nil, imports: _List_Nil, index: index, passed: $elm$core$Set$empty},
				fields);
			return {
				annotation: function () {
					var _v0 = unified.errors;
					if (!_v0.b) {
						return $elm$core$Result$Ok(
							{
								aliases: A3(
									$elm$core$List$foldl,
									F2(
										function (_v1, gathered) {
											var name = _v1.a;
											var ann = _v1.b;
											return A2($mdgriffith$elm_codegen$Internal$Compiler$mergeAliases, ann.aliases, gathered);
										}),
									$mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
									unified.fieldAnnotations),
								inferences: A3(
									$elm$core$List$foldl,
									F2(
										function (_v2, gathered) {
											var name = _v2.a;
											var ann = _v2.b;
											return A2($mdgriffith$elm_codegen$Internal$Compiler$mergeInferences, ann.inferences, gathered);
										}),
									$elm$core$Dict$empty,
									unified.fieldAnnotations),
								type_: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Record(
									$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
										A2(
											$elm$core$List$map,
											function (_v3) {
												var name = _v3.a;
												var ann = _v3.b;
												return _Utils_Tuple2(
													$mdgriffith$elm_codegen$Internal$Compiler$nodify(name),
													$mdgriffith$elm_codegen$Internal$Compiler$nodify(ann.type_));
											},
											$elm$core$List$reverse(unified.fieldAnnotations))))
							});
					} else {
						var errs = _v0;
						return $elm$core$Result$Err(errs);
					}
				}(),
				expression: $stil4m$elm_syntax$Elm$Syntax$Expression$RecordExpr(
					$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
						$elm$core$List$reverse(unified.fields))),
				imports: unified.imports
			};
		});
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$Literal = function (a) {
	return {$: 'Literal', a: a};
};
var $mdgriffith$elm_codegen$Internal$Types$nodify = function (exp) {
	return A2($stil4m$elm_syntax$Elm$Syntax$Node$Node, $stil4m$elm_syntax$Elm$Syntax$Range$emptyRange, exp);
};
var $mdgriffith$elm_codegen$Internal$Types$string = A2(
	$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
	$mdgriffith$elm_codegen$Internal$Types$nodify(
		_Utils_Tuple2(_List_Nil, 'String')),
	_List_Nil);
var $mdgriffith$elm_codegen$Elm$string = function (literal) {
	return $mdgriffith$elm_codegen$Internal$Compiler$Expression(
		function (_v0) {
			return {
				annotation: $elm$core$Result$Ok(
					{aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases, inferences: $elm$core$Dict$empty, type_: $mdgriffith$elm_codegen$Internal$Types$string}),
				expression: $stil4m$elm_syntax$Elm$Syntax$Expression$Literal(literal),
				imports: _List_Nil
			};
		});
};
var $author$project$Gen$Http$get = function (getArg) {
	return A2(
		$mdgriffith$elm_codegen$Elm$apply,
		$mdgriffith$elm_codegen$Elm$value(
			{
				annotation: $elm$core$Maybe$Just(
					A2(
						$mdgriffith$elm_codegen$Elm$Annotation$function,
						_List_fromArray(
							[
								$mdgriffith$elm_codegen$Elm$Annotation$record(
								_List_fromArray(
									[
										_Utils_Tuple2('url', $mdgriffith$elm_codegen$Elm$Annotation$string),
										_Utils_Tuple2(
										'expect',
										A3(
											$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
											_List_fromArray(
												['Http']),
											'Expect',
											_List_fromArray(
												[
													$mdgriffith$elm_codegen$Elm$Annotation$var('msg')
												])))
									]))
							]),
						A3(
							$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
							_List_Nil,
							'Cmd',
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Elm$Annotation$var('msg')
								])))),
				importFrom: _List_fromArray(
					['Http']),
				name: 'get'
			}),
		_List_fromArray(
			[
				$mdgriffith$elm_codegen$Elm$record(
				_List_fromArray(
					[
						A2(
						$elm$core$Tuple$pair,
						'url',
						$mdgriffith$elm_codegen$Elm$string(getArg.url)),
						A2($elm$core$Tuple$pair, 'expect', getArg.expect)
					]))
			]));
};
var $author$project$OpenApi$Path$get = function (_v0) {
	var path_ = _v0.a;
	return path_.get;
};
var $author$project$OpenApi$Schema$get = function (_v0) {
	var schema_ = _v0.a;
	return schema_;
};
var $author$project$OpenApi$info = function (_v0) {
	var openApi = _v0.a;
	return openApi.info;
};
var $author$project$Main$invalidModuleNameChars = _List_fromArray(
	[
		_Utils_chr(' '),
		_Utils_chr('.'),
		_Utils_chr('/'),
		_Utils_chr('{'),
		_Utils_chr('}'),
		_Utils_chr('-')
	]);
var $elm$core$String$map = _String_map;
var $author$project$Main$makeNamespaceValid = function (str) {
	return A2(
		$elm$core$String$map,
		function (_char) {
			return A2($elm$core$List$member, _char, $author$project$Main$invalidModuleNameChars) ? _Utils_chr('_') : _char;
		},
		str);
};
var $mdgriffith$elm_codegen$Elm$Annotation$named = F2(
	function (mod, name) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Annotation(
			{
				aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
				annotation: A2(
					$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(
						_Utils_Tuple2(
							mod,
							$mdgriffith$elm_codegen$Internal$Format$formatType(name))),
					_List_Nil),
				imports: function () {
					if (!mod.b) {
						return _List_Nil;
					} else {
						return _List_fromArray(
							[mod]);
					}
				}()
			});
	});
var $mdgriffith$elm_codegen$Elm$customType = F2(
	function (name, variants) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Declaration(
			{
				docs: $elm$core$Maybe$Nothing,
				exposed: $mdgriffith$elm_codegen$Internal$Compiler$NotExposed,
				imports: A2(
					$elm$core$List$concatMap,
					function (_v0) {
						var listAnn = _v0.b;
						return A2($elm$core$List$concatMap, $mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports, listAnn);
					},
					variants),
				name: name,
				toBody: function (index) {
					return {
						additionalImports: _List_Nil,
						declaration: $stil4m$elm_syntax$Elm$Syntax$Declaration$CustomTypeDeclaration(
							{
								constructors: A2(
									$elm$core$List$map,
									function (_v1) {
										var varName = _v1.a;
										var vars = _v1.b;
										return $mdgriffith$elm_codegen$Internal$Compiler$nodify(
											{
												_arguments: A2(
													$elm$core$List$map,
													A2($elm$core$Basics$composeR, $mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation, $mdgriffith$elm_codegen$Internal$Compiler$nodify),
													vars),
												name: $mdgriffith$elm_codegen$Internal$Compiler$nodify(
													$mdgriffith$elm_codegen$Internal$Format$formatType(varName))
											});
									},
									variants),
								documentation: $elm$core$Maybe$Nothing,
								generics: A2(
									$elm$core$List$concatMap,
									function (_v2) {
										var listAnn = _v2.b;
										return A2(
											$elm$core$List$concatMap,
											A2(
												$elm$core$Basics$composeL,
												$elm$core$List$map($mdgriffith$elm_codegen$Internal$Compiler$nodify),
												$mdgriffith$elm_codegen$Internal$Compiler$getGenerics),
											listAnn);
									},
									variants),
								name: $mdgriffith$elm_codegen$Internal$Compiler$nodify(
									$mdgriffith$elm_codegen$Internal$Format$formatType(name))
							}),
						warning: $elm$core$Maybe$Nothing
					};
				}
			});
	});
var $mdgriffith$elm_codegen$Elm$Variant = F2(
	function (a, b) {
		return {$: 'Variant', a: a, b: b};
	});
var $mdgriffith$elm_codegen$Elm$variant = function (name) {
	return A2($mdgriffith$elm_codegen$Elm$Variant, name, _List_Nil);
};
var $mdgriffith$elm_codegen$Elm$variantWith = $mdgriffith$elm_codegen$Elm$Variant;
var $author$project$Main$nullableType = A2(
	$mdgriffith$elm_codegen$Elm$customType,
	'Nullable',
	_List_fromArray(
		[
			$mdgriffith$elm_codegen$Elm$variant('Null'),
			A2(
			$mdgriffith$elm_codegen$Elm$variantWith,
			'Present',
			_List_fromArray(
				[
					$mdgriffith$elm_codegen$Elm$Annotation$var('value')
				]))
		]));
var $author$project$OpenApi$Operation$operationId = function (_v0) {
	var operation_ = _v0.a;
	return operation_.operationId;
};
var $author$project$OpenApi$paths = function (_v0) {
	var openApi = _v0.a;
	return openApi.paths;
};
var $elm$core$String$filter = _String_filter;
var $author$project$Main$removeInvlidChars = function (str) {
	return A2(
		$elm$core$String$filter,
		function (_char) {
			return !_Utils_eq(
				_char,
				_Utils_chr('\''));
		},
		str);
};
var $mdgriffith$elm_codegen$Elm$Annotation$bool = A3($mdgriffith$elm_codegen$Elm$Annotation$typed, _List_Nil, 'Bool', _List_Nil);
var $elm$core$Char$toLower = _Char_toLower;
var $elm_community$string_extra$String$Extra$changeCase = F2(
	function (mutator, word) {
		return A2(
			$elm$core$Maybe$withDefault,
			'',
			A2(
				$elm$core$Maybe$map,
				function (_v0) {
					var head = _v0.a;
					var tail = _v0.b;
					return A2(
						$elm$core$String$cons,
						mutator(head),
						tail);
				},
				$elm$core$String$uncons(word)));
	});
var $elm$core$Char$toUpper = _Char_toUpper;
var $elm_community$string_extra$String$Extra$toSentenceCase = function (word) {
	return A2($elm_community$string_extra$String$Extra$changeCase, $elm$core$Char$toUpper, word);
};
var $elm_community$string_extra$String$Extra$toTitleCase = function (ws) {
	var uppercaseMatch = A2(
		$elm$regex$Regex$replace,
		$elm_community$string_extra$String$Extra$regexFromString('\\w+'),
		A2(
			$elm$core$Basics$composeR,
			function ($) {
				return $.match;
			},
			$elm_community$string_extra$String$Extra$toSentenceCase));
	return A3(
		$elm$regex$Regex$replace,
		$elm_community$string_extra$String$Extra$regexFromString('^([a-z])|\\s+([a-z])'),
		A2(
			$elm$core$Basics$composeR,
			function ($) {
				return $.match;
			},
			uppercaseMatch),
		ws);
};
var $author$project$Main$typifyName = function (name) {
	return A3(
		$elm$core$String$replace,
		' ',
		'',
		$elm_community$string_extra$String$Extra$toTitleCase(
			A3(
				$elm$core$String$replace,
				'_',
				' ',
				A3($elm$core$String$replace, '-', ' ', name))));
};
var $author$project$Main$elmifyName = function (name) {
	return A2(
		$elm$core$Maybe$withDefault,
		'',
		A2(
			$elm$core$Maybe$map,
			function (_v0) {
				var first = _v0.a;
				var rest = _v0.b;
				return A2(
					$elm$core$String$cons,
					$elm$core$Char$toLower(first),
					rest);
			},
			$elm$core$String$uncons(
				$author$project$Main$typifyName(name))));
};
var $mdgriffith$elm_codegen$Elm$Annotation$float = A3($mdgriffith$elm_codegen$Elm$Annotation$typed, _List_Nil, 'Float', _List_Nil);
var $mdgriffith$elm_codegen$Elm$Annotation$list = function (inner) {
	return A3(
		$mdgriffith$elm_codegen$Elm$Annotation$typed,
		_List_Nil,
		'List',
		_List_fromArray(
			[inner]));
};
var $elm$core$Debug$todo = _Debug_todo;
var $author$project$Main$schemaToAnnotation = function (schema) {
	if (schema.$ === 'BooleanSchema') {
		var bool = schema.a;
		return _Debug_todo(
			'Main',
			{
				start: {line: 507, column: 13},
				end: {line: 507, column: 23}
			})('');
	} else {
		var subSchema = schema.a;
		var singleTypeToAnnotation = function (singleType) {
			switch (singleType.$) {
				case 'ObjectType':
					return $mdgriffith$elm_codegen$Elm$Annotation$record(
						A2(
							$elm$core$List$map,
							function (_v16) {
								var key = _v16.a;
								var valueSchema = _v16.b;
								return _Utils_Tuple2(
									$author$project$Main$elmifyName(key),
									$author$project$Main$schemaToAnnotation(valueSchema));
							},
							A2(
								$elm$core$Maybe$withDefault,
								_List_Nil,
								A2(
									$elm$core$Maybe$map,
									function (_v15) {
										var schemata = _v15.a;
										return schemata;
									},
									subSchema.properties))));
				case 'StringType':
					return $mdgriffith$elm_codegen$Elm$Annotation$string;
				case 'IntegerType':
					return $mdgriffith$elm_codegen$Elm$Annotation$int;
				case 'NumberType':
					return $mdgriffith$elm_codegen$Elm$Annotation$float;
				case 'BooleanType':
					return $mdgriffith$elm_codegen$Elm$Annotation$bool;
				case 'NullType':
					return _Debug_todo(
						'Main',
						{
							start: {line: 536, column: 29},
							end: {line: 536, column: 39}
						})('');
				default:
					var _v17 = subSchema.items;
					switch (_v17.$) {
						case 'NoItems':
							return _Debug_todo(
								'Main',
								{
									start: {line: 541, column: 37},
									end: {line: 541, column: 47}
								})('err');
						case 'ArrayOfItems':
							return _Debug_todo(
								'Main',
								{
									start: {line: 544, column: 37},
									end: {line: 544, column: 47}
								})('');
						default:
							var itemSchema = _v17.a;
							return $mdgriffith$elm_codegen$Elm$Annotation$list(
								$author$project$Main$schemaToAnnotation(itemSchema));
					}
			}
		};
		var _v1 = subSchema.type_;
		switch (_v1.$) {
			case 'SingleType':
				var singleType = _v1.a;
				return singleTypeToAnnotation(singleType);
			case 'AnyType':
				var _v2 = subSchema.ref;
				if (_v2.$ === 'Nothing') {
					var _v3 = subSchema.anyOf;
					if (_v3.$ === 'Nothing') {
						return A2(
							$mdgriffith$elm_codegen$Elm$Annotation$named,
							_List_fromArray(
								['Json', 'Encode']),
							'Value');
					} else {
						var anyOf = _v3.a;
						if ((anyOf.b && anyOf.b.b) && (!anyOf.b.b.b)) {
							var firstSchema = anyOf.a;
							var _v5 = anyOf.b;
							var secondSchema = _v5.a;
							var _v6 = _Utils_Tuple2(firstSchema, secondSchema);
							if ((_v6.a.$ === 'ObjectSchema') && (_v6.b.$ === 'ObjectSchema')) {
								var firstSubSchema = _v6.a.a;
								var secondSubSchema = _v6.b.a;
								var _v7 = _Utils_Tuple2(firstSubSchema.type_, secondSubSchema.type_);
								if ((_v7.a.$ === 'SingleType') && (_v7.a.a.$ === 'NullType')) {
									var _v8 = _v7.a.a;
									return A3(
										$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
										_List_Nil,
										'Nullable',
										_List_fromArray(
											[
												$author$project$Main$schemaToAnnotation(secondSchema)
											]));
								} else {
									if ((_v7.b.$ === 'SingleType') && (_v7.b.a.$ === 'NullType')) {
										var _v9 = _v7.b.a;
										return A3(
											$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
											_List_Nil,
											'Nullable',
											_List_fromArray(
												[
													$author$project$Main$schemaToAnnotation(firstSchema)
												]));
									} else {
										return A2(
											$mdgriffith$elm_codegen$Elm$Annotation$named,
											_List_fromArray(
												['Debug', 'Todo']),
											'AnyOfOneNotNullable');
									}
								}
							} else {
								return A2(
									$mdgriffith$elm_codegen$Elm$Annotation$named,
									_List_fromArray(
										['Debug', 'Todo']),
									'AnyOfNotBothObjectSchemas');
							}
						} else {
							return A2(
								$mdgriffith$elm_codegen$Elm$Annotation$named,
								_List_fromArray(
									['Debug', 'Todo']),
								'AnyOfNotExactly2Items');
						}
					}
				} else {
					var ref = _v2.a;
					var _v10 = A2($elm$core$String$split, '/', ref);
					if (((((((_v10.b && (_v10.a === '#')) && _v10.b.b) && (_v10.b.a === 'components')) && _v10.b.b.b) && (_v10.b.b.a === 'schemas')) && _v10.b.b.b.b) && (!_v10.b.b.b.b.b)) {
						var _v11 = _v10.b;
						var _v12 = _v11.b;
						var _v13 = _v12.b;
						var schemaName = _v13.a;
						return A2(
							$mdgriffith$elm_codegen$Elm$Annotation$named,
							_List_Nil,
							$author$project$Main$typifyName(schemaName));
					} else {
						return _Debug_todo(
							'Main',
							{
								start: {line: 591, column: 37},
								end: {line: 591, column: 47}
							})('other ref: ' + ref);
					}
				}
			case 'NullableType':
				var singleType = _v1.a;
				return A3(
					$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
					_List_Nil,
					'Nullable',
					_List_fromArray(
						[
							singleTypeToAnnotation(singleType)
						]));
			default:
				var singleTypes = _v1.a;
				return _Debug_todo(
					'Main',
					{
						start: {line: 599, column: 21},
						end: {line: 599, column: 31}
					})('union type');
		}
	}
};
var $author$project$Gen$Json$Decode$bool = $mdgriffith$elm_codegen$Elm$value(
	{
		annotation: $elm$core$Maybe$Just(
			A3(
				$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
				_List_fromArray(
					['Json', 'Decode']),
				'Decoder',
				_List_fromArray(
					[$mdgriffith$elm_codegen$Elm$Annotation$bool]))),
		importFrom: _List_fromArray(
			['Json', 'Decode']),
		name: 'bool'
	});
var $author$project$Gen$Json$Decode$field = F2(
	function (fieldArg, fieldArg0) {
		return A2(
			$mdgriffith$elm_codegen$Elm$apply,
			$mdgriffith$elm_codegen$Elm$value(
				{
					annotation: $elm$core$Maybe$Just(
						A2(
							$mdgriffith$elm_codegen$Elm$Annotation$function,
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Elm$Annotation$string,
									A3(
									$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
									_List_fromArray(
										['Json', 'Decode']),
									'Decoder',
									_List_fromArray(
										[
											$mdgriffith$elm_codegen$Elm$Annotation$var('a')
										]))
								]),
							A3(
								$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
								_List_fromArray(
									['Json', 'Decode']),
								'Decoder',
								_List_fromArray(
									[
										$mdgriffith$elm_codegen$Elm$Annotation$var('a')
									])))),
					importFrom: _List_fromArray(
						['Json', 'Decode']),
					name: 'field'
				}),
			_List_fromArray(
				[
					$mdgriffith$elm_codegen$Elm$string(fieldArg),
					fieldArg0
				]));
	});
var $author$project$Gen$Json$Decode$float = $mdgriffith$elm_codegen$Elm$value(
	{
		annotation: $elm$core$Maybe$Just(
			A3(
				$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
				_List_fromArray(
					['Json', 'Decode']),
				'Decoder',
				_List_fromArray(
					[$mdgriffith$elm_codegen$Elm$Annotation$float]))),
		importFrom: _List_fromArray(
			['Json', 'Decode']),
		name: 'float'
	});
var $author$project$Gen$Json$Decode$int = $mdgriffith$elm_codegen$Elm$value(
	{
		annotation: $elm$core$Maybe$Just(
			A3(
				$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
				_List_fromArray(
					['Json', 'Decode']),
				'Decoder',
				_List_fromArray(
					[$mdgriffith$elm_codegen$Elm$Annotation$int]))),
		importFrom: _List_fromArray(
			['Json', 'Decode']),
		name: 'int'
	});
var $author$project$Gen$Json$Decode$list = function (listArg) {
	return A2(
		$mdgriffith$elm_codegen$Elm$apply,
		$mdgriffith$elm_codegen$Elm$value(
			{
				annotation: $elm$core$Maybe$Just(
					A2(
						$mdgriffith$elm_codegen$Elm$Annotation$function,
						_List_fromArray(
							[
								A3(
								$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
								_List_fromArray(
									['Json', 'Decode']),
								'Decoder',
								_List_fromArray(
									[
										$mdgriffith$elm_codegen$Elm$Annotation$var('a')
									]))
							]),
						A3(
							$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
							_List_fromArray(
								['Json', 'Decode']),
							'Decoder',
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Elm$Annotation$list(
									$mdgriffith$elm_codegen$Elm$Annotation$var('a'))
								])))),
				importFrom: _List_fromArray(
					['Json', 'Decode']),
				name: 'list'
			}),
		_List_fromArray(
			[listArg]));
};
var $author$project$Gen$Json$Decode$null = function (nullArg) {
	return A2(
		$mdgriffith$elm_codegen$Elm$apply,
		$mdgriffith$elm_codegen$Elm$value(
			{
				annotation: $elm$core$Maybe$Just(
					A2(
						$mdgriffith$elm_codegen$Elm$Annotation$function,
						_List_fromArray(
							[
								$mdgriffith$elm_codegen$Elm$Annotation$var('a')
							]),
						A3(
							$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
							_List_fromArray(
								['Json', 'Decode']),
							'Decoder',
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Elm$Annotation$var('a')
								])))),
				importFrom: _List_fromArray(
					['Json', 'Decode']),
				name: 'null'
			}),
		_List_fromArray(
			[nullArg]));
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$ListExpr = function (a) {
	return {$: 'ListExpr', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$MismatchedList = F2(
	function (a, b) {
		return {$: 'MismatchedList', a: a, b: b};
	});
var $mdgriffith$elm_codegen$Internal$Compiler$unifyHelper = F2(
	function (exps, existing) {
		unifyHelper:
		while (true) {
			if (!exps.b) {
				return $elm$core$Result$Ok(existing);
			} else {
				var top = exps.a;
				var remain = exps.b;
				var _v1 = top.annotation;
				if (_v1.$ === 'Ok') {
					var ann = _v1.a;
					var _v2 = A4($mdgriffith$elm_codegen$Internal$Compiler$unifiable, ann.aliases, ann.inferences, ann.type_, existing.type_);
					if (_v2.b.$ === 'Err') {
						var err = _v2.b.a;
						return $elm$core$Result$Err(
							_List_fromArray(
								[
									A2($mdgriffith$elm_codegen$Internal$Compiler$MismatchedList, ann.type_, existing.type_)
								]));
					} else {
						var cache = _v2.a;
						var _new = _v2.b.a;
						var $temp$exps = remain,
							$temp$existing = {
							aliases: existing.aliases,
							inferences: A2($mdgriffith$elm_codegen$Internal$Compiler$mergeInferences, existing.inferences, cache),
							type_: _new
						};
						exps = $temp$exps;
						existing = $temp$existing;
						continue unifyHelper;
					}
				} else {
					var err = _v1.a;
					return $elm$core$Result$Err(err);
				}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$unify = function (exps) {
	if (!exps.b) {
		return $elm$core$Result$Ok(
			{
				aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
				inferences: $elm$core$Dict$empty,
				type_: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType('a')
			});
	} else {
		var top = exps.a;
		var remain = exps.b;
		var _v1 = top.annotation;
		if (_v1.$ === 'Ok') {
			var ann = _v1.a;
			return A2($mdgriffith$elm_codegen$Internal$Compiler$unifyHelper, remain, ann);
		} else {
			var err = _v1.a;
			return $elm$core$Result$Err(err);
		}
	}
};
var $mdgriffith$elm_codegen$Elm$list = function (exprs) {
	return $mdgriffith$elm_codegen$Internal$Compiler$expression(
		function (index) {
			var exprDetails = A2($mdgriffith$elm_codegen$Internal$Compiler$thread, index, exprs);
			return {
				annotation: A2(
					$elm$core$Result$map,
					function (inner) {
						return {
							aliases: inner.aliases,
							inferences: inner.inferences,
							type_: A2(
								$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Typed,
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(
									_Utils_Tuple2(_List_Nil, 'List')),
								_List_fromArray(
									[
										$mdgriffith$elm_codegen$Internal$Compiler$nodify(inner.type_)
									]))
						};
					},
					$mdgriffith$elm_codegen$Internal$Compiler$unify(exprDetails)),
				expression: $stil4m$elm_syntax$Elm$Syntax$Expression$ListExpr(
					A2(
						$elm$core$List$map,
						A2(
							$elm$core$Basics$composeR,
							function ($) {
								return $.expression;
							},
							$mdgriffith$elm_codegen$Internal$Compiler$nodify),
						exprDetails)),
				imports: A2($elm$core$List$concatMap, $mdgriffith$elm_codegen$Internal$Compiler$getImports, exprDetails)
			};
		});
};
var $author$project$Gen$Json$Decode$oneOf = function (oneOfArg) {
	return A2(
		$mdgriffith$elm_codegen$Elm$apply,
		$mdgriffith$elm_codegen$Elm$value(
			{
				annotation: $elm$core$Maybe$Just(
					A2(
						$mdgriffith$elm_codegen$Elm$Annotation$function,
						_List_fromArray(
							[
								$mdgriffith$elm_codegen$Elm$Annotation$list(
								A3(
									$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
									_List_fromArray(
										['Json', 'Decode']),
									'Decoder',
									_List_fromArray(
										[
											$mdgriffith$elm_codegen$Elm$Annotation$var('a')
										])))
							]),
						A3(
							$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
							_List_fromArray(
								['Json', 'Decode']),
							'Decoder',
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Elm$Annotation$var('a')
								])))),
				importFrom: _List_fromArray(
					['Json', 'Decode']),
				name: 'oneOf'
			}),
		_List_fromArray(
			[
				$mdgriffith$elm_codegen$Elm$list(oneOfArg)
			]));
};
var $mdgriffith$elm_codegen$Elm$Op$BinOp = F3(
	function (a, b, c) {
		return {$: 'BinOp', a: a, b: b, c: c};
	});
var $stil4m$elm_syntax$Elm$Syntax$Infix$Left = {$: 'Left'};
var $stil4m$elm_syntax$Elm$Syntax$Expression$OperatorApplication = F4(
	function (a, b, c, d) {
		return {$: 'OperatorApplication', a: a, b: b, c: c, d: d};
	});
var $mdgriffith$elm_codegen$Elm$Op$applyPipe = F4(
	function (_v0, infixAnnotation, l, r) {
		var symbol = _v0.a;
		var dir = _v0.b;
		return $mdgriffith$elm_codegen$Internal$Compiler$Expression(
			function (index) {
				var _v1 = A2($mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails, index, l);
				var leftIndex = _v1.a;
				var left = _v1.b;
				var _v2 = A2($mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails, leftIndex, r);
				var rightIndex = _v2.a;
				var right = _v2.b;
				var annotationIndex = $mdgriffith$elm_codegen$Internal$Index$next(rightIndex);
				return {
					annotation: A3(
						$mdgriffith$elm_codegen$Internal$Compiler$applyType,
						index,
						$elm$core$Result$Ok(
							{aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases, inferences: $elm$core$Dict$empty, type_: infixAnnotation}),
						_List_fromArray(
							[left, right])),
					expression: A4(
						$stil4m$elm_syntax$Elm$Syntax$Expression$OperatorApplication,
						symbol,
						dir,
						$mdgriffith$elm_codegen$Internal$Compiler$nodify(left.expression),
						$mdgriffith$elm_codegen$Internal$Compiler$nodify(right.expression)),
					imports: _Utils_ap(left.imports, right.imports)
				};
			});
	});
var $mdgriffith$elm_codegen$Internal$Types$function = F2(
	function (args, _return) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (ann, fn) {
					return A2(
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$FunctionTypeAnnotation,
						$mdgriffith$elm_codegen$Internal$Types$nodify(ann),
						$mdgriffith$elm_codegen$Internal$Types$nodify(fn));
				}),
			_return,
			args);
	});
var $mdgriffith$elm_codegen$Internal$Types$formatValue = function (str) {
	var formatted = _Utils_eq(
		$elm$core$String$toUpper(str),
		str) ? $elm$core$String$toLower(str) : _Utils_ap(
		$elm$core$String$toLower(
			A2($elm$core$String$left, 1, str)),
		A2($elm$core$String$dropLeft, 1, str));
	return $mdgriffith$elm_codegen$Internal$Format$sanitize(formatted);
};
var $mdgriffith$elm_codegen$Internal$Types$var = function (name) {
	return $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(
		$mdgriffith$elm_codegen$Internal$Types$formatValue(name));
};
var $mdgriffith$elm_codegen$Elm$Op$pipe = F2(
	function (r, l) {
		return A4(
			$mdgriffith$elm_codegen$Elm$Op$applyPipe,
			A3($mdgriffith$elm_codegen$Elm$Op$BinOp, '|>', $stil4m$elm_syntax$Elm$Syntax$Infix$Left, 0),
			A2(
				$mdgriffith$elm_codegen$Internal$Types$function,
				_List_fromArray(
					[
						$mdgriffith$elm_codegen$Internal$Types$var('a'),
						A2(
						$mdgriffith$elm_codegen$Internal$Types$function,
						_List_fromArray(
							[
								$mdgriffith$elm_codegen$Internal$Types$var('a')
							]),
						$mdgriffith$elm_codegen$Internal$Types$var('b'))
					]),
				$mdgriffith$elm_codegen$Internal$Types$var('b')),
			l,
			r);
	});
var $author$project$Gen$Json$Decode$string = $mdgriffith$elm_codegen$Elm$value(
	{
		annotation: $elm$core$Maybe$Just(
			A3(
				$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
				_List_fromArray(
					['Json', 'Decode']),
				'Decoder',
				_List_fromArray(
					[$mdgriffith$elm_codegen$Elm$Annotation$string]))),
		importFrom: _List_fromArray(
			['Json', 'Decode']),
		name: 'string'
	});
var $author$project$Gen$Json$Decode$succeed = function (succeedArg) {
	return A2(
		$mdgriffith$elm_codegen$Elm$apply,
		$mdgriffith$elm_codegen$Elm$value(
			{
				annotation: $elm$core$Maybe$Just(
					A2(
						$mdgriffith$elm_codegen$Elm$Annotation$function,
						_List_fromArray(
							[
								$mdgriffith$elm_codegen$Elm$Annotation$var('a')
							]),
						A3(
							$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
							_List_fromArray(
								['Json', 'Decode']),
							'Decoder',
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Elm$Annotation$var('a')
								])))),
				importFrom: _List_fromArray(
					['Json', 'Decode']),
				name: 'succeed'
			}),
		_List_fromArray(
			[succeedArg]));
};
var $elm$core$Debug$toString = _Debug_toString;
var $author$project$Gen$Debug$todo = function (todoArg) {
	return A2(
		$mdgriffith$elm_codegen$Elm$apply,
		$mdgriffith$elm_codegen$Elm$value(
			{
				annotation: $elm$core$Maybe$Just(
					A2(
						$mdgriffith$elm_codegen$Elm$Annotation$function,
						_List_fromArray(
							[$mdgriffith$elm_codegen$Elm$Annotation$string]),
						$mdgriffith$elm_codegen$Elm$Annotation$var('a'))),
				importFrom: _List_fromArray(
					['Debug']),
				name: 'todo'
			}),
		_List_fromArray(
			[
				$mdgriffith$elm_codegen$Elm$string(todoArg)
			]));
};
var $mdgriffith$elm_codegen$Elm$val = function (name) {
	return $mdgriffith$elm_codegen$Elm$value(
		{annotation: $elm$core$Maybe$Nothing, importFrom: _List_Nil, name: name});
};
var $author$project$Gen$Json$Decode$value = $mdgriffith$elm_codegen$Elm$value(
	{
		annotation: $elm$core$Maybe$Just(
			A3(
				$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
				_List_fromArray(
					['Json', 'Decode']),
				'Decoder',
				_List_fromArray(
					[
						A3(
						$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
						_List_fromArray(
							['Json', 'Decode']),
						'Value',
						_List_Nil)
					]))),
		importFrom: _List_fromArray(
			['Json', 'Decode']),
		name: 'value'
	});
var $author$project$Main$schemaToDecoder = function (schema) {
	if (schema.$ === 'BooleanSchema') {
		var bool = schema.a;
		return _Debug_todo(
			'Main',
			{
				start: {line: 358, column: 13},
				end: {line: 358, column: 23}
			})('');
	} else {
		var subSchema = schema.a;
		var singleTypeToDecoder = function (singleType) {
			switch (singleType.$) {
				case 'ObjectType':
					var properties = A2(
						$elm$core$Maybe$withDefault,
						_List_Nil,
						A2(
							$elm$core$Maybe$map,
							function (_v18) {
								var schemata = _v18.a;
								return schemata;
							},
							subSchema.properties));
					return A3(
						$elm$core$List$foldl,
						F2(
							function (_v15, prevExpr) {
								var key = _v15.a;
								var valueSchema = _v15.b;
								return A2(
									$mdgriffith$elm_codegen$Elm$Op$pipe,
									A2(
										$mdgriffith$elm_codegen$Elm$apply,
										$mdgriffith$elm_codegen$Elm$value(
											{
												annotation: $elm$core$Maybe$Nothing,
												importFrom: _List_fromArray(
													['Json', 'Decode', 'Extra']),
												name: 'andMap'
											}),
										_List_fromArray(
											[
												A2(
												$author$project$Gen$Json$Decode$field,
												key,
												$author$project$Main$schemaToDecoder(valueSchema))
											])),
									prevExpr);
							}),
						$author$project$Gen$Json$Decode$succeed(
							A2(
								$mdgriffith$elm_codegen$Elm$function,
								A2(
									$elm$core$List$map,
									function (_v16) {
										var key = _v16.a;
										return _Utils_Tuple2(
											$author$project$Main$elmifyName(key),
											$elm$core$Maybe$Nothing);
									},
									properties),
								function (args) {
									return $mdgriffith$elm_codegen$Elm$record(
										A3(
											$elm$core$List$map2,
											F2(
												function (_v17, arg) {
													var key = _v17.a;
													return _Utils_Tuple2(
														$author$project$Main$elmifyName(key),
														arg);
												}),
											properties,
											args));
								})),
						properties);
				case 'StringType':
					return $author$project$Gen$Json$Decode$string;
				case 'IntegerType':
					return $author$project$Gen$Json$Decode$int;
				case 'NumberType':
					return $author$project$Gen$Json$Decode$float;
				case 'BooleanType':
					return $author$project$Gen$Json$Decode$bool;
				case 'NullType':
					return _Debug_todo(
						'Main',
						{
							start: {line: 413, column: 29},
							end: {line: 413, column: 39}
						})('');
				default:
					var _v19 = subSchema.items;
					switch (_v19.$) {
						case 'NoItems':
							return _Debug_todo(
								'Main',
								{
									start: {line: 418, column: 37},
									end: {line: 418, column: 47}
								})('err');
						case 'ArrayOfItems':
							return _Debug_todo(
								'Main',
								{
									start: {line: 421, column: 37},
									end: {line: 421, column: 47}
								})('');
						default:
							var itemSchema = _v19.a;
							return $author$project$Gen$Json$Decode$list(
								$author$project$Main$schemaToDecoder(itemSchema));
					}
			}
		};
		var _v1 = subSchema.type_;
		switch (_v1.$) {
			case 'SingleType':
				var singleType = _v1.a;
				return singleTypeToDecoder(singleType);
			case 'AnyType':
				var _v2 = subSchema.ref;
				if (_v2.$ === 'Nothing') {
					var _v3 = subSchema.anyOf;
					if (_v3.$ === 'Nothing') {
						return $author$project$Gen$Json$Decode$value;
					} else {
						var anyOf = _v3.a;
						if ((anyOf.b && anyOf.b.b) && (!anyOf.b.b.b)) {
							var firstSchema = anyOf.a;
							var _v5 = anyOf.b;
							var secondSchema = _v5.a;
							var _v6 = _Utils_Tuple2(firstSchema, secondSchema);
							if ((_v6.a.$ === 'ObjectSchema') && (_v6.b.$ === 'ObjectSchema')) {
								var firstSubSchema = _v6.a.a;
								var secondSubSchema = _v6.b.a;
								var _v7 = _Utils_Tuple2(firstSubSchema.type_, secondSubSchema.type_);
								if ((_v7.a.$ === 'SingleType') && (_v7.a.a.$ === 'NullType')) {
									var _v8 = _v7.a.a;
									return $author$project$Gen$Json$Decode$oneOf(
										_List_fromArray(
											[
												A2(
												$mdgriffith$elm_codegen$Elm$apply,
												$mdgriffith$elm_codegen$Elm$value(
													{
														annotation: $elm$core$Maybe$Nothing,
														importFrom: _List_fromArray(
															['Json', 'Decode']),
														name: 'map'
													}),
												_List_fromArray(
													[
														$mdgriffith$elm_codegen$Elm$val('Present'),
														$author$project$Main$schemaToDecoder(secondSchema)
													])),
												$author$project$Gen$Json$Decode$null(
												$mdgriffith$elm_codegen$Elm$val('Null'))
											]));
								} else {
									if ((_v7.b.$ === 'SingleType') && (_v7.b.a.$ === 'NullType')) {
										var _v9 = _v7.b.a;
										return $author$project$Gen$Json$Decode$oneOf(
											_List_fromArray(
												[
													A2(
													$mdgriffith$elm_codegen$Elm$apply,
													$mdgriffith$elm_codegen$Elm$value(
														{
															annotation: $elm$core$Maybe$Nothing,
															importFrom: _List_fromArray(
																['Json', 'Decode']),
															name: 'map'
														}),
													_List_fromArray(
														[
															$mdgriffith$elm_codegen$Elm$val('Present'),
															$author$project$Main$schemaToDecoder(firstSchema)
														])),
													$author$project$Gen$Json$Decode$null(
													$mdgriffith$elm_codegen$Elm$val('Null'))
												]));
									} else {
										return $author$project$Gen$Debug$todo(
											'decode anyOf 2: not nullable:: ' + ($elm$core$Debug$toString(firstSubSchema) + (' ,,, ' + $elm$core$Debug$toString(secondSubSchema))));
									}
								}
							} else {
								return $author$project$Gen$Debug$todo('decode anyOf 2: not both object schemas');
							}
						} else {
							return $author$project$Gen$Debug$todo('decode anyOf: not exactly 2 items');
						}
					}
				} else {
					var ref = _v2.a;
					var _v10 = A2($elm$core$String$split, '/', ref);
					if (((((((_v10.b && (_v10.a === '#')) && _v10.b.b) && (_v10.b.a === 'components')) && _v10.b.b.b) && (_v10.b.b.a === 'schemas')) && _v10.b.b.b.b) && (!_v10.b.b.b.b.b)) {
						var _v11 = _v10.b;
						var _v12 = _v11.b;
						var _v13 = _v12.b;
						var schemaName = _v13.a;
						return $mdgriffith$elm_codegen$Elm$val(
							'decode' + $author$project$Main$typifyName(schemaName));
					} else {
						return _Debug_todo(
							'Main',
							{
								start: {line: 484, column: 37},
								end: {line: 484, column: 47}
							})('other ref: ' + ref);
					}
				}
			case 'NullableType':
				var singleType = _v1.a;
				return $author$project$Gen$Json$Decode$oneOf(
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_codegen$Elm$apply,
							$mdgriffith$elm_codegen$Elm$value(
								{
									annotation: $elm$core$Maybe$Nothing,
									importFrom: _List_fromArray(
										['Json', 'Decode']),
									name: 'map'
								}),
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Elm$val('Present'),
									singleTypeToDecoder(singleType)
								])),
							$author$project$Gen$Json$Decode$null(
							$mdgriffith$elm_codegen$Elm$val('Null'))
						]));
			default:
				var singleTypes = _v1.a;
				return _Debug_todo(
					'Main',
					{
						start: {line: 500, column: 21},
						end: {line: 500, column: 31}
					})('union type');
		}
	}
};
var $mdgriffith$elm_codegen$Elm$Case$Branch = function (a) {
	return {$: 'Branch', a: a};
};
var $stil4m$elm_syntax$Elm$Syntax$Pattern$NamedPattern = F2(
	function (a, b) {
		return {$: 'NamedPattern', a: a, b: b};
	});
var $mdgriffith$elm_codegen$Elm$Case$branch0 = F2(
	function (name, exp) {
		return $mdgriffith$elm_codegen$Elm$Case$Branch(
			function (index) {
				return _Utils_Tuple3(
					index,
					A2(
						$stil4m$elm_syntax$Elm$Syntax$Pattern$NamedPattern,
						{
							moduleName: _List_Nil,
							name: $mdgriffith$elm_codegen$Internal$Format$formatType(name)
						},
						_List_Nil),
					exp);
			});
	});
var $mdgriffith$elm_codegen$Internal$Compiler$toVarWithType = F3(
	function (index, desiredName, _v0) {
		var ann = _v0.a;
		var _v1 = A2($mdgriffith$elm_codegen$Internal$Index$getName, desiredName, index);
		var name = _v1.a;
		var newIndex = _v1.b;
		return {
			exp: $mdgriffith$elm_codegen$Internal$Compiler$Expression(
				function (ignoredIndex_) {
					return {
						annotation: $elm$core$Result$Ok(
							{aliases: ann.aliases, inferences: $elm$core$Dict$empty, type_: ann.annotation}),
						expression: A2($stil4m$elm_syntax$Elm$Syntax$Expression$FunctionOrValue, _List_Nil, name),
						imports: ann.imports
					};
				}),
			index: newIndex,
			name: name
		};
	});
var $mdgriffith$elm_codegen$Elm$Case$branch1 = F3(
	function (name, _v0, toExp) {
		var argName = _v0.a;
		var argType = _v0.b;
		return $mdgriffith$elm_codegen$Elm$Case$Branch(
			function (index) {
				var _var = A3($mdgriffith$elm_codegen$Internal$Compiler$toVarWithType, index, argName, argType);
				return _Utils_Tuple3(
					_var.index,
					A2(
						$stil4m$elm_syntax$Elm$Syntax$Pattern$NamedPattern,
						{
							moduleName: _List_Nil,
							name: $mdgriffith$elm_codegen$Internal$Format$formatType(name)
						},
						_List_fromArray(
							[
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(
								$stil4m$elm_syntax$Elm$Syntax$Pattern$VarPattern(_var.name))
							])),
					toExp(_var.exp));
			});
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$CaseExpression = function (a) {
	return {$: 'CaseExpression', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$EmptyCaseStatement = {$: 'EmptyCaseStatement'};
var $mdgriffith$elm_codegen$Elm$Case$combineInferences = F2(
	function (infs, infResult) {
		if (infResult.$ === 'Ok') {
			var inferred = infResult.a;
			return $elm$core$Result$Ok(
				_Utils_update(
					inferred,
					{
						inferences: A2($mdgriffith$elm_codegen$Internal$Compiler$mergeInferences, infs, inferred.inferences)
					}));
		} else {
			var err = infResult.a;
			return $elm$core$Result$Err(err);
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$unifyOn = F2(
	function (_v0, res) {
		var annDetails = _v0.a;
		if (res.$ === 'Err') {
			return res;
		} else {
			var inf = res.a;
			var _v2 = A4($mdgriffith$elm_codegen$Internal$Compiler$unifiable, inf.aliases, inf.inferences, annDetails.annotation, inf.type_);
			var newInferences = _v2.a;
			var finalResult = _v2.b;
			if (finalResult.$ === 'Ok') {
				var finalType = finalResult.a;
				return $elm$core$Result$Ok(
					{
						aliases: A2($mdgriffith$elm_codegen$Internal$Compiler$mergeAliases, annDetails.aliases, inf.aliases),
						inferences: newInferences,
						type_: finalType
					});
			} else {
				var err = finalResult.a;
				return $elm$core$Result$Err(
					_List_fromArray(
						[err]));
			}
		}
	});
var $mdgriffith$elm_codegen$Elm$Case$captureCaseHelper = F3(
	function (mainCaseExpressionModule, _v0, accum) {
		var toBranch = _v0.a;
		var _v1 = toBranch(
			$mdgriffith$elm_codegen$Internal$Index$dive(accum.index));
		var branchIndex = _v1.a;
		var originalPattern = _v1.b;
		var caseExpression = _v1.c;
		var _v2 = A2($mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails, branchIndex, caseExpression);
		var newIndex = _v2.a;
		var exp = _v2.b;
		var pattern = function () {
			if (!mainCaseExpressionModule.b) {
				return originalPattern;
			} else {
				if (originalPattern.$ === 'NamedPattern') {
					var named = originalPattern.a;
					var vars = originalPattern.b;
					return A2(
						$stil4m$elm_syntax$Elm$Syntax$Pattern$NamedPattern,
						{moduleName: mainCaseExpressionModule, name: named.name},
						vars);
				} else {
					return originalPattern;
				}
			}
		}();
		return {
			annotation: function () {
				var _v3 = accum.annotation;
				if (_v3.$ === 'Nothing') {
					return $elm$core$Maybe$Just(exp.annotation);
				} else {
					if (_v3.a.$ === 'Ok') {
						var gatheredAnnotation = _v3.a.a;
						return $elm$core$Maybe$Just(
							A2(
								$mdgriffith$elm_codegen$Internal$Compiler$unifyOn,
								$mdgriffith$elm_codegen$Internal$Compiler$Annotation(
									{aliases: gatheredAnnotation.aliases, annotation: gatheredAnnotation.type_, imports: _List_Nil}),
								A2($mdgriffith$elm_codegen$Elm$Case$combineInferences, gatheredAnnotation.inferences, exp.annotation)));
					} else {
						var err = _v3.a;
						return $elm$core$Maybe$Just(err);
					}
				}
			}(),
			cases: A2(
				$elm$core$List$cons,
				_Utils_Tuple2(
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(pattern),
					$mdgriffith$elm_codegen$Internal$Compiler$nodify(exp.expression)),
				accum.cases),
			imports: _Utils_ap(accum.imports, exp.imports),
			index: accum.index
		};
	});
var $mdgriffith$elm_codegen$Internal$Compiler$importInferences = F2(
	function (one, two) {
		return {
			aliases: A2($mdgriffith$elm_codegen$Internal$Compiler$mergeAliases, one.aliases, two.aliases),
			inferences: A2($mdgriffith$elm_codegen$Internal$Compiler$mergeInferences, one.inferences, two.inferences),
			type_: two.type_
		};
	});
var $mdgriffith$elm_codegen$Elm$Case$captureCase = F4(
	function (mainExpression, mainExpressionTypeModule, index, branches) {
		var _v0 = A2($mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails, index, mainExpression);
		var branchIndex = _v0.a;
		var mainExpressionDetails = _v0.b;
		var caseExp = A3(
			$elm$core$List$foldl,
			$mdgriffith$elm_codegen$Elm$Case$captureCaseHelper(mainExpressionTypeModule),
			{annotation: $elm$core$Maybe$Nothing, cases: _List_Nil, imports: _List_Nil, index: branchIndex},
			branches);
		return _Utils_Tuple2(
			mainExpressionDetails,
			_Utils_update(
				caseExp,
				{
					annotation: function () {
						var _v1 = caseExp.annotation;
						if ((_v1.$ === 'Just') && (_v1.a.$ === 'Ok')) {
							var inference = _v1.a.a;
							var _v2 = mainExpressionDetails.annotation;
							if (_v2.$ === 'Err') {
								var err = _v2.a;
								return $elm$core$Maybe$Just(
									$elm$core$Result$Err(err));
							} else {
								var mainAnn = _v2.a;
								return $elm$core$Maybe$Just(
									$elm$core$Result$Ok(
										A2($mdgriffith$elm_codegen$Internal$Compiler$importInferences, mainAnn, inference)));
							}
						} else {
							return caseExp.annotation;
						}
					}()
				}));
	});
var $mdgriffith$elm_codegen$Internal$Compiler$getTypeModule = function (_v0) {
	var annotation = _v0.a;
	var _v1 = annotation.annotation;
	if (_v1.$ === 'Typed') {
		var _v2 = _v1.a;
		var _v3 = _v2.b;
		var mod = _v3.a;
		var typeName = _v3.b;
		return mod;
	} else {
		return _List_Nil;
	}
};
var $mdgriffith$elm_codegen$Elm$withType = F2(
	function (ann, _v0) {
		var annDetails = ann.a;
		var toExp = _v0.a;
		return $mdgriffith$elm_codegen$Internal$Compiler$Expression(
			function (index) {
				var exp = toExp(index);
				return _Utils_update(
					exp,
					{
						annotation: function () {
							var _v1 = A2($mdgriffith$elm_codegen$Internal$Compiler$unifyOn, ann, exp.annotation);
							if (_v1.$ === 'Ok') {
								var unified = _v1.a;
								return $elm$core$Result$Ok(unified);
							} else {
								var _v2 = exp.annotation;
								if (_v2.$ === 'Ok') {
									var expressionAnnotation = _v2.a;
									return $elm$core$Result$Ok(
										{aliases: expressionAnnotation.aliases, inferences: expressionAnnotation.inferences, type_: annDetails.annotation});
								} else {
									var err = _v2.a;
									return $elm$core$Result$Ok(
										{aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases, inferences: $elm$core$Dict$empty, type_: annDetails.annotation});
								}
							}
						}(),
						imports: _Utils_ap(exp.imports, annDetails.imports)
					});
			});
	});
var $mdgriffith$elm_codegen$Elm$Case$custom = F3(
	function (mainExpression, annotation, branches) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Expression(
			function (index) {
				var myMain = A2($mdgriffith$elm_codegen$Elm$withType, annotation, mainExpression);
				var _v0 = A4(
					$mdgriffith$elm_codegen$Elm$Case$captureCase,
					myMain,
					$mdgriffith$elm_codegen$Internal$Compiler$getTypeModule(annotation),
					$mdgriffith$elm_codegen$Internal$Index$dive(index),
					branches);
				var expr = _v0.a;
				var gathered = _v0.b;
				return {
					annotation: function () {
						var _v1 = gathered.annotation;
						if (_v1.$ === 'Nothing') {
							return $elm$core$Result$Err(
								_List_fromArray(
									[$mdgriffith$elm_codegen$Internal$Compiler$EmptyCaseStatement]));
						} else {
							var ann = _v1.a;
							return ann;
						}
					}(),
					expression: $stil4m$elm_syntax$Elm$Syntax$Expression$CaseExpression(
						{
							cases: $elm$core$List$reverse(gathered.cases),
							expression: $mdgriffith$elm_codegen$Internal$Compiler$nodify(expr.expression)
						}),
					imports: _Utils_ap(expr.imports, gathered.imports)
				};
			});
	});
var $stil4m$elm_syntax$Elm$Syntax$Expression$RecordAccess = F2(
	function (a, b) {
		return {$: 'RecordAccess', a: a, b: b};
	});
var $mdgriffith$elm_codegen$Internal$Compiler$AttemptingGetOnTypeNameNotAnAlias = function (a) {
	return {$: 'AttemptingGetOnTypeNameNotAnAlias', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$AttemptingToGetOnIncorrectType = function (a) {
	return {$: 'AttemptingToGetOnIncorrectType', a: a};
};
var $mdgriffith$elm_codegen$Internal$Compiler$getFieldFromList = F2(
	function (selector, fields) {
		getFieldFromList:
		while (true) {
			if (!fields.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				var nodifiedTop = fields.a;
				var remain = fields.b;
				var _v1 = $mdgriffith$elm_codegen$Internal$Compiler$denode(nodifiedTop);
				var fieldname = _v1.a;
				var contents = _v1.b;
				if (_Utils_eq(
					$mdgriffith$elm_codegen$Internal$Compiler$denode(fieldname),
					selector)) {
					return $elm$core$Maybe$Just(
						$mdgriffith$elm_codegen$Internal$Compiler$denode(contents));
				} else {
					var $temp$selector = selector,
						$temp$fields = remain;
					selector = $temp$selector;
					fields = $temp$fields;
					continue getFieldFromList;
				}
			}
		}
	});
var $mdgriffith$elm_codegen$Internal$Compiler$inferRecordField = F2(
	function (index, _v0) {
		var fieldName = _v0.fieldName;
		var nameOfRecord = _v0.nameOfRecord;
		var fieldType = $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericType(
			$mdgriffith$elm_codegen$Internal$Format$formatValue(
				_Utils_ap(
					fieldName,
					$mdgriffith$elm_codegen$Internal$Index$indexToString(index))));
		return $elm$core$Result$Ok(
			{
				aliases: $mdgriffith$elm_codegen$Internal$Compiler$emptyAliases,
				inferences: A3(
					$mdgriffith$elm_codegen$Internal$Compiler$addInference,
					nameOfRecord,
					A2(
						$stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$GenericRecord,
						$mdgriffith$elm_codegen$Internal$Compiler$nodify(nameOfRecord),
						$mdgriffith$elm_codegen$Internal$Compiler$nodify(
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Internal$Compiler$nodify(
									_Utils_Tuple2(
										$mdgriffith$elm_codegen$Internal$Compiler$nodify(fieldName),
										$mdgriffith$elm_codegen$Internal$Compiler$nodify(fieldType)))
								]))),
					$elm$core$Dict$empty),
				type_: fieldType
			});
	});
var $mdgriffith$elm_codegen$Internal$Compiler$resolveField = F5(
	function (index, type_, aliases, inferences, fieldName) {
		resolveField:
		while (true) {
			if ($mdgriffith$elm_codegen$Internal$Index$typecheck(index)) {
				switch (type_.$) {
					case 'Record':
						var fields = type_.a;
						var _v1 = A2($mdgriffith$elm_codegen$Internal$Compiler$getFieldFromList, fieldName, fields);
						if (_v1.$ === 'Just') {
							var ann = _v1.a;
							return $elm$core$Result$Ok(
								{aliases: aliases, inferences: inferences, type_: ann});
						} else {
							return $elm$core$Result$Err(
								_List_fromArray(
									[
										$mdgriffith$elm_codegen$Internal$Compiler$CouldNotFindField(
										{
											existingFields: A2(
												$elm$core$List$map,
												A2(
													$elm$core$Basics$composeR,
													$mdgriffith$elm_codegen$Internal$Compiler$denode,
													A2($elm$core$Basics$composeR, $elm$core$Tuple$first, $mdgriffith$elm_codegen$Internal$Compiler$denode)),
												fields),
											field: fieldName
										})
									]));
						}
					case 'GenericRecord':
						var name = type_.a;
						var fields = type_.b;
						var _v2 = A2(
							$mdgriffith$elm_codegen$Internal$Compiler$getFieldFromList,
							fieldName,
							$mdgriffith$elm_codegen$Internal$Compiler$denode(fields));
						if (_v2.$ === 'Just') {
							var ann = _v2.a;
							return $elm$core$Result$Ok(
								{aliases: aliases, inferences: inferences, type_: ann});
						} else {
							return $elm$core$Result$Err(
								_List_fromArray(
									[
										$mdgriffith$elm_codegen$Internal$Compiler$CouldNotFindField(
										{
											existingFields: A2(
												$elm$core$List$map,
												A2(
													$elm$core$Basics$composeR,
													$mdgriffith$elm_codegen$Internal$Compiler$denode,
													A2($elm$core$Basics$composeR, $elm$core$Tuple$first, $mdgriffith$elm_codegen$Internal$Compiler$denode)),
												$mdgriffith$elm_codegen$Internal$Compiler$denode(fields)),
											field: fieldName
										})
									]));
						}
					case 'GenericType':
						var nameOfRecord = type_.a;
						return A2(
							$mdgriffith$elm_codegen$Internal$Compiler$inferRecordField,
							index,
							{fieldName: fieldName, nameOfRecord: nameOfRecord});
					case 'Typed':
						var nodedModAndName = type_.a;
						var vars = type_.b;
						var _v3 = A2($mdgriffith$elm_codegen$Internal$Compiler$getAlias, nodedModAndName, aliases);
						if (_v3.$ === 'Nothing') {
							return $elm$core$Result$Err(
								_List_fromArray(
									[
										$mdgriffith$elm_codegen$Internal$Compiler$AttemptingGetOnTypeNameNotAnAlias(
										{field: fieldName, on: type_})
									]));
						} else {
							var aliased = _v3.a;
							var $temp$index = index,
								$temp$type_ = aliased.target,
								$temp$aliases = aliases,
								$temp$inferences = inferences,
								$temp$fieldName = fieldName;
							index = $temp$index;
							type_ = $temp$type_;
							aliases = $temp$aliases;
							inferences = $temp$inferences;
							fieldName = $temp$fieldName;
							continue resolveField;
						}
					case 'Tupled':
						return $elm$core$Result$Err(
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Internal$Compiler$AttemptingToGetOnIncorrectType(
									{field: fieldName, on: type_})
								]));
					case 'Unit':
						return $elm$core$Result$Err(
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Internal$Compiler$AttemptingToGetOnIncorrectType(
									{field: fieldName, on: type_})
								]));
					default:
						return $elm$core$Result$Err(
							_List_fromArray(
								[
									$mdgriffith$elm_codegen$Internal$Compiler$AttemptingToGetOnIncorrectType(
									{field: fieldName, on: type_})
								]));
				}
			} else {
				return $elm$core$Result$Err(_List_Nil);
			}
		}
	});
var $mdgriffith$elm_codegen$Elm$get = F2(
	function (unformattedFieldName, recordExpression) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Expression(
			function (index) {
				var fieldName = $mdgriffith$elm_codegen$Internal$Format$formatValue(unformattedFieldName);
				var _v0 = A2($mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails, index, recordExpression);
				var expr = _v0.b;
				return {
					annotation: function () {
						var _v1 = expr.annotation;
						if (_v1.$ === 'Ok') {
							var recordAnn = _v1.a;
							return A5($mdgriffith$elm_codegen$Internal$Compiler$resolveField, index, recordAnn.type_, recordAnn.aliases, recordAnn.inferences, fieldName);
						} else {
							var otherwise = _v1;
							return otherwise;
						}
					}(),
					expression: A2(
						$stil4m$elm_syntax$Elm$Syntax$Expression$RecordAccess,
						$mdgriffith$elm_codegen$Internal$Compiler$nodify(expr.expression),
						$mdgriffith$elm_codegen$Internal$Compiler$nodify(fieldName)),
					imports: expr.imports
				};
			});
	});
var $author$project$Gen$Json$Encode$null = $mdgriffith$elm_codegen$Elm$value(
	{
		annotation: $elm$core$Maybe$Just(
			A3(
				$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
				_List_fromArray(
					['Json', 'Encode']),
				'Value',
				_List_Nil)),
		importFrom: _List_fromArray(
			['Json', 'Encode']),
		name: 'null'
	});
var $mdgriffith$elm_codegen$Elm$Annotation$tuple = F2(
	function (one, two) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Annotation(
			{
				aliases: A2(
					$mdgriffith$elm_codegen$Internal$Compiler$mergeAliases,
					$mdgriffith$elm_codegen$Elm$Annotation$getAliases(one),
					$mdgriffith$elm_codegen$Elm$Annotation$getAliases(two)),
				annotation: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled(
					$mdgriffith$elm_codegen$Internal$Compiler$nodifyAll(
						_List_fromArray(
							[
								$mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation(one),
								$mdgriffith$elm_codegen$Internal$Compiler$getInnerAnnotation(two)
							]))),
				imports: _Utils_ap(
					$mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports(one),
					$mdgriffith$elm_codegen$Internal$Compiler$getAnnotationImports(two))
			});
	});
var $author$project$Gen$Json$Encode$object = function (objectArg) {
	return A2(
		$mdgriffith$elm_codegen$Elm$apply,
		$mdgriffith$elm_codegen$Elm$value(
			{
				annotation: $elm$core$Maybe$Just(
					A2(
						$mdgriffith$elm_codegen$Elm$Annotation$function,
						_List_fromArray(
							[
								$mdgriffith$elm_codegen$Elm$Annotation$list(
								A2(
									$mdgriffith$elm_codegen$Elm$Annotation$tuple,
									$mdgriffith$elm_codegen$Elm$Annotation$string,
									A3(
										$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
										_List_fromArray(
											['Json', 'Encode']),
										'Value',
										_List_Nil)))
							]),
						A3(
							$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
							_List_fromArray(
								['Json', 'Encode']),
							'Value',
							_List_Nil))),
				importFrom: _List_fromArray(
					['Json', 'Encode']),
				name: 'object'
			}),
		_List_fromArray(
			[
				$mdgriffith$elm_codegen$Elm$list(objectArg)
			]));
};
var $stil4m$elm_syntax$Elm$Syntax$Expression$TupledExpression = function (a) {
	return {$: 'TupledExpression', a: a};
};
var $mdgriffith$elm_codegen$Elm$tuple = F2(
	function (oneExp, twoExp) {
		return $mdgriffith$elm_codegen$Internal$Compiler$Expression(
			function (index) {
				var _v0 = A2($mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails, index, oneExp);
				var oneIndex = _v0.a;
				var one = _v0.b;
				var _v1 = A2($mdgriffith$elm_codegen$Internal$Compiler$toExpressionDetails, oneIndex, twoExp);
				var twoIndex = _v1.a;
				var two = _v1.b;
				return {
					annotation: A3(
						$elm$core$Result$map2,
						F2(
							function (oneA, twoA) {
								return {
									aliases: A2($mdgriffith$elm_codegen$Internal$Compiler$mergeAliases, twoA.aliases, oneA.aliases),
									inferences: A2($mdgriffith$elm_codegen$Internal$Compiler$mergeInferences, twoA.inferences, oneA.inferences),
									type_: $stil4m$elm_syntax$Elm$Syntax$TypeAnnotation$Tupled(
										_List_fromArray(
											[
												$mdgriffith$elm_codegen$Internal$Compiler$nodify(oneA.type_),
												$mdgriffith$elm_codegen$Internal$Compiler$nodify(twoA.type_)
											]))
								};
							}),
						one.annotation,
						two.annotation),
					expression: $stil4m$elm_syntax$Elm$Syntax$Expression$TupledExpression(
						_List_fromArray(
							[
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(one.expression),
								$mdgriffith$elm_codegen$Internal$Compiler$nodify(two.expression)
							])),
					imports: _Utils_ap(one.imports, two.imports)
				};
			});
	});
var $author$project$Main$schemaToEncoder = function (schema) {
	if (schema.$ === 'BooleanSchema') {
		var bool = schema.a;
		return _Debug_todo(
			'Main',
			{
				start: {line: 204, column: 13},
				end: {line: 204, column: 23}
			})('');
	} else {
		var subSchema = schema.a;
		var singleTypeToDecoder = function (singleType) {
			switch (singleType.$) {
				case 'ObjectType':
					return A2(
						$mdgriffith$elm_codegen$Elm$fn,
						_Utils_Tuple2('rec', $elm$core$Maybe$Nothing),
						function (rec) {
							return $author$project$Gen$Json$Encode$object(
								A2(
									$elm$core$List$map,
									function (_v16) {
										var key = _v16.a;
										var valueSchema = _v16.b;
										return A2(
											$mdgriffith$elm_codegen$Elm$tuple,
											$mdgriffith$elm_codegen$Elm$string(key),
											A2(
												$mdgriffith$elm_codegen$Elm$apply,
												$author$project$Main$schemaToEncoder(valueSchema),
												_List_fromArray(
													[
														A2(
														$mdgriffith$elm_codegen$Elm$get,
														$author$project$Main$elmifyName(key),
														rec)
													])));
									},
									A2(
										$elm$core$Maybe$withDefault,
										_List_Nil,
										A2(
											$elm$core$Maybe$map,
											function (_v15) {
												var schemata = _v15.a;
												return schemata;
											},
											subSchema.properties))));
						});
				case 'StringType':
					return $mdgriffith$elm_codegen$Elm$value(
						{
							annotation: $elm$core$Maybe$Nothing,
							importFrom: _List_fromArray(
								['Json', 'Encode']),
							name: 'string'
						});
				case 'IntegerType':
					return $mdgriffith$elm_codegen$Elm$value(
						{
							annotation: $elm$core$Maybe$Nothing,
							importFrom: _List_fromArray(
								['Json', 'Encode']),
							name: 'int'
						});
				case 'NumberType':
					return $mdgriffith$elm_codegen$Elm$value(
						{
							annotation: $elm$core$Maybe$Nothing,
							importFrom: _List_fromArray(
								['Json', 'Encode']),
							name: 'float'
						});
				case 'BooleanType':
					return $mdgriffith$elm_codegen$Elm$value(
						{
							annotation: $elm$core$Maybe$Nothing,
							importFrom: _List_fromArray(
								['Json', 'Encode']),
							name: 'bool'
						});
				case 'NullType':
					return _Debug_todo(
						'Main',
						{
							start: {line: 254, column: 29},
							end: {line: 254, column: 39}
						})('');
				default:
					var _v17 = subSchema.items;
					switch (_v17.$) {
						case 'NoItems':
							return _Debug_todo(
								'Main',
								{
									start: {line: 259, column: 37},
									end: {line: 259, column: 47}
								})('err');
						case 'ArrayOfItems':
							return _Debug_todo(
								'Main',
								{
									start: {line: 262, column: 37},
									end: {line: 262, column: 47}
								})('');
						default:
							var itemSchema = _v17.a;
							return A2(
								$mdgriffith$elm_codegen$Elm$apply,
								$mdgriffith$elm_codegen$Elm$value(
									{
										annotation: $elm$core$Maybe$Nothing,
										importFrom: _List_fromArray(
											['Json', 'Encode']),
										name: 'list'
									}),
								_List_fromArray(
									[
										$author$project$Main$schemaToEncoder(itemSchema)
									]));
					}
			}
		};
		var _v1 = subSchema.type_;
		switch (_v1.$) {
			case 'SingleType':
				var singleType = _v1.a;
				return singleTypeToDecoder(singleType);
			case 'AnyType':
				var _v2 = subSchema.ref;
				if (_v2.$ === 'Nothing') {
					var _v3 = subSchema.anyOf;
					if (_v3.$ === 'Nothing') {
						return $mdgriffith$elm_codegen$Elm$val('identity');
					} else {
						var anyOf = _v3.a;
						_v4$2:
						while (true) {
							if (anyOf.b) {
								if (!anyOf.b.b) {
									var onlySchema = anyOf.a;
									return $author$project$Gen$Debug$todo('decode anyOf: exactly 1 item');
								} else {
									if (!anyOf.b.b.b) {
										var firstSchema = anyOf.a;
										var _v5 = anyOf.b;
										var secondSchema = _v5.a;
										var _v6 = _Utils_Tuple2(firstSchema, secondSchema);
										if ((_v6.a.$ === 'ObjectSchema') && (_v6.b.$ === 'ObjectSchema')) {
											var firstSubSchema = _v6.a.a;
											var secondSubSchema = _v6.b.a;
											var _v7 = _Utils_Tuple2(firstSubSchema.type_, secondSubSchema.type_);
											if ((_v7.a.$ === 'SingleType') && (_v7.a.a.$ === 'NullType')) {
												var _v8 = _v7.a.a;
												return A2(
													$mdgriffith$elm_codegen$Elm$fn,
													_Utils_Tuple2('nullableValue', $elm$core$Maybe$Nothing),
													function (nullableValue) {
														return A3(
															$mdgriffith$elm_codegen$Elm$Case$custom,
															nullableValue,
															A3(
																$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
																_List_Nil,
																'Nullable',
																_List_fromArray(
																	[
																		$mdgriffith$elm_codegen$Elm$Annotation$var('value')
																	])),
															_List_fromArray(
																[
																	A2($mdgriffith$elm_codegen$Elm$Case$branch0, 'Null', $author$project$Gen$Json$Encode$null),
																	A3(
																	$mdgriffith$elm_codegen$Elm$Case$branch1,
																	'Present',
																	_Utils_Tuple2(
																		'value',
																		$mdgriffith$elm_codegen$Elm$Annotation$var('value')),
																	function (value) {
																		return A2(
																			$mdgriffith$elm_codegen$Elm$apply,
																			$author$project$Main$schemaToEncoder(secondSchema),
																			_List_fromArray(
																				[value]));
																	})
																]));
													});
											} else {
												if ((_v7.b.$ === 'SingleType') && (_v7.b.a.$ === 'NullType')) {
													var _v9 = _v7.b.a;
													return A2(
														$mdgriffith$elm_codegen$Elm$fn,
														_Utils_Tuple2('nullableValue', $elm$core$Maybe$Nothing),
														function (nullableValue) {
															return A3(
																$mdgriffith$elm_codegen$Elm$Case$custom,
																nullableValue,
																A3(
																	$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
																	_List_Nil,
																	'Nullable',
																	_List_fromArray(
																		[
																			$mdgriffith$elm_codegen$Elm$Annotation$var('value')
																		])),
																_List_fromArray(
																	[
																		A2($mdgriffith$elm_codegen$Elm$Case$branch0, 'Null', $author$project$Gen$Json$Encode$null),
																		A3(
																		$mdgriffith$elm_codegen$Elm$Case$branch1,
																		'Present',
																		_Utils_Tuple2(
																			'value',
																			$mdgriffith$elm_codegen$Elm$Annotation$var('value')),
																		function (value) {
																			return A2(
																				$mdgriffith$elm_codegen$Elm$apply,
																				$author$project$Main$schemaToEncoder(firstSchema),
																				_List_fromArray(
																					[value]));
																		})
																	]));
														});
												} else {
													return $author$project$Gen$Debug$todo(
														'decode anyOf 2: not nullable:: ' + ($elm$core$Debug$toString(firstSubSchema) + (' ,,, ' + $elm$core$Debug$toString(secondSubSchema))));
												}
											}
										} else {
											return $author$project$Gen$Debug$todo('decode anyOf 2: not both object schemas');
										}
									} else {
										break _v4$2;
									}
								}
							} else {
								break _v4$2;
							}
						}
						var manySchemas = anyOf;
						return $author$project$Gen$Debug$todo('decode anyOf: not exactly 2 items');
					}
				} else {
					var ref = _v2.a;
					var _v10 = A2($elm$core$String$split, '/', ref);
					if (((((((_v10.b && (_v10.a === '#')) && _v10.b.b) && (_v10.b.a === 'components')) && _v10.b.b.b) && (_v10.b.b.a === 'schemas')) && _v10.b.b.b.b) && (!_v10.b.b.b.b.b)) {
						var _v11 = _v10.b;
						var _v12 = _v11.b;
						var _v13 = _v12.b;
						var schemaName = _v13.a;
						return $mdgriffith$elm_codegen$Elm$val(
							'encode' + $author$project$Main$typifyName(schemaName));
					} else {
						return _Debug_todo(
							'Main',
							{
								start: {line: 335, column: 37},
								end: {line: 335, column: 47}
							})('other ref: ' + ref);
					}
				}
			case 'NullableType':
				var singleType = _v1.a;
				return A2(
					$mdgriffith$elm_codegen$Elm$fn,
					_Utils_Tuple2('nullableValue', $elm$core$Maybe$Nothing),
					function (nullableValue) {
						return A3(
							$mdgriffith$elm_codegen$Elm$Case$custom,
							nullableValue,
							A3(
								$mdgriffith$elm_codegen$Elm$Annotation$namedWith,
								_List_Nil,
								'Nullable',
								_List_fromArray(
									[
										$mdgriffith$elm_codegen$Elm$Annotation$var('value')
									])),
							_List_fromArray(
								[
									A2($mdgriffith$elm_codegen$Elm$Case$branch0, 'Null', $author$project$Gen$Json$Encode$null),
									A3(
									$mdgriffith$elm_codegen$Elm$Case$branch1,
									'Present',
									_Utils_Tuple2(
										'value',
										$mdgriffith$elm_codegen$Elm$Annotation$var('value')),
									function (value) {
										return A2(
											$mdgriffith$elm_codegen$Elm$apply,
											singleTypeToDecoder(singleType),
											_List_fromArray(
												[value]));
									})
								]));
					});
			default:
				var singleTypes = _v1.a;
				return _Debug_todo(
					'Main',
					{
						start: {line: 351, column: 21},
						end: {line: 351, column: 31}
					})('union type');
		}
	}
};
var $author$project$OpenApi$Components$schemas = function (_v0) {
	var contact = _v0.a;
	return contact.schemas;
};
var $author$project$OpenApi$Info$title = function (_v0) {
	var info = _v0.a;
	return info.title;
};
var $elm$json$Json$Encode$list = F2(
	function (func, entries) {
		return _Json_wrap(
			A3(
				$elm$core$List$foldl,
				_Json_addEntry(func),
				_Json_emptyArray(_Utils_Tuple0),
				entries));
	});
var $elm$json$Json$Encode$string = _Json_wrap;
var $author$project$Main$writeFile = _Platform_outgoingPort(
	'writeFile',
	function ($) {
		var a = $.a;
		var b = $.b;
		return A2(
			$elm$json$Json$Encode$list,
			$elm$core$Basics$identity,
			_List_fromArray(
				[
					$elm$json$Json$Encode$string(a),
					$elm$json$Json$Encode$string(b)
				]));
	});
var $author$project$Main$writeMsg = _Platform_outgoingPort('writeMsg', $elm$json$Json$Encode$string);
var $author$project$Main$update = F2(
	function (msg, model) {
		var specValue = msg.a;
		var _v1 = A2($elm$json$Json$Decode$decodeValue, $author$project$OpenApi$decode, specValue);
		if (_v1.$ === 'Ok') {
			var apiSpec = _v1.a;
			return _Utils_Tuple2(
				model,
				function () {
					var pathDeclarations = A3(
						$elm$core$Dict$foldl,
						F3(
							function (url, path, res) {
								return _Utils_ap(
									res,
									A2(
										$elm$core$List$filterMap,
										$elm$core$Basics$identity,
										_List_fromArray(
											[
												A2(
												$elm$core$Maybe$map,
												function (operation) {
													return A3(
														$mdgriffith$elm_codegen$Elm$Declare$fn,
														$elm_community$string_extra$String$Extra$camelize(
															$author$project$Main$removeInvlidChars(
																$author$project$Main$makeNamespaceValid(
																	A2(
																		$elm$core$Maybe$withDefault,
																		url,
																		$author$project$OpenApi$Operation$operationId(operation))))),
														_Utils_Tuple2(
															'toMsg',
															$elm$core$Maybe$Just(
																A2(
																	$mdgriffith$elm_codegen$Elm$Annotation$function,
																	_List_fromArray(
																		[
																			A2(
																			$author$project$Gen$Result$annotation_.result,
																			$author$project$Gen$Http$annotation_.error,
																			$mdgriffith$elm_codegen$Elm$Annotation$var('todo'))
																		]),
																	$mdgriffith$elm_codegen$Elm$Annotation$var('msg')))),
														function (toMsg) {
															return $author$project$Gen$Http$get(
																{
																	expect: A2(
																		$author$project$Gen$Http$expectJson,
																		function (result) {
																			return A2(
																				$mdgriffith$elm_codegen$Elm$apply,
																				toMsg,
																				_List_fromArray(
																					[result]));
																		},
																		$author$project$Gen$Debug$todo('todo')),
																	url: url
																});
														}).declaration;
												},
												$author$project$OpenApi$Path$get(path))
											])));
							}),
						_List_Nil,
						$author$project$OpenApi$paths(apiSpec));
					var namespace = $author$project$Main$removeInvlidChars(
						$author$project$Main$makeNamespaceValid(
							$author$project$OpenApi$Info$title(
								$author$project$OpenApi$info(apiSpec))));
					var componentDeclarations = $elm$core$List$concat(
						A3(
							$elm$core$Dict$foldl,
							F3(
								function (name, schema, res) {
									return A2(
										$elm$core$List$cons,
										_List_fromArray(
											[
												A2(
												$mdgriffith$elm_codegen$Elm$alias,
												$author$project$Main$typifyName(name),
												$author$project$Main$schemaToAnnotation(
													$author$project$OpenApi$Schema$get(schema))),
												A3(
												$mdgriffith$elm_codegen$Elm$Declare$function,
												'decode' + $author$project$Main$typifyName(name),
												_List_Nil,
												function (_v2) {
													return A2(
														$mdgriffith$elm_codegen$Elm$withType,
														$author$project$Gen$Json$Decode$annotation_.decoder(
															A2(
																$mdgriffith$elm_codegen$Elm$Annotation$named,
																_List_Nil,
																$author$project$Main$typifyName(name))),
														$author$project$Main$schemaToDecoder(
															$author$project$OpenApi$Schema$get(schema)));
												}).declaration,
												A3(
												$mdgriffith$elm_codegen$Elm$Declare$function,
												'encode' + $author$project$Main$typifyName(name),
												_List_Nil,
												function (_v3) {
													return A2(
														$mdgriffith$elm_codegen$Elm$withType,
														A2(
															$mdgriffith$elm_codegen$Elm$Annotation$function,
															_List_fromArray(
																[
																	A2(
																	$mdgriffith$elm_codegen$Elm$Annotation$named,
																	_List_Nil,
																	$author$project$Main$typifyName(name))
																]),
															$author$project$Gen$Json$Encode$annotation_.value),
														$author$project$Main$schemaToEncoder(
															$author$project$OpenApi$Schema$get(schema)));
												}).declaration
											]),
										res);
								}),
							_List_Nil,
							A2(
								$elm$core$Maybe$withDefault,
								$elm$core$Dict$empty,
								A2(
									$elm$core$Maybe$map,
									$author$project$OpenApi$Components$schemas,
									$author$project$OpenApi$components(apiSpec)))));
					var file = A2(
						$mdgriffith$elm_codegen$Elm$file,
						_List_fromArray(
							[namespace]),
						_Utils_ap(
							pathDeclarations,
							A2($elm$core$List$cons, $author$project$Main$nullableType, componentDeclarations)));
					return $author$project$Main$writeFile(
						_Utils_Tuple2(file.path, file.contents));
				}());
		} else {
			var err = _v1.a;
			return _Utils_Tuple2(
				model,
				$author$project$Main$writeMsg(
					$elm$json$Json$Decode$errorToString(err)));
		}
	});
var $elm$core$Platform$worker = _Platform_worker;
var $author$project$Main$main = $elm$core$Platform$worker(
	{init: $author$project$Main$init, subscriptions: $author$project$Main$subscriptions, update: $author$project$Main$update});
_Platform_export({'Main':{'init':$author$project$Main$main(
	$elm$json$Json$Decode$succeed(_Utils_Tuple0))(0)}});}(this));
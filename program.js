async function __qblib_lib_lang_system_bas() {
/* global constants: */ 
/* shared variables: */ 
/* static method variables: */ 
async function main() {

/* implicit variables: */ 
/* implicit variables: */ 
} await main();

async function func_Await(fn/*SINGLE*/,thisArg/*SINGLE*/) {
if (QB.halted()) { return; }; 
var Await = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return await fn.apply(thisArg, Array.prototype.slice.call(arguments, 2));
//-------- END JS native code block --------
return Await;
}
async function sub_Await(fn/*SINGLE*/,thisArg/*SINGLE*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    await fn.apply(thisArg, Array.prototype.slice.call(arguments, 2));
//-------- END JS native code block --------
}
async function func_Call(fn/*SINGLE*/,thisArg/*SINGLE*/) {
if (QB.halted()) { return; }; 
var Call = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return fn.apply(thisArg, Array.prototype.slice.call(arguments, 2));
//-------- END JS native code block --------
return Call;
}
async function sub_Call(fn/*SINGLE*/,thisArg/*SINGLE*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    fn.apply(thisArg, Array.prototype.slice.call(arguments, 2));
//-------- END JS native code block --------
}
async function func_Construct(className/*SINGLE*/,thisArg/*SINGLE*/) {
if (QB.halted()) { return; }; 
var Construct = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    if (thisArg == undefined) { thisArg = globalThis; }
    return Reflect.construct(thisArg[className], Array.prototype.slice.call(arguments, 2));
//-------- END JS native code block --------
return Construct;
}
async function func_TypeOf(o/*SINGLE*/) {
if (QB.halted()) { return; }; 
var TypeOf = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return typeof o;
//-------- END JS native code block --------
return TypeOf;
}
async function func_IsRunning() {
if (QB.halted()) { return; }; 
var IsRunning = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return QB.toBoolean(QB.running());
//-------- END JS native code block --------
return IsRunning;
}
async function sub_SetTimeout(fnCallback/*SUB*/,millis/*INTEGER*/) {
if (QB.halted()) { return; }; millis = Math.round(millis); 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        setTimeout(fnCallback, millis);
//-------- END JS native code block --------
}
async function func_TimeInMillis() {
if (QB.halted()) { return; }; 
var TimeInMillis = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return Date.now();
//-------- END JS native code block --------
return TimeInMillis;
}
async function func_ToInteger(value/*SINGLE*/) {
if (QB.halted()) { return; }; 
var ToInteger = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    var result = parseInt(value);
    if (isNaN(result)) {
        result = 0;
    }
    return result;
//-------- END JS native code block --------
return ToInteger;
}
async function func_ToFloat(value/*SINGLE*/) {
if (QB.halted()) { return; }; 
var ToFloat = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    var result = parseFloat(value);
    if (isNaN(result)) {
        result = 0;
    }
    return result;
//-------- END JS native code block --------
return ToFloat;
}
async function func_ToBoolean(value/*SINGLE*/) {
if (QB.halted()) { return; }; 
var ToBoolean = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return value ? -1 : 0;
//-------- END JS native code block --------
return ToBoolean;
}
async function func_ToString(value/*SINGLE*/) {
if (QB.halted()) { return; }; 
var ToString = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return `${value}`;
//-------- END JS native code block --------
return ToString;
}
return {
sub_Await: sub_Await,
func_Await: func_Await,
sub_Call: sub_Call,
func_Call: func_Call,
func_Construct: func_Construct,
func_IsRunning: func_IsRunning,
sub_SetTimeout: sub_SetTimeout,
func_TypeOf: func_TypeOf,
func_TimeInMillis: func_TimeInMillis,
func_ToFloat: func_ToFloat,
func_ToInteger: func_ToInteger,
func_ToBoolean: func_ToBoolean,
func_ToString: func_ToString,
};
}
async function __qblib_lib_lang_array_bas() {
/* global constants: */ 
/* shared variables: */ 
/* static method variables: */ 
async function main() {

/* implicit variables: */ 
/* implicit variables: */ 
} await main();

async function func_At(a/*OBJECT*/,index/*INTEGER*/) {
if (QB.halted()) { return; }; index = Math.round(index); 
var At = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return a.at(index);
//-------- END JS native code block --------
return At;
}
async function sub_Clear(a/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   a.length =  0;
}
async function func_Concat(a/*OBJECT*/) {
if (QB.halted()) { return; }; 
var Concat = null;
/* implicit variables: */ var a2 = 0;  /* SINGLE */ var a2 = QB.initArray([{l:0,u: 10}], 0);  /* SINGLE */ 
   var i = 0;  /* INTEGER */ var j = 0;  /* INTEGER */ var isArray = 0;  /* INTEGER */ 
   var ___v5334240 = 0; ___l7055475: for ( j=  1; (1 > 0) ? ( j <=  arguments.length -  1) : ( j >=  arguments.length -  1);  j+=1) { if (QB.halted()) { return; } ___v5334240++;   if (___v5334240 % 100 == 0) { await QB.autoLimit(); }
      a2 =  arguments[j];
      if ((await func_IsJSArray(  a2)) ) {
         //-------- BEGIN JS native code block --------
            a = a.concat(a2);
//-------- END JS native code block --------
      } else if ( a2._dimensions) {
         var i = 0;  /* INTEGER */ 
         var ___v2895625 = 0; ___l5795186: for ( i=  1; (1 > 0) ? ( i <= (QB.func_UBound(  a2))) : ( i >= (QB.func_UBound(  a2)));  i+=1) { if (QB.halted()) { return; } ___v2895625++;   if (___v2895625 % 100 == 0) { await QB.autoLimit(); }
            await sub_Push(  a,   QB.arrayValue(a2, [ i]).value);
         } 
      } else {
         await sub_Push(  a,    a2);
      }
   } 
   Concat =  a;
return Concat;
}
async function func_Create() {
if (QB.halted()) { return; }; 
var Create = null;
/* implicit variables: */ var a2 = 0;  /* SINGLE */ 
   var i = 0;  /* INTEGER */ 
   var a = {};  /* OBJECT */ 
   a =  [];
   var ___v7747401 = 0; ___l3019480: for ( i=  0; (1 > 0) ? ( i <=  arguments.length - 1) : ( i >=  arguments.length - 1);  i+=1) { if (QB.halted()) { return; } ___v7747401++;   if (___v7747401 % 100 == 0) { await QB.autoLimit(); }
      a2 =  arguments[i];;
      a = (await func_Concat(  a,    a2));
   } 
   Create =  a;
return Create;
}
async function func_Every(a/*OBJECT*/,fn/*FUNCTION*/) {
if (QB.halted()) { return; }; 
var Every = null;
/* implicit variables: */ 
   fn = (await func_PrepareCallback(  fn));
   //-------- BEGIN JS native code block --------
    return QB.toBoolean(a.every(fn));    
//-------- END JS native code block --------
return Every;
}
async function func_Fill(a/*OBJECT*/,value/*SINGLE*/,start/*SINGLE*/,end/*SINGLE*/) {
if (QB.halted()) { return; }; 
var Fill = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return a.fill(value, start, end);
//-------- END JS native code block --------
return Fill;
}
async function func_Filter(a/*OBJECT*/,fn/*FUNCTION*/) {
if (QB.halted()) { return; }; 
var Filter = null;
/* implicit variables: */ 
   fn = (await func_PrepareCallback(  fn));
   //-------- BEGIN JS native code block --------
    return a.filter(fn);
//-------- END JS native code block --------
return Filter;
}
async function func_IndexOf(a/*OBJECT*/,searchElement/*SINGLE*/,fromIndex/*SINGLE*/) {
if (QB.halted()) { return; }; 
var IndexOf = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return a.indexOf(searchElement, fromIndex);
//-------- END JS native code block --------
return IndexOf;
}
async function func_IsJSArray(a/*SINGLE*/) {
if (QB.halted()) { return; }; 
var IsJSArray = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return QB.toBoolean(Array.isArray(a));
//-------- END JS native code block --------
return IsJSArray;
}
async function func_IsQBArray(a/*SINGLE*/) {
if (QB.halted()) { return; }; 
var IsQBArray = null;
/* implicit variables: */ 
   var result = 0;  /* INTEGER */ 
   if ( a._dimensions) {
      result = Math.round(  -  1 );
   }
   IsQBArray =  result;
return IsQBArray;
}
async function sub_Insert(a/*OBJECT*/,index/*INTEGER*/) {
if (QB.halted()) { return; }; index = Math.round(index); 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    var values = Array.from(arguments).slice(2);
    a.splice(index, 0, values);
//-------- END JS native code block --------
}
async function func_Item(a/*OBJECT*/,index/*INTEGER*/) {
if (QB.halted()) { return; }; index = Math.round(index); 
var Item = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return a[index];
//-------- END JS native code block --------
return Item;
}
async function func_Join(a/*OBJECT*/,separator/*SINGLE*/) {
if (QB.halted()) { return; }; 
var Join = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return a.join(separator);
//-------- END JS native code block --------
return Join;
}
async function func_LastIndexOf(a/*OBJECT*/,searchElement/*SINGLE*/,fromIndex/*SINGLE*/) {
if (QB.halted()) { return; }; 
var LastIndexOf = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    if (fromIndex == undefined) { fromIndex = a.length; }
    return a.lastIndexOf(searchElement, fromIndex);
//-------- END JS native code block --------
return LastIndexOf;
}
async function func_Length(a/*OBJECT*/) {
if (QB.halted()) { return; }; 
var Length = null;
/* implicit variables: */ 
   Length =  0;
   if ( a.length) {
      Length =  a.length;
   }
return Length;
}
async function func_Pop(a/*OBJECT*/) {
if (QB.halted()) { return; }; 
var Pop = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return a.pop();
//-------- END JS native code block --------
return Pop;
}
async function sub_Push(a/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var i = 0;  /* INTEGER */ 
   var ___v7607236 = 0; ___l140176: for ( i=  1; (1 > 0) ? ( i <=  arguments.length -  1) : ( i >=  arguments.length -  1);  i+=1) { if (QB.halted()) { return; } ___v7607236++;   if (___v7607236 % 100 == 0) { await QB.autoLimit(); }
      //-------- BEGIN JS native code block --------
        a.push(arguments[i]);
//-------- END JS native code block --------
   } 
}
async function func_Reduce(a/*OBJECT*/,fn/*FUNCTION*/,initialValue/*SINGLE*/) {
if (QB.halted()) { return; }; 
var Reduce = null;
/* implicit variables: */ 
   fn = (await func_PrepareCallback(  fn));
   //-------- BEGIN JS native code block --------
    if (initialValue == undefined) { 
        return a.reduce(fn);
    }
    else {
        return a.reduce(fn, initialValue);
    }
//-------- END JS native code block --------
return Reduce;
}
async function func_ReduceRight(a/*OBJECT*/,fn/*FUNCTION*/,initialValue/*SINGLE*/) {
if (QB.halted()) { return; }; 
var ReduceRight = null;
/* implicit variables: */ 
   fn = (await func_PrepareCallback(  fn));
   //-------- BEGIN JS native code block --------
    if (initialValue == undefined) { 
        return a.reduceRight(fn);
    }
    else {
        return a.reduceRight(fn, initialValue);
    }
//-------- END JS native code block --------
return ReduceRight;
}
async function sub_Remove(a/*OBJECT*/,start/*SINGLE*/,deleteCount/*SINGLE*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   if ( deleteCount ==   undefined) {
      deleteCount =  1;
   }
   //-------- BEGIN JS native code block --------
    a.splice(start, deleteCount);
//-------- END JS native code block --------
}
async function sub_Reverse(a/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    a.reverse();
//-------- END JS native code block --------
}
async function func_Shift(a/*OBJECT*/) {
if (QB.halted()) { return; }; 
var Shift = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return a.shift();
//-------- END JS native code block --------
return Shift;
}
async function func_Slice(a/*SINGLE*/,start/*SINGLE*/,end/*SINGLE*/) {
if (QB.halted()) { return; }; 
var Slice = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return a.slice(start, end);
//-------- END JS native code block --------
return Slice;
}
async function sub_Sort(a/*OBJECT*/,sortFn/*FUNCTION*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   if ( sortFn !=   undefined) {
      sortFn = (await func_PrepareCallback(  sortFn));
   }
   //-------- BEGIN JS native code block --------
    a.sort(sortFn);
//-------- END JS native code block --------
}
async function sub_Splice(a/*OBJECT*/,index/*INTEGER*/,deleteCount/*SINGLE*/) {
if (QB.halted()) { return; }; index = Math.round(index); 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    var values = Array.from(arguments).slice(3);
    a.splice(index, deleteCount, values);
//-------- END JS native code block --------
}
async function sub_Unshift(a/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var i = 0;  /* INTEGER */ 
   var ___v7090379 = 0; ___l8144900: for ( i=  arguments.length -  1; ( - 1 > 0) ? ( i <=  1) : ( i >=  1);  i+= - 1) { if (QB.halted()) { return; } ___v7090379++;   if (___v7090379 % 100 == 0) { await QB.autoLimit(); }
      //-------- BEGIN JS native code block --------
        a.unshift(arguments[i]);
//-------- END JS native code block --------
   } 
}
async function func_ToQBArray(a/*OBJECT*/) {
if (QB.halted()) { return; }; 
var ToQBArray = null;
/* implicit variables: */ 
   var qbArray = QB.initArray([{l:0,u: a.length}], 0);  /* SINGLE */ 
   var i = 0;  /* INTEGER */ 
   var ___v4140327 = 0; ___l453528: for ( i=  1; (1 > 0) ? ( i <=  a.length) : ( i >=  a.length);  i+=1) { if (QB.halted()) { return; } ___v4140327++;   if (___v4140327 % 100 == 0) { await QB.autoLimit(); }
      QB.arrayValue(qbArray, [ i]).value =  a[i - 1];
   } 
   ToQBArray =  qbArray;
return ToQBArray;
}
async function func_PrepareCallback(fn/*FUNCTION*/) {
if (QB.halted()) { return; }; 
var PrepareCallback = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    var fs = fn.toString();
    var pstart = fs.indexOf("(")
    var pend = fs.indexOf(")")
    var paramstr = fs.substring(pstart+1, pend-1);
    var params = paramstr.split(",");
    for (var i=0; i < params.length; i++) {
        var idx = params[i].indexOf("/");
        params[i] = params[i].substring(0, idx);
    }
    var bstart = fs.indexOf("{");
    var bend = fs.lastIndexOf("}");
    var body = fs.substring(bstart+1, bend-1);
    if      (params.length == 1) { return new Function(params[0], body); }
    else if (params.length == 2) { return new Function(params[0], params[1], body); }
    else if (params.length == 3) { return new Function(params[0], params[1], params[2], body); }
    else if (params.length == 4) { return new Function(params[0], params[1], params[2], params[3], body); }
//-------- END JS native code block --------
return PrepareCallback;
}
return {
func_At: func_At,
sub_Clear: sub_Clear,
func_Concat: func_Concat,
func_Create: func_Create,
func_Every: func_Every,
func_Fill: func_Fill,
func_Filter: func_Filter,
func_IndexOf: func_IndexOf,
sub_Insert: sub_Insert,
func_Item: func_Item,
func_IsJSArray: func_IsJSArray,
func_IsQBArray: func_IsQBArray,
func_Join: func_Join,
func_LastIndexOf: func_LastIndexOf,
func_Length: func_Length,
func_Pop: func_Pop,
sub_Add: sub_Push,
sub_Push: sub_Push,
func_Reduce: func_Reduce,
func_ReduceRight: func_ReduceRight,
sub_Remove: sub_Remove,
sub_Reverse: sub_Reverse,
func_Shift: func_Shift,
func_Slice: func_Slice,
sub_Sort: sub_Sort,
sub_Splice: sub_Splice,
sub_Unshift: sub_Unshift,
func_ToQBArray: func_ToQBArray,
};
}
async function __qblib_lib_lang_string_bas() {
var Sys = await __qblib_lib_lang_system_bas();
var JSArray = await __qblib_lib_lang_array_bas();
/* global constants: */ 
/* shared variables: */ 
/* static method variables: */ 
async function main() {

/* implicit variables: */ 
/* implicit variables: */ 
} await main();

async function func_EndsWith(s/*STRING*/,searchStr/*STRING*/) {
if (QB.halted()) { return; }; 
var EndsWith = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   EndsWith = (await Sys.func_ToBoolean( (await Sys.func_Call(  s.endsWith,    s,    searchStr))));
return EndsWith;
}
async function func_FormatUsing() {
if (QB.halted()) { return; }; 
var FormatUsing = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    return QB.formatUsing.apply(QB, arguments);
//-------- END JS native code block --------
return FormatUsing;
}
async function func_Includes(s/*STRING*/,searchStr/*STRING*/) {
if (QB.halted()) { return; }; 
var Includes = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   Includes = (await Sys.func_ToBoolean( (await Sys.func_Call(  s.includes,    s,    searchStr))));
return Includes;
}
async function func_Match(s/*STRING*/,regex/*STRING*/,g/*OBJECT*/) {
if (QB.halted()) { return; }; 
var Match = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   var jsresult = {};  /* OBJECT */ 
   //-------- BEGIN JS native code block --------
        if (g == undefined) { g = 0; }
        jsresult = [];
        var matches = s.matchAll(new RegExp(regex, "g"));
        for (m of matches) {
            var value = null;
            if (typeof g == "string") { value = m.groups[g]; }
            else { value = m[g]; }
            if (value) { jsresult.push(value); }
        }
//-------- END JS native code block --------
   Match = (await JSArray.func_ToQBArray(  jsresult));
return Match;
}
async function sub_Match(s/*STRING*/,regex/*STRING*/,result/*STRING*/,g/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   result = (await func_Match(  s,    regex,    g));
}
async function func_PadEnd(s/*STRING*/,targetLength/*INTEGER*/,padStr/*STRING*/) {
if (QB.halted()) { return; }; targetLength = Math.round(targetLength); 
var PadEnd = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   PadEnd = (await Sys.func_Call(  s.padEnd,    s,    targetLength,    padStr));
return PadEnd;
}
async function func_PadStart(s/*STRING*/,targetLength/*INTEGER*/,padStr/*STRING*/) {
if (QB.halted()) { return; }; targetLength = Math.round(targetLength); 
var PadStart = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   PadStart = (await Sys.func_Call(  s.padStart,    s,    targetLength,    padStr));
return PadStart;
}
async function func_Replace(s/*STRING*/,searchStr/*STRING*/,replaceStr/*STRING*/,regex/*INTEGER*/) {
if (QB.halted()) { return; }; regex = Math.round(regex); 
var Replace = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   if ( regex) {
      Replace = (await Sys.func_Call(  s.replace,    s,   (await Sys.func_Construct( "RegExp" , undefined,    searchStr,   "g")) ,    replaceStr));
   } else {
      Replace = (await Sys.func_Call(  s.replaceAll,    s,    searchStr,    replaceStr));
   }
return Replace;
}
async function func_Search(s/*STRING*/,regex/*STRING*/) {
if (QB.halted()) { return; }; 
var Search = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   Search = (await Sys.func_Call(  s.search,    s,   (await Sys.func_Construct( "RegExp" , undefined,    regex,   "g"))))  +  1;
return Search;
}
async function func_Split(s/*STRING*/,delimiter/*STRING*/,regex/*INTEGER*/) {
if (QB.halted()) { return; }; regex = Math.round(regex); 
var Split = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   if ( delimiter ==   undefined) {
      delimiter = ",";
   }
   var jsresult = {};  /* OBJECT */ 
   if ( regex) {
      jsresult = (await Sys.func_Call(  s.split,    s,   (await Sys.func_Construct( "RegExp" , undefined,    delimiter,   "g"))));
   } else {
      jsresult = (await Sys.func_Call(  s.split,    s,    delimiter));
   }
   Split = (await JSArray.func_ToQBArray(  jsresult));
return Split;
}
async function sub_Split(s/*STRING*/,delimiter/*STRING*/,result/*STRING*/,regex/*INTEGER*/) {
if (QB.halted()) { return; }; regex = Math.round(regex); 
/* implicit variables: */ 
   var temp = QB.initArray([{l:0,u: 0}], 0);  /* SINGLE */ 
   temp = (await func_Split(  s,    delimiter,    regex));
   var i = 0;  /* INTEGER */ 
   QB.resizeArray(result, [{l:0,u:(QB.func_UBound(  temp))}], 0, false);  /* SINGLE */ 
   var ___v7904800 = 0; ___l8626193: for ( i=  1; (1 > 0) ? ( i <= (QB.func_UBound(  temp))) : ( i >= (QB.func_UBound(  temp)));  i+=1) { if (QB.halted()) { return; } ___v7904800++;   if (___v7904800 % 100 == 0) { await QB.autoLimit(); }
      QB.arrayValue(result, [ i]).value = QB.arrayValue(temp, [ i]).value;
   } 
}
async function func_StartsWith(s/*STRING*/,searchStr/*STRING*/) {
if (QB.halted()) { return; }; 
var StartsWith = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   StartsWith = (await Sys.func_ToBoolean( (await Sys.func_Call(  s.startsWith,    s,    searchStr))));
return StartsWith;
}
async function func_Trim(s/*STRING*/) {
if (QB.halted()) { return; }; 
var Trim = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   Trim = (await Sys.func_Call(  s.trim,    s));
return Trim;
}
async function func_TrimEnd(s/*STRING*/) {
if (QB.halted()) { return; }; 
var TrimEnd = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   TrimEnd = (await Sys.func_Call(  s.trimEnd,    s));
return TrimEnd;
}
async function func_TrimStart(s/*STRING*/) {
if (QB.halted()) { return; }; 
var TrimStart = null;
/* implicit variables: */ 
   s = (await Sys.func_ToString(  s));
   TrimStart = (await Sys.func_Call(  s.trimStart,    s));
return TrimStart;
}
return {
func_FormatUsing: func_FormatUsing,
func_EndsWith: func_EndsWith,
func_Includes: func_Includes,
sub_Match: sub_Match,
func_Match: func_Match,
func_PadEnd: func_PadEnd,
func_PadStart: func_PadStart,
func_Replace: func_Replace,
func_Search: func_Search,
sub_Split: sub_Split,
func_Split: func_Split,
func_StartsWith: func_StartsWith,
func_Trim: func_Trim,
func_TrimEnd: func_TrimEnd,
func_TrimStart: func_TrimStart,
};
}
async function __qblib_lib_web_dom_bas() {
var SYS = await __qblib_lib_lang_system_bas();
var JSArray = await __qblib_lib_lang_array_bas();
/* global constants: */ 
/* shared variables: */ 
/* static method variables: */ 
async function main() {

/* implicit variables: */ 
   var e = {};  /* OBJECT */ 
   if ( QB._domElements) {
      e = (await JSArray.func_Pop(  QB._domElements));
      var ___v9619532 = 0; ___l3735362: while ( e) { if (QB.halted()) { return; }___v9619532++;   if (___v9619532 % 100 == 0) { await QB.autoLimit(); }
         await sub_Remove(  e);
         e = (await JSArray.func_Pop(  QB._domElements));
      }
   } else {
      QB._domElements = await JSArray.func_Create();
   }
   if ( QB._domEvents) {
      e = (await JSArray.func_Pop(  QB._domEvents));
      var ___v562369 = 0; ___l8714458: while ( e) { if (QB.halted()) { return; }___v562369++;   if (___v562369 % 100 == 0) { await QB.autoLimit(); }
         await SYS.sub_Call(  e.target.removeEventListener,    e.target,    e.eventType,    e.callbackFn);
         e = (await JSArray.func_Pop(  QB._domEvents));
      }
   } else {
      QB._domEvents = await JSArray.func_Create();
   }
/* implicit variables: */ 
} await main();

async function sub_Alert(text/*STRING*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   await SYS.sub_Call(  window.alert, undefined,    text);
}
async function func_Confirm(text/*STRING*/) {
if (QB.halted()) { return; }; 
var Confirm = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        Confirm = QB.toBoolean(confirm(text));
//-------- END JS native code block --------
return Confirm;
}
async function sub_Add(e/*OBJECT*/,parent/*OBJECT*/,beforeElement/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   if ((await SYS.func_TypeOf(  e))  ==  "string" ) {
      e = (await SYS.func_Call(  document.getElementById,   await func_Document(),    e));
   }
   if ( parent ==   undefined ||  parent ==  "" ) {
      parent = await func_Container();
   }
   if ((await SYS.func_TypeOf(  parent))  ==  "string" ) {
      parent = (await SYS.func_Call(  document.getElementById,   await func_Document(),    parent));
   }
   if ( beforeElement ==  "" ) {
      beforeElement =  undefined;
   }
   if ((await SYS.func_TypeOf(  beforeElement))  ==  "string" ) {
      beforeElement = (await SYS.func_Call(  document.getElementById,   await func_Document(),    beforeElement));
   }
   await SYS.sub_Call(  parent.insertBefore,    parent,    e,    beforeElement);
}
async function func_Create(etype/*STRING*/,parent/*OBJECT*/,content/*STRING*/,eid/*STRING*/,beforeElement/*OBJECT*/) {
if (QB.halted()) { return; }; 
var Create = null;
/* implicit variables: */ 
   var e = {};  /* OBJECT */ 
   e = (await SYS.func_Call(  document.createElement,   await func_Document(),    etype));
   if ( eid !=   undefined &&  eid !=  "" ) {
      e.id =  eid;
   }
   e.className = "qbjs";
   if ( content !=   undefined) {
      if ( e.value !=   undefined) {
         e.value =  content;
      }
      if ( e.innerHTML !=   undefined) {
         e.innerHTML =  content;
      }
   }
   await SYS.sub_Call(  QB._domElements.push,    QB._domElements,    e);
   await sub_Add(  e,    parent,    beforeElement);
   Create =  e;
return Create;
}
async function sub_Create(etype/*STRING*/,parent/*OBJECT*/,content/*STRING*/,eid/*STRING*/,beforeElement/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var e = {};  /* OBJECT */ 
   e = (await func_Create(  etype,    parent,    content,    eid,    beforeElement));
}
async function sub_Event(target/*OBJECT*/,eventType/*STRING*/,callbackFn/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        if (typeof target == "string") {
            target = document.getElementById(target);
        }
        var callbackWrapper = async function(event) {
            var result = await callbackFn(event);
            if (result == false) {
                event.preventDefault();
            }
            return result;
        }
        target.addEventListener(eventType, callbackWrapper);
        QB._domEvents.push({ target: target, eventType: eventType, callbackFn: callbackWrapper});
//-------- END JS native code block --------
}
async function func_Container() {
if (QB.halted()) { return; }; 
var Container = null;
/* implicit variables: */ 
   Container = (await func_Get( "gx-container"));
return Container;
}
async function func_Window() {
if (QB.halted()) { return; }; 
var Window = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        return window;
//-------- END JS native code block --------
return Window;
}
async function func_Document() {
if (QB.halted()) { return; }; 
var Document = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        return document;
//-------- END JS native code block --------
return Document;
}
async function func_Get(eid/*STRING*/) {
if (QB.halted()) { return; }; 
var Get = null;
/* implicit variables: */ 
   Get = (await SYS.func_Call(  document.getElementById,   await func_Document(),    eid));
return Get;
}
async function func_GetAttribute(e/*OBJECT*/,attributeName/*STRING*/) {
if (QB.halted()) { return; }; 
var GetAttribute = null;
/* implicit variables: */ 
   if ((await SYS.func_TypeOf(  e))  ==  "string" ) {
      e = (await SYS.func_Call(  document.getElementById,   await func_Document(),    e));
   }
   GetAttribute = (await SYS.func_Call(  e.getAttribute,    e,    attributeName));
return GetAttribute;
}
async function sub_SetAttribute(e/*OBJECT*/,attributeName/*STRING*/,attributeValue/*STRING*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   if ((await SYS.func_TypeOf(  e))  ==  "string" ) {
      e = (await SYS.func_Call(  document.getElementById,   await func_Document(),    e));
   }
   await SYS.sub_Call(  e.setAttribute,    e,    attributeName,    attributeValue);
}
async function func_GetAttributeNames(e/*OBJECT*/) {
if (QB.halted()) { return; }; 
var GetAttributeNames = null;
/* implicit variables: */ 
   if ((await SYS.func_TypeOf(  e))  ==  "string" ) {
      e = (await SYS.func_Call(  document.getElementById,   await func_Document(),    e));
   }
   GetAttributeNames = (await JSArray.func_ToQBArray( (await SYS.func_Call(  e.getAttributeNames,    e))));
return GetAttributeNames;
}
async function func_GetElementsByClassName(className/*STRING*/,e/*OBJECT*/) {
if (QB.halted()) { return; }; 
var GetElementsByClassName = null;
/* implicit variables: */ 
   if ( e ==   undefined) {
      e = await func_Document();
   } else if ((await SYS.func_TypeOf(  e))  ==  "string" ) {
      e = (await SYS.func_Call(  document.getElementById,   await func_Document(),    e));
   }
   var elements = {};  /* OBJECT */ 
   elements = (await SYS.func_Call(  e.getElementsByClassName,    e,    className));
   GetElementsByClassName = (await JSArray.func_ToQBArray(  elements));
return GetElementsByClassName;
}
async function func_GetImage(imageId/*INTEGER*/) {
if (QB.halted()) { return; }; imageId = Math.round(imageId); 
var GetImage = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        GetImage = QB.getImage(imageId);
//-------- END JS native code block --------
return GetImage;
}
async function sub_Remove(e/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   if ((await SYS.func_TypeOf(  e))  ==  "string" ) {
      e = (await SYS.func_Call(  document.getElementById,   await func_Document(),    e));
   }
   await SYS.sub_Call(  e.remove,    e);
}
async function func_Prompt(text/*STRING*/,defaultValue/*STRING*/) {
if (QB.halted()) { return; }; 
var Prompt = null;
/* implicit variables: */ 
   var result = '';  /* STRING */ 
   result = (await SYS.func_Call(  window.prompt, undefined,    text,    defaultValue));
   if (! result) {
      result = "";
   }
   Prompt =  result;
return Prompt;
}
async function sub_DialogClose(element/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   await SYS.sub_Call(  element.close,    element);
}
async function sub_DialogShowModal(element/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   await SYS.sub_Call(  element.showModal,    element);
}
async function sub_DialogShow(element/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   await SYS.sub_Call(  element.show,    element);
}
async function sub_Focus(element/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   await SYS.sub_Call(  element.focus,    element);
}
async function func_HasFocus(element/*OBJECT*/) {
if (QB.halted()) { return; }; 
var HasFocus = null;
/* implicit variables: */ 
   HasFocus = (await SYS.func_ToBoolean(  document.activeElement ==   element));
return HasFocus;
}
async function sub_SelectAll(element/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   await SYS.sub_Call(  element.select,    element);
}
async function sub_RequestFullscreen(element/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   await SYS.sub_Call(  element.requestFullscreen,    element);
}
async function sub_StopPropagation(e/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   await SYS.sub_Call(  e.stopPropagation,    e);
}
async function sub_RequestAnimationFrame(fnCallback/*SUB*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   await SYS.sub_Call(  window.requestAnimationFrame, undefined,    fnCallback);
}
return {
sub_Add: sub_Add,
sub_Alert: sub_Alert,
func_Confirm: func_Confirm,
sub_Create: sub_Create,
func_Create: func_Create,
sub_Event: sub_Event,
func_Container: func_Container,
func_Get: func_Get,
func_GetImage: func_GetImage,
sub_Remove: sub_Remove,
func_GetAttribute: func_GetAttribute,
sub_SetAttribute: sub_SetAttribute,
func_GetAttributeNames: func_GetAttributeNames,
func_GetElementsByClassName: func_GetElementsByClassName,
func_Prompt: func_Prompt,
sub_DialogClose: sub_DialogClose,
sub_DialogShowModal: sub_DialogShowModal,
sub_DialogShow: sub_DialogShow,
sub_Focus: sub_Focus,
func_HasFocus: func_HasFocus,
sub_SelectAll: sub_SelectAll,
sub_RequestFullscreen: sub_RequestFullscreen,
sub_StopPropagation: sub_StopPropagation,
sub_RequestAnimationFrame: sub_RequestAnimationFrame,
func_Document: func_Document,
func_Window: func_Window,
};
}
var Dom = await __qblib_lib_web_dom_bas();
var String = await __qblib_lib_lang_string_bas();
/* global constants: */ const BASE_URL  =   "?src=https://raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples/"; 
/* shared variables: */ var amap = QB.initArray([0], {}); var cmap = QB.initArray([0], {}); var alist = QB.initArray([0], ''); var clist = QB.initArray([0], ''); var lastSelected = ''; var baseImgUrl = ''; var panel = {}; var header = {}; var headerTitle = {}; var slist = {}; var filter = {}; var collapse = {}; var server = {}; var spanel = {}; var iframe = {}; 
/* static method variables: */ 
async function main() {
QB.start(); QB.setTypeMap({ GXPOSITION:[{ name: 'x', type: 'LONG' }, { name: 'y', type: 'LONG' }], GXDEVICEINPUT:[{ name: 'deviceId', type: 'INTEGER' }, { name: 'deviceType', type: 'INTEGER' }, { name: 'inputType', type: 'INTEGER' }, { name: 'inputId', type: 'INTEGER' }, { name: 'inputValue', type: 'INTEGER' }], FETCHRESPONSE:[{ name: 'ok', type: 'INTEGER' }, { name: 'status', type: 'INTEGER' }, { name: 'statusText', type: 'STRING' }, { name: 'text', type: 'STRING' }]});
    await GX.registerGameEvents(function(e){});
    QB.sub_Screen(0);

/* implicit variables: */ 
   QB.resizeArray(amap, [], {}, false);  /* OBJECT */ QB.resizeArray(cmap, [], {}, false);  /* OBJECT */ 
   QB.resizeArray(alist, [{l:0,u: 0}], '', false);  /* STRING */ QB.resizeArray(clist, [{l:0,u: 0}], '', false);  /* STRING */ 
   lastSelected = '';  /* STRING */ baseImgUrl = '';  /* STRING */ 
   baseImgUrl = "/qbjs/";
   if ( document.location.pathname ==  "/" ) {
      baseImgUrl = "";
   }
   var o = {};  /* OBJECT */ 
   o = (await Dom.func_GetImage(  0));
   o.style.display = "none";
   o = await Dom.func_Container();
   o.style.textAlign = "left";
   o.style.overflow = "hidden";
   o.style.fontFamily = "arial, helvetica, sans-serif";
   o.style.fontSize = "14px";
   var style = {};  /* OBJECT */ 
   style = (await Dom.func_Create( "style"));
   style.innerText = "a, a:visited { color: rgb(69, 118, 147); }";
   panel = {};  /* OBJECT */ 
   panel = (await Dom.func_Create( "div"));
   panel.style.display = "grid";
   panel.style.gridTemplateColumns = "300px auto";
   var lpanel = {};  /* OBJECT */ 
   header = {};  /* OBJECT */ headerTitle = {};  /* OBJECT */ 
   lpanel = (await Dom.func_Create( "div" ,    panel));
   header = (await Dom.func_Create( "div" ,    lpanel));
   header.style.display = "grid";
   header.style.gridTemplateColumns = "auto auto 25px";
   headerTitle = (await Dom.func_Create( "div" ,    header,   "<b>QBJS Samples</b>"));
   headerTitle.style.margin = "6px";
   slist = {};  /* OBJECT */ 
   slist = (await Dom.func_Create( "ul" ,    lpanel));
   slist.style.overflowY = "auto";
   slist.style.marginTop = "0px";
   await sub_GetSamples();
   await sub_SortList(  slist);
   filter = {};  /* OBJECT */ 
   filter = (await Dom.func_Create( "select" ,    header));
   filter.style.marginTop = "5px";
   filter.style.marginBottom = "5px";
   await Dom.sub_Event(  filter,   "change" ,    sub_OnChangeFilter);
   var opt = {};  /* OBJECT */ var grpc = {};  /* OBJECT */ var grpa = {};  /* OBJECT */ 
   opt = (await Dom.func_Create( "option" ,    filter,   "Filter - Show All"));
   opt.value = "*ALL*";
   grpc = (await Dom.func_Create( "optgroup" ,    filter));
   grpc.label = "Category";
   grpa = (await Dom.func_Create( "optgroup" ,    filter));
   grpa.label = "Author";
   var i = 0;  /* INTEGER */ 
   var ___v3640187 = 0; ___l9495566: for ( i=  1; (1 > 0) ? ( i <= (QB.func_UBound(  clist))) : ( i >= (QB.func_UBound(  clist)));  i+=1) { if (QB.halted()) { return; } ___v3640187++;   if (___v3640187 % 100 == 0) { await QB.autoLimit(); }
      opt = (await Dom.func_Create( "option" ,    grpc,   QB.arrayValue(clist, [ i]).value));
      opt.ftype = "category";
      opt.value = QB.arrayValue(clist, [ i]).value;
   } 
   var ___v7671117 = 0; ___l5248684: for ( i=  1; (1 > 0) ? ( i <= (QB.func_UBound(  alist))) : ( i >= (QB.func_UBound(  alist)));  i+=1) { if (QB.halted()) { return; } ___v7671117++;   if (___v7671117 % 100 == 0) { await QB.autoLimit(); }
      opt = (await Dom.func_Create( "option" ,    grpa,   QB.arrayValue(alist, [ i]).value));
      opt.ftype = "author";
      opt.value = QB.arrayValue(alist, [ i]).value;
   } 
   collapse = {};  /* OBJECT */ 
   collapse = (await Dom.func_Create( "img" ,    header));
   collapse.src =  baseImgUrl + "img/slide-left.svg";
   collapse.style.width = "20px";
   collapse.style.height = "20px";
   collapse.style.marginLeft = "5px";
   collapse.style.marginTop = "5px";
   collapse.style.cursor = "pointer";
   collapse.title = "Hide Samples List";
   collapse.isCollapsed =  0;
   await Dom.sub_Event(  collapse,   "click" ,    sub_OnToggleList);
   var rpanel = {};  /* OBJECT */ 
   rpanel = (await Dom.func_Create( "div" ,    panel));
   server = {};  /* OBJECT */ spanel = {};  /* OBJECT */ 
   spanel = (await Dom.func_Create( "div" ,    rpanel));
   spanel.style.position = "absolute";
   spanel.style.right = "145px";
   spanel.style.top = "11px";
   await Dom.sub_Create( "span" ,    spanel,   "Server: ");
   server = (await Dom.func_Create( "select" ,    spanel));
   await Dom.sub_Event(  server,   "change" ,    sub_OnChangeServer);
   opt = (await Dom.func_Create( "option" ,    server,   "Production (qbjs.org)"));
   opt.value = "https://qbjs.org";
   opt = (await Dom.func_Create( "option" ,    server,   "Development (github.io)"));
   opt.value = "https://boxgaming.github.io/qbjs/";
   iframe = {};  /* OBJECT */ 
   iframe = (await Dom.func_Create( "iframe" ,    rpanel));
   iframe.style.width = "100%";
   iframe.style.height = (QB.func__ResizeHeight())  + "px";
   iframe.frameBorder = "0";
   iframe.src =  server.value;
   var win = {};  /* OBJECT */ 
   //-------- BEGIN JS native code block --------
    win = window
//-------- END JS native code block --------
   await Dom.sub_Event(  win,   "resize" ,    sub_OnResize);
   await sub_FireResize();
   var h = '';  /* STRING */ 
   h =  document.location.hash;
   if ( h) {
      var parts = QB.initArray([], '');  /* STRING */ 
      await String.sub_Split(  h,   "=" ,    parts);
      if ((QB.func_UBound(  parts))  ==   2) {
         if (QB.arrayValue(parts, [ 1]).value  ==  "#src" ) {
            iframe.src =  server.value +  BASE_URL + QB.arrayValue(parts, [ 2]).value;
         } else if (QB.arrayValue(parts, [ 1]).value  ==  "#author"  | QB.arrayValue(parts, [ 1]).value  ==  "#category" ) {
            var selectedValue = '';  /* STRING */ 
            selectedValue = QB.arrayValue(parts, [ 2]).value;
            //-------- BEGIN JS native code block --------
                filter.value = decodeURI(selectedValue)
                filter.dispatchEvent(new Event("change"));
//-------- END JS native code block --------
         }
      }
   }
/* implicit variables: */ 
QB.end();
} await main();

async function sub_GetSamples() {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var filename = '';  /* STRING */ var path = '';  /* STRING */ var pname = '';  /* STRING */ var author = '';  /* STRING */ var desc = '';  /* STRING */ var categories = '';  /* STRING */ var ts = '';  /* STRING */ 
   ts = (QB.func_Str( QB.func_Timer()));
   filename = "https://raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples.txt?ts="  +  ts;
   await QB.sub_Open(filename, QB.INPUT, 1);
   var ___v5924582 = 0; ___l535045: while (~(QB.func_EOF(  1))) { if (QB.halted()) { return; }___v5924582++;   if (___v5924582 % 100 == 0) { await QB.autoLimit(); }
      var ___v4687001 = new Array( 5); await QB.sub_InputFromFile(1, ___v4687001);    path = ___v4687001[ 0];    pname = ___v4687001[ 1];    author = ___v4687001[ 2];    desc = ___v4687001[ 3];    categories = ___v4687001[ 4]; 
      var li = {};  /* OBJECT */ var a = {};  /* OBJECT */ 
      li = (await Dom.func_Create( "li" ,    slist));
      a = (await Dom.func_Create( "a" ,    li,    pname));
      a.href = "#src="  +  path;
      a.samplePath =  path;
      a.categories =  categories;
      li.sortName =  pname;
      a.title = "Author:"  + (QB.func_Chr(  10))  +  author + (QB.func_Chr(  10))  + (QB.func_Chr(  10))  + "Categories: "  + (QB.func_Chr(  10))  +  categories + (QB.func_Chr(  10))  + (QB.func_Chr(  10))  + "Description:"  + (QB.func_Chr(  10))  +  desc;
      await Dom.sub_Event(  a,   "click" ,    sub_OnClickSample);
      await sub_MapAuthors(  author,    li);
      await sub_MapCategories(  categories,    li);
   }
   QB.sub_Close(1);
   QB.sub_Kill( "/raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples.txt?ts="  +  ts);
}
async function sub_OnResize() {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   iframe.style.height = (QB.func__ResizeHeight())  + "px";
   slist.style.height = (QB.func__ResizeHeight() -  45)  + "px";
}
async function sub_OnClickSample(event/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   iframe.src =  server.value +  BASE_URL +  event.target.samplePath;
   lastSelected =  event.target.samplePath;
}
async function sub_OnChangeServer(event/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var url = '';  /* STRING */ 
   url =  server.value;
   if ( lastSelected) {
      url =  url +  BASE_URL +  lastSelected;
   }
   iframe.src =  url;
}
async function sub_OnChangeFilter(event/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var opt = {};  /* OBJECT */ 
   opt =  filter.options[filter.selectedIndex];
   if ( opt.value ==  "*ALL*" ) {
      await sub_SetVisible(  - 1);
      return;
   }
   await sub_SetVisible(  0);
   var o = {};  /* OBJECT */ 
   if ( opt.ftype ==  "author" ) {
      location.hash = "author="  +  opt.value;
      o = QB.arrayValue(amap, [ opt.value]).value;
   } else {
      location.hash = "category="  +  opt.value;
      o = QB.arrayValue(cmap, [ opt.value]).value;
   }
   var i = 0;  /* INTEGER */ 
   var ___v6226967 = 0; ___l2981654: for ( i=  0; (1 > 0) ? ( i <=  o.length -  1) : ( i >=  o.length -  1);  i+=1) { if (QB.halted()) { return; } ___v6226967++;   if (___v6226967 % 100 == 0) { await QB.autoLimit(); }
      o[i].style.display = "list-item";
   } 
}
async function sub_OnToggleList() {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   if ( collapse.isCollapsed) {
      collapse.src =  baseImgUrl + "img/slide-left.svg";
      collapse.title = "Hide Samples List";
      headerTitle.style.display = "block";
      filter.style.display = "inline";
      slist.style.display = "block";
      panel.style.gridTemplateColumns = "300px auto";
   } else {
      collapse.src =  baseImgUrl + "img/slide-right.svg";
      collapse.title = "Show Samples List";
      headerTitle.style.display = "none";
      filter.style.display = "none";
      slist.style.display = "none";
      panel.style.gridTemplateColumns = "30px auto";
   }
   collapse.isCollapsed = ~ collapse.isCollapsed;
}
async function sub_SetVisible(visible/*INTEGER*/) {
if (QB.halted()) { return; }; visible = Math.round(visible); 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    var child = slist.firstChild;
    while (child) {
        child.style.display = visible ? "list-item": "none";
        child = child.nextSibling;
    }
//-------- END JS native code block --------
}
async function sub_MapAuthors(authors/*STRING*/,li/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var aarray = QB.initArray([{l:0,u: 0}], '');  /* STRING */ 
   await String.sub_Split(  authors,   "," ,   aarray);
   var ai = 0;  /* INTEGER */ 
   var ___v2637929 = 0; ___l6478212: for ( ai=  1; (1 > 0) ? ( ai <= (QB.func_UBound(  aarray))) : ( ai >= (QB.func_UBound(  aarray)));  ai+=1) { if (QB.halted()) { return; } ___v2637929++;   if (___v2637929 % 100 == 0) { await QB.autoLimit(); }
      var author = '';  /* STRING */ 
      author = (QB.func__Trim( QB.arrayValue(aarray, [ ai]).value));
      var o = {};  /* OBJECT */ 
      o = QB.arrayValue(amap, [ author]).value;
      //-------- BEGIN JS native code block --------
            if (o == undefined || o.length == undefined) {
                o = [];
            }
            o.push(li);
//-------- END JS native code block --------
      QB.arrayValue(amap, [ author]).value =  o;
      var found = 0;  /* INTEGER */ var i = 0;  /* INTEGER */ 
      var ___v8298016 = 0; ___l2793421: for ( i=  1; (1 > 0) ? ( i <= (QB.func_UBound(  alist))) : ( i >= (QB.func_UBound(  alist)));  i+=1) { if (QB.halted()) { return; } ___v8298016++;   if (___v8298016 % 100 == 0) { await QB.autoLimit(); }
         if (QB.arrayValue(alist, [ i]).value  ==   author) {
            found = Math.round(  - 1 );
            break ___l2793421;
         }
      } 
      if (~ found) {
         i = Math.round( (QB.func_UBound(  alist))  +  1 );
         QB.resizeArray(alist, [{l:0,u: i}], '', true);  /* STRING */ 
         QB.arrayValue(alist, [ i]).value =  author;
      }
   } 
   await sub_SortArray(  alist);
}
async function sub_MapCategories(categories/*STRING*/,li/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var carray = QB.initArray([{l:0,u: 0}], '');  /* STRING */ 
   await String.sub_Split(  categories,   "," ,   carray);
   var ci = 0;  /* INTEGER */ 
   var ___v5891630 = 0; ___l8246021: for ( ci=  1; (1 > 0) ? ( ci <= (QB.func_UBound(  carray))) : ( ci >= (QB.func_UBound(  carray)));  ci+=1) { if (QB.halted()) { return; } ___v5891630++;   if (___v5891630 % 100 == 0) { await QB.autoLimit(); }
      var category = '';  /* STRING */ 
      category = (QB.func__Trim( QB.arrayValue(carray, [ ci]).value));
      var o = {};  /* OBJECT */ 
      o = QB.arrayValue(cmap, [ category]).value;
      //-------- BEGIN JS native code block --------
            if (o == undefined || o.length == undefined) {
                o = [];
            }
            o.push(li);
//-------- END JS native code block --------
      QB.arrayValue(cmap, [ category]).value =  o;
      var found = 0;  /* INTEGER */ var i = 0;  /* INTEGER */ 
      var ___v9109643 = 0; ___l9860932: for ( i=  1; (1 > 0) ? ( i <= (QB.func_UBound(  clist))) : ( i >= (QB.func_UBound(  clist)));  i+=1) { if (QB.halted()) { return; } ___v9109643++;   if (___v9109643 % 100 == 0) { await QB.autoLimit(); }
         if (QB.arrayValue(clist, [ i]).value  ==   category) {
            found = Math.round(  - 1 );
            break ___l9860932;
         }
      } 
      if (~ found) {
         i = Math.round( (QB.func_UBound(  clist))  +  1 );
         QB.resizeArray(clist, [{l:0,u: i}], '', true);  /* STRING */ 
         QB.arrayValue(clist, [ i]).value =  category;
      }
   } 
   await sub_SortArray(  clist);
}
async function sub_SortArray(qbarray/*STRING*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var array = {};  /* OBJECT */ 
   //-------- BEGIN JS native code block --------
        array = [];
//-------- END JS native code block --------
   var i = 0;  /* INTEGER */ 
   var ___v6951155 = 0; ___l2268660: for ( i=  1; (1 > 0) ? ( i <= (QB.func_UBound(  qbarray))) : ( i >= (QB.func_UBound(  qbarray)));  i+=1) { if (QB.halted()) { return; } ___v6951155++;   if (___v6951155 % 100 == 0) { await QB.autoLimit(); }
      var o = {};  /* OBJECT */ 
      o = QB.arrayValue(qbarray, [ i]).value;
      //-------- BEGIN JS native code block --------
            array.push(o);
//-------- END JS native code block --------
   } 
   //-------- BEGIN JS native code block --------
        array.sort(function (a, b) {
            return a.toLowerCase().localeCompare(b.toLowerCase());
        });
//-------- END JS native code block --------
   var ___v2439314 = 0; ___l9800032: for ( i=  0; (1 > 0) ? ( i <=  array.length -  1) : ( i >=  array.length -  1);  i+=1) { if (QB.halted()) { return; } ___v2439314++;   if (___v2439314 % 100 == 0) { await QB.autoLimit(); }
      QB.arrayValue(qbarray, [ i + 1]).value =  array[i];
   } 
}
async function sub_SortList(list/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    var i, switching, b, shouldSwitch;
    switching = true;
    while (switching) {
        switching = false;
        b = list.getElementsByTagName("LI");
        for (i = 0; i < (b.length - 1); i++) {
            shouldSwitch = false;
            if (b[i].sortName.toLowerCase().localeCompare(b[i + 1].sortName.toLowerCase()) > 0) {
                shouldSwitch = true;
                break;
            }
        }
        if (shouldSwitch) {
            b[i].parentNode.insertBefore(b[i + 1], b[i]);
            switching = true;
        }
    }
//-------- END JS native code block --------
}
async function sub_FireResize() {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    window.dispatchEvent(new Event("resize"));
//-------- END JS native code block --------
}

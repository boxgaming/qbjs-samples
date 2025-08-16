async function __qbjs_run() {
async function _Dom() {
/* global constants: */ 
/* shared variables: */ 
/* static method variables: */ 
async function main() {

/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
    if (QB._domElements) {
        var e = null;    
        while (e = QB._domElements.pop()) {
            e.remove();
        }
    }
    else { 
        QB._domElements = []; 
    }
    if (QB._domEvents) {
        while (e = QB._domEvents.pop()) {
            e.target.removeEventListener(e.eventType, e.callbackFn);
        }
    }
    else {
        QB._domEvents = [];
    }
//-------- END JS native code block --------
} await main();

async function sub_Alert(text/*STRING*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        alert(text);
//-------- END JS native code block --------
}
async function func_Confirm(text/*STRING*/) {
if (QB.halted()) { return; }; 
var Confirm = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        Confirm = confirm(text) ? -1 : 0;
//-------- END JS native code block --------
return Confirm;
}
async function sub_Add(e/*OBJECT*/,parent/*OBJECT*/,beforeElement/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        if (typeof e == "string") {
            e = document.getElementById(e);
        }
        if (parent == undefined || parent == "") {
            parent = await func_Container(); 
        }
        else if (typeof parent == "string") {
            parent = document.getElementById(parent);
        }
        if (beforeElement == undefined || beforeElement == "") {
            beforeElement = null;
        }
        else if (typeof beforeElement == "string") {
            beforeElement = document.getElementById(beforeElement);
        }
        parent.insertBefore(e, beforeElement);
//-------- END JS native code block --------
}
async function func_Create(etype/*STRING*/,parent/*OBJECT*/,content/*STRING*/,eid/*STRING*/,beforeElement/*OBJECT*/) {
if (QB.halted()) { return; }; 
var Create = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        var e = document.createElement(etype); 
        if (eid != undefined && eid != "") {
            e.id = eid;
        }
        e.className = "qbjs";
        if (content != undefined) {
            if (e.value != undefined) {
                e.value = content;
            }
            if (e.innerHTML != undefined) {
                e.innerHTML = content;
            }
        }
        QB._domElements.push(e);
        await sub_Add(e, parent, beforeElement);
        Create = e;
//-------- END JS native code block --------
return Create;
}
async function sub_Create(etype/*STRING*/,parent/*OBJECT*/,content/*STRING*/,eid/*STRING*/,beforeElement/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var e = 0;  /* SINGLE */ 
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
   //-------- BEGIN JS native code block --------
        Container = document.getElementById("gx-container");
//-------- END JS native code block --------
return Container;
}
async function func_Get(eid/*STRING*/) {
if (QB.halted()) { return; }; 
var Get = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        Get = document.getElementById(eid);
//-------- END JS native code block --------
return Get;
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
   //-------- BEGIN JS native code block --------
        if (typeof e == "string") {
            e = document.getElementById(e);
        }
        if (e != undefined && e != null) {
            e.remove();
        }
//-------- END JS native code block --------
}
async function func_Prompt(text/*STRING*/,defaultValue/*STRING*/) {
if (QB.halted()) { return; }; 
var Prompt = null;
/* implicit variables: */ 
   var result = '';  /* STRING */ 
   //-------- BEGIN JS native code block --------
        result = prompt(text, defaultValue);
        if (!result) { result = ""; }
//-------- END JS native code block --------
   Prompt =  result;;
return Prompt;
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
func_Prompt: func_Prompt,
};
}
const Dom = await _Dom();
async function _String() {
/* global constants: */ 
/* shared variables: */ 
/* static method variables: */ 
async function main() {

/* implicit variables: */ 
} await main();

async function func_EndsWith(s/*STRING*/,searchStr/*STRING*/) {
if (QB.halted()) { return; }; 
var EndsWith = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        EndsWith = QB.toBoolean(s.endsWith(searchStr));
//-------- END JS native code block --------
return EndsWith;
}
async function func_Includes(s/*STRING*/,searchStr/*STRING*/) {
if (QB.halted()) { return; }; 
var Includes = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        Includes = QB.toBoolean(s.includes(searchStr));
//-------- END JS native code block --------
return Includes;
}
async function sub_Match(s/*STRING*/,regex/*STRING*/,result/*STRING*/,g/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
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
   await sub_ToQBArray(  jsresult,    result);
}
async function func_PadEnd(s/*STRING*/,targetLength/*INTEGER*/,padStr/*STRING*/) {
if (QB.halted()) { return; }; targetLength = Math.round(targetLength); 
var PadEnd = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        PadEnd = s.padEnd(targetLength, padStr);
//-------- END JS native code block --------
return PadEnd;
}
async function func_PadStart(s/*STRING*/,targetLength/*INTEGER*/,padStr/*STRING*/) {
if (QB.halted()) { return; }; targetLength = Math.round(targetLength); 
var PadStart = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        PadStart = s.padStart(targetLength, padStr);
//-------- END JS native code block --------
return PadStart;
}
async function func_Replace(s/*STRING*/,searchStr/*STRING*/,replaceStr/*STRING*/,regex/*INTEGER*/) {
if (QB.halted()) { return; }; regex = Math.round(regex); 
var Replace = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        if (regex) {
            Replace = s.replace(new RegExp(searchStr, "g"), replaceStr);
        }
        else {
            Replace = s.replaceAll(searchStr, replaceStr);
        }
//-------- END JS native code block --------
return Replace;
}
async function sub_ToQBArray(jsArray/*OBJECT*/,result/*STRING*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var i = 0;  /* SINGLE */ var part = '';  /* STRING */ 
   if ( jsArray) {
      QB.resizeArray(result, [{l:0,u:jsArray.length}], '', false);  /* STRING */ 
      var ___v5334240 = 0; ___l7055475: for ( i=  1 ;  i <=  jsArray.length;  i= i + 1) { if (QB.halted()) { return; } ___v5334240++;   if (___v5334240 % 100 == 0) { await QB.autoLimit(); }
         //-------- BEGIN JS native code block --------
                part = jsArray[i-1];
//-------- END JS native code block --------
         QB.arrayValue(result, [ i]).value =  part;
      } 
   } else {
      QB.resizeArray(result, [{l:0,u:0}], '', false);  /* STRING */ 
   }
}
async function func_Search(s/*STRING*/,regex/*STRING*/) {
if (QB.halted()) { return; }; 
var Search = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        Search = s.search(new RegExp(regex, "g")) + 1;
//-------- END JS native code block --------
return Search;
}
async function sub_Split(s/*STRING*/,delimiter/*STRING*/,result/*STRING*/,regex/*INTEGER*/) {
if (QB.halted()) { return; }; regex = Math.round(regex); 
/* implicit variables: */ 
   var jsresult = {};  /* OBJECT */ 
   //-------- BEGIN JS native code block --------
        if (regex) {
            jsresult = s.split(new RegExp(delimiter, "g"));
        }
        else {
            jsresult = s.split(delimiter);
        }
//-------- END JS native code block --------
   await sub_ToQBArray(  jsresult,    result);
}
async function func_StartsWith(s/*STRING*/,searchStr/*STRING*/) {
if (QB.halted()) { return; }; 
var StartsWith = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        StartsWith = QB.toBoolean(s.startsWith(searchStr));
//-------- END JS native code block --------
return StartsWith;
}
async function func_TrimEnd(s/*STRING*/) {
if (QB.halted()) { return; }; 
var TrimEnd = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        TrimEnd = s.trimEnd();
//-------- END JS native code block --------
return TrimEnd;
}
async function func_TrimStart(s/*STRING*/) {
if (QB.halted()) { return; }; 
var TrimStart = null;
/* implicit variables: */ 
   //-------- BEGIN JS native code block --------
        TrimStart = s.trimStart();
//-------- END JS native code block --------
return TrimStart;
}
return {
func_EndsWith: func_EndsWith,
func_Includes: func_Includes,
sub_Match: sub_Match,
func_PadEnd: func_PadEnd,
func_PadStart: func_PadStart,
func_Replace: func_Replace,
func_Search: func_Search,
sub_Split: sub_Split,
func_StartsWith: func_StartsWith,
func_TrimEnd: func_TrimEnd,
func_TrimStart: func_TrimStart,
};
}
const String = await _String();
/* global constants: */ const BASE_URL  =   "?src=https://raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples/"; 
/* shared variables: */ var amap = QB.initArray([0], {}); var cmap = QB.initArray([0], {}); var alist = QB.initArray([0], ''); var clist = QB.initArray([0], ''); var lastSelected = ''; var baseImgUrl = ''; var panel = {}; var header = {}; var headerTitle = {}; var slist = {}; var filter = {}; var collapse = {}; var server = {}; var spanel = {}; var iframe = {}; 
/* static method variables: */ 
async function main() {
QB.start(); QB.setTypeMap({ GXPOSITION:[{ name: 'x', type: 'LONG' }, { name: 'y', type: 'LONG' }], GXDEVICEINPUT:[{ name: 'deviceId', type: 'INTEGER' }, { name: 'deviceType', type: 'INTEGER' }, { name: 'inputType', type: 'INTEGER' }, { name: 'inputId', type: 'INTEGER' }, { name: 'inputValue', type: 'INTEGER' }], FETCHRESPONSE:[{ name: 'ok', type: 'INTEGER' }, { name: 'status', type: 'INTEGER' }, { name: 'statusText', type: 'STRING' }, { name: 'text', type: 'STRING' }]});
    await GX.registerGameEvents(function(e){});
    QB.sub_Screen(0);

/* implicit variables: */ 
   QB.resizeArray(amap, [], {}, false);  /* OBJECT */ QB.resizeArray(cmap, [], {}, false);  /* OBJECT */ 
   QB.resizeArray(alist, [{l:0,u:0}], '', false);  /* STRING */ QB.resizeArray(clist, [{l:0,u:0}], '', false);  /* STRING */ 
   lastSelected = '';  /* STRING */ baseImgUrl = '';  /* STRING */ 
   baseImgUrl = "/qbjs/";
   if ( document.location.pathname ==  "/"  ) {
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
   lpanel = (await Dom.func_Create( "div"  ,    panel));
   header = (await Dom.func_Create( "div"  ,    lpanel));
   header.style.display = "grid";
   header.style.gridTemplateColumns = "auto auto 25px";
   headerTitle = (await Dom.func_Create( "div"  ,    header,   "<b>QBJS Samples</b>"));
   headerTitle.style.margin = "6px";
   slist = {};  /* OBJECT */ 
   slist = (await Dom.func_Create( "ul"  ,    lpanel));
   slist.style.overflowY = "auto";
   slist.style.marginTop = "0px";
   await sub_GetSamples();
   await sub_SortList(  slist);
   filter = {};  /* OBJECT */ 
   filter = (await Dom.func_Create( "select"  ,    header));
   filter.style.marginTop = "5px";
   filter.style.marginBottom = "5px";
   await Dom.sub_Event(  filter,   "change"  ,    sub_OnChangeFilter);
   var opt = {};  /* OBJECT */ var grpc = {};  /* OBJECT */ var grpa = {};  /* OBJECT */ 
   opt = (await Dom.func_Create( "option"  ,    filter,   "Filter - Show All"));
   opt.value = "*ALL*";
   grpc = (await Dom.func_Create( "optgroup"  ,    filter));
   grpc.label = "Category";
   grpa = (await Dom.func_Create( "optgroup"  ,    filter));
   grpa.label = "Author";
   var i = 0;  /* INTEGER */ 
   var ___v2895625 = 0; ___l5795186: for ( i=  1 ;  i <= (QB.func_UBound(  clist));  i= i + 1) { if (QB.halted()) { return; } ___v2895625++;   if (___v2895625 % 100 == 0) { await QB.autoLimit(); }
      opt = (await Dom.func_Create( "option"  ,    grpc,   QB.arrayValue(clist, [ i]).value));
      opt.ftype = "category";
      opt.value = QB.arrayValue(clist, [ i]).value;
   } 
   var ___v7747401 = 0; ___l3019480: for ( i=  1 ;  i <= (QB.func_UBound(  alist));  i= i + 1) { if (QB.halted()) { return; } ___v7747401++;   if (___v7747401 % 100 == 0) { await QB.autoLimit(); }
      opt = (await Dom.func_Create( "option"  ,    grpa,   QB.arrayValue(alist, [ i]).value));
      opt.ftype = "author";
      opt.value = QB.arrayValue(alist, [ i]).value;
   } 
   collapse = {};  /* OBJECT */ 
   collapse = (await Dom.func_Create( "img"  ,    header));
   collapse.src =  baseImgUrl + "img/slide-left.svg";
   collapse.style.width = "20px";
   collapse.style.height = "20px";
   collapse.style.marginLeft = "5px";
   collapse.style.marginTop = "5px";
   collapse.style.cursor = "pointer";
   collapse.title = "Hide Samples List";
   collapse.isCollapsed =  0;
   await Dom.sub_Event(  collapse,   "click"  ,    sub_OnToggleList);
   var rpanel = {};  /* OBJECT */ 
   rpanel = (await Dom.func_Create( "div"  ,    panel));
   server = {};  /* OBJECT */ spanel = {};  /* OBJECT */ 
   spanel = (await Dom.func_Create( "div"  ,    rpanel));
   spanel.style.position = "absolute";
   spanel.style.right = "145px";
   spanel.style.top = "11px";
   await Dom.sub_Create( "span"  ,    spanel,   "Server: ");
   server = (await Dom.func_Create( "select"  ,    spanel));
   await Dom.sub_Event(  server,   "change"  ,    sub_OnChangeServer);
   opt = (await Dom.func_Create( "option"  ,    server,   "Production (qbjs.org)"));
   opt.value = "https://qbjs.org";
   opt = (await Dom.func_Create( "option"  ,    server,   "Development (github.io)"));
   opt.value = "https://boxgaming.github.io/qbjs/";
   iframe = {};  /* OBJECT */ 
   iframe = (await Dom.func_Create( "iframe"  ,    rpanel));
   iframe.style.width = "100%";
   iframe.style.height = (QB.func__ResizeHeight())  + "px";
   iframe.frameBorder = "0";
   iframe.src =  server.value;
   var win = {};  /* OBJECT */ 
   //-------- BEGIN JS native code block --------
    win = window
//-------- END JS native code block --------
   await Dom.sub_Event(  win,   "resize"  ,    sub_OnResize);
   await sub_FireResize();
   var h = '';  /* STRING */ 
   h =  document.location.hash;
   if ( h) {
      var parts = QB.initArray([], '');  /* STRING */ 
      await String.sub_Split(  h,   "="  ,    parts);
      if ((QB.func_UBound(  parts))  ==   2 ) {
         if (QB.arrayValue(parts, [ 1]).value  ==  "#src"  ) {
            iframe.src =  server.value +  BASE_URL + QB.arrayValue(parts, [ 2]).value;
         } else if (QB.arrayValue(parts, [ 1]).value  ==  "#author"  | QB.arrayValue(parts, [ 1]).value  ==  "#category"  ) {
            var selectedValue = '';  /* STRING */ 
            selectedValue = QB.arrayValue(parts, [ 2]).value;
            //-------- BEGIN JS native code block --------
                filter.value = decodeURI(selectedValue)
                filter.dispatchEvent(new Event("change"));
//-------- END JS native code block --------
         }
      }
   }
QB.end();
} await main();

async function sub_GetSamples() {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var filename = '';  /* STRING */ var path = '';  /* STRING */ var pname = '';  /* STRING */ var author = '';  /* STRING */ var desc = '';  /* STRING */ var categories = '';  /* STRING */ var ts = '';  /* STRING */ 
   ts = (QB.func_Str( QB.func_Timer()));
   filename = "https://raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples.txt?ts="  +  ts;
   await QB.sub_Open(filename, QB.INPUT, 1);
   var ___v7607236 = 0; ___l140176: while (~(QB.func_EOF(  1))) { if (QB.halted()) { return; }___v7607236++;   if (___v7607236 % 100 == 0) { await QB.autoLimit(); }
      var ___v8144900 = new Array( 5); await QB.sub_InputFromFile(1, ___v8144900);    path = ___v8144900[ 0];    pname = ___v8144900[ 1];    author = ___v8144900[ 2];    desc = ___v8144900[ 3];    categories = ___v8144900[ 4]; 
      var li = {};  /* OBJECT */ var a = {};  /* OBJECT */ 
      li = (await Dom.func_Create( "li"  ,    slist));
      a = (await Dom.func_Create( "a"  ,    li,    pname));
      a.href = "#src="  +  path;
      a.samplePath =  path;
      a.categories =  categories;
      li.sortName =  pname;
      a.title = "Author:"  + (QB.func_Chr(  10))  +  author + (QB.func_Chr(  10))  + (QB.func_Chr(  10))  + "Categories: "  + (QB.func_Chr(  10))  +  categories + (QB.func_Chr(  10))  + (QB.func_Chr(  10))  + "Description:"  + (QB.func_Chr(  10))  +  desc;
      await Dom.sub_Event(  a,   "click"  ,    sub_OnClickSample);
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
   if ( opt.value ==  "*ALL*"  ) {
      await sub_SetVisible(  - 1);
      return;
   }
   await sub_SetVisible(  0);
   var o = {};  /* OBJECT */ 
   if ( opt.ftype ==  "author"  ) {
      location.hash = "author="  +  opt.value;
      o = QB.arrayValue(amap, [ opt.value]).value;
   } else {
      location.hash = "category="  +  opt.value;
      o = QB.arrayValue(cmap, [ opt.value]).value;
   }
   var i = 0;  /* INTEGER */ 
   var ___v453528 = 0; ___l7090379: for ( i=  0 ;  i <=  o.length -  1;  i= i + 1) { if (QB.halted()) { return; } ___v453528++;   if (___v453528 % 100 == 0) { await QB.autoLimit(); }
      o[i].style.display = "list-item";
   } 
}
async function sub_OnToggleList() {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   if ( collapse.isCollapsed ) {
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
   var aarray = QB.initArray([{l:0,u:0}], '');  /* STRING */ 
   await String.sub_Split(  authors,   ","  ,   aarray);
   var ai = 0;  /* INTEGER */ 
   var ___v8626193 = 0; ___l4140327: for ( ai=  1 ;  ai <= (QB.func_UBound(  aarray));  ai= ai + 1) { if (QB.halted()) { return; } ___v8626193++;   if (___v8626193 % 100 == 0) { await QB.autoLimit(); }
      var author = '';  /* STRING */ 
      author = QB.arrayValue(aarray, [ ai]).value;
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
      var ___v3735362 = 0; ___l7904800: for ( i=  1 ;  i <= (QB.func_UBound(  alist));  i= i + 1) { if (QB.halted()) { return; } ___v3735362++;   if (___v3735362 % 100 == 0) { await QB.autoLimit(); }
         if (QB.arrayValue(alist, [ i]).value  ==   author) {
            found =  - 1;
            break ___l7904800;
         }
      } 
      if (~ found) {
         i = (QB.func_UBound(  alist))  +  1;
         QB.resizeArray(alist, [{l:0,u:i}], '', true);  /* STRING */ 
         QB.arrayValue(alist, [ i]).value =  author;
      }
   } 
   await sub_SortArray(  alist);
}
async function sub_MapCategories(categories/*STRING*/,li/*OBJECT*/) {
if (QB.halted()) { return; }; 
/* implicit variables: */ 
   var carray = QB.initArray([{l:0,u:0}], '');  /* STRING */ 
   await String.sub_Split(  categories,   ","  ,   carray);
   var ci = 0;  /* INTEGER */ 
   var ___v8714458 = 0; ___l9619532: for ( ci=  1 ;  ci <= (QB.func_UBound(  carray));  ci= ci + 1) { if (QB.halted()) { return; } ___v8714458++;   if (___v8714458 % 100 == 0) { await QB.autoLimit(); }
      var category = '';  /* STRING */ 
      category = QB.arrayValue(carray, [ ci]).value;
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
      var ___v9495566 = 0; ___l562369: for ( i=  1 ;  i <= (QB.func_UBound(  clist));  i= i + 1) { if (QB.halted()) { return; } ___v9495566++;   if (___v9495566 % 100 == 0) { await QB.autoLimit(); }
         if (QB.arrayValue(clist, [ i]).value  ==   category) {
            found =  - 1;
            break ___l562369;
         }
      } 
      if (~ found) {
         i = (QB.func_UBound(  clist))  +  1;
         QB.resizeArray(clist, [{l:0,u:i}], '', true);  /* STRING */ 
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
   var ___v5248684 = 0; ___l3640187: for ( i=  1 ;  i <= (QB.func_UBound(  qbarray));  i= i + 1) { if (QB.halted()) { return; } ___v5248684++;   if (___v5248684 % 100 == 0) { await QB.autoLimit(); }
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
   var ___v535045 = 0; ___l7671117: for ( i=  0 ;  i <=  array.length -  1;  i= i + 1) { if (QB.halted()) { return; } ___v535045++;   if (___v535045 % 100 == 0) { await QB.autoLimit(); }
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

}
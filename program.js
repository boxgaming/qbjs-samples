async function __qbjs_run() {
async function _Dom() {
/* static method variables: */ 

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

async function sub_Alert(text/*STRING*/) {
if (QB.halted()) { return; }; 
   //-------- BEGIN JS native code block --------
        alert(text);
//-------- END JS native code block --------
}
async function func_Confirm(text/*STRING*/) {
if (QB.halted()) { return; }; 
var Confirm = null;
   //-------- BEGIN JS native code block --------
        Confirm = confirm(text) ? -1 : 0;
//-------- END JS native code block --------
return Confirm;
}
async function sub_Add(e/*OBJECT*/,parent/*OBJECT*/,beforeElement/*OBJECT*/) {
if (QB.halted()) { return; }; 
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
   var e = 0;  /* SINGLE */ 
   e =  (await func_Create(  etype,    parent,    content,    eid,    beforeElement));
}
async function sub_Event(target/*OBJECT*/,eventType/*STRING*/,callbackFn/*OBJECT*/) {
if (QB.halted()) { return; }; 
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
   //-------- BEGIN JS native code block --------
        Container = document.getElementById("gx-container");
//-------- END JS native code block --------
return Container;
}
async function func_Get(eid/*STRING*/) {
if (QB.halted()) { return; }; 
var Get = null;
   //-------- BEGIN JS native code block --------
        Get = document.getElementById(eid);
//-------- END JS native code block --------
return Get;
}
async function func_GetImage(imageId/*INTEGER*/) {
if (QB.halted()) { return; }; imageId = Math.round(imageId); 
var GetImage = null;
   //-------- BEGIN JS native code block --------
        GetImage = QB.getImage(imageId);
//-------- END JS native code block --------
return GetImage;
}
async function sub_Remove(e/*OBJECT*/) {
if (QB.halted()) { return; }; 
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
   var result = '';  /* STRING */ 
   //-------- BEGIN JS native code block --------
        result = prompt(text, defaultValue);
        if (!result) { result = ""; }
//-------- END JS native code block --------
   Prompt =   result;;
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
/* static method variables: */ 
QB.start(); QB.setTypeMap({ GXPOSITION:[{ name: 'x', type: 'LONG' }, { name: 'y', type: 'LONG' }], GXDEVICEINPUT:[{ name: 'deviceId', type: 'INTEGER' }, { name: 'deviceType', type: 'INTEGER' }, { name: 'inputType', type: 'INTEGER' }, { name: 'inputId', type: 'INTEGER' }, { name: 'inputValue', type: 'INTEGER' }], FETCHRESPONSE:[{ name: 'ok', type: 'INTEGER' }, { name: 'status', type: 'INTEGER' }, { name: 'statusText', type: 'STRING' }, { name: 'text', type: 'STRING' }]});
    await GX.registerGameEvents(function(e){});
    QB.sub_Screen(0);

   const BASE_URL  =   "?src=https://raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples/"; 
   var amap = QB.initArray([], {});  /* OBJECT */ var cmap = QB.initArray([], {});  /* OBJECT */ 
   var alist = QB.initArray([{l:0,u:0}], '');  /* STRING */ var clist = QB.initArray([{l:0,u:0}], '');  /* STRING */ 
   var lastSelected = '';  /* STRING */ 
   var o = {};  /* OBJECT */ 
   o =  (await Dom.func_GetImage(  0));
   o.style.display =  "none";
   o =  await Dom.func_Container();
   o.style.textAlign =  "left";
   o.style.overflow =  "hidden";
   o.style.fontFamily =  "arial, helvetica, sans-serif";
   o.style.fontSize =  "14px";
   var style = {};  /* OBJECT */ 
   style =  (await Dom.func_Create( "style"));
   style.innerText =  "a, a:visited { color: rgb(69, 118, 147); }";
   var panel = {};  /* OBJECT */ 
   panel =  (await Dom.func_Create( "div"));
   panel.style.display =  "grid";
   panel.style.gridTemplateColumns =  "300px auto";
   var lpanel = {};  /* OBJECT */ var header = {};  /* OBJECT */ 
   lpanel =  (await Dom.func_Create( "div"  ,    panel));
   header =  (await Dom.func_Create( "div"  ,    lpanel));
   header.style.display =  "grid";
   header.style.gridTemplateColumns =  "auto auto";
   header.style.padding =  "10px";
   await Dom.sub_Create( "div"  ,    header,   "<b>QBJS Samples</b>");
   var slist = {};  /* OBJECT */ 
   slist =  (await Dom.func_Create( "ul"  ,    lpanel));
   slist.style.overflowY =  "auto";
   slist.style.marginTop =  "0px";
   await sub_GetSamples();
   await sub_SortList(  slist);
   var filter = {};  /* OBJECT */ 
   filter =  (await Dom.func_Create( "select"  ,    header));
   await Dom.sub_Event(  filter,   "change"  ,    sub_OnChangeFilter);
   var opt = {};  /* OBJECT */ var grpc = {};  /* OBJECT */ var grpa = {};  /* OBJECT */ 
   opt =  (await Dom.func_Create( "option"  ,    filter,   "Filter - Show All"));
   opt.value =  "*ALL*";
   grpc =  (await Dom.func_Create( "optgroup"  ,    filter));
   grpc.label =  "Category";
   grpa =  (await Dom.func_Create( "optgroup"  ,    filter));
   grpa.label =  "Author";
   var i = 0;  /* INTEGER */ 
   var ___v7641413 = 0; ___l0: for ( i=  1 ;  i <= (QB.func_UBound(  clist));  i= i + 1) { if (QB.halted()) { return; } ___v7641413++;   if (___v7641413 % 100 == 0) { await QB.autoLimit(); }
      opt =  (await Dom.func_Create( "option"  ,    grpc,   QB.arrayValue(clist, [ i]).value));
      opt.ftype =  "category";
      opt.value =  QB.arrayValue(clist, [ i]).value;
   } 
   var ___v1068624 = 0; ___l3576428: for ( i=  1 ;  i <= (QB.func_UBound(  alist));  i= i + 1) { if (QB.halted()) { return; } ___v1068624++;   if (___v1068624 % 100 == 0) { await QB.autoLimit(); }
      opt =  (await Dom.func_Create( "option"  ,    grpa,   QB.arrayValue(alist, [ i]).value));
      opt.ftype =  "author";
      opt.value =  QB.arrayValue(alist, [ i]).value;
   } 
   var rpanel = {};  /* OBJECT */ 
   rpanel =  (await Dom.func_Create( "div"  ,    panel));
   var server = {};  /* OBJECT */ 
   var spanel = {};  /* OBJECT */ 
   spanel =  (await Dom.func_Create( "div"  ,    rpanel));
   spanel.style.position =  "absolute";
   spanel.style.right =  "145px";
   spanel.style.top =  "11px";
   await Dom.sub_Create( "span"  ,    spanel,   "Server: ");
   server =  (await Dom.func_Create( "select"  ,    spanel));
   await Dom.sub_Event(  server,   "change"  ,    sub_OnChangeServer);
   opt =  (await Dom.func_Create( "option"  ,    server,   "Production (qbjs.org)"));
   opt.value =  "https://qbjs.org";
   opt =  (await Dom.func_Create( "option"  ,    server,   "Development (github.io)"));
   opt.value =  "https://boxgaming.github.io/qbjs/";
   var iframe = {};  /* OBJECT */ 
   iframe =  (await Dom.func_Create( "iframe"  ,    rpanel));
   iframe.style.width =  "100%";
   iframe.style.height =  (QB.func__ResizeHeight())  + "px";
   iframe.frameBorder =  "0";
   iframe.src =   server.value;
   await Dom.sub_Event(  window ,   "resize"  ,    sub_OnResize);
   await sub_FireResize();
QB.end();

async function sub_GetSamples() {
if (QB.halted()) { return; }; 
   var filename = '';  /* STRING */ var path = '';  /* STRING */ var pname = '';  /* STRING */ var author = '';  /* STRING */ var desc = '';  /* STRING */ var categories = '';  /* STRING */ var ts = '';  /* STRING */ 
   ts =  (QB.func_Str( QB.func_Timer()));
   filename =  "https://raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples.txt?ts="  +  ts;
   await QB.sub_Open(filename, QB.INPUT, 1);
   var ___v480418 = 0; ___l7075312: while (~(QB.func_EOF(  1))) { if (QB.halted()) { return; }___v480418++;   if (___v480418 % 100 == 0) { await QB.autoLimit(); }
      var ___v5364588 = new Array(5); await QB.sub_InputFromFile(1, ___v5364588);    path = ___v5364588[0];    pname = ___v5364588[1];    author = ___v5364588[2];    desc = ___v5364588[3];    categories = ___v5364588[4]; 
      var li = {};  /* OBJECT */ var a = {};  /* OBJECT */ 
      li =  (await Dom.func_Create( "li"  ,    slist));
      a =  (await Dom.func_Create( "a"  ,    li,    pname));
      a.href =  "#"  +  path;
      a.samplePath =   path;
      a.categories =   categories;
      a.title =  "Author:"  + (QB.func_Chr(  10))  +  author + (QB.func_Chr(  10))  + (QB.func_Chr(  10))  + "Categories: "  + (QB.func_Chr(  10))  +  categories + (QB.func_Chr(  10))  + (QB.func_Chr(  10))  + "Description:"  + (QB.func_Chr(  10))  +  desc;
      await Dom.sub_Event(  a,   "click"  ,    sub_OnClickSample);
      await sub_MapAuthors(  author,    li);
      await sub_MapCategories(  categories,    li);
   }
   QB.sub_Close(1);
   QB.sub_Kill( "/raw.githubusercontent.com/boxgaming/qbjs-samples/refs/heads/main/samples.txt?ts="  +  ts);
}
async function sub_OnResize() {
if (QB.halted()) { return; }; 
   iframe.style.height =  (QB.func__ResizeHeight())  + "px";
   slist.style.height =  (QB.func__ResizeHeight() -  45)  + "px";
}
async function sub_OnClickSample(event/*OBJECT*/) {
if (QB.halted()) { return; }; 
   iframe.src =   server.value +  BASE_URL +  event.target.samplePath;
   lastSelected =   event.target.samplePath;
}
async function sub_OnChangeServer(event/*OBJECT*/) {
if (QB.halted()) { return; }; 
   var url = '';  /* STRING */ 
   url =   server.value;
   if ( lastSelected) {
      url =   url +  BASE_URL +  lastSelected;
   }
   iframe.src =   url;
}
async function sub_OnChangeFilter(event/*OBJECT*/) {
if (QB.halted()) { return; }; 
   var opt = {};  /* OBJECT */ 
   opt =   filter.options[filter.selectedIndex];
   if ( opt.value ==  "*ALL*"  ) {
      await sub_SetVisible(  - 1);
      return;
   }
   await sub_SetVisible(  0);
   var o = {};  /* OBJECT */ 
   if ( opt.ftype ==  "author"  ) {
      o =  QB.arrayValue(amap, [ opt.value]).value;
   } else {
      o =  QB.arrayValue(cmap, [ opt.value]).value;
   }
   var i = 0;  /* INTEGER */ 
   var ___v6161923 = 0; ___l7288614: for ( i=  0 ;  i <=  o.length -  1;  i= i + 1) { if (QB.halted()) { return; } ___v6161923++;   if (___v6161923 % 100 == 0) { await QB.autoLimit(); }
      o[i].style.display =  "list-item";
   } 
}
async function sub_Split(sourceString/*STRING*/,delimiter/*STRING*/,results/*STRING*/) {
if (QB.halted()) { return; }; 
   var sarray = {};  /* OBJECT */ 
   //-------- BEGIN JS native code block --------
        sarray = sourceString.split(delimiter);
//-------- END JS native code block --------
   var i = 0;  /* INTEGER */ 
   var s = '';  /* STRING */ 
   QB.resizeArray(results, [{l:0,u:sarray.length}], '', false);  /* STRING */ 
   var ___v4082566 = 0; ___l2480838: for ( i=  0 ;  i <=  sarray.length +  1;  i= i + 1) { if (QB.halted()) { return; } ___v4082566++;   if (___v4082566 % 100 == 0) { await QB.autoLimit(); }
      //-------- BEGIN JS native code block --------
            s = sarray[i]
//-------- END JS native code block --------
      QB.arrayValue(results, [ i + 1]).value =  (QB.func_LTrim(  s));
   } 
}
async function sub_SetVisible(visible/*INTEGER*/) {
if (QB.halted()) { return; }; visible = Math.round(visible); 
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
   var aarray = QB.initArray([{l:0,u:0}], '');  /* STRING */ 
   await sub_Split(  authors,   ","  ,   aarray);
   var ai = 0;  /* INTEGER */ 
   var ___v7070014 = 0; ___l9476965: for ( ai=  1 ;  ai <= (QB.func_UBound(  aarray));  ai= ai + 1) { if (QB.halted()) { return; } ___v7070014++;   if (___v7070014 % 100 == 0) { await QB.autoLimit(); }
      var author = '';  /* STRING */ 
      author =  QB.arrayValue(aarray, [ ai]).value;
      var o = {};  /* OBJECT */ 
      o =  QB.arrayValue(amap, [ author]).value;
      //-------- BEGIN JS native code block --------
            if (o == undefined || o.length == undefined) {
                o = [];
            }
            o.push(li);
//-------- END JS native code block --------
      QB.arrayValue(amap, [ author]).value =   o;
      var found = 0;  /* INTEGER */ var i = 0;  /* INTEGER */ 
      var ___v4271988 = 0; ___l9837131: for ( i=  1 ;  i <= (QB.func_UBound(  alist));  i= i + 1) { if (QB.halted()) { return; } ___v4271988++;   if (___v4271988 % 100 == 0) { await QB.autoLimit(); }
         if (QB.arrayValue(alist, [ i]).value  ==   author) {
            found =   - 1;
            break ___l9837131;
         }
      } 
      if (~ found) {
         i =  (QB.func_UBound(  alist))  +  1;
         QB.resizeArray(alist, [{l:0,u:i}], '', true);  /* STRING */ 
         QB.arrayValue(alist, [ i]).value =   author;
      }
   } 
   await sub_SortArray(  alist);
}
async function sub_MapCategories(categories/*STRING*/,li/*OBJECT*/) {
if (QB.halted()) { return; }; 
   var carray = QB.initArray([{l:0,u:0}], '');  /* STRING */ 
   await sub_Split(  categories,   ","  ,   carray);
   var ci = 0;  /* INTEGER */ 
   var ___v6924219 = 0; ___l4633799: for ( ci=  1 ;  ci <= (QB.func_UBound(  carray));  ci= ci + 1) { if (QB.halted()) { return; } ___v6924219++;   if (___v6924219 % 100 == 0) { await QB.autoLimit(); }
      var category = '';  /* STRING */ 
      category =  QB.arrayValue(carray, [ ci]).value;
      var o = {};  /* OBJECT */ 
      o =  QB.arrayValue(cmap, [ category]).value;
      //-------- BEGIN JS native code block --------
            if (o == undefined || o.length == undefined) {
                o = [];
            }
            o.push(li);
//-------- END JS native code block --------
      QB.arrayValue(cmap, [ category]).value =   o;
      var found = 0;  /* INTEGER */ var i = 0;  /* INTEGER */ 
      var ___v6304556 = 0; ___l6800396: for ( i=  1 ;  i <= (QB.func_UBound(  clist));  i= i + 1) { if (QB.halted()) { return; } ___v6304556++;   if (___v6304556 % 100 == 0) { await QB.autoLimit(); }
         if (QB.arrayValue(clist, [ i]).value  ==   category) {
            found =   - 1;
            break ___l6800396;
         }
      } 
      if (~ found) {
         i =  (QB.func_UBound(  clist))  +  1;
         QB.resizeArray(clist, [{l:0,u:i}], '', true);  /* STRING */ 
         QB.arrayValue(clist, [ i]).value =   category;
      }
   } 
   await sub_SortArray(  clist);
}
async function sub_SortArray(qbarray/*STRING*/) {
if (QB.halted()) { return; }; 
   var array = {};  /* OBJECT */ 
   //-------- BEGIN JS native code block --------
        array = [];
//-------- END JS native code block --------
   var i = 0;  /* INTEGER */ 
   var ___v5319874 = 0; ___l2269004: for ( i=  1 ;  i <= (QB.func_UBound(  qbarray));  i= i + 1) { if (QB.halted()) { return; } ___v5319874++;   if (___v5319874 % 100 == 0) { await QB.autoLimit(); }
      var o = {};  /* OBJECT */ 
      o =  QB.arrayValue(qbarray, [ i]).value;
      //-------- BEGIN JS native code block --------
            array.push(o);
//-------- END JS native code block --------
   } 
   //-------- BEGIN JS native code block --------
        array.sort(function (a, b) {
            return a.toLowerCase().localeCompare(b.toLowerCase());
        });
//-------- END JS native code block --------
   var ___v2788304 = 0; ___l209622: for ( i=  0 ;  i <=  array.length -  1;  i= i + 1) { if (QB.halted()) { return; } ___v2788304++;   if (___v2788304 % 100 == 0) { await QB.autoLimit(); }
      QB.arrayValue(qbarray, [ i + 1]).value =   array[i];
   } 
}
async function sub_SortList(list/*OBJECT*/) {
if (QB.halted()) { return; }; 
   //-------- BEGIN JS native code block --------
    var i, switching, b, shouldSwitch;
    switching = true;
    while (switching) {
        switching = false;
        b = list.getElementsByTagName("LI");
        for (i = 0; i < (b.length - 1); i++) {
            shouldSwitch = false;
            if (b[i].innerHTML.toLowerCase() > b[i + 1].innerHTML.toLowerCase()) {
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
   //-------- BEGIN JS native code block --------
    window.dispatchEvent(new Event("resize"));
//-------- END JS native code block --------
}

}
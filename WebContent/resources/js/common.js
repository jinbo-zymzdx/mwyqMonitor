var LOC = "LOC";
var PER = "PER";
var ORG = "ORG";

var locdiv = "#locList";
var perdiv = "#perList";
var orgdiv = "#orgList";
var hoteventdiv = "#hotevent";

var timechartdiv = "#time_chart";
var linechartdiv = "#line_chart";
var cloudchartdiv = "#cloud_chart";

var KEYWORD = "#conditions_tag";
var PAGESIZE = "#rblPageSize";
var DATE = "#rblTimeDuration";

var INDEXKEYWORD = "#input_keywords";

var LOGINAME = "#username";
var PWD = "#password";

var FAIL_STATUS = "Fail";
var SUCCESS_STATUS = "Success";

var mapdiv = "map-demo";
var COLUMN_H = 178;
var CHAT_W = 320;

var CONTENTLEN = 180;

var loc_chartdiv = "loc_chart";
var org_chartdiv = "org_chart";
var per_chartdiv = "per_chart";

var LOC_TITLE = "地点";
var PER_TITLE = "人物";
var ORG_TITLE = "组织机构";
var LINE_TITLE = "新闻趋势";
var COLUMN_SNAME = "新闻指数";
var MAP_WTITLE = "相关新闻";
var COLUMN_XLEN = 3;
var MODAL_NEWSLIST = 15;		//首页趋势图弹出框新闻列表显示条数
var HOTSPOTS_SHOW = 20;		//实时热点时间轴新闻的显示个数

var SOURCE_COLOR = "#660099";			//源话题颜色，紫色
var TOPIC_COLOR = "rgb(11, 98, 164)";	//话题颜色，深蓝
var LOC_COLOR = "rgb(44, 160, 44)";		//地点实体颜色，绿色
var PER_COLOR = "rgb(23, 190, 207)";	//人物实体颜色，淡蓝色
var ORG_COLOR = "rgb(255, 127, 14)";	//组织机构实体颜色，橙色

var DEFAULT_LANG = "chinese";
var LANG_SPLIT = "@@@";

var NUM = 10;
var SHOWNUM = 10;
var CNUM = 8;
var MAXPOINT = 50;
var DEFNEWSNUM = 500;
var DEFDATE = "7d";
var DB_ZHCN = "zh-CN";
var DB_KO = "ko";
var DB_UI = "ui";
var DB_BO = "bo";
var BD_ZHCN = "zh";
var BD_KO = "kor";
var BD_DEFAULT = "auto";
var MIN_NEWS = 200;

var LANGS_SET = [];	//语言类型集合，从配置文件中获取

//function settings(){
//	if($('#settings').is(':hidden')){
//		$('#settings').show();
//	}else {
//		$('#settings').hide();
//	}
//}

//设置面板的显示控制
function settings(){
	if($('#set-panel').is(':hidden')){
		$('#set-panel').show(300);
	}else {
		$('#set-panel').hide();
	}
}

//隐藏设置面板，防止跟登录面板重叠在一起
function hideSettings(){
	$('#set-panel').hide();
}

function getRequestParameters() {
    var url = location.href;
    var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
    var paraObj = {};
    for (i = 0; j = paraString[i]; i++) {
        paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
    }
    return paraObj;
}

function logout(){
	var flag = false;
	
	$.ajax({
		url: "svc/user/mwhjlogin/userLogout",
		type: "GET",
		async: false,
		contentType: "application/json",
		success: function(data){
//			alert(JSON.stringify(data.status));
//			window.location.href = 'login.html';
			if(data.status == "success"){
				flag = true;
			}
		},
		dataType: "json"
	});
	
	if(flag){
		window.location.href = 'login.html';
	}
}

function sort_by(field, reverse, primer){
	reverse = (reverse) ? -1 : 1; 
	return function(a,b){ 
	    a = a[field]; 
	    b = b[field]; 
	    if (typeof(primer) != 'undefined'){ 
		a = primer(a); 
		b = primer(b); 
	    } 
	    if (a>b) {
	    	if(field == "date"){
	    		return reverse * 1; 
	    	}else if(field == "count"){
	    		return reverse * -1;
	    	}else if(field == "size"){
	    		return reverse * -1;
	    	}
	    }
	    if (a<b) {
	    	if(field == "date"){
	    		return reverse * -1; 
	    	}else if(field == "count"){
	    		return reverse * 1;
	    	}else if(field == "size"){
	    		return reverse * -1;
	    	}
	    }
	}
	return 0; 
}

function Entity(name,count){
	this.name = name;
	this.count = count;
}

function Line(date,count){
	this.date = date;
	this.count = count;
}

function Cloud(text,size){
	this.text = text;
	this.size = size;
}

function Point(lng,lat){
	this.lng = lng;
	this.lat = lat;
}

function Location(name,point){
	this.name = name;
	this.point = point;
}

function News(id,title,date){
	this.id = id;
	this.title = title;
	this.date = date;
}

function Events(location,newsList){
	this.location = location;
	this.newsList = newsList;
}

function converLang(langCode){
	if(langCode.indexOf(LOC) != -1){
		return LOC_TITLE;
	}
	
	if(langCode.indexOf(PER) != -1){
		return PER_TITLE;
	}
	
	if(langCode.indexOf(ORG) != -1){
		return ORG_TITLE;
	}
}

function converLangSource(langCode){
	if(langCode.indexOf(DB_ZHCN) != -1){
		return BD_ZHCN;
	}
	
	if(langCode.indexOf(DB_KO) != -1){
		return BD_KO;
	}
	
	return BD_DEFAULT;
}

function converLangCode(lang_Type){
	if(lang_Type == LOC_TITLE){
		return LOC;
	}
	
	if(lang_Type == PER_TITLE){
		return PER;
	}
	
	if(lang_Type == ORG_TITLE){
		return ORG;
	}
}

function converColor(langCode){
	if(langCode == LOC || langCode == "中文"){
		//return "#0b62a4";		//蓝色
		return "rgb(62, 149, 215)";
	}
	
	if(langCode == PER || langCode == "蒙文"){
		return "#4da74d";		//绿色
	}
	
	if(langCode == ORG || langCode == "维文"){
		return "#7A92A3";		//灰色
	}
	
	if(langCode == "藏文"){
		return "rgb(23, 190, 207)";		//蓝绿色
	}
}

function Drilldown(name,categories,data,color){
	this.name = name;
	this.categories = categories;
//	this.data = parseFloat(data).toFixed(2);
	this.data = data;
	this.color = color;
}

function PieData(y,color,drilldown){
//	this.y = parseFloat(y).toFixed(2);
	this.y = y;
	this.color = color;
	this.drilldown = drilldown;
}

function trim(str) { //删除左右两端的空格
    return str.replace(/(^\s*)|(\s*$)/g, "");
}

/**
 * 分页函数
 * @param idName
 * @param pageCount  总页数
 * @param pageEvent 翻页事件
 * 
 * 使用该函数需要引入model.css 和 jquery.paginate.js
 */
function pagination(idName, pageCount, pageEvent){
	$(idName).paginate({
	    count : pageCount,		//总页数
	    start : 1,
	    display : 5,		//显示页数
	    border	: false,
	    border_color	 : '#fff',
	    text_color : '#428bca',
	    background_color 	: 'white',	
	    border_hover_color	: '#ccc',
	    text_hover_color  		: '#fff',
	    background_hover_color	: '#428bca', 
	    images	: false,
	    mouse	: 'press',
	    onChange : pageEvent
	});
}

/**
 * 新闻内容实体标注
 *
 * @param content 新闻内容
 */
function markEntity(content,lang_Type){
	content = content.replace(/(\r\n)|(\n)/g,"<br>").replace(/[(^\s+)|(\s+$)]{3}/g,"<br>　　");
	
	var regex = /\{([^\,\{\}]*)\,(LOC|PER|ORG)\}/g;		//匹配形如{XXX,ORG}或{XXX,PER}或{XXX,LOC}
	var temp = content.match(regex);		//匹配到的结果集合
	if(temp != null){
		temp = removeRepeat(temp);//去除数组中重复的对象
		
		for(var i=0; i<temp.length; i++){
			var splitResult = temp[i].replace(/\{/,"").replace(/\}/,"").split(",");	//分割成字符串数组
			var tag = splitResult[0];		//实体标签
			var type = splitResult[1];		//实体类型
			content = content.replace(new RegExp(temp[i], 'g'),function(){
				var showColor = "#000";
//				if(type == LOC){
//					showColor = LOC_COLOR;
//				}else if(type == PER){
//					showColor = PER_COLOR;
//				}else if(type == ORG){
//					showColor = ORG_COLOR;
//				}
				return "<span class='entity-maker' onclick='entityDetail(this,"+type+",\""+lang_Type+"\",event);'>"+tag+"</span>"
			});
		}
	}
	
	return content;
}

/**
 * 去除数组中的重复对象
 * 
 * @param array 要去重的数组
 */
function removeRepeat(array){
	var hash = {};
    var result = [];
    for (var i = 0; i < array.length; i++) {
        var len = array[i];
        if (hash[len] !== array[i]) {
            hash[len] = len;
            result.push(len)
        }
    }
	return result;
}

/**
 * 初始化注入
 */
//$(function(){
//	listUserWord();		//展开自定义监控
//	
//	$.ajaxSettings.async = false;
//	$.getJSON("js/conf/langsconf.json", function(result){
//		var langsRadioHtml = "";
//		var filter_ul_html = '<li><a href="javascript:void(0);" onclick="langFilter(this,\'all\')">全部</a></li>';	//首页实时热点按语言过滤
//		for(var i in result){
//			var code = result[i].code;
//			var name = result[i].name;
//			if(i == 0){
//				//默认选中第一个
//				if(code == "zh")
//					langsRadioHtml += '<span class="input-group-addon"><input name="cbLanguage" type="radio" checked="checked" value="zh-CN" >'+name+'</input></span>';
//				else
//					langsRadioHtml += '<span class="input-group-addon"><input name="cbLanguage" type="radio" checked="checked" value="'+code+'" >'+name+'</input></span>';
//			}else{
//				if(code == "zh")
//					langsRadioHtml += '<span class="input-group-addon"><input name="cbLanguage" type="radio" value="zh-CN" >'+name+'</input></span>';
//				else
//					langsRadioHtml += '<span class="input-group-addon"><input name="cbLanguage" type="radio" value="'+code+'" >'+name+'</input></span>';
//			}
//			filter_ul_html += '<li><a href="javascript:void(0);" onclick="langFilter(this,\''+code+'\')">'+name+'</a></li>';
//			LANGS_SET.push(name);
//		}
//		$("#langsRadio").html(langsRadioHtml);
//		$("#filter_ul_li").html(filter_ul_html);
//	});	
//	
//	//模态框关闭的触发事件
//	$('#pointNewsContent').on('hidden.bs.modal',function(){
//		entityClose();		//关闭实体详情
//	}).scroll(function(){
//		entityClose();		//关闭实体详情
//	});
//	
//	//获取焦点
//	$("#search_conditions").click(function(){
//		$("#conditions_keyword").focus();
//	});
//	
//	//打印功能
//	$("#dropdownPrint").click(function(){
//		hideSettings();
//	});
//	
//	$('#side-menu').metisMenu();		//自定义监测
//})

/**
 * 实体详情
 *
 */
function entityDetail(object, type,lang_Type, event){
	var name = $(object).text();
	var type = type;
	
	if(lang_Type.indexOf(BD_KO) != -1){
		name = encodeURI(name);
	}
	
	var param = {
		appid : null,
		userid : null,
		accesstoken : null,
		entityName : name,
		entityType : type,
		lang_Type : lang_Type
	}
	//alert(JSON.stringify(param,null,2))
	var result = "";
	$.ajax({
		url : "svc/mongo/mwhjsearch/entityInfo",
		async: false,
		data: param,
		type: "GET",
		contentType: "application/json; charset=utf-8",
		success: function(data){
			result = data;
		},
		dataType: "json"
	});
	//alert(JSON.stringify(result,null,2))
	
//	alert(JSON.stringify(result));
	
	var entityName = result.entityname;
	var url = result.url;						//实体链接
	var classInfo = result.classInfo;	//类别归属
	var related = result.related;			//相关词
	var zhabstract = result.zhabstract; //概述
	
	var content_html;
	if(classInfo == "" && related =="" && zhabstract == ""){
		content_html = "<em>暂缺</em>";	//斜体“暂缺”
	}else{
		content_html = "<p style='text-indent:2em; margin:0 0 5px;'>"+zhabstract+"</p>"
								+"<span style='margin-bottom:5px;'><strong>类别归属：</strong>"+classInfo+"</span><br>"
								+"<span style='margin-bottom:5px; padding-bottom:5px;'><strong>相关词：</strong>"+related+"</span>"
								
	}
	url = url == "" ? "javascript:void(0);" : url;
	$('.popover-title').html("<a href='"+url+"' target='_blank'>"+entityName+"</a><div class='close entity-close' aria-hidden='true' onclick='entityClose();'>&times;</div>");
	$('.popover-content').html(content_html);
	
	var e = window.event || event;
	
	var mw_top = $(object).offset().top;	//文本距离窗体顶部长度
	var mw_left = $(object).offset().left;	//文本距离窗体左侧长度
	var mouse_left = e.clientX; 				//鼠标距左侧的距离
	var mouse_top = e.clientY;				//鼠标距顶部的距离
	
	var text_width = $(object).text().length * 14;		//被点击文本的宽度，字数 * 字体大小
	var this_width = $(object).width();
	
	//$('.popover-content').append("<br>文本距离顶部："+mw_top+"<br>文本距左侧："
	//			+mw_left+"<br>鼠标点击位置："+e.clientX+"<br>被点击文本宽度："+this_width
	//			+"<br>文本宽度："+text_width);
				
	var popover_height = $('.popover').height();	//弹出框的高度
	var popover_width = $('.popover').width();	//弹出框的宽度
	
	if(this_width - text_width > 50){
		//说明实体被分为两行
		$('.popover').removeClass("top");
		$('.popover').removeClass("bottom");
		$('.popover').addClass("right");
		var top = mouse_top - popover_height/2 -5;
		
		$('.popover').css('display','block')
		.css('top',top)
		.css('left',mouse_left);
	}else{
		var top = mw_top - popover_height - 5;
		var left = mw_left - (popover_width/2) + (this_width/2);
		
		if(top > 0){
			$('.popover').removeClass("right");
			$('.popover').removeClass("bottom");
			$('.popover').addClass("top");
			var top = mw_top - popover_height - 5;
			//var left = mw_left - (popover_width/2) + (this_width/2);
		}else if(top <= 0){
			$('.popover').removeClass("right");
			$('.popover').removeClass("top");
			$('.popover').addClass("bottom");
			var top = mw_top + 20;
		}
		
		$('.popover').css('display','block')
		.css('top',top)
		.css('left',left);
	}
}

/**
 * 关闭实体详情弹出框
 */
function entityClose(){
	$('.popover').css('display','none')
}

/**
 * Date格式化 
 */
Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, 	//月
        "d+": this.getDate(), 			//日 
        "h+": this.getHours(), 			//小 
        "m+": this.getMinutes(), 		//分 
        "s+": this.getSeconds(), 		//秒 
        "S": this.getMilliseconds() 		//毫秒 
    };
    if (/(y+)/.test(fmt)){
    	fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for (var k in o){
    	if (new RegExp("(" + k + ")").test(fmt)){
    		fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    	}
    }
    return fmt;
};

/**
 * 如果新闻趋势图少于3个点，手动添加前后两个点，防止趋势图画成一个点或一条线
 * 返回按日期排序的集合
 */
function filterAreaData(lineList){
	if(lineList.length <= 2){
		if(lineList.length == 1){
			//只有一个点
			var thisDate = lineList[0].date;
			thisDate = new Date(thisDate.replace(/-/g, "/"));
			var beforeDate = thisDate.getTime() - 1000*60*60*24;	//前一天
			var afterDate = thisDate.getTime() + 1000*60*60*24;		//后一天
			beforeDate = new Date(beforeDate).Format("yyyy-MM-dd");
			afterDate = new Date(afterDate).Format("yyyy-MM-dd");
//			lineList.push({
//				"date" : beforeDate,
//				"newsNum" : 0
//			},{
//				"date" : afterDate,
//				"newsNum" : 0
//			});
			lineList.push(new Line(beforeDate,0));
			lineList.push(new Line(afterDate,0));
		}else{
			//有两个点
			var temp = [];
//			for(var i=0; i<lineList.length; i++){
//				var dateStr = lineList[i].date;
//				var time = new Date(dateStr.replace(/-/g, "/"));
//				temp.push(time);
//			}
			
			var date1 = lineList[0].date;		//第一个时间
			var date2 = lineList[1].date;		//第二个时间
			
			date1 = new Date(date1.replace(/-/g,"/"));
			date2 = new Date(date2.replace(/-/g,"/"));
			
			var temp_date;
			
			if(date1.getTime() > date2.getTime()){
				temp_date = date1;
				date1 = date2;
				date2 = temp_date;
			}
			temp.push(date1);
			temp.push(date2);
			
			//temp = temp.sort();
			var minDate = temp[0].getTime()-1000*60*60*24;		//最小日期
			var maxDate = temp[1].getTime()+1000*60*60*24;		//最大日期
			minDate = new Date(minDate).Format("yyyy-MM-dd");
			maxDate = new Date(maxDate).Format("yyyy-MM-dd");
			
			lineList.push(new Line(minDate,0));
			lineList.push(new Line(maxDate,0));
//			lineList.push({
//				"date" : minDate,
//				"newsNum" : 0
//			},{
//				"date" : maxDate,
//				"newsNum" : 0
//			});
		}
	}else{
		lineList = lineList;
	}
	
	lineList = lineList.sort(sort_by('date',false,String));
	return lineList;
}

function listUserWord(){
	//alert("开始执行");
	document.charset='utf-8';
	
	var submenuhtml = "<li><a href='#' onclick='addNode();'><span class='glyphicon glyphicon-plus'></span>  添加</a></li>";
	var alluserwords = new Array();
//	$.ajax({
//		url: "svc/mongo/mwhjsearch/userword",
//		async: false,
//		type: "GET",
//		contentType: "application/json; charset=utf-8",
//		success: function(data){
////			alert(JSON.stringify(data));
//			alluserwords = data;
//		},
//		dataType: "json"
//	});
	
	
	$.ajax({
		url: "/mwyqMonitor/custom/listAll",
		async: false,
		type: "GET",
		contentType: "application/json; charset=utf-8",
		success: function(data){
			//alert(JSON.stringify(data));
			alluserwords = data;
		},
		dataType: "json"
	});

	alluserwords =  _.sortBy(alluserwords, function(n){ return n.word_Type;})
	alluserwords = alluserwords.reverse();
	//获取显示屏宽度	
	var bodyWidth = document.documentElement.scrollWidth;
	for(var auwi = 0; auwi < alluserwords.length;auwi ++){
		var word = alluserwords[auwi];
		var word_Type = word.word_Type;
		var isPause = word.isPause;
		
		var resultWord = word.word.toString();
		
		//var sendWord = encodeURI(word.word);
		//var sendWord = encodeURI(word.word);
		if(bodyWidth < 1345){
			submenuhtml += "<li style='font-size:12px; padding:5px 5px 5px 10px !important;'>";
		}else{
			submenuhtml += "<li>";
		}
		submenuhtml += "<div class='switch-div'><a target='"+'_blank'+"' href='"+'/mwyqMonitor/custom/displayMonitor/'+word.word+"' title='"+word.word+"' value='"+word.id+"'>";
		submenuhtml += getGlyphicon(word_Type);
		
		if(bodyWidth < 1350){
			var showWord = word.word.length > 3 ? (word.word.substr(0,3)+"...") : word.word;
			submenuhtml += showWord + "</a>";
			submenuhtml += "<span class='glyphicon glyphicon-remove listUser_remove' onclick='removeNode(this);' style='padding: 6px 0 5px 5px;'></span>";
		}else{
			var showWord = word.word.length > 5 ? (word.word.substr(0,5)+"...") : word.word;
			submenuhtml += showWord + "</a>";
			submenuhtml += "<span class='glyphicon glyphicon-remove listUser_remove' onclick='removeNode(this);'></span>";
		}
		
		if(isPause == 1){
			if(bodyWidth < 1345){
				submenuhtml += '<div class="switch switch-mini monitor-switch" style="min-width:50px !important;"><input type="checkbox" checked="checked"></div>';
			}else{
				submenuhtml += '<div class="switch switch-mini monitor-switch"><input type="checkbox" checked="checked"></div>';
			}
		}else{
			if(bodyWidth < 1345){
				submenuhtml += '<div class="switch switch-mini monitor-switch" style="min-width:50px !important;"><input type="checkbox" checked=""></div>';
			}else{
				submenuhtml += '<div class="switch switch-mini monitor-switch"><input type="checkbox" checked=""></div>';
			}
		}
		
		submenuhtml += "</div></li>";
	}
	
	$("#usersubmenu").html(submenuhtml);
	
	$('.switch')['bootstrapSwitch']();
	
	resetStatus();
	//addSwitch();
}

//删除节点
function removeNode(object){
	 if(confirm("确定要删除该节点吗？")){
	 	var keyWord = $(object).siblings("a").attr("title");
//		$.ajax({
//			url: "svc/mongo/mwhjsearch/deleteword",
//			data: { id : id },
//			type: "GET"
//		});
	 	
	 	//alert(keyWord);
		
		$.ajax({
		url: "/mwyqMonitor/custom/deleteMonitor",
		contentType:'charset=UTF-8',
		data: { keyWord : encodeURI(keyWord) },
		type: "GET"
	});
	 	
	 	$(object).parent("div").parent("li").remove();
	 }
}

//添加节点
function addNode(){
	$("#monitor_word").val("");
	$("#monitor_wordType").val("");
	$("#monitor_langType").val("");
	$("#monitor_describe").val("");
	$("#monitor").modal("show");
}





//保存自定义检测添加
function saveMonitor(){
	document.charset='utf-8';
	
	var word = $("#monitor_word").val();
	var word_Type = $("#monitor_wordType").val();
	var lang_Type = $("#monitor_langType").val();
	var describe = $("#monitor_describe").val();
	describe = describe == "" ? word : describe;
	
	var word_type_code = "";
	if(word_Type == "地点"){
		word_type_code = "LOC";
	} else if (word_Type == "人物"){
		word_type_code = "PER";
	} else if (word_Type == "组织机构"){
		word_type_code = "ORG";
	} else {
		word_type_code = "";
	}
	
	var lang_type_code = "";
	if(lang_Type == "维文"){
		lang_type_code = DB_UI;
	} else if (lang_Type == "藏文"){
		lang_type_code = DB_BO;
	} else if (lang_Type == "蒙文"){
		lang_type_code = DB_KO;
	} else if(lang_Type == "中文"){
		lang_type_code = DB_ZHCN;
	} 
	

	
	$
	.ajax({
		type : "post",
		async : false,
		url : "/mwyqMonitor/custom/saveMonitor",
		data : {key_word:word,type:word_type_code,lang_type:lang_type_code,description:describe},
		dataType : "json",
		success : function(result) {
		}
	});
	
	
	
	var bodyWidth = document.documentElement.scrollWidth;		//获取显示屏宽度
	var html="";
	if(word != "" || word != null){
		html = "<li><div class='switch-div'><a target='"+'_blank'+"' href='"+'/mwyqMonitor/custom/displayMonitor/'+word+"' title='"+word+"' >"
					+getGlyphicon(word_type_code)+word+"</a>"
		var showWord; 
		if(bodyWidth <= 1366){
			showWord = word.length > 3 ? (word.substr(0,3) + "...") : word;
		}else{
//			showWord = word;
			showWord = word.length > 5 ? (word.substr(0,5) + "...") : word;
		}

		if(bodyWidth < 1345){
			html = "<li style='font-size:12px; padding:5px 5px 5px 10px !important;'><div class='switch-div'>"
					+"<a target='"+'_blank'+"' href='"+'/mwyqMonitor/custom/displayMonitor/'+word+"' title='"+word+"' >"
					+getGlyphicon(word_type_code)+showWord+"</a>"
					+"<span class='glyphicon glyphicon-remove listUser_remove' onclick='removeNode(this);' style='padding: 6px 0 5px 5px;'></span>"
					+'<div class="switch switch-mini monitor-switch" style="min-width:50px !important;"><input type="checkbox" checked=""></div>'
					+"</div></li>";
		}else{
			html = "<li><div class='switch-div'><a target='"+'_blank'+"' href='"+'/mwyqMonitor/custom/displayMonitor/'+word+"' title='"+word+"' >"
					+getGlyphicon(word_type_code)+showWord+"</a>"
					+"<span class='glyphicon glyphicon-remove listUser_remove' onclick='removeNode(this);'></span>"
					+'<div class="switch switch-mini monitor-switch"><input type="checkbox" checked=""></div>'
					+"</div></li>";
		}
		
//		$.ajax({
//			url: "svc/mongo/mwhjsearch/adduserword",
//			data: {
//				word : word,
//				word_Type : word_type_code,
//				lang_Type : lang_type_code,
//				description : describe
//			},
//			type: "POST",
//			dataType: "json"
//		});
		
	} else{
		alert("监控词不能为空！");
	}
	
	$("#usersubmenu").find("li:first").after(html);
	$("#usersubmenu").find("li:first").next("li").find(".switch")['bootstrapSwitch']();
	
	resetStatus();
	
	//$('.switch')['bootstrapSwitch']();
	//addSwitch();
	//$("#usersubmenu").append(html);
	$("#monitor").modal("hide");
}

//监控词状态调整
function resetStatus(){
	$(".switch-off").each(function(){
		var a = $(this).parent().siblings("a");
		a.css("color","#999").css("cursor","default").css("pointer-events", "none");
	});
	
	$(".monitor-switch").on('switch-change', function (e, data) {
        var value = data.value;
        var id = $(this).siblings("a").attr("value");
		
		if(!value){
			$(this).siblings("a").css("color","#999").css("cursor","default").css("pointer-events", "none");
		} else{
			$(this).siblings("a").css("color","#428bca").css("cursor","pointer").css("pointer-events", "inherit");
			this.disabled = false;
		}
		
		$.ajax({
			url: "svc/mongo/mwhjsearch/pauseword",
			data: { id : id },
			type: "GET"
		});
    });
}

//监控词搜索
function wordSearch(word, word_type,langs){
	
	document.charset='utf-8';
//	$.ajax({
//		url: "/mwyqMonitor/custom/displayMonitor",
//		contentType:'charset=UTF-8',
//		data: { word : encodeURI(word) },
//		type: "GET"
//	});
	var maxNum = $(PAGESIZE).val();		//设置面板的最大搜索数
	var dates = $(DATE).val();						//时间选择
//	var langs = "";										//语言

	if(maxNum == ""){
		maxNum = DEFNEWSNUM;
	}
	
	if(dates == ""){
		dates = DEFDATE;
	}
	
	var param = {};
	param.appid = "123";
	param.userid = "123";
	param.accesstoken = "123";
	param.keyword = "";
	param.maxNum = maxNum;
	param.dates = dates;
	param.langs = langs.trim();
	
	var queryWordModel = "";
	queryWordModel = word + ":" + word_type;
	param.queryWordModel = queryWordModel;
	
	var condition = "";
	condition += "appid="+param.appid+"&userid="+param.userid+"&accesstoken="+param.accesstoken+"&";
//	condition += "keyword="+ encodeURIComponent(keyword) + "&maxNum=" + maxNum + "&dates=" + dates + "&langs=" + langs + "&words=" + queryWordModel;
	condition += "keyword="+ param.keyword + "&maxNum=" + maxNum + "&dates=" + dates + "&langs=" + langs + "&words=" +queryWordModel;
	
	//window.open("monitor.html?"+ condition);
}

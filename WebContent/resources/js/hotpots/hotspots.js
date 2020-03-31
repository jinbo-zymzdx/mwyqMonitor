//虚构实时热点数据，需要根据时间排序，距离现在最近的排在最靠前

var hotspotsObj = new Array();

var moreClick = 0;	//记录查看更多的点击次数
var maxClick = 0;		//最多可以点击的次数

var kosportsObj = new Array();
var uisportsObj = new Array();
var bosportsObj = new Array();

var zhNum = 0;
var uiNum = 0;
var boNum = 0;
var koNum = 0;

/**
 * 请求后台获取数据
 * @param {Object} param
 */
function getData(param){
	var result;
	$.ajax({
		url: "svc/mongo/mwhjsearch/hotNews",
		async: false,
		data : param,
		type: "GET",
		contentType: "application/json",
		success: function(data){
			result = data;
		},
		dataType: "json"
	});
	return result;
}

//初始化载入
$(function(){	
	//$('#side-menu').metisMenu();
	
	var param = {
		appid : null,
		userid : null,
		accesstoken : null,
		pageNum : 0	//默认为0
	}
	
	var hotalldata = getData(param);
	hotspotsObj = hotalldata.hotNewsResults;
	
	var temp = hotspotsObj.length / HOTSPOTS_SHOW;	//"加载更多"最多可以点击的次数
	var index = String(temp).indexOf(".");
	maxClick = index > -1 ? String(temp).substring(0,index)*1+1 : temp;
	
	var total = hotalldata.totalNum;			//总数
	var Chinese = hotalldata.zhcNum;		//中文
	var Korean = hotalldata.koNum;			//朝文
	var Balakrishnan = hotalldata.uiNum;	//维文
	var Tibetan = hotalldata.boNum;			//藏文

	zhNum = Chinese;
	uiNum = Balakrishnan;
	boNum = Tibetan;
	koNum = Korean;
	
	createTitleAlert(total, Chinese, Korean, Balakrishnan, Tibetan);		//创建统计分析面板
	
	var showObject = hotspotsObj.slice(0,HOTSPOTS_SHOW);	//初始化创建时间轴的长度
	createTimeLine(showObject);		//创建时间轴
	
	//搜索智能提示
	var data = hotalldata.autoCompletes;
	autoComplete(data);		//方法位于search.js

//	$("#lang_all").click(function(){
//		if(this.checked){
//			//alert("全选")
//			$("input[name='checkname']").each(function(){
//				this.checked=true;
//			}); 
//		}else{
//			//alert("取消全选")
//			$("input[name='checkname']").each(function(){
//				this.checked=false;
//			}); 
//		}
//	});
});

//新闻标题点击话题
function show_content(obj, ID){
	var param = {
		nid : ID,
		appid : "123",
		userid : "123",
		accesstoken : "123"
	}
	
	var newsResult;
	
	$.ajax({
		url: "svc/mongo/mwhjsearch/newsInfoByID",
		async: false,
		data : param,
		type: "GET",
		contentType: "application/json",
		success: function(data){
			newsResult = data;
		},
		dataType: "json"
	});
	
	var title = newsResult.news_Title;
	var crawl_Source = newsResult.crawl_Source;
	var time = newsResult.crawl_Time.replace(".0","");
	var show_time = formatTime(time);
	var content = newsResult.news_Content.replace(/(\r\n)|(\n)/g,"<br>").replace(/[(^\s+)|(\s+$)]{3}/g,"<br>　　");
	var lang_Type = newsResult.lang_Type;
	
	var className = lang_Type.indexOf("ui") > -1 ? "lang-ui" : "";
	
	//$(obj).parent().parent().parent().children(".timeline-badge").attr("class","timeline-badge");		//去掉背景色
	//$(obj).parent().parent().parent().find("span").attr("class","glyphicon glyphicon-ok")				//打钩，表示已读
	var html = "<h4 class='timeline-title "+className+"'>"+title+"</h4><p><small class='text-muted'>"+show_time+"</small>"
					+"<a class='crawl_Source' href='http://"+crawl_Source+"' target='_blank'>"+crawl_Source+"</a></p><p class='"+className+"'>"+content+"</p>";
	$("#news_content").html(html);
}

//局部刷新
function refresh(){
	//请求新的hotspotsObj数据,这里手动伪造添加
//	hotspotsObj.unshift({
//		title : "新闻标题8",
//		date : new Date(),
//		content : "新闻内容8",
//		lang : "tib"
//	});
	createTimeLine(hotspotsObj);
}

//创建时间轴，@Parma badge[] 徽章背景色数组，@parma hotspots{} 实时热点数据
function createTimeLine(hotspots,label){
	var html = ""
	if(hotspots == "" || hotspots == null){
		html = "<div class='row notfind'><span>没有找到"+label+"的热点新闻！</span></div>";
		$("#showTimeLine").html(html);
		$("#news_content").html("");
		$(".showMore").css("display","none");
	}else{
		html = buildTimeLine(hotspots);
		$("#showTimeLine").html(html);		//创建时间轴
		$(".showMore").css("display","block");
	}
}

//构建时间轴html
function buildTimeLine(hotspots, isTake){
	var  prefix, suffix;	//前缀，<ul> 或空
	prefix = isTake == "takeMore" ? "" : "<ul class='timeline'>";
	suffix = isTake == "takeMore" ? "" : "</ul>";
	
	var html = prefix;
	
	var badge = ["warning","info","danger","success","primary"]
	
	//右侧显示面板默认显示第一条新闻
	var hotContent = hotspots[0].content.replace(/(\r\n)|(\n)/g,"<br>").replace(/[(^\s+)|(\s+$)]{3}/g,"<br>　　");
	var pattern = /^<br>/;
	var firstR = pattern.test(hotContent);
	hotContent = firstR ? hotContent.replace("<br>","") : hotContent;
	
	var url = hotspots[0].url;
	var lang_Type = hotspots[0].langtype;
	
	var className = lang_Type.indexOf("ui") > -1 ? "lang-ui" : "";
	
	var first_html = "<h4 class='timeline-title "+className+"'>"+hotspots[0].title+"</h4><p><small class='text-muted'>"
							+formatTime(hotspots[0].date)+"</small><a class='crawl_Source' href='http://"+url+"' target='_blank'>"
							+url+"</a></p><p class='"+className+"'>"+hotContent+"</p>";		//新闻内容面板默认显示第一条新闻
							
	$("#news_content").html(first_html);
	
	for(var i=0; i< hotspots.length; i++){
		var time = formatTime(hotspots[i].date);		//距离现在的时间
		
		var badge_index = Math.floor(Math.random() * badge.length);
		var badge_color = badge[badge_index];		//徽章颜色
		var divisible = i%2==0;
		
		var Htitle = hotspots[i].title.trim();
		Htitle = Htitle.length > 100 ? Htitle.substr(0,30) : Htitle;
		Htitle = Htitle.replace(/\"/g,"");
		
		var Hcontent = hotspots[i].content;
//		var Hcontent = hotspots[i].content.replace(/(\r\n)|(\n)/g,"<br>").replace(/[(^\s+)|(\s+$)]/g,"<br>　　");
//		var result = pattern.test(Hcontent);
//		Hcontent = Hcontent.replace(/\"/g,"");
//		
//		Hcontent = result ? Hcontent.replace("<br>","") : Hcontent;

		Hcontent = Hcontent.length > 100 ? (Hcontent.substr(0,100)+"...") : Hcontent;
		
		var ID = hotspots[i].id;		//新闻ID
		
		if(i == 0){
			//默认显示第一个
			html += "<li><div class='timeline-badge "+badge_color+"'><span class='glyphicon glyphicon-credit-card'></span></div><div class='timeline-panel'>"
					+'<div class="timeline-heading"><h4 class="timeline-title tl-title '+className+'" onclick="show_content(this,'+ID+')">'+Htitle
					+"</h4><p><small class='text-muted'>"+time+"</small></p></div><div class='timeline-body'><div class='timeline-content "+className+"'>"
					+Hcontent+"</div></div></div></li>";
		}else{
			if(divisible){
				html += "<li><div class='timeline-badge "+badge_color+"'><span class='glyphicon glyphicon-credit-card'></span></div><div class='timeline-panel'>"
						+'<div class="timeline-heading"><h4 class="timeline-title tl-title '+className+'" onclick="show_content(this,'+ID+')">'+Htitle
						+"</h4><p><small class='text-muted'>"+time+"</small></p></div><div class='timeline-body'><div class='timeline-content "+className+"'>"
						+Hcontent+"</div></div></div></li>";
			}else{
				html += "<li class='timeline-inverted'><div class='timeline-badge "+badge_color+"'><span class='glyphicon glyphicon-credit-card'></span></div>"
						+'<div class="timeline-panel"><div class="timeline-heading"><h4 class="timeline-title tl-title '+className+'" onclick="show_content(this,'+ID+')">'
						+Htitle+"</h4><p><small class='text-muted'>"+time+"</small></p></div><div class='timeline-body'><div class='timeline-content "+className+"'>"
						+Hcontent+"</div></div></div></li>";
			}
		}
	}
	html += suffix;
	return html;
}

//创建统计分析面板
function createTitleAlert(total, Chinese, Korean, Balakrishnan, Tibetan){
	var title_alert_html = "今日已抓取<span class='font-total'>"+total+"</span>篇新闻，其中：";
	for(var i in LANGS_SET){
		var lang_label = LANGS_SET[i];
		if(lang_label == "中文"){
			title_alert_html += lang_label+"<span class='lang'>"+Chinese+"</span>篇";
		} else if(lang_label == "维文"){
			title_alert_html += lang_label+"<span class='lang'>"+Balakrishnan+"</span>篇";
		} else if(lang_label == "朝文"){
			title_alert_html += lang_label+"<span class='lang'>"+Korean+"</span>篇";
		} else if(lang_label == "藏文"){
			title_alert_html += lang_label+"<span class='lang'>"+Tibetan+"</span>篇";
		}
		if(i != LANGS_SET.length-1)
			title_alert_html += "，";
	}
//	var title_alert_html = "今日已抓取<span class='font-total'>"+total+"</span>篇新闻；中文<span class='lang'>"+Chinese
//									+"</span>篇，朝文<span class='lang'>"+Korean+"</span>篇，维文<span class='lang'>"+Balakrishnan
//									+"</span>篇，藏文<span class='lang'>"+Tibetan+"</span>篇";

	$("#title_alert").html(title_alert_html);
}

//监听鼠标滚动，调整新闻内容显示面板的定位
window.onscroll=function(){
    var theight=getScrollTop();		//获取窗口滚动条的高度
	if(theight>=100){
		$("#panel_show_news").removeClass("panel-fixed");
		$("#panel_show_news").addClass("panel-fixed-2");
	}else{
		$("#panel_show_news").removeClass("panel-fixed-2");
		$("#panel_show_news").addClass("panel-fixed");
	}
}

//计算指定时间距离现在有多久
function formatTime(dateStr){
	var now = new Date();		//当前时间
	var old_time = new Date(dateStr.replace(/-/g,   "/"));
	//var old_time =Date.parse
	var days =(now.getTime() - old_time.getTime()) / 86400000;
	//alert(now)
	var time = "";
	if(parseInt(days) > 2){
		time = dateStr;
	}else{
		var hours = days * 24;		//计算小时
		if(parseInt(hours) < 1){
			var mimutes = hours * 60;
			if(parseInt(mimutes) < 1 ){
				time = "刚刚";
			}else{
				time = parseInt(mimutes)+"分钟以前"
			}
		}else{
			time = parseInt(hours)+"小时以前"
		}
	}
	//alert(time)
	return time;
}

//获取窗口滚动条高度
function getScrollTop(){  
    var scrollTop=0;  
    if(document.documentElement&&document.documentElement.scrollTop){  
        scrollTop=document.documentElement.scrollTop;  
    }else if(document.body){  
        scrollTop=document.body.scrollTop;  
    }  
    return scrollTop;  
}

//获取更多数据
function takeMore(){
	moreClick++;

	if(moreClick >= maxClick){
		moreClick = maxClick;
		//$('.showMore-a').html("返回顶部 ↑");
		$('body,html').animate({scrollTop:0},1000);	//返回顶部
	}else{
		if(moreClick == (maxClick-1)){
			$('.showMore-a').html("返回顶部 ↑");
		}
		
		var startIndex = moreClick * HOTSPOTS_SHOW;
		var endIndex = (moreClick+1) * HOTSPOTS_SHOW;
		//alert(startIndex+"-----"+endIndex)
		var hotspotsData = hotspotsObj.slice(startIndex, endIndex);
		
		var html = buildTimeLine(hotspotsData, "takeMore");
		$(".timeline").append(html);
	}
}

function hotNewslang(langs){
	var param = {};
	param.appid = '123';
	param.userid = '123';
	param.accesstoken = '123';
	param.langs = langs;
	var result = new Array();
	$.ajax({
		url: "svc/mongo/mwhjsearch/hotNewslang",
		async: false,
		data : param,
		type: "GET",
		contentType: "application/json",
		success: function(data){
			result = data;
		},
		dataType: "json"
	});
	return result;
}

//根据下拉列表框选中语言筛选热点新闻
function langFilter(object, label){
	var langText = $(object).text();
	$("#lang_category").html(langText);
	$('.showMore-a').html("");
	switch(label){
		case "all":
			createTimeLine(hotspotsObj);
		break;
		case "zh":
			var data = filterData(hotspotsObj,"zh-CN");		//筛选数据
			
			if(zhNum != 0){
				data = hotNewslang("zh-CN");
			}
			
			createTimeLine(data,langText);		//创建时间轴
		break;
		case "ko":
			var data = filterData(hotspotsObj,"ko");
			
			if(koNum != 0){
				data = hotNewslang("ko");
			}
			
			createTimeLine(data,langText);
		break;
		case "ui":
			var data = filterData(hotspotsObj,"ui");
			
			if(uiNum != 0){
				data = hotNewslang("ui");
			}
			
			createTimeLine(data,langText);
		break;
		case "bo":
			var data = filterData(hotspotsObj,"bo");
			
			if(boNum != 0){
				data = hotNewslang("bo");
			}
			
			createTimeLine(data,langText);
		break;
	}
}

//按语言筛选热点新闻
function filterData(data, lang){
	//alert(data.length)
	var result = [];
	var isit = {};
	for(var i=0; i<data.length; i++){
		if(data[i].langtype.indexOf(lang) > -1){
			result.push(data[i]);
		}
	}
	return result;
}

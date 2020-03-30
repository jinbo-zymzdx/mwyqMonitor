$(document).ready(pageInit);	//初始化载入

var eventsArray = [];	//全局话题列表
var areaData = null;		//用于绘制新闻趋势图（按语言分类）的数据
var lang_set = [];			//全局语言类型列表，读配置文件


function pageInit(){
	//$('#side-menu').metisMenu();
	
	var statistics;
	
	$.ajax({
		url: "svc/mongo/mwhj/statistics",
		async: false,
		type: "GET",
		contentType: "application/json",
		success: function(data){
			statistics = data;
		},
		dataType: "json"
	});
	
	var newsList = statistics.newsModel;
	var eventList = statistics.eventModel;
	var entityModel = statistics.entityModel;
	var statisticTopic = statistics.statisticTopic;	//话题统计数据
	var topicModel = statistics.topicModel;
	var searchWords = statistics.searchWords;
	var provinces = statistics.userLocations;
	var data = statistics.autoCompletes;
	
	areaData = newsList;
	
	drawArea(newsList);		//绘制新闻趋势图
	drawLine(eventList);		//绘制话题折线图
	drawEntityPie(entityModel);	//绘制实体统计双层饼图
	drawTopicPie(statisticTopic);	//绘制话题统计双层饼图
	drawCloud(searchWords);		//绘制搜索热词排行词云图
	drawMap(provinces);			//绘制用户访问热度地图
	getEventPage(topicModel);	//生成历史话题排行列表
	
	autoComplete(data);		//搜索提示，方法位于search.js
	
	eventsArray = statistics.topicModel;
}

/**
 * 绘制新闻趋势图
 * 
 * @param {Object} newsList
 */
function drawArea(newsList){
	var ykey = [];
	for(var i in LANGS_SET){
		var lang = LANGS_SET[i];
		if(lang == "中文"){
			ykey.push("chinese");
		}else if(lang == "朝文"){
			ykey.push("korean");
		}else if(lang == "维文"){
			ykey.push("balakrishnan");
		}else if(lang == "藏文"){
			ykey.push("tibetan");
		}
	}
	var areaContent = {};
	areaContent.div = "news_count_chart";	//div name
	newsList = newsList.sort(sort_by('date',false,String));
	areaContent.data = newsList;
	areaContent.xkey = "date";		//x轴划分关键字，即x轴的显示字段
	//areaContent.ykey = ['chinese','korean','balakrishnan','tibetan','total'];
	//areaContent.ykey = ['chinese','korean','balakrishnan','tibetan'];
	areaContent.ykey = ykey;
	//areaContent.labels = ['中文','朝文','维文','藏文','总计'];
	//areaContent.labels = ['中文','朝文','维文','藏文'];
	areaContent.labels = LANGS_SET;
	
	//绘制新闻趋势图
	morrisArea(areaContent,function(){
		//alert("趋势图点击事件")
	});
}

/**
 * 绘制话题折线统计图
 * 
 * @param {Object} eventList
 */
function drawLine(eventList){
	//话题数量折线图
	var ykey = [];
	for(var i in LANGS_SET){
		var lang = LANGS_SET[i];
		if(lang == "中文"){
			ykey.push("chinese");
		}else if(lang == "朝文"){
			ykey.push("korean");
		}else if(lang == "维文"){
			ykey.push("balakrishnan");
		}else if(lang == "藏文"){
			ykey.push("tibetan");
		}
	}
	var temp_ls = LANGS_SET;
	temp_ls.push("总计");
	ykey.push("total");
	
	var lineContent = {};
	lineContent.div = "event_count_chart";
	lineContent.data = eventList;
	lineContent.xkey = "date";
//	lineContent.ykey = ['chinese','korean','balakrishnan','tibetan','total'];
	lineContent.ykey = ykey;
//	lineContent.labels = ['中文','朝文','维文','藏文','总计'];
	lineContent.labels = temp_ls;
//	lineContent.ykey = ['korean','balakrishnan','tibetan','total'];
//	lineContent.labels = ['朝文','维文','藏文','总计'];
	
	//绘制话题数量折线图
	morrisLine(lineContent);	//morrisLine in charts.draw.js
}

/**
 * 绘制实体统计双层饼图
 * 
 * @param {Object} entityModel
 */
function drawEntityPie(entityModel){
	var categories = new Array();
	var pieData = new Array();
	var entitytotal = 0;	//实体总数
	
	for(var emi = 0; emi < entityModel.length; emi ++){
		var statisticEntityModel = entityModel[emi];
		var langtype = converLang(statisticEntityModel.entitype);
		categories.push(langtype);
		
		entitytotal += statisticEntityModel.sum;
		
		var colortype = converColor(statisticEntityModel.entitype);		
		var drilldown = new Drilldown(langtype,statisticEntityModel.langtype,statisticEntityModel.ratio,colortype);
		var pieDateEntity = new PieData(statisticEntityModel.eratio,colortype,drilldown); 
		
		pieData.push(pieDateEntity);
	}

	var colors = Highcharts.getOptions().colors;
	
	var secondLayer = [];	//第二层数据
	var thirdLayer = [];		//最外层数据
	
	for (var i = 0; i < pieData.length; i++) {
        // add secondLayer data
		var sy_data = pieData[i].y.toFixed(2) * 1.0;	//保留两位有效数字
		if(i == pieData.length-1){
			//最后一个值是100-前面所有的值，确保不会因为四舍五入引发的数据不正确
			var sy_temp = 100.0;
			for(var k=0; k< pieData.length - 1; k++){
				sy_temp -= pieData[k].y.toFixed(2) * 1.0;
			}
			sy_data = sy_temp.toFixed(2) * 1.0;
		}
        secondLayer.push({
            name: categories[i],
            y: sy_data,
            color: pieData[i].color
        });
		
        var etypeall = 0;
        
        // add thirdLayer data
        for (var j = 0; j < pieData[i].drilldown.data.length; j++) {
            var brightness = 0.2 - (j / pieData[i].drilldown.data.length) / 5 ;
			var ty_data = pieData[i].drilldown.data[j].toFixed(2) * 1.0; 		//第三层数据
			
			if(j == pieData[i].drilldown.data.length-1){
				if(j == 0){
					ty_data = sy_data;
				}else{
					var ty_temp = sy_data;
					for(var k=0; k<pieData[i].drilldown.data.length-1; k++){
						ty_temp -= pieData[i].drilldown.data[k].toFixed(2) * 1.0;
					}
					ty_data = ty_temp.toFixed(2) * 1.0;
				}
			}
			
            thirdLayer.push({
				//parentName: pieData[i].drilldown.name,
                name: pieData[i].drilldown.categories[j],
                y: ty_data,
                color: Highcharts.Color(pieData[i].color).brighten(brightness).get()
            });
        }
    }

	var pieContent = {};
	pieContent.div = "#entity_count_chart";
	
	pieContent.secondLayer = secondLayer;
	//alert(JSON.stringify(secondLayer,null,2))
	pieContent.secondHover = "占实体总数百分比";	//鼠标移过第二层饼图浮动显示的标签
	pieContent.thirdLayer = thirdLayer;
	//alert(JSON.stringify(secondLayer,null,2))
	pieContent.thirdHover = "占实体百分比";		//鼠标移过第三层饼图浮动显示的标签
	
	var eventCount = entitytotal;	//实体总数
	
	//绘制实体统计双层饼图
	hcdrawPieChart(pieContent);
	
	$("#entity_count_chart").append("<div class='explantion'><span>实体总数："+eventCount+"</span></div>");		//饼图中间空白处显示
}

/**
 * 绘制话题分类统计双层饼图
 * 
 * @param {Object} statisticTopic
 */
function drawTopicPie(statisticTopic){
	
	var categories = new Array();
	var pieData = new Array();
	var data = [];
	var secondLayer = [];	//第二层数据
	var thirdLayer = [];		//最外层数据
	var topicCount = 0;
	var colors = Highcharts.getOptions().colors;
	
	for(var i = 0; i < statisticTopic.length; i ++){
		topicCount += statisticTopic[i].topicCount;
		data.push({
			y : statisticTopic[i].langRatio,
			color : converColor(statisticTopic[i].langType),
			drilldown : {
				name : statisticTopic[i].langType,
				categories : statisticTopic[i].topicType,
				data : statisticTopic[i].topicRatio,
				color : converColor(statisticTopic[i].langType)
			}
		});
	}
	
	for (var i = 0; i < data.length; i++) {
		
		var sy_data = data[i].y.toFixed(2) * 1.0;	//保留两位有效数字
		if(i == data.length-1){
			//最后一个值是100-前面所有的值，确保不会因为四舍五入引发的数据不正确
			var sy_temp = 100.0;
			for(var k=0; k< data.length - 1; k++){
				sy_temp -= data[k].y.toFixed(2) * 1.0;
			}
			sy_data = sy_temp.toFixed(2) * 1.0;
		}
		
        secondLayer.push({
            name: data[i].drilldown.name,
            y: sy_data,
            color: data[i].color
        });
		
		var y_temp = 0.0;
        for (var j = 0; j < data[i].drilldown.data.length; j++) {
            var brightness = 0.2 - (j / data[i].drilldown.data.length) / 5 ;
			
			var ty_data = data[i].drilldown.data[j].toFixed(2) * 1.0; 		//第三层数据
			
			if(j == data[i].drilldown.data.length-1){
				if(j == 0){
					ty_data = sy_data;
				}else{
//					var ty_temp = sy_data;
					var ty_temp = 100;
					for(var k=0; k<data[i].drilldown.data.length-1; k++){
						ty_temp -= data[i].drilldown.data[k].toFixed(2) * 1.0;
					}
					ty_data = ty_temp.toFixed(2) * 1.0;
				}
			}
			
			if(data[i].drilldown.categories[j] != null){
				 thirdLayer.push({
	                name: data[i].drilldown.categories[j],
	                //y: data[i].drilldown.data[j],
	                y: ty_data,
	                color: data[i].drilldown.color
	            });
			}
        }
    }
	
	var topicPie = {};
	topicPie.div = "#topic_count_chart";
	topicPie.secondLayer = secondLayer;	//沿用实体统计的数据
	topicPie.secondHover = "占话题总数百分比";		//鼠标移过第二层饼图浮动显示的标签
	topicPie.thirdLayer = thirdLayer;
	topicPie.thirdHover = "占话题百分比";		//鼠标移过第三层饼图浮动显示的标签
	
	hcdrawPieChart(topicPie);
	$("#topic_count_chart").append("<div class='explantion'><span>话题总数："+topicCount+"</span></div>");		//饼图中间空白处显示
}

/**
 * 绘制话题分类统计双层饼图
 * 
 * @param {Object} statisticTopic
 */
function drawTopicPie_old(statisticTopic){
	var categories = new Array();
	var pieData = new Array();
	var data = [];
	var secondLayer = [];	//第二层数据
	var thirdLayer = [];		//最外层数据
	var topicCount = 0;
	var colors = Highcharts.getOptions().colors;
	
	for(var i = 0; i < statisticTopic.length; i ++){
		topicCount += statisticTopic[i].topicCount;
		data.push({
			y : statisticTopic[i].langRatio,
			color : converColor(statisticTopic[i].langType),
			drilldown : {
				name : statisticTopic[i].langType,
				categories : statisticTopic[i].topicType,
				data : statisticTopic[i].topicRatio,
				color : converColor(statisticTopic[i].langType)
			}
		});
	}
	
	for (var i = 0; i < data.length; i++) {
		
		var sy_data = data[i].y.toFixed(2) * 1.0;	//保留两位有效数字
		if(i == data.length-1){
			//最后一个值是100-前面所有的值，确保不会因为四舍五入引发的数据不正确
			var sy_temp = 100.0;
			for(var k=0; k< data.length - 1; k++){
				sy_temp -= data[k].y.toFixed(2) * 1.0;
			}
			sy_data = sy_temp.toFixed(2) * 1.0;
		}
		
        secondLayer.push({
            name: data[i].drilldown.name,
            y: sy_data,
            color: data[i].color
        });
		
		var y_temp = 0.0;
        for (var j = 0; j < data[i].drilldown.data.length; j++) {
            var brightness = 0.2 - (j / data[i].drilldown.data.length) / 5 ;
			
			var ty_data = data[i].drilldown.data[j].toFixed(2) * 1.0; 		//第三层数据
			
			if(j == data[i].drilldown.data.length-1){
				if(j == 0){
					ty_data = sy_data;
				}else{
					var ty_temp = sy_data;
					for(var k=0; k<data[i].drilldown.data.length-1; k++){
						ty_temp -= data[i].drilldown.data[k].toFixed(2) * 1.0;
					}
					ty_data = ty_temp.toFixed(2) * 1.0;
				}
			}
			
			if(data[i].drilldown.categories[j] != null){
				 thirdLayer.push({
	                name: data[i].drilldown.categories[j],
	                //y: data[i].drilldown.data[j],
	                y: ty_data,
	                color: data[i].drilldown.color
	            });
			}
        }
    }
	
	var topicPie = {};
	topicPie.div = "#topic_count_chart";
	topicPie.secondLayer = secondLayer;	//沿用实体统计的数据
	topicPie.secondHover = "占话题总数百分比";		//鼠标移过第二层饼图浮动显示的标签
	topicPie.thirdLayer = thirdLayer;
	topicPie.thirdHover = "占话题百分比";		//鼠标移过第三层饼图浮动显示的标签
	
	hcdrawPieChart(topicPie);
	$("#topic_count_chart").append("<div class='explantion'><span>话题总数："+topicCount+"</span></div>");		//饼图中间空白处显示
}

/**
 * 绘制搜索热词排行词云图
 * 
 * @param {Object} searchWords
 */
function drawCloud(searchWords){
	var keywords = _.pluck(searchWords, 'name');
	var weights =  _.pluck(searchWords, 'weights');
	var divID = "#keyword_top_chart";
	var div_width = $(divID).width();
	
	//词云图点击事件
	var cloudClickEvent = function(d){
		var conditions = [];
		conditions.push({
			label : decodeURI(encodeURIComponent(d.text)),
			type : ""
		});
		
//		var condition = "";
//		var keyword = d.text;
//		condition += "keyword="+ encodeURIComponent(keyword) + "&maxNum=" + maxNum + "&dates=" + dates + "&langs=" + langs;
//		condition += "keyword="+ keyword + "&maxNum=" + maxNum + "&dates=" + dates + "&langs=" + langs;

		
		var maxNum = $(PAGESIZE).val();		//设置面板的最大搜索数
		var dates = $(DATE).val();						//时间选择
		var langs = "";										//语言

		if(maxNum == ""){
			maxNum = DEFNEWSNUM;
		}
		
		if(dates == ""){
			dates = DEFDATE;
		}
		
		$("input[name='cbLanguage']:checked").each(function () {
	        langs += this.value;
	    });
		
		conditions.push({
			"seting": {
				maxNum:		maxNum,
				dates:			dates,
				langs:			langs
			}
		});
		
		var condition = "";
		var keyword = d.text;
		condition += "appid=123&userid=123&accesstoken=123&";
		condition += "keyword="+ encodeURIComponent(keyword) + "&maxNum=" + maxNum + "&dates=" + dates + "&langs=" + langs;
		
//		window.open("index.html?conditions="+JSON.stringify(conditions));
//		window.open("index.html?conditions="+JSON.stringify(conditions));
		window.open("index.html?" + condition);
	}

	var cloudOptions = {
		"keywords": keywords,
		"weights" : weights,
		"width": div_width,
		"height": 350,
		"container" : divID,
		"clickEvent": cloudClickEvent
	};
	//alert(JSON.stringify(cloudOptions,null,2))
	d3drawCloud(cloudOptions);
}

/**
 * 按语言或网站来源绘制新闻趋势图
 * 
 * @param {Object} object
 * @param {Object} category
 */
function drawByCategory(object, category){
	var thisCategory = $(object).text();	//语言或网站来源
	$("#news_category").html(thisCategory);	
	$("#news_count_chart").empty();		//清空div
	
	if(category == "source"){
		//按网站来源
		var getResult = null;
		$.ajax({
			url : "svc/mongo/mwhjsearch/newsBySource",
			type : "GET",
			async : false,
			contentType : "application/json",
			success : function(data){
				//alert(JSON.stringify(data,null,2));
				getResult = data;
			},
			dataType : "json"
		});
		
//		alert(JSON.stringify(getResult));
		
		var areaContent = {};
		areaContent.div = "news_count_chart";	//div name
		areaContent.data = getResult.data.sort(sort_by('date',false,String));
		areaContent.xkey = "date";		//x轴划分关键字，即x轴的显示字段
		areaContent.ykey = getResult.ykeys;
		areaContent.labels = getResult.labels;
		
		//绘制新闻趋势图
		morrisArea(areaContent,function(){
			//alert("趋势图点击事件")
		});
	}else{
		//按语言
		drawArea(areaData);
	}
}

var pageCount=0;	//总页数
/**
 * 生成历史话题排行列表
 * 
 * @param {Object} eventsList
 */
function getEventPage(eventsList){
	var ListLength = eventsList.length/10;
	
	var index = String(ListLength).indexOf("."); 
	var pageNum = index > -1 ? String(ListLength).substring(0,index)*1+1 : ListLength;		//总页数

	var html = "";
	var pageMess = "1 / "+pageNum;		//页数信息显示，形如：1/20，默认定位在第一页
	var eventShowList = eventsList.slice(0,10);		//一页显示10条
	
	html = buildTopicHtml(eventShowList);  //生成历史话题排行html
	$("#event_top_chart").html("");
	$("#event_top_chart").html(html);

	 //分页点击事件
	 var pageEvent = function(page){
		redirect(page);
		pageMess = page+" / "+pageNum;
		$("#pageMess").html(pageMess);
	}
	pagination("#pagination", pageNum, pageEvent);		//生成分页
	 
	 $("#pageMess").html(pageMess);
}

//根据页码翻页
function redirect(current){
	var eventNum = eventsArray.length;	//话题总数
	var startIndex = (current - 1) * 10; 		//话题列表截取的起始下标
	var endIndex = current * 10 > eventNum ? eventNum : current * 10; //话题列表截取的终止下标
	var eventShowList = eventsArray.slice(startIndex, endIndex);

	var html = buildTopicHtml(eventShowList);		//生成话题历史排行html

	$("#event_top_chart").html(html);
}

//历史话题按时间排行
function event_groupbytime(obj,dates){
	var thisTime = $(obj).text();

	var param = {};
	param.appid = "";
	param.userid = "";
	param.accesstoken = "";
	param.dates = dates;

	$("#event_groupTime").html(thisTime);
	
	var topicModel;
	
	$.ajax({
		url: "svc/mongo/mwhjsearch/historyTopic",
		data: param,
		async: false,
		type: "GET",
		contentType: "application/json",
		success: function(data){
			topicModel = data;
		},
		dataType: "json"
	});
	
	eventsArray = topicModel;
	
	getEventPage(topicModel);
}

//根据话题集合生成历史话题排行html
function buildTopicHtml(eventShowList){
	//alert(JSON.stringify(eventShowList,null,2))
	var html="";
	for(var i=0; i< eventShowList.length; i++){
		var condition = "";
		condition += "appid=" + "undefined";
		condition += "&userid=" + "undefined";
		condition += "&accesstoken=" + "undefined";
		condition += "&eventid=" + encodeURIComponent(eventShowList[i].eventid);
		condition += "&eventname=" + encodeURIComponent(eventShowList[i].eventname);
		var lang_Type = eventShowList[i].lang_Type;
		var title = eventShowList[i].eventname;
		var show_title = title.length > 110 ? (title.substring(0,110)+"...") : title;
		
		var className = lang_Type.indexOf("ui") > -1 ? "lang-ui" : "";
		html += "<li class='clearfix'><div class='chat-body clearfix'><div class='header'><a href='report.html?"+ condition +"' target='_blank' title='"+title+"' class='"+className+"'>"
				+show_title+"</a><small class='pull-right text-muted'><i class='fa fa-clock-o fa-fw'></i>"+eventShowList[i].date+"</small></div></div></li>";
	}
	return html;
}

/**
 * 绘制访问用户热度地图
 * 
 * @param {Object} provinces
 */
function drawMap(provinces){
	$("#visitors_level_chart").SVGMap({
		mapName: 'china',
		provinces : provinces,
		mapWidth: "100%",
		mapHeight: 400,
		clickCallback: function(stateData, obj){
			//alert(PlaceCode[obj.id]);
		}
	});
}

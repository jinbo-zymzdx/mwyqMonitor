/**
 * 搜索提示
 */
$.widget( "custom.catcomplete", $.ui.autocomplete, {
	_renderMenu: function( ul, items ) {
		items = items.slice(0,10);
		var that = this,
			currentType = "";
		$.each( items, function( index, item ) {
			var li;
			li = that._renderItemData( ul, item );
			var glyphicon = getGlyphicon(item.type);

			li.prepend(glyphicon);
			
			if ( item.type ) {
				li.attr( "aria-label", item.label + "#" + item.type );
			}
		});
	}
});

//根据类型获取图标
function getGlyphicon(type){
	var glyphicon = "";
	if(type.indexOf("PER") != -1){
		glyphicon = '<span class="glyphicon glyphicon-user" title="PER"></span>  ';
	}else if(type.indexOf("ORG") != -1){
		glyphicon = '<span class="glyphicon glyphicon-bookmark" title="ORG"></span>  ';
	}else if(type.indexOf("LOC") != -1){
		glyphicon = '<span class="glyphicon glyphicon-map-marker" title="LOC"></span>  ';
	} else{
		glyphicon = '<span class="glyphicon glyphicon-question-sign" title="OTHER"></span>  '
	}
	return glyphicon;
}

function autoComplete(data){
	$("#conditions_keyword")
	.catcomplete({
		minLength: 0,
		source: data,
		focus: function() {
			return true;
		},
		select : function(event, ui){
			var label = ui.item.label;		//文本
			var type = ui.item.type;		//类型
			
			var tag_html = "";
			var glyphicon = getGlyphicon(type);
			tag_html = "<span class='label label-primary conditons_tag'>"+ glyphicon + "<span class='conditions-keyword'>"
							+ label +"</span><span class='glyphicon glyphicon-remove glyphicon-remove-hide'></span></span>";
			
			$("#conditions_tagList").append(tag_html);
			//清空输入框
			$("#conditions_keyword").val("");
			
			//搜索标签删除图标显示与隐藏
			$(".conditons_tag").mouseover(function(){
				$(this).find(".glyphicon-remove-hide").show();
			});
			$(".conditons_tag").mouseout(function(){
				$(this).find(".glyphicon-remove-hide").hide();
			});
			$(".conditons_tag").click(function(){
				$(this).remove();
			});
			
			return false;
		}
	});
	
	//搜索标签删除图标显示与隐藏
	$(".conditons_tag").mouseover(function(){
		$(this).find(".glyphicon-remove-hide").show();
	});
	$(".conditons_tag").mouseout(function(){
		$(this).find(".glyphicon-remove-hide").hide();
	});
	$(".conditons_tag").click(function(){
		$(this).remove();
	});
}

/**
 * 获取搜索条件列表
 * @param {Object} tag
 */
function getConditions(tag){
	//获取输入框的值
	var conditions = [];	//搜索条件集合
	
	var queryWordModel = ""; 
	var keyword = "";
	
	var allspan = $("#conditions_tagList > span");
	$.each(allspan,function(){
		var type = $(this).find("span:first").attr("title");				//搜索关键字的类型
		var label = $(this).find(".conditions-keyword").text();	//搜索关键字
		var condition_temp = {};
		condition_temp.type = type;
		condition_temp.label = decodeURI(encodeURIComponent(label));
//		condition_temp.label = encodeURIComponent(label);
		
		//add 2014-12-19 
		queryWordModel += condition_temp.label + ":" + condition_temp.type + "@@";
//		keyword += condition_temp.label + " ";
		
		conditions.push(condition_temp);
	});
	
	queryWordModel = queryWordModel.substring(0, queryWordModel.length - 2);
	
	
	var customKey = $("#conditions_keyword").val();		//用户自定义关键词
	if(customKey != ""){
		conditions.push({
			type : "", 
			label : decodeURI(encodeURIComponent(customKey))
		});
		keyword += decodeURI(encodeURIComponent(customKey)) + " ";
//		keyword += customKey + " ";
	}
	keyword = keyword.trim();
	
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
//	var keyword = d.text;
	condition += "appid=123&userid=123&accesstoken=123&";
//	condition += "keyword="+ encodeURIComponent(keyword) + "&maxNum=" + maxNum + "&dates=" + dates + "&langs=" + langs + "&words=" + queryWordModel;
	condition += "keyword="+ keyword + "&maxNum=" + maxNum + "&dates=" + dates + "&langs=" + langs + "&words=" + queryWordModel;
	
	if(conditions != ""){
		if(tag == "blank"){
		//在首页搜索，不打开新窗口
//			location.href = "index.html?conditions="+JSON.stringify(conditions);
			location.href = "index.html?"+ condition;
		}else{
			//定向到首页
//			window.open("index.html?conditions="+JSON.stringify(conditions));
			window.open("index.html?conditions="+ condition);
			//location.href = "index.html?conditions="+JSON.stringify(conditions);
		}
	}else{
		alert("请选择或输入关键词！")
	}
}

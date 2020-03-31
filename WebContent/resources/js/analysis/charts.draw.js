//绘制趋势图
function morrisArea(areaContent, areaFun){
	$("#" + areaContent.div).unbind("click");
	Morris.Area({
		element: areaContent.div,	//div name
		data: areaContent.data,
		xkey: areaContent.xkey,	//横坐标
		ykeys: areaContent.ykey,
		labels: areaContent.labels,	
		pointSize: 2,		//趋势图上点得大小，数值越大点越大
        hideHover: 'auto',
		lineWidth: 2,
        resize: true,		//自动调整大小
        parseTime: false,		//设置时间不自动转换
        behaveLikeLine: true	//叠加或重叠
	}).on("click",areaFun);	//趋势图的点击事件
}

//绘制折线统计图
function morrisLine(lineContent){
	Morris.Line({
        element: lineContent.div,		//div name
        data: lineContent.data,
        xkey: lineContent.xkey,
        ykeys: lineContent.ykey,
        labels: lineContent.labels,
        hideHover: 'auto',
        resize: true
    });
}

//绘制柱状图
function morrisBar(barContent, barFun){
	if(barContent.data.length == 0){
		$("#" + barContent.div).html("<div class='notfind row'><span'>未抽取到 "+ barContent.type +" 实体</span></div>");
	}else {
		$("#" + barContent.div).unbind("click");
		
		Morris.Bar({
			element : barContent.div,		//div name
			data : barContent.data,
			xkey : barContent.xkeys,
			ykeys : barContent.ykey,
			labels : barContent.labels,
			barColors : barContent.barColor,
			hideHover : 'auto',
			resize : true,
			xLabelAngle : 45,		// x轴文本的倾斜角度
			xLabelFormat: function (x) {
				var xLable = x.src.name;
				return xLable.substring(0,3);		//限制x轴文本的显示长度
			 },
			 hoverCallback: function (index, options, content, row) {
			  	return row.name+"："+row.value;
			}
		}).on('click',barFun);
	}
}

//绘制实体双层饼图
function hcdrawPieChart(pieContent){
	//alert(JSON.stringify(pieContent,null,2))
	var bodyWidth = document.documentElement.scrollWidth;		//获取显示屏宽度

	var inSize = "58%";
	var inInterSize = "28%";
	var outerSize = "72%";
	var outerInnerSize = "53%";
	
	if(bodyWidth < 1366){
		inSize = "45%";
		inInterSize = "20%";
		outerSize = "50%";
		outerInnerSize = "40%";
	}
	
	var seColor = pieContent.thirdLayer.length > 0 ? "#FFF" : "#666";
	var seDistance = pieContent.thirdLayer.length > 0 ? -35 : 25;
	
	$(pieContent.div).highcharts({
		chart: {
            type: 'pie'
        },
		title: {
            text: ''
        },
		plotOptions: {
            pie: {
				//allowPointSelect: true,
				//showInLegend: true,
                shadow: false,
                center: ['50%', '50%'],
				events:{
					click:function(){
						//alert("双层饼图点击事件")
					}
				}
            }
        },
		tooltip: {
//    	    valueSuffix: '%',
    		formatter: function() {
    			//return '<b>' + this.point.name + '</b>: ' + this.percentage + ' %';
    			return '<b>' + this.point.name + '</b><br/>'+ this.series.name + ':' + Highcharts.numberFormat(this.y, 2, '.') + '%';
    		},
    		style: {
    			padding: '16px'		//鼠标移上去，显示面板的填充像素
    		}
        },
        series: [{
				//最里层饼图，空白
				name:"",
				data:"",
				size:"25%",
			}, {
				//内层饼图
	            name: pieContent.secondHover,
	            data: pieContent.secondLayer,
//	            pointFormat: '{point.txt}: <b>{point.percentage}%</b>',
	            size: inSize,
				innerSize: inInterSize,		//设置饼图内圈尺寸
	            dataLabels: {
					enabled: true,
	                formatter: function() {
						if(seColor == "#FFF"){
							return this.y > 1 ? this.point.name : null;
						}else{
							return this.y > 1 ? '<b>'+ this.point.name +':</b> '+ Highcharts.numberFormat(this.y, 2, '.') +'%'  : null;
						}
	                },
	                color: seColor,
	                distance: seDistance		//内圈文本显示位置
	            }
	        }, {
				//外层饼图
	            name: pieContent.thirdHover,
	            data: pieContent.thirdLayer,
	            size: outerSize,		
	            innerSize: outerInnerSize,		//设置饼图外圈尺寸
	            dataLabels: {
					enabled: true,
	                formatter: function() {
	                    // display only if larger than 1
//	                    return this.y > 1 ? '<b>'+ this.point.name +':</b> '+ this.y +'%'  : null;
	        			return this.y > 1 ? '<b>'+ this.point.name +':</b>'+ Highcharts.numberFormat(this.y, 2, '.') +'%'  : null;
//	        			return '<b>' + this.point.name + '</b>: ' + Highcharts.numberFormat(this.y, 2, '.') + '%';
	                },
					distance: 20		//标识线的长度
	        	}
	        }]
	});
}

//制作词云 copy of hcdraw.js
function d3drawCloud(cloudOptions) {
	if($(cloudOptions.container).children( "svg" ).length != 0){
		$(cloudOptions.container).empty();
	}
	
	var fill = d3.scale.category20();
	var words = cloudOptions.keywords;
	var flag = 0;
	  d3.layout.cloud().size([cloudOptions.width, cloudOptions.height])
	      .words(words.map(function(d) {
//	    	  alert(JSON.stringify(d) + flag);
	    	  if(cloudOptions.weights == undefined ){
	    		  flag ++;
	    		  return {text: d, size: 10 + Math.random() * 40};
	    	  }else {
//	    		  return {text: d, size: 10 + parseFloat(cloudOptions.weights[flag]) * 90};
//	    		  alert(10 * (words.length - flag) + Number(parseFloat(cloudOptions.weights[flag]) * 10));
	    		  flag ++;
	    		  return {text: d, size: 2 * (words.length - flag) + Number(parseFloat(cloudOptions.weights[flag]) * 10)};
	    	  }
	    	  
	      }))
	      .padding(5)
	      .rotate(function() { return 0; })
		  //.rotate(function(d) { return ~~(Math.random() * 5) * 30 - 60; })
	      .font("Impact")
	      .fontSize(function(d) { return d.size; })
	      .on("end", draw)
	      .start();

	  function draw(words) {
	    d3.select(cloudOptions.container).append("svg")
	        .attr("width", "100%")
	        .attr("height", cloudOptions.height)
	     	.append("g")
	        .attr("transform", "translate("+ cloudOptions.width / 2 +","+ (cloudOptions.height / 2+15) +")")
	      	.selectAll("text")
	        .data(words)
	      	.enter().append("text")
	        .style("font-size", function(d) { return d.size + "px"; })
	        .style("font-family", "Impact")
	        .style("fill", function(d, i) { return fill(i); })
			.style("cursor","pointer")
	        .attr("text-anchor", "middle")
	        .attr("transform", function(d) {
	          return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
	        })
	        .text(function(d) { return d.text; })
			.on("click", cloudOptions.clickEvent);
	  }
 }
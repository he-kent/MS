$(function(){
	home.initCostOfWeek();
	home.initCardStat();
});
var home={
		initCostOfWeek:function(){
			var params={};
			ajax({
				url:contextPath+'/cost/treatmentCostStatList.do',
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					//初始化统计图表
					home.loadCostOfWeekBar(data.payCost);//非VIP
					home.loadCostPcOfWeekBar(data.payCount);//VIp
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		loadCostOfWeekBar:function(data){
			//最近7天内各种支付方式的支付金额统计表
			var costWeekCharts=echarts.init(document.getElementById("CostOfWeekBar"));
			 var datastr=JSON.stringify(data); 
			 //如果data 是空 不渲染图表
			if(baseOpt.strIsEmpty(datastr) || datastr=="[]"){
				fvipCharts.clear();
				return;
				}
			var xAisData=[],seriesData=[];
			$.each(data,function(index,value){
				xAisData.push(value.payTypeMoney);
				var series={};
				series.name=value.payTypeMoney;
				series.type="bar";
				series.barMaxWidth='30px';
				series.data=[];
				series.barGap='40%';
				series.data.push(value.payAmount);
				seriesData.push(series);
			});
			var option={
					title: {
		                text: '最近7天非VIP支付图表',
		                padding:'0',
		                textStyle:{
		                	fontSize:'16px',
		                	color:'#048AFD'
		                }	
		            },
		            tooltip: {},
		            legend: {
		                data:xAisData,
		                top:'25px',
		                padding: [0, 5]
		            },
		            toolbox: {
		                show : true,
		                orient: 'vertical',
		                x: 'right',
		                y: 'center',
		                feature : {
		                    mark : {show: true},
		                    dataView : {show: true, readOnly: false},
		                    magicType : {show: true, type: ['line', 'bar']},
		                    restore : {show: true},
		                    saveAsImage : {show: true}
		                }
		            },
		            calculable : true,
		            xAxis: {
		            	type : 'category',
		            	//data:xAisData,
		            	silent: false,
		                splitLine: {
		                    show: false
		                }
		            },
		            yAxis: {
		            	type : 'value'
		            },
		            series:seriesData
			};
			costWeekCharts.setOption(option,{width:'350px',height:'300px'});
		},
		loadCostPcOfWeekBar:function(data){
			//最近7天内使用vip支付的总次数
			var costCardCharts=echarts.init(document.getElementById("CostPcOfWeekBar"));
			 var datastr=JSON.stringify(data); 
			 //如果data 是空 不渲染图表
			if(baseOpt.strIsEmpty(datastr) || datastr=="[]"){
				vipPayCharts.clear();
				return;
				}
			var option={
					title: {
		                text: '最近7天VIP支付图表',
		                padding:'0',
		                textStyle:{
		                	fontSize:'16px',
		                	color:'#048AFD'
		                }
		            },
		            tooltip: {},
		            toolbox: {
		                show : true,
		                orient: 'vertical',
		                x: 'right',
		                y: 'center',
		                feature : {
		                    mark : {show: true},
		                    dataView : {show: true, readOnly: false},
		                    magicType : {show: true, type: ['line', 'bar']},
		                    restore : {show: true},
		                    saveAsImage : {show: true}
		                }
		            },
		            calculable : true,
		            legend: {
		                data:[data[0].payTypeCount],
		                top:'25px',
		                padding: [0, 5]
		            },
		            xAxis: {
		                data: [data[0].payTypeCount]
		            },
		            yAxis: {},
		            series: [{
		                name: [data[0].payTypeCount],
		                type: 'bar',
		                data: [data[0].payCardCount],
		                barMaxWidth:'30px',
		                barGap:'40%'
		            }]
			};
			costCardCharts.setOption(option);
		},
        initCardStat:function(){
			ajax({
				url:contextPath+'/cost/getCusCardStat.do',
				type:'post',
				data:{},
				dataType:'json',
				success:function(data){
					home.loadCardMoney(data.moneyDatas);
					home.loadCardCount(data.countDatas);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		loadCardMoney:function(data){
			var CardMoneyOfWeekBar=echarts.init(document.getElementById("CardMoneyOfWeekBar"));
			 var datastr=JSON.stringify(data); 
			 //如果data 是空 不渲染图表
			if(baseOpt.strIsEmpty(datastr) || datastr=="[]"){
				vipPayCharts.clear();
				return;
			}
			var xAisData=[],seriesData=[];
			$.each(data,function(index,value){
				xAisData.push(value.cardType);
				var series={};
				series.name=value.cardType;
				series.type="bar";
				series.data=[];
				series.barMaxWidth='30px';
				series.barGap='40%';
				series.data.push(value.cardMoney);
				seriesData.push(series);
			});
			var option={
					title: {
		                text: '最近7天办卡分类统计图表',
		                padding:'0',
		                textStyle:{
		                	fontSize:'16px',
		                	color:'#048AFD'
		                }	
		            },
		            tooltip: {},
		            legend: {
		                data:xAisData,
		                top:'25px',
		                padding: [0, 5]
		            },
		            toolbox: {
		                show : true,
		                orient: 'vertical',
		                x: 'right',
		                y: 'center',
		                feature : {
		                    mark : {show: true},
		                    dataView : {show: true, readOnly: false},
		                    magicType : {show: true, type: ['line', 'bar']},
		                    restore : {show: true},
		                    saveAsImage : {show: true}
		                }
		            },
		            calculable : true,
		            xAxis: {
		            	type : 'category',
		            	//data:xAisData,
		            	silent: false,
		                splitLine: {
		                    show: false
		                }
		            },
		            yAxis: {
		            	type : 'value'
		            },
		            series:seriesData
			};
			CardMoneyOfWeekBar.setOption(option);
		},
		loadCardCount:function(data){
			var CardCountOfWeekBar=echarts.init(document.getElementById("CardCountOfWeekBar"));
			 var datastr=JSON.stringify(data); 
			 //如果data 是空 不渲染图表
			if(baseOpt.strIsEmpty(datastr) || datastr=="[]"){
				vipPayCharts.clear();
				return;
			}
			var xAisData=[],seriesData=[];
			$.each(data,function(index,value){
				xAisData.push(value.cardType);
				var series={};
				series.name=value.cardType;
				series.type="bar";
				series.data=[];
				series.barMaxWidth='30px';
				series.barGap='40%';
				series.data.push(value.cardCount);
				seriesData.push(series);
			});
			var option={
					title: {
		                text: '最近7天办卡次数统计图表',
		                padding:'0',
		                textStyle:{
		                	fontSize:'16px',
		                	color:'#048AFD'
		                }	
		            },
		            tooltip: {},
		            legend: {
		                data:xAisData,
		                top:'25px',
		                padding: [0, 5]
		            },
		            toolbox: {
		                show : true,
		                orient: 'vertical',
		                x: 'right',
		                y: 'center',
		                feature : {
		                    mark : {show: true},
		                    dataView : {show: true, readOnly: false},
		                    magicType : {show: true, type: ['line', 'bar']},
		                    restore : {show: true},
		                    saveAsImage : {show: true}
		                }
		            },
		            calculable : true,
		            xAxis: {
		            	type : 'category',
		            	//data:xAisData,
		            	silent: false,
		                splitLine: {
		                    show: false
		                }
		            },
		            yAxis: {
		            	type : 'value'
		            },
		            series:seriesData
			};
			CardCountOfWeekBar.setOption(option);
		}
};
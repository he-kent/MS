$(function(){
	$( ".datepicker" ).datepicker({
		dateFormat:'yy-mm-dd',
		changeYear:true,
		changeMonth:true
	});
	treatmentstat.initTreatmentCostStat();
});
var  treatmentstat = {
		initTreatmentCostStat:function(){//诊疗费用支付分类统计
			var start=$("#costtime-start").val(),
			    end=$("#costtime-end").val(),
			    params={"start":start,"end":end};
			ajax({
				url:contextPath+'/cost/treatmentCostStatList.do',
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					var treatmentCostStatGridBody=$("#treatmentCostStatGridBody"),
					tcVipPayCountStatGridBody=$("#tcVipPayCountStatGridBody");
					treatmentCostStatGridBody.empty();
					var htmlCost="",htmlCard="";
					$.each(data.payCost,function(index,value){
						htmlCost+="<tr>"+
						      "<td>"+value.payTypeMoney+"</td>"+
						      "<td>"+value.payAmount+"</td>"+
						      "</tr>";
					});
					treatmentCostStatGridBody.html(htmlCost);
					tcVipPayCountStatGridBody.empty();
					$.each(data.payCount,function(index,value){
						htmlCard+="<tr>"+
						      "<td>"+value.payTypeCount+"</td>"+
						      "<td>"+value.payCardCount+"</td>"+
						      "</tr>";
					});
					tcVipPayCountStatGridBody.html(htmlCard);
					//初始化统计图表
					treatmentstat.initfvipCharts(data.payCost);//非VIP
					treatmentstat.initvipCharts(data.payCount);//VIp
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		initfvipCharts:function(data){
			var fvipCharts = echarts.init(document.getElementById("fvipCharts"));
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
				series.data=[];
				series.data.push(value.payAmount);
				seriesData.push(series);
			});
			var options={
					title: {
		                text: '非VIP支付图表',
		            },
		            color:['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3'],
		            tooltip: {},
		            legend: {
		                data:xAisData,
		                top:'25px'
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
			 // 使用刚指定的配置项和数据显示图表。
			fvipCharts.setOption(options);
		},
		initvipCharts:function(data){
			var vipPayCharts = echarts.init(document.getElementById("vipPayCharts"));
			 var datastr=JSON.stringify(data); 
			 //如果data 是空 不渲染图表
			if(baseOpt.strIsEmpty(datastr) || datastr=="[]"){
				vipPayCharts.clear();
				return;
				}
			var options={
					title: {
		                text: 'VIP支付图表',
		            },
		            color:['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3'],
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
		                top:'25px'
		            },
		            xAxis: {
		                data: [data[0].payTypeCount]
		            },
		            yAxis: {},
		            series: [{
		                name: [data[0].payTypeCount],
		                type: 'bar',
		                data: [data[0].payCardCount]
		            }]
			};
			 // 使用刚指定的配置项和数据显示图表。
			vipPayCharts.setOption(options);
		}
};
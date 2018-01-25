$(function(){
	$( ".datepicker" ).datepicker({
		dateFormat:'yy-mm-dd',
		changeYear:true,
		changeMonth:true
	});
	accstat.initAccCostStat();
});
var accstat = {
		initAccCostStat:function(){
			var accType=$("#accType-search").val(),
			    acctimestrat=$("#acctime-start").val(),
			    acctimeend=$("#acctime-end").val(),
			    params={"accType":accType,"startAccTime":acctimestrat,"endAccTime":acctimeend};
			ajax({
				url:contextPath+'/account/accountStatList.do',
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					var accountStatBody=$("#accCostStatGridBody");
					accountStatBody.empty();
					var html="";
					$.each(data.dates,function(index,value){
						html+="<tr>"+
						      "<td>"+value.accItems+"</td>"+
						      "<td>"+accstat.formatAccType(value.accType)+"</td>"+
						      "<td>"+value.accMoney+"</td>"+
						      "</tr>";
					});
					accountStatBody.html(html);
					//初始化图表
					accstat.initAccCostBar(data.dates);
					accstat.initAccCostPie(data.dates);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		formatAccType:function(val){
			if(val=1){
				return "支出";
			}
			if(val=2){
				return "收入";
			}
		},
		initAccCostBar:function(data){
			var accBarChart=echarts.init(document.getElementById("accCostBar"));
			var dataStr=JSON.stringify(data);
			if(baseOpt.strIsEmpty(dataStr) || dataStr=="[]"){
				accBarChart.clear();
				return ;
			}
			var xDatas=[],seriesData=[];
			$.each(data,function(index,value){
				xDatas.push(value.accItems);
				var series={};
				series.name=value.accItems;
				series.type="bar";
				series.data=[];
				series.data.push(value.accMoney);
				seriesData.push(series);
			});
			var option={
					title : {
				        text: '店铺费用统计图表',
				    },
				    tooltip : { },
				    legend: {
				        data:xDatas
				    },
				    toolbox: {
				        show : true,
				        feature : {
				            mark : {show: true},
				            dataView : {show: true, readOnly: false},
				            magicType : {show: true, type: ['line', 'bar']},
				            restore : {show: true},
				            saveAsImage : {show: true}
				        }
				    },
				    calculable : true,
				    xAxis : [
				        {
				            type : 'category',
				            //data : xDatas
				        }
				    ],
				    yAxis : [
				        {
				            type : 'value'
				        }
				    ],
				    series : seriesData
			};
			accBarChart.setOption(option);
		},
		initAccCostPie:function(data){
			var accPieChart=echarts.init(document.getElementById("accCostPie"));
			var dataStr=JSON.stringify(data);
			if(baseOpt.strIsEmpty(dataStr) || dataStr=="[]"){
				accPieChart.clear();
				return ;
			}
			var xDatas=[],seriesData=[];
			$.each(data,function(index,value){
				xDatas.push(value.accItems);
				var ddata={};
				ddata.value=value.accMoney;
				ddata.name=value.accItems;
				seriesData.push(ddata);
			});
			var option={
					 title : {
					        text: '店铺费用统计饼图',
					        x:'center'
					    },
					    tooltip : {
					        trigger: 'item',
					        formatter: "{a} <br/>{b} : {c} ({d}%)"
					    },
					    legend: {
					        orient : 'vertical',
					        x : 'left',
					        data:xDatas
					    },
					    toolbox: {
					        show : true,
					        feature : {
					            mark : {show: true},
					            dataView : {show: true, readOnly: false},
					            magicType : {
					                show: true, 
					                type: ['pie', 'funnel'],
					                option: {
					                    funnel: {
					                        x: '25%',
					                        width: '50%',
					                        funnelAlign: 'left',
					                        max: 1548
					                    }
					                }
					            },
					            restore : {show: true},
					            saveAsImage : {show: true}
					        }
					    },
					    calculable : true,
					    series :[
									{
										name:"支出类型",
										type:"pie",
										radius:'55%',
										center:['50%', '60%'],
										data:seriesData
									}
					             ]
			};
			accPieChart.setOption(option);
		}
};
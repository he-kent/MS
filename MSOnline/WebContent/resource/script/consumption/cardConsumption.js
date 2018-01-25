$(function(){
	xh.initCardConsumption();
});
var xh={
		initCardConsumption:function(){//客户vip卡消费合计 （按卡卡编号）
			var cusName=$("#cusName-search").val(),
			    cusTel=$("#cusTel-search").val(),
			    cusCardNum=$("#cusCardNum-search").val();
			var params ={"cusName":cusName,"cusTel":cusTel,"cusCardNum":cusCardNum};
			ajax({
				url:contextPath+"/cus/cardConsumpList.do",
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					var html="";
					var cardConsumptionDataGrid=$("#cardConsumptionDataGrid");
					cardConsumptionDataGrid.empty();
					$.each(data.datas,function(index,value){
						html+="<tr>"+
						      "<td>"+value.cus_name+"</td>"+
						      "<td>"+value.cus_tel+"</td>"+
						      "<td>"+value.card_num+"</td>"+
						      "<td>"+value.valid_num+"</td>"+
						      "<td>"+value.cardUsed+"</td>"+
						      "<td>"+value.remain+"</td>"+
						      "</tr>";
					});
					cardConsumptionDataGrid.html(html);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		}
};
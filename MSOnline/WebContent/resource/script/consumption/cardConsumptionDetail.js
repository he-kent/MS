$(function(){
	detail.initCardConDetail();
});
var detail={
		initCardConDetail:function(){//客户vip卡消费明细
			var cusName=$("#cusName-search").val(),
			    cusTel=$("#cusTel-search").val(),
			    cusCardNum=$("#cusCardNum-search").val();
			var params ={"cusName":cusName,"cusTel":cusTel,"cusCardNum":cusCardNum};
			ajax({
				url:contextPath+"/cus/cardConsumpDetailList.do",
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					var html="";
					var cardConDetailDataGrid=$("#cardConDetailDataGrid");
					cardConDetailDataGrid.empty();
					$.each(data.datas,function(index,value){
						html+="<tr>"+
						      "<td>"+value.cus_name+"</td>"+
						      "<td>"+value.cus_tel+"</td>"+
						      "<td>"+value.card_num+"</td>"+
						      "<td>"+value.consumption_count+"</td>"+
						      "<td>"+(new Date(value.createtime)).Format("yyyy-MM-dd hh:mm:ss")+"</td>"+
						      "</tr>";
					});
					cardConDetailDataGrid.html(html);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		}
};
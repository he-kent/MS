$(function(){
	cost.initCostDataGrid();
});
var cost ={
		initCostDataGrid:function(){
			var params ={};
			ajax({
				url:contextPath+"/treatment/costList.do",
				data:params,
				dataType:'json',
				type:'post',
				success:function(data){
					var html="";
					var costDataGridBody= $("#costDataGridBody");
					costDataGridBody.empty();
					$.each(data.dates,function(index,value){
						html+="<tr>"+
						     "<td style=\"display:none;\">"+value.costId+"</td>"+
						     "<td style=\"display:none;\">"+value.cusId+"</td>"+
						     "<td style=\"display:none;\">"+value.caseId+"</td>"+
						     "<td>"+value.cus_name+"</td>"+
						     "<td>"+value.cus_tel+"</td>"+
						     "<td>"+value.cus_sex+"</td>"+
						     "<td>"+value.treatment_item+"</td>"+
						     "<td>"+value.physician_signature+"</td>"+
						     "<td>"+value.treatment_cost+"</td>"+
						     "<td>"+value.pay_amount+"</td>"+
						     "<td>"+cost.formatCol(value.pay_type)+"</td>"+
						     "<td>"+(value.pay_card_type?value.pay_card_type:'')+"</td>"+
						     "<td>"+(value.pay_time?new Date(value.pay_time).Format('yyyy-MM-dd hh:mm:ss'):'')+"</td>"+
						     "<td>"+value.pay_status+"</td>"+
						     "<td>"+value.pay_card_num+"</td>"+
						     "</tr>";
					});
					costDataGridBody.html(html);
				},
				complete:function(XHR,TestStatus){
					XHR = null;
				}
			});
		},
		formatCol:function(val){
			var txt="";
			switch(val){
			case 1:txt="vip卡支付";
			       break;
			case 2:txt="现金支付";
			       break;
			case 3:txt="支付宝支付";
		           break;
			case 4:txt="微信支付";
		           break;
			case 5:txt="银行卡支付";
		           break;
		    default:txt="";
			}
			return txt;
		}
};
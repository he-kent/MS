$(function(){
cusCard.initCusCardList();
});
var cusCard={
		initCusCardList:function(){
			var cusCardNameOrTel =$("#cusCardNameOrTel").val(), 
			    params ={"cusCardNameOrTel":cusCardNameOrTel};
			ajax({
				url:contextPath+"/cus/cusCardList.do",
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					console.log(data);
					var tbody=$("#cusCardDataGridBody");
					tbody.empty();
					var html="";
					$.each(data.dates,function(index,value){
						html+="<tr id=\""+value.id+"\">"+
						       /*"<td>"+value.id+"</td>"+
						       "<td>"+value.cusId+"</td>"+
						       "<td>"+value.cardId+"</td>"+*/
						       "<td>"+value.cusName+"</td>"+
						       "<td>"+value.cusTel+"</td>"+
						       "<td>"+value.cardNum+"</td>"+
						       "<td>"+value.cardAmount+"</td>"+
						       "<td>"+value.validNum+"</td>"+
						       "<td>"+value.cardMoney+"</td>"+
						       "<td>"+value.cardType+"</td>"+
						       "<td>"+(new Date(value.handlestime).Format("yyyy-MM-dd hh:mm:ss"))+"</td>"+
						       "<td>"+(new Date(value.expirytime).Format("yyyy-MM-dd hh:mm:ss"))+"</td>"+
						       "<td>"+value.handlesCard+"</td>"+
						       "<td>"+value.cardUseStatus+"</td>"+
						       "<td>"+value.handlesNote+"</td>"+
						      "</tr>";
					});
					tbody.html(html);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		}
}
$(function(){
	$( ".datepicker" ).datepicker({
		dateFormat:'yy-mm-dd',
		changeYear:true,
		changeMonth:true
	});
	acc.initAccDateGrid();
});
var acc = {
		initAccDateGrid:function(){
			var accType=$("#accType-search").val(),
			    acctimestrat=$("#acctime-start").val(),
			    acctimeend=$("#acctime-end").val(),
			    params={"accType":accType,"startAccTime":acctimestrat,"endAccTime":acctimeend};
			ajax({
				url:contextPath+'/account/accountList.do',
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					console.log(data);
					var accountBody=$("#accountDataGridBody");
					accountBody.empty();
					var html="";
					$.each(data.dates,function(index,value){
						html+="<tr>"+
						      "<td>"+value.id+"</td>"+
						      "<td>"+value.accItems+"</td>"+
						      "<td>"+value.accMoney+"</td>"+
						      "<td>"+acc.formatAccType(value.accType)+"</td>"+
						      "<td>"+(value.accTime?new Date(value.accTime).Format('yyyy-MM-dd hh:mm:ss'):'')+"</td>"+
						      "<td>"+value.accPeople+"</td>"+
						      "<td>"+value.accNote+"</td>"+
						      "</tr>";
					});
					accountBody.html(html);
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
		openAccAddModal:function(){
			$("#AccAddModal").modal('show');
		},
		addAccount:function(){
			var accItmes =$("#accItmes").val(),
			    accMoney =$("#accMoney").val(),
			    accType=$("#accType").val(),
			    accPeople=$("#accPeople").val(),
			    accNote=$("#accNote").val(),
			    params={"accItmes":accItmes,"accMoney":accMoney,"accType":accType,"accPeople":accPeople,"accNote":accNote};
			ajax({
				url:contextPath+"/account/addAccount.do",
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					if(data.msg==1){
						$("#AccAddModal").modal('hide');
						acc.initAccDateGrid();
					}else{
						alert("记账失败！");
					}
				},complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		closeModal:function(modalId,formId){
			$("#AccAddModal").modal('hide');
			document.getElementById(formId).reset();
		}
};
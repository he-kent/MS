$(function(){
	card.cardListInit();
	$( ".datepicker" ).datepicker({
		dateFormat:'yy-mm-dd',
		changeYear:true,
		changeMonth:true
	});
	/*card.initCardTypeOpt('card-type-add','card-type-update');*/
});
var card={
		cardListInit:function(){
			var cardname=$("#cardame-search").val(),
			    params={"cardname":cardname};
			ajax({
				url:contextPath+'/card/getCardList.do',
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					var html="",
					    tbody = $("#cardDataGridBody");
					    tbody.empty();
					$.each(data.dates,function(index,value){
						var expiryTime ="",
						    createtime="",
						    updatetime="";
						
						if(value.expiryTime){
							expiryTime=new Date(value.expiryTime).Format("yyyy-MM-dd hh:mm:ss");
						}
						if(value.updatetime){
							updatetime=new Date(value.updatetime).Format("yyyy-MM-dd hh:mm:ss");
						}
						if(value.createtime){
							createtime=new Date(value.createtime).Format("yyyy-MM-dd hh:mm:ss");
						}
						html +="<tr id=\""+value.id+"\">"+
						        "<td>"+value.id+"</td>"+
						       /* "<td>"+value.cardNumber+"</td>"+*/
						        "<td>"+value.cardName+"</td>"+
						        "<td>"+value.cardAmount+"</td>"+
						        /*"<td >"+value.cardType+"</td>"+*/
						        "<td>"+expiryTime+"</td>"+
						        "<td>"+value.validNum+"</td>"+
						        "<td>"+(value.cardStatus==1?'有效':'无效')+"</td>"+
						        "<td>"+createtime+"</td>"+
						        "<td>"+updatetime+"</td>"+
						        "<td><a href=\"#\" onclick=\"card.openUpdateCardModal('"+value.id+"')\">修改</a>|<a href=\"#\" onclick=\"card.deleteCard('"+value.id+"')\">删除</a>|<a href=\"#\" onclick=\"card.updateCardStatus('"+value.id+"',1)\">有效</a>|<a href=\"#\" onclick=\"card.updateCardStatus('"+value.id+"',2)\">无效</a></td>"+
						       "</tr>";
					});
					
					tbody.html(html);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		openAddCardWin:function(modalId,formId){
			$("#"+modalId).modal('show');
		},
		closeAddCardWin:function(modalId,formId){
			$("#"+modalId).modal('hide');
			document.getElementById(formId).reset();
		},
		addCard:function(){
			var cardName = $("#cardname-add").val(),
			    validNum =$("#card-validNum-add").val(),
			    expiryTime=$("#card-expiryTime-add").val(),
			    cardStatus=$("#card-status-add").val(),
			    /*cardType=$("#card-type-add").val(),*///"cardType":cardType,
			    cardAmount=$("#cardAmount-add").val(),
			    /*cardNumber=$("#cardNumber-add").val(),*///"cardNumber":cardNumber,
			    cardNote=$("#cardNote-add").val(),
			    params={"cardName":cardName,"validNum":validNum,"expiryTime":expiryTime,"cardStatus":cardStatus,"cardAmount":cardAmount,"cardNote":cardNote};
			ajax({
				url:contextPath+'/card/addCard.do',
				data:params,
				type:'post',
				dataType:'json',
				success:function(data){
					console.log(data);
					if(data.msg == 1){
						card.cardListInit();
					}
					card.closeAddCardWin("addCardModel","addCardForm");
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		deleteCard:function(id){
			ajax({
				url:contextPath+'/card/deleteCard.do',
				type:'post',
				data:{"id":id},
				dataType:'json',
				success:function(data){
					if(data.msg==1){
						card.cardListInit();
					}
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		updateCardStatus:function(id,status){
			ajax({
				url:contextPath+'/card/updateCardStatus.do',
				type:'post',
				dataType:'json',
				data:{"id":id,"status":status},
				success:function(data){
					if(data.msg==1){
						card.cardListInit();
					}
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		openUpdateCardModal:function(id){
			ajax({
				url:contextPath+'/card/getDateById.do',
				type:'post',
				data:{"id":id},
				dataType:'json',
				success:function(data){
					console.log(data);
					$("#cardname-update").val(data.cardName);
				    $("#card-validNum-update").val(data.validNum);
				    $("#card-expiryTime-update").val(data.expiryTime);
				    $("#card-status-update").val(data.cardStatus);
				    /*$("#card-type-update").val(data.cardType);*/
				    $("#cardAmount-update").val(data.cardAmount);
				    $("#cardNote-update").val(data.cardNote);
				    $("#updateCardId").val(data.id);
					$('#updateCardModel').modal('show');
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		updateCard:function(){
			var cardName = $("#cardname-update").val(),
		    validNum =$("#card-validNum-update").val(),
		    expiryTime=$("#card-expiryTime-update").val(),
		    cardStatus=$("#card-status-update").val(),
		   /* cardType=$("#card-type-update").val(),*///"cardType":cardType,
		    cardAmount=$("#cardAmount-update").val(),
		    cardNote=$("#cardNote-update").val(),
		    id=$("#updateCardId").val(),
		    params={"id":id,"cardName":cardName,"validNum":validNum,"expiryTime":expiryTime,"cardStatus":cardStatus,"cardAmount":cardAmount,"cardNote":cardNote};
			ajax({
				url:contextPath+'/card/updateCard.do',
				data:params,
				type:'post',
				dataType:'json',
				success:function(data){
					console.log(data);
					if(data.msg==1){
						card.cardListInit();
					}
					card.closeAddCardWin('updateCardModel','updateCardForm');
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		initCardTypeOpt:function(selectAddId,selectUpdateId){//初始化表单中的卡类型选项
			var cardTypeAddSelect=$("#"+selectAddId),
			    cardTypeUpdateSelect=$("#"+selectUpdateId);
			    cardTypeAddSelect.empty();
			    cardTypeUpdateSelect.empty();
			ajax({
				url:contextPath+'/dic/getDicDates.do',
				type:'post',
				data:{"dicCode":"1001","dicStatus":1},
				dataType:'json',
				success:function(data){
					console.log(data);
					var html="<option value='0'>请选择</option>";
					$.each(data.dates,function(index,value){
						html+="<option value=\""+value.id+"\">"+value.dicName+"</option>";
					});
					cardTypeAddSelect.html(html);
					cardTypeUpdateSelect.html(html);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		}
		
};
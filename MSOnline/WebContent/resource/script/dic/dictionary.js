$(function(){
	dic.initDicDateGrid();
});
var dic={
		initDicDateGrid:function(){
			var dicname =$("#dicname").val();
			var params ={"dicname":dicname};
			ajax({
				url:contextPath+'/dic/getDicDates.do',
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					console.log(data);
					var tbody = $("#dicDateGridBody"),
					     html="";
					    tbody.empty();
					    $.each(data.dates,function(index,value){
					    	var createtime="",
						        updatetime="";
								if(value.updatetime){
									updatetime=new Date(value.updatetime).Format("yyyy-MM-dd hh:mm:ss");
								}
								if(value.createtime){
									createtime=new Date(value.createtime).Format("yyyy-MM-dd hh:mm:ss");
								}
					    	html+="<tr id=\""+value.id+"\">"+
					    	        "<td>"+value.id+"</td>"+
					    	        "<td>"+value.dicName+"</td>"+
					    	        "<td>"+value.dicCode+"</td>"+
					    	        "<td>"+(value.dicStatus==1?'有效':'无效')+"</td>"+
					    	        "<td>"+createtime+"</td>"+
					    	        "<td>"+updatetime+"</td>"+
					    	        "<td>"+value.dicNote+"</td>"+
					    	        "<td><a href=\"#\" onclick=\"dic.openUpdateDicModal('"+value.id+"')\">修改</a>|<a href=\"#\" onclick=\"dic.deleteDic('"+value.id+"')\">删除</a>|<a href=\"#\" onclick=\"dic.updateDicStatus('"+value.id+"',1)\">有效</a>|<a href=\"#\" onclick=\"dic.updateDicStatus('"+value.id+"',2)\">无效</a></td>"+
					    	       "</tr>";
					    });
					    tbody.append(html);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		openDicModal:function(modalId,formId){
			$('#'+modalId).modal('show');
		},
		closeDicModal:function(modalId,formId){
			$("#"+modalId).modal('hide');
			document.getElementById(formId).reset();
		},
		addDic:function(){
			var dicName =$("#dicname-add").val(),           
			    dicStatus=$("#dicstatus-add").val(),          
			    dicCode=$("#diccode-add").val(),            
			    dicNote=$("#dicnote-add").val(),
			    params={"dicName":dicName,"dicStatus":dicStatus,"dicCode":dicCode,"dicNote":dicNote};
			ajax({
				url:contextPath+'/dic/addDic.do',
				data:params,
				type:'post',
				dataType:'json',
				success:function(data){
					if(data.msg==1){
						dic.initDicDateGrid();
					}
					dic.closeDicModal('addDicModal','addDicForm');
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		updateDic:function(){
			var dicName =$("#dicname-update").val(),
			   id=$("#dicUpdateId").val(),
		       dicStatus=$("#dicstatus-update").val(),          
		       dicCode=$("#diccode-update").val(),            
		       dicNote=$("#dicnote-update").val(),
		      params={"id":id,"dicName":dicName,"dicStatus":dicStatus,"dicCode":dicCode,"dicNote":dicNote};
			ajax({
				url:contextPath+'/dic/updateDic.do',
				data:params,
				type:'post',
				dataType:'json',
				success:function(data){
					if(data.msg==1){
						dic.initDicDateGrid();
					}
					dic.closeDicModal('updateDicModel','updateDicForm');
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		openUpdateDicModal:function(dicId){
			 ajax({
				 url:contextPath+'/dic/getDicById.do',
					data:{"id":dicId},
					type:'post',
					dataType:'json',
					success:function(data){
						console.log(data);
						    $("#dicname-update").val(data.dicName),
						    $("#dicUpdateId").val(data.id),
					        $("#dicstatus-update").val(data.dicStatus),          
					        $("#diccode-update").val(data.dicCode),            
					        $("#dicnote-update").val(data.dicNote),
					        $("#updateDicModel").modal('show');
					},
					complete:function(XHR,TextStatus){
						XHR = null;
					}
			 });
		},
		deleteDic:function(dicId){
			ajax({
				 url:contextPath+'/dic/deleteDic.do',
					data:{"id":dicId},
					type:'post',
					dataType:'json',
					success:function(data){
						console.log(data);
						if(data.msg==1){
							dic.initDicDateGrid();
						}
					},
					complete:function(XHR,TextStatus){
						XHR = null;
					}
			 });
		},
		updateDicStatus:function(dicId,status){
			ajax({
				 url:contextPath+'/dic/updateDicStatus.do',
					data:{"id":dicId,"status":status},
					type:'post',
					dataType:'json',
					success:function(data){
						console.log(data);
						if(data.msg==1){
							dic.initDicDateGrid();
						}
					},
					complete:function(XHR,TextStatus){
						XHR = null;
					}
			 });
		}
		
};
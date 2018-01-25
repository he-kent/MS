$(function(){
     menuOpt.initList();
     $("#menustatu option[value=1]").attr("selected","true");
});
/**
 * 
 * @param objId 模态框ID
 * @param rowId  行ID  子菜单行 id 为  
 * @param update 行数据 （修改时使用）
 */

function openModal(objId,rowId){
	//添加子菜单时 将pid 设置为 rowId
	$("#rowId").val(rowId);
	/*if(update == 'update'){
		//如果是修改 执行下面操作
		var rowDatas = $("#"+rowId).children('td');
		$("#rowId").val(rowDatas[0].innerText);
		$("#menuname-from").val(rowDatas[1].innerText);
		$("#menuurl").val(rowDatas[2].innerText);
		$("#menustatu option[value="+rowDatas[3].innerText+"]").attr('selected',true);
		$("#pid").val(rowDatas[4].innerText);
		$("#menuAddSubmitBtn").hide();
		$("#menuUpdateSubmitBtn").show();
	}else{
		$("#isupdate").val("");
		$("#menuAddSubmitBtn").show();
		$("#menuUpdateSubmitBtn").hide();
	}*/
	$('#'+objId).modal('show');
}
function closeModal(objId,formId){
	$('#'+objId).modal('hide');
	document.getElementById(formId).reset();
}
/*打开修改Modal*/
function openMenuUpdateModal(menuId){
	ajax({
		url:contextPath+'/menu/getDateById.do',
		data:{"id":menuId},
		type:'post',
		dateType:'json',
		success:function(data){
			$("#rowId-update").val(data.id);
			$("#menuname-update").val(data.menuName);
			$("#menuurl-update").val(data.menuUrl);
			$("#menustatu-update").val(data.menuStatus);
			$("#pid-update").val(data.pid);
			$("#updateMenuModal").modal('show');
		},
		complete:function(XHR,TextStatus){
			XHR=null;
		}
	});
}
/*添加菜单*/
function addMenu(){
	var rowId = $("#rowId").val(), pid;
	if(parseInt(rowId)>0){//大于0 表示是添加子菜单  rowId只是一个标识
		$("#pid").val(rowId);
		pid = rowId;
	}else{
		pid = $("#pid").val();
	}
	var menuName = $("#menuname-from").val();
	if(baseOpt.strIsEmpty(menuName)){
		$("#menuname-from").parent(".col-sm-8").addClass(" has-warning has-feedback");
		var iconHtml ="<span class=\"glyphicon glyphicon-warning-sign form-control-feedback\" aria-hidden=\"true\"></span><span id=\"menunameinputstatus\" class=\"sr-only\">(warning)</span>"; 
		$("#menuname-from").after(iconHtml);
	}else{
		$("#menuname-from").parent(".col-sm-8").removeClass(" has-warning has-feedback");
		$("#menuname-from").next('span').remove();
	}
	var menuUrl = $("#menuurl").val(),
	    menuStatu = $("#menustatu").val(),
	    params = {"menuName":menuName,"menuUrl":menuUrl,"menuStatu":menuStatu,"pid":pid};
	ajax({
		url:contextPath+"/menu/addMenu.do",
		data:params,
		type:"post",
		dataType:"json",
		success:function(data){
			console.log(data);
			if(data.msg == '1'){
				 //刷新列表
				  menuOpt.getAllMenus();
				  //关闭添加窗口
				 closeModal("addMenuModal","addMenuForm");
			}else{
				 //关闭添加窗口
				 closeModal("addMenuModal","addMenuForm");
			}
			
		},complete:function(XHR,TextStatus){
			XHR = null;
		}
	});
}
function updateMenu(){
	    var rowId = $("#rowId-update").val(),
	        menuName = $("#menuname-update").val(),
	        menuUrl = $("#menuurl-update").val(),
	        menuStatu = $("#menustatu-update").val(),
	        pid=$("#pid-update").val(),
	        params = {"rowId":rowId,"menuName":menuName,"menuUrl":menuUrl,"menuStatu":menuStatu,"pid":pid};
	    ajax({
			url:contextPath+"/menu/updateMenu.do",
			data:params,
			type:"post",
			dataType:"json",
			success:function(data){
				if(data.msg == '1'){
					//刷新列表
					 menuOpt.getAllMenus();
				}
					 //关闭添加窗口
					 closeModal("updateMenuModal","updateMenuForm");
				
			},complete:function(XHR,TextStatus){
				XHR = null;
			},error:function(XHR){
				console.log(XHR);
			}
		});
}
function updateMenuStatu(id,statu){
	ajax({
		url:contextPath+"/menu/updateMenuStatu.do",
		data:{"id":id,"statu":statu},
		type:"post",
		dataType:"json",
		success:function(data){
			console.log(data);
			if(data.msg == '1'){
				 //刷新列表
				  menuOpt.getAllMenus();
			}else{
				alert("修改失败");
			}
			
		},complete:function(XHR,TextStatus){
			XHR = null;
		}
	});
}
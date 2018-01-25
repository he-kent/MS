  $(function(){
	  initRoleTable();//初始化角色户列表	
      });
 function initRoleTable(){
	 var rolename = $("#rolename-search").val(),
	     parems = {"rolename":rolename};
	 ajax({
	  url:contextPath+'/role/roleList.do',
	  type:'post',
	  data:parems,
	  dataType:'json',
	  success:function(data){
		  console.log(data);
		  var  tbody = $("#roleDataGridBody"),html="";
		  tbody.empty();
		  $.each(data.datas,function(index,role){
			  html+= "<tr id=\""+role.id+"\">"+
			  "<td>"+role.id+"</td>"+
			  "<td>"+role.rolename+"</td>"+
			  "<td>"+new Date(role.createtime).Format("yyyy-MM-dd hh:mm:ss")+"</td>"+
			  "<td>"+new Date(role.updatetime).Format("yyyy-MM-dd hh:mm:ss")+"</td>"+
			  "<td>"+(role.status==1?'有效':'无效')+"</td>"+
			  "<td><a id=\"update\""+role.id+" href=\"#\" onclick=\"openUpdateRoleWin('"+role.id+"')\">修改</a>|<a href=\"#\" onclick=\"deleteRole('"+role.id+"')\">删除</a>|<a href=\"#\" onclick=\"openUpdatePermissionsModal("+role.id+")\">修改权限</a>|<a href=\"#\" onclick=\"updateRoleStatus('"+role.id+"',1)\">有效</a>|<a href=\"#\" onclick=\"updateRoleStatus('"+role.id+"',2)\">无效</a></td>"+
			   "</tr>";
		  });
		  tbody.html(html);
	  }
 });
 } 
 function openAddRoleWin(objId,formId){
	 $("#"+objId).modal('show');
 }
 function closeAddRoleWin(objId,formId){
	 $("#"+objId).modal('hide');
	 document.getElementById(formId).reset();
 }
 function openUpdateRoleWin(rowId){
	 $("#roleId-update").val(rowId);
	 ajax({
		 url:contextPath+'/role/getDateById.do',
		 type:'post',
		 data:{"id":rowId},
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 $("#roleId-update").val(data.id);
			 $("#role-update").val(data.rolename);
			 $("#role-status-update").val(data.status);
			 openAddRoleWin('updateRoleModal');
		 }
	 });
 }
 /*添加用户*/
 function addRole(){
	 var rolename =$("#rolename-add").val(),
	     status = $("#role-status-add").val(),
	     params={"rolename":rolename,"status":status};
	 ajax({
		 url:contextPath+'/role/addRole.do',
		 type:'post',
		 data:params,
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 if(parseInt(data.msg)==1){
				 initRoleTable();
			 }
			 closeAddRoleWin("addRoleModel","addRoleForm");
		 },
		 complete:function(XHR,TextStatus){
			 XHR=null;
		 }
	 });
 }
 /*修改用户*/
 function updateRole(){
	 var roleId = $("#roleId-update").val(),
	     rolename =$("#role-update").val(),
	     status = $("#role-status-add").val(),
	     params={"id":roleId,"rolename":rolename,"status":status};
	 ajax({
		 url:contextPath+'/role/updateRole.do',
		 type:'post',
		 data:params,
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 if(parseInt(data.msg)==1){
				 initRoleTable();
			 }
			 closeAddRoleWin("updateRoleModal","upateRoleForm");
		 },
		 complete:function(XHR,TextStatus){
			 XHR=null;
		 }
	 });
 }
 function deleteRole(roleId){
	 ajax({
		 url:contextPath+'/role/deleteRole.do',
		 type:'post',
		 data:{"id":roleId},
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 if(parseInt(data.msg)==1){
				 initRoleTable();
			 }
		 },
		 complete:function(XHR,TextStatus){
			 XHR = null;
		 }
	 });
 }
 
 function updateRoleStatus(roleId,status){
	 ajax({
		 url:contextPath+'/role/updateRoleStatus.do',
		 type:'post',
		 data:{"id":roleId,"status":status},
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 if(parseInt(data.msg)==1){
				 initRoleTable();
			 }
		 },
		 complete:function(XHR,TextStatus){
			 XHR = null;
		 }
	 });
 }
 /*打开修改权限模态框*/
 function openUpdatePermissionsModal(roleId){
	 //初始化权限树
	 getTree(roleId);
	 $("#roleId").val(roleId);
	 $("#updatePermissionsModal").modal('show');
 }
 //获取权限树
 function getTree(roleId) {
	   ajax({
		   url:contextPath+'/role/getMenuTree.do',
		   type:'post',
		   data:{"roleId":roleId},
		   dataType:'json',
		   success:function(data){
			   console.log(data);
			   $('#tree').treeview({
					  data: data,
					  multiSelect:true,
					  showCheckbox:true,
					  expandIcon:"glyphicon glyphicon-triangle-right",
					  emptyIcon:"",
					  collapseIcon:"glyphicon glyphicon-triangle-bottom",
					  color:"#3498DB",
					  selectedBackColor:"#5CB85C",
					  onNodeSelected:function(event,data){
						  $('#tree').treeview('checkNode',[data.nodeId,{ silent: true }]);
						  if(data.nodes){
							 for(var i in data.nodes){
								 $('#tree').treeview('checkNode',[data.nodes[i].nodeId,{ silent: true }]);
								  $('#tree').treeview('selectNode',[data.nodes[i].nodeId,{ silent: true }]);
							 }
						  }
						  if(data.parentId != undefined){
							  $('#tree').treeview('checkNode',[data.parentId,{ silent: true }]);
							  $('#tree').treeview('selectNode',[data.parentId,{ silent: true }]);
						  }
					  },
					  onNodeUnselected:function (event, node){
						  $('#tree').treeview('uncheckNode', [ node.nodeId, { silent: true } ]);
						  if(node.nodes){
							  for(var i in node.nodes){
									 $('#tree').treeview('uncheckNode',[node.nodes[i].nodeId,{ silent: true }]);
									  $('#tree').treeview('unselectNode',[node.nodes[i].nodeId,{ silent: true }]);
								 }
						  }
					  }
					  });  
		   },
		   complete:function(XHR,TextStatus){
			   XHR = null;
		   }
	   });
	}
 /*保存权限*/
function savePermission(){
	var nodes = $('#tree').treeview('getSelected'),
	    roleId = $('#roleId').val(),
	    menuIds = new Array();
	for(var i in nodes){
		console.log(i);
		menuIds.push(nodes[i].id);
	}
	console.log(menuIds.join(','));
	var params={"roleId":roleId,"menuIds":menuIds.join(',')};
	ajax({
		url:contextPath+'/role/savePermission.do',
		type:'post',
		data:params,
		dataType:'json',
		success:function(data){
			console.log(data);
			if(data.msg==1){
				closeAddRoleWin('updatePermissionsModal','updatePermissionsForm');
				//刷新页面
				  window.location.reload();
			}else{
				alert('修改权限失败！');
			}
		}
	});

}
	   
      
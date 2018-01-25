  $(function(){
	  inittable();//初始化用户列表	
	  loadRoleList("#roleSelect","#roleID-update","#roleID-add");
      });
 function inittable(){
	 var username = $("#username-search").val(),
	     parems = {"username":username};
	 ajax({
		  url:contextPath+'/user/userList.do',
	  type:'post',
	  data:parems,
	  dataType:'json',
	  success:function(data){
		  console.log(data);
		  var  tbody = $("#userDataGridBody"),html="";
		  tbody.empty();
		  $.each(data.datas,function(index,user){
			  console.log(user);
			  html+= "<tr id=\""+user.id+"\">"+
			  "<td>"+user.id+"</td>"+
			  "<td>"+user.username+"</td>"+
			  "<td>"+user.nickname+"</td>"+
			  "<td>"+user.roleID+"</td>"+
			  "<td>"+user.roleName+"</td>"+
			  "<td>"+new Date(user.createtime).Format("yyyy-MM-dd hh:mm:ss")+"</td>"+
			  "<td>"+new Date(user.updatetime).Format("yyyy-MM-dd hh:mm:ss")+"</td>"+
			  "<td>"+(user.status==1?'有效':'无效')+"</td>"+
			  "<td><a id=\"update\""+user.id+" href=\"#\" onclick=\"openUpdateUserWin('"+user.id+"')\">修改</a>|<a href=\"#\" onclick=\"deleteUser('"+user.id+"')\">删除</a>|<a href=\"#\" onclick=\"openUpdateRoleModal("+user.id+")\">修改角色</a>|<a href=\"#\" onclick=\"updateUserStatus('"+user.id+"',1)\">有效</a>|<a href=\"#\" onclick=\"updateUserStatus('"+user.id+"',2)\">无效</a></td>"+
			   "</tr>";
		  });
		  tbody.html(html);
	  }
 });
 } 
 function openAddUserWin(objId,formId){
	 $("#"+objId).modal('show');
 }
 function closeAddUseWin(objId,formId){
	 $("#"+objId).modal('hide');
	 document.getElementById(formId).reset();
 }
 function openUpdateUserWin(rowId){
	 $("#userId-update").val(rowId);
	 ajax({
		 url:contextPath+'/user/getDateById.do',
		 type:'post',
		 data:{"id":rowId},
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 $("#userId-update").val(data.id);
			 $("#username-update").val(data.username);
			 $("#nickname-update").val(data.nickname);
			 $("#phone-update").val(data.phone);
			 $("#status-update").val(data.status);
			 /*$("#roleID-update").val(data.roleID);*/
			/* $("#avatar-update").val(data.avatar);*/
			 $("#address-update").val(data.address);
			 $("#updateUserModal").modal('show');
		 }
	 });
 }
 /*添加用户*/
 function addUser(){
	 var username=$("#username-add").val(),
	     password = $("#password-add").val(),
	     nickname=$("#nickname-add").val(),
	     phone=$("#phone-add").val(),
	     status=$("#status-add").val(),
	     roleID = $("#roleID-add").val(),
	     avatar = $("#avatar-add").val(),
	     address = $("#address-add").val(),
	    params={"password":password,"address":address,"avatar":avatar,"roleID":roleID,"username":username,"nickname":nickname,"phone":phone,"status":status};
	 ajax({
		 url:contextPath+'/user/addUser.do',
		 type:'post',
		 data:params,
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 if(parseInt(data.msg)==1){
				 inittable();
			 }
			 closeAddUseWin("addUserModel","addUserForm");
		 },
		 complete:function(XHR,TextStatus){
			 XHR=null;
		 }
	 });
 }
 /*修改用户*/
 function updateUser(){
	 var id = $("#userId-update").val(),
	     username=$("#username-update").val(),
	     nickname=$("#nickname-update").val(),
	     phone=$("#phone-update").val(),
	     status=$("#status-update").val(),
	     roleID = $("#roleID-update").val(),
	     avatar = $("#avatar-update").val(),
	     address = $("#address-update").val(),
	     params={"id":id,"address":address,"avatar":avatar,"roleID":roleID,"username":username,"nickname":nickname,"phone":phone,"status":status};
	 ajax({
		 url:contextPath+'/user/updateUser.do',
		 type:'post',
		 data:params,
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 if(parseInt(data.msg)==1){
				 inittable();
			 }
			 closeAddUseWin("updateUserModal","upateform");
		 },
		 complete:function(XHR,TextStatus){
			 XHR=null;
		 }
	 });
 }
 function deleteUser(userId){
	 ajax({
		 url:contextPath+'/user/deleteUser.do',
		 type:'post',
		 data:{"id":userId},
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 if(parseInt(data.msg)==1){
				 inittable();
			 }
		 },
		 complete:function(XHR,TextStatus){
			 XHR = null;
		 }
	 });
 }
 
 function updateUserStatus(userId,status){
	 ajax({
		 url:contextPath+'/user/updateUserStatus.do',
		 type:'post',
		 data:{"id":userId,"status":status},
		 dataType:'json',
		 success:function(data){
			 console.log(data);
			 if(parseInt(data.msg)==1){
				 inittable();
			 }
		 },
		 complete:function(XHR,TextStatus){
			 XHR = null;
		 }
	 });
 }
 /*打开修改用户角色modal*/
 function openUpdateRoleModal(userId){
	 $("#userIdUpdateRole").val(userId);
	 //loadRoleList("roleSelect");
	 $("#updateUserRoleModal").modal('show');
 }
 /*加载角色选项列表*/
 function loadRoleList(){
	 var arg1=arguments[0],
	     arg2=arguments[1],
	     arg3=arguments[2];
	 /*查询启用状态的角色*/
	 $.post(contextPath+'/role/roleList.do',{"status":1},function(data){
		 console.log(data);
		 var html="<option value=''>请选择</option>",
		     datas=data.datas;
		 for(var i in datas){
			 html+="<option value='"+datas[i].id+"'>"+datas[i].rolename+"</option>";
		 }
		 $(arg1).html(html);
		 $(arg2).html(html);
		 $(arg3).html(html);
	 },'json');
 }
 /*修改用户角色*/
 function updateUserRole(){
	 var userId =$("#userIdUpdateRole").val(),
	     roleId=$("#roleSelect").val(),
	     params={"userId":userId,"roleId":roleId};
	 ajax({
		 url:contextPath+'/user/updateUserRole.do',
		 data:params,
		 type:'post',
		 dataType:'json',
		 success:function(data){
			if(data.msg==1){
				 inittable();
			}else{
				alert("修改失败！");
			}
			closeAddUseWin('updateUserRoleModal','updateUserRoleForm');
		 }
	 });
 }
      
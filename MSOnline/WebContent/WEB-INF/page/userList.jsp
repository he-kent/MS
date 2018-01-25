<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理</title>
</head>
<body>
 <div class="search-box">
            <form class="form-inline" role="form">
			  <div class="form-group">
			    <label for="username">用户名称</label>
			    <input type="text" class="form-control" id="username-search" placeholder="请输入用户名称"/>
			  </div>
			  <button type="submit" class="btn btn-info" onclick="inittable();return false;">查询</button>
			</form>
			 
			<hr/>
			<div class="optionMenuBar">
			  <button type="button" class="btn btn-info" id="addUserBtn" onclick="openAddUserWin('addUserModel','addUserForm')">添加用户</button>
			</div>
          </div>
          <div>
           <table class="table table-bordered table-striped table-hover" id="userDataGrid">
                <thead>
                    <tr>
                        <th >ID</th>
                        <th>用户名称</th>
                        <th>昵称</th>
                        <th>角色ID</th>
                         <th>角色名称</th>
                        <th>创建时间</th>
                        <th>修改时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="userDataGridBody"></tbody>
             </table>
          </div>
          <!-- 添加用户modal -->
          <div class="modal fade"  id="addUserModel" tabindex="-1" role="dialog">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close"  aria-label="Close" onclick="closeAddUseWin('addUserModel','addUserForm')"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">添加用户</h4>
			      </div>
			      <div class="modal-body">
			         <form class="form-horizontal" id="addUserForm">
			             <div class="form-group">
			                 <label for="username-add" class="col-sm-2 control-label">用户名:</label>
			                 <div class="col-sm-8">
			                    <input id="username-add" name="username" class="form-control" placeholder="请输入用户名"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="password-add"  class="col-sm-2 control-label">密码:</label>
			                 <div class="col-sm-8">
			                    <input id="password-add" type="password" name="password" class="form-control"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                  <label for="nickname-add" class="col-sm-2 control-label">昵称:</label>
			                  <div class="col-sm-8">
			                      <input class="form-control" name="nickname" id="nickname-add"/>
			                  </div>
			                  <label class="col-sm-2"></label>
			             </div>
			              <div class="form-group">
			                  <label for="phone-add" class="col-sm-2 control-label">电话:</label>
			                  <div class="col-sm-8">
			                      <input class="form-control" name="phone" id="phone-add"/>
			                  </div>
			                  <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="status-add" class="col-sm-2 control-label">状态:</label>
			                 <div class="col-sm-8">
			                    <select id="status-add" class="form-control">
			                       <option value=1>有效</option>
			                       <option value=2>无效</option>
			                    </select>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="roleID-add" class="col-sm-2 control-label">角色ID:</label>
			                  <div class="col-sm-8">
			                     <select id="roleID-add" class="form-control"> </select>
			                  </div>
			                  <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="avatar-add" class="col-sm-2 control-label">头像:</label>
			                  <div class="col-sm-8">
			                       <input type="file" id="avatar-add" name="avatar" class="form-control"/>
			                  </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="address-add" class="col-sm-2 control-label">地址：</label>
			                 <div class="col-sm-8">
			                     <input id="address-add" name="address" class="form-control"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			         </form>
			      </div>
			      <div class="modal-footer">
			         <button type="button" class="btn btn-info" onclick="addUser();">添加</button>
			        <button type="button" class="btn btn-default" onclick="closeAddUseWin('addUserModel','addUserForm')">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
		   <!-- 修改用户 -->
		   <div class="modal fade" tabindex="-1" role="dialog" id="updateUserModal">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">修改用户</h4>
			      </div>
			      <div class="modal-body">
			        <form class="form-horizontal" id="upateform">
			             <input id="userId-update" type="hidden"/>
			             <div class="form-group">
			                 <label for="username-update" class="col-sm-2 control-label">用户名:</label>
			                 <div class="col-sm-8">
			                    <input id="username-update" name="username" class="form-control" placeholder="请输入用户名"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                  <label for="nickname-update" class="col-sm-2 control-label">昵称:</label>
			                  <div class="col-sm-8">
			                      <input class="form-control" name="nickname" id="nickname-update"/>
			                  </div>
			                  <label class="col-sm-2"></label>
			             </div>
			              <div class="form-group">
			                  <label for="phone-update" class="col-sm-2 control-label">电话:</label>
			                  <div class="col-sm-8">
			                      <input class="form-control" name="phone" id="phone-update"/>
			                  </div>
			                  <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="status-update" class="col-sm-2 control-label">状态:</label>
			                 <div class="col-sm-8">
			                    <select id="status-update" class="form-control">
			                       <option value=1>有效</option>
			                       <option value=2>无效</option>
			                    </select>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="roleID-update" class="col-sm-2 control-label">角色ID:</label>
			                  <div class="col-sm-8">
			                     <select id="roleID-update" class="form-control"></select>
			                  </div>
			                  <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="avatar-update" class="col-sm-2 control-label">头像:</label>
			                  <div class="col-sm-8">
			                       <input type="file" id="avatar-update" name="avatar" class="form-control"/>
			                  </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="address-update" class="col-sm-2 control-label">地址：</label>
			                 <div class="col-sm-8">
			                     <input id="address-update" name="address" class="form-control"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			         </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" onclick="updateUser()">修改</button>
			        <button type="button" class="btn btn-default" onclick="closeAddUseWin('updateUserModal','upateform')">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			<!-- 修改用户角色 -->
			<div class="modal fade" tabindex="-1" role="dialog" id="updateUserRoleModal">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close" onclick="closeAddUseWin('updateUserRoleModal','updateUserRoleForm');" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">修改用户角色</h4>
			      </div>
			      <div class="modal-body">
			        <form class="form-horizontal" id="updateUserRoleForm">
			             <input type="hidden" id="userIdUpdateRole"/>
			              <div class="form-group">
						    <label for="roleSelect" class="col-sm-2 control-label">角色:</label>
						    <div class="col-sm-8">
						      <select id="roleSelect" class="form-control"> </select>
						    </div>
						    <label class="col-sm-2"></label>
						  </div>
			        </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" onclick="updateUserRole();">保存</button>
			        <button type="button" class="btn btn-default" onclick="closeAddUseWin('updateUserRoleModal','updateUserRoleForm');">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
          <script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/userList.js"></script>
</body>
</html>
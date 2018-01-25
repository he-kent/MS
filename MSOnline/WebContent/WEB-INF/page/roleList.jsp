<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理</title>
</head>
<body>
 <div class="search-box">
            <form class="form-inline" role="form">
			  <div class="form-group">
			    <label for="rolename-search">角色名称</label>
			    <input type="text" class="form-control" id="rolename-search" placeholder="请输入角色名称"/>
			  </div>
			  <button type="submit" class="btn btn-info" onclick="initRoleTable();return false;">查询</button>
			</form>
			 
			<hr/>
			<div class="optionMenuBar">
			  <button type="button" class="btn btn-info" id="addUserBtn" onclick="openAddRoleWin('addRoleModel','addRoleForm')">添加角色</button>
			</div>
          </div>
          <div>
           <table class="table table-bordered table-striped table-hover" id="roleDataGrid">
                <thead>
                    <tr>
                        <th >ID</th>
                        <th>角色名称</th>
                        <th>创建时间</th>
                        <th>修改时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="roleDataGridBody"></tbody>
             </table>
          </div>
          <!-- 添加角色modal -->
          <div class="modal fade"  id="addRoleModel" tabindex="-1" role="dialog">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close"  aria-label="Close" onclick="closeAddRoleWin('addRoleModel','addRoleForm')"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">添加角色</h4>
			      </div>
			      <div class="modal-body">
			         <form class="form-horizontal" id="addRoleForm">
			             <div class="form-group">
			                 <label for="rolename-add" class="col-sm-2 control-label">角色名称:</label>
			                 <div class="col-sm-8">
			                    <input id="rolename-add" name="rolename" class="form-control" placeholder="请输入角色名"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="role-status-add" class="col-sm-2 control-label">状态:</label>
			                 <div class="col-sm-8">
			                    <select id="role-status-add" class="form-control">
			                       <option value=1>启用</option>
			                       <option value=2>禁用</option>
			                    </select>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			         </form>
			      </div>
			      <div class="modal-footer">
			         <button type="button" class="btn btn-info" onclick="addRole();">添加</button>
			        <button type="button" class="btn btn-default" onclick="closeAddRoleWin('addRoleModel','addRoleForm')">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
		   <!-- 修改角色 -->
		   <div class="modal fade" tabindex="-1" role="dialog" id="updateRoleModal">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">修改角色</h4>
			      </div>
			      <div class="modal-body">
			        <form class="form-horizontal" id="upateRoleForm">
			             <input id="roleId-update" type="hidden"/>
			             <div class="form-group">
			                 <label for="role-update" class="col-sm-2 control-label">角色名称:</label>
			                 <div class="col-sm-8">
			                    <input id="role-update" name="rolename" class="form-control" placeholder="请输入角色名"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="role-status-update" class="col-sm-2 control-label">状态:</label>
			                 <div class="col-sm-8">
			                    <select id="role-status-update" class="form-control">
			                       <option value=1>启用</option>
			                       <option value=2>禁用</option>
			                    </select>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			         </form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-primary" onclick="updateRole()">修改</button>
			        <button type="button" class="btn btn-default" onclick="closeAddRoleWin('updateRoleModal','upateRoleForm')">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- role/.modal -->
			<!-- 修改权限modal -->
			<div class="modal fade" tabindex="-1" role="dialog" id="updatePermissionsModal">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close"  onclick="closeAddRoleWin('updatePermissionsModal','updatePermissionsForm')"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">修改权限</h4>
			      </div>
			      <div class="modal-body">
			         <form id="updatePermissionsForm">
			             <input type="hidden" id="roleId"/>
			             <div id="tree"></div>   
					</form>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-info" onclick="savePermission()">保存</button>
			        <button type="button" class="btn btn-default" onclick="closeAddRoleWin('updatePermissionsModal','updatePermissionsForm')">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- 修改权限/.modal -->
          <script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/roleList.js"></script>
</body>
</html>
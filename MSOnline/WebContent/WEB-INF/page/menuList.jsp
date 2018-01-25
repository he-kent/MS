<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<!-- 菜单列表页面 -->
<body>
     <div class="search-box">
            <form class="form-inline" role="form">
			  <div class="form-group">
			    <label for="menuname">菜单名称</label>
			    <input type="text" class="form-control" id="menuname" placeholder="请输入菜单名称"/>
			  </div>
			  <button type="submit" class="btn btn-info">查询</button>
			</form>
			<hr/>
			<div class="optionMenuBar">
			  <button type="button" class="btn btn-info" id="addMenuBtn" onclick="openModal('addMenuModal',-1,null)">添加菜单</button>
			</div>
          </div>
          <div>
           <table class="table table-bordered table-hover" id="menuTreeGrid">
                <thead>
                    <tr>
                        <th style="display:none">ID</th>
                        <th>菜单名称</th>
                        <th>URL</th>
                        <th>状态</th>
                        <th>PID</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="menuTreeGridTBody"></tbody>
             </table>
          </div>
		<!--添加菜单 Modal -->
		<div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog" aria-labelledby="addMenuModalLabel" data-backdrop="static">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header bg-primary">
		        <button type="button" class="close" onclick="closeModal('addMenuModal','addMenuForm')"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="addMenuModalLabel">添加菜单</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal" id="addMenuForm">
		        <!-- 行ID  如果是添加子菜单 则将 pid设置为该行的Id -->
		           <input type="hidden" id="rowId" readonly/>
		           <div class="form-group">
		               <label for="menuname-from" class="col-sm-2 control-label">菜单名称:</label>
					    <div class="col-sm-8 ">
					      <input type="text" class="form-control" name="menuName" id="menuname-from" placeholder="请输入菜单名称" aria-describedby="menunameinputstatus">
					    </div>
					     <label for="menuname-from" class="col-sm-2 control-label"></label>
		           </div>
		           <div class="form-group">
		               <label for="menuurl" class="col-sm-2 control-label">菜单URL:</label>
		               <div class="col-sm-8">
		                 <input type="text" class="form-control" name="menuUrl" id="menuurl" placeholder="请输入菜单URL"/>
		               </div>
		               <label for="menuurl"class="col-sm-2 control-label"></label>
		           </div>
		           <div class="form-group">
		              <label for="menustatu" class="col-sm-2 control-label">菜单状态:</label>
		              <div class="col-sm-8">
		                 <select class="form-control" id="menustatu" name="menuStatu">
		                     <option value=1>启用</option>
		                     <option value=2>禁用</option>
		                 </select>
		              </div>
		              <label for="menustatu" class="col-sm-2 control-label"></label>
		           </div>
		           <div class="form-group" style="display:none;">
		               <label for="pid" class="col-sm-2 control-label">PID:</label>
		               <div class="col-sm-8">
		                    <input id="pid"  name="pid" value=0 class="form-control" readonly/>
		               </div>
		               <label for="pid" class="col-sm-2 control-label"></label>
		           </div> 
		        </form>
		      </div>
		      <div class="modal-footer">
		       <!-- <button type="button" class="btn btn-info"  id="menuUpdateSubmitBtn" style="displsy:none;" onclick="updateMenu()">修改</button> -->
		        <button type="button" class="btn btn-info"  id="menuAddSubmitBtn" onclick="addMenu()">添加</button>
		        <button type="button" class="btn btn-default"  onclick="closeModal('addMenuModal','addMenuForm')">取消</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!--添加菜单 Modal  end -->
		<!-- 修改菜单 -->
		<div class="modal fade" id="updateMenuModal" tabindex="-1" role="dialog" aria-labelledby="updateMenuLabel" data-backdrop="static">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header bg-primary">
		        <button type="button" class="close" onclick="closeModal('updateMenuModal','updateMenuForm')"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="updateMenuLabel">修改菜单</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal" id="updateMenuForm">
		           <input type="hidden" id="rowId-update" readonly/>
		           <div class="form-group">
		               <label for="menuname-update" class="col-sm-2 control-label">菜单名称:</label>
					    <div class="col-sm-8 ">
					      <input type="text" class="form-control" name="menuName" id="menuname-update" placeholder="请输入菜单名称" aria-describedby="menunameinputstatus">
					    </div>
					     <label for="menuname-update" class="col-sm-2 control-label"></label>
		           </div>
		           <div class="form-group">
		               <label for="menuurl-update" class="col-sm-2 control-label">菜单URL:</label>
		               <div class="col-sm-8">
		                 <input type="text" class="form-control" name="menuUrl" id="menuurl-update" placeholder="请输入菜单URL"/>
		               </div>
		               <label for="menuurl-update"class="col-sm-2 control-label"></label>
		           </div>
		           <div class="form-group">
		              <label for="menustatu-update" class="col-sm-2 control-label">菜单状态:</label>
		              <div class="col-sm-8">
		                 <select class="form-control" id="menustatu-update" name="menuStatu">
		                     <option value=1>启用</option>
		                     <option value=2>禁用</option>
		                 </select>
		              </div>
		              <label for="menustatu-update" class="col-sm-2 control-label"></label>
		           </div>
		           <div class="form-group" style="display:none;">
		               <label for="pid-update" class="col-sm-2 control-label">PID:</label>
		               <div class="col-sm-8">
		                    <input id="pid-update"  name="pid" value=0 class="form-control" readonly/>
		               </div>
		               <label for="pid-update" class="col-sm-2 control-label"></label>
		           </div> 
		        </form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-info"  id="menuUpdateSubmitBtn" onclick="updateMenu()">修改</button> 
		        <button type="button" class="btn btn-default"  onclick="closeModal('updateMenuModal','updateMenuForm')">取消</button>
		      </div>
		    </div>
		  </div>
		</div>
          <script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/menuList.js"></script>
</body>
</html>
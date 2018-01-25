<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>字典维护</title>
</head>
<body>
      <div class="search-box">
            <form class="form-inline" role="form">
			  <div class="form-group">
			    <label for="dicname">字典名称</label>
			    <input type="text" class="form-control" id="dicname" placeholder="请输入字典名称"/>
			  </div>
			  <button type="submit" class="btn btn-info" onclick="dic.initDicDateGrid();return false;">查询</button>
			</form>
			<hr/>
			<div class="optionMenuBar">
			  <button type="button" class="btn btn-info" id="addDicBtn" onclick="dic.openDicModal('addDicModal','addDicForm')">添加字典</button>
			</div>
          </div>
          <div>
           <table class="table table-bordered table-striped table-hover" id="dicDateGrid">
                <thead>
                    <tr>
                        <th >ID</th>
                        <th>字典名称</th>
                        <th>字典编码</th>
                        <th>状态</th>
                        <th>创建时间</th>
                        <th>修改时间</th>
                        <th>备注</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="dicDateGridBody"></tbody>
             </table>
          </div>
           <!-- 添加字典modal -->
          <div class="modal fade"  id="addDicModal" tabindex="-1" role="dialog">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close"  aria-label="Close" onclick="dic.closeDicModal('addDicModal','addDicForm')"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">添加字典</h4>
			      </div>
			      <div class="modal-body">
			         <form class="form-horizontal" id="addDicForm">
			             <div class="form-group">
			                 <label for="dicname-add" class="col-sm-2 control-label">字典名称:</label>
			                 <div class="col-sm-8">
			                    <input id="dicname-add" name="dicName" class="form-control" placeholder="请输入字典名称"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="diccode-add" class="col-sm-2 control-label">字典编码：</label>
			                <div class="col-sm-8">
			                    <input id="diccode-add" name="dicCode" value="1001" class="form-control" placeholder="请输入字典编码"/>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="dicstatus-add" class="col-sm-2 control-label">字典状态：</label>
			                <div class="col-sm-8">
			                   <select id="dicstatus-add" name="dicSttatus" class="form-control">
			                       <option value=1>有效</option>
			                       <option value=2>无效</option>
			                   </select>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="dicnote-add" class="col-sm-2 control-label">备注：</label>
			                <div class="col-sm-8">
			                  <textarea rows="3" id="dicnote-add" name="dicNote" class="form-control"></textarea>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			         </form>
			      </div>
			      <div class="modal-footer">
			         <button type="button" class="btn btn-info" onclick="dic.addDic();">添加</button>
			        <button type="button" class="btn btn-default" onclick="dic.closeDicModal('addDicModal','addDicForm')">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			 <!-- 修改字典modal -->
          <div class="modal fade"  id="updateDicModel" tabindex="-1" role="dialog">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close"  aria-label="Close" onclick="dic.closeDicModal('updateDicModel','updateDicForm')"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">修改字典</h4>
			      </div>
			      <div class="modal-body">
			         <form class="form-horizontal" id="updateDicForm">
			         <input id="dicUpdateId" type="hidden"/>
			             <div class="form-group">
			                 <label for="dicname-update" class="col-sm-2 control-label">字典名称:</label>
			                 <div class="col-sm-8">
			                    <input id="dicname-update" name="dicName" class="form-control" placeholder="请输入字典名称"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="diccode-update" class="col-sm-2 control-label">字典编码：</label>
			                <div class="col-sm-8">
			                    <input id="diccode-update" name="dicCode" class="form-control" placeholder="请输入字典编码"/>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="dicstatus-update" class="col-sm-2 control-label">字典状态：</label>
			                <div class="col-sm-8">
			                   <select id="dicstatus-update" name="dicSttatus" class="form-control">
			                       <option value=1>有效</option>
			                       <option value=2>无效</option>
			                   </select>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="dicnote-update" class="col-sm-2 control-label">备注：</label>
			                <div class="col-sm-8">
			                  <textarea rows="3" id="dicnote-update" name="dicNote" class="form-control"></textarea>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			         </form>
			      </div>
			      <div class="modal-footer">
			         <button type="button" class="btn btn-info" onclick="dic.updateDic();">修改</button>
			        <button type="button" class="btn btn-default" onclick="dic.closeDicModal('updateDicModel','updateDicForm')">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
   <script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/dic/dictionary.js"></script>
</body>
</html>
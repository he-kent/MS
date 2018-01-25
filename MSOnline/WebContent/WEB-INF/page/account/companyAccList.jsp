<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公司记账</title>                        
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/account.css"/>
</head>
<body>
   <div class="search-box">
            <form class="form-inline" role="form" id="accountSearchForm">
			  <div class="form-group">
			    <label for="acc-search" class="control-label">记账类型:</label>
			     <select id="accType-search" class="form-control">
			         <option value="">请选择</option>
			         <option value="1">房租</option>
			         <option value="2">水费</option>
			         <option value="3">电费</option>
			         <option value="4">其他</option>
			     </select>
			  </div>
			   <div class="form-group">
			    <label for="acctime-search" class="control-label">记账日期:</label>
			     <input class="datepicker form-control" id="acctime-start" >至<input class="datepicker form-control" id="acctime-end" >
			  </div>
			  <button type="submit" class="btn btn-info" onclick="acc.initAccDateGrid();return false;">查询</button>
			  <button type="button" class="btn btn-info" onclick="baseOpt.baseClearForm('accountSearchForm');return false;">清空</button>
			</form>
			 
			<hr/>
			<div class="optionMenuBar">
			  <button type="button" class="btn btn-info" id="addAccountBtn" onclick="acc.openAccAddModal()">记一笔</button>
			</div>
    </div>
      <div>
           <table class="table table-bordered table-striped table-hover" id="AccountDataGrid">
                <thead>
                    <tr>
                        <th >ID</th>
                        <th>账单项目</th>
                        <th>账单金额</th>
                        <th>账单类型</th>
                        <th>记账时间</th>
                        <th>记账人</th>
                        <th>备注</th>
                    </tr>
                </thead>
                <tbody id="accountDataGridBody"></tbody>
             </table>
       </div>
      <!-- 记账 -->
       <div class="modal fade" tabindex="-1" role="dialog" id="AccAddModal">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header bg-primary">
		        <button type="button" class="close" onclick="acc.closeModal('AccAddModal','accAddForm')" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">记账</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal"  id="accAddForm">
		         <div class="form-group">
				    <label for="accItmes" class="col-sm-2 control-label">记账项目：</label>
				    <div class="col-sm-8">
				      <select id="accItmes" class="form-control">
			             <option value="4">其他</option>
			             <option value="1">房租</option>
			             <option value="2">水费</option>
			             <option value="3">电费</option>
			           </select>
				    </div>
				  </div>
				  <div class="form-group">
				      <label for="accMoney" class="col-sm-2 control-label">记账金额：</label>
				      <div class="col-sm-8">
				          <input id="accMoney" class="form-control"/>
				      </div>
				  </div>
				  <div class="form-group">
				      <label for="accType" class="col-sm-2 control-label">记账类型：</label>
				      <div class="col-sm-8">
				         <select id="accType" class="form-control">
				            <option value=1>支出</option>
				            <option value=2>收入</option>
				         </select>
				      </div>
				  </div>
				   <div class="form-group">
				      <label for="accPeople" class="col-sm-2 control-label">记账人：</label>
				      <div class="col-sm-8">
				          <input id="accPeople" class="form-control"/>
				      </div>
				  </div>
				   <div class="form-group">
				      <label for="accNote" class="col-sm-2 control-label">备注：</label>
				      <div class="col-sm-8">
				          <textarea id="accNote" rows=3 class="form-control"></textarea>
				      </div>
				  </div>
		        </form>
		      </div>
		      <div class="modal-footer">
		       <button type="button" class="btn btn-primary" onclick="acc.addAccount()">记一笔</button>
		        <button type="button" class="btn btn-default" onclick="acc.closeModal('AccAddModal','accAddForm')">取消</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/account/account.js"></script>
</body>
</html>
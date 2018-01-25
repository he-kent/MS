<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>治疗费用列表</title>
</head>
<body>
      <div class="search-box">
	     <form class="form-inline" id="costSearchForm">
		  <div class="form-group">
		    <input type="text" class="form-control" id="cusNameOrTel" placeholder="输入用户名或手机号">
		  </div>
		  <button type="button" class="btn btn-info" onclick="return false;">查询</button>
		  <button type="button" class="btn btn-info" onclick="baseOpt.baseClearForm('costSearchForm');return false;">清空</button>
		</form>
		<hr/>
    </div>
    <table id="costDataGrid" class="table table-bordered table-striped table-hover">
      <thead>
         <tr>
           <th style="display:none;">costId</th>
           <th style="display:none;">cusId</th>
           <th style="display:none;">caseId</th>
           <th>客户名称</th>
           <th>客户电话</th>
           <th>客户性别</th>
           <th>治疗项目</th>
           <th>主治医师</th>
           <th>治疗费用</th>
           <th>实付金额</th>
           <th>付款方式</th>
           <th>付款卡类型</th>
           <th>付款时间</th>
           <th>支付状态</th>
           <th>卡编号</th>
         </tr>
      </thead>
      <tbody id="costDataGridBody"></tbody>
    </table>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/treatment/treatment.js"></script>
</body>
</html>
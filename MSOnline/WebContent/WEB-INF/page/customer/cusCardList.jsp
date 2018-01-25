<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户办卡列表</title>
</head>
<body>
      <div class="search-box">
	     <form class="form-inline" id="cusCardSearchForm">
		  <div class="form-group">
		    <input type="text" class="form-control" id="cusCardNameOrTel" placeholder="输入用户名或手机号">
		  </div>
		  <button type="button" class="btn btn-info" onclick="cusCard.initCusCardList();return false;">查询</button>
		  <button type="button" class="btn btn-info" onclick="baseOpt.baseClearForm('cusCardSearchForm');return false;">清空</button>
		</form>
		<hr/>
    </div>
    <table id="cusCardDataGrid" class="table table-bordered table-striped table-hover">
      <thead>
         <tr>
           <th style="display:none;">ID</th>
           <th style="display:none;">办卡人ID</th>
           <th style="display:none;">卡ID</th>
           <th>办卡人名称</th>
           <th>办卡人联系电话</th>
           <th>卡编号</th>
           <th>卡金额</th>
           <th>卡有效次数</th>
           <th>实付金额</th>
           <th>卡类型</th>
           <th>办卡时间</th>
           <th>到期时间</th>
           <th>售卡人</th>
           <th>卡使用状态</th>
           <th>备注</th>
         </tr>
      </thead>
      <tbody id="cusCardDataGridBody"></tbody>
    </table>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/customer/cusCardList.js"></script>
</body>
</html>
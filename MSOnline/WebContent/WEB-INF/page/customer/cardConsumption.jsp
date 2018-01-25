<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>VIP卡消耗合计</title>
</head>
<body>
<div class="search-box">
            <form class="form-inline" role="form" id="cardConsumptionSearchForm">
			  <div class="form-group">
			   <input id="cusName-search" class="form-control" placeholder="请输入客户名称"/>
			  </div>
			   <div class="form-group">
			   <input id="cusTel-search" class="form-control" placeholder="请输入客户电话"/>
			  </div>
			  <div class="form-group">
			   <input id="cusCardNum-search" class="form-control" placeholder="请输入卡编号"/>
			  </div>
			  <button type="submit" class="btn btn-info" onclick="xh.initCardConsumption();return false;">查询</button>
			  <button type="button" class="btn btn-info" onclick="baseOpt.baseClearForm('cardConsumptionSearchForm');return false;">清空</button>
			</form>
			<hr/>
</div>
<div>
        <table class="table table-bordered table-striped table-hover" >
            <thead>
               <tr>
                 <th>客户名称</th>
                 <th>联系电话</th>
                 <th>卡编号</th>
                 <th>可用次数</th>
                 <th>已使用次数</th>
                 <th>剩余次数</th>
               </tr>
            </thead>
            <tbody id="cardConsumptionDataGrid"></tbody>
        </table>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/consumption/cardConsumption.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>店铺费用统计</title>                        
</head>
<body>
<div class="search-box">
         <form class="form-inline" role="form" id="accountStatSearchForm">
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
		  <button type="submit" class="btn btn-info" onclick="accstat.initAccCostStat();return false;">查询</button>
		  <button type="button" class="btn btn-info" onclick="baseOpt.baseClearForm('accountStatSearchForm');return false;">清空</button>
		</form>
   <hr/>
 </div>
<div>
     <table class="table table-bordered table-striped table-hover" >
          <thead>
              <tr>
                  <th>账单项目</th>
                  <th>账单类型</th>
                  <th>账单金额</th>
              </tr>
          </thead>
          <tbody id="accCostStatGridBody"></tbody>
       </table>
 </div>
<div class="container-fluid">
  <div class="row">
    <div class="col-sm-6" >
        <div id="accCostBar" class="statCharts"></div>
    </div>
    <div class="col-sm-6" >
        <div id="accCostPie" class="statCharts"></div>
    </div>
  </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/account/accountStat.js"></script>
</body>
</html>
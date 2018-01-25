<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>诊疗费用支付分类统计</title>                        
</head>
<body>
<div class="search-box">
  <form class="form-inline" role="form" id="costStatSearchForm">
    <div class="form-group">
     <label class="control-label">日期:</label>
     <input class="datepicker form-control" id="costtime-start" >至<input class="datepicker form-control" id="costtime-end" >
    </div>
    <button type="submit" class="btn btn-info" onclick="treatmentstat.initTreatmentCostStat();return false;">查询</button>
    <button type="button" class="btn btn-info" onclick="baseOpt.baseClearForm('costStatSearchForm');return false;">清空</button>
  </form>
<hr/>
</div>
<div>
     <table class="table table-bordered table-striped table-hover" >
          <thead>
            <caption ><b>诊疗费用非vip支付分类统计</b></caption>
              <tr>
                  <th>支付方式(非vip)</th>
                  <th>收入金额</th>
              </tr>
          </thead>
          <tbody id="treatmentCostStatGridBody"></tbody>
       </table>
 </div>
<div>
    <table class="table table-bordered table-striped table-hover" >
         <thead>
          <caption ><b>诊疗费用VIP支付统计</b></caption>
             <tr>
                 <th>支付方式(vip)</th>
                 <th>支付次数</th>
             </tr>
         </thead>
         <tbody id="tcVipPayCountStatGridBody"></tbody>
      </table>
</div>
<div class="pull-left statCharts" id="fvipCharts"></div>
<div class="pull-right statCharts" id="vipPayCharts"></div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/coststat/treatmentStat.js"></script>
</body>
</html>
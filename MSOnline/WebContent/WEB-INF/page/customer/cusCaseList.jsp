<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>病历列表</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/css/treatmentCost.css"/>
</head>
<body>
      <div class="search-box">
	     <form class="form-inline" id="cusCaseSearchForm">
		  <div class="form-group">
		    <input type="text" class="form-control" id="cusCaseName" placeholder="输入客户户名">
		  </div>
		  <div class="form-group">
		    <input type="text" class="form-control" id="cusCaseTel" placeholder="输入电话">
		  </div>
		  <button type="button" class="btn btn-info" onclick="cusCase.initCusCaseList();return false;">查询</button>
		  <button type="button" class="btn btn-info" onclick="baseOpt.baseClearForm('cusCaseSearchForm');return false;">清空</button>
		</form>
		<hr/>
    </div>
    <table id="cusCaseDataGrid" class="table table-bordered table-striped table-hover">
      <thead>
         <tr>
           <th style="display:none;">ID</th>
           <th>客户名称</th>
           <th>客户电话</th>
           <th style="display:none;">性别</th>
           <th style="display:none;">身高</th>
           <th style="display:none;">医疗机构</th>
           <th>医疗科室</th>
           <th>就诊时间</th>
           <th>初诊时间</th>
           <th>主诉</th>
           <th>主治医师</th>
           <th>治疗方案</th>
            <th>费用支付</th>
           <th>操作</th>
         </tr>
      </thead>
      <tbody id="cusCaseDataGridBody"></tbody>
    </table>
    <div class="modal fade" tabindex="-1" role="dialog" id="cusCasePayModal">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header bg-primary">
	        <button type="button" class="close" onclick="cusCase.closeCasePayModal('cusCasePayModal','cusCasePayForm')" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">费用支付</h4>
	      </div>
	      <div class="modal-body">
	        <form class="form-horizontal" id="cusCasePayForm">
	        <!-- 订单id -->
	        <input id="tcid" type="hidden"/>
	        <!-- 病历 ID -->
	         <input  id="cus_case_id" type="hidden">
	         <!-- 客户ID -->
	          <input  id="cus_id" type="hidden">
	          <div class="form-group">
			    <label for="costPeople" class="col-sm-2 control-label">付款人：</label>
			    <div class="col-sm-8">
			      <input class="form-control" id="costPeople" readonly>
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="pay_type" class="col-sm-2 control-label">支付方式：</label>
			    <div class="col-sm-8">
			      <select id="pay_type" class="form-control" onchange="cusCase.payTypeChage();">
			          <option value=1>vip卡支付</option>
			          <option value=2>现金支付</option>
			          <option value=3>支付宝支付</option>
			          <option value=4>微信支付</option>
			          <option value=5>银行卡支付</option>
			      </select>
			    </div>
			  </div>
			   <div class="form-group">
			    <label for="treatment_cost" class="col-sm-2 control-label">诊疗费用：</label>
			    <div class="col-sm-8">
			      <input class="form-control" id="treatment_cost">
			    </div>
			  </div>
			   <div class="form-group">
			    <label for="pay_amount" class="col-sm-2 control-label">实付金额：</label>
			    <div class="col-sm-8">
			      <input class="form-control" id="pay_amount">
			    </div>
			  </div>
			  <div class="form-group payCardType">
			    <label class="col-sm-2 control-label"></label>
			       <div class="col-sm-8">
				     <input type="button" class="btn btn-success" onclick="cusCase.selectCard();" value="查看客户可使用卡"/>
			       </div>
			  </div>
			  <div class="form-group payCardType">
			      <label class="col-sm-2 control-label">  </label>
			       <div class="col-sm-8">
			          <table  class="table table-bordered table-striped table-hover" id="cusCanUseCardTab">
			              <thead>
			                  <tr>
			                    <td>卡编号</td>
			                    <td style="display:none;">卡类型</td>
			                    <td>卡类型</td>
			                    <td>可用次数</td>
			                    <td>剩余次数</td>
			                  </tr>
			              </thead>
			              <tbody id="cusCanUseCard"></tbody>
			          </table>
			       </div>
			  </div>
			  <div class="form-group payCardType" >
			    <label for="pay_card_type" class="col-sm-2 control-label">支付卡类型：</label>
			    <div class="col-sm-8">
			      <select id="pay_card_type" class="form-control"></select>
			    </div>
			  </div>
			  <div class="form-group payCardType" >
			    <label for="pay_card_num" class="col-sm-2 control-label">卡编号：</label>
			    <div class="col-sm-8">
			      <input class="form-control" id="pay_card_num">
			    </div>
			  </div>
			  <div class="form-group payCardType" >
			    <label for="use_card_count" class="col-sm-2 control-label">使用次数：</label>
			    <div class="col-sm-8">
			      <input class="form-control" id="use_card_count">
			    </div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	         <button type="button" class="btn btn-primary" onclick="cusCase.payCase();">支付</button>
	        <button type="button" class="btn btn-default" onclick="cusCase.closeCasePayModal('cusCasePayModal','cusCasePayForm')">取消</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
<!-- 诊疗记录 详情-->
<div class="modal fade" tabindex="-1" role="dialog" id="CusCaseDetailsModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <button type="button" class="close" onclick="cusCase.closeCasePayModal('CusCaseDetailsModal','CusCaseDetailsForm')" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">诊疗详情</h4>
      </div>
      <div class="modal-body">
         <form class="form-horizontal" id="CusCaseDetailsForm">
            <div class="form-group">
              <label for="caseCusIdDetail" class="col-sm-2 control-label">客户ID：</label>
              <div class="col-sm-8">
                 <input  id="caseCusIdDetail" class="form-control" readonly/>
              </div>
           </div>
           <div class="form-group">
              <label for="caseCusNameDetail" class="col-sm-2 control-label">客户姓名：</label>
              <div class="col-sm-8">
                 <input  id="caseCusNameDetail" class="form-control" readonly/>
              </div>
           </div>
           <div class="form-group">
              <label for="caseCusTelDetail" class="col-sm-2 control-label">客户联系电话：</label>
              <div class="col-sm-8">
                 <input  id="caseCusTelDetail" class="form-control" readonly/>
              </div>
           </div>
		  <div class="form-group">
		    <label for="msInstitutionDetail" class="col-sm-2 control-label">医疗机构：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="msInstitutionDetail" placeholder="输入医疗机构" readonly/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="msDepartmentDetail" class="col-sm-2 control-label">医疗科室：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="msDepartmentDetail" placeholder="输入医疗科室" readonly/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="seeDoctorTimeDetail" class="col-sm-2 control-label">就诊时间：</label>
		    <div class="col-sm-8">
		      <input  class="form-control datepicker" id="seeDoctorTimeDetail" readonly/>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="firstSeeDoctorTimeDetail" class="col-sm-2 control-label">初诊时间：</label>
		    <div class="col-sm-8">
		      <input  class="form-control datepicker" id="firstSeeDoctorTimeDetail" readonly/>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="healthNumberDetail" class="col-sm-2 control-label">医保证号：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="healthNumberDetail" readonly/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="msHeightDetail" class="col-sm-2 control-label">身高：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="msHeightDetail" readonly/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="heartRateDetail" class="col-sm-2 control-label">心率：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="heartRateDetail" readonly/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="bloodSugarDetail" class="col-sm-2 control-label">血糖：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="bloodSugarDetail" readonly/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="bloodFatDetail" class="col-sm-2 control-label">血脂：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="bloodFatDetail" readonly/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="bloodPressureDetail" class="col-sm-2 control-label">血压：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="bloodPressureDetail" readonly/>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="mainlyAboutDetail" class="col-sm-2 control-label">主诉：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="mainlyAboutDetail" readonly></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="allergyDetail" class="col-sm-2 control-label">过敏史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="allergyDetail" readonly></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="hpiDetail" class="col-sm-2 control-label">现病史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="hpiDetail" readonly></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="pastMedicalHisDetail" class="col-sm-2 control-label">既往史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="pastMedicalHisDetail" readonly></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="hisMedicineDetail" class="col-sm-2 control-label">治疗史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="hiyMedicineDetail" readonly></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="medicationHisDetail" class="col-sm-2 control-label">用药史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="medicationHisDetail" readonly></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="chronicIllnessDetail" class="col-sm-2 control-label">慢性病史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="chronicIllnessDetail" readonly></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="geneticHisDetail" class="col-sm-2 control-label">遗传病史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="geneticHisDetail" readonly></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="fzjcDetail" class="col-sm-2 control-label">辅助检查：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="fzjcDetail" readonly></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="physicalCheckDetail" class="col-sm-2 control-label">体格检查：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="physicalCheckDetail" readonly></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="chineseMedicineDetail" class="col-sm-2 control-label">中医诊断：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="chineseMedicineDetail" readonly></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="westernMedicineDetail" class="col-sm-2 control-label">西医诊断：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="westernMedicineDetail" readonly></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="treatmentItemDetails" class="col-sm-2 control-label">治疗项目：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="treatmentItemDetails" readonly/>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="treatmentOptionsDetail" class="col-sm-2 control-label">治疗方案：</label>
		    <div class="col-sm-8">
		      <textarea  class="form-control" id="treatmentOptionsDetail" readonly></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="physicianSignatureDetail" class="col-sm-2 control-label">医师签名：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="physicianSignatureDetail" readonly/>
		    </div>
		  </div>
		  <div class="form-group">
		     <label for="caseNoteDetail" class="col-sm-2 control-label">备注：</label>
		     <div class="col-sm-8">
		        <textarea rows=3  class="form-control" id="caseNoteDetail" readonly></textarea>
		     </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" onclick="cusCase.closeCasePayModal('CusCaseDetailsModal','CusCaseDetailsForm')">关闭</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/customer/cusCaseList.js"></script>
</body>
</html>
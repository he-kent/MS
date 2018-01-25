<%@ page language="java" contentType="text/html; charset=utf-8"   pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>客户维护</title>
<link rel='stylesheet' type="text/css" href="${pageContext.request.contextPath}/resource/css/customer.css"/>
</head>
<body>
   <div class="search-box">
     <form class="form-inline" id="cusSearchForm">
	  <div class="form-group">
	    <input type="text" class="form-control" id="cusNameOrTel" placeholder="输入用户名或手机号">
	  </div>
	  <button type="button" class="btn btn-info" onclick="cus.initCusDateGrid();return false;">查询</button>
	  <button type="button" class="btn btn-info" onclick="cus.clearForm('cusSearchForm');return false;">清空</button>
	</form>
	<hr/>
	<div class="optionMenuBar">
	  <button type="button" class="btn btn-info" onclick="cus.openCusModal('addCusModal');" >添加客户</button>
	</div>
  </div>
  <table class="table table-bordered table-striped table-hover">
     <thead>
     	<tr>
            <th>ID</th>
     	    <th>客户名称</th>
     	    <th>联系电话</th>
     	    <th>性别</th>
     	    <th>出生日期</th>
     	    <th>住址</th>
     	    <th>创建时间</th>
     	    <th>修改时间</th>
     	    <!-- <th>备注</th> -->
     	    <th>操作</th>
     	</tr>
     </thead>
     <tbody id="customerDataGrid"></tbody>
  </table>
  <!-- 添加客户 -->
  <div class="modal fade" tabindex="-1" role="dialog" id="addCusModal" data-backdrop="static">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <button type="button" class="close" onclick="cus.closeCusModal('addCusModal','addCusForm')" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">添加客户</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" id="addCusForm">
		  <div class="form-group">
		    <label for="cusNameAdd" class="col-sm-2 control-label">客户姓名：</label>
		    <div class="col-sm-8">
		      <input type="email" class="form-control" id="cusNameAdd" name="cus_name" placeholder="请输入客户名称">
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		  <div class="form-group">
		    <label for="cusTelAdd" class="col-sm-2 control-label">联系电话：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="cusTelAdd" name="cus_tel" placeholder="请输入联系电话">
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		   <div class="form-group">
		    <label for="cusBirthdayAdd" class="col-sm-2 control-label">出生日期：</label>
		    <div class="col-sm-8">
		      <input  class="datepicker form-control" id="cusBirthdayAdd" name="cus_birthday" placeholder="请输入出生日期">
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		  <div class="form-group">
		    <label for="cusSexAdd" class="col-sm-2 control-label">性别：</label>
		    <div class="col-sm-8">
		      <select id="cusSexAdd" class="form-control" id="cusSexAdd" name="cus_sex">
		         <option value="female">女</option>
		         <option value="male">男</option>
		      </select>
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		  <div class="form-group">
		    <label for="cusAddressAdd" class="col-sm-2 control-label">住址：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="cusAddressAdd" name="cus_address" placeholder="请输入住址">
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		   <div class="form-group">
		    <label for="cusNoteAdd" class="col-sm-2 control-label">备注：</label>
		    <div class="col-sm-8">
		       <textarea rows="3" class="form-control" id="cusNoteAdd" name="ms_note"></textarea>
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="cus.addCus();">保存</button>
        <button type="button" class="btn btn-default" onclick="cus.closeCusModal('addCusModal','addCusForm');">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
  <!-- 修改客户 -->
  <div class="modal fade" tabindex="-1" role="dialog" id="updateCusModal" data-backdrop="static">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <button type="button" class="close" onclick="cus.closeCusModal('updateCusModal','updateCusForm')" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">修改客户</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" id="updateCusForm">
          <input id="cusIdUpdate" type="hidden"/>
		  <div class="form-group">
		    <label for="cusNameUpdate" class="col-sm-2 control-label">客户姓名：</label>
		    <div class="col-sm-8">
		      <input type="email" class="form-control" id="cusNameUpdate" name="cus_name" placeholder="请输入客户名称">
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		  <div class="form-group">
		    <label for="cusTelUpdate" class="col-sm-2 control-label">联系电话：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="cusTelUpdate" name="cus_tel" placeholder="请输入联系电话">
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		   <div class="form-group">
		    <label for="cusBirthdayUpdate" class="col-sm-2 control-label">出生日期：</label>
		    <div class="col-sm-8">
		      <input  class="datepicker form-control" id="cusBirthdayUpdate" name="cus_birthday" placeholder="请输入出生日期" readonly>
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		  <div class="form-group">
		    <label for="cusSexUpdate" class="col-sm-2 control-label">性别：</label>
		    <div class="col-sm-8">
		      <select  class="form-control" id="cusSexUpdate" name="cus_sex">
		         <option value="female">女</option>
		         <option value="male">男</option>
		      </select>
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		  <div class="form-group">
		    <label for="cusAddressUpdate" class="col-sm-2 control-label">住址：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="cusAddressUpdate" name="cus_address" placeholder="请输入住址">
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		   <div class="form-group">
		    <label for="cusNoteUpdate" class="col-sm-2 control-label">备注：</label>
		    <div class="col-sm-8">
		       <textarea rows="3" class="form-control" id="cusNoteUpdate" name="ms_note"></textarea>
		    </div>
		    <label class="col-sm-2"></label>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="cus.updateCus();">保存</button>
        <button type="button" class="btn btn-default" onclick="cus.closeCusModal('updateCusModal','updateCusForm');">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
 <!-- 客户办卡 -->
  <div class="modal fade" tabindex="-1" role="dialog" id="CusCardModal" data-backdrop="static">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <button type="button" class="close" onclick="cus.closeCusModal('CusCardModal','CusCardForm')" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">办卡</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal" id="CusCardForm">
              <div class="form-group">
                 <label for="cusId" class="col-sm-2 control-label">办卡人ID：</label>
                 <div class="col-sm-8">
                    <input  id="cusId" class="form-control" readonly/>
                 </div>
              </div>
              <div class="form-group">
                 <label for="cusName" class="col-sm-2 control-label">办卡人姓名：</label>
                 <div class="col-sm-8">
                    <input  id="cusName" class="form-control" readonly/>
                 </div>
              </div>
              <div class="form-group">
                 <label for="cusTel" class="col-sm-2 control-label">办卡人电话：</label>
                 <div class="col-sm-8">
                    <input  id="cusTel" class="form-control" readonly/>
                 </div>
              </div>
              <div class="form-group">
                 <label for="cardTypeCus" class="col-sm-2 control-label">办卡类型：</label>
                 <div class="col-sm-8">
                    <select id="cardTypeCus" class="form-control" onchange="cus.onSelectCardType();"></select>
                 </div>
              </div>
              <div class="form-group">
                 <label for="cardAmount" class="col-sm-2 control-label">卡金额：</label>
                 <div class="col-sm-8">
                    <input  id="cardAmount" class="form-control" readonly/>
                 </div>
              </div>
              <div class="form-group">
                 <label for="validNum" class="col-sm-2 control-label">可使用次数：</label>
                 <div class="col-sm-8">
                    <input  id="validNum" class="form-control" readonly/>
                 </div>
              </div>
               <div class="form-group">
                 <label for="cardMoney" class="col-sm-2 control-label">实收金额：</label>
                 <div class="col-sm-8">
                    <input  id="cardMoney" class="form-control" />
                 </div>
              </div>
               <div class="form-group">
                 <label for="cardNum" class="col-sm-2 control-label">卡编号：</label>
                 <div class="col-sm-8">
                    <input  id="cardNum" class="form-control" />
                 </div>
              </div>
              <div class="form-group">
                 <label for="handlesCard" class="col-sm-2 control-label">售卡人：</label>
                 <div class="col-sm-8">
                    <input  id="handlesCard" class="form-control" />
                 </div>
              </div>
               <div class="form-group">
                 <label for="expiryTime" class="col-sm-2 control-label">到期时间：</label>
                 <div class="col-sm-8">
                    <input  id="expiryTime" class="datepicker form-control" />
                 </div>
              </div>
              <div class="form-group">
                 <label for="handelsNote" class="col-sm-2 control-label">备注：</label>
                 <div class="col-sm-8">
                    <input  id="handelsNote" class="form-control" />
                 </div>
              </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="cus.addCusCard();">保存</button>
        <button type="button" class="btn btn-default" onclick="cus.closeCusModal('CusCardModal','CusCardForm');">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<!-- 添加诊疗记录 -->
<div class="modal fade" tabindex="-1" role="dialog" id="addCaseModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <button type="button" class="close" onclick="cus.closeCusModal('addCaseModal','addCaseForm')" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">添加病历</h4>
      </div>
      <div class="modal-body">
         <form class="form-horizontal" id="addCaseForm">
            <div class="form-group">
              <label for="caseCusId" class="col-sm-2 control-label">客户ID：</label>
              <div class="col-sm-8">
                 <input  id="caseCusId" class="form-control" readonly/>
              </div>
           </div>
           <div class="form-group">
              <label for="caseCusName" class="col-sm-2 control-label">客户姓名：</label>
              <div class="col-sm-8">
                 <input  id="caseCusName" class="form-control" readonly/>
              </div>
           </div>
           <div class="form-group">
              <label for="caseCusTel" class="col-sm-2 control-label">客户联系电话：</label>
              <div class="col-sm-8">
                 <input  id="caseCusTel" class="form-control" readonly/>
              </div>
           </div>
		  <div class="form-group">
		    <label for="msInstitution" class="col-sm-2 control-label">医疗机构：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="msInstitution" placeholder="输入医疗机构"/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="msDepartment" class="col-sm-2 control-label">医疗科室：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="msDepartment" placeholder="输入医疗科室"/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="seeDoctorTime" class="col-sm-2 control-label">就诊时间：</label>
		    <div class="col-sm-8">
		      <input  class="form-control datepicker" id="seeDoctorTime" />
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="firstSeeDoctorTime" class="col-sm-2 control-label">初诊时间：</label>
		    <div class="col-sm-8">
		      <input  class="form-control datepicker" id="firstSeeDoctorTime" />
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="healthNumber" class="col-sm-2 control-label">医保证号：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="healthNumber" />
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="msHeight" class="col-sm-2 control-label">身高：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="msHeight" />
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="heartRate" class="col-sm-2 control-label">心率：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="heartRate" />
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="bloodSugar" class="col-sm-2 control-label">血糖：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="bloodSugar" />
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="bloodFat" class="col-sm-2 control-label">血脂：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="bloodFat"/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="bloodPressure" class="col-sm-2 control-label">血压：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="bloodPressure"/>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="treatmentItem" class="col-sm-2 control-label">治疗项目：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="treatmentItem"/>
		      <ul id="treatmentItemSelets" class="treatmentItemSelets">
		          <li>腰椎</li>
		          <li>颈椎</li>
		          <li>胸椎</li>
		          <li>拔罐</li>
		          <li>刮痧</li>
		          <li>针灸</li>
		      </ul>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="mainlyAbout" class="col-sm-2 control-label">主诉：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="mainlyAbout"></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="allergy" class="col-sm-2 control-label">过敏史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="allergy"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="hpi" class="col-sm-2 control-label">现病史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="hpi"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="pastMedicalHistory" class="col-sm-2 control-label">既往史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="pastMedicalHistory"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="hiistoryMedicine" class="col-sm-2 control-label">治疗史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="hiistoryMedicine"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="medicationHistory" class="col-sm-2 control-label">用药史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="medicationHistory"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="chronicIllness" class="col-sm-2 control-label">慢性病史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="chronicIllness"></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="geneticHistory" class="col-sm-2 control-label">遗传病史：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="geneticHistory"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="auxiliaryExamination" class="col-sm-2 control-label">辅助检查：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="auxiliaryExamination"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="physicalCheck" class="col-sm-2 control-label">体格检查：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="physicalCheck"></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="chineseMedicine" class="col-sm-2 control-label">中医诊断：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="chineseMedicine"></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="westernMedicine" class="col-sm-2 control-label">西医诊断：</label>
		    <div class="col-sm-8">
		      <textarea rows=3  class="form-control" id="westernMedicine"></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="treatmentOptions" class="col-sm-2 control-label">治疗方案：</label>
		    <div class="col-sm-8">
		      <textarea  class="form-control" id="treatmentOptions"></textarea>
		    </div>
		  </div>
		   <div class="form-group">
		    <label for="physicianSignature" class="col-sm-2 control-label">医师签名：</label>
		    <div class="col-sm-8">
		      <input  class="form-control" id="physicianSignature"/>
		    </div>
		  </div>
		  <div class="form-group">
		     <label for="caseNote" class="col-sm-2 control-label">备注：</label>
		     <div class="col-sm-8">
		        <textarea rows=3  class="form-control" id="caseNote"></textarea>
		     </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" onclick="cus.addCusCase()">保存</button>
        <button type="button" class="btn btn-default" onclick="cus.closeCusModal('addCaseModal','addCaseForm')">取消</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/customer/customer.js"></script>
</body>
</html>
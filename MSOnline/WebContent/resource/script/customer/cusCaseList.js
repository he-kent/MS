$(function(){
cusCase.initCusCaseList();
});
var cusCase={
		initCusCaseList:function(){
			var cusName =$("#cusCaseName").val(),
			    cusTel =$("#cusCaseTel").val(),
			    params ={"cusName":cusName,"cusTel":cusTel};
			ajax({
				url:contextPath+"/cus/cusCaseList.do",
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					var tbody=$("#cusCaseDataGridBody");
					tbody.empty();
					var html="";
					$.each(data.dates,function(index,value){
						html+="<tr>"+
						      "<td style=\"display:none;\">"+value.id+"</td>"+
						      "<td>"+value.cus_name+"</td>"+
						      "<td>"+value.cus_tel+"</td>"+
						      "<td style=\"display:none;\">"+value.cus_sex+"</td>"+
						      "<td style=\"display:none;\">"+value.ms_height+"</td>"+
						      "<td style=\"display:none;\">"+value.ms_institution+"</td>"+
						      "<td>"+value.ms_department+"</td>"+
						      "<td>"+new Date(value.see_doctor_time).Format("yyyy-MM-dd")+"</td>"+
						      "<td>"+new Date(value.first_see_doctor_time).Format("yyyy-MM-dd")+"</td>"+
						      "<td>"+value.allergy+"</td>"+
						      "<td>"+value.physician_signature+"</td>"+
						      "<td>"+value.treatment_options+"</td>"+
						      "<td><span "+(value.pay_status == 1?"class='text-danger'":"class='text-success'")+">"+value.payStatus+"</span></td>"+
						      "<td>"+(value.pay_status == 1 ? "<a href='#' onclick=\"cusCase.openCasePayModal('"+value.id+"','"+value.cus_id+"','"+value.cus_name+"','"+value.tcid+"')\" >支付</a>|" :"")+"<a href='#' onclick=\"cusCase.openCusCaseDetails('"+value.id+"')\">查看详情</a></td>"+
						      "</tr>";
					});
					tbody.html(html);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		openCasePayModal:function(cus_case_id,cus_id,cusName,tcid){
			$("#cus_case_id").val(cus_case_id);
			$("#cus_id").val(cus_id);
			$("#costPeople").val(cusName);
			$("#tcid").val(tcid);
			ajax({
				url:contextPath+'/card/getEffectiveCard.do',
				type:'post',
				data:{"cardStatus":1},
				dataType:'json',
				success:function(data){
					var payCardType=$("#pay_card_type");
					payCardType.empty();
					var html="<option value=0>请选择</option>";
					$.each(data,function(index,value){
						html +="<option value=\""+value.id+"\">"+value.cardName+"</option>";
					});
					payCardType.html(html);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
			$("#cusCasePayModal").modal('show');
		},
		closeCasePayModal:function(modalId,formId){
			$("#"+modalId).modal('hide');
			document.getElementById(formId).reset();
		},
		payTypeChage:function(){
			var payType = $("#pay_type").val();
			if(payType==1){ 
				$(".payCardType").show();
			}else{
				$(".payCardType").hide();
				$("#pay_card_type").val(0);
				$("#pay_card_num").val('');
				$("#use_card_count").val('');
			}
			
		},
		selectCard:function(){
			var cusName=$("#costPeople").val();
			ajax({
				url:contextPath+"/cus/cardConsumpList.do",
				type:'post',
				data:{"card_use_status":1,"cusName":cusName},
				dataType:'json',
				success:function(data){
					var html="";
					var cusCanUseCard=$("#cusCanUseCard");
					if(data.datas){
						$.each(data.datas,function(index,value){
							html+="<tr>"+
							      "<td>"+value.card_num+"</td>"+
							      "<td style=\"display:none\">"+value.cardType+"</td>"+
							      "<td>"+value.card_type+"</td>"+
							      "<td>"+value.valid_num+"</td>"+
							      "<td>"+value.remain+"</td>"+
							      "</tr>";
						});
					}else{
						html="<tr class='text-error'>该客户没有可用卡，或未办卡！</tr>";
					}
					cusCanUseCard.empty();
					cusCanUseCard.html(html);
					$("#cusCanUseCardTab").show();
					$("#cusCanUseCard tr").on("click",function(){
						$(this).each(function(index,elements){
							$("#pay_card_num").val($(elements).find("td").eq(0).text());
							alert($(elements).find("td").eq(1).text());
							$("#pay_card_type").val($(elements).find("td").eq(1).text());
							$("#use_card_count").val(1);
						});
					});
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		payCase:function(){
			var cusCaseId =$("#cus_case_id").val(),
			    cusId=$("#cus_id").val(),
			    tcid=$("#tcid").val(),
			   // costPeople=$("#costPeople").val(),
			    treatmentCost=$("#treatment_cost").val(),
			    payAmount=$("#pay_amount").val(),
			    payType=$("#pay_type").val(),
			    payCardType=$("#pay_card_type").val(),
			    payCardNum=$("#pay_card_num").val(),
			    useCardCount=$("#use_card_count").val(),
			    params={"useCardCount":useCardCount,"tcid":tcid,"cusCaseId":cusCaseId,"cusId":cusId,"treatmentCost":treatmentCost,"payAmount":payAmount,"payType":payType,"payCardType":payCardType,"payCardNum":payCardNum};
			ajax({
				url:contextPath+'/cus/payCase.do',
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					if(data.msg==1){
						cusCase.closeCasePayModal('cusCasePayModal','cusCasePayForm');
						cusCase.initCusCaseList();
					}else{
						alert('支付失败！');
					}
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		openCusCaseDetails:function(caseId){
			ajax({
				url:contextPath+'/cus/cusCaseDetails.do',
				type:'post',
				data:{"caseId":caseId},
				dataType:'json',
				success:function(data){
					$("#caseCusIdDetail").val(data.cus_id);
				    $("#caseCusNameDetail").val(data.cus_name);
				    $("#caseCusTelDetail").val(data.cus_tel);
				    $("#msInstitutionDetail").val(data.ms_institution);
				    $("#msDepartmentDetail").val(data.ms_department);
				    $("#seeDoctorTimeDetail").val(new Date(data.see_doctor_time).Format('yyyy-MM-dd'));
				    $("#firstSeeDoctorTimeDetail").val(new Date(data.first_see_doctor_time).Format('yyyy-MM-dd'));
				    $("#healthNumberDetail").val(data.health_number);
				    $("#msHeightDetail").val(data.ms_height);
				    $("#heartRateDetail").val(data.heart_rate);
				    $("#bloodSugarDetail").val(data.blood_sugar);
				    $("#bloodFatDetail").val(data.blood_fat);
				    $("#bloodPressureDetail").val(data.blood_pressure);
				    $("#mainlyAboutDetail").val(data.mainly_about);
				    $("#allergyDetail").val(data.allergy);
				    $("#hpiDetail").val(data.hpi);
				    $("#pastMedicalHisDetail").val(data.past_medical_history);
				    $("#hiyMedicineDetail").val(data.hiistory_medicine),
				    $("#medicationHisDetail").val(data.medication_history);
				    $("#chronicIllnessDetail").val(data.chronic_illness);
				    $("#geneticHisDetail").val(data.genetic_history);
				    $("#fzjcDetail").val(data.auxiliary_examination);
				    $("#physicalCheckDetail").val(data.physical_check);
				    $("#chineseMedicineDetail").val(data.chinese_medicine);
				    $("#westernMedicineDetail").val(data.western_medicine);
				    $("#treatmentOptionsDetail").val(data.treatment_options);
				    $("#physicianSignatureDetail").val(data.physician_signature);
					 $("#caseNoteDetail").val(data.ms_note);
					 $("#treatmentItemDetails").val(data.treatment_item);
					$("#CusCaseDetailsModal").modal('show');
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		}
};
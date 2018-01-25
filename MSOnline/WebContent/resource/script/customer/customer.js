$(function(){
	cus.initCusDateGrid();
	$( ".datepicker" ).datepicker({
		dateFormat:'yy-mm-dd',
		changeYear:true,
		changeMonth:true
	});
	var lis=$("#treatmentItemSelets li");
	$("#addCaseModal").on('show.bs.modal',function(e){
		var txt=[];
		$.each(lis,function(index,value){
			value.onclick=function(e){
				var t = $(e.target).text();
				txt.push(t);
				$(e.target).hide();
				$("#treatmentItem").val(txt.join(','));
			};
		});
	});
});

var cus={
		openCusModal:function(modalId){
			$("#"+modalId).modal('show');
		},
		closeCusModal:function(modalId,formId){
			$("#"+modalId).modal('hide');
			document.getElementById(formId).reset();
		},
		clearForm:function(formId){
			document.getElementById(formId).reset();
		},
		openUpdateCusModal:function(cusId){
			ajax({
				url:contextPath+'/cus/getCusById.do',
				type:'post',
				data:{"cusId":cusId},
				dataType:'json',
				success:function(data){
					console.log(data);
					 $("#cusNameUpdate").val(data.cusName),
					 $("#cusTelUpdate").val(data.cusTel),
					 $("#cusBirthdayUpdate").val(new Date(data.cusBirthday).Format("yyyy-MM-dd")),
					 $("#cusSexUpdate").val(data.cusSex),
					 $("#cusAddressUpdate").val(data.cusAddress),
					 $("#cusNoteUpdate").val(data.cusNote),
					 $("#cusIdUpdate").val(data.id),
					$('#updateCusModal').modal('show');
				},
				complete:function(XHR,TextStatus){
					XHT = null;
				}
			});
		},
		initCusDateGrid:function(){
			var cusNameOrTel =$("#cusNameOrTel").val(),
			    params={"cusNameOrTel":cusNameOrTel};
			ajax({
				url:contextPath+'/cus/getCusList.do',
				data:params,
				type:'post',
				dataType:'json',
				success:function(data){
					
				     var html="",
				         tbody=$("#customerDataGrid");
				         tbody.empty();
				     $.each(data.dates,function(index,value){
				    	 html+="<tr id=\""+value.id+"\">"+
				    	        "<td>"+value.id+"</td>"+
				    	        "<td>"+value.cusName+"</td>"+
				    	        "<td>"+value.cusTel+"</td>"+
				    	        "<td>"+value.cusSex+"</td>"+
				    	        "<td>"+new Date(value.cusBirthday).Format("yyyy-MM-dd hh:mm:ss")+"</td>"+
				    	        "<td>"+value.cusAddress+"</td>"+
				    	        "<td>"+new Date(value.createtime).Format("yyyy-MM-dd hh:mm:ss")+"</td>"+
				    	        "<td>"+new Date(value.updatetime).Format("yyyy-MM-dd hh:mm:ss")+"</td>"+
				    	        "<td><a href=\"#\"onclick=\"cus.openCusCardModal('"+value.id+"','"+value.cusTel+"','"+value.cusName+"')\">办卡</a>|<a href=\"#\" onclick=\"cus.openAddCaseModal('"+value.id+"','"+value.cusName+"','"+value.cusTel+"')\">添加诊疗记录</a>|<a href=\"#\" onclick=\"cus.openUpdateCusModal('"+value.id+"')\">修改</a></td>"+
				    	        "</tr>";
				     });
				     tbody.html(html);
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
		},
		addCus:function(){
			var cusName=$("#cusNameAdd").val(),
			    cusTel=$("#cusTelAdd").val(),
			    cusBirthday=$("#cusBirthdayAdd").val(),
			    cusSex=$("#cusSexAdd").val(),
			    cusAddress=$("#cusAddressAdd").val(),
			    cusNote=$("#cusNoteAdd").val(),
			    params ={"cusName":cusName,"cusTel":cusTel,"cusBirthday":cusBirthday,"cusSex":cusSex,"cusAddress":cusAddress,"cusNote":cusNote};
			ajax({
				url:contextPath+'/cus/addCus.do',
				data:params,
				type:'post',
				dataType:'json',
				success:function(data){
					if(data.msg==1){
						cus.initCusDateGrid();
					}
					cus.closeCusModal('addCusModal','addCusForm');
				}
			});
		},
		updateCus:function(){
			var cusName=$("#cusNameUpdate").val(),
			    cusTel=$("#cusTelUpdate").val(),
			    cusBirthday=$("#cusBirthdayUpdate").val(),
			    cusSex=$("#cusSexUpdate").val(),
			    cusAddress=$("#cusAddressUpdate").val(),
			    cusNote=$("#cusNoteUpdate").val(),
			    cusId =$("#cusIdUpdate").val(),
			    params ={"cusId":cusId,"cusName":cusName,"cusTel":cusTel,"cusBirthday":cusBirthday,"cusSex":cusSex,"cusAddress":cusAddress,"cusNote":cusNote};
			ajax({
				url:contextPath+'/cus/updateCus.do',
				data:params,
				type:'post',
				dataType:'json',
				success:function(data){
					if(data.msg==1){
						cus.initCusDateGrid();
					}
					cus.closeCusModal('updateCusModal','updateCusForm');
				}
			});
		},
		openCusCardModal:function(cusId,cusTel,cusName){
			$("#cusId").val(cusId);
			$("#cusTel").val(cusTel);
			$("#cusName").val(cusName);
			ajax({
				url:contextPath+'/card/getEffectiveCard.do',
				type:'post',
				data:{"cardStatus":1},
				dataType:'json',
				success:function(data){
					console.log(data);
					var cardTypeCus=$("#cardTypeCus");
					cardTypeCus.empty();
					var html="<option value=0>请选择</option>";
					$.each(data,function(index,value){
						html +="<option data-validNum=\""+value.validNum+"\" data-amount=\""+value.cardAmount+"\" value=\""+value.id+"\">"+value.cardName+"</option>";
					});
					cardTypeCus.html(html);
					$("#CusCardModal").modal('show');
				},
				complete:function(XHR,TextStatus){
					XHR = null;
				}
			});
			
		},
		addCusCard:function(){
			var cusId=$("#cusId").val(),
			    cusName=$("#cusName").val(),
			    cusTel=$("#cusTel").val(),
			    cardTypeCus=$("#cardTypeCus").val(),
			    cardAmount=$("#cardAmount").val(),
			    cardMoney=$("#cardMoney").val(),
			    cardNum=$('#cardNum').val(),
			    handlesCard=$("#handlesCard").val(),
			    expiryTime=$("#expiryTime").val(),
			    handelsNote=$("#handelsNote").val(),
			    validNum=$("#validNum").val(),
			    params={"cusId":cusId,"cusName":cusName,"cusTel":cusTel,"cardTypeCus":cardTypeCus,"cardAmount":cardAmount,"validNum":validNum,
				         "cardMoney":cardMoney,"cardNum":cardNum,"handlesCard":handlesCard,"expiryTime":expiryTime,"handelsNote":handelsNote};
			ajax({
				url:contextPath+"/cus/addCusCard.do",
				type:'post',
				data:params,
				dataType:'json',
				success:function(data){
					if(data.msg==1){
						cus.closeCusModal('CusCardModal','CusCardForm');
						alert("办卡成功！可以去办卡列表查询！");
					}else{
						alert("办卡失败！");
					}
				},
				complete:function(XHR,TextStatus){
					XHR= null;
				}
			});
		},
		onSelectCardType:function(){
			var cardTypeCus=$("#cardTypeCus").find("option:selected").attr("data-amount");
			var validNum = $("#cardTypeCus").find("option:selected").attr("data-validNum");
			$("#cardAmount").val(cardTypeCus);
			$("#validNum").val(validNum);
		},
		openAddCaseModal:function(cusId,cusName,cusTel){
			$("#caseCusId").val(cusId);
			$("#caseCusName").val(cusName);
			$("#caseCusTel").val(cusTel);
			$("#addCaseModal").modal('show');
		},
		addCusCase:function(){
			  var  cusId=$("#caseCusId").val(),
			       msInstitution=$("#msInstitution").val(),
			       msDepartment=$("#msDepartment").val(),
			       seeDoctorTime=$("#seeDoctorTime").val(),
			       firstSeeDoctorTime=$("#firstSeeDoctorTime").val(),
			       healthNumber=$("#healthNumber").val(),
			       msHeight=$("#msHeight").val(),
			       heartRate=$("#heartRate").val(),
			       bloodSugar=$("#bloodSugar").val(),
			       bloodFat=$("#bloodFat").val(),
			       bloodPressure=$("#bloodPressure").val(),
			       mainlyAbout=$("#mainlyAbout").val(),
			       allergy=$("#allergy").val(),
			       hpi=$("#hpi").val(),
			       pastMedicalHistory=$("#pastMedicalHistory").val(),
			       hiistoryMedicine=$("#hiistoryMedicine").val(),
			       medicationHistory=$("#medicationHistory").val(),
			       chronicIllness=$("#chronicIllness").val(),
			       geneticHistory=$("#geneticHistory").val(),
			       auxiliaryExamination=$("#auxiliaryExamination").val(),
			       physicalCheck=$("#physicalCheck").val(),
			       chineseMedicine=$("#chineseMedicine").val(),
			       westernMedicine=$("#westernMedicine").val(),
			       treatmentOptions=$("#treatmentOptions").val(),
			       caseNote=$("#caseNote").val(),
			       physicianSignature=$("#physicianSignature").val(),
			       treatmentItem=$("#treatmentItem").val(),
			       params={
				  "cusId":cusId,
				   "msInstitution":msInstitution,
				   "msDepartment":msDepartment,
			       "seeDoctorTime":seeDoctorTime,
			       "firstSeeDoctorTime":firstSeeDoctorTime,
			       "healthNumber":healthNumber,
			       "msHeight":msHeight,
			       "heartRate":heartRate,
			       "bloodSugar":bloodSugar,
			       "bloodFat":bloodFat,
			       "bloodPressure":bloodPressure,
			       "mainlyAbout":mainlyAbout,
			       "allergy":allergy,
			       "hpi":hpi,
			       "pastMedicalHistory":pastMedicalHistory,
			       "hiistoryMedicine":hiistoryMedicine,
			       "medicationHistory":medicationHistory,
			       "chronicIllness":chronicIllness,
			       "geneticHistory":geneticHistory,
			       "auxiliaryExamination":auxiliaryExamination,
			       "physicalCheck":physicalCheck,
			       "chineseMedicine": chineseMedicine,
			       "westernMedicine":westernMedicine,
			       "treatmentOptions":treatmentOptions,
			       "caseNote":caseNote,
			       "physicianSignature":physicianSignature,
			       "treatmentItem":treatmentItem
			       };
			  ajax({
				  url:contextPath+'/cus/addCusCase.do',
				  type:'post',
				  data:params,
				  dataType:'json',
				  success:function(data){
					  if(data.msg==1){
						  cus.closeCusModal('addCaseModal','addCaseForm');
						  alert("添加成功 ！可在病历列表中查询");
					  }else{
						  alert("添加失败 ！");
					  }
				  },
				  complete:function(XHR,TextStatus){
					  XHR = null;
				  }
			  });
		}
};

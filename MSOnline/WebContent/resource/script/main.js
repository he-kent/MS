$(function(){
	document.getElementById("toFirstPage").click();
});
var menuOpt = {
         		menuOnclick:function(obj){
         			var ul=$(obj).next("ul"),
         			    bool=ul.hasClass("menuopen");
         			if(bool){
         				ul.slideUp();
         				ul.removeClass("menuopen");
         				ul.removeClass("menuclose");
         			}else{
         				ul.addClass("menuopen");
         				ul.removeClass("menuclose");
         				ul.slideDown();
         			}
         		},
         		chileMenuIterator:function(rowId){
         			ajax({
         				url:contextPath+"/menu/getChildMenusByPid.do",
         				data:{"id":rowId},
         			    type:"post",
         			    dataType:"json",
         			    success:function(data){
         			    	menuOpt.addTableChildDatas(data,rowId);
         			    },complete: function (XHR, TextStatus) { 
         			    	     XHR = null ;
         			    	}
         			});
         		},
         		getAllMenus:function(){//获取菜单列表
         			ajax({
         				url:contextPath+"/menu/menuList.do",
         				data:{},
         				type:"post",
         				dataType:"json",
         				success:function(data){
         				   menuOpt.addTableParentDatas(data);
         				},complete:function(XHR,TextStatus){
         					XHR = null;
         				}
         			});
         		},
         		addTableParentDatas:function(data){//动态生产菜单列表 
         			var tBody=$("#menuTreeGridTBody"),
         			     htmlTxt="";
         			tBody.empty();
         			$.each(data.datas,function(index,value){
         		     htmlTxt += "<tr style='background-color:#F9F9F9' onclick=\"menuOpt.chileMenuIterator('"+value.id+"')\" id=\""+value.id+"\">"
         		         htmlTxt+="<td style='display:none;'>"+value.id+"</td>";
         		         htmlTxt+="<td>"+value.menuName+"</td>";
         		         htmlTxt+="<td>"+value.menuUrl+"</td>";
         		         htmlTxt+="<td>"+(value.menuStatus==1?'启用':'禁用')+"</td>";
         				 htmlTxt+="<td>"+value.pid+"</td>";
         				 htmlTxt+="<td><a href='#' onclick=\"openModal('addMenuModal','"+value.id+"')\" >添加子菜单|</a><a href=\"#\" onclick=\"openMenuUpdateModal('"+value.id+"')\" >修改|</a><a href=\"#\" onclick=\"updateMenuStatu('"+value.id+"',1)\">启用|</a><a href=\"#\" onclick=\"updateMenuStatu('"+value.id+"',2)\">禁用</a></td>";
         			     htmlTxt+="</tr>";
 					});
         			tBody.html(htmlTxt);
         		},
         		addTableChildDatas:function(data,rowId){//动态添加子菜单列表
         			if(data){
         				
         				var tr =$("#"+rowId),
         				 trHtml="";
         				$(".childtr"+rowId).remove();
            			 $.each(data,function(index,value){
            			  trHtml+= "<tr class=\"childtr"+rowId+"\" id=\""+value.id+"\">";
            				 trHtml+="<td style='display:none;'>"+value.id+"</td>";
            				 trHtml+="<td><span style='display:inline-block;width:20px'></span>"+value.menuName+"</td>";
            				 trHtml+="<td>"+value.menuUrl+"</td>";
            				 trHtml+="<td>"+(value.menuStatus==1?'启用':'禁用')+"</td>";
            				 trHtml+="<td>"+value.pid+"</td>";
            				 trHtml+="<td><a href=\"#\" onclick=\"openMenuUpdateModal('"+value.id+"')\">修改|</a><a href=\"#\" onclick=\"updateMenuStatu('"+value.id+"',1)\">启用|</a><a href=\"#\" onclick=\"updateMenuStatu('"+value.id+"',2)\">禁用</a></td>";
            				 trHtml+="</tr>";
      			       });
            			 tr.after(trHtml);
         			}
         		},
         		initList:function(){
         			this.getAllMenus();//初始菜单列表
         		},
         		toLoadPage:function(menuUrl){//点击左侧菜单加载页面 #mainContent
         			var e = event || window.event;
         			e.preventDefault();
         			$("#mainContent").load(contextPath+"/"+menuUrl);
         		}
         	};

	var baseOpt = {
			strIsEmpty:function(str){
				if(str.replace(/(^s*)|(s*$)/g,"").length == 0){  //如果字符串去掉空白字符 长度等于 0  判断该字符串为空（null  undefined ''）
					return true;
				}else{
					return false;
				}
			},
			baseClearForm:function(formId){
				document.getElementById(formId).reset();
			}
	};

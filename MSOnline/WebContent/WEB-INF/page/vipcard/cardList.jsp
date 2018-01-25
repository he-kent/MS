<%@ page language="java" contentType="text/html; charset=utf-8"   pageEncoding="utf-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>会员卡管理</title>
</head>
<body>
 <div class="search-box">
            <form class="form-inline" role="form">
			  <div class="form-group">
			    <label for="cardame-search">卡名称:</label>
			    <input type="text" class="form-control" id="cardame-search" placeholder="请输入卡名称"/>
			  </div>
			  <button type="submit" class="btn btn-info" onclick="card.cardListInit();return false;">查询</button>
			</form>
			 
			<hr/>
			<div class="optionMenuBar">
			  <button type="button" class="btn btn-info" id="addCardBtn" onclick="card.openAddCardWin('addCardModel','addCardForm')">添加卡</button>
			</div>
    </div>
          <div>
           <table class="table table-bordered table-striped table-hover" id="cardDataGrid">
                <thead>
                    <tr>
                        <th >ID</th>
                        <!-- <th>卡编号</th> -->
                        <th>卡名称</th>
                        <th>卡金额</th>
                        <th style="display:none;">卡类型</th>
                        <th>到期时间</th>
                        <th>有效次数</th>
                        <th>状态</th>
                        <th>创建时间</th>
                        <th>修改时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody id="cardDataGridBody"></tbody>
             </table>
          </div>
          <!-- 添加卡modal -->
          <div class="modal fade"  id="addCardModel" tabindex="-1" role="dialog">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close"  aria-label="Close" onclick="card.closeAddCardWin('addCardModel','addCardForm')"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">添加卡</h4>
			      </div>
			      <div class="modal-body">
			         <form class="form-horizontal" id="addCardForm">
			             <div class="form-group">
			                 <label for="cardname-add" class="col-sm-2 control-label">卡名称:</label>
			                 <div class="col-sm-8">
			                    <input id="cardname-add" name="cardname" class="form-control" placeholder="请输入卡名"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="card-status-add" class="col-sm-2 control-label">状态:</label>
			                 <div class="col-sm-8">
			                    <select id="card-status-add" class="form-control">
			                       <option value=1>有效</option>
			                       <option value=2>无效</option>
			                    </select>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			            <!--  <div class="form-group">
			                 <label for="card-type-add" class="col-sm-2 control-label">卡类型:</label>
			                 <div class="col-sm-8">
			                    <select id="card-type-add" class="form-control" ></select>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div> -->
			             <div class="form-group">
			                <label for="card-validNum-add" class="col-sm-2 control-label">有效次数:</label>
			                <div class="col-sm-8">
			                    <input id="card-validNum-add" name="valid_num" class="form-control"/>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="card-expiryTime-add" class="col-sm-2 control-label">到期时间:</label>
			                <div class="col-sm-8">
							  <input type="text" name="expiry_time" id="card-expiryTime-add"  class="datepicker form-control"/>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			            <!--  <div class="form-group">
			                <label for="cardNumber-add" class="col-sm-2 control-label">卡编号:</label>
			                <div class="col-sm-8">
			                   <input id="cardNumber-add" name="card_number" class="form-control"/>
			                </div>
			                <label class="col-sm-2"></label>
			             </div> -->
			             <div class="form-group">
			                <label for="cardAmount-add" class="col-sm-2 control-label">卡金额:</label>
			                <div class="col-sm-8">
			                   <input id="cardAmount-add" name="card_amount" class="form-control"/>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="cardNote-add" class="col-sm-2 control-label">备注:</label>
			                <div class="col-sm-8">
			                   <textarea id="cardNote-add" name="card_note" class="form-control" rows="3"></textarea>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			         </form>
			      </div>
			      <div class="modal-footer">
			         <button type="button" class="btn btn-info" onclick="card.addCard();">添加</button>
			        <button type="button" class="btn btn-default" onclick="card.closeAddCardWin('addCardModel','addCardForm')">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			  <!-- 修改卡modal -->
          <div class="modal fade"  id="updateCardModel" tabindex="-1" role="dialog">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary">
			        <button type="button" class="close"  aria-label="Close" onclick="card.closeAddCardWin('updateCardModel','updateCardForm')"><span aria-hidden="true">&times;</span></button>
			        <h4 class="modal-title">修改卡</h4>
			      </div>
			      <div class="modal-body">
			         <form class="form-horizontal" id="updateCardForm">
			             <input id="updateCardId" type="hidden"/>
			             <div class="form-group">
			                 <label for="cardname-update" class="col-sm-2 control-label">卡名称:</label>
			                 <div class="col-sm-8">
			                    <input id="cardname-update" name="cardname" class="form-control" placeholder="请输入卡名"/>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                 <label for="card-status-update" class="col-sm-2 control-label">状态:</label>
			                 <div class="col-sm-8">
			                    <select id="card-status-update" class="form-control">
			                       <option value=1>有效</option>
			                       <option value=2>无效</option>
			                    </select>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div>
			            <!--  <div class="form-group">
			                 <label for="card-type-update" class="col-sm-2 control-label" >卡类型:</label>
			                 <div class="col-sm-8">
			                    <select id="card-type-update" class="form-control"> </select>
			                 </div>
			                 <label class="col-sm-2"></label>
			             </div> -->
			             <div class="form-group">
			                <label for="card-validNum-update" class="col-sm-2 control-label">有效次数:</label>
			                <div class="col-sm-8">
			                    <input id="card-validNum-update" name="valid_num" class="form-control"/>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="card-expiryTime-update" class="col-sm-2 control-label">到期时间:</label>
			                <div class="col-sm-8">
							  <input type="text" name="expiry_time" id="card-expiryTime-update"  class="datepicker form-control"/>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="cardAmount-update" class="col-sm-2 control-label">卡金额:</label>
			                <div class="col-sm-8">
			                   <input id="cardAmount-update" name="card_amount" class="form-control"/>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			             <div class="form-group">
			                <label for="cardNote-update" class="col-sm-2 control-label">备注:</label>
			                <div class="col-sm-8">
			                   <textarea id="cardNote-update" name="card_note" class="form-control" rows="3"></textarea>
			                </div>
			                <label class="col-sm-2"></label>
			             </div>
			         </form>
			      </div>
			      <div class="modal-footer">
			         <button type="button" class="btn btn-info" onclick="card.updateCard();">修改</button>
			        <button type="button" class="btn btn-default" onclick="card.closeAddCardWin('updateCardModel','updateCardForm')">取消</button>
			      </div>
			    </div><!-- /.modal-content -->
			  </div><!-- /.modal-dialog -->
			</div><!-- /.modal -->
			<script type="text/javascript" src="${pageContext.request.contextPath}/resource/script/vipcard/vipcard.js"></script>
</body>
</html>
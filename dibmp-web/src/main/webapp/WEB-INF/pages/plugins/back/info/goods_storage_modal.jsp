<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<div class="modal fade" id="goodsRecordInfo"  tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true" data-keyboard="true">
	<div class="modal-dialog" style="width: 1000px">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button>
				<div class="form-group" id="didDiv">
					<strong><span class="glyphicon glyphicon-eye-open"></span>&nbsp;商品库存详情</strong></h3>
				</div>
			</div>
			<div class="modal-body">
				<div>
					<table class="table table-condensed table-bordered table-hover" id="detailsTab">
						<thead>
							<tr>
								<th class="text-left" style="width:40%;">仓库名称</th> 
								<th class="text-center" style="width:10%;">省份</th>
								<th class="text-center" style="width:10%;">城市</th>
								<th class="text-center" style="width:10%;">库存数量</th>
							</tr>
						</thead>
						<tbody>
							<tr class="text-primary">
								<td class="text-left">通州一号仓库</td>
								<td class="text-center">北京</td>
								<td class="text-center">北京</td>
								<td class="text-center">2000</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
			</div>
		</div>
	</div>
</div>

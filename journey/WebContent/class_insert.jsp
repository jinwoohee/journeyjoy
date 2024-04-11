<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
 <% 
	request.setCharacterEncoding("utf-8");
	String u_id = (String) session.getAttribute("u_id");	
%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JOURNEY JOY::������::</title>

	<!-- css -->
	<link rel="stylesheet" type="text/css" href="css/class_insert.css">

	<!-- jquery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

	<!-- ��¥ -->
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<script>
	$(function(){
		/* ��¥ */
		$("#endDt").datepicker({
			dateFormat: 'yy-mm-dd' //�޷� ��¥ ����
			,minDate:0
			,nextText : ">"
			,prevText : "<"
			,showOtherMonths: true //�� ������ ������� �յڿ��� ��¥�� ǥ��
			,showMonthAfterYear:true //�⵵ - �� ����
			,changeYear: true //�� ���� ����
            ,changeMonth: true //�� ���� ����
            ,monthNamesShort: ['1��','2��','3��','4��','5��','6��','7��','8��','9��','10��','11��','12��'] //�޷��� �� �κ� �ؽ�Ʈ
            ,dayNamesMin: ['��','��','ȭ','��','��','��','��'] //�޷��� ���� �ؽ�Ʈ
		});

		/* ����� ��ưŬ��->���Ͼ��ε� */
		$("#fileBtn").click(function (e) {
			$('input[type=file]').click();
		});

		$('input[type=button]').mouseleave(function(){
			$(this).css({'box-shadow':'none'});
		});

		/* ����� ��� �� �̹��� �̸����� */
		var img = new Image();
		img.src = '';

		$('input[type=file]').change(function(event){
			const file = event.target.files;
			var imgTempUrl = window.URL.createObjectURL(file[0]);

			img.src = imgTempUrl;
			
			$('div[name=preview]').append(img);
		});
		
		//õ���� �޸� 
		$("input[name=guide]").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9.]/g,'').replace(/\B(?=(\d{3})+(?!\d))/g, ","));
		});
		
		//�����Է°� Ȯ��
		$("input[name=volumn]").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9.]/g,''));
		});
	});
</script>
<body>
	<jsp:include page="main_header.jsp" />
	<section id="main_section">
		<div>
			<form id="classMade" action='classInsert.jj?page=classInsert' method='post'>
				<table id="classTable">
					<tr><td>����</td></tr>
					<tr>
						<td>
							<select name="city" size="1">
					    		<option value="choice">����</option>
					    		<option value="tokyo">����</option>
					    		<option value="osaka">����ī</option>
					    		<option value="toronto">�����</option>
					    		<option value="vancouver">�����</option>
						  	</select>
						</td>
					</tr>
					<tr><td>����</td></tr>
					<tr>
						<td>
							<input type="text" name="title" size="20" maxlength="50">
						</td>
					</tr>
					<tr><td>����</td></tr>
					<tr>
						<td>
							<textarea name="contents" cols="7" maxlength="300"></textarea>
						</td>
					</tr>
					<tr><td>�����ο�</td></tr>
					<tr>
						<td>
							<input type="text" name="volumn" size="20" maxlength="3" placeholder=" (�ּ� 3���̻�)">
						</td>
					</tr>
					<tr><td>����</td></tr>
					<tr>
						<td>
							<input type="text" name="charge" size="20" placeholder=" ���� �Է�">
						</td>
					</tr>
					<tr><td>����������¥</td></tr>
					<tr>
						<td>
							<input type="text" name='endDt' id="endDt" placeholder="���൵����">
						</td>
					</tr>
					<tr><td>÷������</td></tr>
					<tr>
						<td>
							<div id="thumnail">
								<div name="preview"></div>
							</div>
							<div>
								<input type="file" name="file" accept=".jpg, .png, .gif" />
								<input type="button" id="fileBtn" value="�߰�">
							</div>
						</td>
					</tr>
				</table>
				<div id="buttonArea">
					<input type="hidden" name="u_id" value="<%=(String)session.getAttribute("u_id")%>">
					<input type="submit" value="����ϱ�">
				</div>
			</form>
		</div>
	</section>
	<jsp:include page="main_footer.jsp" />
</body>
</html>
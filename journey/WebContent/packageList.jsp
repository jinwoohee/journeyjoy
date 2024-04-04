<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- css -->
<link rel="stylesheet" type="text/css" href="css/packageList.css">

<!-- jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<!-- font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

</head>
<script>
	$(function() {
		/* 날짜 */
		$("#datepicker").datepicker({
			dateFormat: 'yy-mm-dd' //달력 날짜 형태
			,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
			,showMonthAfterYear:true //년도 - 월 순서
			,changeYear: true //년 선택 가능
            ,changeMonth: true //월 선택 가능
            ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 텍스트
		});

		//초기값을 오늘 날짜로 설정
        $("#datepicker").datepicker('setDate', 'today');

        /* 이미지 mouseenter, mouseleave */
        $(".thumnail").mouseenter(function(){
        	$(this).find('img').css({'transform':'scale(1.2)'});
        });
        $(".thumnail").mouseleave(function(){
        	$(this).find('img').css({'transform':'scale(1)'});
        });

        /* 버튼 mouseenter, mouseleave */
        $("input[type='button']").mouseenter(function(){
        	$(this).css({'box-shadow':'inset 5px 5px 10px #000054'});
        });
        $("input[type='button']").mouseleave(function(){
        	$(this).css({'box-shadow':'none'});
        });	

        /* 찜하기 */
        $("li div:nth-of-type(2)>img").click(function() {
        	if($(this).attr('src') == 'img/icon/heart2.png'){
        		$(this).attr('src','img/icon/heart.png');
        	}else{
        		$(this).attr('src','img/icon/heart2.png');
        	}
        });

        /* 클릭 눌러도 화면 위로 이동X */
        $("a").click(function(e){
		    e.preventDefault();
		});

        /* 상세보기 이동 */
        $(".thumnail").click(function () {
        	$(location).attr('href', 'packageDetail.jsp');
        })

        /* 페이징 */
        /* $("#paging").twbsPagination({
        	startPage:1,	//시작시 표시되는 현재 페이지
        	totalPages:5,	//총 페이지
        	visiblePages:12, //한페이지당 보여지는 페이지 수
        	first:"<<",
        	last:">>",
        	prev:"<이전",
        	next:"다음>",

        	onPageClick: function(event, page){
        		//클릭이벤트
        	}
        });  */
	});
</script>
<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	
	<!-- header(이미지) -->
	<section>
		<div id="top_section">
			<img src="img/travel/travel15.jpg">
			<div>
				<div>
					<h1>패키지 여행</h1>
					<p>#다함께 #떠나는 #패키지 #여행</p>
				</div>
			</div>
		</div>
	</section>

	<!-- 계획하기 버튼 -->
	<div>
		<input type="button" value="패키지 기획하기" onclick="location.href='packagePlan.jsp'">
	</div>

	<!-- 검색구간 -->
	<section>
		<div id="search_section">
			<div>
				<select>
					<option value="choice">전체</option>
					<option value="progress">진행</option>
					<option value="end">종료</option>
				</select>

				<select>
					<option value="latest">최신순</option>
					<option value="popularity">인기순</option>
					<option value="deadline">마감순</option>
				</select>

				<select>
					<option value="choice">여행도시</option>
					<option value="japan">일본</option>
					<option value="canada">캐나다</option>
					<option value="america">미국</option>
				</select>

				<input type="text" id="datepicker">

				<div id="search">
					<input type="text" name="searchBox" placeholder="  검색단어 입력">
					<input type="submit" value="검색">
				</div>
			</div>
		</div>
	</section>

	<!-- 리스트 출력 -->
	<section>
		<!-- 첫번째 라인 -->
		<article>
			<div>
				<ul>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo1.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>2박3일 도쿄 맛집여행</P></div>
							<div><p>99,000~</p></div>
							<div><p>닉네임1</p></div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo2.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>도쿄 쇼핑 여행</P></div>
							<div><p>129,000~</p></div>
							<div><p>닉네임2</p></div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo3.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>도쿄 힐링 투어</P></div>
							<div><p>70,000~</p></div>
							<div><p>닉네임3</p></div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo4.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>로컬맛집투어!</P></div>
							<div><p>109,000~</p></div>
							<div><p>닉네임4</p></div>
						</a>
					</li>
				</ul>
			</div>	
		</article>

		<!-- 두번째 라인 -->
		<article>
			<div>
				<ul>
					<li>
						<a href="">
							<div class="thumnail"><img src="img/japan/tokyo1.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>2박3일 도쿄 맛집여행</P></div>
							<div><p>99,000~</p></div>
							<div><p>닉네임1</p></div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo2.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>도쿄 쇼핑 여행</P></div>
							<div><p>129,000~</p></div>
							<div><p>닉네임2</p></div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo3.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>도쿄 힐링 투어</P></div>
							<div><p>70,000~</p></div>
							<div><p>닉네임3</p></div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo4.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>로컬맛집투어!</P></div>
							<div><p>109,000~</p></div>
							<div><p>닉네임4</p></div>
						</a>
					</li>
				</ul>
			</div>	
		</article>

		<!-- 세번째 라인 -->
		<article>
			<div>
				<ul>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo1.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>2박3일 도쿄 맛집여행</P></div>
							<div><p>99,000~</p></div>
							<div><p>닉네임1</p></div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo2.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>도쿄 쇼핑 여행</P></div>
							<div><p>129,000~</p></div>
							<div><p>닉네임2</p></div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo3.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>도쿄 힐링 투어</P></div>
							<div><p>70,000~</p></div>
							<div><p>닉네임3</p></div>
						</a>
					</li>
					<li>
						<a href="#">
							<div class="thumnail"><img src="img/japan/tokyo4.jpg" /></div>
							<div><img src="img/icon/heart2.png"/></div>
							<div><P>로컬맛집투어!</P></div>
							<div><p>109,000~</p></div>
							<div><p>닉네임4</p></div>
						</a>
					</li>
				</ul>
			</div>	
		</article>
	</section>
	  <div id="paging"></div>
	<jsp:include page="main_footer.html" />	
	
</body>
</html>
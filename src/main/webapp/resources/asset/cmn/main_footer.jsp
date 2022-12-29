

<style>
.btn_gotop {
  display:none;
  position:fixed;
  bottom:150px;
  right:100px;
  z-index:999;
  border:1px solid #ccc;
  outline:none;
  background-color:white;
  color:#333;
  cursor:pointer;
  padding:15px 20px;
  border-radius:100%;
}
</style>

<script>
$(window).scroll(function(){
  if ($(this).scrollTop() > 300){
    $('.btn_gotop').show();
  } else{
    $('.btn_gotop').hide();
  }
});
$('.btn_gotop').click(function(){
  $('html, body').animate({scrollTop:0},400);
  return false;
});
</script>

<!-- 상단으로 이동하기 버튼 -->
<a href="#" class="btn_gotop">
  <span class="glyphicon glyphicon-chevron-up">
  </span>
</a>

<footer style="margin-top: 100px; bottom:0; width: 100%; border: 1px solid; background-color: #eee; text-align: center;">
    <p>&nbsp;</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
      Copyright &copy; by 2022 Elecmusk All right reserved
    <p>&nbsp;</p>  
    <p>&nbsp;</p>  
    <p>&nbsp;</p>  
</footer>

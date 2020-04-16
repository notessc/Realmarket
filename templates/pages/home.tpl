<?php $this->layout("layouts/main") ?>
<style>
  .Booking:link,.Booking:hover,.Booking:visited,.Booking:active{
    color:black;
    text-decoration: none;
  }

  .modal {
    z-index:1;
    display:none;
    padding-top:100px;
    position:fixed;
    left:0;
    top:0;
    width:100%;
    height:100%;
    overflow:auto;
    background-color:rgb(0,0,0);
    background-color:rgba(0,0,0,0.8)
  }

  .modal-content{
    margin: auto;
    display: block;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }

  .modal-hover-opacity {
    opacity:1;
    filter:alpha(opacity=100);
    -webkit-backface-visibility:hidden
  }

  .modal-hover-opacity:hover {
    opacity:0.60;
    filter:alpha(opacity=60);
    -webkit-backface-visibility:hidden
  }

  .close {
    text-decoration:none;
    float:right;
    top: 15px;
    font-size:40px;
    font-weight:bold;
    color:white;
    transition: 0.3s;
  }

  .close:hover,.close:focus {
    color: #bbb;
    text-decoration: none;
    cursor: pointer;
  } 

  .container1 {
    width:200px;
    display:inline-block;
  }
  .modal-content, #caption {   
    -webkit-animation-name: zoom;
    -webkit-animation-duration: 0.6s;
    animation-name: zoom;
    animation-duration: 0.6s;
  }


  @-webkit-keyframes zoom {
    from {-webkit-transform:scale(0)} 
    to {-webkit-transform:scale(1)}
  }

  @keyframes zoom {
    from {transform:scale(0)} 
    to {transform:scale(1)}
  }

</style>
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img class="first-slide" src="upload/BookingBooth (10).jpg" alt="First slide">
        <div class="container">
          <div class="carousel-caption text-left">
            <h1>BOOKING BOOTH SYSTEM</h1>
            <p>สามารถเพิ่มโอกาสทางธุรกิจให้ผู้ประกอบการที่เป็นเจ้าของตลาดสามแยกกระทุ่มแบนบริหารจัดการจำนวนพื้นที่ผู้เช่าร้านค้าภายในตลาดได้.</p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <img class="second-slide" src="upload/BookingBooth (8).jpg" alt="Second slide">
        <div class="container">
          <div class="carousel-caption">
            <h1>และยัง..</h1>
            <p>เพื่อเพิ่มช่องทางการจองพื้นที่ให้ผู้เช่าร้านค้าที่ตลาดสามแยกกระทุ่มแบน.</p>
          </div>
        </div>
      </div>
      <div class="carousel-item">
        <img class="third-slide" src="upload/BookingBooth (3).jpg" alt="Third slide">
        <div class="container">
          <div class="carousel-caption text-right">
            <h1>อีกทั้ง..</h1>
            <p>เพื่อให้ผู้ประกอบการที่เป็นเจ้าของตลาดสามแยกกระทุ่มแบนตรวจสอบจำนวนผู้เช่าและจำนวนพื้นที่ว่างได้อย่างชัดเจน.</p>
          </div>
        </div>
      </div>
	</div>
    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="sr-only">Next</span>
    </a>
</div>
<div class="container marketing">
  <div class="row featurette" style="background:rgb(243, 243, 243); padding: 20px;">
    <div class="col-md-4 text-center">
      <div class="row">
        <div class="col-sm-4" style="background:rgb(86, 179, 255); padding: 10px;">
            <i class="fas fa-store" style="font-size:70px;color:rgb(255, 255, 255)"></i>
        </div>
        <div class="col">
            <p style="font-size:20px; color:rgb(0, 0, 0)">จำนวนล๊อคทั้งหมด</p>
            <p style="font-size:20px; color:rgb(119, 119, 119)"><span id="booth_all"></span></p>
        </div>
      </div>
    </div>
    <div class="col-md-4 text-center">
      <div class="row">
        <div class="col-sm-4" style="background:rgb(255, 86, 86); padding: 10px;">
            <i class="fas fa-store" style="font-size:70px;color:rgb(255, 255, 255)"></i>
        </div>
        <div class="col">
            <p style="font-size:20px; color:rgb(0, 0, 0)">จำนวนล๊อคที่จองไปแล้ว</p>
            <p style="font-size:20px; color:rgb(119, 119, 119)"><span id="booth_booking"></span></p>
        </div>
      </div>
    </div>
    <div class="col-md-4 text-center">
      <div class="row">
        <div class="col-sm-4" style="background:#00CC00; padding: 10px;">
            <i class="fas fa-store" style="font-size:70px;color:rgb(255, 255, 255)"></i>
        </div>
        <div class="col">
            <p style="font-size:20px; color:rgb(0, 0, 0)">จำนวนล๊อคที่ยังเหลืออยู่</p>
            <p style="font-size:20px; color:rgb(119, 119, 119)"><span id="booth_balance"></span></p>
        </div>
      </div>
    </div>
  </div>

  <!-- Three columns of text below the carousel -->
  <?php if (isset($_SESSION["logged"])&& $_SESSION["status"]==0): ?>
  <br>
  <br>
  <br>
  <div class="row text-center">
    <div class="col-md-5"></div>
    <div class="col-md-2 p-3 mb-2 bg-dark text-white rounded-circle" style="cursor: pointer;" onclick="window.location.href='/booking'">
      <i class='fas fa-store' style='font-size:48px;'></i><br>
      จอง
    </div>  
    <div class="col-md-5"></div>
  </div>
  <?php endif ?>
  <hr class="featurette-divider">

  <div class="row featurette" >
    <div class="col-md-5">
        <h3 class="featurette-heading">
          มุมของกิน
        </h3>
        <p class="lead">
            &nbsp;&nbsp;&nbsp; มีร้านขายของกินหลากหลายความอร่อย กับ เมนูเด็ดๆ ที่ยกทัพความอร่อยมาให้ลูกค้าเรียกชิมกันอย่างหนำใจ ทั้งอาหาร ขนมหวาน และเครื่องดื่มต่างๆ&nbsp; ในราคาเป็นกันเองสบายกระเป๋า&nbsp; ใครซื้อแล้วอยากนั่งทาน ก็มีที่นั่งทาน พร้อมฟังเพลงเบาๆ ชิวๆได้ตลอดทั้งคืน 
        </p>
    </div>
    <div class="col-md-7">
        <img class src="upload/BookingBooth (4).jpg"  width="600" height="450 ">
    </div>
  </div>

  <hr class="featurette-divider">

  <div class="row featurette" >
    <div class="col-md-7">
      <img class src="upload/BookingBooth (7).jpg"  width="600" height="450">
    </div>
    <div class="col-md-5">
        <h3 class="featurette-heading">
          มุมเสื้อผ้า
        </h3>
        <p class="lead">
            &nbsp;&nbsp;&nbsp; จะพบกับสินค้าแฟชั่น เสื้อผ้าเก๋ๆ กระเป๋า รองเท้า เครื่องประดับ เครื่องสำอาง , สินค้าอุปกรณ์ไอทีต่างๆ ราคาไม่แพง สินค้ามือหนึ่ง-มือสอง , มีทั้งร้านรูปแบบเต้นท์ , ร้านเปิดท้าย , ร้านตั้งโต๊ะ , ร้านแบกะดิน ที่จะให้คุณเดินช้อปกันแบบไม่รู้เบื่อเลยทีเดียว 
        </p>
    </div>
  </div>

  <hr class="featurette-divider">

  <div class="row featurette" >
    <div class="col-md-5">
        <h3 class="featurette-heading">
          ที่ตั้งของตลาด
        </h3>
        <p class="lead">
            มีทำเลติดกับถนนใหญ่ ถนนทางหลวงหมายเลข 3091 โดยด้านข้างติดห้างใหญ่ คือ ห้างโลตัส สาขากระทุ่มแบนและโกลบอลเฮ้าส์ สาขากระทุ่มแบน&nbsp; จัดเป็นอีกหนึ่งตลาดนัดที่มีทำเลดี น่าสนใจเลยทีเดียว
        </p>
    </div>
    <div class="col-md-7">
      <iframe src="https://www.google.com/maps/embed?pb=!1m16!1m12!1m3!1d969.2683969440194!2d100.27400582918324!3d13.653287507825691!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!2m1!1z4LiV4Lil4Liy4LiU4LiZ4Lix4LiU4Liq4Liy4Lih4LmB4Lii4LiB4LiB4Lij4Liw4LiX4Li44LmI4Lih4LmB4Lia4LiZ!5e0!3m2!1sth!2sth!4v1581322118384!5m2!1sth!2sth" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>  
    </div>
  </div>
  
  <hr class="featurette-divider">
  
  <h4>VIEW THE PHOTOS</h4>
  <div class="row featurette" >
    <div class="col-md-12">
      <div id="myBtnContainer" style="float: none; 
                                      display: inline-block; 
                                      font-size: 16px;
                                      font-weight: 400;
                                      line-height: normal;
                                      margin-right: 5px;
                                      outline: medium none;
                                      padding: 5px 15px;
                                      transition: all 100ms ease-in-out 0s;">
        <button class="btn active" onclick="filterSelection('all')"> ทั้งหมด</button>
        <button class="btn" onclick="filterSelection('fashion')"> เสื้อผ้า/แฟชั่น</button>
        <button class="btn" onclick="filterSelection('food')"> อาหาร/ของกิน</button>
      </div>
    </div>
    <div class="col-md-12">
      <div class="row">
        <div class="column fashion">
          <div class="content">
            <img class="image" src="upload/BookingBooth (13).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (13).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
                
              </div>
            </div>
          </div>
        </div>
        <div class="column fashion">
          <div class="content">
            <img class="image" src="upload/BookingBooth (12).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (12).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column fashion">
          <div class="content">
            <img class="image" src="upload/BookingBooth (11).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (11).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column fashion">
          <div class="content">
            <img class="image" src="upload/BookingBooth (10).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (10).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column fashion">
          <div class="content">
            <img class="image" src="upload/BookingBooth (9).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (9).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                  </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column fashion">
          <div class="content">
            <img class="image" src="upload/BookingBooth (8).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (8).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column fashion">
          <div class="content">
            <img class="image" src="upload/BookingBooth (7).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (7).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column food">
          <div class="content">
            <img class="image" src="upload/BookingBooth (6).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (6).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column food">
          <div class="content">
            <img class="image" src="upload/BookingBooth (5).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (5).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column food">
          <div class="content">
            <img class="image" src="upload/BookingBooth (4).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (4).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column food">
          <div class="content">
            <img class="image" src="upload/BookingBooth (3).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (3).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column food">
          <div class="content">
            <img class="image" src="upload/BookingBooth (2).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (2).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="column food">
          <div class="content">
            <img class="image" src="upload/BookingBooth (1).jpg" style="width:100%">
            <div class="overlay"></div>
            <div class="icons-holder">
              <div class="icons-holder-inner">
                <div class="styled-icons icon-sm icon-dark icon-circled icon-theme-colored">
                  <a href="upload/BookingBooth (1).jpg">
                    <i class="fas fa-search-plus"></i>
                  </a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
      <!--<div class="col-sm-3" style="margin: 2px;"> 
        <img class="image" src="upload/BookingBooth (1).jpg" style="cursor:pointer;border-radius: 5px;transition: 0.3s;" width="256" height="256" onclick="onClick(this)">
      </div>-->
  </div>
  <br>
  <br>
  
</div>

<script>

jQuery(document).ready(function($){
    showbalance();
    showall();
    showbooking();
});

function showall(){

  $.ajax({
          url: "/booth/dis_all",
          type : 'get',
          cache : false, 
          dataType : 'json',
          success: function(result){
            x = JSON.stringify(result[0].number);
            $("#booth_all").html(x);
  }});

}

function showbalance(){

  $.ajax({
          url: "/booth/dis_balance",
          type : 'get',
          cache : false, 
          dataType : 'json',
          success: function(result){
            x = JSON.stringify(result[0].number);
            $("#booth_balance").html(x);
        
  }});

}
function showbooking(){

  $.ajax({
          url: "/booth/dis_booking",
          type : 'get',
          dataType : 'json',
          cache : false, 
          success: function(result){
            x = JSON.stringify(result[0].number);
            $("#booth_booking").html(x);
  }});

}

  filterSelection("all");
  
  function filterSelection(c) {
    var x, i;
    x = document.getElementsByClassName("column");
    if (c == "all") c = "";
    for (i = 0; i < x.length; i++) {
      w3RemoveClass(x[i], "shows");
      if (x[i].className.indexOf(c) > -1) w3AddClass(x[i], "shows");
    } 
  }

  function w3AddClass(element, name) {
    var i, arr1, arr2;
    arr1 = element.className.split(" ");
    arr2 = name.split(" ");
    for (i = 0; i < arr2.length; i++) {
      if (arr1.indexOf(arr2[i]) == -1) {element.className += " " + arr2[i];}
    }
  }

  function w3RemoveClass(element, name) {
    var i, arr1, arr2;
    arr1 = element.className.split(" ");
    arr2 = name.split(" ");
    for (i = 0; i < arr2.length; i++) {
      while (arr1.indexOf(arr2[i]) > -1) {
        arr1.splice(arr1.indexOf(arr2[i]), 1);     
      }
    }
    element.className = arr1.join(" ");
  }

  // Add active class to the current button (highlight it)
  var btnContainer = document.getElementById("myBtnContainer");
  var btns = btnContainer.getElementsByClassName("btn");
  for (var i = 0; i < btns.length; i++) {
    btns[i].addEventListener("click", function(){
      var current = document.getElementsByClassName("btn active");
      current[0].className = current[0].className.replace(" active", "");
      this.className += " active";
    });
  }
</script>

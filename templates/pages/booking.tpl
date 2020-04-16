<?php $this->layout("layouts/main") ?>
<?php 
        $t = strtotime("next Tuesday");
        $nextT = date("Y-m-d", $t);
        
        $f = strtotime("next Friday");
        $nextF = date("Y-m-d", $f);
        
        $w3f = strtotime("+3 week next Friday");
        $week3F = date("Y-m-d", $w3f);
?>
<style>
    .ui-front {
        z-index: 318;
    }
    .parallax {
      /* The image used */
      background-image: url('upload/งานนำเสนอ1.jpg');

      /* Full height */
      height: 100%; 

      /* Create the parallax scrolling effect */
      background-attachment: fixed;
      background-position: center;
      background-repeat: no-repeat;
      background-size: cover;
    }
</style>
<!--<div class="parallax"></div>-->
<div class="container" style="padding: 30px;">

    <br>
    <h4>ล๊อคร้านค้า</h4>
    <br>
    <p style="text-decoration: underline; color: rgb(0,0,255);">ผังตลาด</p>
    <img src="upload/งานนำเสนอ1.jpg" width="75%" height="30%">
    <hr>
    <button id="btn_booking" onclick="return modal_create_open()" class="btn-primary btn-md" style="width: 100px; margin-bottom: 15px;">จอง</button>
    <div id="gridbooth"></div><br>

    <div class="modal" id="modal_create" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
            <h4 class="modal-title">this title</h4>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="disiblebutton()">
              <span aria-hidden="true" class="fas fa-window-close"></span>
	        </button>
	        
	      </div>
	    <div class="modal-body">
            <form id="form_create" onsubmit="return submit_create_repair()">
                <div class="form-group">
                    <label for="lab_bookingid" id="lab_bookingid">รหัสการจอง</label>
                    <input type="text" name="bookingid" id="bookingid" class="form-control" autocomplete="off">
                </div>
		        <div class="form-group">    
		        	<label for="lab_memberid" id="lab_memberid">รหัสการสมาชิก</label>
		            <input type="text" name="memberid" id="memberid" class="form-control" autocomplete="off">
		        </div>
		        <div class="form-group">
		            <label for="lab_boothid" id="lab_boothid">รหัสล๊อค</label>
		            <input type="text" name="boothid" id="boothid" class="form-control" autocomplete="off" >
		        </div>
                <div class="form-group">
                    <label for="lab_pice" id="lab_price">ประเภทการจอง (ราคาที่ระบุ / วัน)</label>
                    <br><label for="lab_pice" id="lab_price"><font size="2">  1.ประจำ ขายวันอังคารและวันศุกร์ เป็นเวลา 4 สัปดาห์</font></label>
                    <br><label for="lab_pice" id="lab_price"><font size="2">  2.ชั่วคราว ขายวันอังคารและวันศุกร์ เป็นเวลา 1 สัปดาห์</font></label>
                    <div id="priceid" type="checked" name="priceid"></div>
                </div>
		        <div class="form-group">
		            <label for="lab_bookingdate" id="lab_bookingdate">วันที่จอง</label>
		            <input type="date" name="bookingdate" id="bookingdate" class="form-control" autocomplete="off" >
                </div>
                <div class="form-group">
		            <label for="lab_saledate" id="lab_saledate">วันที่เริ่มขาย</label>
		            <input type="date" name="saledate" id="saledate" class="form-control" autocomplete="off" >
                </div>
                <div class="form-group">
		            <label for="lab_bookeddate" id="lab_bookeddate">วันที่สิ้นสุด</label>
		            <input type="date" name="bookeddate" id="bookeddate" class="form-control" autocomplete="off" >
                </div>

                <input type="hidden" name="createBy">
                <input type="hidden" name="updateBy">

                <button class="btn-primary" id="Save"><i class="glyphicon glyphicon-floppy-save"></i>&nbsp;ยืนยันการจอง</button>
	        </form>
	      </div>
	    </div>
	  </div>
    </div>
    <div id="dialog" title="Delete"><label for="Delete">คุณต้องการลบที่จะมัน?</label></div>
</div>

<script type="text/javascript">
    $('#dialog').hide();
    var date = new Date();
    var dd = date.getDate();
    var mm = date.getMonth() + 1;
    var yyyy = date.getFullYear();
    if(dd < 10){
        dd = '0'+dd; 
    }
    if(mm < 10){
        mm = '0'+mm;
    }
    var nowDate = yyyy+'-'+mm+'-'+dd;
    var now2Date = mm+'/'+dd+'/'+yyyy;
    jQuery(document).ready(function($){
        gridbooth();
        disiblebutton();
        document.getElementById("Save").disabled = true;
    });
    
    var session_userid = '<?php echo $_SESSION["userid"]; ?>';
    var sale_date = '<?php echo $nextT; ?>';
    var end_date2 = '<?php echo $nextF; ?>';
    var end_date1 = '<?php echo $week3F ?>';
    function bookingDate(inputDate, addDay){
        var d = new Date(inputDate);
        d.setDate(d.getDate()+addDay);
        mkMonth=d.getMonth()+1;
        mkMonth=new String(mkMonth);
        if(mkMonth.length==1){
            mkMonth="0"+mkMonth;
        }
        mkDay=d.getDate();
        mkDay=new String(mkDay);
        if(mkDay.length==1){
            mkDay="0"+mkDay;
        }   
        mkYear=d.getFullYear();
        return mkYear+"-"+mkMonth+"-"+mkDay;
    }

    function disiblebutton(){
        document.getElementById("Save").disabled = true;
    }

    $('#gridbooth').on('rowclick', function (event){
        var args = event.args;
        var boundIndex = args.rowindex;
        var datarow = $("#gridbooth").jqxGrid('getrowdata', boundIndex);

        if(datarow.STATUS_BOOKING == 1){
            document.getElementById("btn_booking").disabled = true;
        }
        else{
            document.getElementById("btn_booking").disabled = false;
        }
    });


    function modal_create_open() {
        var rowdata = row_selected("#gridbooth");
        if (typeof rowdata !== 'undefined') {
            $('#form_create').trigger('reset');
            $('#modal_create').modal({backdrop: 'static'});
            $('.modal-title').text('รายการจอง');
            $('#lab_bookingid').hide();
            $('input[name=bookingid]').hide();
            $('input[name=memberid]').val(session_userid);
            $('input[name=memberid]').prop('readonly', true);
            $('input[name=boothid]').val(rowdata.ID);
            $('input[name=boothid]').prop('readonly', true);
            $('#lab_bookingdate').hide();
            $('input[name=bookingdate]').hide();
            $('#lab_bookeddate').hide();
            $('input[name=bookeddate]').hide();
            $('#lab_saledate').hide();
            $('input[name=saledate]').hide();
        }

        $("#priceid").jqxListBox({width: 466, height: 52});   
        getPrice()
        .done(function(data) {
            $('#priceid').jqxListBox('refresh');
            $.each(data, function(index, val) {
                var NAME;
                if(val.NAME == "Regular"){
                    NAME = "ตั้งประจำ";
                }else{
                    NAME = "ตั้งชั่วคราว";
                }

                $("#priceid").jqxListBox('addItem',{
                    label: NAME +"  "+ val.PRICE,
                    value: val.ID,
                });           
            }); 
         });

        $("#priceid").on('select', function (event) {
            document.getElementById("Save").disabled = false;
            if (event.args) {
                var item = event.args.item;
                if (item) {
                    if(item.value == 1){
                        $('#lab_bookingdate').show();
                        $('input[name=bookingdate]').show();
                        $('#lab_bookeddate').show();
                        $('input[name=bookeddate]').show();
                        $('#lab_saledate').show();
                        $('input[name=saledate]').show();
                        $('input[name=saledate]').val(sale_date);
                        $('input[name=saledate]').prop('readonly', true);
                        $('input[name=bookingdate]').val(nowDate);
                        $('input[name=bookingdate]').prop('readonly', true);
                        $('input[name=bookeddate]').val(end_date1);
                        $('input[name=bookeddate]').prop('readonly', true);
                    }
                    if(item.value == 2){
                        $('#lab_bookingdate').show();
                        $('input[name=bookingdate]').show();
                        $('#lab_saledate').show();
                        $('input[name=saledate]').show();
                        $('#lab_bookeddate').show();
                        $('input[name=bookeddate]').show();
                        $('input[name=saledate]').val(sale_date);
                        $('input[name=saledate]').prop('readonly', true);
                        $('input[name=bookingdate]').val(nowDate);
                        $('input[name=bookingdate]').prop('readonly', true);
                        $('input[name=bookeddate]').val(end_date2);
                        $('input[name=bookeddate]').prop('readonly', true);
                    }
                }
            }
        });
  	}

    function submit_create_repair() {
        $.ajax({
            url : '/api/v1/booking/create',
            type : 'post',
            cache : false,
            dataType : 'json',
            data : $('form#form_create').serialize()
            })
            .done(function(data) {
            if (data.status != 201) {
                gotify(data.message,"danger");
                $('#gridbooth').jqxGrid('updatebounddata');
                document.getElementById("Save").disabled = true;
            }else{
                gotify(data.message,"success");
                $('#gridbooth').jqxGrid('updatebounddata');
                document.getElementById("btn_booking").disabled = true;
                document.getElementById("Save").disabled = true;
                $('#modal_create').modal('hide');
            }
            });
        return false;
    }

    function gridbooth(){
        var dataAdapter = new $.jqx.dataAdapter({
            datatype: "json",
            datafields: [
                { 
                    name: "ID",
                    type: "string" 
                },
                { 
                    name: "DETAIL",
                    type: "string" 
                },
                { 
                    name: "STATUS_BOOKING",
                    type: "int" 
                }
            ],
                url : '/api/v1/booth/load'
        });

        return $("#gridbooth").jqxGrid({
            width: '100%',
            source: dataAdapter,
            autoheight: true,
            columnsresize: true,
            pageable: true,
            filterable: true,
            showfilterrow: true,
            theme : 'themeorange2',
            columns: [
                { 
                    text:"รหัสล๊อค", 
                    datafield: "ID",
                    width:"10%"
                },
                { 
                    text:"รายละเอียด", 
                    datafield: "DETAIL"
                },
	          	{ 
	          		text: 'สถานะการจอง',
	          		datafield: 'STATUS_BOOKING', 
	          		width:"10%", 
	          		filterable: false,
	                cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
	                    var status;
	                       if (value == 0) {
	                           status =  "<div style='padding: 5px; background:#00BB00 ; color:#ffffff;'>ยังไม่มีการจอง</div>";
	                       }else if(value == 1){
	                           status =  "<div style='padding: 5px; background:#EE0000 ; color:#ffffff;'>มีการจอง</div>";
	                       }                    
	                       return status;
	                }
	            }
            ]
        });
    }

    function getPrice(){
          	return $.ajax({
	        url : '/api/v1/booth/price',
	        type : 'get',
	        dataType : 'json',
            datafields: [
                        { name: 'ID' },
                        { name: 'NAME' }
            ],
	        cache : false
      	});
   	} 

</script>
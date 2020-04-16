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

    <p style="text-decoration: underline; color: rgb(0,0,255);">ผังตลาด</p>
    <img src="upload/งานนำเสนอ1.jpg" width="75%" height="30%">
    <hr>
    <h4>รายการจองของคุณ</h4>
    <div id="gridbooking" style="margin-bottom: 12px;"></div>

    <button id="btn_delete" class="btn-danger btn-md">ยกเลิก</button>

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
                    <label for="lab_pice" id="lab_price">ยอดจ่ายทั้งหมด</label>
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
        gridbooking();
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

    $('#gridbooking').on('rowclick', function (event){
        var args = event.args;
        var boundIndex = args.rowindex;
        var datarow = $("#gridbooking").jqxGrid('getrowdata', boundIndex);

        if(datarow.STATUS_CANCEL == 1){
            document.getElementById("btn_delete").disabled = true;
        }
        else{
            document.getElementById("btn_delete").disabled = false;
        }
    });

  	$('#btn_delete').on('click', function(e) {
      var rowdata = row_selected("#gridbooking");
    	if (typeof rowdata !== 'undefined') {
    		$("#dialog").dialog({
      		buttons : {
        		"OK" : function() {

        		gojax('post', '/api/v1/booking/delete', {id:rowdata.BOOKINGID})

			    	.done(function(data) {
			    		if (data.status == 200)
						{
							gotify(data.message,"success");
			    			//$('#dialog').dialog("close");
			          		//$('#gridbooking').jqxGrid('updatebounddata');
						} else {
						    gotify(data.message,"danger");
						}
                    });
                    $('#dialog').dialog("close");
                    $('#gridbooking').jqxGrid('updatebounddata');
                    document.getElementById("btn_booking").disabled = false;
    	 		return false;

        	},
        		"Cancel" : function() {
          			$(this).dialog("close");
        	}
      	}
    	});

      	}else{//tan_edit_180625
					alert("กรุณาเลือกรายการ");
				}
  	});

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
                $('#gridbooking').jqxGrid('updatebounddata');
                document.getElementById("Save").disabled = true;
            }else{
                gotify(data.message,"success");
                $('#gridbooking').jqxGrid('updatebounddata');
                document.getElementById("btn_booking").disabled = true;
                document.getElementById("Save").disabled = true;
                $('#modal_create').modal('hide');
            }
            });
        return false;
    }

    function gridbooking() {

        var dataAdapter = new $.jqx.dataAdapter({
        dataType: "json",
        dataFields: [
            { name: "RowNumber", type: "int"},
            { name: "BOOKINGID", type: "string"},
            { name: "BOOKINGDATE", type: "date", cellsformat: "dd-MM-yyyy"},
            { name: "SALEDATE", type: "date", cellsformat: "dd-MM-yyyy"},
            { name: "BOOKEDDATE", type: "date", cellsformat: "dd-MM-yyyy"},
            { name: "BOOTHID", type: "string"},
            { name: "DETAIL", type: "string"},
            { name: "PRICE", type: "float"},
            { name: "STATUS_APPROVED", type: "int"},
            { name: "STATUS_OVER", type: "int"},
            { name: "STATUS_CANCEL", type: "int"}
        ],
            url : '/api/v1/booking/list',
            sortcolumn: 'RowNumber',
            sortdirection: 'asc',
        });
        return $("#gridbooking").jqxGrid({
            width: '100%',
            source: dataAdapter,
            showstatusbar: true,
            statusbarheight: 25,
            autoheight: true,
            pageable: true,
            altrows: true,
            showaggregates: true,
            width: '100%',
            // filterable: true,
            // showfilterrow: true,
            theme : 'Office',
            columns: [
            { text:"อันดับ", datafield: "RowNumber"},
            { text:"รหัสการจอง", datafield: "BOOKINGID", hidden:true },
            { text:"วันที่จอง", datafield: "BOOKINGDATE", cellsformat: "dd-MM-yyyy"},
            { text:"วันที่ขาย", datafield: "SALEDATE", cellsformat: "dd-MM-yyyy"},
            { text:"วันที่สิ้นสุด", datafield: "BOOKEDDATE", cellsformat: "dd-MM-yyyy"},
            { text:"รหัสล๊อค", datafield: "BOOTHID"},
            { text:"รายละเอียด", datafield: "DETAIL"},
            { text:"ราคา", datafield: "PRICE", cellsformat: "d2", aggregates: ['sum'], width:"13%"},
            { 
                text: 'สถานะการอนุมัติ',
                datafield: 'STATUS_APPROVED', 
                width:"15%", 
                filterable: false,
                cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
                    var status;
                        if (value ==1) {
                            status =  "<div style='padding: 5px; background:#00BB00 ; color:#ffffff;'>อนุมัติ</div>";
                        }else{
                            status =  "<div style='padding: 5px; background:#EE0000 ; color:#ffffff;'>ไม่อนุมัติ</div>";
                        }                    
                        return status;
                }
            },
            { 
                text: 'สถานะการจอง',
                datafield: 'STATUS_OVER', 
                width:"15%", 
                filterable: false,
                cellsrenderer: function (index, datafield, value, defaultvalue, column, rowdata){
                    var status;
                        if (value ==0) {
                            status =  "<div style='padding: 5px; background:#00BB00 ; color:#ffffff;'>ยังอยู่ในช่วงของการจอง</div>";
                        }else{
                            status =  "<div style='padding: 5px; background:#EE0000 ; color:#ffffff;'>เลยเวลาที่ทำการจองไว้</div>";
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
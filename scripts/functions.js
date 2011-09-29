$(function(){
    var i = 0;
    var ledArray=new Array();
    $("#slider").slider({
        range: "max",
        min: 0,
	max: 7,
        slide: function( event, ui ) {
            //$( "#amount" ).val( ui.value );
            console.log(ui.value);
            curLoc = ui.value;
                for(ledPin=0;ledPin<7;ledPin++){
                    if(ledPin<curLoc){
                        ledArray[ledPin] = 1;
                    } else ledArray[ledPin] = 0;
                    console.log(ledArray[ledPin]);
                    $.ajax({
                    type: "POST",
                    url: "scripts/ajaxFunctions.php",
                    data: "state="+ledArray[ledPin]+"&pin="+ledPin,
                    success: function(msg){
                        console.log(msg);
                    }
                });
            }
        }
    });
    $('.toggleLED').click(function(){
        if($(this).attr('name')=='1'){
            $(this).attr('name', 0);
            $(this).attr('value', "Turn LED On");
        } else {
            $(this).attr('name', 1);
            $(this).attr('value', "Turn LED Off");
        };
        $.ajax({//Make the Ajax Request
                type: "POST",
                url: "scripts/ajaxFunctions.php",
                data: "state="+$(this).attr('name')+"&pin="+$(this).attr('id'),
                success: function(msg){
                   console.log(msg);
                }
            });
    });
});
$(function(){
    var i = 0;
    var ledArray=new Array();
    var lastLedArray = new Array();
    $("#slider").slider({
        range: "max",
        min: 0,
	max: 7,
        slide: function( event, ui ) {
            curLoc = ui.value;
                for(ledPin=0;ledPin<7;ledPin++){
                    if(ledPin<curLoc){
                        ledArray[ledPin] = 1;
                    } else ledArray[ledPin] = 0;
                }

                if(lastLedArray.length > 0){ 
                    for(i=0;i<7;i++){
                        if(lastLedArray[i] != ledArray[i]){
                        console.log(i+"="+ledArray[i]);
                            $.ajax({
                                type: "GET",
                                url: "http://192.168.1.202",
                                data: "11=1",
                                dataType: "jsonp",
                                success: function(msg){
                                    console.log("here");
                                }
                            });
                        lastLedArray[i]=ledArray[i];
                        }
                    }
                }
                else{
                    for(i=0;i<7;i++){
                        lastLedArray[i]=ledArray[i];
                        
                    }
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
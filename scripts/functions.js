$(function(){
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
<?php
require_once "scripts/functions.php";
require_once "scripts/php_serial.class.php";
header('Access-Control-Allow-Origin: *');
$stream = 0;
?>
<html>
    <head>
        <link rel="stylesheet" href="css/styles.css" />
        <link rel="stylesheet" href="css/ui-lightness/jquery-ui-1.8.16.custom.css" />
        <script type="text/javascript" src="js/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui-1.8.16.custom.min.js"></script>
        <script type="text/javascript" src="scripts/functions.js"></script>
        
    </head>
    <body>
        <input type="button" id="8" class="toggleLED" value="Turn LED On" name="0" />
        <input type="button" id="9" class="toggleLED" value="Turn LED On" name="0" />
        <div class="sliderParent">
            <div id="slider"></div>
        </div>
        <?PHP
        if($stream == 1)
            echo '<iframe width="560" height="340" src="http://cdn.livestream.com/embed/arduionolgy?layout=4&amp;height=340&amp;width=560&amp;autoplay=false" style="border:0;outline:0" frameborder="0" scrolling="no"></iframe><div style="font-size: 11px;padding-top:10px;text-align:center;width:560px">Watch <a href="http://www.livestream.com/?utm_source=lsplayer&amp;utm_medium=embed&amp;utm_campaign=footerlinks" title="live streaming video">live streaming video</a> from <a href="http://www.livestream.com/arduionolgy?utm_source=lsplayer&amp;utm_medium=embed&amp;utm_campaign=footerlinks" title="Watch arduionolgy at livestream.com">arduionolgy</a> at livestream.com</div>';
        ?>
        <form name="input" action="http://192.168.1.202" method="post">
            Username: <input type="text" name="11" />
            <input type="submit" value="Submit" />
        </form>
    </body>
</html>
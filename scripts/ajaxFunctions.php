<?php
require_once "functions.php";
$arduinoInterface = new arduinoInterface();
$arduinoInterface->toggleLED($_POST["state"],$_POST["pin"]);
?>
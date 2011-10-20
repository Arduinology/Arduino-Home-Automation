<?php
error_reporting(-1);
print_r($_POST);
$ch = curl_init("http://192.168.1.202/");
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, "$_POST[pin]=$_POST[value]");
$data2 = curl_exec($ch);
$curl_errno = curl_errno($ch);
$curl_error = curl_error($ch);
curl_close($ch);
/*if ($curl_errno > 0) {
        echo "cURL Error ($curl_errno): $curl_error\n";
} else {
        echo "Data received: $data2\n";
}*/
?>
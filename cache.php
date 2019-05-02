<?php
    $time=time();
    $interval=60;
    header('Last-Modified: '.gmdate('r',$time));
    header('Expires: '.gmdate('r',($time+$interval)));
    header('Cache-Control: max-age='.$interval);
    header('Content-type: text/json');

    $arr = array('a'=>1,'b'=>2);
    echo json_encode($arr);
?>

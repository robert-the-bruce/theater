<?php
/**
 * Created by PhpStorm.
 * User: rsalc
 * Date: 17.01.2019
 * Time: 18:35
 */

//echo $e->getMessage() . '<br>';

switch ($e->getCode()){

    case 23000:
        echo 'Datensatz ist schon vorhanden! <br>';
        break;

}

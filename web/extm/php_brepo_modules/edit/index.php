<?php
use function Hestiacp\quoteshellarg\quoteshellarg;

$TAB = "EXTMODULES";

// Main include
include $_SERVER["DOCUMENT_ROOT"] . "/inc/main.php";

// Check user
if ($_SESSION["userContext"] != "admin") {
	header("Location: /list/user");
	exit();
}

exec(HESTIA_CMD . "v-ext-modules state php_brepo_modules json", $output, $return_var);
$check_passenger_enabled = json_decode(implode("", $output), true);
if (($return_var != 0) || (empty($check_passenger_enabled)) || ($check_passenger_enabled[0]["STATE"] != "enabled")){
	header("Location: /list/extmodules/");
	exit();
}
unset($output);

$error_message = "";
if ((!empty($_GET["ver"])) && ($_GET["ver"] != "")) {
    $php_vers = $_GET["ver"];
    $ver_quoted = quoteshellarg($_GET["ver"]);
    exec(HESTIA_CMD . "v-ext-modules-run php_brepo_modules php_modules " . $ver_quoted . " json", $output, $return_var);
    $phps_modules = [];
    if ($return_var == 0) {
        $phps_modules = json_decode(implode("", $output), true);
    } else {
        $error_message = $output;
    }
    unset($output);
	if (!empty($_POST["save"]) && $error_message == ""){
        $new_modules = $_POST["v_php_module_name"];
        $chg = false;
        foreach ($new_modules as $key => $value){
            if (!preg_match("/(\d\d)-.+/i", $value)){
                $mod_name = quoteshellarg($value);
                $chg = true;
                exec(HESTIA_CMD . "v-ext-modules-run php_brepo_modules php_enable " . $ver_quoted . " " . $mod_name, $output, $return_var);
                unset($output);
            }
        }
        foreach ($phps_modules as $key => $value){
            if ($value["STATE"]!="disabled"){
                $fnd = false;
                foreach ($new_modules as $ikey => $ivalue){
                    if ($ivalue==$value["STATE"]){
                        $fnd = true;
                        break;
                    }
                }
                if (!$fnd){
                    $chg = true;
                    $mod_name = quoteshellarg($phps_modules[$key]["MODNAME"]);
                    exec(HESTIA_CMD . "v-ext-modules-run php_brepo_modules php_disable " . $ver_quoted . " " . $mod_name, $output, $return_var);
                    unset($output);
                }                          
            }
        }      
        exec(HESTIA_CMD . "v-ext-modules-run php_brepo_modules php_modules " . $ver_quoted . " json", $output, $return_var);
        $phps_modules = [];
        if ($return_var == 0) {
            $phps_modules = json_decode(implode("", $output), true);
        } else {
            $error_message = $output;
        }
        unset($output);
        if ($chg){
            exec(HESTIA_CMD . "v-restart-web-backend", $output, $return_var);
        }
    } 

    // Render page
    render_page($user, $TAB, "extmodules/extmodules_php_brepo_modules_list");
} else {
    // Data
    exec(HESTIA_CMD . "v-ext-modules-run php_brepo_modules php_list json", $output, $return_var);
    $phps = [];
    if ($return_var == 0) {
        $phps = json_decode(implode("", $output), true);
        ksort($phps);
    } else {
        $error_message = $output;
    }

    unset($output);

    // Render page
    render_page($user, $TAB, "extmodules/extmodules_php_brepo_modules");
} 

// Back uri
$_SESSION["back"] = $_SERVER["REQUEST_URI"];
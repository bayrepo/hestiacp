<?php
use function Hestiacp\quoteshellarg\quoteshellarg;

ob_start();

session_start();
include $_SERVER["DOCUMENT_ROOT"] . "/inc/main.php";

// Check token
verify_csrf($_GET);

// Check user
if ($_SESSION["userContext"] != "admin") {
	header("Location: /list/user");
	exit();
}

if (!empty($_GET["id"])) {
	$v_name = urldecode($_GET["id"]);
    $v_action = urldecode($_GET["state"]);
    if ($v_action == "enable") {
	    exec(HESTIA_CMD . "v-ext-modules enable " . quoteshellarg($v_name), $output, $return_var);
    } else {
        exec(HESTIA_CMD . "v-ext-modules disable " . quoteshellarg($v_name), $output, $return_var);
    }
}
check_return_code($return_var, $output);
unset($output);

$back = getenv("HTTP_REFERER");
if (!empty($back)) {
	header("Location: " . $back);
	exit();
}

header("Location: /list/extmodules/");
exit();
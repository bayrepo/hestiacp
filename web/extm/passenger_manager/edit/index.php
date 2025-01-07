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

exec(HESTIA_CMD . "v-ext-modules state passenger_manager json", $output, $return_var);
$check_passenger_enabled = json_decode(implode("", $output), true);
if (($return_var != 0) || (empty($check_passenger_enabled)) || ($check_passenger_enabled[0]["STATE"] != "enabled")){
	header("Location: /list/extmodules/");
	exit();
}
unset($output);

$error_message = "";
if ((!empty($_GET["del"])) && ($_GET["del"] != "")) {
	//Delete item
	$path = quoteshellarg($_GET["del"]);
	exec(HESTIA_CMD . "v-ext-modules-run passenger_manager del_ruby " . $path, $output, $return_var);
	if ($return_var != 0){
		$error_message = $output;
	}
	unset($output);
} else if ((!empty($_GET["add"])) && ($_GET["add"] != "")) {
	//Delete item
	$path = quoteshellarg($_GET["add"]);
	exec(HESTIA_CMD . "v-ext-modules-run passenger_manager add_ruby " . $path, $output, $return_var);
	if ($return_var != 0){
		$error_message = $output;
	}
	unset($output);
} 

// Data
exec(HESTIA_CMD . "v-ext-modules-run passenger_manager get_rubys json", $output, $return_var);
$rubys = [];
if ($return_var == 0) {
	$rubys = json_decode(implode("", $output), true);
	ksort($rubys);
} else {
	$error_message = $output;
}

unset($output);

// Render page
render_page($user, $TAB, "extmodules_passenger_manager");

// Back uri
$_SESSION["back"] = $_SERVER["REQUEST_URI"];
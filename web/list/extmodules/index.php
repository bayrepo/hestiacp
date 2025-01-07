<?php
$TAB = "EXTMODULES";

// Main include
include $_SERVER["DOCUMENT_ROOT"] . "/inc/main.php";

// Check user
if ($_SESSION["userContext"] != "admin") {
	header("Location: /list/user");
	exit();
}

// Data
exec(HESTIA_CMD . "v-ext-modules list json", $output, $return_var);
$data = json_decode(implode("", $output), true);
ksort($data);
$error_message = "";
if (!empty($_SESSION["error_msg"])){
	$error_message = $_SESSION["error_msg"];
	$_SESSION["error_msg"] = "";
}

unset($output);

// Render page
render_page($user, $TAB, "extmodules");

// Back uri
$_SESSION["back"] = $_SERVER["REQUEST_URI"];
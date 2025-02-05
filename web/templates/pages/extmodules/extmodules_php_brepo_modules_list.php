<!-- Begin toolbar -->
<div class="toolbar">
	<div class="toolbar-inner">
		<div class="toolbar-buttons">
			<a class="button button-secondary button-back js-button-back" href="/extm/php_brepo_modules/edit/">
				<i class="fas fa-arrow-left icon-blue"></i><?= _("Back") ?>
			</a>
		</div>
        <div class="toolbar-buttons">
			<button type="submit" class="button" form="main-form">
				<i class="fas fa-floppy-disk icon-purple"></i><?= _("Save") ?>
			</button>
		</div>
	</div>
</div>
<!-- End toolbar -->

<div class="container">

	<?php
if (!empty($error_message)) {
?>
	<div class="u-text-center inline-alert inline-alert-danger u-mb20" role="alert">
		<i class="fas fa-circle-exclamation"></i>
		<p><?= $error_message ?></p>
	</div>
<?php
}
?>


	<h1 class="u-text-center u-mt20 u-pr30 u-mb20 u-pl30"><?= _("Available modules list for version PHP") ?> <?= $php_vers ?></h1>

    <form id="main-form" name="v_ruby_path" method="post">
		<input type="hidden" name="save" value="save">
        <div class="units-table js-units-container">
            <div class="units-table-header">
                <div class="units-table-cell u-text-center"><?= _("PHP module name") ?></div>
				<div class="units-table-cell u-text-center"><?= _("Description") ?></div>
            </div>

            <?php
                foreach ($phps_modules as $key => $value) {
            ?>
			<div class="units-table-row js-unit">
                <div class="units-table-cell js-unit">
					<span class="u-hide-desktop"><?= _("PHP module name") ?>:</span>
                    <div class="form-check">
						<input
							class="form-check-input"
							type="checkbox"
							name="v_php_module_name[]"
							id="v_php_module_name[]"
							<?= $phps_modules[$key]["STATE"] != "disabled" ? "checked" : "" ?>
                            <?php
                                if ($phps_modules[$key]["STATE"] != "disabled") {
                                    echo " value=\"" . $phps_modules[$key]["STATE"] . "\"";
                                } else {
                                    echo " value=\"" . $phps_modules[$key]["MODNAME"] ."\"";
                                }
                            ?>
						>
						<label for="v_policy_user_change_theme">
							<?= $phps_modules[$key]["MODNAME"] ?>
						</label>
					</div>
				</div>
				<div class="units-table-cell">
						<span class="u-hide-desktop"><?= _("Description") ?>:</span>
						<?= $phps_modules[$key]["DESCR"] ?>
				</div>
			</div>
            <?php } ?>
        </div>
    </form>

</div>

<footer class="app-footer">
	<div class="container app-footer-inner">
		<p>
			<?= _("PHP modules list") ?>
		</p>
	</div>
</footer>

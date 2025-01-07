<!-- Begin toolbar -->
<div class="toolbar">
	<div class="toolbar-inner">
		<div class="toolbar-buttons">
			<a class="button button-secondary button-back js-button-back" href="/list/extmodules/">
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
if (is_array($error_message)) {
?>
	<div class="u-text-center inline-alert inline-alert-danger u-mb20" role="alert">
		<i class="fas fa-circle-exclamation"></i>
		<p><?= $error_message[0] ?></p>
	</div>
<?php
}
?>

	<h2 class="u-text-center u-mt20 u-pr30 u-mb20 u-pl30"><?= _("Passenger manager") ?></h2>

	<form id="main-form" name="v_ruby_path" method="get">
		<div>
			<!-- Basic options section -->
			<details class="collapse u-mb10">
				<summary class="collapse-header">
					<i class="fas fa-folder-open u-mr10"></i><?= _("Add new ruby path") ?>
				</summary>
				<div class="collapse-content">
					<div class="u-mb10">
						<label for="v_path" class="form-label">
							<?= _("Path") ?>
						</label>
						<input type="text" class="form-control"	name="add" id="v_path" value="">
					</div>
				</div>
			</details>
		</div>
	</form>
	<p>Ruby list</p>

<?php
foreach ($rubys as $key => $value) {
?>	
	<div class="u-text-center card-content">
		<?= $value["RUBY"] ?> <a class="data-controls js-confirm-action"
			href="/extm/passenger_manager/edit/?del=<?= urlencode($value["RUBY"]) ?>"
			title="<?= $value["RUBY"] ?>"
			data-confirm-title="<?= _("Are you sure you want to delete item?") ?>"
			data-confirm-message="<?= $value["RUBY"] ?>"><i class="fas fa-trash-can icon-red"></i></a>
	</div>
<?php
}
?>
</div>

<footer class="app-footer">
	<div class="container app-footer-inner">
		<p>
			<?= _("Ruby available list") ?>
		</p>
	</div>
</footer>

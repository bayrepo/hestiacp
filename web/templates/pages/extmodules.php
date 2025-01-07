<!-- Begin toolbar -->
<div class="toolbar">
	<div class="toolbar-inner">
		<div class="toolbar-buttons">
			<a class="button button-secondary button-back js-button-back" href="/list/server/">
				<i class="fas fa-arrow-left icon-blue"></i><?= _("Back") ?>
			</a>
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


	<h1 class="u-text-center u-hide-desktop u-mt20 u-pr30 u-mb20 u-pl30"><?= _("List modules") ?></h1>

	<div class="units-table js-units-container">
		<div class="units-table-header">
			<div class="units-table-cell"><?= _("Module ID") ?></div>
			<div class="units-table-cell"><?= _("Module name") ?></div>
			<div class="units-table-cell"></div>
			<div class="units-table-cell u-text-center"><?= _("Module description") ?></div>
			<div class="units-table-cell u-text-center"><?= _("Module state") ?></div>
			<div class="units-table-cell u-text-center"><?= _("Requirements") ?></div>
			<div class="units-table-cell u-text-center"><?= _("Configuration") ?></div>
		</div>

		<!-- Begin extmodules list item loop -->
		<?php
			foreach ($data as $key => $value) {
				++$i;
				if ($data[$key]['STATE'] == 'disabled') {
					$status = 'disabled';
					$module_action = 'enable';
					$module_action_title = _('Enable module');
					$module_icon = 'fa-play';
					$module_icon_class = 'icon-green';
					$module_confirmation = _('Are you sure you want to enable module %s?') ;
				} else {
					$status = 'enabled';
					$module_action = 'disable';
					$module_action_title = _('Disable module');
					$module_icon = 'fa-stop';
					$module_icon_class = 'icon-red';
					$module_confirmation = _('Are you sure you want to disable module %s?') ;
				}
			?>
			<div class="units-table-row <?php if ($status == 'disabled') echo 'disabled'; ?> js-unit">
				<div class="units-table-cell u-text-bold">
					<span class="u-hide-desktop"><?= _("Module ID") ?>:</span>
					<?= $data[$key]["ID"] ?>
				</div>
				<div class="units-table-cell units-table-heading-cell u-text-bold">
					<span class="u-hide-desktop"><?= _("Module name") ?>:</span>
						<?php
							$iconClass = $status == "disabled" ? "fa-circle-minus" : "fa-circle-check";
							$colorClass = $status == "disabled" ? "icon-red" : "icon-green";
						?>
						<i class="fas <?= $iconClass ?> u-mr5 <?= $status ? $colorClass : "" ?>"></i> <?= $data[$key]["NAME"] ?>
				</div>
				<div class="units-table-cell">
					<ul class="units-table-row-actions">
						<li class="units-table-row-action shortcut-s" data-key-action="js">
							<a
								class="units-table-row-action-link data-controls js-confirm-action"
								href="/edit/extmodules/?id=<?= urlencode($data[$key]['NAME']) ?>&state=<?= $module_action ?>&token=<?= $_SESSION["token"] ?>"
								title="<?= $module_action_title ?>"
								data-confirm-title="<?= $module_action_title ?>"
								data-confirm-message="<?= sprintf($module_confirmation, $data[$key]['NAME']) ?>"
							>
								<i class="fas <?= $module_icon ?> <?= $module_icon_class ?>"></i>
								<span class="u-hide-desktop"><?= $module_action_title ?></span>
							</a>
						</li>
					</ul>
				</div>
				<div class="units-table-cell">
					<span class="u-hide-desktop"><?= _("Module description") ?>:</span>
					<?= $data[$key]["DESCR"] ?>
				</div>
				<div class="units-table-cell u-text-center-desktop">
					<span class="u-hide-desktop u-text-bold"><?= _("Module state") ?>:</span>
					<?= $data[$key]["STATE"] ?>
				</div>
				<div class="units-table-cell u-text-center-desktop">
					<span class="u-hide-desktop"><?= _("Requirements") ?>:</span>
					<?= $data[$key]["REQ"] ?>
				</div>
				<div class="units-table-cell u-text-center-desktop">
					<span class="u-hide-desktop"><?= _("Configuration") ?>:</span>
					<?php 
						if (($data[$key]["CONF"]=="yes") && ($status == "enabled")) { 
					?>
					<a href="/extm/<?= urlencode($data[$key]['NAME']) ?>/edit/" title="<?= $data[$key]['NAME'] ?>">
						<?= _("Edit") ?>
					</a>
					<?php
						} else {
					?>
					&nbsp;
					<?php
						}
					?>
				</div>
			</div>
		<?php } ?>
	</div>

</div>

<footer class="app-footer">
	<div class="container app-footer-inner">
		<p>
			<?= _("Extended modules list") ?>
		</p>
	</div>
</footer>

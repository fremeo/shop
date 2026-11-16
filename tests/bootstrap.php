<?php
foreach ([__DIR__ . '/../vendor/autoload.php', __DIR__ . '/../../../autoload.php'] as $autoload) {
	if (is_file($autoload)) {
		require $autoload;
		return;
	}
}
exit("Kein Composer-Autoloader gefunden.\n");

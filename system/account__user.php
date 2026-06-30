<?php
$F['ACCOUNT']['W'][0]['ID'] = $D['SESSION']['AccountId'];
$F['ACCOUNT'] = [];
$F['USER']['ACCOUNT'] = null;
$F['USER']['W'][0]['ACCOUNT']['W'][0]['ID'] = $D['SESSION']['AccountId'];

$C['fremeo/shop']['CData']->get_object($D,$F);
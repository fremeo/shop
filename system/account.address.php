<?php
if($D['Action'] == 'save') {
	$d['ACCOUNT']['D'][$D['SESSION']['ACCOUNT']['AccountId']] = $D['ACCOUNT']['D'][$D['SESSION']['ACCOUNT']['AccountId']];
	$CData->set_object($d);
}


$F['ACCOUNT']['W'][0]['ID'] = $D['SESSION']['ACCOUNT']['AccountId'];
$F['ACCOUNT']['ADDRESS']['ARTICLE'] = [];
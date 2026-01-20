<?php
if(($D['Action']??null) == 'save') {
	$d['ACCOUNT']['D'][$D['SESSION']['AccountId']] = $D['ACCOUNT']['D'][$D['SESSION']['AccountId']];
	$CData->set_object($d);
}


$F['ACCOUNT']['W'][0]['ID'] = ($D['SESSION']['AccountId']??null);
$F['ACCOUNT']['ADDRESS']['ARTICLE'] = [];
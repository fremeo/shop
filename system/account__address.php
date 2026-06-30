<?php
if(isset($D['ACCOUNT']['D'][$D['SESSION']['AccountId']]) && ($D['Action']??null) == 'save') {

	$d['ACCOUNT']['D'][$D['SESSION']['AccountId']] = $D['ACCOUNT']['D'][$D['SESSION']['AccountId']];
	
	$C['fremeo/shop']['CData']->set_object($d);
	unset($D['ACCOUNT']['D'][$D['SESSION']['AccountId']]['ADDRESS']);
}


$F['ACCOUNT']['W'][0]['ID'] = ($D['SESSION']['AccountId']??null);
$F['ACCOUNT']['ADDRESS'] = [];

$C['fremeo/shop']['CData']->get_object($D,$F);
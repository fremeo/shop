<?php
if($D['Action'] == 'login') {
	$F['ACCOUNT']['W'][0]['Active'] = 1;
	$F['ACCOUNT']['W'][0]['CUSTOMER']['W'][0]['Active'] = 1;
	$F['ACCOUNT']['W'][0]['CUSTOMER']['W'][0]['Mail'] = $D['_Login']['Mail'];
	$F['ACCOUNT']['CUSTOMER']['W'][0]['Active'] = 1;
	$F['ACCOUNT']['CUSTOMER']['W'][0]['Mail'] = $D['_Login']['Mail'];
	$CData->get_object($D,$F);

	$_AccId = array_key_first((array)$D['ACCOUNT']['D']);
	if( $D['ACCOUNT']['D'][$_AccId]['Active'] == 1) {
		$_CusId = array_key_first((array)$D['ACCOUNT']['D'][$_AccId]['CUSTOMER']['D']);
		if($D['ACCOUNT']['D'][$_AccId]['CUSTOMER']['D'][$_CusId]['Password'] == $D['_Login']['Password']) {
			#$_SESSION['D']['ACCOUNT'] = $D['ACCOUNT'];
			
			$_SESSION['D']['ACCOUNT'] = [
				'AccountId' => $_AccId,
				'CustomerId' => $_CusId,
			];
			
			header("Location: {$D['BasePath']}account");
		}
		else {
			echo "login falsch";
		}
	}
}
elseif($D['Action'] == 'register') {
	$_newAccId = hash("crc32b", time());
	$_newCusId = hash("crc32b", time());
	
	$d['ACCOUNT']['D'][$_newAccId]['Active'] = 1;
	$d['ACCOUNT']['D'][$_newAccId]['CUSTOMER']['D'][$_newCusId]['Mail'] = $D['_Login']['Mail'];
	$d['ACCOUNT']['D'][$_newAccId]['CUSTOMER']['D'][$_newCusId]['Password'] = $D['_Login']['Password'];

	$d['ACCOUNT']['D'][$_newAccId]['ADDRESS']['D'][$_newCusId] = [
		'Active'		=> 1,
		'Company'		=> $D['_Login']['Company'],
		'FName'			=> $D['_Login']['FName'],
		'LName'			=> $D['_Login']['LName'],
		'Street'		=> $D['_Login']['Street'],
		'HNumber'		=> $D['_Login']['HNumber'],
		'Postcode'		=> $D['_Login']['Postcode'],
		'City'			=> $D['_Login']['City'],
		'CountryId'		=> $D['_Login']['CountryId'],
		'Telephone'		=> $D['_Login']['Telephone'],
	];
	$CData->set_object($d);

	$_SESSION['D']['ACCOUNT'] = [
		'AccountId' => $_newAccId,
		'CustomerId' => $_newCusId,
	];
}
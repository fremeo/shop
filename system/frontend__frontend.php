<?php


switch($R['ACTION']??null) {

	case 'addMemo':
	$C['CData']->set_object($D);
	break;
	case 'addToBasket':

	if(!$_SESSION['OrderId']) {
		$_SESSION['OrderId'] = hash("crc32b", $_SESSION['UserId'].hrtime(true));
	}

	$C['CShop']->updateBasket($R);
	$D['SESSION'] = $_SESSION;

	break;
	case 'goCheckout':
	

	$d = [];
	$d['ACCOUNT']['D'][ $D['SESSION']['AccountId'] ]['ORDER']['D'][ $_SESSION['OrderId'] ] = $D['SESSION']['BASKET']['ORDER']['D'][ $_SESSION['OrderId'] ];
	$d['ACCOUNT']['D'][ $D['SESSION']['AccountId'] ]['ORDER']['D'][ $_SESSION['OrderId'] ]['DateTime'] = date('YmdHis');


#$d['ACCOUNT']['D'][ $D['SESSION']['AccountId'] ]['ORDER']['D'][ $orderId ]['ARTICLE']['D'] = $D['SESSION']['BASKET']['ORDER']['D'][ $_SESSION['OrderId'] ]['ARTICLE'];
	$C['CData']->set_object($d);

	unset($_SESSION['OrderId']);
	unset($_SESSION['BASKET']);
	$_SESSION['OrderId'] = hash("crc32b", $_SESSION['UserId'].hrtime(true));#Neue Warenkorb ID zuweisen

	$D['SESSION'] = $_SESSION;
	break;
}

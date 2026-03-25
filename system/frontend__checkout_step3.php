<?php

if(($D['SESSION']['BASKET']['ORDER']['D'][ $D['SESSION']['OrderId'] ]['ARTICLE']['D']??null)) {
	$F['ARTICLE']['W'][0]['ID'] = array_keys( $D['SESSION']['BASKET']['ORDER']['D'][ $D['SESSION']['OrderId'] ]['ARTICLE']['D']); #Lade Alle Artikel die im Warenkorb liegen
	
	$C['papp~shop']['CData']->get_object($d,$F); 
	$F['ARTICLE']['W'][1]['ID'] = array_keys($d['ARTICLE']['ParentId']['D']); #Vater IDs hollen


	$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
	#$F['ARTICLE']['STOCK'] = [];
	$F['ARTICLE']['CUSTOMERGROUP'] = [];
}
$F['SHIPPING']['LANGUAGE'] = [];
$F['SHIPPING']['PAYMENT'] = [];
$F['SHIPPING']['COUNTRY'] = [];

$F['PAYMENT']['W'][0]['Active'] = 1;
/*$F['PAYMENT']['LANGUAGE'] = [];
*/
#ToDo: Wird vorausgesetzt dass der Benutzer eingellogt ist.
#Lade standard Adresse aus dem Account
##$F['ACCOUNT']['ADDRESS']['W'][0]['Active'] = 1;
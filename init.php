<?php

include_once(__dir__."/system/core/CShop.php");



/*
#Erweiterung der Admin Module um eigene Templates und PHP Dateien	
$D['MODUL']['D'][ 'fremeo/admin' ]['MODUL']['D'][ $D['MY']['Id'] ]['TEMPLATE'] = [
	'tpl_dir' => __DIR__ . '/system/extend/templates/',
	'php_dir' => __DIR__ . '/system/extend/',
];
*/
#$C['fremeo/shop']['CData'] = new \phploader\CData( [ 'DB' => ['FILENAME' => PROJECT_ROOT.'data/fremeo~shop/data.db', 'FILENAME_C' => PROJECT_ROOT.'data_c/fremeo~shop/data.db' ] ] );
if (!isset($C['fremeo/shop']['CData'])) {
    $C->set('CData', new \phploader\CData( [ 'DB' => ['FILENAME' => PROJECT_ROOT.'data/fremeo~shop/data.db', 'FILENAME_C' => PROJECT_ROOT.'data_c/fremeo~shop/data.db' ] ] ), 'fremeo/shop');
}
$C['fremeo/shop']['CData']->registerPattern(
	(static fn (string $file): array => include $file)(__DIR__ . '/system/default/default.pattern.php')
);

$C['CShop'] = new CShop($C['fremeo/shop']['CData']);
/*
$F['ATTRIBUTE_SET']['LANGUAGE'] = [];
$F['ATTRIBUTE_SET']['ATTRIBUTE_GROUP']['LANGUAGE'] = [];
$F['ATTRIBUTE_SET']['ATTRIBUTE_GROUP']['ATTRIBUTE']['PROPERTY']['LANGUAGE'] = [];
$F['ATTRIBUTE']['PROPERTY']['LANGUAGE'] = [];
$F['ATTRIBUTE']['LANGUAGE'] = [];
$F['ARTICLE']['STOCK'] = [];
$F['ARTICLE']['CUSTOMERGROUP']['ATTRIBUTE']['ITEM']['PROPERTY'] = [];
$F['ARTICLE']['ATTRIBUTE']['ITEM']['PROPERTY']['LANGUAGE'] = [];
$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
$F['ACCOUNT']['MEMO']['ARTICLE'] = [];
$F['ACCOUNT']['ORDER']['ARTICLE'] = [];
$F['ACCOUNT']['ORDER']['DELIVERY']['ARTICLE'] = [];

$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
$F['ARTICLE']['STOCK'] = [];
$F['ARTICLE']['CUSTOMERGROUP'] = [];
$C['CData']->get_object($D1,$F); #Achtung: über diese Methode wurden Artikel Texte nicht ausgelesen!

$C['fremeo/shop']['CData']->set_object($D1);

*/
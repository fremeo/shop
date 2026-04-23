<?php

include_once(__dir__."/system/core/CShop.php");



/*
#Erweiterung der Admin Module um eigene Templates und PHP Dateien	
$D['MODUL']['D'][ 'papp/admin' ]['MODUL']['D'][ $D['MY']['Id'] ]['TEMPLATE'] = [
	'tpl_dir' => __DIR__ . '/system/extend/templates/',
	'php_dir' => __DIR__ . '/system/extend/',
];
*/
#DB-----------------
#ATTRIBUTE_SET
$Pattern = [];
$Pattern['ATTRIBUTE_SET'] = [
	'Active'			=> ['Type' => 'checkbox'],
];
$Pattern['ATTRIBUTE_SET']['D']['LANGUAGE'] = [
	'Title'				=> ['Type' => 'text'],
];
$Pattern['ATTRIBUTE_SET']['D']['ATTRIBUTE_GROUP'] = [
	'Active'			=> ['Type' => 'checkbox'],
	'CustomerGroup'		=> ['Type' => 'multiselect'],
];

#ATTRIBUTE_GROUP
$Pattern['ATTRIBUTE_SET']['D']['ATTRIBUTE_GROUP']['D']['LANGUAGE'] = [
	'Title'				=> ['Type' => 'text'],
];

$Pattern['ATTRIBUTE_SET']['D']['ATTRIBUTE_GROUP']['D']['ATTRIBUTE']['D']['PROPERTY'] = [
	'Active'			=> ['Type' => 'checkbox'],
	'Required'			=> ['Type' => 'checkbox'],#Pflicht Attribut für diese Gruppe Markieren!
	'Enum'				=> ['Type' => 'json'],
	'EnumState'			=> ['Type' => 'text', 'Enum' => ['prepend','append','overwrite'] ],
];

$Pattern['ATTRIBUTE_SET']['D']['ATTRIBUTE_GROUP']['D']['ATTRIBUTE']['D']['PROPERTY']['D']['LANGUAGE'] = [
	'Enum'				=> ['Type' => 'json'],
];

$Pattern['ATTRIBUTE']['D']['PROPERTY'] = 
$Pattern['ATTRIBUTE'] = [ #<-- Todo: Pfad veraltet
	'Active'		=> ['Type' => 'checkbox'],
	#'ParentId'		=> ['Type' => 'id', 'ForeignKey' => 1],
	'Sort'			=> ['Type' => 'number'],
	'Type'			=> ['Type' => 'text'], #text, textarea,file,...
	'I18n'			=> ['Type' => 'checkbox'],
	'Enum'			=> ['Type' => 'json'],

];

$Pattern['ATTRIBUTE']['D']['PROPERTY']['D']['LANGUAGE'] = 
$Pattern['ATTRIBUTE']['D']['LANGUAGE'] = [ #<-- Todo: Pfad veraltet
	'Title'			=> ['Type' => 'text'],
	'Description'	=> ['Type' => 'text'],
	'Enum'			=> ['Type' => 'json'],
];



#ARTICLE
$Pattern['ARTICLE'] = [
	'Active'			=> ['Type' => 'checkbox'],
	'ParentId'			=> ['Type' => 'id', 'ForeignKey' => 1],
];

$Pattern['ARTICLE']['D']['STOCK'] = [
	'Active'		=> ['Type' => 'checkbox'],
	'WAREHOUSE'		=> ['Type' => 'id'],
	'Stock'			=> ['Type' => 'number'],
];

$Pattern['ARTICLE']['D']['CUSTOMERGROUP']['D']['ATTRIBUTE']['D']['ITEM']['D']['PROPERTY'] = 
$Pattern['ARTICLE']['D']['CUSTOMERGROUP'] = [ #<-- Todo: Pfad veraltet
	'Active'			=> ['Type' => 'checkbox'],
	'Value'				=> ['Type' => 'text'],
	#'Price'				=> ['Type' => 'number'], #ToDo: Add Sort?
	#'OPrice'			=> ['Type' => 'number'], #Alter Preis
	#'PriceChangeDate'	=> ['Type' => 'date'], #Preis Änderung Zeitraum. Datum wann zuletzt Preis nach oben verändert wurde. Damit beim Reduzieren der Streichpreis ab 30 Tagen angezeigt werden kann.
	#'RRPrice'			=> ['Type' => 'number'], #UVP
];

$Pattern['ARTICLE']['D']['ATTRIBUTE']['D']['ITEM']['D']['PROPERTY'] =
$Pattern['ARTICLE']['D']['ATTRIBUTE'] = [ #<-- Todo: Pfad veraltet
	'Active'		=> ['Type' => 'checkbox'],
	'Value'			=> ['Type' => 'text'],
];

$Pattern['ARTICLE']['D']['ATTRIBUTE']['D']['ITEM']['D']['PROPERTY']['D']['LANGUAGE'] =
$Pattern['ARTICLE']['D']['ATTRIBUTE']['D']['LANGUAGE'] = [ #<-- Todo: Pfad veraltet
	#'ATTRIBUTE'		=> ['Type' => 'id'],
	'Value'			=> ['Type' => 'text'],
];


$Pattern['ACCOUNT']['D']['ADDRESS'] = [
	'Active'		=> ['Type' => 'checkbox'],
	'FName'			=> ['Type' => 'text'],
	'LName'			=> ['Type' => 'text'],
	'Street'		=> ['Type' => 'text'],
	'HNumber'		=> ['Type' => 'text'],
	'Postcode'		=> ['Type' => 'text'],
	'City'			=> ['Type' => 'text'],
	'CountryId'		=> ['Type' => 'id'], #isocode2
	'Phone'			=> ['Type' => 'text'],
	'Mail'			=> ['Type' => 'text'],
];

$Pattern['ACCOUNT']['D']['MEMO'] = [
	'Active'		=> ['Type' => 'checkbox'],
	'Name'			=> ['Type' => 'text'],
];

$Pattern['ACCOUNT']['D']['MEMO']['D']['ARTICLE'] = [
	'Active'		=> ['Type' => 'checkbox'],
	#'Value'			=> ['Type' => 'text'],
];


$Pattern['ACCOUNT']['D']['ORDER'] = [
	'Active'		=> ['Type' => 'checkbox'],
	'CustomerId'	=> ['Type' => 'id'],
	'Number'		=> ['Type' => 'text'],
	'DateTime'		=> ['Type' => 'text'],#Zeitstempel der Bestellung
	'PaymentId'		=> ['Type' => 'id'],
	#'ShippingId'	=> ['Type' => 'id'],
	'FName'			=> ['Type' => 'text'],
	'LName'			=> ['Type' => 'text'],
	'Street'		=> ['Type' => 'text'],
	'HNumber'		=> ['Type' => 'text'],
	'Postcode'		=> ['Type' => 'text'],
	'City'			=> ['Type' => 'text'],
	'CountryId'		=> ['Type' => 'id'], #isocode2
	'Phone'			=> ['Type' => 'text'],
	'Mail'			=> ['Type' => 'text'],

];
$Pattern['ACCOUNT']['D']['ORDER']['D']['ARTICLE'] = [
	'Active'		=> ['Type' => 'checkbox'],
	'Number'		=> ['Type' => 'text'],
	'Title'			=> ['Type' => 'text'],
	'Stock'			=> ['Type' => 'text'],
	'Price'			=> ['Type' => 'text'],
];

$Pattern['ACCOUNT']['D']['ORDER']['D']['DELIVERY'] = [ #Es können mehrere Versandadressen je Bestellung geben oder mehrfach versendet werden, bei teilbestellungen
	'Active'		=> ['Type' => 'checkbox'],
	'FName'			=> ['Type' => 'text'],
	'LName'			=> ['Type' => 'text'],
	'Street'		=> ['Type' => 'text'],
	'HNumber'		=> ['Type' => 'text'],
	'Postcode'		=> ['Type' => 'text'],
	'City'			=> ['Type' => 'text'],
	'CountryId'		=> ['Type' => 'id'], #isocode2
	'Phone'			=> ['Type' => 'text'],
	'Mail'			=> ['Type' => 'text'],
	'ShippingId'	=> ['Type' => 'id'], #z.B: DHL, ...
	'Status'		=> ['Type' => 'text'], #-20 Storno; 0=Offen; 9=Klärung; 20=Versandfreigabe; 40=Fertig
	'ShippedDate'	=> ['Type' => 'text'],
	'TrackingNumber'=> ['Type' => 'text'],
];

$Pattern['ACCOUNT']['D']['ORDER']['D']['DELIVERY']['D']['ARTICLE'] = [ #Versendete Artikel
	'Active'		=> ['Type' => 'checkbox'],
	'Number'		=> ['Type' => 'text'],
	'Title'			=> ['Type' => 'text'],
	'Stock'			=> ['Type' => 'text'],
	'Weight'		=> ['Type' => 'text'],
];

#$C['CData']->registerPattern($Pattern);


$C['papp~shop']['CData'] = new \papp\CData( [ 'DB' => ['FILENAME' => PROJECT_ROOT.'data/papp~shop/data.db', 'FILENAME_C' => PROJECT_ROOT.'data_c/papp~shop/data.db' ] ] );
$C['papp~shop']['CData']->registerPattern($Pattern);

$C['CShop'] = new CShop($C['papp~shop']['CData']);
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

$C['papp~shop']['CData']->set_object($D1);

*/
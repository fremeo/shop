<?php
/*
#Erweiterung der Admin Module um eigene Templates und PHP Dateien	
$D['MODUL']['D'][ 'papp/admin' ]['MODUL']['D'][ $D['MY']['Id'] ]['TEMPLATE'] = [
	'tpl_dir' => __DIR__ . '/system/extend/templates/',
	'php_dir' => __DIR__ . '/system/extend/',
];
*/
#DB-----------------
#ATTRIBUTE_SET
$D['PATTERN']['ATTRIBUTE_SET'] = [
	'Active'			=> ['Type' => 'checkbox'],
];
$D['PATTERN']['ATTRIBUTE_SET']['D']['LANGUAGE'] = [
	'Title'				=> ['Type' => 'text'],
];
$D['PATTERN']['ATTRIBUTE_SET']['D']['ATTRIBUTE_GROUP'] = [
	'Active'			=> ['Type' => 'checkbox'],
	'CustomerGroup'		=> ['Type' => 'multiselect'],
];

#ATTRIBUTE_GROUP
$D['PATTERN']['ATTRIBUTE_SET']['D']['ATTRIBUTE_GROUP']['D']['LANGUAGE'] = [
	'Title'				=> ['Type' => 'text'],
];

$D['PATTERN']['ATTRIBUTE_SET']['D']['ATTRIBUTE_GROUP']['D']['ATTRIBUTE']['D']['PROPERTY'] = [
	'Active'			=> ['Type' => 'checkbox'],
	'Required'			=> ['Type' => 'checkbox'],#Pflicht Attribut für diese Gruppe Markieren!
	'Enum'				=> ['Type' => 'json'],
	'EnumState'			=> ['Type' => 'text', 'Enum' => ['prepend','append','overwrite'] ],
];

$D['PATTERN']['ATTRIBUTE_SET']['D']['ATTRIBUTE_GROUP']['D']['ATTRIBUTE']['D']['PROPERTY']['D']['LANGUAGE'] = [
	'Enum'				=> ['Type' => 'json'],
];

$D['PATTERN']['ATTRIBUTE']['D']['PROPERTY'] = 
$D['PATTERN']['ATTRIBUTE'] = [ #<-- Todo: Pfad veraltet
	'Active'		=> ['Type' => 'checkbox'],
	#'ParentId'		=> ['Type' => 'id', 'ForeignKey' => 1],
	'Sort'			=> ['Type' => 'number'],
	'Type'			=> ['Type' => 'text'], #text, textarea,file,...
	'I18n'			=> ['Type' => 'checkbox'],
	'Enum'			=> ['Type' => 'json'],

];

$D['PATTERN']['ATTRIBUTE']['D']['PROPERTY']['D']['LANGUAGE'] = 
$D['PATTERN']['ATTRIBUTE']['D']['LANGUAGE'] = [ #<-- Todo: Pfad veraltet
	'Title'			=> ['Type' => 'text'],
	'Description'	=> ['Type' => 'text'],
	'Enum'			=> ['Type' => 'json'],
];



#ARTICLE
$D['PATTERN']['ARTICLE'] = [
	'Active'			=> ['Type' => 'checkbox'],
	'ParentId'			=> ['Type' => 'id', 'ForeignKey' => 1],
];

$D['PATTERN']['ARTICLE']['D']['STOCK'] = [
	'Active'		=> ['Type' => 'checkbox'],
	'WAREHOUSE'		=> ['Type' => 'id'],
	'Stock'			=> ['Type' => 'number'],
];

$D['PATTERN']['ARTICLE']['D']['CUSTOMERGROUP']['D']['ATTRIBUTE']['D']['ITEM']['D']['PROPERTY'] = 
$D['PATTERN']['ARTICLE']['D']['CUSTOMERGROUP'] = [ #<-- Todo: Pfad veraltet
	'Active'			=> ['Type' => 'checkbox'],
	'Value'				=> ['Type' => 'text'],
	#'Price'				=> ['Type' => 'number'], #ToDo: Add Sort?
	#'OPrice'			=> ['Type' => 'number'], #Alter Preis
	#'PriceChangeDate'	=> ['Type' => 'date'], #Preis Änderung Zeitraum. Datum wann zuletzt Preis nach oben verändert wurde. Damit beim Reduzieren der Streichpreis ab 30 Tagen angezeigt werden kann.
	#'RRPrice'			=> ['Type' => 'number'], #UVP
];

$D['PATTERN']['ARTICLE']['D']['ATTRIBUTE']['D']['ITEM']['D']['PROPERTY'] =
$D['PATTERN']['ARTICLE']['D']['ATTRIBUTE'] = [ #<-- Todo: Pfad veraltet
	'Active'		=> ['Type' => 'checkbox'],
	'Value'			=> ['Type' => 'text'],
];

$D['PATTERN']['ARTICLE']['D']['ATTRIBUTE']['D']['ITEM']['D']['PROPERTY']['D']['LANGUAGE'] =
$D['PATTERN']['ARTICLE']['D']['ATTRIBUTE']['D']['LANGUAGE'] = [ #<-- Todo: Pfad veraltet
	#'ATTRIBUTE'		=> ['Type' => 'id'],
	'Value'			=> ['Type' => 'text'],
];

/*
$D['PATTERN']['FILE'] = [
	'Name'			=> ['Type' => 'text'],
	'Size'			=> ['Type' => 'number'],
	'Extension'		=> ['Type' => 'text'],
];
*/

$C['CData']->registerPattern($D['PATTERN']);
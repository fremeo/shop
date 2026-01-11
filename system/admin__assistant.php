<?php

if($D['ACTION'] == 'save') {

	#ATT-SET
	$D['ATTRIBUTE_SET']['D']['Default']['LANGUAGE']['D']['DE']['Title'] = "Standard";
	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Identity']['LANGUAGE']['D']['DE']['Title'] = "Artikel Identität";
	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Variation']['LANGUAGE']['D']['DE']['Title'] = "Variationen";
	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Image']['LANGUAGE']['D']['DE']['Title'] = "Bilder";
	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Detail']['LANGUAGE']['D']['DE']['Title'] = "Artikel Details";

	


	#Standard Attribute
	#$D['ATTRIBUTE']['D']['main'] = ['Active' => 1,'Type' => 'text', 'ParentId' => '']; #Parent => Gruppe
	#$D['ATTRIBUTE']['D']['main']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Artikel Haupt Attribute' ];
	
	##$D['ATTRIBUTE']['D']['Sku'] = ['Active' => 1,'Type' => 'text', 'ParentId' => 'main'];
	$D['ATTRIBUTE']['D']['Sku']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Artikelnummer' ];
	
	#Bilder
	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Image']['ATTRIBUTE']['D']['ImageSet']['Active'] = 1;
	$D['ATTRIBUTE']['D']['ImageSet']['LANGUAGE']['D']['DE']['Title'] = 'Image Set';
	$D['ATTRIBUTE']['D']['ImageSet']['MaxUniqueItems'] = 12;
	$D['ATTRIBUTE']['D']['ImageSet']['PROPERTY']['D']['FileId']['LANGUAGE']['D']['DE']['Title'] = 'File Id';

	#$D['ATTRIBUTE']['D']['Image'] = ['Active' => 1,'Type' => 'textarea', 'ParentId' => 'main'];
	#$D['ATTRIBUTE']['D']['Image']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Produktbilder' ];
	
	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Identity']['ATTRIBUTE']['D']['Title']['Active'] = 1;
	$D['ATTRIBUTE']['D']['Title'] = ['Active' => 1,'Type' => 'text','I18n' => '1', 'ParentId' => 'main'];
	$D['ATTRIBUTE']['D']['Title']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Titel' ];
	
	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Identity']['ATTRIBUTE']['D']['Url']['Active'] = 1;
	$D['ATTRIBUTE']['D']['Url'] = ['Active' => 1,'Type' => 'text','I18n' => '1', 'ParentId' => 'main'];
	$D['ATTRIBUTE']['D']['Url']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Seo Url' ];
	
	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Identity']['ATTRIBUTE']['D']['Description']['Active'] = 1;
	$D['ATTRIBUTE']['D']['Description'] = ['Active' => 1,'Type' => 'wysiwyg','I18n' => '1', 'ParentId' => 'main'];
	$D['ATTRIBUTE']['D']['Description']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Beschreibung' ];
	
	$D['ATTRIBUTE']['D']['VarianteGroup'] = ['Active' => 1,'Type' => 'text', 'ParentId' => 'main'];
	$D['ATTRIBUTE']['D']['VarianteGroup']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Varianten Gruppe' ];

	$D['ATTRIBUTE']['D']['Categorie'] = ['Active' => 1,'Type' => 'text', 'ParentId' => 'main'];
	$D['ATTRIBUTE']['D']['Categorie']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Kategorie' ];

	$D['ATTRIBUTE']['D']['RRPrice'] = ['Active' => 1,'Type' => 'text', 'ParentId' => 'main'];
	$D['ATTRIBUTE']['D']['RRPrice']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'UVP' ];
/* #PReisangabe muss $ART.CUSTOMERGROUP.D['0'].Price 
	$D['ATTRIBUTE']['D']['Price'] = ['Active' => 1,'Type' => 'text', 'ParentId' => 'main'];
	$D['ATTRIBUTE']['D']['Price']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Preis' ];
$D['ATTRIBUTE']['D']['Price']['Active'] = -2;
*/

	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Identity']['ATTRIBUTE']['D']['TaxClass']['Active'] = 1;
	$D['ATTRIBUTE']['D']['TaxClass'] = ['Active' => 1,'Type' => 'select', 'ParentId' => 'main', 'option' => ['zero|Zero', 'normal|normal' ] ];
	$D['ATTRIBUTE']['D']['TaxClass']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Steuerklasse' ];

	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Identity']['ATTRIBUTE']['D']['DeliveryClass']['Active'] = 1;
	$D['ATTRIBUTE']['D']['DeliveryClass'] = ['Active' => 1,'Type' => 'select', 'ParentId' => 'main', 'option' => ['DP', 'DHL' ] ];
	$D['ATTRIBUTE']['D']['DeliveryClass']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Versandklasse' ];
	
	#========================
	#$D['ATTRIBUTE']['D']['general'] = ['Active' => 1,'Type' => 'text', 'ParentId' => '']; #Parent => Gruppe
	#$D['ATTRIBUTE']['D']['general']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Allgemein Gültige Attribute' ];

	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Variation']['ATTRIBUTE']['D']['Color']['Active'] = 1;
	$D['ATTRIBUTE']['D']['Color'] = ['Active' => 1,'Type' => 'text', 'ParentId' => 'general','I18n' => '1'];
	$D['ATTRIBUTE']['D']['Color']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Farbe' ];
	#$D['ATTRIBUTE']['D']['Color']['PROPERTY']['D']['Color']['LANGUAGE']['D']['DE']['Title'] = 'Farbe';
	#$D['ATTRIBUTE']['D']['Color']['PROPERTY']['D']['ColorMap']['LANGUAGE']['D']['DE']['Title'] = 'Farbe Farbgruppe';

	#$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Variation']['ATTRIBUTE']['D']['ColorMap']['Active'] = 1;
	#$D['ATTRIBUTE']['D']['ColorMap'] = ['Active' => 1,'Type' => 'text', 'ParentId' => 'general','I18n' => '1'];
	#$D['ATTRIBUTE']['D']['ColorMap']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Farbgruppe' ];

	$D['ATTRIBUTE_SET']['D']['Default']['ATTRIBUTE_GROUP']['D']['Variation']['ATTRIBUTE']['D']['Size']['Active'] = 1;
	$D['ATTRIBUTE']['D']['Size'] = ['Active' => 1,'Type' => 'text', 'ParentId' => 'general','I18n' => '1'];
	$D['ATTRIBUTE']['D']['Size']['LANGUAGE']['D']['DE'] = [ 'Active' =>1, 'Title' => 'Größe' ];
	
	#Standard Einstellungen
	$D['SETTING']['D']['Menu'] = ['Active' => 1, ];
	$D['SETTING']['D']['MegaMenu'] = ['Active' => 1, ];
	$D['SETTING']['D']['FooterMenu'] = ['Active' => 1, ];
	$D['SETTING']['D']['SiteTitle'] = ['Active' => 1, 'ParentId' => 'Site', ];
	$D['SETTING']['D']['OrderNextNumber'] = ['Active' => 1, 'ParentId' => 'Order', 'Value' => 1];
	##$D['SETTING']['D']['Language'] = ['Active' => 1, 'ParentId' => null, 'Value' => '{"DE":{"Active":1},"EN":{"Active":1}}'];
	#$D['SETTING']['D']['CustomerGroup'] = ['Active' => 1, 'ParentId' => null, 'Value' => '{"B2B":{"Active":1},"B2C":{"Active":1}}'];
	#$D['SETTING']['D'][''] = ['Active' => 1, 'ParentId' => null, 'Value' => ''];

	$D['PATTERN']['LINK'] = [
		'Active'		=> ['Type' => 'checkbox'],
		'FromURL'		=> ['Type' => 'text'],
		'ToURL'			=> ['Type' => 'text'],
	];

	#Erforderliche SEO-Seiten
	$D['LINK']['D'][ hash("crc32b", '') ] = ['Active' => 1,'FromURL' => '','ToURL' => 'D[_PAGE]=page&D[_ID]=start&D[_LANGUAGE]=DE' ]; #Startseite

	$D['LINK']['D'][ hash("crc32b", 'account') ] = ['Active' => 1,'FromURL' => 'account','ToURL' => 'D[_PAGE]=account' ];
	$D['LINK']['D'][ hash("crc32b", 'account/login') ] = ['Active' => 1,'FromURL' => 'account/login','ToURL' => 'D[_PAGE]=account.login' ];
	$D['LINK']['D'][ hash("crc32b", 'account/logout') ] = ['Active' => 1,'FromURL' => 'account/logout','ToURL' => 'D[_PAGE]=account.logout' ];

	#$D['LINK']['D'][ hash("crc32b", 'account/profil') ] = ['Active' => 1,'FromURL' => 'profil','ToURL' => 'D[_PAGE]=account|account.profil' ];
	$D['LINK']['D'][ hash("crc32b", 'account/order') ] = ['Active' => 1,'FromURL' => 'order','ToURL' => 'D[_PAGE]=account|account.order' ];
	$D['LINK']['D'][ hash("crc32b", 'account/address') ] = ['Active' => 1,'FromURL' => 'address','ToURL' => 'D[_PAGE]=account|account.address' ];
	$D['LINK']['D'][ hash("crc32b", 'account/memo') ] = ['Active' => 1,'FromURL' => 'memo','ToURL' => 'D[_PAGE]=account|account.memo' ];
	$D['LINK']['D'][ hash("crc32b", 'account/user') ] = ['Active' => 1,'FromURL' => 'account/user','ToURL' => 'D[_PAGE]=account|account.user' ];
	$D['LINK']['D'][ hash("crc32b", 'account/basket') ] = ['Active' => 1,'FromURL' => 'account/basket','ToURL' => 'D[_PAGE]=account.basket' ];

	$D['LINK']['D'][ hash("crc32b", 'blog') ] = ['Active' => 1,'FromURL' => 'blog','ToURL' => 'D[_PAGE]=blog.list' ];

	#=====Versandarten===================
	$D['SHIPPING']['D']['DHL'] = ['Active' => 1,'DeliveryDay' => 2, 'Price' => 5.99];
	$D['SHIPPING']['D']['DHL']['LANGUAGE']['D']['DE'] = ['Active' => 1, 'Title' => 'DHL Versand'];
	$D['SHIPPING']['D']['DHL']['PAYMENT']['D']['PP'] = ['Active' => 1];
	$D['SHIPPING']['D']['DHL']['PAYMENT']['D']['PR'] = ['Active' => 1];
	$D['SHIPPING']['D']['DHL']['PAYMENT']['D']['CP'] = ['Active' => 1];
	$D['SHIPPING']['D']['DHL']['PAYMENT']['D']['OA'] = ['Active' => 1];
	$D['SHIPPING']['D']['DHL']['COUNTRY']['D']['DE'] = ['Active' => 1];
	$D['SHIPPING']['D']['DHL']['COUNTRY']['D']['IT'] = ['Active' => 1];

	$D['PAYMENT']['D']['PP'] = ['Active' => 0];
	$D['PAYMENT']['D']['PP']['LANGUAGE']['D']['DE'] = ['Active' => 1, 'Title' => 'PayPal'];
	$D['PAYMENT']['D']['PR'] = ['Active' => 1];
	$D['PAYMENT']['D']['PR']['LANGUAGE']['D']['DE'] = ['Active' => 1, 'Title' => 'Vorkasse'];
	$D['PAYMENT']['D']['CP'] = ['Active' => 0];
	$D['PAYMENT']['D']['CP']['LANGUAGE']['D']['DE'] = ['Active' => 1, 'Title' => 'Barzahlung'];
	$D['PAYMENT']['D']['OA'] = ['Active' => 0];
	$D['PAYMENT']['D']['OA']['LANGUAGE']['D']['DE'] = ['Active' => 1, 'Title' => 'Auf Rechnung'];
	$CData->set_object($D); 
}

$F['SETTING'] = [];
$F['ATTRIBUTE'] = [];

$CData->get_object($D,$F);
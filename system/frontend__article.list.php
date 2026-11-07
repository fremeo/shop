<?php
$search = trim((string)($D['SEARCH'] ?? ''));
if($search !== '') {
	$f['ARTICLE']['W'][0]['ATTRIBUTE']['W'][0]['ID'] = ['Title','Sku','Description'];
	
	$terms = preg_split('/\s+/', $search); # Suchbegriffe anhand von Leerzeichen trennen
	$count = count($terms);
	
	for ($i = 0; $i < $count; $i++) { 
		$f['ARTICLE']['W'][0]['ATTRIBUTE']['W'][0]['LANGUAGE']['W'][$i]['Value']['LIKE%%'] = $terms[$i];
	}
	
	#$f['ARTICLE']['W'][0]['ATTRIBUTE']['W'][0]['LANGUAGE']['W'][0]['Value']['LIKE%%'] = $D['SEARCH'];
	$C['fremeo/shop']['CData']->get_object($dSearch,$f);
	
	#Filter agiere auf Parent und Kinder 
	$F['ARTICLE']['W'][0]['ID'] = array_merge( array_keys((array)($dSearch['ARTICLE']['D']??[]))
		,array_keys((array)($dSearch['ARTICLE']['ParentId']['D']??[]))
	 );
	 
	#Kategorie bzw. vorab gesetzten Filter berücksichtigen
	#$F['ARTICLE']['W'][0]['ATTRIBUTE']['W'][0]['ID'] = $R['F']['ARTICLE']['W'][0]['ATTRIBUTE']['W'][0]['ID'];
	#$F['ARTICLE']['W'][0]['ATTRIBUTE']['W'][0]['Value'] = $R['F']['ARTICLE']['W'][0]['ATTRIBUTE']['W'][0]['Value'];

}

#Vater auslesen

$F = array_merge_recursive($F,($D['R']['F']??[]));

$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
$F['ARTICLE']['STOCK'] = [];
$F['ARTICLE']['CUSTOMERGROUP'] = [];
$F['ARTICLE']['W'][0]['ParentId']['='] = ''; #Filtere nach Parend und einzeln Artikel, keine Kinder
$F['ARTICLE']['W'][0]['Active'] = '1';

$F['ARTICLE']['L']['STEP'] = $D['_ARTICLE']['STEP'] = $_SESSION['D']['_ARTICLE']['STEP'] = $D['_STEP']??$_SESSION['D']['_ARTICLE']['STEP']??100;

$C['fremeo/shop']['CData']->get_object($D,$F);

$D['ARTICLE']['_PARENT_COUNT'] = count((array)($D['ARTICLE']['D']??[]));#$D['ARTICLE']['COUNT'];
#$D['ARTICLE']['_PARENT_COUNT'] = $D['ARTICLE']['COUNT'];



#Kinder auslesen
if($D['ARTICLE']['D']??null) {
	$F2['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
	$F2['ARTICLE']['STOCK'] = [];
	$F2['ARTICLE']['CUSTOMERGROUP'] = [];
	$F2['ARTICLE']['W'][0]['ParentId'] = array_keys((array)$D['ARTICLE']['D']);
	$C['fremeo/shop']['CData']->get_object($D,$F2);
}
#unset($F);

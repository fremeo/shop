<?php
$F['ARTICLE']['W'][0]['ID'] = [$D['_ID']];

$C['CData']->get_object($D,$F);
unset($F['ARTICLE']['W'][0]['ID']);

foreach((array) $D['ARTICLE']['D'] AS $kART => $ART) {
	
	if($ART['ParentId']) {
		$F['ARTICLE']['W'][0]['ID'][] = $ART['ParentId'];
		$F['ARTICLE']['W'][1]['ParentId'][] = $ART['ParentId'];
	} else {
		$F['ARTICLE']['W'][0]['ID'][] = $D['_ID'];
		$F['ARTICLE']['W'][1]['ParentId'][] = $D['_ID'];
	}
}

unset($D['ARTICLE']); #die Variation auswahl wegen der Sortierung wieder entfernt, weil weiter wird dieses Aritkel in der richtigen Reihenfolge geholt.

#$F['ARTICLE']['W'][1]['ParentId'] = [$D['_ID']];
#$F['ARTICLE']['W'][2]['ID'] = [$D['_PID']]; #Wenn Variante aufgemacht, wird muss andere Varianten und parent Artikel ebenfalls ausgeben.
#$F['ARTICLE']['W'][3]['ParentId'] = [$D['_PID']];
$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
$F['ARTICLE']['STOCK'] = [];
$F['ARTICLE']['CUSTOMERGROUP'] = [];

$F['ATTRIBUTE']['LANGUAGE'] = [];


$C['papp~shop']['CData']->get_object($D,$F);
unset($F['ARTICLE']);
unset($F['ATTRIBUTE']);
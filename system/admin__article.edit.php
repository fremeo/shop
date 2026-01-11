<?php

if(($D['ACTION']??null) == 'save') {
	$C['CData']->set_object($D);
}

else if(($D['ACTION']??null) == 'new') {
	$D['ARTICLE']['D']['-new-'] = [];
}

$F['ARTICLE']['W'][0]['ID'] = $D['_ID'];
$F['ARTICLE']['W'][1]['ParentId'] = $D['_ID'];
$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
$F['ARTICLE']['STOCK'] = [];
$F['ARTICLE']['CUSTOMERGROUP'] = [];
$F['ATTRIBUTE']['LANGUAGE'] = [];
###$C['CData']->get_object($D,$F);


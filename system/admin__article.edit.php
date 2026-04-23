<?php

if(($D['ACTION']??null) == 'save') {
	$C['papp~shop']['CData']->set_object($D);
}
else if(($R['ACTION']??null) == 'new') {
	$D['R']['Id'] = hash("crc32b", time());
	$D['_ID'] = $D['R']['Id'];#Todo: verübergehend, bis $D_ID zur R[Id] wird.
}

$F['ARTICLE']['W'][0]['ID'] = $D['_ID'];
$F['ARTICLE']['W'][1]['ParentId'] = $D['_ID'];
$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
$F['ARTICLE']['STOCK'] = [];
$F['ARTICLE']['CUSTOMERGROUP'] = [];
$F['ATTRIBUTE']['LANGUAGE'] = [];
###$C['CData']->get_object($D,$F);

$C['papp~shop']['CData']->get_object($D,$F);
unset($F['ARTICLE']);
unset($F['ATTRIBUTE']);
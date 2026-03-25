<?php

if(($D['ACTION']??null) == 'save') {
	$C['papp~shop']['CData']->set_object($D); 
}


$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
$F['ARTICLE']['STOCK'] = [];
$F['ARTICLE']['CUSTOMERGROUP'] = [];
$C['papp~shop']['CData']->get_object($D,$F);
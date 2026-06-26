<?php

if(($D['ACTION']??null) == 'save') {
	$C['fremeo~shop']['CData']->set_object($D); 
}


$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
$F['ARTICLE']['STOCK'] = [];
$F['ARTICLE']['CUSTOMERGROUP'] = [];
$C['fremeo~shop']['CData']->get_object($D,$F);
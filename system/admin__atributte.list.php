<?php

if(($D['ACTION']??null) == 'save') {
	$C['CData']->set_object($D); 
}


$F['ARTICLE']['ATTRIBUTE']['LANGUAGE'] = [];
$F['ARTICLE']['STOCK'] = [];
$F['ARTICLE']['CUSTOMERGROUP'] = [];
$C['CData']->get_object($D,$F);
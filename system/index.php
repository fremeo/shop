<?php
$_page = explode('|',$D['_PAGE']);
$_tpl = null;
foreach((array)$_page AS $kPage => $Page) {
	if( is_file("system/papp/shop/system/{$Page}.php")) {
		include "system/papp/shop/system/{$Page}.php";  #Fügt ggf. Seiten Spezifische Ausgaben $F hinzu
	}
	$_tpl .= "|{$Page}.tpl";
}
$CData->get_object($D,$F);


$smarty->assign('D',$D);
$smarty->display("extends:index.tpl{$_tpl}|include/input.tpl");
<?php 
/*
if($D['SEO_URL'] == '') {


// Smarty-Instanz erzeugen
	#$smarty = new Smarty();
	
	#$smarty->setTemplateDir(__DIR__ . '/system/template/');
	$smarty->addTemplateDir(__DIR__ . '/system/template/', 'shop');
	#$C['smarty']->setCompileDir(__DIR__ . "/../../../data_c/{$projectName}/template_c/");
	$smarty->setCompileDir("{$D['MY']['CacheDir']}template_c/");
	$smarty->error_reporting = E_ALL & ~E_NOTICE & ~E_WARNING & ~E_DEPRECATED;
	
	if($D['LINK']['D'][ $hURL ]['Active'] && strpos($D['LINK']['D'][ $hURL ]['ToURL'], 'D[_PAGE]') !== false ) {
			parse_str($D['LINK']['D'][ $hURL ]['ToURL'], $d);
			$D = array_merge_recursive ($D,(array)$d['D']);
			header( "HTTP/1.1 200 OK" );
		}
		else {#Link nicht vorhanden
			header( "HTTP/1.1 404 Not Found" );
			$D['_PAGE'] = '404';
		}
		
	
	
	include(__DIR__."/system/index.php");
}
*/
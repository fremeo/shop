<?php

if ( !$D['SESSION']['ACCOUNT']) {
	header("Location: {$D['BasePath']}account/login");
}
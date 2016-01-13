<?php
	
	try {
	    $db_connection = pg_connect("host=192.168.99.100 port=5433 dbname=test user=test password=test");

	    echo 'connected';
	} catch (Exception $e) {
		echo 'une erreur est survenue: '.$e->getMessage();
	}

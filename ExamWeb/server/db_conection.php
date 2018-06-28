<?php

	try{
		//$conn = new PDO("oci:dbname=BOCHN;host=192.168.159.188",'BOC','Bochn2015$');
		$conn = new PDO("mysql:dbname=examweb;host=localhost",'root','');
	}catch(PDOException $e)
	{
		echo $e ;
	}	

?>
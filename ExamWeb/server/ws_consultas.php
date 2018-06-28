<?php
$postdata = file_get_contents("php://input");
$request = json_decode($postdata);

switch ($request->op) {
	case 1:		
		getExamen($request->v1);
		break;
	case 2:
		getPreguntasExamen($request->v1, $request->v2);
		break;
	case 3:
		guardaRespuestas($request->v1);
		break;
	default:
		# code...
		null;
		break;
}
//getPreguntasExamen(10001, 'REP001');
//getExamen(10001);

function getPreguntasExamen($vAlumno, $vExamen){

	$json_result = [];
	$vcont = 1;
	try{
		include 'db_conection.php';

		$vQry = 'SELECT a.id_examen,';
		$vQry .= '	b.titulo,';
		$vQry .= '	b.asignatura,';
		$vQry .= '	b.catedratico,';
		$vQry .= '	b.tiempo,';
		$vQry .= '	c.nombre,';
		$vQry .= '	d.id_pregunta,';
		$vQry .= '	d.texto_pregunta,';
		$vQry .= '	lower(d.op1) op1,';
		$vQry .= '	lower(d.op2) op2,';
		$vQry .= '	lower(d.op3) op3,';
		$vQry .= '	lower(d.op4) op4,';	
		$vQry .= '	a.id_alumno';
		$vQry .= '	FROM tbl_examen_alumnos a';
		$vQry .= '	left join tbl_examenes b on (a.id_examen=b.id)';
		$vQry .= '	left join tbl_alumnos c on (a.id_alumno=c.id_alumno)';
		$vQry .= '	left join tbl_preguntas_examen d on (a.id_examen=d.id_examen and d.estado = 1)';
		$vQry .= '	WHERE	a.id_alumno = ' . $vAlumno . ' and a.id_examen =\'' . $vExamen . '\';';

	    $temp_arr = array();
	    foreach($conn->query($vQry) as $row){
	    	$temp_arr = array("id_exm"=>$row[0], "id_alumn"=>$row[12], "num"=>$vcont, "id"=>$row[6], "q"=>$row[7],"r"=>"", "op1"=>$row[8], "op2"=>$row[9],"op3"=>$row[10],"op4"=>$row[11]);
	    	array_push($json_result, $temp_arr);
	    	$vcont ++;
	    }

		    /*var_dump($row);*/
		}catch(PDOException $e){
			echo $e;
		}
		echo JSON_encode($json_result);
}

function getExamen($vAlumno){

	$json_result = [];
	$vcont = 1;
	try{
		include 'db_conection.php';

		$vQry = 'SELECT a.id_examen,';
		$vQry .= 'b.titulo,';
		$vQry .= 'e.nombre as asignatura,';
		$vQry .= 'd.nombre as catedratico,';
		$vQry .= 'c.nombre,';
		$vQry .= 'c.id_alumno,';
		$vQry .= 'b.tiempo';
		$vQry .= ' FROM tbl_examen_alumnos a';
		$vQry .= ' left join tbl_examenes b on (a.id_examen=b.id)';
		$vQry .= ' left join tbl_alumnos c on (a.id_alumno=c.id_alumno)';
		$vQry .= ' left join tbl_catedraticos d on (b.catedratico=d.id_catedratico)';
		$vQry .= ' left join tbl_asignaturas e on (b.asignatura=e.id_asignatura)';
		$vQry .= ' WHERE a.id_alumno = ' . $vAlumno;

	    $temp_arr = array();
	    foreach($conn->query($vQry) as $row){
	    	$temp_arr = array("id"=>$row[0], "title"=>$row[1], "asignatura"=>$row[2], "catedratico"=>$row[3], "alumno"=>$row[4], "alumno_id"=>$row[5],"tiempo"=>$row[6]);
	    	array_push($json_result, $temp_arr);
	    	$vcont ++;
	    }
		    /*var_dump($row);*/
		

		}catch(PDOException $e){
			echo $e;
		}
		echo JSON_encode($json_result);

}

function guardaRespuestas($arr_respuestas){

	$vFlag = 0;
	try{		
		include 'db_conection.php';
		//print_r($arr_respuestas);
		for($i=0; $i<count($arr_respuestas); $i++){
			$vQry = 'INSERT INTO tbl_respuestas_examen (id_examen, id_alumno,id_pregunta, respuesta_alumno, correcta, fecha)';
			$vQry .= ' VALUES(';
			$vQry .= '\'' . $arr_respuestas[$i]->id_exm; 
			$vQry .= '\',\'' . $arr_respuestas[$i]->id_alumn;
			$vQry .= '\',' . $arr_respuestas[$i]->id;
			$vQry .= ',\'' . $arr_respuestas[$i]->r;
			$vQry .= '\',' . -1;
			$vQry .= ',NOW())';

			$stmt = $conn->prepare($vQry);
			if(!$stmt->execute()){
		    	print_r($conn->errorInfo());
		    	$vFlag = 1;
		    }else{
				$vFlag = 0;				
			}
		    //echo $vQry;
		}

		for($i=0; $i<count($arr_respuestas); $i++){

			$vQry = 'INSERT INTO tbl_respuestas_examen (id_examen, id_alumno, id_pregunta, correcta)';
			$vQry .= ' SELECT * FROM (';
    		$vQry .= ' SELECT a.id_examen,';
    		$vQry .= ' a.id_alumno,';
    		$vQry .= ' d.id_pregunta,';
    		$vQry .= ' case when UPPER(d.txt_respuesta) = UPPER(e.respuesta_alumno) then 1 else 0 end correcta';
    		$vQry .= ' FROM tbl_examen_alumnos a';
    		$vQry .= ' left join tbl_examenes b on (a.id_examen=b.id)';
    		$vQry .= ' left join tbl_alumnos c on (a.id_alumno=c.id_alumno)';
    		$vQry .= ' left join tbl_preguntas_examen d on (a.id_examen=d.id_examen and d.estado = 1)';
    		$vQry .= ' left join tbl_respuestas_examen e on (a.id_examen=e.id_examen and d.id_pregunta=e.id_pregunta)';
    		$vQry .= ' WHERE	a.id_alumno = '. $arr_respuestas[$i]->id_alumn .' and a.id_examen= \''. $arr_respuestas[$i]->id_exm .'\') as t2';
			$vQry .= ' ON DUPLICATE KEY UPDATE correcta = t2.correcta';

			$stmt = $conn->prepare($vQry);
			if(!$stmt->execute()){
		    	print_r($conn->errorInfo());
		    	$vFlag = 1;
		    }else{
				$vFlag = 0;				
			}
		    //echo $vQry;
		}
		
		if($vFlag==0){
			echo 'SUCCESS';
		}else{
			echo 'Error';
		}
	    /*var_dump($row);*/
	}catch(Exception $e){		
		echo $e;
	}
}

?>
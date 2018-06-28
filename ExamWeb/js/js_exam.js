
var parametros;
var appMDL = angular.module("appMain", []);

appMDL.controller("ctrl_1", function($scope, $http) {
	//alert('x');
	$scope.reloj = 0;
	$scope.exam_title = 'YYYY';
	$scope.catedratico = 'xx';
	$scope.alumno = 'xxxxxxx';
	$scope.preguntas_exm = []; //[{"num":"1", "q":"que es la matriz foda y para que sierve", 'op1':'Es un analisis','op2':'es todo','op3':'todas son correctas','op4':'son siglas'},
							 //{"num":"2","q":"que es la matriz de impacto", 'op1':'Es un analisis','op2':'es todo','op3':'todas son correctas','op4':'son siglas'}];
	// body...
	//console.log(parametros.p2);
	$http.post('server/ws_consultas.php', {op:2, v1:parametros.p1, v2:parametros.p2}).then(function(result){
		console.log(result.data);
		$scope.preguntas_exm = result.data;
	});

	$scope.guardarRespuestas = function(){
		$http.post('server/ws_consultas.php', {op:3, v1:$scope.preguntas_exm}).then(function(result){
			console.log(result.data);			
		});
	}

	$scope.repuesta = function(obj) {
		//alert(0);
		var qx = ''; 
		var rx = ''; 
		
		for(i=0; i<$scope.preguntas_exm.length; i++){
			qx = 'q' + $scope.preguntas_exm[i].id;
			rx = obj.target.id;
			//console.log($scope.preguntas_exm[i].id +'-'+ obj.target.name);
			if(qx == obj.target.name){
				if(rx == qx+'a'){
					$scope.preguntas_exm[i].r = $scope.preguntas_exm[i].op1;
				}else if(rx == qx+'b'){
					$scope.preguntas_exm[i].r = $scope.preguntas_exm[i].op2;
				}else if(rx == qx+'c'){
					$scope.preguntas_exm[i].r = $scope.preguntas_exm[i].op3;
				}else if(rx == qx+'d'){
					$scope.preguntas_exm[i].r = $scope.preguntas_exm[i].op4;
				}
				console.log($scope.preguntas_exm);
				//console.log(obj.target.name +'-'+ obj.target.id);
			}
		}
	}

	$scope.timer = setInterval(function(){ 
			$scope.reloj = $scope.reloj +1; 
			$("#reloj").html($scope.reloj);
			if($scope.reloj == 10){
				clearTimeout($scope.timer);
			}
	}, 1000);


});

function getParams(param) {
    var vars = {};
    window.location.href.replace( location.hash, '' ).replace( 
        /[?&]+([^=&]+)=?([^&]*)?/gi, // regexp
        function( m, key, value ) { // callback
            vars[key] = value !== undefined ? value : '';
        }
    );

    if ( param ) {
        return vars[param] ? vars[param] : null;    
    }
    return vars;
}
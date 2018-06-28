
var appMDL = angular.module("appMain", []);

appMDL.controller("ctrl_1", function($scope, $http) {
	//alert('x');
	$scope.reloj = 0;
	$scope.exam_title = 'YYYY';
	$scope.catedratico = 'xx';
	$scope.alumno = 'xxxxxxx';
	$scope.jsn_examenes;
	// body...

	$scope.getExamen = function(){
		$http.post('server/ws_consultas.php', {op:1, v1:$scope.id_alumno}).then(function(result){
			console.log(result.data);
			$scope.jsn_examenes = result.data;
		});
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
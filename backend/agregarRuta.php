<?php

header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Methods: HEAD, GET, POST, PUT, PATCH, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method,Access-Control-Request-Headers, Authorization");
header('Content-Type: application/json');
$method = $_SERVER['REQUEST_METHOD'];
if ($method == "OPTIONS") {
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method,Access-Control-Request-Headers, Authorization");
header("HTTP/1.1 200 OK");
die();
}

    require "config.php";

    $idUser = $_POST['idUser'];   
    $nombre = $_POST['nombre'];   
    $telefono = $_POST['telefono'];  
    $placa = $_POST['placa'];
    $cupo = $_POST['cupo'];
    $salida = $_POST['salida'];
    $llegada = $_POST['llegada'];
    $estado = $_POST['estado'];


    $sql = "INSERT INTO ruta (id, idUser,nombre,telefono,placa,cupo,salida,llegada, estado)
     VALUES (default,'$idUser', '$nombre', '$telefono', '$placa', '$cupo', '$salida','$llegada','$estado')";
    

    if (mysqli_query($con, $sql)) {
    $respuesta = array("mensaje"=>"Datos Modificados");
    $json_string = json_encode($respuesta);
    echo $json_string;
  } else {
    
    $respuesta = array("mensaje"=>"Error". mysqli_error($con));
    $json_string = json_encode($respuesta);
    echo $json_string;
  
  }  
?>
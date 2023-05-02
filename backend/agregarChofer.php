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
     
    $correo = $_POST['correo'];   
    $identificacion = $_POST['identificacion'];
    $nombre = $_POST['nombre'];   
    $telefono = $_POST['telefono'];
    $tipo = $_POST['tipo'];
    $ruta = $_POST['ruta'];
    $password = $_POST['password']; 

    $sql = "INSERT INTO usuario (id, correo, identificacion,nombre,placa,telefono,tipo,ruta,password)
     VALUES (default,'$correo', '$identificacion', '$nombre', '$placa', '$telefono','$tipo',default,'$password')";
    
    if (mysqli_query($con, $sql)) {
    $respuesta = array("mensaje"=>"Datos registrados");
    $json_string = json_encode($respuesta);
    echo $json_string;
  } else {
    $respuesta = array("mensaje"=>"Error al registrar". mysqli_error($con));
    $json_string = json_encode($respuesta);
    echo $json_string;
  }  
?>
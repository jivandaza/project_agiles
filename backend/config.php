<?php

session_start();
$host = "localhost"; /* equipo */
$user = "id18947852_bestparkingapp1"; /* usuario */
$password = "!bestparkingO1!"; /* clave */
$dbname = "id18947852_bestparkingapp"; /* base de datos */

$con = mysqli_connect($host, $user, $password,$dbname);

if (!$con) {
  die("Connection failed: " . mysqli_connect_error());
}
//echo "Conexion Exitosa";

?>

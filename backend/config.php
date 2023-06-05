<?php

session_start();
$host = "localhost"; /* equipo */
$user = "id18968237_cootraznorte"; /* usuario */
$password = "2q>KCZIvT{7-ykyQ"; /* clave */
$dbname = "id18968237_cootraznortedb"; /* base de datos */

$con = mysqli_connect($host, $user, $password,$dbname);

if (!$con) {
  die("Connection failed: " . mysqli_connect_error());
}
//echo "Conexion Exitosa";

?>

<?php
    session_start();
    if(isset($_SESSION["user"])){
        if ($_SESSION["user"] != ''){
            header("location:http://localhost/sistema_control_asistencias/views");
            exit();
        }
    }
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <title>Registrar Asistencia | Sistema Control de Asistemas</title>
    <?php
        require($_SERVER['DOCUMENT_ROOT'].'/sistema_control_asistencias/includes/head.php');
    ?>
</head>
<body>
   
    <header>
        <nav class="navbar justify-content-between navbar-dark bg-primary" style="padding-bottom:5px;padding-top:5px;">
            <a class="navbar-brand" href="#"><img src="http://localhost/sistema_control_asistencias/media/logo-unir.png" width="80" height="30" class="d-inline-block align-top" alt="">Control de Asistencias</a>
            <form class="form-inline">
                <button class="btn btn-outline-light my-2 my-sm-0" type="button" data-toggle="modal" data-target="#login_modal">Iniciar Sesión</button>    
            </form>
        </nav>
    </header>
    
    <main>
        <div class="container">
            <div class="asistencia_modal">
               
                <form action="#" id="asistencia" class="border border-primary rounded p-5 form mt-5">
                    <div class="form-group row justify-content-center">
                        <img src="http://localhost/sistema_control_asistencias/media/icon-profile.png" class="navbar_logo">
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Ingresar cédula de identidad para marcar asistencia</label>
                        <input type="text" name="cedula" id="cedula" class="form-control" placeholder="Cédula de Identidad" minlength="6" maxlength="8" onkeypress="return validar_numeros(event);" autocomplete="off">
                    </div>
                    
                    <div class="row justify-content-center">
                        <button type="submit" class="btn btn-outline-primary">Marcar Asistencia</button>
                    </div>
                </form>
                
            </div>
        </div>
    </main>
    
    <footer class="fixed-bottom">
        <div class="text-center">
            <hr>
            <p>Si necesitas ayuda, puedes ver el MANUAL DE USUARIO haciendo click <a href="#">AQUI</a>.</p>
            <p>© 2020 Copyright UNIR</p>
        </div>
    </footer>
    
    <div class="modal" id="login_modal">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title bold">Iniciar Sesión</h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>

                <div class="modal-body">
                    <form action="" id="login">
                        <div class="form-group">
                            <label for="user">Usuario</label>
                            <input type="text" class="form-control" id="user" name="user" maxlength="15" required autocomplete="off">
                        </div>
                        <div class="form-group">
                            <label for="password">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" maxlength="30" required autocomplete="off">
                        </div>
                    </form>
                </div>

                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal"><strong>Cancelar</strong></button>
                    <button type="submit" form="login" class="btn btn-primary"><strong>Entrar</strong></button>
                </div>

            </div>
        </div>
    </div>
    
    <?php
        require($_SERVER['DOCUMENT_ROOT'].'/sistema_control_asistencias/includes/script.php');
    ?>
    <script src="http://localhost/sistema_control_asistencias/js/validar.js"></script>
    <script>
        $('#login_modal').on('shown.bs.modal', function() {
             $('#user').focus();
        })
        
        $('#login_modal').on('hide.bs.modal', function() {
            document.getElementById('user').value = '';
            document.getElementById('password').value = '';
        })
        
        jQuery(document).on('submit','#login', function(event){
            event.preventDefault();
            
            jQuery.ajax({
                url: 'http://localhost/sistema_control_asistencias/php/login.php',
                type: 'POST',
                dataType: 'json',
                data: $(this).serialize(),
                beforeSend: function(){
                    
                }
            })
            
            .done(function(respuesta) {
                if (!respuesta.error){
                    location.href = 'http://localhost/sistema_control_asistencias/views';
                } else if (respuesta.denegado) {
                    Swal.fire({
                        icon: 'error',
                        title: 'ERROR',
                        text: 'Cuenta desactivada!'
                    })
                    document.getElementById('password').value = '';
                } else {
                    Swal.fire({
                        icon: 'error',
                        title: 'ERROR',
                        text: 'Datos inválidos!'
                    })
                    document.getElementById('password').value = '';
                }
            })
            .fail(function(respuesta) {
                console.log(respuesta.responseText);
            })
        });
        
        jQuery(document).on('submit','#asistencia', function(event){
            event.preventDefault();
            var cedula = document.getElementById("cedula").value;
            if (cedula != ""){
                $.ajax({
                type: "POST",
                url: "http://localhost/sistema_control_asistencias/php/confirmar.php",
                data: $(this).serialize(),
                success: function(r){
                    
                        if(r == "null"){						
                            Swal.fire({
                              icon: 'error',
                              text: 'Cédula de identidad no registrada!',
                            });			
                        } else if (r == "0"){
                            Swal.fire({
                              icon: 'error',
                              text: 'Usted está desactivado!',
                            });
                        } else if (r == "1"){
                            Swal.fire({
                              icon: 'error',
                              text: 'Usted ya ha marcado la salida hoy!',
                            });
                        } else {
                            Swal.fire({
                                title: "¿Desea marcar la asistencia de "+r+"?",
                                icon: 'question',
                                showCancelButton: true,
                                confirmButtonColor: '#3085d6',
                                cancelButtonColor: '#d33',
                                confirmButtonText: 'Si, marcar!',
                                cancelButtonText: 'Cancelar'
                            }).then((result) => {
                                if (result.value) {
                                    $.ajax({
                                        type: "POST",
                                        dataType: 'json',
                                        url: "http://localhost/sistema_control_asistencias/php/horaActual.php",
                                        data: "cedula="+cedula,
                                        success: function(datos){
                                            
                                            var horaActual = datos.horaActual;
                                            var tipo = datos.tipo;
                                            var espacio_blanco = /[a-z]/i;
                                            
                                            if (tipo == '1'){
                                                if (horaActual > '08:00:00'){
                                                    
                                                    justificacion = '';
                                                    
                                                    while (justificacion == '' || !espacio_blanco.test(justificacion)){
                                                        justificacion = prompt('Usted está entrando tarde. Justifique la razón:');
                                                    }
                                                    
                                                    if (justificacion == null){
                                                        Swal.fire({
                                                          icon: 'error',
                                                          title: 'Marcado cancelado'
                                                        })
                                                    } else {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "http://localhost/sistema_control_asistencias/php/asistencia.php",
                                                            data: {cedula:cedula,tipo:'1',justificacion:justificacion},
                                                            success: function(r){
                                                                Swal.fire({
                                                                  position: 'top-end',
                                                                  icon: 'success',
                                                                  title: 'Marcado Exitoso',
                                                                  showConfirmButton: false,
                                                                  timer: 1500
                                                                })
                                                                document.getElementById("cedula").value="";
                                                            }
                                                        })
                                                    }
                                                } else {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "http://localhost/sistema_control_asistencias/php/asistencia.php",
                                                        data: {cedula:cedula,tipo:'1'},
                                                        success: function(r){
                                                            Swal.fire({
                                                              position: 'top-end',
                                                              icon: 'success',
                                                              title: 'Marcado Exitoso',
                                                              showConfirmButton: false,
                                                              timer: 1500
                                                            })
                                                            document.getElementById("cedula").value="";
                                                        }
                                                    })
                                                }
                                            } else {
                                                if (horaActual < '17:00:00'){
                                                    
                                                    justificacion = '';
                                                    
                                                    while (justificacion == '' || !espacio_blanco.test(justificacion)){
                                                        justificacion = prompt('Usted está saliendo temprano. Justifique la razón:');
                                                    }
                                                    
                                                    if (justificacion == null){
                                                        Swal.fire({
                                                          icon: 'error',
                                                          title: 'Marcado cancelado'
                                                        })
                                                    } else {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "http://localhost/sistema_control_asistencias/php/asistencia.php",
                                                            data: {cedula:cedula,tipo:'0',justificacion:justificacion},
                                                            success: function(r){
                                                                Swal.fire({
                                                                  position: 'top-end',
                                                                  icon: 'success',
                                                                  title: 'Marcado Exitoso',
                                                                  showConfirmButton: false,
                                                                  timer: 1500
                                                                })
                                                                document.getElementById("cedula").value="";
                                                            }
                                                        })
                                                    }
                                                } else {
                                                    $.ajax({
                                                        type: "POST",
                                                        url: "http://localhost/sistema_control_asistencias/php/asistencia.php",
                                                        data: {cedula:cedula,tipo:'0'},
                                                        success: function(r){
                                                            Swal.fire({
                                                              position: 'top-end',
                                                              icon: 'success',
                                                              title: 'Marcado Exitoso',
                                                              showConfirmButton: false,
                                                              timer: 1500
                                                            })
                                                            document.getElementById("cedula").value="";
                                                        }
                                                    })
                                                }
                                            }
                                        }
                                    })
                                    .fail(function(respuesta) {
                                        console.log(respuesta.responseText);
                                    })
                              }
                            })
                        }
                    }
                })
            } else {
                Swal.fire({
                  icon: 'error',
                  title: 'Ingrese cédula de identidad',
                });
            }
        });
    </script>
</body>
</html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ticketes | Registro de Usuario</title>
        <style>
            body { 
                background-color: #8EACB8; /* Azul OR */
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
                margin: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }
            .form-container {
                background: white;
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
                width: 400px;
            }
            h2 { 
                color: #FF69B4; /* Rosa */
                text-align: center;
                margin-bottom: 20px;
            }
            input {
                width: 100%;
                padding: 12px;
                margin: 8px 0;
                border: 2px solid #f0f0f0;
                border-radius: 10px;
                box-sizing: border-box;
                outline: none;
            }
            input:focus { border-color: #90EE90; } /* Verde al hacer clic */
            
            .btn-registrar {
                background-color: #90EE90; /* Verde Pasto */
                color: #333;
                border: none;
                padding: 15px;
                width: 100%;
                border-radius: 10px;
                font-weight: bold;
                cursor: pointer;
                margin-top: 15px;
            }
            .btn-registrar:hover { background-color: #76e076; }
            
            .volver {
                display: block;
                text-align: center;
                margin-top: 15px;
                text-decoration: none;
                color: #888;
                font-size: 14px;
            }
        </style>
    </head>
    <body>

        <div class="form-container">
            <h2>Crea tu Cuenta</h2>
            
            <form action="registroServlet" method="POST">
                <input type="text" name="nombre" placeholder="Nombre(s)" required>
                <input type="text" name="apellido" placeholder="Apellidos" required>
                <input type="email" name="correo" placeholder="Correo Electrónico" required>
                <input type="password" name="pass" placeholder="Contraseña" required>
                <input type="text" name="telefono" placeholder="Teléfono" required>
                <input type="text" name="pais" placeholder="País" required>
                
                <button type="submit" class="btn-registrar">FINALIZAR REGISTRO</button>
            </form>
            
            <a href="index.jsp" class="volver"> <- Volver al inicio</a>
        </div>

    </body>
</html>
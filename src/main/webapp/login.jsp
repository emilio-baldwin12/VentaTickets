<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Iniciar Sesion</title>
    <style>
       
        :root {
            --bg-blue: #8EACB8;/* Azul OR */
            --entity-header: #1A1A1A; /* Negro  */
            --entity-body: #E8E2D1;   /* Crema  */
            --accent-pink: #FFB6C1;   /* Rosa */
        }

        body { 
            background-color: var(--bg-blue); 
            font-family: 'Segoe UI', Tahoma, sans-serif; 
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .login-card {
            background: var(--entity-body);
            border: 2px solid var(--entity-header);
            border-radius: 8px;
            width: 350px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .login-header {
            background: var(--entity-header);
            color: white;
            padding: 15px;
            text-align: center;
            font-weight: bold;
            letter-spacing: 1px;
            font-size: 18px;
        }

        .login-body {
            padding: 25px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
            font-size: 14px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box; /* Evita que el input se salga del cuadro */
            background-color: white;
        }

        .btn-entrar {
            background-color: var(--accent-pink);
            color: #333;
            border: 2px solid var(--entity-header);
            padding: 12px;
            width: 100%;
            font-weight: bold;
            cursor: pointer;
            border-radius: 4px;
            transition: 0.3s;
        }

        .btn-entrar:hover {
            filter: brightness(0.9);
            transform: translateY(-2px);
        }

        .footer-links {
            text-align: center;
            margin-top: 15px;
        }

        .footer-links a {
            text-decoration: none;
            color: #555;
            font-size: 13px;
        }

        .footer-links a:hover {
            text-decoration: underline;
            color: var(--entity-header);
        }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="login-header">
            USUARIOS : LOGIN
        </div>
        
        <div class="login-body">
            <form action="loginServlet" method="POST">
                <label>CORREO ELECTRÓNICO:</label>
                <input type="email" name="correo" placeholder="ejemplo@mail.com" required>

                <label>CONTRASEÑA:</label>
                <input type="password" name="pass" placeholder="********" required>

                <button type="submit" class="btn-entrar">INGRESAR AL SISTEMA</button>
            </form>

            <div class="footer-links">
                <a href="index.jsp"> <- Volver al Inicio</a><br><br>
                <a href="registro.jsp">¿No tienes cuenta? Regístrate aquí</a>
            </div>
        </div>
    </div>

</body>
</html>
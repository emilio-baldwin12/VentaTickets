<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Home</title>
    <style>
        :root {
            --bg-blue: #8EACB8;  /* Azul OR */
            --entity-header: #1A1A1A; /* Negro  */
            --entity-body: #E8E2D1;   /* Crema */
            --accent-pink: #FFB6C1;   /* Rosa */
            --accent-green: #90EE90;  /* Verde  */
        }

        body { 
            background-color: var(--bg-blue); 
            font-family: 'Segoe UI', Tahoma, sans-serif; 
            margin: 0; 
            color: #333;
        }

        header {
            background-color: var(--entity-header);
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        .logo { 
            font-size: 30px; 
            font-weight: bold; 
            color: white; 
            text-decoration: none; 
            letter-spacing: 2px;
        }
        .nav-btns a {
            text-decoration: none;
            padding: 10px 25px;
            border-radius: 4px;
            font-weight: bold;
            margin-left: 10px;
            transition: 0.3s;
        }
        .btn-login { background-color: var(--accent-pink); color: #333; }
        .btn-reg { background-color: var(--accent-green); color: #333; }
        .btn-login:hover, .btn-reg:hover { filter: brightness(0.9); }

        .main-wrapper {
            display: flex;
            max-width: 1200px;
            margin: 40px auto;
            gap: 25px;
            padding: 0 20px;
        }

        .content-main { flex: 3; }
        .sidebar { flex: 1; }

        .section-title { 
            font-size: 20px; 
            font-weight: bold; 
            margin-bottom: 25px; 
            color: white;
            background: var(--entity-header);
            padding: 10px 20px;
            display: inline-block;
            border-radius: 4px 4px 0 0;
        }
        
        .event-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 25px;
        }

        .event-card {
            background: var(--entity-body);
            border: 2px solid var(--entity-header);
            border-radius: 8px;
            overflow: hidden;
            transition: 0.3s;
            display: flex;
            flex-direction: column;
        }
        .event-card:hover { transform: scale(1.02); box-shadow: 0 10px 20px rgba(0,0,0,0.2); }
        
        .event-header { 
            background: var(--entity-header); 
            color: white; 
            padding: 10px; 
            text-align: center; 
            font-weight: bold;
            font-size: 14px;
        }
        
        .event-info { padding: 20px; border-top: 1px solid #ccc; }
        .event-info h3 { font-size: 18px; margin: 0 0 10px 0; color: #1a1a1a; }
        .event-info p { font-size: 14px; color: #555; margin: 0; }

        .side-card {
            background: var(--entity-body);
            border: 2px solid var(--entity-header);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .side-card h4 { 
            margin-top: 0; 
            color: var(--entity-header); 
            border-bottom: 2px solid var(--entity-header); 
            padding-bottom: 5px; 
        }
    </style>
</head>
<body>

    <header>
        <a href="index.jsp" class="logo">TICKETS</a>
        <div class="nav-btns">
            <a href="login.jsp" class="btn-login">INICIAR SESION</a>
            <a href="registro.jsp" class="btn-reg">REGISTRARSE</a>
        </div>
    </header>

    <div class="main-wrapper">
        
        <div class="content-main">
            <div class="section-title">LO MAS BUSCADO</div>
            
            <div class="event-grid">
                <div class="event-card">
                    <div class="event-header">ARTISTA : ID_01</div>
                    <div class="event-info">
                        <h3>Vans Warped Tour</h3>
                        <p>> Autodromo Hnos. Rodriguez</p>
                        <p>> Fecha: 15/06/2026</p>
                    </div>
                </div>

                <div class="event-card">
                    <div class="event-header">ATRISTA : ID_02</div>
                    <div class="event-info">
                        <h3>Mentiras, El Musical</h3>
                        <p>> Teatro Aldama</p>
                        <p>> Disponibilidad: Alta</p>
                    </div>
                </div>

                <div class="event-card">
                    <div class="event-header">ARTISTA : ID_03</div>
                    <div class="event-info">
                        <h3>Zayn</h3>
                        <p>> Estadio GNP Seguros</p>
                        <p>> Estado: Preventa</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <div class="side-card">
                <h4>SISTEMA</h4>
                <p>Bienvenido al vendedor de boletos derrocador</p>
            </div>
            <div class="side-card" style="border-color: var(--accent-pink);">
                <h4 style="color: #d81b60;">EXPERIENCIAS+</h4>
                <p>Consulta los paquetes VIP disponibles para ID_03</p>
            </div>
        </div>

    </div>

</body>
</html>
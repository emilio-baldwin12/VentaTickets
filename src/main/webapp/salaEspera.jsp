<%-- 
    Document   : salaEspera
    Created on : 6 jun 2026, 10:45:39 p.m.
    Author     : luise
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String idConcierto = request.getParameter("idConcierto");
    if (idConcierto == null || session.getAttribute("idusuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sala de Espera Virtual | Ticketes</title>
    <style>
        body {
            background-color: var(--bg-blue);
            font-family: 'Segoe UI', Tahoma, sans-serif;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .espera-container {
            background: var(--entity-body);
            max-width: 600px;
            margin: 80px auto;
            padding: 50px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            color: var(--entity-header);
        }
        .spinner {
            width: 60px;
            height: 60px;
            border: 6px solid rgba(0,0,0,0.1);
            border-top-color: var(--accent-pink);
            border-radius: 50%;
            animation: girar 1s linear infinite;
            margin: 0 auto 30px auto;
        }
        @keyframes girar {
            to {
                transform: rotate(360deg);
            }
        }
        .posicion-box {
            background: rgba(255,255,255,0.5);
            padding: 20px;
            border-radius: 10px;
            margin-top: 30px;
            border: 2px dashed var(--accent-green);
        }
        .numero-posicion {
            font-size: 48px;
            font-weight: bold;
            color: var(--entity-header);
            margin: 10px 0;
        }
        .alerta {
            color: #d9534f;
            font-size: 14px;
            font-weight: bold;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="img/auxiliares/encabezado.jsp" />

    <div class="espera-container">
        <div class="spinner"></div>
        <h1 style="margin-top: 0;">Estás en la fila virtual</h1>
        <p>Por favor, <strong>no recargues ni cierres esta página</strong>. Tu turno se actualizará automáticamente</p>
        
        <div class="posicion-box">
            <div style="font-size: 14px; text-transform: uppercase; letter-spacing: 1px;">Personas delante de ti:</div>
            <div class="numero-posicion" id="textoPosicion">Calculando...</div>
        </div>

        <p class="alerta">Sera redirigido automáticamente al mapa de asientos cuando sea tu turno</p>
    </div>

    <script>
        const idConcierto = <%= idConcierto %>;
        const textoPosicion = document.getElementById('textoPosicion');
        function consultarEstadoFila() {
            const urlSegura = 'filaEstadoServlet?idConcierto=' + idConcierto + '&t=' + new Date().getTime();

            fetch(urlSegura, { 
                cache: "no-store" 
            })//El navegador NO  debe de guardar cache
                .then(response => response.json()) 
                .then(datos => {
                    
                    if (datos.error) {
                        window.location.href = 'login.jsp';
                        return;
                    }

                    if (datos.puedeComprar === true) {
                        textoPosicion.innerText = "¡ES TU TURNO!";
                        window.location.href = 'concierto_asientos.jsp?id=' + idConcierto;
                    } 
                    else {
                        let personasDelante = datos.posicion - 1; 
                        if (personasDelante < 0) personasDelante = 0;
                        textoPosicion.innerText = personasDelante;
                    }
                })
                .catch(error => console.error('Error al consultar la fila:', error));
        }
        consultarEstadoFila();
        setInterval(consultarEstadoFila, 5000);
    </script>
</body>
</html>
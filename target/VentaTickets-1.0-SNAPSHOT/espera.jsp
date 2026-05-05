<%@page import="datos.filaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. Validar el parámetro del evento
    String idEvParam = request.getParameter("idEvento");
    int evId = (idEvParam != null) ? Integer.parseInt(idEvParam) : 0;

    // 2. Validar la sesión del usuario (evita el error de la línea 4)
    Object idUsObj = session.getAttribute("idUsuario");
    int usId = (idUsObj != null) ? (int)idUsObj : 0;

    // 3. Si algo falta, lo mandamos al inicio para que no explote
    if (evId == 0 || usId == 0) {
        response.sendRedirect("index.jsp");
        return; 
    }

    filaDAO dao = new filaDAO();
    Long posicion = dao.posicion(evId, usId);
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Fila Virtual</title>
    <!-- Se refresca cada 5 segundos para actualizar el lugar -->
    <meta http-equiv="refresh" content="5">
    <style>
        :root {
            --bg-blue: #8EACB8;
            --entity-header: #1A1A1A;
            --entity-body: #E8E2D1;
            --accent-pink: #FFB6C1;
        }

        body { 
            background-color: var(--bg-blue); 
            font-family: 'Segoe UI', sans-serif; 
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }

        .fila-card {
            background: var(--entity-body);
            border: 2px solid var(--entity-header);
            width: 400px;
            text-align: center;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .fila-header {
            background: var(--entity-header);
            color: white;
            padding: 15px;
            font-weight: bold;
        }

        .posicion-contenedor {
            padding: 40px;
        }

        .numero-lugar {
            font-size: 80px;
            font-weight: bold;
            color: var(--entity-header);
            margin: 20px 0;
        }

        .status-bar {
            background: var(--accent-pink);
            padding: 10px;
            font-weight: bold;
            font-size: 14px;
            border-top: 2px solid var(--entity-header);
        }
    </style>
</head>
<body>

    <div class="fila-card">
        <div class="fila-header">
            FILA_VIRTUAL :: EVENTO_<%= evId %>
        </div>
        
        <div class="posicion-contenedor">
            <p>TU POSICIÓN ACTUAL:</p>
            <div class="numero-lugar">
                <%= (posicion != null) ? (posicion + 1) : "..." %>
            </div>
            <p>No cierres esta pestaña.<br>Estamos procesando tu acceso.</p>
        </div>

        <% 
            // Si ya es el primero (posición 0), lo mandamos a comprar
            if (posicion != null && posicion == 0) { 
        %>
            <div class="status-bar" style="background-color: #90EE90;">
                ¡ES TU TURNO! Redireccionando...
            </div>
            <script>
                setTimeout(function(){ window.location.href = "compra.jsp?idEvento=<%= evId %>"; }, 2000);
            </script>
        <% } else { %>
            <div class="status-bar">
                ACTUALIZANDO LUGAR...
            </div>
        <% } %>
    </div>

</body>
</html>
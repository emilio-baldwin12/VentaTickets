<%-- 
    Document   : solicitar concierto
    Created on : 4 jun 2026, 10:08:55 p.m.
    Author     : luise
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    String rolUser = (String) session.getAttribute("tipousuario");

    if (nombreUser == null || !"ARTISTA".equals(rolUser)) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Solicitar Concierto | Tickets</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #E8E2D1;
            margin: 0;
        }
        .form-container {
            max-width: 600px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h1 {
            color: #1A1A1A;
            margin-top: 0;
            border-bottom: 2px solid #eee;
            padding-bottom: 10px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #333;
        }
        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
        }
        textarea {
            resize: vertical;
            height: 100px;
        }
        .btn-submit {
            background-color: #3483fa;
            color: white;
            padding: 15px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            width: 100%;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn-submit:hover {
            background-color: #2968c8;
        }
    </style>
</head>
<body>
    <jsp:include page="img/auxiliares/encabezado.jsp" />

    <div class="form-container">
        <h1>Proponer Nuevo Concierto</h1>
        <p style="color: #666; margin-bottom: 25px;">Llena los datos de tu evento. El administrador revisara tu solicitud</p>
        
        <form action="solicitudServlet" method="POST">
            <input type="hidden" name="accion" value="nueva_solicitud">
            
            <div class="form-group">
                <label for="nombre">Nombre del Tour o Evento:</label>
                <input type="text" id="nombre" name="nombre_evento" required placeholder="Ej. The Tour">
            </div>
            
            <div class="form-group">
                <label for="fecha">Fecha Tentativa:</label>
                <input type="date" id="fecha" name="fecha_propuesta" required>
            </div>
            
            <div class="form-group">
                <label for="ciudad">Ciudad Propuesta:</label>
                <input type="text" id="ciudad" name="ciudad_propuesta" required placeholder="Ej. Ciudad de México">
            </div>
            
            <div class="form-group">
                <label for="descripcion">Descripcion:</label>
                <textarea id="descripcion" name="descripcion" placeholder="Detalles extra sobre el tipo de show, aforo esperado, etc."></textarea>
            </div>
            
            <button type="submit" class="btn-submit">Enviar Solicitud al Administrador</button>
        </form>
    </div>
</body>
</html>

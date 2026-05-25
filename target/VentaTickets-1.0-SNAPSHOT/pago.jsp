<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUser = (String) session.getAttribute("nombreusuario");

    String idConcierto = request.getParameter("idConcierto");
    String asientosSeleccionados = request.getParameter("asientosSeleccionados");
    String precioFijo = request.getParameter("precio");
    String totalPagar = request.getParameter("totalPagar");

    if(idConcierto == null || asientosSeleccionados == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    int cantidadBoletos = asientosSeleccionados.split(",").length;
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Pago</title>
    <style>
        :root {
            --bg-blue: #8EACB8;
            --entity-header: #1A1A1A;
            --entity-body: #E8E2D1;
            --accent-pink: #FFB6C1;
            --accent-green: #90EE90;
        }
        body { 
            background-color: var(--bg-blue); 
            font-family: 'Segoe UI', Tahoma, sans-serif; 
            margin: 0; 
            color: #333;
        }

        .main-header {
            background-color: var(--entity-header);
            color: white;
            padding: 0 40px;
            display: flex;
            flex-direction: column; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.4);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .header-top { 
            display: flex;
            justify-content: space-between;
            align-items: center;
            height: 70px; 
        }
        .logo {
            font-size: 30px;
            font-weight: bold; 
            color: white; 
            text-decoration: none; 
            letter-spacing: 2px; 
        }
        .user-actions {
            display: flex;
            align-items: center;
            gap: 20px; 
        }
        .action-item {
            display: flex;
            align-items: center; 
            gap: 8px; 
            color: white;
            text-decoration: none; 
            font-size: 13px;
            font-weight: bold; 
            text-transform: uppercase;
            cursor: pointer; 
        }
        .action-item:hover {
            color: var(--accent-pink);
        }
        .search-btn { 
            background: #2A2A2A;
            padding: 8px 15px; 
            border-radius: 4px;
            border: 1px solid #444;
            color: #888; 
            font-size: 12px; 
        }
        .main-nav { 
            border-top: 1px solid #333;
            display: flex; 
            justify-content: flex-start; 
        }
        .nav-links { 
            display: flex;
            gap: 30px; 
            list-style: none;
            margin: 0; 
            padding: 12px 0;
        }
        .nav-links a {
            color: white; 
            text-decoration: none;
            font-size: 14px;
            font-weight: bold; 
            text-transform: uppercase;
        }
        .nav-links a:hover {
            color: var(--accent-pink);
        }

        .page-layout { 
            display: flex; 
            gap: 30px; 
            max-width: 1000px;
            margin: 50px auto; 
            align-items: stretch;
        }
        .col-resumen {
            flex: 1;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        .col-pago {
            flex: 1;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        h2 { color: var(--entity-header); margin-top: 0; margin-bottom: 25px; text-transform: uppercase;}
        
        .detalle-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
            font-size: 15px;
        }
        .total-row {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
            padding-top: 15px;
            font-weight: bold;
            font-size: 24px;
            color: var(--entity-header);
            border-top: 2px dashed #ccc;
        }

        .btn-pago {
            background: #f8f9fa;
            border: 2px solid #e0e0e0;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 15px;
            font-size: 16px;
            font-weight: bold;
            color: #333;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: space-between;
            text-align: left;
        }
        .btn-pago:hover {
            border-color: var(--entity-header);
            background: #fff;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .icono-pago {
            height: 35px; 
            width: auto;
            object-fit: contain;
        }
    </style>
</head>
<body>

    <header class="main-header">
        <div class="header-top">
            <a href="index.jsp" class="logo">TICKETS</a>
            <div class="user-actions">
                <a href="#" class="action-item search-btn">BUSCAR ARTISTA O EVENTO</a>
                <a href="notificaciones.jsp" class="action-item">NOTIFICACIONES</a>
                <a href="#" class="action-item">PERFIL <%= (nombreUser != null) ? "▾" : "" %></a>
                <a href="configuracion.jsp" class="action-item">CONFIGURACIÓN</a>
                <% if(nombreUser == null) { %>
                    <a href="login.jsp" class="action-item" style="color: var(--accent-green)">INGRESA</a>
                <% } else { %>
                    <span class="action-item" style="color: var(--accent-pink)"><%= nombreUser.toUpperCase() %></span>
                <% } %>
            </div>
        </div>
        <nav class="main-nav">
            <ul class="nav-links">
                <li><a href="index.jsp">INICIO</a></li>
                <li><a href="conciertos.jsp" style="color: var(--accent-pink);">CONCIERTOS</a></li>
                <li><a href="artista.jsp">ARTISTAS</a></li>
                <li><a href="productos.jsp">PRODUCTOS</a></li>
            </ul>
        </nav>
    </header>

    <form id="formFinal" action="boletoServlet" method="POST" style="display: none;">
        <input type="hidden" name="idConcierto" value="<%= idConcierto %>">
        <input type="hidden" name="precio" value="<%= precioFijo %>">
        <input type="hidden" name="asientosSeleccionados" value="<%= asientosSeleccionados %>">
        <input type="hidden" name="metodoPago" id="inputMetodo">
    </form>

        <div class="page-layout">

            <div class="col-resumen">
                <h2>Resumen de Compra</h2>

                <div class="detalle-item">
                    <span>Asientos seleccionados:</span>
                    <strong><%= cantidadBoletos %></strong>
                </div>
                <div class="detalle-item">
                    <span>Precio por boleto:</span>
                    <span>$ <%= precioFijo %> MXN</span>
                </div>

                <div class="total-row">
                    <span>Total:</span>
                    <span>$ <%= totalPagar %> MXN</span>
                </div>
            </div>

            <div class="col-pago">
                <h2>Método de Pago</h2>
                <p style="color: #666; font-size: 14px; margin-top: -15px; margin-bottom: 25px;">Selecciona una opción para finalizar tu reserva</p>

                <button class="btn-pago" onclick="procesarPago('CREDITO')">
                    <span>Tarjeta de Crédito</span>
                    <img src="${pageContext.request.contextPath}/img/auxiliares/credito.jpg" class="icono-pago">
                </button>

                <button class="btn-pago" onclick="procesarPago('DEBITO')">
                    <span>Pago con PayPal</span>
                    <img src="${pageContext.request.contextPath}/img/auxiliares/paypal.jpg" class="icono-pago">
                </button>

                <button class="btn-pago" onclick="procesarPago('OXXO')">
                    <span>Pago en Efectivo (OXXO)</span>
                    <img src="${pageContext.request.contextPath}/img/auxiliares/oxxo.jpg" class="icono-pago">
                </button>
            </div>

        </div>
        <form id="formFinalizarPago" action="transaccion.jsp" method="POST" style="display: none;">
            <input type="hidden" name="metodoPago" id="inputMetodoPago">
            <input type="hidden" name="idConcierto" value="<%= request.getParameter("idConcierto") %>">
            <input type="hidden" name="asientosSeleccionados" value="<%= request.getParameter("asientosSeleccionados") %>">
            <input type="hidden" name="totalPagar" value="<%= request.getParameter("totalPagar") %>">
        </form>

        <script>
            function procesarPago(metodo) {
                document.getElementById('inputMetodoPago').value = metodo;
                document.getElementById('formFinalizarPago').submit();
            }
        </script>
</body>
</html>
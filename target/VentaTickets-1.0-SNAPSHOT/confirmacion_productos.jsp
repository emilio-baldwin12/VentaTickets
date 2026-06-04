<%-- 
    Document   : confirmacion_productos
    Created on : 2 jun 2026, 11:30:45 p.m.
    Author     : luise
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("nombreusuario") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String total = (String) session.getAttribute("ultimoTotal");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tickets | Compra Confirmada</title>
    <style>
        body {
            background-color: #8EACB8;
            font-family: 'Segoe UI', Tahoma, sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .confirm-box {
            background: white;
            padding: 40px;
            border-radius: 15px;
            width: 500px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .success-icon {
            font-size: 70px;
            color: #2e7d32;
            margin-bottom: 15px;
        }
        h2 { 
            color: #1A1A1A;
            margin-top: 0; 
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        p { 
            color: #555;
            font-size: 15px;
            line-height: 1.6;
        }
        
        .total-paid {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            margin: 25px 0;
            border: 1px solid #eee;
            font-size: 18px;
            font-weight: bold;
            color: #1A1A1A;
        }
        .btn-home {
            display: inline-block;
            background: #1A1A1A;
            color: white;
            text-decoration: none;
            padding: 14px 35px;
            font-weight: bold;
            border-radius: 8px;
            text-transform: uppercase;
            font-size: 14px;
            transition: background 0.2s;
        }
        .btn-home:hover { 
            background: #333;
        }
    </style>
</head>
<body>
    <div class="confirm-box">
        <div class="success-icon">✓</div>
        <h2>¡Compra Confirmada!</h2>
        <p>Tu pago ha sido procesado con éxito. El inventario se ha actualizado en el almacén de la base de datos y tus artículos están listos para su distribución.</p>
        
        <% if(total != null) { %>
            <div class="total-paid">
                TOTAL PAGADO: $ <%= String.format("%,.2f", Double.parseDouble(total)) %> MXN
            </div>
        <% } %>
        
        <a href="productos.jsp" class="btn-home">Volver a la Tienda</a>
    </div>
</body>
</html>

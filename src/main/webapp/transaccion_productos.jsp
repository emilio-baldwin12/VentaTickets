<%-- 
    Document   : transaccion_productos
    Created on : 2 jun 2026, 11:23:01 p.m.
    Author     : luise
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("nombreusuario") == null) {
        response.sendRedirect("index.jsp");
        return; 
    }

    if (session.getAttribute("carritoProductos") == null) {
        response.sendRedirect("productos.jsp");
        return;
    }

    String total = request.getParameter("totalPagar");
    String metodo = request.getParameter("metodoPago");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tickets | Transacción de Mercancía</title>
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
            .card-container {
                background: white;
                padding: 40px;
                border-radius: 15px;
                width: 450px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-group label {
                display: block;
                font-size: 12px;
                font-weight: bold;
                color: #1A1A1A;
                margin-bottom: 8px;
                text-transform: uppercase;
            }
            .form-group input {
                width: 100%;
                padding: 12px;
                border: 1px solid #ccc;
                border-radius: 6px;
                box-sizing: border-box;
                font-size: 15px;
            }
            .btn-pagar {
                background: #1A1A1A;
                color: white;
                border: none;
                padding: 15px;
                width: 100%;
                font-weight: bold;
                border-radius: 8px;
                cursor: pointer;
                font-size: 16px;
                margin-top: 10px;
            }
            .btn-pagar:hover {
                background: #333;
            }
            .order-summary {
                background: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 25px;
                border: 1px solid #eee;
            }
        </style>
    </head>
    <body>

        <div class="card-container">
            <h2 style="margin-top: 0; color: #1A1A1A;">Finalizar Pago</h2>
            
            <div class="order-summary">
                <span style="font-size: 13px; color: #666; font-weight: bold;">TOTAL A CARGAR:</span>
                <h2 style="margin: 5px 0 0 0; color: #1A1A1A;">$ <%= total != null ? String.format("%,.2f", Double.parseDouble(total)) : "0.00" %> MXN</h2>
                <small style="color: #888;">Método: <%= metodo != null ? metodo : "Seleccionado" %></small>
            </div>

            <form action="carritoServlet" method="POST">
                <input type="hidden" name="accion" value="finalizarCompraProductos">
                <input type="hidden" name="total" value="<%= total %>">
                <input type="hidden" name="metodoPago" value="<%= metodo %>">

                <div class="form-group">
                    <label>Titular de la Cuenta</label>
                    <input type="text" required placeholder="Nombre completo">
                </div>

                <div class="form-group">
                    <label>Número de Referencia / Tarjeta</label>
                    <input type="text" id="numeroTarjeta" required placeholder="0000 0000 0000 0000" maxlength="19">
                </div>

                <div style="display: flex; gap: 20px;">
                    <div class="form-group" style="flex: 1;">
                        <label>Vencimiento</label>
                        <input type="text" id="fechaVencimiento" required placeholder="MM/YY" maxlength="5">
                    </div>
                    <div class="form-group" style="flex: 1;">
                        <label>CVV / NIP</label>
                        <input type="password" required placeholder="123" maxlength="3">
                    </div>
                </div>

                <button type="submit" class="btn-pagar">PAGAR AHORA</button>
            </form>
        </div>

    </body>
    <script>
        document.getElementById('fechaVencimiento').addEventListener('input', function (e) {
                let valor = e.target.value.replace(/\D/g, '');
                if (valor.length > 2) {
                    valor = valor.slice(0, 2) + '/' + valor.slice(2, 4);
                }
                e.target.value = valor;
            });
    </script>
</html>
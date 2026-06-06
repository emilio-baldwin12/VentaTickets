<%-- 
    Document   : reventa_formulario
    Created on : 5 jun 2026, 10:19:23 p.m.
    Author     : luise
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    if (nombreUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String idBoleto = request.getParameter("id_bol");
    String precioOriginalStr = request.getParameter("precio_orig");
    double precioOriginal = 0;
    
    if (precioOriginalStr != null) {
        precioOriginal = Double.parseDouble(precioOriginalStr);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Poner Boleto en Reventa | Ticketes</title>
    <style>
        body { 
            font-family: 'Segoe UI', Tahoma, sans-serif;
            background-color: #E8E2D1; 
            margin: 0; 
        }
        .container { 
            max-width: 700px; 
            margin: 50px auto;
            background: white; 
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        h1 { 
            color: #1A1A1A;
             border-bottom: 2px solid #eee;
             padding-bottom: 10px; 
             margin-top: 0; 
        }
        
        .caja-legal { 
            background-color: #f8f9fa; 
            border: 1px solid #ddd; 
            padding: 20px; 
            height: 150px; 
            overflow-y: scroll; 
            border-radius: 6px;
            font-size: 13px;
            color: #555;
            margin-bottom: 20px;
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
        input[type="number"], 
        textarea { 
            width: 100%; 
            padding: 12px; 
            border: 1px solid #ddd; 
            border-radius: 6px;
            box-sizing: border-box;
        }
        
        .alerta-precio { 
            background-color: #e8f4fd;
            color: #0056b3;
            padding: 10px;
            border-radius: 6px; 
            font-size: 13px;
            margin-bottom: 20px; 
            border-left: 4px solid #3483fa;
        }
        
        .checkbox-group {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 25px;
        }
        .checkbox-group input { 
            margin-top: 4px;
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
            transition: 0.3s;
        }
        .btn-submit:hover {
            background-color: #2968c8;
        }
    </style>
</head>
<body>
    <jsp:include page="img/auxiliares/encabezado.jsp" />

    <div class="container">
        <h1>Transferencia Segura (De Fan a Fan)</h1>
        <p style="color: #666;">Ingresa tu boleto al mercado secundario oficial de Ticketes.</p>
        
        <div class="alerta-precio">
            <strong>Protección al Consumidor:</strong> Por normativas de reventa digital, el precio máximo que puedes establecer está limitado al valor de compra original del boleto <strong>($<%= precioOriginal %>)</strong>.
        </div>

        <div class="caja-legal">
            <strong>TÉRMINOS Y CONDICIONES DE REVENTA</strong><br><br>
            1. <strong>Finalidad:</strong> Esta plataforma busca facilitar la transferencia de boletos entre fans, prohibiendo el lucro comercial (Scalping).<br>
            2. <strong>Límite de Precio:</strong> El vendedor acepta de conformidad que el sistema bloquee el ingreso de cantidades superiores al precio facial del boleto.<br>
            3. <strong>Garantía de Autenticidad:</strong> Al aceptar, el sistema anulará el código de barras original en su poder y generará uno nuevo exclusivamente para el comprador final.<br>
            4. <strong>Cobro de Tarifas:</strong> Ticketes retendrá una comisión operativa del 5% del valor final de la transacción por el servicio de intermediación segura.<br>
            5. <strong>Cancelación:</strong> Puede retirar su boleto del mercado secundario en cualquier momento, siempre y cuando no haya sido adquirido por otro usuario.
        </div>

        <form action="reventaServlet" method="POST">
            <input type="hidden" name="accion" value="publicar">
            <input type="hidden" name="id_boleto" value="<%= idBoleto %>">
            
            <div class="checkbox-group">
                <input type="checkbox" id="acepto" required>
                <label for="acepto" style="font-weight: normal; color: #444; font-size: 14px; cursor: pointer;">
                    He leído y acepto los Términos y Condiciones, y declaro que esta reventa no persigue fines comerciales ilícitos.
                </label>
            </div>

            <div class="form-group">
                <label>Precio de Reventa deseado (Máximo $<%= precioOriginal %>):</label>
                <input type="number" name="precio_nuevo" step="0.01" min="1" max="<%= precioOriginal %>" required placeholder="Ej. <%= precioOriginal %>">
            </div>
            
            <div class="form-group">
                <label>Motivo de la reventa | Opcional, visible para el comprador:</label>
                <textarea name="motivo" placeholder="Ej. Cuestiones de salud, no podré asistir a esa ciudad, etc." style="height: 80px;"></textarea>
            </div>
            
            <button type="submit" class="btn-submit">Publicar en el Mercado</button>
        </form>
    </div>
</body>
</html>
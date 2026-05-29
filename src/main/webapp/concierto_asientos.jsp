<%-- 
    Document   : concierto_asientos
    Created on : 13 may 2026, 11:06:34 p.m.
    Author     : luise
--%>
<%@page import="modelo.concierto"%>
<%@page import="datos.conciertoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    String idParam = request.getParameter("id");
    concierto c = null;

    if (idParam != null && !idParam.isEmpty()) {
        try {
            c = new conciertoDAO().detalleConcierto(Integer.parseInt(idParam));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tickets | Selección de Asientos</title>
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

            .badge {
                background-color: #ff4444;
                color: white;
                border-radius: 50%;
                padding: 2px 7px;
                font-size: 10px;
                margin-left: 5px;
            }

            .page-layout { 
                display: flex; 
                gap: 30px; 
                max-width: 1300px;
                margin: 30px auto; 
                padding: 0 20px; 
                align-items: flex-start;
            }
            .map-side { 
                flex: 1; 
                max-width: 35%;
            }
            .seats-side {
                flex: 2; 
                background: white; 
                border-radius: 15px;
                min-height: 550px; 
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                padding: 40px; 
            }

            .map-container {
                background-color: #000; 
                padding: 15px;
                border-radius: 12px; 
                border: 2px solid #FFD700;
            }
            .fil0 {
                fill: #333; 
                transition: 0.3s; 
                cursor: pointer;
            }
            .fil0:hover { 
                fill: var(--accent-pink) !important;
            }
            .selected { 
                fill: var(--accent-green) !important;
            }
            .str0 { 
                stroke: #fff; 
                stroke-width: 15; 
            }
            #STAGE { 
                fill: #111 !important; 
                cursor: default; 
            }

            .btn-checkout { 
                background: var(--entity-header); 
                color: white; 
                padding: 15px; 
                border: none; 
                border-radius: 8px; 
                width: 100%; 
                font-weight: bold; 
                cursor: pointer; 
                margin-top: 20px; 
            }
            
            .seats-grid-container {
                margin-top: 25px;
                background: #fafafa;
                border: 1px solid #eaeaea;
                border-radius: 12px;
                padding: 25px;
                display: flex;
                flex-direction: column;
                align-items: center;
                gap: 12px;
            }
            .stage-direction {
                width: 70%;
                background: #e0e0e0;
                text-align: center;
                font-size: 11px;
                font-weight: bold;
                padding: 5px;
                border-radius: 4px;
                color: #777;
                margin-bottom: 10px;
                letter-spacing: 1px;
            }
            .seats-rows-holder {
                display: flex;
                flex-direction: column;
                gap: 12px;
                align-items: center;
                margin-bottom: 30px;
            }
            .seats-row {
                display: flex;
                gap: 10px;
                align-items: center;
            }
           .row-name {
                font-weight: bold;
                color: #aaa;
                font-size: 14px;
                width: 25px;
                text-align: center;
            }
            .row-label {
                font-weight: bold;
                color: #999;
                font-size: 14px;
                width: 20px;
                text-align: center;
            }
            .seat-dot {
                width: 22px;
                height: 22px;
                border-radius: 50%;
                background-color: var(--accent-green);
                cursor: pointer;
                transition: transform 0.2s, background-color 0.2s;
            }
            .seat-dot:hover {
                transform: scale(1.3);
                background-color: var(--accent-pink) !important;
            }

            .seat-dot.occupied {
                background-color: #d1d5db !important;
                cursor: not-allowed;
            }
            .seat-dot.occupied:hover {
                transform: none;
            }

            .seat-dot.selected-by-user {
                background-color: #007bff !important;
                box-shadow: 0 0 8px rgba(0, 123, 255, 0.6);
            }
            .seat {
                width: 24px;
                height: 24px;
                border-radius: 50%;
                background-color: #28a745; 
                cursor: pointer;
                transition: all 0.2s ease;
            }
            .seat:hover {
                transform: scale(1.25);
                background-color: var(--accent-pink) !important;
            }
            .seat.occupied {
                background-color: #d6d6d6; 
                cursor: not-allowed;
            }
            .seat.occupied:hover {
                transform: none;
                background-color: #d6d6d6 !important;
            }
            .seat.user-selected {
                background-color: #007bff !important; 
                box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
            }
            .zona-block-header {
                background: var(--entity-header);
                color: white;
                padding: 15px;
                border-radius: 8px;
                text-align: center;
                font-weight: bold;
                font-size: 18px;
                letter-spacing: 1px;
                margin-bottom: 5px;
                text-transform: uppercase;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }
            .stage-indicator-bar {
                width: 100%;
                background: #e5e7eb;
                color: #666;
                text-align: center;
                font-size: 11px;
                font-weight: bold;
                padding: 6px 0;
                border-radius: 4px;
                margin-bottom: 25px;
                letter-spacing: 2px;
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
                    <a href="#" class="action-item">PERFIL <%= (nombreUser != null) ? "" : "" %></a>
                    <a href="configuracion.jsp" class="action-item">CONFIGURACIÓN</a>
                    <% if(nombreUser == null) { %>
                        <a href="login.jsp" class="action-item" style="color: var(--accent-green)">INGRESA</a>
                    <% } else { %>
                        <span class="action-item" style="color: var(--accent-pink)"><%= nombreUser.toUpperCase() %></span>
                    <% } %>
                </div>
            </div>
            <nav class="main-nav">
                <ul class="nav-links" style="align-items: center;">
                    <li><a href="index.jsp">INICIO</a></li>
                    <li><a href="conciertos.jsp" style="color: var(--accent-pink);">CONCIERTOS</a></li>
                    <li><a href="artista.jsp">ARTISTAS</a></li>
                    <li><a href="productos.jsp">PRODUCTOS</a></li>
                    <% if(nombreUser != null) { %>
                        <li style="display: flex; align-items: center;">
                            <a href="carrito.jsp" style="color: var(--accent-green); position: relative; display: flex; align-items: center; gap: 6px;">
                                <img src="img/auxiliares/carrito.png" alt="Carrito" style="width: 20px; height: auto;">
                                <span id="header-cart-count" class="badge" style="position: absolute; top: -10px; right: -20px;">0</span>
                            </a>
                        </li>
                    <% } %>
                </ul>
            </nav>
        </header>

        <div class="page-layout">
            <div class="map-side">
                <div class="map-container">
                    <% 
                        if(c != null && c.getrutamapa() != null) { 
                            String rutaFinal = "estadios/" + c.getrutamapa();
                    %>
                            <jsp:include page="<%= rutaFinal %>" />
                    <% } else { %>
                            <div style="color: white; text-align: center; padding: 50px;">
                                Estadio No Disponible Por Ahora
                            </div>
                    <% } %>
                </div>
            </div>

            <div class="seats-side">
                <div id="placeholder-info" style="text-align: center; margin-top: 150px; color: #888;">
                    <h2>Selecciona una zona en el mapa</h2>
                    <p>Haz clic en cualquier sección para abrir los lugares</p>
                </div>

                <div id="detalle-seleccion" style="display: none; text-align: center;">

                    <h1 id="txt-seccion" style="margin: 0 0 5px 0; color: var(--entity-header); font-size: 32px; font-weight: bold; text-transform: uppercase;">-</h1>
                    <p style="color: #666; margin: 0 0 20px 0; font-size: 14px;">
                    </p>

                    <div id="seats-rows-holder" class="seats-rows-holder"></div>

                        <div id="carrito-container" style="display: none; background: #f9f9f9; padding: 20px; border-radius: 10px; margin-top: 20px; text-align: left; border: 1px solid #eee;">
                            <h3 style="margin: 0 0 15px 0; font-size: 16px; color: var(--entity-header);">TUS ASIENTOS:</h3>
                            <ul id="lista-carrito" style="list-style: none; padding: 0; margin: 0; margin-bottom: 15px;">
                                </ul>
                            <hr style="border-top: 1px dashed #ccc; margin-bottom: 15px;">
                            <div style="display: flex; justify-content: space-between; align-items: center;">
                                <span style="font-size: 14px; font-weight: bold; color: #666;">TOTAL A PAGAR:</span>
                                <h2 style="margin: 0; color: var(--entity-header);">$ <span id="txt-total-carrito">0.00</span> MXN</h2>
                            </div>
                        </div>

                        <div style="background: #f9f9f9; padding: 20px; border-radius: 10px; margin-top: 15px; display: flex; justify-content: space-between; align-items: center; text-align: left;">
                            <div>
                                <span style="font-size: 11px; color: #666; font-weight: bold;">PRECIO</span>
                                <h3 style="margin: 2px 0; color: #333;">$ <span id="txt-precio">0.00</span> MXN</h3>
                            </div>
                            <% if (nombreUser == null) { %>
                                <button type="button" onclick="window.location.href='login.jsp'" class="btn-checkout" style="margin: 0; width: auto; padding: 12px 30px; background: #ff4444;">INICIA SESIÓN PARA COMPRAR</button>
                            <% } else { %>
                                <button type="button" id="btn-procesar-compra" class="btn-checkout" style="margin: 0; width: auto; padding: 12px 30px;">IR AL PAGO -></button>
                            <% } %>       
                        </div>
                    </div>
                </div>

                <form id="formCompra" action="pago.jsp" method="POST" style="display: none;">
                    <input type="hidden" name="idConcierto" value="<%= idParam %>">
                    <input type="hidden" name="precio" id="inputPrecio">
                    <input type="hidden" name="asientosSeleccionados" id="inputAsientos">
                    <input type="hidden" name="totalPagar" id="inputTotal">
                </form>    
        <script>
                window.carritoGlobal = [];
                window.floorDisponibles = [];
                window.floorIdLimpio = '';
                window.floorTotal = 0;
                window.actualizarCarrito = function() {
                    const listaCarrito = document.getElementById('lista-carrito');
                    const contenedorCarrito = document.getElementById('carrito-container');
                    const txtTotalCarrito = document.getElementById('txt-total-carrito');

                    listaCarrito.innerHTML = '';
                    if (window.carritoGlobal.length === 0) {
                        contenedorCarrito.style.display = 'none';
                        txtTotalCarrito.innerText = '0.00';
                        return;
                    }
                    contenedorCarrito.style.display = 'block';
                    let total = 0;
                    window.carritoGlobal.forEach(item => {
                        let li = document.createElement('li');
                        li.style.padding = "8px 0";
                        li.style.fontSize = "14px";
                        li.style.display = "flex";
                        li.style.justifyContent = "space-between";
                        li.style.borderBottom = "1px solid #eee";
                        li.innerHTML = '<span><strong>ZONA ' + item.zona + '</strong> - Fila ' + item.fila + ', Asiento ' + item.numero + '</span> ' +
                                       '<span>$ ' + item.precio.toLocaleString() + '</span>';

                        listaCarrito.appendChild(li);
                        total += item.precio;
                    });
                    if(listaCarrito.lastChild) {
                        listaCarrito.lastChild.style.borderBottom = "none";
                    }
                    txtTotalCarrito.innerText = total.toLocaleString();
                };

                window.renderFloorUI = function() {
                    const rowsHolder = document.getElementById('seats-rows-holder');
                    let actualesEnCarrito = window.carritoGlobal.filter(function(item) { 
                        return item.zona === window.floorIdLimpio; 
                    }).length;
                    let lugaresRestantes = window.floorDisponibles.length - actualesEnCarrito;
                    
                    rowsHolder.innerHTML = '<div style="background:#f8f9fa; padding:25px; border-radius:12px; border:2px solid #ccc; text-align:center; box-shadow: 0 4px 10px rgba(0,0,0,0.05);">' +
                                               '<h3 style="margin-top:0; color:#1A1A1A; font-size: 22px;">ENTRADA GENERAL (PISTA)</h3>' +
                                           '<p style="font-size:16px; color:#666;">Lugares disponibles: <strong style="color:#28a745;">' + lugaresRestantes + '</strong> de ' + window.floorTotal + '</p>' +
                            
                                            '<div style="display:flex; justify-content:center; align-items:center; gap:25px; margin-top:20px;">' +
                                                '<button type="button" onclick="window.modificarFloor(-1)" style="padding:10px 25px; font-size:26px; font-weight:bold; cursor:pointer; border-radius:8px; border:none; background:#ff4444; color:white; transition:0.2s;">-</button>' +
                                                '<span style="font-size:32px; font-weight:bold; min-width:40px; color:#1A1A1A;">' + actualesEnCarrito + '</span>' +
                                                '<button type="button" onclick="window.modificarFloor(1)" style="padding:10px 25px; font-size:26px; font-weight:bold; cursor:pointer; border-radius:8px; border:none; background:#28a745; color:white; transition:0.2s;">+</button>' +
                                            '</div>' +
                                        '</div>';
                };

                window.modificarFloor = function(cambio) {
                    let actuales = window.carritoGlobal.filter(function(item) { return item.zona === window.floorIdLimpio; });
                    if (cambio === 1) {
                        if (actuales.length >= window.floorDisponibles.length) {
                            alert("Ya no hay más lugares disponibles en la pista");
                            return;
                        }
                        let asientoLibre = window.floorDisponibles.find(function(a) { 
                            return !window.carritoGlobal.some(function(c) { 
                                return c.id === a.id; 
                            }); 
                        });
                        if (asientoLibre) {
                            window.carritoGlobal.push({
                                id: asientoLibre.id,
                                zona: window.floorIdLimpio,
                                fila: 'GEN',
                                numero: actuales.length + 1,
                                precio: asientoLibre.precio
                            });
                        }
                    } else if (cambio === -1) {
                        if (actuales.length > 0) {
                            let lastItem = actuales[actuales.length - 1]; 
                            window.carritoGlobal = window.carritoGlobal.filter(function(item) { return item.id !== lastItem.id; });
                        }
                    }
                    window.actualizarCarrito();
                    window.renderFloorUI();
                };
                document.addEventListener("DOMContentLoaded", function() {
                    document.getElementById('btn-procesar-compra')?.addEventListener('click', function(){
                        if(window.carritoGlobal.length === 0){
                            alert("Selecciona al menos un asiento para agregarlo al carrito.");
                            return;
                        }

                        // Obtenemos los IDs y los unimos con comas
                        let ids = window.carritoGlobal.map(item => item.id).join(',');

                        // Hacemos una petición POST silenciosa al Servlet
                        fetch('agregarCarritoServlet', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: 'asientos=' + ids
                        })
                        .then(response => response.json())
                        .then(data => {
                            if(data.success) {
                                // 1. Actualizamos el número rojo en el encabezado
                                const badge = document.getElementById('header-cart-count');
                                if(badge) badge.innerText = data.totalItems;
                                
                                alert("¡Asientos guardados exitosamente en tu carrito!");
                                
                                // 2. Opcional: Limpiamos la selección actual para que siga comprando
                                window.carritoGlobal = [];
                                window.actualizarCarrito();
                                
                                // Limpiamos las bolitas verdes del mapa
                                document.querySelectorAll('.seat-dot.selected-by-user').forEach(s => {
                                    s.classList.remove('selected-by-user');
                                });
                                
                                if(typeof window.renderFloorUI === 'function') {
                                    window.renderFloorUI();
                                }
                            } else {
                                alert("Error al agregar al carrito: " + data.error);
                            }
                        })
                        .catch(error => {
                            console.error("Fetch error:", error);
                            alert("Hubo un problema de conexión con el servidor.");
                        });
                    });
                });
            </script>
    </body>
</html>









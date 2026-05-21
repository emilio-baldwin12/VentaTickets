<%-- 
    Document   : concierto_asientos
    Created on : 13 may 2026, 11:06:34 p.m.
    Author     : luise
--%>
<%@page import="modelo.artista"%>
<%@page import="datos.artistaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nombreUser = (String) session.getAttribute("nombreusuario");
    String idParam = request.getParameter("id");
    artista a = null;
    int pendientes = 0; 

    if (idParam != null && !idParam.isEmpty()) {
        try {
            a = new artistaDAO().obtenerPerfil(Integer.parseInt(idParam));
        } catch (Exception e) {
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

        <div class="page-layout">
            <div class="map-side">
                <div class="map-container">
                    <svg viewBox="2000 0 28000 20000" xmlns="http://www.w3.org/2000/svg" style="width: 100%; height: auto;">
                        <g id="capa-estadio">
                                <polygon id="FLOOR" class="fil0 str0" points="12052.03,9178.2 12162.35,8638.83 12787.53,8222.05 18168.93,8209.79 18156.67,11347.92 12824.3,11360.18 12284.93,11065.98 12052.03,10440.8 12554.62,10440.8 12566.88,9141.42 "/>
                                <polygon id="_111" class="fil0 str0" points="13892.9,4979.98 15129.39,4979.98 15118.73,7953.96 13892.9,7985.94 "/>
                                <polygon id="_112" class="fil0 str0" points="15193.35,5310.42 15204.01,8039.24 16834.9,8017.92 16845.56,5299.76 "/>
                                <polygon id="_113" class="fil0 str0" points="16888.2,5001.3 18135.36,4990.64 18146.02,7985.94 16952.16,7996.6 "/>
                                <polygon id="_114" class="fil0 str0" points="19190.64,4979.98 18199.31,4979.98 18199.31,7996.6 19105.37,7985.94 19222.62,7165.16 "/>
                                <polygon id="_115" class="fil0 str0" points="20363.18,6877.36 20032.74,6653.51 20011.42,6813.4 19382.51,6642.85 19265.26,6674.83 19286.58,4969.32 19606.36,4969.32 20629.67,5246.46 21098.68,5523.61 "/>
                                <polygon id="_116" class="fil0 str0" points="21557.04,4894.7 20395.16,6888.02 20650.99,7026.59 21141.32,7527.58 21311.87,7815.39 23347.82,6674.83 23028.04,6131.2 22100.67,5182.51 "/>
                                <polygon id="_117" class="fil0 str0" points="21365.17,7943.3 23411.78,6706.81 23635.63,7090.55 23998.05,8359.02 24051.35,9158.48 21674.29,9147.82 21695.61,8806.72 21503.74,8199.13 "/>
                                <polygon id="_118" class="fil0 str0" points="21706.27,9243.75 23838.16,9201.12 23859.48,10341.68 21695.61,10362.99 "/>
                                <polygon id="_119" class="fil0 str0" points="21695.61,10458.93 24030.03,10416.29 24051.35,10991.9 23731.56,12260.38 23379.8,12878.62 21354.51,11716.74 21567.7,11333 21716.93,10768.05 "/>
                                <polygon id="_120" class="fil0 str0" points="20373.84,12644.11 20768.24,13358.3 21226.6,13038.51 21748.91,12494.88 21951.44,12132.46 21279.89,11716.74 21162.64,12047.19 20736.26,12441.59 "/>
                                <polygon id="_121" class="fil0 str0" points="19233.28,12239.06 19755.59,12036.53 20107.35,12857.3 20331.2,12718.73 21108.14,14061.2 20612.64,14344.34 19641.86,14607.26 19318.27,14597.15 19277.82,12544.36 "/>
                                <polygon id="_122" class="fil0 str0" points="18185.69,12514.02 19207.03,12534.24 19166.58,14566.81 18205.91,14587.04 "/>
                                <polygon id="_101" class="fil0 str0" points="16911.54,11614.03 17690.19,11603.91 17659.85,12514.02 18114.9,12534.24 18125.02,14576.93 16891.32,14607.26 "/>
                                <polygon id="_102" class="fil0 str0" points="15192.45,11603.91 16790.19,11624.14 16830.64,14283.67 15202.56,14293.78 "/>
                                <polygon id="_103" class="fil0 str0" points="13887.97,11593.8 15131.78,11603.91 15111.55,14587.04 13908.19,14587.04 "/>
                                <polygon id="_104" class="fil0 str0" points="12411.57,11462.34 12735.17,11593.8 13827.29,11614.03 13827.29,14617.37 12441.91,14607.26 11380.12,14324.12 10925.07,14081.42 "/>
                                <polygon id="_105" class="fil0 str0" points="9388,12524.13 11956.52,11037.63 12007.08,11078.08 11359.89,11634.25 11713.82,11998.29 12077.87,11452.23 12280.11,11543.24 10864.39,14000.53 10409.34,13737.61 9640.81,12969.07 "/>
                                <polygon id="_106" class="fil0 str0" points="8750.92,10441 11774.5,10461.23 11814.95,10693.81 11946.41,10956.73 9337.44,12453.35 9064.41,11988.18 8801.49,11017.4 "/>
                                <polygon id="_107" class="fil0 str0" points="8771.15,9197.19 11784.61,9217.42 11804.84,10339.88 8761.04,10339.88 "/>
                                <polygon id="_108" class="fil0 str0" points="9317.21,7124.17 11481.24,8367.98 11400.34,8489.33 11845.28,8752.25 11784.61,9116.29 8801.49,9116.29 8801.49,8570.23 9054.29,7609.56 "/>
                                <polygon id="_109" class="fil0 str0" points="9377.89,7063.5 9590.24,6638.78 10389.11,5850.03 10837.99,5564.67 12031.25,7597.25 11899.79,7728.72 11657.09,7415.23 11252.6,7809.61 11535.74,8092.76 11444.73,8234.33 "/>
                                <polygon id="_110" class="fil0 str0" points="10918.89,5534.33 11384.06,5261.3 12324.51,4968.04 13800.91,4998.38 13821.13,7961.3 12840.23,7961.3 12698.66,8062.42 12466.08,7566.92 12193.04,7688.27 "/>
                                <polygon id="_201" class="fil0 str0" points="17591.06,16863.96 19615.19,16856.73 19622.42,19488.11 17569.37,19495.33 "/>
                                <polygon id="_202" class="fil0 str0" points="16029.58,16871.19 17518.77,16892.88 17475.39,19480.88 16036.81,19488.11 "/>
                                <polygon id="_203" class="fil0 str0" points="14511.48,16871.19 15957.29,16863.96 15964.52,19473.65 14518.71,19495.33 "/>
                                <polygon id="_204" class="fil0 str0" points="12400.6,16871.19 14424.74,16856.73 14439.19,19480.88 12415.06,19480.88 "/>
                                <polygon id="_205" class="fil0 str0" points="10419.84,16654.32 11171.66,16871.19 12328.31,16871.19 12321.08,19495.33 10875.27,19473.65 9776.46,19170.03 "/>
                                <polygon id="_206" class="fil0 str0" points="8901.74,16047.08 9624.65,16473.59 10318.64,16639.86 9675.25,19141.11 8627.04,18880.87 7622.2,18295.31 "/>
                                <polygon id="_207" class="fil0 str0" points="8843.91,15989.25 7557.14,18259.17 6631.82,17731.45 5786.02,16900.11 7636.66,15049.47 8193.29,15627.79 "/>
                                <polygon id="_208" class="fil0 str0" points="6639.05,13777.16 6993.27,14427.77 7571.6,14977.18 5728.19,16842.27 4925.76,16039.85 4361.9,15063.93 "/>
                                <polygon id="_209" class="fil0 str0" points="3487.18,12916.9 6010.12,12273.51 6169.16,12989.19 6566.76,13675.95 4347.44,14977.18 3769.12,14044.63 "/>
                                <polygon id="_210" class="fil0 str0" points="3154.65,10661.44 5793.25,10661.44 5764.33,11413.26 6010.12,12165.08 3472.73,12851.84 3169.11,11818.08 "/>
                                <polygon id="_211" class="fil0 str0" points="3161.88,9056.59 5793.25,9042.13 5771.56,10553 3169.11,10553 "/>
                                <polygon id="_212" class="fil0 str0" points="3451.04,6736.06 6010.12,7437.28 5793.25,8109.58 5778.79,8912.01 3169.11,8969.84 3169.11,7769.82 "/>
                                <polygon id="_213" class="fil0 str0" points="4340.21,4581.81 3769.12,5528.81 3472.73,6642.08 6010.12,7350.53 6205.31,6577.02 6610.13,5904.72 "/>
                                <polygon id="_214" class="fil0 str0" points="4361.9,4509.52 6646.28,5846.89 7022.19,5152.9 7571.6,4610.72 5720.96,2752.86 4904.08,3576.97 "/>
                                <polygon id="_215" class="fil0 str0" points="5786.02,2702.25 6552.3,1964.89 7520.99,1357.65 8829.45,3576.97 8186.07,3960.11 7636.66,4545.66 "/>
                                <polygon id="_216" class="fil0 str0" points="7600.51,1299.82 8619.81,714.26 9668.02,425.1 10333.09,2948.04 9668.02,3143.22 8952.35,3548.05 "/>
                                <polygon id="_217" class="fil0 str0" points="9754.77,410.64 10412.61,2926.35 11084.91,2738.4 12321.08,2723.94 12335.54,107.02 10817.44,114.25 "/>
                                <polygon id="_218" class="fil0 str0" points="12393.37,99.8 14424.74,107.02 14431.96,2723.94 12407.83,2723.94 "/>
                                <polygon id="_219" class="fil0 str0" points="14518.71,107.02 16007.9,99.8 15993.44,2738.4 14533.17,2738.4 "/>
                                <polygon id="_220" class="fil0 str0" points="16072.96,114.25 16058.5,2738.4 17533.23,2745.63 17533.23,114.25 "/>
                                <polygon id="_221" class="fil0 str0" points="17612.75,135.94 19622.42,121.48 19622.42,2731.17 17598.29,2731.17 "/>
                                <polygon id="_222" class="fil0 str0" points="19694.71,114.25 21169.44,107.02 22275.48,410.64 21624.87,2933.58 20887.51,2738.4 19716.4,2723.94 "/>
                                <polygon id="_223" class="fil0 str0" points="22369.46,439.56 23424.9,721.49 24444.2,1292.59 23121.28,3555.28 22427.29,3136 21689.93,2955.27 "/>
                                <polygon id="_224" class="fil0 str0" points="23215.26,3598.66 24502.03,1379.34 25470.72,1914.29 26258.69,2709.48 24386.37,4523.97 23851.42,3974.57 "/>
                                <polygon id="_225" class="fil0 str0" points="24444.2,4610.72 26323.75,2781.77 27118.95,3540.82 27639.44,4495.06 25383.97,5832.43 25029.75,5131.21 "/>
                                <polygon id="_226" class="fil0 str0" points="25449.04,5919.18 27704.5,4596.26 28275.59,5564.96 28543.07,6634.86 26012.9,7379.45 25817.72,6548.11 "/>
                                <polygon id="_227" class="fil0 str0" points="26056.28,7437.28 28586.44,6714.38 28868.38,7762.59 28875.61,8926.46 26244.23,8955.38 26251.46,8131.27 "/>
                                <polygon id="_228" class="fil0 str0" points="26229.77,9020.44 28868.38,9042.13 28890.06,10567.46 26237,10574.69 "/>
                                <polygon id="_229" class="fil0 str0" points="26246.37,10676.06 28865.94,10647.38 28885.06,11804.2 28588.68,12874.97 26045.6,12177.06 26265.49,11393.1 "/>
                                <polygon id="_230" class="fil0 str0" points="26007.35,12263.1 28540.88,12941.89 28254.07,14041.35 27690,14978.27 25424.16,13716.29 25835.26,12999.26 "/>
                                <polygon id="_231" class="fil0 str0" points="24458.56,14978.27 25032.18,14395.08 25366.8,13783.21 27670.88,15064.31 27135.49,16020.36 26303.73,16842.56 "/>
                                <polygon id="_232" class="fil0 str0" points="23167.89,15972.56 23808.44,15618.82 24372.51,15045.19 26255.93,16890.36 25414.6,17712.56 24487.24,18238.39 "/>
                                <polygon id="_233" class="fil0 str0" points="21657.34,16603.55 22412.61,16431.46 23120.09,16010.8 24429.87,18295.75 23397.34,18888.5 22355.25,19165.75 "/>
                                <polygon id="_234" class="fil0 str0" points="19697.44,16880.8 20844.7,16852.12 21580.85,16660.91 22288.33,19137.07 21160.19,19500.37 19697.44,19471.68 "/>
                                <polygon id="STAGE" class="fil0 str0" points="18459.69,8402.01 20940.11,8409.44 20932.68,11172.06 18481.97,11179.49 "/>
<%--                            <polygon id="LOGES" class="fil0 str0" points="12211.94,4162.3 10923.18,4572.36 10091.34,5076.15 9072.05,5990 8462.81,6974.15 7994.17,8391.79 7970.74,11039.61 8310.5,12386.95 8978.32,13523.41 9903.88,14425.54 11063.77,15093.35 12258.81,15444.84 19651.62,15444.84 21057.54,15069.92 21631.63,14718.44 21666.78,14870.75 22287.72,14530.99 22838.38,13956.9 23260.15,13593.7 23553.06,13031.33 23389.03,12879.03 23728.8,12328.37 24045.13,11098.19 24068.56,10395.23 24021.7,8344.92 23646.78,7149.89 23025.83,6118.88 22170.56,5181.6 21057.54,4560.65 19792.21,4162.3 "/>
                                <polygon id="MIX" class="fil0 str0" points="11942.47,9317.35 12446.26,9317.35 12446.26,10278.07 11942.47,10301.5 "/>
                                <polygon id="SUITES" class="fil0 str0" points="11843.86,2978.98 20654.31,2943.84 22235.97,3342.18 23712.19,4185.73 24848.65,5357.34 25633.62,6763.26 26020.25,8204.33 26043.68,11285.65 25657.05,12855.59 24813.5,14249.8 23688.76,15397.97 22341.42,16182.95 20841.76,16604.72 11796.99,16628.15 10297.34,16253.24 8856.27,15421.4 7719.81,14238.08 6946.56,12925.89 6524.78,11379.37 6513.06,8239.48 6969.99,6669.53 7790.11,5263.61 8797.69,4244.31 10203.61,3424.19 "/>
--%>                                
                        </g>
                    </svg>
                </div>
            </div>

            <div class="seats-side">
                <div id="placeholder-info" style="text-align: center; margin-top: 150px; color: #888;">
                    <h2>Selecciona una zona en el mapa</h2>
                    <p>Haz clic en cualquier sección para abrir los lugares.</p>
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
                                <span style="font-size: 11px; color: #666; font-weight: bold;">PRECIO UNITARIO</span>
                                <h3 style="margin: 2px 0; color: #333;">$ <span id="txt-precio">0.00</span> MXN</h3>
                            </div>
                            <button class="btn-checkout" style="margin: 0; width: auto; padding: 12px 30px;">IR AL PAGO -></button>
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
                let carritoGlobal = [];

                function actualizarCarrito() {
                    const listaCarrito = document.getElementById('lista-carrito');
                    const contenedorCarrito = document.getElementById('carrito-container');
                    const txtTotalCarrito = document.getElementById('txt-total-carrito');

                    listaCarrito.innerHTML = '';
                    if (carritoGlobal.length === 0) {
                        contenedorCarrito.style.display = 'none';
                        txtTotalCarrito.innerText = '0.00';
                        return;
                    }

                    contenedorCarrito.style.display = 'block';
                    let total = 0;

                    carritoGlobal.forEach(item => {
                        let li = document.createElement('li');
                        li.style.padding = "8px 0";
                        li.style.fontSize = "14px";
                        li.style.display = "flex";
                        li.style.justifyContent = "space-between";
                        li.style.borderBottom = "1px solid #eee";

                        li.innerHTML = `<span><strong>ZONA ${item.zona}</strong> - Fila ${item.fila}, Asiento ${item.num}</span> 
                                        <span>$ ${item.precio.toLocaleString()}</span>`;

                        listaCarrito.appendChild(li);
                        total += item.precio;
                    });

                    if(listaCarrito.lastChild) {
                        listaCarrito.lastChild.style.borderBottom = "none";
                    }

                    txtTotalCarrito.innerText = total.toLocaleString();
                }

                document.querySelectorAll('.fil0').forEach(seccion => {
                    seccion.addEventListener('click', function(e) {
                        e.preventDefault();
                        e.stopPropagation();

                        if(this.id === 'STAGE' || this.id === 'MIX') {
                            return;
                        }

                        document.querySelectorAll('.fil0').forEach(s => s.classList.remove('selected'));
                        this.classList.add('selected');

                        document.getElementById('placeholder-info').style.display = 'none';
                        document.getElementById('detalle-seleccion').style.display = 'block';

                        let idLimpio = this.id.replace('_', '');
                        let precio = (idLimpio === 'FLOOR') ? 2500 : 1500;

                        document.getElementById('txt-seccion').innerText = "ZONA " + idLimpio;
                        document.getElementById('txt-precio').innerText = precio.toLocaleString();

                        const rowsHolder = document.getElementById('seats-rows-holder');
                        rowsHolder.innerHTML = ''; 

                        const filas = ['A', 'B', 'C', 'D', 'E'];

                        let prefijoZona = isNaN(parseInt(idLimpio)) ? 90 : parseInt(idLimpio);

                        filas.forEach((letraFila, indexFila) => {
                            const rowDiv = document.createElement('div');
                            rowDiv.className = 'seats-row';

                            const leftLabel = document.createElement('div');
                            leftLabel.className = 'row-name';
                            leftLabel.innerText = letraFila;
                            rowDiv.appendChild(leftLabel);

                            for(let i = 1; i <= 10; i++) {
                                const seat = document.createElement('div');

                                let idAsientoFake = (prefijoZona * 1000) + ((indexFila + 1) * 100) + i;

                                let yaSeleccionado = carritoGlobal.find(item => item.id === idAsientoFake);

                                const isOccupied = Math.random() < 0.30; 

                                if(isOccupied && !yaSeleccionado) {
                                    seat.className = 'seat-dot occupied';
                                } else {
                                    seat.className = yaSeleccionado ? 'seat-dot selected-by-user' : 'seat-dot';

                                    seat.addEventListener('click', function() {
                                        if (this.classList.contains('selected-by-user')) {
                                            this.classList.remove('selected-by-user');
                                            carritoGlobal = carritoGlobal.filter(item => item.id !== idAsientoFake);
                                        } else {
                                            this.classList.add('selected-by-user');
                                            carritoGlobal.push({
                                                id: idAsientoFake,
                                                zona: idLimpio,
                                                fila: letraFila,
                                                num: i,
                                                precio: precio
                                            });
                                        }
                                        actualizarCarrito();
                                    });
                                }
                                rowDiv.appendChild(seat);
                            }

                            const rightLabel = document.createElement('div');
                            rightLabel.className = 'row-name';
                            rightLabel.innerText = letraFila;
                            rowDiv.appendChild(rightLabel);

                            rowsHolder.appendChild(rowDiv);
                        });
                    });
                });

                document.querySelector('.btn-checkout').addEventListener('click', function(){
                    if(carritoGlobal.length === 0){
                        alert("Por favor, selecciona un asiento para continuar al pago");
                        return;
                    }

                    let ids = carritoGlobal.map(item => item.id);

                    let precioText = document.getElementById('txt-precio').innerText.replace(/,/g, '');
                    let totalText = document.getElementById('txt-total-carrito').innerText.replace(/,/g, '');

                    const inputAsientos = document.getElementById('inputAsientos');
                    const inputPrecio = document.getElementById('inputPrecio');
                    const inputTotal = document.getElementById('inputTotal');
                    const form = document.getElementById('formCompra');

                    if(inputAsientos && inputPrecio && form){
                        inputAsientos.value = ids.join(',');
                        inputPrecio.value = precioText; 
                        inputTotal.value = totalText;

                        form.submit();
                    }
                });
            </script>
    </body>
</html>









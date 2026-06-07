<%-- 
    Document   : configuracion
    Created on : 6 jun 2026, 3:36:51 p.m.
    Author     : luise
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Configuración de Accesibilidad | Ticketes</title>
    
    <style>
        body { 
            background-color: var(--bg-blue); 
            font-family: 'Segoe UI', Tahoma, sans-serif; 
            margin: 0; 
            color: var(--entity-header);
            transition: background-color 0.4s ease, color 0.4s ease;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            background: var(--entity-body);
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            transition: background-color 0.4s ease;
        }
        h1 { border-bottom: 2px solid var(--accent-pink); padding-bottom: 10px; }
        
        .config-section {
            background: rgba(255, 255, 255, 0.4);
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            border-left: 5px solid var(--accent-green);
        }

        /* Botones de Tema */
        .btn-theme {
            padding: 15px 20px;
            border: 2px solid transparent;
            border-radius: 8px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            margin-right: 10px;
            margin-bottom: 10px;
            transition: 0.2s;
        }
        
        .btn-sadgirl {
            background: #8EACB8; 
            color: #1A1A1A;
        }
        .btn-showgirl { 
            
            background: #7AB99A; 
            color: #E8643E; 
        }
        .btn-fotos { 
            background: #08391F;
            color: #F5F5F5;
        }
        
        .btn-theme:hover, .btn-theme.activo {
            transform: translateY(-3px);
            box-shadow: 0 5px 10px rgba(0,0,0,0.3);
            border-color: var(--accent-pink);
            opacity: 0.9;
        }
        .switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }
        .slider:before {
            position: absolute;
            content: "";
            height: 26px; width: 26px;
            left: 4px; bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        
        input:checked + .slider { 
            background-color: var(--accent-green);
        }
        input:checked + .slider:before { 
            transform: translateX(26px);
        }
    </style>
</head>
<body>
    <jsp:include page="img/auxiliares/encabezado.jsp" />

    <div class="container">
        <h1> Configuración y Accesibilidad</h1>
        
        <div class="config-section">
            <h2 style="margin-top: 0; color: var(--entity-header);">Accesibilidad de Lectura</h2>
            <p style="color: #444;">Activa la tipografía de alta legibilidad para reducir la fatiga visual y facilitar la lectura en caso de dislexia</p>
            
            <div style="display: flex; align-items: center; gap: 15px;">
                <label class="switch">
                    <input type="checkbox" id="toggleDislexia" onchange="cambiarFuente()">
                    <span class="slider"></span>
                </label>
                <strong id="textoEstadoFuente" style="color: var(--entity-header);">Fuente para Dislexia: Desactivado</strong>
            </div>
        </div>

        <div class="config-section">
            <h2 style="margin-top: 0; color: var(--entity-header);">Apariencia del Sistema</h2>
            <p style="color: #444;">Elige la Estetica que más te guste para navegar</p>
            
            <button class="btn-theme btn-sadgirl" onclick="cambiarTema('tema-sadgirl')">You seem pretty sad ...</button>
            <button class="btn-theme btn-showgirl" onclick="cambiarTema('tema-showgirl')">The Life of a Showgirl</button>
            <button class="btn-theme btn-fotos" onclick="cambiarTema('tema-fotos')">Debí tirar más fotos</button>
        </div>
    </div>

    <script>
        const toggleDislexia = document.getElementById('toggleDislexia');
        const textoEstado = document.getElementById('textoEstadoFuente');

        function cambiarFuente() {
            if (toggleDislexia.checked) {
                document.body.classList.add('fuente-dislexia');
                localStorage.setItem('preferencia-fuente', 'activa');
                textoEstado.innerText = "Fuente para Dislexia: Activado";
            } else {
                document.body.classList.remove('fuente-dislexia');
                localStorage.setItem('preferencia-fuente', 'inactiva');
                textoEstado.innerText = "Fuente para Dislexia: Desactivado";
            }
        }

        function cambiarTema(nombreTema) {
            document.body.classList.remove('tema-sadgirl', 'tema-showgirl', 'tema-fotos');
            document.body.classList.add(nombreTema);
            localStorage.setItem('preferencia-tema', nombreTema);
        }
        window.onload = function() {
            if (localStorage.getItem('preferencia-fuente') === 'activa') {
                toggleDislexia.checked = true;
                cambiarFuente();
            }
        };
    </script>
</body>
</html>
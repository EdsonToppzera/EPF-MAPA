% import json
% saved_points_json = json.dumps([p.to_dict() for p in points])

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mapa: Falha na infraestrutura</title>
    
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
    
    <!-- css -->
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <!-- Botão para ativar modo de adicionar pontos -->
    <button id="addBtn">Adicionar ponto</button>

    <!-- pesquisa -->
    <a href="/map/search" id="searchBtn" style="
        position: absolute;
        top: 10px;
        left: 50%;
        transform: translateX(60px); /* Desloca para o lado do outro botão */
        z-index: 1000;
        padding: 10px 16px;
        font-size: 14px;
        border-radius: 4px;
        background-color: #FF9800; /* Cor Laranja para diferenciar */
        color: white;
        text-decoration: none;
        font-family: Arial, sans-serif;
    ">Pesquisar</a>


    <!-- Container do mapa -->
    <div id="map"></div>

    <!-- Biblioteca Leaflet para o mapa -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <script>
        // Pontos salvos vindos do servidor
        const savedPoints = JSON.parse('{{!saved_points_json}}');

        // add pontos ou nn
        let adding = false;

        //mapa centrado no brasil
        const map = L.map('map').setView([-14.235, -51.9253], 6);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);


        savedPoints.forEach(p => {
            L.marker([p.lat, p.lng])
             .addTo(map)
             .bindPopup(`<b>${p.name}</b><br>${p.description}`);
        });

        // Botão de adicionar pontos
        const addBtn = document.getElementById('addBtn');

        //alternar modo de adicionar pontos
        addBtn.addEventListener('click', () => {
            adding = !adding;
            addBtn.textContent = adding ? 'Cancelar' : 'Adicionar ponto';
            map.getContainer().style.cursor = adding ? 'crosshair' : '';
        });

        map.on('click', (e) => {
            if (!adding) return;

            const { lat, lng } = e.latlng;

            //cria formulário HTML
            const formHTML = `
                <form id="pointForm" action="/map/add" method="POST">
                    <input type="hidden" name="lat" value="${lat}">
                    <input type="hidden" name="lng" value="${lng}">

                    <label>Nome</label>
                    <input type="text" name="name" placeholder="Digite o nome" autofocus required>

                    <label>Descrição</label>
                    <textarea name="description" placeholder="Digite a descrição"></textarea>

                    <div class="form-actions">
                        <button type="submit">Salvar</button>
                        <button type="button" id="cancelBtn">Cancelar</button>
                    </div>
                </form>
            `;

            const popup = L.popup()
                .setLatLng([lat, lng])
                .setContent(formHTML)
                .openOn(map);

            // Aguarda o popup ser renderizado para adicionar eventos visuais
            setTimeout(() => {
                const form = document.getElementById('pointForm');
                const cancelBtn = document.getElementById('cancelBtn');

                form.addEventListener('submit', () => {
                    adding = false;
                    addBtn.textContent = 'Adicionar ponto';
                    map.getContainer().style.cursor = '';
                });

                // Evento de cancelar
                cancelBtn.addEventListener('click', () => {
                    map.closePopup();
                    adding = false;
                    addBtn.textContent = 'Adicionar ponto';
                    map.getContainer().style.cursor = '';
                });
            }, 0);
        });
    </script>
</body>
</html>
% import json
% saved_points_json = json.dumps([p.to_dict() for p in points])

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>NoteMap Mapa</title>
    
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
    
    <!-- css -->
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
    <!-- Botão para ativar modo de adicionar pontos -->
    <button id="addBtn">Adicionar ponto</button>

    <!-- botao de pesquisa -->
    <a href="/map/search" id="searchBtn">Pesquisar pontos</a>


    <!-- Container do mapa -->
    <div id="map"></div>

    <!-- Biblioteca Leaflet para o mapa -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <script>
        // Pontos salvos vindos do servidor
        const savedPoints = JSON.parse('{{!saved_points_json}}');

        // add pontos ou nn
        let adding = false;

        // Lê a URL para pegar a coordenada
        const params = new URLSearchParams(window.location.search);
        const lat = params.get('lat');
        const lng = params.get('lng');

        // Se nn tiver a informacao da coordenada, centraliza no brasil
        const center = (lat && lng) ? [lat, lng] : [-14.235, -51.9253];
        const zoom = (lat && lng) ? 15 : 6;

        const map = L.map('map').setView(center, zoom);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

                // macete pra mudar as cores do marcadores
                savedPoints.forEach(p => {
                    let iconUrl = 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-blue.png';
                    
                    if (p.color === 'red') {
                        iconUrl = 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png';
                    } else if (p.color === 'green') {
                        iconUrl = 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png';
                    } else if (p.color === 'gold') {
                        iconUrl = 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-gold.png';
                    }

                    const customIcon = L.icon({
                        iconUrl: iconUrl,
                        shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
                        iconSize: [25, 41],
                        iconAnchor: [12, 41],
                        popupAnchor: [1, -34],
                        shadowSize: [41, 41]
                    });

                    L.marker([p.lat, p.lng], {icon: customIcon})
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

                const userType = "{{current_user.tipo if current_user else 'user'}}"; 
                
                let colorInputHTML = '';

                // Se for premium, mostra o SELECT
                if (userType === 'user_premium') {
                    colorInputHTML = `
                        <label style="color: #FFD700; font-weight: bold;">Cor do Marcador {Premium}</label>
                        <select name="color" style="width: 100%; padding: 5px; margin-bottom: 10px;">
                            <option value="blue">Azul (Padrão)</option>
                            <option value="red">Vermelho</option>
                            <option value="green">Verde</option>
                            <option value="gold">Dourado</option>
                        </select>
                    `;
                } else {
                    colorInputHTML = `<input type="hidden" name="color" value="blue">`;
                }

                // Cria formulário HTML
                const formHTML = `
                    <form id="pointForm" action="/map/add" method="POST">
                        <input type="hidden" name="lat" value="${lat}">
                        <input type="hidden" name="lng" value="${lng}">

                        <label>Nome</label>
                        <input type="text" name="name" placeholder="Digite o nome" autofocus required>

                        <label>Descrição</label>
                        <textarea name="description" placeholder="Digite a descrição"></textarea>

                        <!-- AQUI ENTRA O SELETOR DE COR -->
                        ${colorInputHTML}

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
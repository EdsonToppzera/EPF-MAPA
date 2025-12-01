% import json
% saved_points_json = json.dumps([p.to_dict() for p in points])

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mapa de Falhas</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
    <style>
        #map { height: 500px; width: 100%; }
        .form-actions { margin-top: 10px; }
    </style>
</head>
<body>
    <h1>Mapa de Falhas na Infraestrutura</h1>
    <button id="addBtn">Adicionar ponto</button>
    <div id="map"></div>

    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <script>
        // 1. Inicializa mapa
        const map = L.map('map').setView([-14.235, -51.9253], 4);
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '© OpenStreetMap'
        }).addTo(map);

        // 2. Pontos vindos do servidor (Bottle já gerou o JSON)
        // esse json.parse transfroma json em objeto, basicamente pra parar de dar um erro q tava dando antes
        const savedPoints = JSON.parse('{{!saved_points_json}}');

        savedPoints.forEach(p => {
            L.marker([p.lat, p.lng])
             .addTo(map)
             .bindPopup(`<b>${p.name}</b><br>${p.description}`);
        });

        // 3. Lógica de adicionar pontos
        let adding = false;
        const addBtn = document.getElementById('addBtn');

        addBtn.addEventListener('click', () => {
            adding = !adding;
            addBtn.textContent = adding ? 'Cancelar' : 'Adicionar ponto';
            map.getContainer().style.cursor = adding ? 'crosshair' : '';
        });

        map.on('click', (e) => {
            if (!adding) return;

            const { lat, lng } = e.latlng;

            const formHTML = `
                <form action="/map/add" method="POST">
                    <input type="hidden" name="lat" value="${lat}">
                    <input type="hidden" name="lng" value="${lng}">
                    
                    <label>Nome</label><br>
                    <input type="text" name="name" required autofocus><br>
                    
                    <label>Descrição</label><br>
                    <textarea name="description"></textarea><br>

                    <div class="form-actions">
                        <button type="submit">Salvar</button>
                    </div>
                </form>
            `;

            L.popup()
             .setLatLng([lat, lng])
             .setContent(formHTML)
             .openOn(map);
        });
    </script>
</body>
</html>

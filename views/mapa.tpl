<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>mapa falhas na infraestrutura</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <button id="addBtn">Adicionar ponto</button>

    <div id="map"></div>

    <!-- Leaflet -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <script>
        // Variável para controlar se estamos no modo de adicionar pontos
        let adding = false;

        // Centrado no Brasil
        const map = L.map('map').setView([-14.235, -51.9253], 6);

        // Adiciona camada de tiles do OpenStreetMap
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Referência ao botão
        const addBtn = document.getElementById('addBtn');

        // Função para alternar modo de adicionar pontos
        addBtn.addEventListener('click', () => {
            adding = !adding;
            addBtn.textContent = adding ? 'Cancelar' : 'Adicionar ponto';
            map.getContainer().style.cursor = adding ? 'crosshair' : '';
        });

        // Evento de clique no mapa
        map.on('click', (e) => {
            if (!adding) return;

            const { lat, lng } = e.latlng;

            // Cria formulário HTML
            const formHTML = `
                <form id="pointForm">
                    <label>Nome</label>
                    <input type="text" name="name" placeholder="Digite o nome" autofocus>

                    <label>Descrição</label>
                    <textarea name="description" placeholder="Digite a descrição"></textarea>

                    <div class="form-actions">
                        <button type="submit">Salvar</button>
                        <button type="button" id="cancelBtn">Cancelar</button>
                    </div>
                </form>
            `;

            // Cria popup no local clicado
            const popup = L.popup()
                .setLatLng([lat, lng])
                .setContent(formHTML)
                .openOn(map);

            // Aguarda o popup ser renderizado para adicionar eventos
            setTimeout(() => {
                const form = document.getElementById('pointForm');
                const cancelBtn = document.getElementById('cancelBtn');

                // Evento de submit do formulário
                form.addEventListener('submit', (e) => {
                    e.preventDefault();
                    // Adiciona marcador no mapa
                    L.marker([lat, lng]).addTo(map);
                    // Fecha popup e desativa modo de adição
                    map.closePopup();
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
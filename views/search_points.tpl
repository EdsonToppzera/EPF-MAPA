<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="utf-8">
    <title>Pesquisar Pontos</title>
    <link rel="stylesheet" href="/static/css/styles.css">
    <style>
        /* css dessa pagina */
        .container { max-width: 800px; margin: 20px auto; padding: 20px; }
        .search-box { display: flex; gap: 10px; margin-bottom: 20px; }
        .search-box input { flex: 1; padding: 10px; font-size: 16px; }
        .point-card { 
            border: 1px solid white; 
            padding: 15px; 
            margin-bottom: 10px; 
            border-radius: 8px; 
            background: rgb(219, 224, 227);
        }
        
        .back-btn { 
            display: inline-block; 
 
            padding: 8px 16px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            background-color: #2196F3;
            color: white;
            cursor: pointer;
            text-decoration: none;
            font-family: Arial, sans-serif;
        }
        .back-btn:hover {
            background-color: #1976D2;
        }
    </style>

</head>
<body>
    <div class="container">
        <a href="/map" class="back-btn">Voltar para o Mapa</a>
        
        <h1 style="font-family: Arial, sans-serif;">Pesquisar Pontos</h1>
        
        <!-- Formulário de Pesquisa (envia para a mesma URL via GET) -->
        <form action="/map/search" method="GET" class="search-box">
            <input type="text" name="q" value="{{query}}" placeholder="Digite o nome do ponto..." autofocus>
            <button type="submit" class="back-btn">Buscar</button>
        </form>

        <!-- Lista de Resultados -->
        <div class="results">
            % if not points:
                <p>Nenhum ponto encontrado.</p>
            % else:
                % for p in points:
                    <div class="point-card">
                        <!-- O link envia lat/lng para a rota do mapa -->
                        <h3>
                            <a href="/map?lat={{p.lat}}&lng={{p.lng}}&zoom=15" style="text-decoration: none; color: #2196F3;">
                                {{p.name}}
                            </a>
                        </h3>
                        <p>{{p.description}}</p>
                        <small>Lat: {{p.lat}}, Lng: {{p.lng}}</small>
                    </div>
                % end
            % end
        </div>
    </div>
</body>
</html>

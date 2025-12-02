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
            border: 1px solid #ddd; 
            padding: 15px; 
            margin-bottom: 10px; 
            border-radius: 8px; 
            background: #f9f9f9;
        }
        .back-btn { 
            display: inline-block; 
            margin-bottom: 20px; 
            text-decoration: none; 
            color: #2196F3; 
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="/map" class="back-btn">Voltar para o Mapa</a>
        
        <h1>Pesquisar Pontos</h1>
        
        <!-- Formulário de Pesquisa (envia para a mesma URL via GET) -->
        <form action="/map/search" method="GET" class="search-box">
            <input type="text" name="q" value="{{query}}" placeholder="Digite o nome do ponto..." autofocus>
            <button type="submit" style="background: #2196F3; color: white; border: none; padding: 0 20px; cursor: pointer;">Buscar</button>
        </form>

        <!-- Lista de Resultados -->
        <div class="results">
            % if not points:
                <p>Nenhum ponto encontrado.</p>
            % else:
                % for p in points:
                    <div class="point-card">
                        <h3>{{p.name}}</h3>
                        <p>{{p.description}}</p>
                        <small>Lat: {{p.lat}}, Lng: {{p.lng}}</small>
                    </div>
                % end
            % end
        </div>
    </div>
</body>
</html>

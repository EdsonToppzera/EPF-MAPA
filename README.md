# Projeto Template: POO com Python + Bottle + JSON

Este é um projeto de template educacional voltado para o ensino de **Programação Orientada a Objetos (POO)** do Prof. Lucas Boaventura, Universidade de Brasília (UnB).

Utiliza o microframework **Bottle**. Ideal para uso em disciplinas introdutórias de Engenharia de Software ou Ciência da Computação.

## 💡 Objetivo

Este projeto é uma aplicação web desenvolvida com o framework Bottle em Python, focada em permitir que usuários façam anotações e as vinculem a localizações geográficas em um mapa, facilitando a organização contextual de informações.

---

## 🗂 Estrutura de Pastas

```bash
EPF-MAPA/
├── controllers/          # Controladores (Rotas e lógica de interação com serviços)
├── ├── __init__.py
│   ├── authenticator_controller.py  # Gerencia login, registro, home, logout
│   ├── base_controller.py
│   ├── point_controller.py          # (Futura) Gerencia a visualização e criação de pontos
│   └── user_controller.py
├── data/                 # Armazenamento de dados (JSON)
│   ├── points.json
│   └── users.json
├── models/               # Modelos de Dados (Classes de objetos)
│   ├── point.py
│   └── user.py
├── services/             # Lógica de Negócio (Camada de serviço)
│   ├── session_state.py
│   ├── point_service.py
│   └── user_service.py              # Gerencia autenticação e registro
├── static/               # Arquivos Estáticos
│   ├── css/              # style.css, helper.css
│   ├── img/              # Imagens do projeto
│   └── js/               # Arquivos JavaScript
│── views/                # Templates HTML (.tpl)
    ├── account/          # Templates relacionados à autenticação
      ├── login.tpl     # Formulário de Login.
      └── registro.tpl  # Formulário de Cadastro.
    ├── helper-final.tpl  
    ├── home.tpl          # Página de Boas-vindas (Home Page).
    ├── layout.tpl        
    ├── map.tpl           # Página principal para visualização e interação com o mapa.
    ├── search_points.tpl 
    ├── user_form.tpl     
    ├── users.tpl
└── main.py
```


---

## 📁 Descrição das Pastas

### `controllers/`
Contém as classes responsáveis por lidar com as rotas da aplicação. Exemplos:
- `user_controller.py`: rotas para listagem, adição, edição e remoção de usuários.
- `base_controller.py`: classe base com utilitários comuns.

### `models/`
Define as classes que representam os dados da aplicação. Exemplo:
- `user.py`: classe `User`, com atributos como `id`, `name`, `email`, etc.

### `services/`
Responsável por salvar, carregar e manipular dados usando arquivos JSON. Exemplo:
- `user_service.py`: contém métodos como `get_all`, `add_user`, `delete_user`.

### `views/`
Contém os arquivos `.tpl` utilizados pelo Bottle como páginas HTML:
- `layout.tpl`: estrutura base com navegação e bloco `content`.
- `users.tpl`: lista os usuários.
- `user_form.tpl`: formulário para adicionar/editar usuário.

### `static/`
Arquivos estáticos como:
- `css/style.css`: estilos básicos.
- `js/main.js`: scripts JS opcionais.
- `img/BottleLogo.png`: exemplo de imagem.

### `data/`
Armazena os arquivos `.json` que simulam o banco de dados:
- `users.json`: onde os dados dos usuários são persistidos.

---

## ▶️ Como Executar

1. Crie o ambiente virtual na pasta fora do seu projeto:
```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\\Scripts\\activate     # Windows
```

2. Entre dentro do seu projeto criado a partir do template e instale as dependências:
```bash
pip install -r requirements.txt
```

3. Rode a aplicação:
```bash
python main.py
```

4. Accese sua aplicação no navegador em: [http://localhost:8080](http://localhost:8080)

---

## ✍️ Personalização
Para adicionar novos modelos (ex: Atividades):

1. Crie a classe no diretório **models/**.

2. Crie o service correspondente para manipulação do JSON.

3. Crie o controller com as rotas.

4. Crie as views .tpl associadas.

---

## 🧠 Autor e Licença
Projeto desenvolvido como template didático para disciplinas de Programação Orientada a Objetos, baseado no [BMVC](https://github.com/hgmachine/bmvc_start_from_this).
Você pode reutilizar, modificar e compartilhar livremente.

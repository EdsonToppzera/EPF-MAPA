<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - NoteMap</title>
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>

    <div class="container-login">

        <!-- Left Side -->

        <div class="painel-esquerdo">
            <div class="content">
                <h2 class="login-title">SEJA BEM-VINDO DE VOLTA!</h2>
                <p class="login-subtitle">Acesse sua conta para continuar organizando suas anotações.</p>
            </div>
            <img src="/static/img/LocaLoginRegistro.gif" class="side-img">
        </div>

        <!-- Right Side  -->
        
        <div class="painel-direito">
            <div class="form-container">
                <div class="header-login">
                    <img src="/static/img/logoLgnn.png" class="logo-notemap">
                    <h1 class="text-login">Faça login na sua conta</h1>
                </div>

                <form action="/login" method="post" class="login-form">
                    <div>
                        <label>Email</label>
                        <div class="input-wrapper">
                            <i class="bi bi-envelope-fill input-icon"></i>
                            <input type="email" name="email" placeholder="email@gmail.com">
                        </div>
                    </div>
                    
                    <div>
                        <label>Password</label>
                        <div class="input-wrapper">
                            <i class="bi bi-lock-fill input-icon"></i>
                            <input type="password" name="password" placeholder="••••••••••">
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-login">Acessar conta</button>
                </form>

                <a href="/registro" class="link">Não é cadastrado? REGISTRE-SE</a>
            </div>
        </div>
    </div>
</body>
</html>

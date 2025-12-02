<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NoteMap - Registro</title>
    <link rel="stylesheet" href="/static/css/style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
      
  <div class="container-registro">

        <!-- LEFT SIDE -->

        <div class="painel-esquerdo-reg">
            <div class="content-reg">
                <h1 class="registro-title">Organize suas ideias com facilidade</h1>
                <p class="registro-subtitle">Registre-se para ter acesso ao NoteMap e simplificar seu dia a dia.</p>
            </div>

            <img src="/static/img/LocaRegistro.gif" class="side-img-reg">
        </div>

        <!-- RIGHT SIDE -->
        <div class="painel-direito-reg">

            <div class="form-container-reg">

                <div class="header-registro">
                    <img src="/static/img/logoLgnn.png" class="logo-notemap">
                    <h1 class="text-registro">Criar nova conta</h1>
                </div>

                <form action="/registro" method="post" class="registro-form">

                    <div>
                        <label>Nome</label>
                        <div class="input-wrapper">
                            <i class="bi bi-person-fill input-icon"></i>
                            <input type="text" name="name" placeholder="Nome">
                        </div>
                    </div>

                    <div>
                        <label>Email</label>
                        <div class="input-wrapper">
                            <i class="bi bi-envelope-fill input-icon"></i>
                            <input type="email" name="email" placeholder="email@gmail.com">
                        </div>
                    </div>

                    <div>
                        <label>Senha</label>
                        <div class="input-wrapper">
                            <i class="bi bi-lock-fill input-icon"></i>
                            <input type="password" name="password" placeholder="••••••••••">
                        </div>
                    </div>

                    <button type="submit" class="btn-login">Criar conta</button>

                </form>

                <a href="/login" class="link">Já possui uma conta? Faça login</a>

            </div>
        </div>
  </div>

</body>
</html>

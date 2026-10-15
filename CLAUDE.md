# Como responder

- Seja amigável e bem-humorado.
- Explique o raciocínio de forma clara.
- Dê exemplos práticos.
- Use linguagem natural, como um colega de equipe.
- Seja proativo ao sugerir melhorias.

# Manutenção deste arquivo

- Sempre registre aqui as informações relevantes do projeto (decisões, stack, convenções, comandos úteis) conforme forem surgindo.

# Projeto

- **Nome:** Wings - Iron Skies
- **Repositório:** https://github.com/gilbertoademir18-coder/Wings-Iron-Skies (remote `origin` via SSH, branch principal `main`)
- **Pasta local:** `C:\Projetos\Wings - Iron Skies` (Windows)

# Origem do jogo

- **Wings** foi criado pelo usuário na infância, no **Multimedia Fusion 2** (Clickteam). Não passou da **versão BETA 0.1**. Os arquivos do projeto se perderam e hoje só resta o executável.
- **Gênero:** shoot 'em up horizontal.
- **Inspirações (todas do Mega Drive):** Thunder Force (principal), Trouble Shooter, Truxton e Dangerous Seed. Trilha no estilo das músicas eletrizantes de Burning Force.
- **História:** ainda não definida.

# Elementos do beta original (referência)

- **Mecânica central:** ao derrotar um chefe, o jogador ganha a arma dele, como em Mega Man.
- **Controles:** setas para mover, `A` para atirar, `ENTER` para começar.
- **HUD:**
  - pontos no canto superior esquerdo;
  - vidas, com o logo "W", no canto inferior esquerdo;
  - radar circular com barra de % no canto inferior direito;
  - barra de vida do boss no topo.
- **Fase 1 (mar):**
  - 3 atos, como em Sonic;
  - o tempo passa durante a fase: começa de manhã, passa pelo pôr do sol e termina à noite;
  - no fim, um boss: uma nave grande que dispara um laser gigante;
  - existe também uma "Área de Treinamento do Boss".
- **Elementos vistos nos prints:**
  - inimigos: jatos amarelos, naves triangulares (verde/rosa), uma "serpente" de anéis azuis e um inimigo em anel vermelho/marrom;
  - itens: power-up hexagonal com "W" e cápsulas.

# Visão do remake

- Jogabilidade e gráficos 2D, com acabamento moderno.
- **Arte em pixel art HD:**
  - resolução base 640x360, com escala inteira para 1080p/4K;
  - parallax, partículas e iluminação moderna.
- Suporte a gamepad (XInput) e teclado.
- Mantém a mecânica de armas dos chefes e as fases divididas em atos, com o tempo passando ao longo da fase.

# Stack e ferramentas

| Área | Ferramenta |
|---|---|
| Engine | Godot 4.7 (instalado via winget: `GodotEngine.GodotEngine`), GDScript |
| Input | Input Map do Godot (gamepad XInput nativo no Windows) |
| Pixel art / animação | Aseprite (alternativas grátis: Pixelorama / LibreSprite) |
| Música estilo Mega Drive (FM/YM2612) | Furnace Tracker (grátis) ou DefleMask; alternativa moderna: FL Studio / LMMS |
| Efeitos sonoros | jsfxr / ChipTone / Bfxr |
| Fases/tiles | TileMapLayer + editor de cenas do Godot |
| Padrões de tiro (opcional) | plugin BulletUpHell ou sistema próprio |
| Versionamento | Git + Git LFS para assets binários (png, wav, ogg, ase) |

# Convenções

- **Estrutura de pastas:**
  - `project.godot` fica na raiz;
  - cenas em `scenes/`;
  - scripts em `scripts/`;
  - assets (futuros) em `assets/`.
- **Resolução base:** 640x360. A janela padrão é 1280x720 com `stretch/mode=viewport` e `scale_mode=integer`. O filtro de textura é nearest, para manter o pixel art nítido.
- **Input:** as ações são registradas por código em `scripts/input_setup.gd` (`InputSetup.setup()`, chamado em `main.gd`):
  - `move_left`, `move_right`, `move_up`, `move_down`: setas, D-pad e analógico esquerdo;
  - `shoot`: `A`, `Z` ou `Espaço` no teclado; botão A ou X no controle;
  - `start`: `ENTER` ou Start.
- **Camadas de colisão:**
  - 1 = jogador;
  - 2 = tiros do jogador;
  - 4 = inimigos.

  O inimigo monitora as camadas 1 e 2 e trata a colisão em `_on_area_entered`.
- **Scripts:** GDScript tipado, com `class_name` em cada entidade (`Player`, `Enemy`, `Bullet`, `Explosion`, `Background`, `Hud`).
- **Gráficos provisórios:** por enquanto tudo é desenhado em `_draw()`. Esses desenhos serão trocados por sprites em pixel art.
- **Commits:** mensagens em português, no estilo Conventional Commits (`feat:`, `fix:`, `docs:`...).

# Estado atual

- **Protótipo 0.1** (out/2026): tela de título, nave com tiro, ondas de jatos amarelos em senoide, explosões, pontos, 3 vidas com invulnerabilidade ao renascer, game over com restart, e cenário do mar (manhã) com parallax.
- **Como rodar:** abrir `project.godot` no Godot 4 e apertar F5.
- **Validar sem abrir o editor:**
  - importar: `godot_console --headless --path . --import`
  - rodar: `godot_console --headless --path . --quit-after 300`

  `godot_console` fica em `%LOCALAPPDATA%\Microsoft\WinGet\Links`.

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
| Engine | Godot 4.x (última estável), GDScript |
| Input | Input Map do Godot (gamepad XInput nativo no Windows) |
| Pixel art / animação | Aseprite (alternativas grátis: Pixelorama / LibreSprite) |
| Música estilo Mega Drive (FM/YM2612) | Furnace Tracker (grátis) ou DefleMask; alternativa moderna: FL Studio / LMMS |
| Efeitos sonoros | jsfxr / ChipTone / Bfxr |
| Fases/tiles | TileMapLayer + editor de cenas do Godot |
| Padrões de tiro (opcional) | plugin BulletUpHell ou sistema próprio |
| Versionamento | Git + Git LFS para assets binários (png, wav, ogg, ase) |

# Convenções

- (A definir: estrutura de pastas, nomenclatura, etc.)

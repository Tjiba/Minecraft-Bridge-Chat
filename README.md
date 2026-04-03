<div align="center">

<h1>Minecraft-Bridge-Chat</h1>

<p>Bidirectional chat bridge between Minecraft guild chat and Discord.</p>

[![Discord.js](https://img.shields.io/badge/discord.js-v14-5865F2?logo=discord&logoColor=white)](https://discord.js.org)
[![Mineflayer](https://img.shields.io/badge/mineflayer-v4-62B15B)](https://github.com/PrismarineJS/mineflayer)
[![Node.js](https://img.shields.io/badge/Node.js-22%2B-339933?logo=node.js&logoColor=white)](https://nodejs.org)
[![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker&logoColor=white)](./docker-compose.yml)

</div>

---

## What it does

Connects your Minecraft guild chat (Hypixel) to a Discord server in real time. Messages sent in-game appear in Discord and vice versa. Guild events are also relayed automatically.

**Features:**
- Real-time bidirectional message relay (Minecraft ↔ Discord)
- Guild event detection — joins, leaves, promotions, kicks, mutes...
- Discord slash commands to manage the guild directly from Discord
- Webhook integration with player avatars for authentic message display
- Multi-guild support (multiple Minecraft guilds in separate Discord channels)
- Inter-guild communication (cross-guild message relay)
- Automatic reconnection with exponential backoff

---

## Prerequisites

- Node.js >= 22.0.0
- A Discord bot token (with message content intent + slash commands)
- A Minecraft account (Microsoft) with access to the target guild
- Guild officer/admin permissions on the Minecraft server

---

## Installation

```bash
# 1. Clone the repository
git clone https://github.com/FrenchLegacy/Minecraft-Bridge-Chat.git
cd Minecraft-Bridge-Chat

# 2. Install dependencies
npm install

# 3. Configure
cp config/settings.example.json config/settings.json
# Edit config/settings.json with your credentials

# 4. Start
npm start

# Development mode (auto-reload)
npm run dev
```

### Docker

```bash
docker-compose up -d
```

---

## Configuration

Copy `config/settings.example.json` to `config/settings.json` and fill in the following:

### App

```json
{
  "app": {
    "token": "YOUR_DISCORD_BOT_TOKEN",
    "clientId": "YOUR_BOT_CLIENT_ID",
    "serverDiscordId": "YOUR_DISCORD_SERVER_ID"
  }
}
```

### Guild

```json
{
  "guilds": [{
    "name": "MyGuild",
    "id": "myguild",
    "enabled": true,
    "server": {
      "serverName": "Hypixel",
      "host": "mc.hypixel.net",
      "port": 25565,
      "version": "1.8.9"
    },
    "account": {
      "email": "bot_email@example.com",
      "authMethod": "microsoft",
      "sessionPath": "./data/auth-cache",
      "reconnection": {
        "enabled": true,
        "maxRetries": 5,
        "retryDelay": 30000,
        "exponentialBackoff": true
      }
    },
    "ranks": ["Member", "Officer", "Co-Leader", "Leader"]
  }]
}
```

Set the Discord channel IDs and webhook URLs for chat and staff channels in each guild config.

Other config files (no editing required for basic use):
- `config/patterns.json` — regex patterns for message/event detection
- `config/templates.json` — message formatting templates

---

## Discord commands

| Command | Description |
|---------|-------------|
| `/ping` | Bot latency |
| `/help` | List available commands |
| `/serverinfo` | Connected server info |
| `/guild list <guild> <type>` | List guild members |
| `/guild invite <guild> <player>` | Invite a player |
| `/guild kick <guild> <player> <reason>` | Kick a player |
| `/guild promote/demote <guild> <player>` | Manage ranks |
| `/guild mute/unmute <guild> <player>` | Moderation |
| `/guild setrank <guild> <player> <rank>` | Set a rank directly |
| `/guild info <guild>` | Guild info |
| `/guild execute <guild> <command>` | Run an arbitrary guild command |

---

## Project structure

```
src/
├── main.js                          # Entry point
├── config/                          # Config loading & validation
├── discord/                         # Discord bot & bridge
│   ├── bridge/BridgeCoordinator.js  # Message relay logic
│   ├── client/commands/             # Slash commands
│   └── client/senders/              # Webhook & message senders
├── minecraft/                       # Minecraft bot
│   ├── client/parsers/              # Chat & event parsing
│   └── servers/HypixelStrategy.js  # Hypixel-specific handling
└── shared/                          # Logger, formatter, inter-guild
```

---

## Troubleshooting

**Bot not connecting to Minecraft** — Check credentials, Microsoft auth, and that the account has guild access.

**Messages not bridging** — Verify webhook URLs and check logs for parsing errors.

**Commands not working** — Ensure the bot has the required Discord permissions and guild officer role in-game.

---

<div align="center">
<sub>Made by <a href="https://github.com/FrenchLegacy">French Legacy</a> — maintained by <a href="https://github.com/Fabien83560">@Fabien83560</a></sub>
</div>

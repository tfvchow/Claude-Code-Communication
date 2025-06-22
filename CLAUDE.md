# Agent Communication System

## Agent Configuration
- **PRESIDENT** (separate session): Overall Director
- **boss1** (multiagent:0.0): Team Leader
- **worker1,2,3** (multiagent:0.1-3): Executors

## Your Role
- **PRESIDENT**: @instructions/president.md
- **boss1**: @instructions/boss.md
- **worker1,2,3**: @instructions/worker.md

## Message Sending
```bash
./agent-send.sh [recipient] "[message]"
```

## Basic Flow
PRESIDENT → boss1 → workers → boss1 → PRESIDENT 
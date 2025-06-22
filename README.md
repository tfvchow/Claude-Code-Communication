# 🤖 Claude Code Agent Communication System

A development system where multiple AIs work together like a company

## 📌 What is this?

**In 3 lines:**
1. Multiple AI agents (President, Manager, Workers) collaborate on development
2. Each runs in different terminal windows and exchanges messages
3. They divide roles like a human organization to develop efficiently

**Actual achievements:**
- Survey system (EmotiFlow) completed in 3 hours
- Generated 12 innovative ideas
- 100% test coverage

## 🎬 Try it in 5 minutes!

### Requirements
- Mac or Linux
- tmux (terminal multiplexer)
- Claude Code CLI

### Steps

#### 1️⃣ Download (30 seconds)
```bash
git clone https://github.com/nishimoto265/Claude-Code-Communication.git
cd Claude-Code-Communication
```

#### 2️⃣ Environment Setup (1 minute)
```bash
./setup.sh
```
This prepares 5 terminal windows in the background!

#### 3️⃣ Open President screen and start AI (2 minutes)

**Open President screen:**
```bash
tmux attach-session -t president
```

**Start Claude in President screen:**
```bash
# Browser authentication required
claude --dangerously-skip-permissions
```

#### 4️⃣ Start all subordinates at once (1 minute)

**Open a new terminal:**
```bash
# Start all 4 subordinates at once
for i in {0..3}; do 
  tmux send-keys -t multiagent.$i 'claude --dangerously-skip-permissions' C-m
done
```

#### 5️⃣ Check subordinates' screens
・Browser authentication for Claude may be required in each screen
```bash
tmux attach-session -t multiagent
```
This displays a 4-split screen:
```
┌────────┬────────┐
│ boss1  │worker1 │
├────────┼────────┤
│worker2 │worker3 │
└────────┴────────┘
```

#### 6️⃣ Enter the magic words (30 seconds)

Then enter:
```
You are the president. Create a stylish and comprehensive IT company homepage.
```

**This automatically triggers:**
1. President instructs the manager
2. Manager assigns work to 3 workers
3. Everyone collaborates on development
4. Report back to president when complete

## 🏢 Characters (Agents)

### 👑 President (PRESIDENT)
- **Role**: Decides overall strategy
- **Trait**: Genius at understanding users' true needs
- **Catchphrase**: "Please realize this vision"

### 🎯 Manager (boss1)
- **Role**: Middle manager who leads the team
- **Trait**: Master at drawing out members' creativity
- **Catchphrase**: "Please provide at least 3 innovative ideas"

### 👷 Workers (worker1, 2, 3)
- **worker1**: Design specialist (UI/UX)
- **worker2**: Data processing specialist
- **worker3**: Testing specialist

## 💬 How do they communicate?

### How to send messages
```bash
./agent-send.sh [recipient_name] "[message]"

# Example: Send to manager
./agent-send.sh boss1 "New project"

# Example: Send to worker1
./agent-send.sh worker1 "Please create the UI"
```

### Example exchanges

**President → Manager:**
```
You are boss1.

【Project Name】Survey System Development

【Vision】
A system anyone can use easily with instant results

【Success Criteria】
- Complete response in 3 clicks
- Real-time result display

Please realize this with innovative ideas.
```

**Manager → Worker:**
```
You are worker1.

【Project】Survey System

【Challenge】
Please propose at least 3 innovative UI design ideas.

【Format】
1. Idea name: [Catchy name]
   Overview: [Description]
   Innovation: [What's new]
```

## 📁 Important Files Explained

### Instructions (instructions/)
Behavior manuals for each agent

**president.md** - President's instructions
```markdown
# Your Role
As the best executive, understand user needs
and present a vision

# 5-Layer Needs Analysis
1. Surface: What to build
2. Functional: What it can do  
3. Benefit: What improves
4. Emotional: How they want to feel
5. Value: Why it's important
```

**boss.md** - Manager's instructions
```markdown
# Your Role
As a genius facilitator,
maximize the team's creativity

# 10-Minute Rule
Check progress every 10 minutes
and support struggling members
```

**worker.md** - Worker's instructions
```markdown
# Your Role
Leverage your expertise for innovative implementation

# Task Management
1. Create a to-do list
2. Execute in order
3. Report when complete
```

### CLAUDE.md
System-wide configuration file
```markdown
# Agent Communication System

## Agent Configuration
- PRESIDENT: Overall director
- boss1: Team leader  
- worker1,2,3: Executors

## Message Sending
./agent-send.sh [recipient] "[message]"
```

## 🎨 What was actually created: EmotiFlow

### What does it do?
- 😊 Survey that expresses emotions with emojis
- 📊 Real-time results viewing
- 📱 Mobile-friendly

### Try it out
```bash
cd emotiflow-mvp
python -m http.server 8000
# Open http://localhost:8000 in browser
```

### File structure
```
emotiflow-mvp/
├── index.html    # Main screen
├── styles.css    # Design
├── script.js     # Logic
└── tests/        # Tests
```

## 🔧 Troubleshooting

### Q: Agent not responding
```bash
# Check status
tmux ls

# Restart
./setup.sh
```

### Q: Messages not delivered
```bash
# View logs
cat logs/send_log.txt

# Manual test
./agent-send.sh boss1 "test"
```

### Q: Want to start over
```bash
# Full reset
tmux kill-server
rm -rf ./tmp/*
./setup.sh
```

## 🚀 Create Your Own Project

### Simple example: Create a TODO app

Enter in President (PRESIDENT):
```
You are the president.
Please create a TODO app.
Simple and easy to use, with task add/delete/complete functionality.
```

This automatically triggers:
1. Manager breaks down tasks
2. worker1 creates UI
3. worker2 handles data management
4. worker3 creates tests
5. Complete!

## 📊 System Architecture (Illustrated)

### Screen Layout
```
┌─────────────────┐
│   PRESIDENT     │ ← President screen (purple)
└─────────────────┘

┌────────┬────────┐
│ boss1  │worker1 │ ← Manager (red) and Worker1 (blue)
├────────┼────────┤
│worker2 │worker3 │ ← Worker2 and 3 (blue)
└────────┴────────┘
```

### Communication Flow
```
President
 ↓ "Realize this vision"
Manager
 ↓ "Everyone, share your ideas"
Workers
 ↓ "Complete!"
Manager
 ↓ "All complete"
President
```

### Progress Management System
```
./tmp/
├── worker1_done.txt     # Created when worker1 completes
├── worker2_done.txt     # Created when worker2 completes
├── worker3_done.txt     # Created when worker3 completes
└── worker*_progress.log # Progress logs
```

## 💡 Why is this amazing?

### Traditional Development
```
Human → AI → Result
```

### This System
```
Human → AI President → AI Manager → AI Workers×3 → Integration → Result
```

**Benefits:**
- 3x faster with parallel processing
- Leverages specialization
- Rich in ideas
- High quality

## 🎓 For Those Who Want to Know More

### How to Write Prompts

**Good example:**
```
You are boss1.

【Project Name】Clear name
【Vision】Concrete ideal
【Success Criteria】Measurable metrics
```

**Bad example:**
```
Make something
```

### Customization Methods

**Add new worker:**
1. Create `instructions/worker4.md`
2. Edit `setup.sh` to add pane
3. Add mapping to `agent-send.sh`

**Change timer:**
```bash
# In instructions/boss.md
sleep 600  # To change 10 min to 5 min
sleep 300
```

## 🌟 Summary

With this system, multiple AIs collaborate to achieve:
- Complete web apps in **3 hours**
- Generate **12** innovative ideas
- Achieve **100%** test coverage

Try it out and experience the power of an AI team!

---

**Author**: [GitHub](https://github.com/nishimoto265/Claude-Code-Communication)
**License**: MIT
**Questions**: Please use [Issues](https://github.com/nishimoto265/Claude-Code-Communication/issues)!
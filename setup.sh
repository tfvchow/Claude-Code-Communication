#!/bin/bash

# 🚀 Multi-Agent Communication Demo Environment Setup
# Reference: setup_full_environment.sh

set -e  # Stop on error

clear

# Colored log functions
log_info() {
    echo -e "\033[1;32m[INFO]\033[0m $1"
}

log_success() {
    echo -e "\033[1;34m[SUCCESS]\033[0m $1"
}

echo "🤖 Multi-Agent Communication Demo Environment Setup"
echo "==========================================="
echo ""

# STEP 1: Clean up existing sessions
log_info "🧹 Starting existing session cleanup..."

tmux kill-session -t multiagent 2>/dev/null && log_info "multiagent session deleted" || log_info "multiagent session did not exist"
tmux kill-session -t president 2>/dev/null && log_info "president session deleted" || log_info "president session did not exist"

# Clear completion files
mkdir -p ./tmp
rm -f ./tmp/worker*_done.txt 2>/dev/null && log_info "Cleared existing completion files" || log_info "Completion files did not exist"

log_success "✅ Cleanup complete"
echo ""

# STEP 2: Create multiagent session (4 panes: boss1 + worker1,2,3)
log_info "📺 Creating multiagent session (4 panes)..."

# Create first pane
tmux new-session -d -s multiagent -n "agents" /bin/bash

# Create 2x2 grid (total 4 panes)
tmux split-window -h -t "multiagent:0" /bin/bash      # Horizontal split (left-right)
tmux select-pane -t "multiagent:0.0"
tmux split-window -v /bin/bash                        # Vertical split on left side
tmux select-pane -t "multiagent:0.2"
tmux split-window -v /bin/bash                        # Vertical split on right side

# Set pane titles
log_info "Setting pane titles..."
PANE_TITLES=("boss1" "worker1" "worker2" "worker3")

for i in {0..3}; do
    tmux select-pane -t "multiagent:0.$i" -T "${PANE_TITLES[$i]}"
    
    # Set working directory and prompts silently
    tmux send-keys -t "multiagent:0.$i" "cd $(pwd); export TERM=xterm-256color; clear" C-m
    
    # Set color prompts
    PANE_NAME="${PANE_TITLES[$i]}"
    if [ $i -eq 0 ]; then
        # boss1: red
        tmux send-keys -t "multiagent:0.$i" "PS1='(\[\e[1;31m\]${PANE_NAME}\[\e[0m\]) \[\e[1;32m\]\w\[\e[0m\]\$ '" C-m
        tmux send-keys -t "multiagent:0.$i" "export PS1" C-m
        tmux send-keys -t "multiagent:0.$i" "clear" C-m
    else
        # workers: blue
        tmux send-keys -t "multiagent:0.$i" "PS1='(\[\e[1;34m\]${PANE_NAME}\[\e[0m\]) \[\e[1;32m\]\w\[\e[0m\]\$ '" C-m
        tmux send-keys -t "multiagent:0.$i" "export PS1" C-m
        tmux send-keys -t "multiagent:0.$i" "clear" C-m
    fi
    
done

log_success "✅ multiagent session created"
echo ""

# STEP 3: Create president session (1 pane)
log_info "👑 Creating president session..."

tmux new-session -d -s president /bin/bash
tmux send-keys -t president "cd $(pwd); export TERM=xterm-256color" C-m
tmux send-keys -t president "PS1='(\[\e[1;35m\]PRESIDENT\[\e[0m\]) \[\e[1;32m\]\w\[\e[0m\]\$ '" C-m
tmux send-keys -t president "export PS1" C-m
tmux send-keys -t president "clear" C-m

log_success "✅ president session created"
echo ""

# STEP 4: Environment verification and display
log_info "🔍 Verifying environment..."

echo ""
echo "📊 Setup Results:"
echo "==================="

# Check tmux sessions
echo "📺 Tmux Sessions:"
tmux list-sessions
echo ""

# Display pane configuration
echo "📋 Pane Configuration:"
echo "  multiagent session (4 panes):"
echo "    Pane 0: boss1     (Team Leader)"
echo "    Pane 1: worker1   (Executor A)"
echo "    Pane 2: worker2   (Executor B)"
echo "    Pane 3: worker3   (Executor C)"
echo ""
echo "  president session (1 pane):"
echo "    Pane 0: PRESIDENT (Project Director)"

echo ""
log_success "🎉 Demo environment setup complete!"
echo ""
echo "📋 Next Steps:"
echo "  1. 🔗 Session Attach:"
echo "     tmux attach-session -t multiagent   # Check multi-agent"
echo "     tmux attach-session -t president    # Check president"
echo ""
echo "  2. 🤖 Start Claude Code:"
echo "     # Step 1: President authentication"
echo "     tmux send-keys -t president 'claude' C-m"
echo "     # Step 2: After auth, start all multiagents"
echo "     for i in {0..3}; do tmux send-keys -t multiagent:0.\$i 'claude' C-m; done"
echo ""
echo "  3. 📜 Check Instructions:"
echo "     PRESIDENT: instructions/president.md"
echo "     boss1: instructions/boss.md"
echo "     worker1,2,3: instructions/worker.md"
echo "     System structure: CLAUDE.md"
echo ""
echo "  4. 🎯 Run Demo: Enter 'You are the president. Follow the instructions' in PRESIDENT" 
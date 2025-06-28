#!/bin/bash

# 🧹 Cleanup Git Worktrees for Multi-Agent System

set -e

# Configuration
CLAUDE_AGENT_WORK_DIR="${CLAUDE_AGENT_WORK_DIR:-$HOME/.claude-agents}"
TARGET_PROJECT_DIR="${1:-$(pwd)}"

# Colored log functions
log_info() {
    echo -e "\033[1;32m[INFO]\033[0m $1"
}

log_success() {
    echo -e "\033[1;34m[SUCCESS]\033[0m $1"
}

echo "🧹 Cleaning up Multi-Agent Git Worktrees"
echo "========================================"
echo ""

# Check if target is a git repository
if [ -d "$TARGET_PROJECT_DIR/.git" ] || git -C "$TARGET_PROJECT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
    log_info "🌳 Cleaning up git worktrees..."
    
    cd "$TARGET_PROJECT_DIR"
    
    # Remove worktrees
    for i in {1..3}; do
        if [ -d "$CLAUDE_AGENT_WORK_DIR/worker$i" ]; then
            log_info "Removing worktree for worker$i..."
            git worktree remove "$CLAUDE_AGENT_WORK_DIR/worker$i" --force 2>/dev/null || true
        fi
        
        # Delete agent branches
        if git branch | grep -q "agent-worker$i"; then
            log_info "Deleting branch agent-worker$i..."
            git branch -D "agent-worker$i" 2>/dev/null || true
        fi
        if git branch | grep -q "agent-worker$i-isolated"; then
            log_info "Deleting branch agent-worker$i-isolated..."
            git branch -D "agent-worker$i-isolated" 2>/dev/null || true
        fi
    done
    
    # Prune worktrees
    git worktree prune
    
    log_success "✅ Git worktrees cleaned up successfully"
else
    log_info "📁 Non-git repository: Removing copied directories..."
    
    # Remove copied directories
    for i in {1..3}; do
        if [ -d "$CLAUDE_AGENT_WORK_DIR/worker$i" ]; then
            log_info "Removing directory for worker$i..."
            rm -rf "$CLAUDE_AGENT_WORK_DIR/worker$i"
        fi
    done
    
    log_success "✅ Copied directories cleaned up successfully"
fi

# Clean up agent files
log_info "🗑️  Cleaning up agent files..."
rm -f "$CLAUDE_AGENT_WORK_DIR"/worker*_done.txt 2>/dev/null || true
rm -f "$CLAUDE_AGENT_WORK_DIR"/*_progress.log 2>/dev/null || true
rm -f "$CLAUDE_AGENT_WORK_DIR"/send_log.txt 2>/dev/null || true

# Kill tmux sessions
tmux kill-session -t multiagent 2>/dev/null && log_info "multiagent session terminated" || true
tmux kill-session -t president 2>/dev/null && log_info "president session terminated" || true

echo ""
log_success "🎉 Cleanup complete!"
echo ""
echo "💡 You can now:"
echo "   - Run './setup.sh' again to restart the system"
echo "   - Work normally in your project directory"
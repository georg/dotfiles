function cwt-rm --description 'Remove a git worktree from .claude/worktrees'
    if test (count $argv) -eq 0
        echo "Usage: cwt-rm <worktree-name>"
        return 1
    end

    set -l name $argv[1]
    set -l git_root (git rev-parse --show-toplevel 2>/dev/null)

    if test -z "$git_root"
        echo "Error: Not in a git repository"
        return 1
    end

    set -l worktree_dir "$git_root/.claude/worktrees/$name"

    if not test -d "$worktree_dir"
        echo "Error: Worktree '$name' does not exist at $worktree_dir"
        return 1
    end

    git worktree remove "$worktree_dir"
end

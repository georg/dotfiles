function cwt --description 'Create a git worktree in .claude/worktrees and start Claude'
    if test (count $argv) -eq 0
        echo "Usage: cwt <worktree-name>"
        return 1
    end

    set -l name $argv[1]
    set -l git_root (git rev-parse --show-toplevel 2>/dev/null)

    if test -z "$git_root"
        echo "Error: Not in a git repository"
        return 1
    end

    set -l worktree_dir "$git_root/.claude/worktrees/$name"

    mkdir -p "$git_root/.claude/worktrees"
    git worktree add "$worktree_dir" -b "$name" 2>/dev/null
    or git worktree add "$worktree_dir" "$name"

    if test $status -ne 0
        echo "Error: Failed to create worktree"
        return 1
    end

    cd "$worktree_dir"
    mise trust
    claude
end

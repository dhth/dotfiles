function! helpers#GetCommitsForDiffOpen()
    "more at https://github.com/junegunn/fzf.vim/blob/master/autoload/fzf/vim.vim#L1203
    "shows commits for current branch, needs --all to show commits for all branches
    "--ansi in fzf options shows colors using shell codes
    let source = 'git log --graph --since="2 weeks ago" '.get(g:, 'fzf_commits_log_options', '--color=always '.fzf#shellescape('--format=%C(auto)%h%d %s %C(green)%cr'))
    let b:start_commit="0"
    let b:end_commit="0"
    call fzf#run(fzf#wrap({'source': source, 'sink': function('s:CommitHelper'), 'options': '--multi=2 --ansi'}))
endfunction


function! s:CommitHelper(commit_data)
    let commit_hash = trim(split(split(a:commit_data, "<<")[1], ">>")[0])
    if b:end_commit ==# "0"
        let b:end_commit = commit_hash
    elseif b:start_commit ==# "0"
        let b:start_commit = commit_hash
    endif
    " hack to get data from multiple choices from FZF
    " [TODO] find a better way for this
    if (b:end_commit != "0" && b:start_commit != "0")
        execute 'DiffviewOpen '.b:start_commit.'...'.b:end_commit
    endif
endfunction


function! s:DiffWithCommitHelper(commit_data)
    let l:commit_hash = trim(split(a:commit_data, " ")[0])
    execute 'Gvdiffsplit! '.l:commit_hash.':%'
    " execute "wincmd H"
    " execute "wincmd l"
endfunction


function! helpers#DiffWithCommit()
    let source = 'git log ' . get(g:, 'fzf_commits_log_options', '--color=always '.fzf#shellescape('--format=%C(auto)%h%d %s %C(green)%cr')) . ' ' . expand('%:t')
    call fzf#run(fzf#wrap({'source': source, 'sink': function('s:DiffWithCommitHelper'), 'options': '--ansi --inline-info'}))
endfunction

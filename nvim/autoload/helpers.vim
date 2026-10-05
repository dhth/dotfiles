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

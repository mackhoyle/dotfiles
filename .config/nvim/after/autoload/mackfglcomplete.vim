
" Property of Four Js*
" (c) Copyright Four Js 1995, 2025. All Rights Reserved.
" * Trademark of Four Js Development Tools Europe Ltd
"   in the United States and elsewhere

"Installation
"
"Add next lines to ~/.vimrc (On Windows: %USERPROFILE%\.vimrc)
"
"   let generofiles=expand($FGLDIR . "/vimfiles")
"   if isdirectory(generofiles)
"       let &rtp=generofiles.','.&rtp
"   endif
"
"Usage
"   in vim insert mode: press <tab> to get a list of proposals.

let b:res=[]

function! mackfglcomplete#Complete(findstart, base)
    if a:findstart
        " Determine tool
        if &filetype ==# 'fgl'
            let tool = 'fglcomp'
        else
            let tool = 'fglform'
        endif
        if exists('g:fgl_lowercase_keywords')
            let tool .= ' --fo-lowercase-keywords=1'
        endif

        " Save &shellredir and set for our system call
        let sr = &shellredir
        if has('win32') || has('win64')
            set shellredir=>%s\ 2>nul
        else
            set shellredir=>%s\ 2>/dev/null
        endif

        " Build command
        let cmd = tool . " -M --vimcomplete=" . line('.') . "," . col('.') . " stdin:" . expand('%')
        let stdin = join(getline(1, '$'), "\n")
        let raw = system(cmd, stdin)

        " Try to find first JSON array in output
        let start_json = match(raw, '\[')
        let end_json   = match(raw, '\]', start_json)
        let b:res = []
        if start_json >= 0 && end_json >= 0
            let json_str = strpart(raw, start_json, end_json - start_json + 1)
            try
                let b:res = eval(json_str)
            catch
                let b:res = []
            endtry
        endif

        " Restore &shellredir
        let &shellredir = sr

        " Compute start column
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\i'
            let start -= 1
        endwhile
        return start
    else
        return get(b:, 'res', [])
    endif
endfunction



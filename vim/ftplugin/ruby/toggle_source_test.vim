if !exists("*ToggleSourceTestFilename")
    function ToggleSourceTestFilename()
    let l:without_fixes = substitute(substitute(RPath('%'), '^\(\(\(src\)\|\(test\)\|\(lib\)\)\/\)*', '', ''), '\(_test\)\?\.rb', '', '')
    if (match(RPath("%"), "^test/") >= 0)
      let l:lib = 'lib/'.l:without_fixes.'.rb'
      let l:src = 'src/'.l:without_fixes.'.rb'
      let l:src_lib = 'src/lib/'.l:without_fixes.'.rb'
      echo l:src_lib
      if !empty(glob(l:lib))
        return l:lib
      endif
      if !empty(glob(l:src))
        return l:src
      endif
      if !empty(glob(l:src_lib))
        return l:src_lib
      endif
      return l:without_fixes.'.rb'
    else
      return "test/".l:without_fixes."_test.rb"
        endif
    endfunction
endif

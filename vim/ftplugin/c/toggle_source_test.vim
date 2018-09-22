if !exists("*ToggleSourceTestFilename")
	function ToggleSourceTestFilename()
    if (match(RPath("%"), "^test/") >= 0)
      return RPath(substitute(RPath("%:r"), '^test/\(.*\)Test$', '\1', "").".c*")
    else
      return "test/".RPath("%:r")."Test.cpp"
		endif
	endfunction
endif

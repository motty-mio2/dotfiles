function gime {
    Param (
        [ValidateSet ("property", "dictionary", "register", "write", "palette" )]$option)

    switch ($option) {
        "property" { $argument = " --mode=config_dialog" }
        "dictionary" { $argument = " --mode=dictionary_tool" }
        "register" { $argument = " --mode=word_register_dialog" }
        "write" { $argument = " --mode=hand_writing" }
        "palette" { $argument = " --mode=character_palette" }
        Default { $argument = $null }
    }
    cmd /C (start "C:\Program Files (x86)\Google\Google Japanese Input\GoogleIMEJaTool.exe"${argument})
}

function msime {
    Param (
        [ValidateSet ("ADDSYSDICT", "CHECKSYSDICT", "REMOVESYSDICT"
            , "SETKANAINPUT", "GETKANAINPUT" , "SETCUSTOMDICTPATH"
            , "GETCUSTOMDICTPATH", "FIXCUSTOMDICT", "CODEAREAFORCONVERT"
            , "SETOKURIGANAOPTION", "GETOKURIGANAOPTION", "SETKEYTEMPLATE"
            , "SETKUTOUTEN", "RESET", "LOADAUTOTUNEDATA"
            , "SAVEAUTOTUNEDATA", "REMOVEAUTOTUNEDATA", "SETFILTERDICT"
            , "GETFILTERDICT", "REMOVEFILTERDICT", "HELP"
        )]$argument)

    C:\Windows\System32\IME\IMEJP\imjpuexc.exe ${argument}
}
function splitpane --description 'split the pane'
    powershell.exe -command wt.exe -w 0 sp -d \"(wslpath -w "$PWD")\" -H $argv
end

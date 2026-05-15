function fish_mode_prompt --description 'Displays the current mode'
    if ! contains -- --final-rendering $argv 
        fish_default_mode_prompt
    end
end

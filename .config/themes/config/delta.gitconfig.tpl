[delta]
    dark = true
    tabs = 2

    file-style = omit
    file-decoration-style = none

    line-numbers = true
    line-numbers-left-format = "{nm:>4} "
    line-numbers-right-format = "│ {np:>4} "
    line-numbers-left-style = "{{ color8 }}"
    line-numbers-right-style = dim "{{ background }}" 
    line-numbers-zero-style = dim "{{ color8 }}" 
    line-numbers-plus-style = dim "{{ color2 }}" 
    line-numbers-minus-style = dim "{{ color1 }}" 

    wrap-left-symbol = " "
    wrap-right-symbol = " "
    wrap-right-prefix-symbol = " "

    plus-style = "{{ color2 }}"
    plus-emph-style = "{{ color2 }}" "{{ color10 }}"
    minus-style = "{{ color1 }}"
    minus-emph-style = "{{ color1 }}" "{{ color9 }}"

    hunk-label = "  󰡏 "
    hunk-header-line-number-style = "{{ color3 }}"
    hunk-header-style = dim "{{ color8 }}"
    hunk-header-file-style = dim "{{ color8 }}"
    hunk-header-decoration-style = "{{ color3 }}" ol ul

    zero-style = syntax


    # blame-palette = "#1e1e2e #181825 #11111b #313244 #45475a"
	# hunk-header-decoration-style = "#6c7086" box ul
	# hunk-header-file-style = bold
	# hunk-header-line-number-style = bold "#a6adc8"
	# hunk-header-style = file line-number syntax
	# line-numbers-left-style = "#6c7086"
	# line-numbers-right-style = "#6c7086"
	# line-numbers-zero-style = "#6c7086"
	# # 35% red 65% base
	# minus-emph-style = bold syntax "#694559"
	# # 20% red 80% base
	# minus-style = syntax "#493447"
	# # 35% green 65% base
	# plus-emph-style = bold syntax "#4e6356"
	# # 20% green 80% base
	# plus-style = syntax "#394545"
	# map-styles = \
	# 	bold purple => syntax "#5b4e74", \
	# 	bold blue => syntax "#445375", \
	# 	bold cyan => syntax "#446170", \
	# 	bold yellow => syntax "#6b635b"
	# # Should match the name of the bat theme

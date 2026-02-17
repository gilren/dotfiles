[delta]
    dark = true
    syntax-theme = tokyonight_night
    tabs = 2

    file-style = omit
    file-decoration-style = none

    line-numbers = true
    line-numbers-left-format = "{nm:>4} "
    line-numbers-right-format = "│ {np:>4} "
    line-numbers-left-style = "{{ color8 }}"
    line-numbers-right-style = "{{ background }}" dim
    line-numbers-zero-style = "{{ color8 }}" dim
    line-numbers-plus-style = "{{ color2 }}" dim
    line-numbers-minus-style = "{{ color1 }}" dim

    wrap-left-symbol = " "
    wrap-right-symbol = " "
    wrap-right-prefix-symbol = " "

    plus-style = syntax "{{ color2 }}"
    plus-emph-style = syntax "{{ color2 }}" "{{ color10 }}"
    minus-style = syntax "{{ color1 }}"
    minus-emph-style = syntax "{{ color1 }}" "{{ color9 }}"

    hunk-label = "  󰡏 "
    hunk-header-line-number-style = "{{ color3 }}"
    hunk-header-style = "{{ color8 }}" dim
    hunk-header-file-style = "{{ color8 }}" dim
    hunk-header-decoration-style = "{{ color3 }}" ol ul

    zero-style = syntax

[delta]
    dark = true
    tabs = 2
    # Use the dynamically generated bat theme (matches terminal colors).
    # Theme-set builds bat.tmTheme from the same colors.toml and symlinks it
    # to ~/.config/bat/themes/current.tmTheme.
    syntax-theme = current

    # File names are shown in the hunk header instead (diffnav handles the
    # file tree), so omit the separate file block.
    file-style = omit
    file-decoration-style = none

    line-numbers = true
    line-numbers-left-format = "{nm:>4} "
    line-numbers-right-format = "│ {np:>4} "
    # Left column: old-file line numbers, visible on terminal bg.
    # Right column: new-file line numbers, dimmed to blend into the diff panel.
    line-numbers-left-style = "{{ color8 }}"
    line-numbers-right-style = dim "{{ background }}" 
    line-numbers-zero-style = dim "{{ color8 }}" 
    line-numbers-plus-style = dim "{{ color2 }}" 
    line-numbers-minus-style = dim "{{ color1 }}" 

    wrap-left-symbol = " "
    wrap-right-symbol = " "
    wrap-right-prefix-symbol = " "

    # Full-line background tint: 10% blend gives subtle highlight for every
    # added/removed line. The emph variant (25% + bold) highlights the
    # actually changed characters within a line.
    # Template syntax: {{ mix(foreground, background, weight) }} blends
    # two hex colors at the given weight (0 = all bg, 100 = all fg).
    plus-style = "{{ color2 }}" "{{ mix(color2, background, 10) }}"
    plus-emph-style = bold "{{ color2 }}" "{{ mix(color2, background, 25) }}"
    minus-style = "{{ color1 }}" "{{ mix(color1, background, 10) }}"
    minus-emph-style = bold "{{ color1 }}" "{{ mix(color1, background, 25) }}"

    hunk-label = "  󰡏 "
    # Hunk header: line number + dimmed description in gray, file name in
    # foreground, and a colored overline/underline using the theme accent.
    hunk-header-line-number-style = "{{ accent }}"
    hunk-header-style = dim "{{ color8 }}"
    hunk-header-file-style = "{{ foreground }}"
    hunk-header-decoration-style = "{{ accent }}" ol ul

    # Unchanged (context) lines use bat syntax highlighting via the dynamic
    # theme. No explicit background — blends with terminal bg.
    zero-style = syntax

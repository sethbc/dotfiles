
# set spacing on menu bar icons
defaults -currentHost write -globalDomain NSStatusItemSpacing -int 10 #8
defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 10 #8

# revert to old
#defaults -currentHost delete -globalDomain NSStatusItemSpacing
#defaults -currentHost delete -globalDomain NSStatusItemSelectionPadding

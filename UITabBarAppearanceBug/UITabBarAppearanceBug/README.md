#  UITabBar Appearance Bug

## Problem

Long text on tab bar items in a UITabBar apply a level of “tightening” (an automatic kerning adjustment) in order to squeeze into the tab bar visually. This tightening is lost when applying an appearance to the tab bar

## Explored Fixes

I tried the following to resolve the issue:

- Started with `NSParagraphStyle`'s `allowsDefaultTighteningForTruncation` and provided it to the title text attributes for all states. This did not replicate iOS’s default tightening behaviour
- Supplied a kerning value directly (between -0.5 and -1.0), but this affected all text (even that which does not need tightening based on available space). It also caused labels to become leading-aligned, and the kerning was lost whenever the `UITabBar` `items` setter was called (which gets called by Dayforce to dynamically update tab items)
- Attempted to construct a `UITabBarItemAppearance` configured for the default `.stackedLayout` style and then mutated its existing title text attributes, hoping to preserve whatever iOS was using as a default. This also broke the text tightening behaviour. 
- I tried simply not replacing the existing layout appearances and only provided the additional `.foregroundColor` key to enhance the contrast (e.g. `tabBar.standardAppearance.inlineLayoutAppearance.normal.titleTextAttributes[.foregroundColor] = UIColor.bodyMediumEmphasis`, this preserved the text tightening behaviour in the standard iOS tab bar, but did not adjust the colours
- I then tried the following line of code: `tabBar.standardAppearance = tabBar.standardAppearance`. This BROKE letter tightening, implying to me that iOS is doing some magic on unadulterated tab bars, and the simple fact of setting the appearance will break that
- Moved on to the `UITabBarItem` itself and attempted to create tab bar items with the correct appearance directly. This broke in the same way (no automatic kerning)
- Attempted to apply a kerning adjustment through `NSParagraphStyle` only to tab bar items with long titles (> 12 characters). This did not work.
- Tried using the appearance proxy instead (`UITabBar.appearance()` and `UITabBarItem.appearance()`), for some reason calling `setTitleTextAttributes` on `UITabBarItem`’s appearance proxy for the `.normal` state sets it for the `.selected` state (can’t figure out how to change the `.normal` state though)
- Tried re-setting the tab bar items (ie., `tabBar.setItems(.., animated: false)`) upon selection in an attempt to force iOS to reconsider its life choices, but that resulted in randomly getting the correct kerning, only to break again on highlighted/selected state changes

## Analysis

- This simple project replicates the issue. Would appreciate anyone’s time to see if they can identify a workaround

## Feedback

- Filed feedback with apple. FB11431073 & FB11431035


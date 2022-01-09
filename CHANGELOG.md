# 1.0.0-rc.2

**BREAKING**
- `AdwHeaderBarMinimal` is now `AdwHeaderBar.minimal`
- The `start` and `end` parameter of `AdwHeaderBar` are now `List<Widget>` instead of `Widget`
- `AdwTextButton` is now `AdwButton.flat`
- The `height` and `expanded` properties of ViewSwitcher are now deprecated

**Other Changes**
- Add `AdwComboRow`, `AdwAvatar`, `AdwButton`(`.pill`, `.circular`, `.flat`)
- Improve Header Button
- Update Sidebar Theming
- Update View Switcher theming
- Remove Scroll errors from example app by improving `AdwClamp`

# 1.0.0-rc.1

- Added the following widgets:
  - `AdwScaffold`
  - `AdwTextField`
  - `AdwTextButton`
  - `AdwViewStack`
  - `WindowResizeListener`
- Fix Window buttons null error
- Update Example
- Update `AdwActionRow` & `AdwStackSidebar`
- Improve `AdwFlap`

# 1.0.0-rc.0

- Seperate libadwaita (Widgets) and adwaita (Colors)
- Rename Every widget from GtkSomething to AdwSomething
- Rename GtkContainer to AdwClamp and GtkTwoPane to AdwFlap
- Add `AdwPreferenceGroup` and `AdwActionRow` from libadwaita.
- Add `AdwStackSidebar` which is basically `GtkStackSidebar`
- `AdwHeaderBar` parameter's
    - Replace leading with start
    - Replace trailing with end
    - Replace center with title

For older Changelog visit: https://pub.dev/packages/gtk/changelog

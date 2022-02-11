# Changelog

## 1.0.0

### **BREAKING**
- `AdwHeaderBar.minimal` is now `AdwHeaderBar.custom`
- Remove `label` parameter from `AdwTextField`
- `ViewSwitcherStyle` is now `ViewSwitcherPolicy`
- `ViewSwitcherStyle.desktop` and `ViewSwitcherStyle.mobile` are also renamed to `ViewSwitcherPolicy.wide` and `ViewSwitcherPolicy.narrow`

### **Changes to widgets**
**ComboRow**
- Dropdown is now scrollable if too many elements are there

**Flap**
- Renamed `flapController` to `controller`
- Moved most of the things into `FlapStyle` class to simplify its usage in `AdwScaffold`

**HeaderBar**
- Now the `AdwHeaderBar` is not dependent on any package, `windowDecor` object is now optional
- Add `isTransparent` parameter => Makes `AdwHeaderBar`'s background and border color

**Popover**
- Revisit popup menu by using `popover_gtk` package (popover package with fade transition) (#35)

**TextField**
- Add `autofocus` parameter
- Add `prefixIcon` parameter
- Add `onSubmitted` parameter

**ViewSwitcher**
- Add `badge` in `AdwViewSwitcher`

**New Widgets**
- `AdwSwitch` => port of `GtkSwitch` from gtk4
- `AdwAboutWindow` => port of upcoming `AdwAboutWindow` from libadwaita

## 1.0.0-rc.2

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

## 1.0.0-rc.1

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

## 1.0.0-rc.0

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

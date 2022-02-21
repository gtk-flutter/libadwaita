# Changelog

## 1.2.0

### BREAKING

* `flapPolicy` and `flapPosition` are now removed from `FlapStyle` use `FlapOptions` and options parameter of `AdwFlap`.
  * Previously
    ```dart
    AdwFlap(
      style: FlapStyle(
        width: ...,
        breakpoint: ...,
        flapPosition: ...,
        flapPolicy: ...,
      )
    )
    ```
  * Now
    ```dart
    AdwFlap(
      style: FlapStyle(
        width: ...,
        breakpoint: ...,
      ),
      options: FlapOptions(
        flapPosition: ...,
        flapPolicy: ...,
      )
    )
    ```
* Fix spelling by renaming `seperator` to `separator` everywhere


### DEPRECATED

* `headerbar` parameter from `AdwScaffold` and `AdwAboutWindow` is deprecated
  * Previously
    ```dart
    AdwScaffold(
      headerbar: (_) => AdwHeaderBar(
        start: start,
        end: end,
        title: title,
      )
    )
    ```
  * Now
    ```dart
    AdwScaffold(
      start: start,
      end: end,
      title: title,
    )
    ```

### ADDED

* Add `appName` and `appVersion` parameter
* `actions` and `controls` parameter for `AdwHeaderBar`
* Add ability to change `horizontalTitleGap` for `AdwActionRow` and `AdwComboRow`
* Init Translations

### CHANGED
* Changed default value of `horizontalTitleGap` to 8
* Switch to `titlebar_buttons` package as `window_decorations` is deprecated
* Link to external examples in example.md

## 1.0.2

* Fix License in README

## 1.0.1

* Relicense under MPL-2.0

## 1.0.0+2

* Fix Table view on pub.dev

## 1.0.0+1

* Fix Example link

## 1.0.0

### **BREAKING**
* `AdwHeaderBar.minimal` is now `AdwHeaderBar.custom`
* Remove `label` parameter from `AdwTextField`
* `ViewSwitcherStyle` is now `ViewSwitcherPolicy`
* `ViewSwitcherStyle.desktop` and `ViewSwitcherStyle.mobile` are also renamed to `ViewSwitcherPolicy.wide` and `ViewSwitcherPolicy.narrow`

### **Changes to widgets**
**ComboRow**
* Dropdown is now scrollable if too many elements are there

**Flap**
* Renamed `flapController` to `controller`
* Moved most of the things into `FlapStyle` class to simplify its usage in `AdwScaffold`

**HeaderBar**
* Now the `AdwHeaderBar` is not dependent on any package, `windowDecor` object is now optional
* Add `isTransparent` parameter => Makes `AdwHeaderBar`'s background and border color

**Popover**
* Revisit popup menu by using `popover_gtk` package (popover package with fade transition) (#35)

**TextField**
* Add `autofocus` parameter
* Add `prefixIcon` parameter
* Add `onSubmitted` parameter

**ViewSwitcher**
* Add `badge` in `AdwViewSwitcher`

**New Widgets**
* `AdwSwitch` => port of `GtkSwitch` from gtk4
* `AdwAboutWindow` => port of upcoming `AdwAboutWindow` from libadwaita

## 1.0.0-rc.2

**BREAKING**
* `AdwHeaderBarMinimal` is now `AdwHeaderBar.minimal`
* The `start` and `end` parameter of `AdwHeaderBar` are now `List<Widget>` instead of `Widget`
* `AdwTextButton` is now `AdwButton.flat`
* The `height` and `expanded` properties of ViewSwitcher are now deprecated

**Other Changes**
* Add `AdwComboRow`, `AdwAvatar`, `AdwButton`(`.pill`, `.circular`, `.flat`)
* Improve Header Button
* Update Sidebar Theming
* Update View Switcher theming
* Remove Scroll errors from example app by improving `AdwClamp`

## 1.0.0-rc.1

* Added the following widgets:
  * `AdwScaffold`
  * `AdwTextField`
  * `AdwTextButton`
  * `AdwViewStack`
  * `WindowResizeListener`
* Fix Window buttons null error
* Update Example
* Update `AdwActionRow` & `AdwStackSidebar`
* Improve `AdwFlap`

## 1.0.0-rc.0

* Seperate libadwaita (Widgets) and adwaita (Colors)
* Rename Every widget from GtkSomething to AdwSomething
* Rename GtkContainer to AdwClamp and GtkTwoPane to AdwFlap
* Add `AdwPreferenceGroup` and `AdwActionRow` from libadwaita.
* Add `AdwStackSidebar` which is basically `GtkStackSidebar`
* `AdwHeaderBar` parameter's
  * Replace leading with start
  * Replace trailing with end
  * Replace center with title

Older CHANGELOG can be found [here](https://pub.dev/packages/gtk/changelog)

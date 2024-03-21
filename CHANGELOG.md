## 2.3.2

* Removed screenshots and example from package archive

## 2.3.1

* Fixed error when search had special characters
* Removed WillPopScope since it's not working yet

## 2.3.0

* Added untitled anchor/trigger widget
* Added option to custom placeholder of the anchor/trigger widget
* Added option to custom separator value text

## 2.0.0

* Added groupable choice items that can be sorted
* Added group list, item, header builder, and predefined widget
* Added choice anchor and value text widget
* Added value chips widget
* Adjust `itemSkip` callback parameters
* Replaced `trigger` term with `anchor`
* Replaced `createWidget` with `createSpacer`
* Renamed most of `createBuilder` constructor with `create`
* Improved choice and search controller construction
* Improved selected many logic
* Keep focus search field on submit and cross faded search toggle icon
* Fixed search field spacing and replaceable leading widget

## 1.3.2

* Re-render-able modal widget
* Changed default to manual search submit
* Added loading indicator to controller so it can access everywhere
* The trigger widget notices the loading state from the choice controller
* Improved inline and prompted choice with placeholder, error and loading indicator

## 1.0.0

* Optional placeholder widget when there are no choice items
* Renamed the term `filter` to `search` and all related files

## 1.0.0-dev.4

* Added onFilter option to catch filter value when changed
* Renamed filter show/hide to attach/detach
* Moved filter route history to outer context

## 1.0.0-dev.3

* Fixed strange navigator behavior of filterable prompted choice
* Added example screenshots
* Improved example

## 1.0.0-dev.2

* Provides API documentation
* Choice list get keyword directly from state
* Removed [Choice.builder] constructor
* Create alias to build modal compositions widget
* Renamed [toChoiceData] to [asChoiceData]
* Improved example

## 1.0.0-dev.1

* Inline or prompted choice widget
* Single or multiple choice widget
* Searchable choice items with highlighted result
* Customizable list, comes with predefined
* Customizable prompt, comes with predefined

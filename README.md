# DropDownTableView
Here is a drop-down TableView. It shows JSON-like data.

Place into Podfile `pod 'DropDownTableView'`

Place this preamble `import DropDownTableView` into source file.

["Russia" : ["capital" : "Moscow", "square" : "17 098 242"],
"USA" : ["capital" : "Washington, D.C.", "Independence Day" : "July 4", "square" : "9 857 306"],
"Zimbabwe" : ["capital" : "Harare"]]

Inherit from `DropDownTableViewController` and override methods from `DropDownTableViewDataSource` and `DropDownTableViewDelegate`.

This is initial version, and it has some bugs and incomplete implementation.

I am awaiting for your comments.

![Alt text](https://raw.githubusercontent.com/NSSimpleApps/DropDownTableView/master/DropDownTableView/DropDownTable.gif)

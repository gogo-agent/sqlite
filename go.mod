module github.com/gogo-agent/sqlite

go 1.24.5

replace github.com/gogo-agent/jsonschema => ../jsonschema

replace github.com/gogo-agent/jsonpatch => ../jsonpatch

replace github.com/gogo-agent/jsonpointer => ../jsonpointer

require (
	github.com/gogo-agent/jsonschema v0.0.0-00010101000000-000000000000
	github.com/mattn/go-sqlite3 v1.14.32
)

require (
	github.com/gogo-agent/jsonpatch v0.0.0-00010101000000-000000000000 // indirect
	github.com/gogo-agent/jsonpointer v0.0.0-00010101000000-000000000000 // indirect
)

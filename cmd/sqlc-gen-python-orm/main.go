package main

import (
	"github.com/sqlc-dev/sqlc-go/codegen"

	python "github.com/zztkm/sqlc-gen-python-orm/internal"
)

const version = "0.0.2"

func main() {
	codegen.Run(python.Generate)
}

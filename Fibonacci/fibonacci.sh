#!/usr/bin/env sh

echo "No Parallel"
go run fibonacci.go ${1}
echo "Parallel"
go run fibonacci_p.go ${1}
echo "Parallel Fix"
go run fibonacci_p_fix.go ${1}

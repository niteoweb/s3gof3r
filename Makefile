VERSION := 5.0.1

all: setup build

wercker: all test

setup:
	go get -v s3sync/...

clean:
	rm -f champ
	rm -rf pkg
	rm -rf bin
	find src/* -maxdepth 0 ! -name 's3sync' -type d | xargs rm -rf

build:
	go build --ldflags '-w -X main.version=$(VERSION)' s3sync/cmd/gof3r

test:
	go test -v -race s3sync/...

cover:
	gocov test s3sync/... | gocov report

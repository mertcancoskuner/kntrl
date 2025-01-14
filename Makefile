CLANG ?= clang
CFLAGS ?= -O2 -g -Wall -Werror 
GOARCH ?= amd64

#LIBEBPF_TOP = /home/cx/go/src/github.com/ebpf
LIBEBPF_TOP = /home/cx/go/src/github.com/kondukto-io/kntrl/
#LIBEBPF_TOP = /go/pkg/mod/github.com/cilium/ebpf@v0.11.0
EXAMPLES_HEADERS = $(LIBEBPF_TOP)/bpf/headers

all: generate build 

generate: export BPF_CLANG=$(CLANG)
generate: export BPF_CFLAGS=$(CFLAGS)
generate: export BPF_HEADERS=$(EXAMPLES_HEADERS)
generate:
	go generate ./...
build:
	go build -o kntrl .
clean:
	rm kntrl ./internal/handlers/tracer/bpf_bpfel_x86.o ./internal/handlers/tracer/bpf_bpfel_x86.go

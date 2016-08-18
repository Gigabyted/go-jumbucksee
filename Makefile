# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gjbsee gjbsee-cross evm all test clean
.PHONY: gjbsee-linux gjbsee-linux-386 gjbsee-linux-amd64 gjbsee-linux-mips64 gjbsee-linux-mips64le
.PHONY: gjbsee-linux-arm gjbsee-linux-arm-5 gjbsee-linux-arm-6 gjbsee-linux-arm-7 gjbsee-linux-arm64
.PHONY: gjbsee-darwin gjbsee-darwin-386 gjbsee-darwin-amd64
.PHONY: gjbsee-windows gjbsee-windows-386 gjbsee-windows-amd64
.PHONY: gjbsee-android gjbsee-ios

GOBIN = build/bin
GO ?= latest

gjbsee:
	build/env.sh go run build/ci.go install ./cmd/gjbsee
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gjbsee\" to launch gjbsee."

evm:
	build/env.sh go run build/ci.go install ./cmd/evm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/evm to start the evm."

all:
	build/env.sh go run build/ci.go install

test: all
	build/env.sh go run build/ci.go test

clean:
	rm -fr build/_workspace/pkg/ Godeps/_workspace/pkg $(GOBIN)/*

# Cross Compilation Targets (xgo)

gjbsee-cross: gjbsee-linux gjbsee-darwin gjbsee-windows gjbsee-android gjbsee-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-*

gjbsee-linux: gjbsee-linux-386 gjbsee-linux-amd64 gjbsee-linux-arm gjbsee-linux-mips64 gjbsee-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-*

gjbsee-linux-386:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=linux/386 -v ./cmd/gjbsee
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-* | grep 386

gjbsee-linux-amd64:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=linux/amd64 -v ./cmd/gjbsee
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-* | grep amd64

gjbsee-linux-arm: gjbsee-linux-arm-5 gjbsee-linux-arm-6 gjbsee-linux-arm-7 gjbsee-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-* | grep arm

gjbsee-linux-arm-5:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=linux/arm-5 -v ./cmd/gjbsee
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-* | grep arm-5

gjbsee-linux-arm-6:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=linux/arm-6 -v ./cmd/gjbsee
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-* | grep arm-6

gjbsee-linux-arm-7:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=linux/arm-7 -v ./cmd/gjbsee
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-* | grep arm-7

gjbsee-linux-arm64:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=linux/arm64 -v ./cmd/gjbsee
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-* | grep arm64

gjbsee-linux-mips64:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=linux/mips64 -v ./cmd/gjbsee
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-* | grep mips64

gjbsee-linux-mips64le:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=linux/mips64le -v ./cmd/gjbsee
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-linux-* | grep mips64le

gjbsee-darwin: gjbsee-darwin-386 gjbsee-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-darwin-*

gjbsee-darwin-386:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=darwin/386 -v ./cmd/gjbsee
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-darwin-* | grep 386

gjbsee-darwin-amd64:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=darwin/amd64 -v ./cmd/gjbsee
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-darwin-* | grep amd64

gjbsee-windows: gjbsee-windows-386 gjbsee-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-windows-*

gjbsee-windows-386:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=windows/386 -v ./cmd/gjbsee
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-windows-* | grep 386

gjbsee-windows-amd64:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=windows/amd64 -v ./cmd/gjbsee
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-windows-* | grep amd64

gjbsee-android:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=android-21/aar -v ./cmd/gjbsee
	@echo "Android cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-android-*

gjbsee-ios:
	build/env.sh go run build/ci.go xgo --go=$(GO) --dest=$(GOBIN) --targets=ios-7.0/framework -v ./cmd/gjbsee
	@echo "iOS framework cross compilation done:"
	@ls -ld $(GOBIN)/gjbsee-ios-*

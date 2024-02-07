all:
	if [ ! -d $(BUILD_PATH)/cvitek/build/arch ]; then \
		mkdir -p $(BUILD_PATH)/cvitek/build/arch; \
	fi

	cd $(BUILD_PATH)/cvitek/build/arch && \
	$(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) -G Ninja -DCHIP=cv180x \
		-DTOP_DIR=$(BUILD_PATH)/cvitek \
		-DRUN_TYPE=CVIRTOS \
		-DRUN_ARCH=riscv64 \
		-DBUILD_ENV_PATH=$(BUILD_PATH)/cvitek/build \
		-DCMAKE_TOOLCHAIN_FILE=$(BUILD_PATH)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(BUILD_PATH)/cvitek/arch
	cd $(BUILD_PATH)/cvitek/build/arch && $(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) --build . --target install -- -v

	if [ ! -d $(BUILD_PATH)/cvitek/build/kernel ]; then \
		mkdir -p $(BUILD_PATH)/cvitek/build/kernel; \
	fi

	cd $(BUILD_PATH)/cvitek/build/kernel && \
	$(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DTOP_DIR=$(BUILD_PATH)/cvitek \
		-DBUILD_ENV_PATH=$(BUILD_PATH)/cvitek/build \
		-DCMAKE_TOOLCHAIN_FILE=$(BUILD_PATH)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(BUILD_PATH)/cvitek/kernel
	cd $(BUILD_PATH)/cvitek/build/kernel && $(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) --build . --target install -- -v

	if [ ! -d $(BUILD_PATH)/cvitek/build/common ]; then \
		mkdir -p $(BUILD_PATH)/cvitek/build/common; \
	fi

	cd $(BUILD_PATH)/cvitek/build/common && \
	$(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DTOP_DIR=$(BUILD_PATH)/cvitek \
		-DBUILD_ENV_PATH=$(BUILD_PATH)/cvitek/build \
		-DCMAKE_TOOLCHAIN_FILE=$(BUILD_PATH)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(BUILD_PATH)/cvitek/common
	cd $(BUILD_PATH)/cvitek/build/common && $(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) --build . --target install -- -v

	if [ ! -d $(BUILD_PATH)/cvitek/build/hal ]; then \
		mkdir -p $(BUILD_PATH)/cvitek/build/hal; \
	fi

	cd $(BUILD_PATH)/cvitek/build/hal && \
	$(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DTOP_DIR=$(BUILD_PATH)/cvitek \
		-DRUN_TYPE=CVIRTOS \
		-DBUILD_ENV_PATH=$(BUILD_PATH)/cvitek/build \
		-DCMAKE_TOOLCHAIN_FILE=$(BUILD_PATH)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		-DBOARD_FPGA=n \
		$(BUILD_PATH)/cvitek/hal/cv180x
	cd $(BUILD_PATH)/cvitek/build/hal && $(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) --build . --target install -- -v

	if [ ! -d $(BUILD_PATH)/cvitek/build/driver ]; then \
		mkdir -p $(BUILD_PATH)/cvitek/build/driver; \
	fi

	cd $(BUILD_PATH)/cvitek/build/driver && \
	$(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DTOP_DIR=$(BUILD_PATH)/cvitek \
		-DRUN_TYPE=CVIRTOS \
		-DBUILD_ENV_PATH=$(BUILD_PATH)/cvitek/build \
		-DBOARD_FPGA=n \
		-DCMAKE_TOOLCHAIN_FILE=$(BUILD_PATH)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(BUILD_PATH)/cvitek/driver
	cd $(BUILD_PATH)/cvitek/build/driver && $(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) --build . --target install -- -v

	if [ ! -d $(BUILD_PATH)/cvitek/build/task ]; then \
		mkdir -p $(BUILD_PATH)/cvitek/build/task; \
	fi

	cd $(BUILD_PATH)/cvitek/build/task && \
	$(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) -G Ninja -DCHIP=cv180x \
		-DRUN_ARCH=riscv64 \
		-DRUN_TYPE=CVIRTOS \
		-DTOP_DIR=$(BUILD_PATH)/cvitek \
		-DBUILD_ENV_PATH=$(BUILD_PATH)/cvitek/build \
		-DBOARD_FPGA=n \
		-DCMAKE_TOOLCHAIN_FILE=$(BUILD_PATH)/cvitek/scripts/toolchain-riscv64-elf.cmake \
		$(BUILD_PATH)/cvitek/task
	cd $(BUILD_PATH)/cvitek/build/task && $(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) --build . --target install -- -v
	cd $(BUILD_PATH)/cvitek/build/task && $(MK_ENV) CROSS_COMPILE=$(CROSS_COMPILE) $(TARGET_CMAKE) --build . --target cvirtos.bin -- -v

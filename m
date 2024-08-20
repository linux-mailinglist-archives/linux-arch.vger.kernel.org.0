Return-Path: <linux-arch+bounces-6377-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0CD9589C3
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 16:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4901C216E1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB419308F;
	Tue, 20 Aug 2024 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FyK8mSHn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9791946BA
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164591; cv=none; b=X8XBlLSm19Iw78RNHut2w+dq3jzckiMMaNHZi/3NAYGDIGxPNpIOE2nMe+x07274BLJQVLS0qbqw460FrK8bv6d0SXGiMY1jKhZOVUzAYwTJUd3VHTSTUJqjS+rxjSBBJfQJFLWM4Gepl2g39JBj/wXYkvtM0di+XFQVVkK+vIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164591; c=relaxed/simple;
	bh=p5DIYYPmnf5GAUCo2DGsMlFe4KWuwcB9Zgt0wGz5W7w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqetIoP78Q2RK8VwSXTqBW2/JSghILqhgrldY6Pe+msfZoEGkDRIhZ30VEBQjDlDnH0Xs55CfthdkIwr0KiANzMcaxPu8hQsu8GrYsR1odcyPRo1vwRRAoUkWFDFJXyOGtFDAn/+Qz2BoWe6QijKBgwRXWd+TtOwSfxbNB+qugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FyK8mSHn; arc=none smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-2f3cb747ed7so37959031fa.0
        for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164581; x=1724769381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpssDU0ANQ0XzdDxnha8iafuj4FS6tV1LC1H29qKgqc=;
        b=FyK8mSHnEZ3W75pXjHKUoBFmydEO+A7BOHk1lHSoxZXY5XAEVYSDX8WWsZpCqfVJdz
         8ImdKa70e0kGqKmxJgSGSCoe/hfzTz3QLAZTGwUbDCfKUEypswYEyeNSCp46jiI5KBT6
         VpBy4cI7ugfSSgrmcVp8I/cOgEwsci7uQnaWK84deHy3cdB0E9fdhFsT3ww66536mdsa
         ckGUJamzLpDFyW41NmlROOA15SmlooHJxCIwJr10UBy6wzIUsZXjL6lN26uJ45TlY/yv
         jbuaZQzhF4PY6HMKXYYPCEFpNAaaZDstW5RR5eAANft/e/PxTjGAd8UGVLCM8jzESmIn
         Ipwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164581; x=1724769381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpssDU0ANQ0XzdDxnha8iafuj4FS6tV1LC1H29qKgqc=;
        b=bklT/NyVft3csmGMyxnGZjWDS5PKluHBh0055KILYeFWynLk/XUvom+C4AtAr5UC6D
         dvQGaBq0x8v1pK5wU3omZamtUx92R5yPnshYkdb+jbPVHysKqMHSWXTu1rzo2V2ajfq+
         vWI9RR/XYDcjCNpFgH9E7SLdnqX+wzJbShQ465lqFdJKg9Y51TqOCEASLYDrn+XqTI4r
         PTEKK/PLMUID7hoM07cUrh/BN5SyqyHaRLTPBKUBdxYgjLQLb11+DBGIKD0vtRpCD/I8
         WYxd7BBeC8vX0o2exhS/vDfL/Lfhq6n1v9ROaJDCySw5vYP3mb9GO4bHyC9wHt1Igbvc
         vD5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpJ8CMMS6ww5vEWtJUf41mdHZE+fthmqfC6NmKz/pulOg37YyM7RRfc0nTSvwMuCemSjSiVQgCrf9kFudQvMOM0TmXvq9tf5xU7g==
X-Gm-Message-State: AOJu0YyoPNiMm/oxGYdF6gWXqIPllQKudPODTfQ82iwTDjXI6JkaOnpB
	hTFfnGlMa8tpQyERLjhoGrwOBUABMpOg1DLdOqsdcNgFyDAnZTZFBlIy/A1arxY=
X-Google-Smtp-Source: AGHT+IHzxFWw3egfmj0xIj7AQUPWFAaRy1NB6eQNNhxxRBm4y+LCCXnx0Ke/f+b2cD4VrJ1utTrwOQ==
X-Received: by 2002:a2e:a9a9:0:b0:2f3:ea34:596 with SMTP id 38308e7fff4ca-2f3ea34063amr22855301fa.44.1724164580168;
        Tue, 20 Aug 2024 07:36:20 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfa6a7sm6897409a12.40.2024.08.20.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:36:19 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 08/11] misc: rp1: RaspberryPi RP1 misc driver
Date: Tue, 20 Aug 2024 16:36:10 +0200
Message-ID: <5954e4dccc0e158cf434d2c281ad57120538409b.1724159867.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724159867.git.andrea.porta@suse.com>
References: <cover.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RaspberryPi RP1 is ia PCI multi function device containing
peripherals ranging from Ethernet to USB controller, I2C, SPI
and others.
Implement a bare minimum driver to operate the RP1, leveraging
actual OF based driver implementations for the on-borad peripherals
by loading a devicetree overlay during driver probe.
The peripherals are accessed by mapping MMIO registers starting
from PCI BAR1 region.
As a minimum driver, the peripherals will not be added to the
dtbo here, but in following patches.

Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 MAINTAINERS                           |   2 +
 arch/arm64/boot/dts/broadcom/rp1.dtso | 152 ++++++++++++
 drivers/misc/Kconfig                  |   1 +
 drivers/misc/Makefile                 |   1 +
 drivers/misc/rp1/Kconfig              |  20 ++
 drivers/misc/rp1/Makefile             |   3 +
 drivers/misc/rp1/rp1-pci.c            | 333 ++++++++++++++++++++++++++
 drivers/misc/rp1/rp1-pci.dtso         |   8 +
 drivers/pci/quirks.c                  |   1 +
 include/linux/pci_ids.h               |   3 +
 10 files changed, 524 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
 create mode 100644 drivers/misc/rp1/Kconfig
 create mode 100644 drivers/misc/rp1/Makefile
 create mode 100644 drivers/misc/rp1/rp1-pci.c
 create mode 100644 drivers/misc/rp1/rp1-pci.dtso

diff --git a/MAINTAINERS b/MAINTAINERS
index 67f460c36ea1..1359538b76e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19119,9 +19119,11 @@ F:	include/uapi/linux/media/raspberrypi/
 RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
+F:	arch/arm64/boot/dts/broadcom/rp1.dtso
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 F:	drivers/clk/clk-rp1.c
+F:	drivers/misc/rp1/
 F:	drivers/pinctrl/pinctrl-rp1.c
 F:	include/dt-bindings/clock/rp1.h
 F:	include/dt-bindings/misc/rp1.h
diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
new file mode 100644
index 000000000000..d80178a278ee
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/rp1.h>
+#include <dt-bindings/misc/rp1.h>
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target-path="";
+		__overlay__ {
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			rp1: rp1@0 {
+				compatible = "simple-bus";
+				#address-cells = <2>;
+				#size-cells = <2>;
+				interrupt-controller;
+				interrupt-parent = <&rp1>;
+				#interrupt-cells = <2>;
+
+				// ranges and dma-ranges must be provided by the includer
+				ranges = <0xc0 0x40000000
+					  0x01/*0x02000000*/ 0x00 0x00000000
+					  0x00 0x00400000>;
+
+				dma-ranges =
+				// inbound RP1 1x_xxxxxxxx -> PCIe 1x_xxxxxxxx
+					     <0x10 0x00000000
+					      0x43000000 0x10 0x00000000
+					      0x10 0x00000000>;
+
+				clk_xosc: clk_xosc {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-output-names = "xosc";
+					clock-frequency = <50000000>;
+				};
+
+				macb_pclk: macb_pclk {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-output-names = "pclk";
+					clock-frequency = <200000000>;
+				};
+
+				macb_hclk: macb_hclk {
+					compatible = "fixed-clock";
+					#clock-cells = <0>;
+					clock-output-names = "hclk";
+					clock-frequency = <200000000>;
+				};
+
+				rp1_clocks: clocks@c040018000 {
+					compatible = "raspberrypi,rp1-clocks";
+					#clock-cells = <1>;
+					reg = <0xc0 0x40018000 0x0 0x10038>;
+					clocks = <&clk_xosc>;
+					clock-names = "xosc";
+
+					assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
+							  <&rp1_clocks RP1_PLL_AUDIO_CORE>,
+							  // RP1_PLL_VIDEO_CORE and dividers are now managed by VEC,DPI drivers
+							  <&rp1_clocks RP1_PLL_SYS>,
+							  <&rp1_clocks RP1_PLL_SYS_SEC>,
+							  <&rp1_clocks RP1_PLL_SYS_PRI_PH>,
+							  <&rp1_clocks RP1_CLK_ETH_TSU>;
+
+					assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
+							       <1536000000>, // RP1_PLL_AUDIO_CORE
+							       <200000000>,  // RP1_PLL_SYS
+							       <125000000>,  // RP1_PLL_SYS_SEC
+							       <100000000>,  // RP1_PLL_SYS_PRI_PH
+							       <50000000>;   // RP1_CLK_ETH_TSU
+				};
+
+				rp1_gpio: pinctrl@c0400d0000 {
+					reg = <0xc0 0x400d0000  0x0 0xc000>,
+					      <0xc0 0x400e0000  0x0 0xc000>,
+					      <0xc0 0x400f0000  0x0 0xc000>;
+					compatible = "raspberrypi,rp1-gpio";
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <RP1_INT_IO_BANK0 IRQ_TYPE_LEVEL_HIGH>,
+						     <RP1_INT_IO_BANK1 IRQ_TYPE_LEVEL_HIGH>,
+						     <RP1_INT_IO_BANK2 IRQ_TYPE_LEVEL_HIGH>;
+					gpio-line-names =
+						"ID_SDA", // GPIO0
+						"ID_SCL", // GPIO1
+						"GPIO2", // GPIO2
+						"GPIO3", // GPIO3
+						"GPIO4", // GPIO4
+						"GPIO5", // GPIO5
+						"GPIO6", // GPIO6
+						"GPIO7", // GPIO7
+						"GPIO8", // GPIO8
+						"GPIO9", // GPIO9
+						"GPIO10", // GPIO10
+						"GPIO11", // GPIO11
+						"GPIO12", // GPIO12
+						"GPIO13", // GPIO13
+						"GPIO14", // GPIO14
+						"GPIO15", // GPIO15
+						"GPIO16", // GPIO16
+						"GPIO17", // GPIO17
+						"GPIO18", // GPIO18
+						"GPIO19", // GPIO19
+						"GPIO20", // GPIO20
+						"GPIO21", // GPIO21
+						"GPIO22", // GPIO22
+						"GPIO23", // GPIO23
+						"GPIO24", // GPIO24
+						"GPIO25", // GPIO25
+						"GPIO26", // GPIO26
+						"GPIO27", // GPIO27
+						"PCIE_RP1_WAKE", // GPIO28
+						"FAN_TACH", // GPIO29
+						"HOST_SDA", // GPIO30
+						"HOST_SCL", // GPIO31
+						"ETH_RST_N", // GPIO32
+						"", // GPIO33
+						"CD0_IO0_MICCLK", // GPIO34
+						"CD0_IO0_MICDAT0", // GPIO35
+						"RP1_PCIE_CLKREQ_N", // GPIO36
+						"", // GPIO37
+						"CD0_SDA", // GPIO38
+						"CD0_SCL", // GPIO39
+						"CD1_SDA", // GPIO40
+						"CD1_SCL", // GPIO41
+						"USB_VBUS_EN", // GPIO42
+						"USB_OC_N", // GPIO43
+						"RP1_STAT_LED", // GPIO44
+						"FAN_PWM", // GPIO45
+						"CD1_IO0_MICCLK", // GPIO46
+						"2712_WAKE", // GPIO47
+						"CD1_IO1_MICDAT1", // GPIO48
+						"EN_MAX_USB_CUR", // GPIO49
+						"", // GPIO50
+						"", // GPIO51
+						"", // GPIO52
+						""; // GPIO53
+				};
+			};
+		};
+	};
+};
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41c3d2821a78..02405209e6c4 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -618,4 +618,5 @@ source "drivers/misc/uacce/Kconfig"
 source "drivers/misc/pvpanic/Kconfig"
 source "drivers/misc/mchp_pci1xxxx/Kconfig"
 source "drivers/misc/keba/Kconfig"
+source "drivers/misc/rp1/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c2f990862d2b..84bfa866fbee 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -71,3 +71,4 @@ obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
 obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
 obj-y				+= keba/
+obj-$(CONFIG_MISC_RP1)		+= rp1/
diff --git a/drivers/misc/rp1/Kconfig b/drivers/misc/rp1/Kconfig
new file mode 100644
index 000000000000..050417ee09ae
--- /dev/null
+++ b/drivers/misc/rp1/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# RaspberryPi RP1 misc device
+#
+
+config MISC_RP1
+        tristate "RaspberryPi RP1 PCIe support"
+        depends on PCI && PCI_QUIRKS
+        select OF
+        select OF_OVERLAY
+        select IRQ_DOMAIN
+        select PCI_DYNAMIC_OF_NODES
+        help
+          Support for the RP1 peripheral chip found on Raspberry Pi 5 board.
+          This device supports several sub-devices including e.g. Ethernet controller,
+          USB controller, I2C, SPI and UART.
+          The driver is responsible for enabling the DT node once the PCIe endpoint
+          has been configured, and handling interrupts.
+          This driver uses an overlay to load other drivers to support for RP1
+          internal sub-devices.
diff --git a/drivers/misc/rp1/Makefile b/drivers/misc/rp1/Makefile
new file mode 100644
index 000000000000..e83854b4ed2c
--- /dev/null
+++ b/drivers/misc/rp1/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+rp1-pci-objs			:= rp1-pci.o rp1-pci.dtbo.o
+obj-$(CONFIG_MISC_RP1)		+= rp1-pci.o
diff --git a/drivers/misc/rp1/rp1-pci.c b/drivers/misc/rp1/rp1-pci.c
new file mode 100644
index 000000000000..a6093ba7e19a
--- /dev/null
+++ b/drivers/misc/rp1/rp1-pci.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-22 Raspberry Pi Ltd.
+ * All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+#include <dt-bindings/misc/rp1.h>
+
+#define RP1_B0_CHIP_ID		0x10001927
+#define RP1_C0_CHIP_ID		0x20001927
+
+#define RP1_PLATFORM_ASIC	BIT(1)
+#define RP1_PLATFORM_FPGA	BIT(0)
+
+#define RP1_DRIVER_NAME		"rp1"
+
+#define RP1_ACTUAL_IRQS		RP1_INT_END
+#define RP1_IRQS		RP1_ACTUAL_IRQS
+#define RP1_HW_IRQ_MASK		GENMASK(5, 0)
+
+#define RP1_SYSCLK_RATE		200000000
+#define RP1_SYSCLK_FPGA_RATE	60000000
+
+enum {
+	SYSINFO_CHIP_ID_OFFSET	= 0,
+	SYSINFO_PLATFORM_OFFSET	= 4,
+};
+
+#define REG_SET			0x800
+#define REG_CLR			0xc00
+
+/* MSIX CFG registers start at 0x8 */
+#define MSIX_CFG(x) (0x8 + (4 * (x)))
+
+#define MSIX_CFG_IACK_EN        BIT(3)
+#define MSIX_CFG_IACK           BIT(2)
+#define MSIX_CFG_TEST           BIT(1)
+#define MSIX_CFG_ENABLE         BIT(0)
+
+#define INTSTATL		0x108
+#define INTSTATH		0x10c
+
+extern char __dtbo_rp1_pci_begin[];
+extern char __dtbo_rp1_pci_end[];
+
+struct rp1_dev {
+	struct pci_dev *pdev;
+	struct device *dev;
+	struct clk *sys_clk;
+	struct irq_domain *domain;
+	struct irq_data *pcie_irqds[64];
+	void __iomem *bar1;
+	int ovcs_id;
+	bool level_triggered_irq[RP1_ACTUAL_IRQS];
+};
+
+static void dump_bar(struct pci_dev *pdev, unsigned int bar)
+{
+	dev_info(&pdev->dev,
+		 "bar%d len 0x%llx, start 0x%llx, end 0x%llx, flags, 0x%lx\n",
+		 bar,
+		 pci_resource_len(pdev, bar),
+		 pci_resource_start(pdev, bar),
+		 pci_resource_end(pdev, bar),
+		 pci_resource_flags(pdev, bar));
+}
+
+static void msix_cfg_set(struct rp1_dev *rp1, unsigned int hwirq, u32 value)
+{
+	iowrite32(value, rp1->bar1 + RP1_PCIE_APBS_BASE + REG_SET + MSIX_CFG(hwirq));
+}
+
+static void msix_cfg_clr(struct rp1_dev *rp1, unsigned int hwirq, u32 value)
+{
+	iowrite32(value, rp1->bar1 + RP1_PCIE_APBS_BASE + REG_CLR + MSIX_CFG(hwirq));
+}
+
+static void rp1_mask_irq(struct irq_data *irqd)
+{
+	struct rp1_dev *rp1 = irqd->domain->host_data;
+	struct irq_data *pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
+
+	pci_msi_mask_irq(pcie_irqd);
+}
+
+static void rp1_unmask_irq(struct irq_data *irqd)
+{
+	struct rp1_dev *rp1 = irqd->domain->host_data;
+	struct irq_data *pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
+
+	pci_msi_unmask_irq(pcie_irqd);
+}
+
+static int rp1_irq_set_type(struct irq_data *irqd, unsigned int type)
+{
+	struct rp1_dev *rp1 = irqd->domain->host_data;
+	unsigned int hwirq = (unsigned int)irqd->hwirq;
+	int ret = 0;
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		dev_dbg(rp1->dev, "MSIX IACK EN for irq %d\n", hwirq);
+		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
+		rp1->level_triggered_irq[hwirq] = true;
+	break;
+	case IRQ_TYPE_EDGE_RISING:
+		msix_cfg_clr(rp1, hwirq, MSIX_CFG_IACK_EN);
+		rp1->level_triggered_irq[hwirq] = false;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static struct irq_chip rp1_irq_chip = {
+	.name            = "rp1_irq_chip",
+	.irq_mask        = rp1_mask_irq,
+	.irq_unmask      = rp1_unmask_irq,
+	.irq_set_type    = rp1_irq_set_type,
+};
+
+static void rp1_chained_handle_irq(struct irq_desc *desc)
+{
+	unsigned int hwirq = desc->irq_data.hwirq & RP1_HW_IRQ_MASK;
+	struct rp1_dev *rp1 = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int virq;
+
+	chained_irq_enter(chip, desc);
+
+	virq = irq_find_mapping(rp1->domain, hwirq);
+	generic_handle_irq(virq);
+	if (rp1->level_triggered_irq[hwirq])
+		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK);
+
+	chained_irq_exit(chip, desc);
+}
+
+static int rp1_irq_xlate(struct irq_domain *d, struct device_node *node,
+			 const u32 *intspec, unsigned int intsize,
+			 unsigned long *out_hwirq, unsigned int *out_type)
+{
+	struct rp1_dev *rp1 = d->host_data;
+	struct irq_data *pcie_irqd;
+	unsigned long hwirq;
+	int pcie_irq;
+	int ret;
+
+	ret = irq_domain_xlate_twocell(d, node, intspec, intsize,
+				       &hwirq, out_type);
+	if (!ret) {
+		pcie_irq = pci_irq_vector(rp1->pdev, hwirq);
+		pcie_irqd = irq_get_irq_data(pcie_irq);
+		rp1->pcie_irqds[hwirq] = pcie_irqd;
+		*out_hwirq = hwirq;
+	}
+
+	return ret;
+}
+
+static int rp1_irq_activate(struct irq_domain *d, struct irq_data *irqd,
+			    bool reserve)
+{
+	struct rp1_dev *rp1 = d->host_data;
+	struct irq_data *pcie_irqd;
+
+	pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
+	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
+
+	return irq_domain_activate_irq(pcie_irqd, reserve);
+}
+
+static void rp1_irq_deactivate(struct irq_domain *d, struct irq_data *irqd)
+{
+	struct rp1_dev *rp1 = d->host_data;
+	struct irq_data *pcie_irqd;
+
+	pcie_irqd = rp1->pcie_irqds[irqd->hwirq];
+	msix_cfg_clr(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
+
+	return irq_domain_deactivate_irq(pcie_irqd);
+}
+
+static const struct irq_domain_ops rp1_domain_ops = {
+	.xlate      = rp1_irq_xlate,
+	.activate   = rp1_irq_activate,
+	.deactivate = rp1_irq_deactivate,
+};
+
+static int rp1_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *rp1_node;
+	struct reset_control *reset;
+	struct rp1_dev *rp1;
+	int err  = 0;
+	int i;
+
+	rp1_node = dev_of_node(dev);
+	if (!rp1_node) {
+		dev_err(dev, "Missing of_node for device\n");
+		return -EINVAL;
+	}
+
+	rp1 = devm_kzalloc(&pdev->dev, sizeof(*rp1), GFP_KERNEL);
+	if (!rp1)
+		return -ENOMEM;
+
+	rp1->pdev = pdev;
+	rp1->dev = &pdev->dev;
+
+	reset = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+	reset_control_reset(reset);
+
+	dump_bar(pdev, 0);
+	dump_bar(pdev, 1);
+
+	if (pci_resource_len(pdev, 1) <= 0x10000) {
+		dev_err(&pdev->dev,
+			"Not initialised - is the firmware running?\n");
+		return -EINVAL;
+	}
+
+	err = pcim_enable_device(pdev);
+	if (err < 0) {
+		dev_err(&pdev->dev, "Enabling PCI device has failed: %d",
+			err);
+		return err;
+	}
+
+	rp1->bar1 = pci_iomap(pdev, 1, 0);
+	if (!rp1->bar1) {
+		dev_err(&pdev->dev, "Cannot map PCI bar\n");
+		return -EIO;
+	}
+
+	u32 dtbo_size = __dtbo_rp1_pci_end - __dtbo_rp1_pci_begin;
+	void *dtbo_start = __dtbo_rp1_pci_begin;
+
+	err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &rp1->ovcs_id, rp1_node);
+	if (err)
+		goto err_unmap_bar;
+
+	pci_set_master(pdev);
+
+	err = pci_alloc_irq_vectors(pdev, RP1_IRQS, RP1_IRQS,
+				    PCI_IRQ_MSIX);
+	if (err != RP1_IRQS) {
+		dev_err(&pdev->dev, "pci_alloc_irq_vectors failed - %d\n", err);
+		goto err_unload_overlay;
+	}
+
+	pci_set_drvdata(pdev, rp1);
+	rp1->domain = irq_domain_add_linear(of_find_node_by_name(NULL, "rp1"), RP1_IRQS,
+					    &rp1_domain_ops, rp1);
+
+	for (i = 0; i < RP1_IRQS; i++) {
+		int irq = irq_create_mapping(rp1->domain, i);
+
+		if (irq < 0) {
+			dev_err(&pdev->dev, "failed to create irq mapping\n");
+			err = irq;
+			goto err_unload_overlay;
+		}
+		irq_set_chip_and_handler(irq, &rp1_irq_chip, handle_level_irq);
+		irq_set_probe(irq);
+		irq_set_chained_handler_and_data(pci_irq_vector(pdev, i),
+						 rp1_chained_handle_irq, rp1);
+	}
+
+	err = of_platform_default_populate(rp1_node, NULL, dev);
+	if (err)
+		goto err_unload_overlay;
+
+	return 0;
+
+err_unload_overlay:
+	of_overlay_remove(&rp1->ovcs_id);
+err_unmap_bar:
+	pci_iounmap(pdev, rp1->bar1);
+
+	return err;
+}
+
+static void rp1_remove(struct pci_dev *pdev)
+{
+	struct rp1_dev *rp1 = pci_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	of_platform_depopulate(dev);
+	pci_iounmap(pdev, rp1->bar1);
+	of_overlay_remove(&rp1->ovcs_id);
+
+	clk_unregister(rp1->sys_clk);
+}
+
+static const struct pci_device_id dev_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RP1_C0), },
+	{ 0, }
+};
+
+static struct pci_driver rp1_driver = {
+	.name		= RP1_DRIVER_NAME,
+	.id_table	= dev_id_table,
+	.probe		= rp1_probe,
+	.remove		= rp1_remove,
+};
+
+module_pci_driver(rp1_driver);
+
+MODULE_AUTHOR("Phil Elwell <phil@raspberrypi.com>");
+MODULE_DESCRIPTION("RP1 wrapper");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/rp1/rp1-pci.dtso b/drivers/misc/rp1/rp1-pci.dtso
new file mode 100644
index 000000000000..0bf2f4bb18e6
--- /dev/null
+++ b/drivers/misc/rp1/rp1-pci.dtso
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/* the dts overlay is included from the dts directory so
+ * it can be possible to check it with CHECK_DTBS while
+ * also compile it from the driver source directory.
+ */
+
+#include "arm64/broadcom/rp1.dtso"
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index a2ce4e08edf5..8c2e6238535e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6245,6 +6245,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_RPI, PCI_DEVICE_ID_RP1_C0, of_pci_make_dev_node);
 
 /*
  * Devices known to require a longer delay before first config space access
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e388c8b1cbc2..2120f2895bb8 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2610,6 +2610,9 @@
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
 #define PCI_DEVICE_ID_TEKRAM_DC290	0xdc29
 
+#define PCI_VENDOR_ID_RPI		0x1de4
+#define PCI_DEVICE_ID_RP1_C0		0x0001
+
 #define PCI_VENDOR_ID_ALIBABA		0x1ded
 
 #define PCI_VENDOR_ID_CXL		0x1e98
-- 
2.35.3



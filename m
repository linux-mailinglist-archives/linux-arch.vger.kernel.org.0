Return-Path: <linux-arch+bounces-6371-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A80958995
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 16:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4031C20FD9
	for <lists+linux-arch@lfdr.de>; Tue, 20 Aug 2024 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690EF193060;
	Tue, 20 Aug 2024 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M6ugdnCi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C0D1917F3
	for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164581; cv=none; b=GAzzBi7GE7PM/Vd98dPQcc1kRwvpx5l0bO6hX7/0Pj1zPWi2l+sNY0Hc/jWTU8J7X5FokS8UwgLIUKRfx3GjF6pE+pk599zHeg8nT2O2gC7vdxHFKsF4WooCZBTctQu9K7KR2wVBM4b3YqUsepEtgbFxy+Wf2oebHlA8aKH0P78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164581; c=relaxed/simple;
	bh=CXk3gZVzsrKbIzWOgNZGBf2mcrHqL/Z/BDFVfEUhCzY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfeWy4Yz9KRTGLGi3BWs+r2SX1pKKQu6pDFvnhIC01QwZRff8cLgACJbIPLZM0ZyQGzbDVUoE/enq7v4LEzePBiHXfNjNaoNrNOHGb/jB9u4QGTEoj5ZpJf7GpFSrbVEcF+wbSNBJBoo+XkW7qN7mO3tze0v3oKYIZcuMAnnt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M6ugdnCi; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a86464934e3so131209366b.3
        for <linux-arch@vger.kernel.org>; Tue, 20 Aug 2024 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164574; x=1724769374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YUoEHOyo3mbRqQ7po+1SqcXbAOaAYN/hfkfXz6cOpww=;
        b=M6ugdnCiJJh39mmJcerWQ7KkzDxHbifbfF0hdqSUqoz7fvhnrP478U6cnZWupt1VRe
         YL9ikkDCOSOs/6I/wDR6V+n20VuGEhyNSgfFFVQ/lcpoSw+LGgEFNn2Mv6Qn+2sg+8Z+
         bu0Rcn0upzG8b6HOBb9MvRHZ0ZA2F+2vz2JOhTTcMoQn97R3tAUx8wP3qFb1/P2ktpD9
         1UVXbcJurIKSF9XgpJn0nmlFbVxY1jPSiOXy+SsZbnfsQ64okPlC8+V8xtJC+A3UqJrl
         LpISYVaj+tm58vMfZ7x4Bd5iJYx/tm18NfkyMi1jQWzqCpTaJvibNynsv1iMbKAvGcBN
         uglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164574; x=1724769374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUoEHOyo3mbRqQ7po+1SqcXbAOaAYN/hfkfXz6cOpww=;
        b=VIhGR70rI7PSr/fJ8FyMm6Tb9j7rxJ3dUyrO19INiNrMWT274+gKLCYqkgyYioD0eN
         /UZmAUSJInpWasR4ktt/hTmF1yDxeHSsd2FXpqJp5BVjgjteF5LImDSxoeOh2vJ2aUOz
         pe4JeUH9TAcZ8NvmrIVYmOG+eGv5aitdKUSLvZ4xukuFh2X0t9jm3QCe43IzjA093t66
         NmbO/a0e5wx4vQ1TOMsggFrBMqIIIcmBQkyXQtdIV8AoFlpW2QdwOtguyWrRQJSUII5S
         9iW3JsAKUzDowB7surAY6Rg0OiKSgyHqjb3AKSTOwizOkJhPx5ma+yzA1WKK1BY/0bOM
         9i+w==
X-Forwarded-Encrypted: i=1; AJvYcCWHINXoELcICceIfNHwFfKQ7zDFPJ8L1QU+C9CqlV1beV8MFDbzWrz8p15f/iGJAdUgDgiGrSVPiEII@vger.kernel.org
X-Gm-Message-State: AOJu0YykyxTZcMXiYOUCuayWfvumsBQG5sXjAfTu1ZE4XkmnCZhwl4wK
	2UyRxg7CwoLOVBtbvB/E4m7kqrWLO9k9Au5T8E6qq16RPB2Ylgxn71oSvsaaBMw=
X-Google-Smtp-Source: AGHT+IHpdj6e+9gsmHibP7nfJCkihn0972wUjS1mYY2IECCpQRmv9YzBQKBG5pL700WFc1lSLWbiQw==
X-Received: by 2002:a17:907:2da6:b0:a7a:9144:e23b with SMTP id a640c23a62f3a-a83928d3597mr956230466b.19.1724164573460;
        Tue, 20 Aug 2024 07:36:13 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6a76sm768408766b.38.2024.08.20.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:36:13 -0700 (PDT)
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
Subject: [PATCH 02/11] dt-bindings: pinctrl: Add RaspberryPi RP1 gpio/pinctrl/pinmux bindings
Date: Tue, 20 Aug 2024 16:36:04 +0200
Message-ID: <82d57814075ed1bc76bf17bde124c5c83925ac59.1724159867.git.andrea.porta@suse.com>
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

Add device tree bindings for the gpio/pin/mux controller that is part of
the RP1 multi function device, and relative entries in MAINTAINERS file.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../pinctrl/raspberrypi,rp1-gpio.yaml         | 177 +++++++++++++
 MAINTAINERS                                   |   2 +
 include/dt-bindings/misc/rp1.h                | 235 ++++++++++++++++++
 3 files changed, 414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 create mode 100644 include/dt-bindings/misc/rp1.h

diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
new file mode 100644
index 000000000000..7011fa258363
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
@@ -0,0 +1,177 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/raspberrypi,rp1-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RaspberryPi RP1 GPIO/Pinconf/Pinmux Controller submodule
+
+maintainers:
+  - Andrea della Porta <andrea.porta@suse.com>
+
+description:
+  The RP1 chipset is a Multi Function Device containing, among other sub-peripherals,
+  a gpio/pinconf/mux controller whose 54 pins are grouped into 3 banks. It works also
+  as an interrupt controller for those gpios.
+
+  Each pin configuration node lists the pin(s) to which it applies, and one or
+  more of the mux function to select on those pin(s), and their configuration.
+  The pin configuration and multiplexing supports the generic bindings.
+  For details on each properties (including the meaning of "pin configuration node"),
+  you can refer to ./pinctrl-bindings.txt.
+
+properties:
+  compatible:
+    const: raspberrypi,rp1-gpio
+
+  reg:
+    minItems: 3
+    maxItems: 3
+    description: One reg specifier for each one of the 3 pin banks.
+
+  '#gpio-cells':
+    description: The first cell is the pin number and the second cell is used
+      to specify the flags (see include/dt-bindings/gpio/gpio.h).
+    const: 2
+
+  gpio-controller: true
+
+  gpio-ranges:
+    maxItems: 1
+
+  gpio-line-names:
+    maxItems: 54
+
+  interrupts:
+    minItems: 3
+    maxItems: 3
+    description: One interrupt specifier for each one of the 3 pin banks.
+
+  '#interrupt-cells':
+    description:
+      Specifies the Bank number (as specified in include/dt-bindings/misc/rp1.h)
+      and Flags (as defined in (include/dt-bindings/interrupt-controller/irq.h).
+      Possible values for the Bank number are
+          RP1_INT_IO_BANK0
+          RP1_INT_IO_BANK1
+          RP1_INT_IO_BANK2
+    const: 2
+
+  interrupt-controller: true
+
+additionalProperties:
+  anyOf:
+    - type: object
+      additionalProperties: false
+      allOf:
+        - $ref: pincfg-node.yaml#
+        - $ref: pinmux-node.yaml#
+
+      description:
+        Pin controller client devices use pin configuration subnodes (children
+        and grandchildren) for desired pin configuration.
+        Client device subnodes use below standard properties.
+
+      properties:
+        pins:
+          description:
+            A string (or list of strings) adhering to the pattern "gpio[0-5][0-9]"
+        function: true
+        bias-disable: true
+        bias-pull-down: true
+        bias-pull-up: true
+        slew-rate:
+          description: 0 is slow slew rate, 1 is fast slew rate
+          enum: [ 0, 1 ]
+        drive-strength:
+          description: 0 -> 2mA, 1 -> 4mA, 2 -> 8mA, 3 -> 12mA
+          enum: [ 0, 1, 2, 3 ]
+
+    - type: object
+      additionalProperties:
+        $ref: "#/additionalProperties/anyOf/0"
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - reg
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+  - interrupts
+  - "#interrupt-cells"
+  - interrupt-controller
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/misc/rp1.h>
+
+    rp1 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        rp1_gpio: pinctrl@c0400d0000 {
+            reg = <0xc0 0x400d0000  0x0 0xc000>,
+                  <0xc0 0x400e0000  0x0 0xc000>,
+                  <0xc0 0x400f0000  0x0 0xc000>;
+            compatible = "raspberrypi,rp1-gpio";
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <RP1_INT_IO_BANK0 IRQ_TYPE_LEVEL_HIGH>,
+                         <RP1_INT_IO_BANK1 IRQ_TYPE_LEVEL_HIGH>,
+                         <RP1_INT_IO_BANK2 IRQ_TYPE_LEVEL_HIGH>;
+            gpio-line-names =
+                   "ID_SDA", // GPIO0
+                   "ID_SCL", // GPIO1
+                   "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6",
+                   "GPIO7", "GPIO8", "GPIO9", "GPIO10", "GPIO11",
+                   "GPIO12", "GPIO13", "GPIO14", "GPIO15", "GPIO16",
+                   "GPIO17", "GPIO18", "GPIO19", "GPIO20", "GPIO21",
+                   "GPIO22", "GPIO23", "GPIO24", "GPIO25", "GPIO26",
+                   "GPIO27",
+                   "PCIE_RP1_WAKE", // GPIO28
+                   "FAN_TACH", // GPIO29
+                   "HOST_SDA", // GPIO30
+                   "HOST_SCL", // GPIO31
+                   "ETH_RST_N", // GPIO32
+                   "", // GPIO33
+                   "CD0_IO0_MICCLK", // GPIO34
+                   "CD0_IO0_MICDAT0", // GPIO35
+                   "RP1_PCIE_CLKREQ_N", // GPIO36
+                   "", // GPIO37
+                   "CD0_SDA", // GPIO38
+                   "CD0_SCL", // GPIO39
+                   "CD1_SDA", // GPIO40
+                   "CD1_SCL", // GPIO41
+                   "USB_VBUS_EN", // GPIO42
+                   "USB_OC_N", // GPIO43
+                   "RP1_STAT_LED", // GPIO44
+                   "FAN_PWM", // GPIO45
+                   "CD1_IO0_MICCLK", // GPIO46
+                   "2712_WAKE", // GPIO47
+                   "CD1_IO1_MICDAT1", // GPIO48
+                   "EN_MAX_USB_CUR", // GPIO49
+                   "", // GPIO50
+                   "", // GPIO51
+                   "", // GPIO52
+                   ""; // GPIO53
+
+            rp1_uart0_14_15: rp1_uart0_14_15 {
+                pin_txd {
+                    function = "uart0";
+                    pins = "gpio14";
+                    bias-disable;
+                };
+
+                pin_rxd {
+                    function = "uart0";
+                    pins = "gpio15";
+                    bias-pull-up;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7db9bce278..c5018232c251 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19120,7 +19120,9 @@ RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
+F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 F:	include/dt-bindings/clock/rp1.h
+F:	include/dt-bindings/misc/rp1.h
 
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
diff --git a/include/dt-bindings/misc/rp1.h b/include/dt-bindings/misc/rp1.h
new file mode 100644
index 000000000000..6dd5e23870c2
--- /dev/null
+++ b/include/dt-bindings/misc/rp1.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * This header provides constants for the PY MFD.
+ */
+
+#ifndef _RP1_H
+#define _RP1_H
+
+/* Address map */
+#define RP1_SYSINFO_BASE 0x000000
+#define RP1_TBMAN_BASE 0x004000
+#define RP1_SYSCFG_BASE 0x008000
+#define RP1_OTP_BASE 0x00c000
+#define RP1_POWER_BASE 0x010000
+#define RP1_RESETS_BASE 0x014000
+#define RP1_CLOCKS_BANK_DEFAULT_BASE 0x018000
+#define RP1_CLOCKS_BANK_VIDEO_BASE 0x01c000
+#define RP1_PLL_SYS_BASE 0x020000
+#define RP1_PLL_AUDIO_BASE 0x024000
+#define RP1_PLL_VIDEO_BASE 0x028000
+#define RP1_UART0_BASE 0x030000
+#define RP1_UART1_BASE 0x034000
+#define RP1_UART2_BASE 0x038000
+#define RP1_UART3_BASE 0x03c000
+#define RP1_UART4_BASE 0x040000
+#define RP1_UART5_BASE 0x044000
+#define RP1_SPI8_BASE 0x04c000
+#define RP1_SPI0_BASE 0x050000
+#define RP1_SPI1_BASE 0x054000
+#define RP1_SPI2_BASE 0x058000
+#define RP1_SPI3_BASE 0x05c000
+#define RP1_SPI4_BASE 0x060000
+#define RP1_SPI5_BASE 0x064000
+#define RP1_SPI6_BASE 0x068000
+#define RP1_SPI7_BASE 0x06c000
+#define RP1_I2C0_BASE 0x070000
+#define RP1_I2C1_BASE 0x074000
+#define RP1_I2C2_BASE 0x078000
+#define RP1_I2C3_BASE 0x07c000
+#define RP1_I2C4_BASE 0x080000
+#define RP1_I2C5_BASE 0x084000
+#define RP1_I2C6_BASE 0x088000
+#define RP1_AUDIO_IN_BASE 0x090000
+#define RP1_AUDIO_OUT_BASE 0x094000
+#define RP1_PWM0_BASE 0x098000
+#define RP1_PWM1_BASE 0x09c000
+#define RP1_I2S0_BASE 0x0a0000
+#define RP1_I2S1_BASE 0x0a4000
+#define RP1_I2S2_BASE 0x0a8000
+#define RP1_TIMER_BASE 0x0ac000
+#define RP1_SDIO0_APBS_BASE 0x0b0000
+#define RP1_SDIO1_APBS_BASE 0x0b4000
+#define RP1_BUSFABRIC_MONITOR_BASE 0x0c0000
+#define RP1_BUSFABRIC_AXISHIM_BASE 0x0c4000
+#define RP1_ADC_BASE 0x0c8000
+#define RP1_IO_BANK0_BASE 0x0d0000
+#define RP1_IO_BANK1_BASE 0x0d4000
+#define RP1_IO_BANK2_BASE 0x0d8000
+#define RP1_SYS_RIO0_BASE 0x0e0000
+#define RP1_SYS_RIO1_BASE 0x0e4000
+#define RP1_SYS_RIO2_BASE 0x0e8000
+#define RP1_PADS_BANK0_BASE 0x0f0000
+#define RP1_PADS_BANK1_BASE 0x0f4000
+#define RP1_PADS_BANK2_BASE 0x0f8000
+#define RP1_PADS_ETH_BASE 0x0fc000
+#define RP1_ETH_IP_BASE 0x100000
+#define RP1_ETH_CFG_BASE 0x104000
+#define RP1_PCIE_APBS_BASE 0x108000
+#define RP1_MIPI0_CSIDMA_BASE 0x110000
+#define RP1_MIPI0_CSIHOST_BASE 0x114000
+#define RP1_MIPI0_DSIDMA_BASE 0x118000
+#define RP1_MIPI0_DSIHOST_BASE 0x11c000
+#define RP1_MIPI0_MIPICFG_BASE 0x120000
+#define RP1_MIPI0_ISP_BASE 0x124000
+#define RP1_MIPI1_CSIDMA_BASE 0x128000
+#define RP1_MIPI1_CSIHOST_BASE 0x12c000
+#define RP1_MIPI1_DSIDMA_BASE 0x130000
+#define RP1_MIPI1_DSIHOST_BASE 0x134000
+#define RP1_MIPI1_MIPICFG_BASE 0x138000
+#define RP1_MIPI1_ISP_BASE 0x13c000
+#define RP1_VIDEO_OUT_CFG_BASE 0x140000
+#define RP1_VIDEO_OUT_VEC_BASE 0x144000
+#define RP1_VIDEO_OUT_DPI_BASE 0x148000
+#define RP1_XOSC_BASE 0x150000
+#define RP1_WATCHDOG_BASE 0x154000
+#define RP1_DMA_TICK_BASE 0x158000
+#define RP1_SDIO_CLOCKS_BASE 0x15c000
+#define RP1_USBHOST0_APBS_BASE 0x160000
+#define RP1_USBHOST1_APBS_BASE 0x164000
+#define RP1_ROSC0_BASE 0x168000
+#define RP1_ROSC1_BASE 0x16c000
+#define RP1_VBUSCTRL_BASE 0x170000
+#define RP1_TICKS_BASE 0x174000
+#define RP1_PIO_APBS_BASE 0x178000
+#define RP1_SDIO0_AHBLS_BASE 0x180000
+#define RP1_SDIO1_AHBLS_BASE 0x184000
+#define RP1_DMA_BASE 0x188000
+#define RP1_RAM_BASE 0x1c0000
+#define RP1_RAM_SIZE 0x020000
+#define RP1_USBHOST0_AXIS_BASE 0x200000
+#define RP1_USBHOST1_AXIS_BASE 0x300000
+#define RP1_EXAC_BASE 0x400000
+
+/* Interrupts */
+
+#define RP1_INT_IO_BANK0 0
+#define RP1_INT_IO_BANK1 1
+#define RP1_INT_IO_BANK2 2
+#define RP1_INT_AUDIO_IN 3
+#define RP1_INT_AUDIO_OUT 4
+#define RP1_INT_PWM0 5
+#define RP1_INT_ETH 6
+#define RP1_INT_I2C0 7
+#define RP1_INT_I2C1 8
+#define RP1_INT_I2C2 9
+#define RP1_INT_I2C3 10
+#define RP1_INT_I2C4 11
+#define RP1_INT_I2C5 12
+#define RP1_INT_I2C6 13
+#define RP1_INT_I2S0 14
+#define RP1_INT_I2S1 15
+#define RP1_INT_I2S2 16
+#define RP1_INT_SDIO0 17
+#define RP1_INT_SDIO1 18
+#define RP1_INT_SPI0 19
+#define RP1_INT_SPI1 20
+#define RP1_INT_SPI2 21
+#define RP1_INT_SPI3 22
+#define RP1_INT_SPI4 23
+#define RP1_INT_SPI5 24
+#define RP1_INT_UART0 25
+#define RP1_INT_TIMER_0 26
+#define RP1_INT_TIMER_1 27
+#define RP1_INT_TIMER_2 28
+#define RP1_INT_TIMER_3 29
+#define RP1_INT_USBHOST0 30
+#define RP1_INT_USBHOST0_0 31
+#define RP1_INT_USBHOST0_1 32
+#define RP1_INT_USBHOST0_2 33
+#define RP1_INT_USBHOST0_3 34
+#define RP1_INT_USBHOST1 35
+#define RP1_INT_USBHOST1_0 36
+#define RP1_INT_USBHOST1_1 37
+#define RP1_INT_USBHOST1_2 38
+#define RP1_INT_USBHOST1_3 39
+#define RP1_INT_DMA 40
+#define RP1_INT_PWM1 41
+#define RP1_INT_UART1 42
+#define RP1_INT_UART2 43
+#define RP1_INT_UART3 44
+#define RP1_INT_UART4 45
+#define RP1_INT_UART5 46
+#define RP1_INT_MIPI0 47
+#define RP1_INT_MIPI1 48
+#define RP1_INT_VIDEO_OUT 49
+#define RP1_INT_PIO_0 50
+#define RP1_INT_PIO_1 51
+#define RP1_INT_ADC_FIFO 52
+#define RP1_INT_PCIE_OUT 53
+#define RP1_INT_SPI6 54
+#define RP1_INT_SPI7 55
+#define RP1_INT_SPI8 56
+#define RP1_INT_SYSCFG 58
+#define RP1_INT_CLOCKS_DEFAULT 59
+#define RP1_INT_VBUSCTRL 60
+#define RP1_INT_PROC_MISC 57
+#define RP1_INT_END 61
+
+/* DMA peripherals (for pacing) */
+#define RP1_DMA_I2C0_RX 0x0
+#define RP1_DMA_I2C0_TX 0x1
+#define RP1_DMA_I2C1_RX 0x2
+#define RP1_DMA_I2C1_TX 0x3
+#define RP1_DMA_I2C2_RX 0x4
+#define RP1_DMA_I2C2_TX 0x5
+#define RP1_DMA_I2C3_RX 0x6
+#define RP1_DMA_I2C3_TX 0x7
+#define RP1_DMA_I2C4_RX 0x8
+#define RP1_DMA_I2C4_TX 0x9
+#define RP1_DMA_I2C5_RX 0xa
+#define RP1_DMA_I2C5_TX 0xb
+#define RP1_DMA_SPI0_RX 0xc
+#define RP1_DMA_SPI0_TX 0xd
+#define RP1_DMA_SPI1_RX 0xe
+#define RP1_DMA_SPI1_TX 0xf
+#define RP1_DMA_SPI2_RX 0x10
+#define RP1_DMA_SPI2_TX 0x11
+#define RP1_DMA_SPI3_RX 0x12
+#define RP1_DMA_SPI3_TX 0x13
+#define RP1_DMA_SPI4_RX 0x14
+#define RP1_DMA_SPI4_TX 0x15
+#define RP1_DMA_SPI5_RX 0x16
+#define RP1_DMA_SPI5_TX 0x17
+#define RP1_DMA_PWM0 0x18
+#define RP1_DMA_UART0_RX 0x19
+#define RP1_DMA_UART0_TX 0x1a
+#define RP1_DMA_AUDIO_IN_CH0 0x1b
+#define RP1_DMA_AUDIO_IN_CH1 0x1c
+#define RP1_DMA_AUDIO_OUT 0x1d
+#define RP1_DMA_PWM1 0x1e
+#define RP1_DMA_I2S0_RX 0x1f
+#define RP1_DMA_I2S0_TX 0x20
+#define RP1_DMA_I2S1_RX 0x21
+#define RP1_DMA_I2S1_TX 0x22
+#define RP1_DMA_I2S2_RX 0x23
+#define RP1_DMA_I2S2_TX 0x24
+#define RP1_DMA_UART1_RX 0x25
+#define RP1_DMA_UART1_TX 0x26
+#define RP1_DMA_UART2_RX 0x27
+#define RP1_DMA_UART2_TX 0x28
+#define RP1_DMA_UART3_RX 0x29
+#define RP1_DMA_UART3_TX 0x2a
+#define RP1_DMA_UART4_RX 0x2b
+#define RP1_DMA_UART4_TX 0x2c
+#define RP1_DMA_UART5_RX 0x2d
+#define RP1_DMA_UART5_TX 0x2e
+#define RP1_DMA_ADC 0x2f
+#define RP1_DMA_DMA_TICK_TICK0 0x30
+#define RP1_DMA_DMA_TICK_TICK1 0x31
+#define RP1_DMA_SPI6_RX 0x32
+#define RP1_DMA_SPI6_TX 0x33
+#define RP1_DMA_SPI7_RX 0x34
+#define RP1_DMA_SPI7_TX 0x35
+#define RP1_DMA_SPI8_RX 0x36
+#define RP1_DMA_SPI8_TX 0x37
+#define RP1_DMA_PIO_CH0_TX 0x38
+#define RP1_DMA_PIO_CH0_RX 0x39
+#define RP1_DMA_PIO_CH1_TX 0x3a
+#define RP1_DMA_PIO_CH1_RX 0x3b
+#define RP1_DMA_PIO_CH2_TX 0x3c
+#define RP1_DMA_PIO_CH2_RX 0x3d
+#define RP1_DMA_PIO_CH3_TX 0x3e
+#define RP1_DMA_PIO_CH3_RX 0x3f
+
+#endif
-- 
2.35.3



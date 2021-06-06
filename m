Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E239CE50
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 11:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFFJHl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 05:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhFFJHb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 05:07:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B57B61420;
        Sun,  6 Jun 2021 09:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622970342;
        bh=Pb26qSYgqSZkgm2+zHaeL+r+s/hn8Bf6c5rxTNsuaCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pO2juAnBpF7yiE0t7aIO90ePSpqdhI7gcpnWC1++7th2o9PoOhVgjOSCey0J7AUG5
         I/ZFlE3E5mQwv7TKidIVJPYdUKyQJIZ7H3ymMwuyOUgyBp28rWyt8yQMKCGCKaJCbZ
         jYmjRe0GwrGR822mCzNlVrNEt7Uag2jEHIaw4RuXEEjyhhPUYKcov6DWNeTHrU2CsB
         xjw2Wl06knkGRwnIqNWFULCRMm8ZVRCbyOLUYWJoI64nm/FAhURvwcJH7B55ZgRbE8
         A7YJ1ZyVxpBtIEUtFPYkuKdjEhSiyyscNmJUtKeZ3tC8jxEwwsL2qXeLtkfCIhi99X
         vycihnlCzvfYg==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        drew@beagleboard.org, liush@allwinnertech.com,
        lazyparser@gmail.com, wefu@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCH v2 09/11] riscv: soc: Initial DTS for Allwinner D1 NeZha board
Date:   Sun,  6 Jun 2021 09:04:07 +0000
Message-Id: <1622970249-50770-13-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622970249-50770-1-git-send-email-guoren@kernel.org>
References: <1622970249-50770-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add initial DTS for Allwinner D1 NeZha board having only essential
devices (uart, dummy, clock, reset, clint, plic, etc).

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-Developed-by: Liu Shaohua <liush@allwinnertech.com>
Signed-off-by: Liu Shaohua <liush@allwinnertech.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
---
 arch/riscv/boot/dts/Makefile                       |  1 +
 arch/riscv/boot/dts/allwinner/Makefile             |  2 +
 .../boot/dts/allwinner/allwinner-d1-nezha-kit.dts  | 29 ++++++++
 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi    | 84 ++++++++++++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 arch/riscv/boot/dts/allwinner/Makefile
 create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
 create mode 100644 arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index fe996b8..3e7b264 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -2,5 +2,6 @@
 subdir-y += sifive
 subdir-$(CONFIG_SOC_CANAAN_K210_DTB_BUILTIN) += canaan
 subdir-y += microchip
+subdir-y += allwinner
 
 obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
diff --git a/arch/riscv/boot/dts/allwinner/Makefile b/arch/riscv/boot/dts/allwinner/Makefile
new file mode 100644
index 00000000..4adbf4b
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_SUNXI) += allwinner-d1-nezha-kit.dtb
diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
new file mode 100644
index 00000000..cd9f7c9
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/allwinner-d1-nezha-kit.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "allwinner-d1.dtsi"
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Allwinner D1 NeZha Kit";
+	compatible = "allwinner,d1-nezha-kit";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &serial0;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0x20000000>;
+	};
+
+	soc {
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
new file mode 100644
index 00000000..11cd938
--- /dev/null
+++ b/arch/riscv/boot/dts/allwinner/allwinner-d1.dtsi
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Allwinner D1 Soc";
+	compatible = "allwinner,d1-nezha-kit";
+
+	chosen {
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <2400000>;
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			status = "okay";
+			compatible = "riscv";
+			riscv,isa = "rv64imafdcv";
+			mmu-type = "riscv,sv39";
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		reset: reset-sample {
+			compatible = "thead,reset-sample";
+			plic-delegate = <0x0 0x101ffffc>;
+		};
+
+		clint: clint@14000000 {
+			compatible = "riscv,clint0";
+			interrupts-extended = <
+				&cpu0_intc  3 &cpu0_intc  7
+				>;
+			reg = <0x0 0x14000000 0x0 0x04000000>;
+			clint,has-no-64bit-mmio;
+		};
+
+		plic: interrupt-controller@10000000 {
+			#interrupt-cells = <1>;
+			compatible = "riscv,plic0";
+			interrupt-controller;
+			interrupts-extended = <
+				&cpu0_intc  0xffffffff &cpu0_intc  9
+				>;
+			reg = <0x0 0x10000000 0x0 0x04000000>;
+			reg-names = "control";
+			riscv,max-priority = <7>;
+			riscv,ndev = <200>;
+		};
+
+		dummy_apb: apb-clock {
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			clock-output-names = "dummy_apb";
+			#clock-cells = <0>;
+		};
+
+		serial0: serial@2500000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x02500000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <18>;
+			clocks = <&dummy_apb>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.7.4


Return-Path: <linux-arch+bounces-7042-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABEB96CB1C
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E854E280FB0
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFA118BB84;
	Wed,  4 Sep 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqTwTwVU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD7718A956;
	Wed,  4 Sep 2024 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493706; cv=none; b=BaSm+PYprF+jYrgf5YoTurczOgNNqH2yCfefhImtMoYevfwR2EWjwBqm+AdQcQmq9fKmOCHo8aBd0SpzBN4mA4D2fc4b6EYOC5ALkHtREVhE8XVSzAa73r3kGZwq/unKdSSEXRjc3+1SRzr2TJs5s2CUaOgcprr1rLzTuhfPVIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493706; c=relaxed/simple;
	bh=DmABIXiqMlKjw8vipv0+VS4xuXqSDmbddSZqsqM36bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qe0HoE0IGB+h9h+9qKreOW3yaptqJz+YB7gj3Nnz+IgW0lEMyQnoeBmAMzaalU3HTZ6Q1fB9umaSUz1Nx162bTq2QxBtrTHU8/0F/fiqDfj4M4Fl4VpzWTT8xUqZL+SbphqBfcCLEOrMKeRoEtsmWGB3gJ2wNN1g0VNfr4QMIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqTwTwVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAF6C4CEC3;
	Wed,  4 Sep 2024 23:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493706;
	bh=DmABIXiqMlKjw8vipv0+VS4xuXqSDmbddSZqsqM36bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BqTwTwVUZAur7/lg6dVvjAba6rF+NIKCS18IWBXb15+i1RLEpZJqVGotXHZD/Kph2
	 rfGFjbDa7oCFYwXWzp+WsRUXfNd7/a/eaMn8FHX3+Uo608D+NiB0yHuhG25DV0sjzt
	 zj1TswqP2EkTIfZHwtC0OAJIokeP6d7dvhs5tenp+SawsbA7SdVrwh2aQAtp0XETDT
	 AYYVARz8k1MQ3tDHM+Grlq3oBrmS5NVWn5t5VIApa0e9eOcGLpDzhjRpWcyo0KQ7e4
	 oRZHiEYui/jbhI/h0WPFvxZ4/0OMF9D7BJF1drBmVjszV65kgm284tO+Zzh80HV5KF
	 vmwblpvwGdtaA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	Dinh Nguyen <dinguyen@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 05/15] MIPS: migrate to generic rule for built-in DTBs
Date: Thu,  5 Sep 2024 08:47:41 +0900
Message-ID: <20240904234803.698424-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904234803.698424-1-masahiroy@kernel.org>
References: <20240904234803.698424-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Select GENERIC_BUILTIN_DTB and BUILTIN_DTB_ALL when built-in DTB
support is enabled.

DTBs compiled under arch/mips/boot/dts/ will be wrapped and compiled
in scripts/Makefile.vmlinux.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/Kconfig                         | 2 ++
 arch/mips/Makefile                        | 3 ---
 arch/mips/boot/dts/Makefile               | 2 --
 arch/mips/boot/dts/brcm/Makefile          | 2 --
 arch/mips/boot/dts/cavium-octeon/Makefile | 2 --
 arch/mips/boot/dts/ingenic/Makefile       | 2 --
 arch/mips/boot/dts/lantiq/Makefile        | 2 --
 arch/mips/boot/dts/loongson/Makefile      | 2 --
 arch/mips/boot/dts/mscc/Makefile          | 3 ---
 arch/mips/boot/dts/mti/Makefile           | 2 --
 arch/mips/boot/dts/pic32/Makefile         | 2 --
 arch/mips/boot/dts/ralink/Makefile        | 2 --
 12 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 60077e576935..7bfe3fd011f4 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -28,10 +28,12 @@ config MIPS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select BUILDTIME_TABLE_SORT
+	select BUILTIN_DTB_ALL if BUILTIN_DTB
 	select CLONE_BACKWARDS
 	select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
 	select CPU_PM if CPU_IDLE || SUSPEND
 	select GENERIC_ATOMIC64 if !64BIT
+	select GENERIC_BUILTIN_DTB if BUILTIN_DTB
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_GETTIMEOFDAY
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 5785a3d5ccfb..be8cb44a89fd 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -423,9 +423,6 @@ endif
 
 CLEAN_FILES += vmlinux.32 vmlinux.64
 
-# device-trees
-core-y += arch/mips/boot/dts/
-
 archprepare:
 ifdef CONFIG_MIPS32_N32
 	@$(kecho) '  Checking missing-syscalls for N32'
diff --git a/arch/mips/boot/dts/Makefile b/arch/mips/boot/dts/Makefile
index e2476b12bb0c..ff468439a8c4 100644
--- a/arch/mips/boot/dts/Makefile
+++ b/arch/mips/boot/dts/Makefile
@@ -16,5 +16,3 @@ subdir-$(CONFIG_ATH79)			+= qca
 subdir-$(CONFIG_RALINK)			+= ralink
 subdir-$(CONFIG_MACH_REALTEK_RTL)	+= realtek
 subdir-$(CONFIG_FIT_IMAGE_FDT_XILFPGA)	+= xilfpga
-
-obj-$(CONFIG_BUILTIN_DTB)	:= $(addsuffix /, $(subdir-y))
diff --git a/arch/mips/boot/dts/brcm/Makefile b/arch/mips/boot/dts/brcm/Makefile
index d85f446cc0ce..1798209697c6 100644
--- a/arch/mips/boot/dts/brcm/Makefile
+++ b/arch/mips/boot/dts/brcm/Makefile
@@ -33,5 +33,3 @@ dtb-$(CONFIG_DT_NONE) += \
 	bcm97420c.dtb \
 	bcm97425svmb.dtb \
 	bcm97435svmb.dtb
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/cavium-octeon/Makefile b/arch/mips/boot/dts/cavium-octeon/Makefile
index 17aef35f311b..48085bca666c 100644
--- a/arch/mips/boot/dts/cavium-octeon/Makefile
+++ b/arch/mips/boot/dts/cavium-octeon/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_CAVIUM_OCTEON_SOC)	+= octeon_3xxx.dtb octeon_68xx.dtb
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ingenic/Makefile b/arch/mips/boot/dts/ingenic/Makefile
index 54aa0c4e6091..6e674f1a3aa3 100644
--- a/arch/mips/boot/dts/ingenic/Makefile
+++ b/arch/mips/boot/dts/ingenic/Makefile
@@ -5,5 +5,3 @@ dtb-$(CONFIG_JZ4770_GCW0)	+= gcw0.dtb
 dtb-$(CONFIG_JZ4780_CI20)	+= ci20.dtb
 dtb-$(CONFIG_X1000_CU1000_NEO)	+= cu1000-neo.dtb
 dtb-$(CONFIG_X1830_CU1830_NEO)	+= cu1830-neo.dtb
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
index ae6e3e21ebeb..d8531b4653c0 100644
--- a/arch/mips/boot/dts/lantiq/Makefile
+++ b/arch/mips/boot/dts/lantiq/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_DT_EASY50712)	+= danube_easy50712.dtb
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/loongson/Makefile
index 5c6433e441ee..5e3ab984d70f 100644
--- a/arch/mips/boot/dts/loongson/Makefile
+++ b/arch/mips/boot/dts/loongson/Makefile
@@ -5,5 +5,3 @@ dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64c_4core_rs780e.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64c_8core_rs780e.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64g_4core_ls7a.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64v_4core_virtio.dtb
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mscc/Makefile b/arch/mips/boot/dts/mscc/Makefile
index eeb6b7aae83b..566dbec3c7fb 100644
--- a/arch/mips/boot/dts/mscc/Makefile
+++ b/arch/mips/boot/dts/mscc/Makefile
@@ -8,6 +8,3 @@ dtb-$(CONFIG_SOC_VCOREIII)	+= \
 	ocelot_pcb123.dtb \
 	serval_pcb105.dtb \
 	serval_pcb106.dtb
-
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/mti/Makefile b/arch/mips/boot/dts/mti/Makefile
index b5f7426998b1..c1c7b27296dd 100644
--- a/arch/mips/boot/dts/mti/Makefile
+++ b/arch/mips/boot/dts/mti/Makefile
@@ -1,5 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_MIPS_MALTA)	+= malta.dtb
 dtb-$(CONFIG_LEGACY_BOARD_SEAD3)	+= sead3.dtb
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/pic32/Makefile b/arch/mips/boot/dts/pic32/Makefile
index fb57f36324db..4069cda2370c 100644
--- a/arch/mips/boot/dts/pic32/Makefile
+++ b/arch/mips/boot/dts/pic32/Makefile
@@ -3,5 +3,3 @@ dtb-$(CONFIG_DTB_PIC32_MZDA_SK)		+= pic32mzda_sk.dtb
 
 dtb-$(CONFIG_DTB_PIC32_NONE)		+= \
 					pic32mzda_sk.dtb
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
index d27d7e8c700f..dc002152d843 100644
--- a/arch/mips/boot/dts/ralink/Makefile
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -10,5 +10,3 @@ dtb-$(CONFIG_SOC_MT7621) += \
 	mt7621-gnubee-gb-pc1.dtb \
 	mt7621-gnubee-gb-pc2.dtb \
 	mt7621-tplink-hc220-g5-v1.dtb
-
-obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
-- 
2.43.0



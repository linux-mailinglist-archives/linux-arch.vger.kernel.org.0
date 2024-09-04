Return-Path: <linux-arch+bounces-7045-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D3E96CB2B
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97A71F285A2
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D401917D9;
	Wed,  4 Sep 2024 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYTs406l"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D7018E02B;
	Wed,  4 Sep 2024 23:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493714; cv=none; b=UMGxvOd46w77Rec6SvS4DX/oZPRcYGZtDzy/T4wS+btlUDf64pnzCLs1WqXi2/v00kkasR/QJCKORkSgwsldJiXyjCyFpHuPv7U5HW7/26LaK0SROu94abnuogmdpZQfwRt8e3qDuQP37f0eizNqEBED+pzx/vedt0KODcMWFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493714; c=relaxed/simple;
	bh=ShH7X/nJUOJT346TPtT8MDMv6QalWDIylxJwzZgk3lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7INiiCh+G+hJ27zrlySuUqHxE80SJK6oVN/vWzjBkOWfPYQ63gyHkA/oI0Fl0/VsJkLU8IUfOvswHczFHQc32YgKz3EawrreNL4fD8BxCqjozeeW0s2TPZN5gRyMqMXshl8BaXkaC1yMT6Jexn3fMQuOHsLDj4tt/wWkBvyPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYTs406l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D540BC4CECA;
	Wed,  4 Sep 2024 23:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493714;
	bh=ShH7X/nJUOJT346TPtT8MDMv6QalWDIylxJwzZgk3lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYTs406lL9RVGMTvwddw7pj2H9g2O9zYNJjASRMvJlNrHHQzUvSYQ5dL4NUkrnATX
	 s0iznwK98cW8R9Ll+TbIVOcGRYFmVX6BtoM5XjrgLjMxQc3qKLY8Jf92EhAFav4hC+
	 MS7ZRw7cWLg9FotPvnbdYjuaJ7uTDwxIhcVmcaCyfZ2GI7HLaLDv7fDj/zkNDqEdcx
	 ihG9tR/V1isusbNSsNSXoCr5RWd1a+3x1M3TXEAl9ZOqCj53KbWz5oZnNVp1NeG0af
	 3e+xowAe808Kn6LHg4/bPMhiliZTlJG/0V1wErXUCqqlCNEWEroYvnQaRnDgO6JGPf
	 nkKS33OG/4rqA==
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
Subject: [PATCH 08/15] ARC: migrate to the generic rule for built-in DTB
Date: Thu,  5 Sep 2024 08:47:44 +0900
Message-ID: <20240904234803.698424-9-masahiroy@kernel.org>
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

Select GENERIC_BUILTIN_DTB to use the generic rule to support built-in
DTB.

To keep consistency across architectures, this commit also renames
CONFIG_ARC_BUILTIN_DTB_NAME to CONFIG_BUILTIN_DTB_NAME.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/Kconfig                           | 7 ++++---
 arch/arc/Makefile                          | 3 ---
 arch/arc/boot/dts/Makefile                 | 9 +--------
 arch/arc/configs/axs101_defconfig          | 2 +-
 arch/arc/configs/axs103_defconfig          | 2 +-
 arch/arc/configs/axs103_smp_defconfig      | 2 +-
 arch/arc/configs/haps_hs_defconfig         | 2 +-
 arch/arc/configs/haps_hs_smp_defconfig     | 2 +-
 arch/arc/configs/hsdk_defconfig            | 2 +-
 arch/arc/configs/nsim_700_defconfig        | 2 +-
 arch/arc/configs/nsimosci_defconfig        | 2 +-
 arch/arc/configs/nsimosci_hs_defconfig     | 2 +-
 arch/arc/configs/nsimosci_hs_smp_defconfig | 2 +-
 arch/arc/configs/tb10x_defconfig           | 2 +-
 arch/arc/configs/vdk_hs38_defconfig        | 2 +-
 arch/arc/configs/vdk_hs38_smp_defconfig    | 2 +-
 16 files changed, 18 insertions(+), 27 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index d01e69a29b69..11fe4f497571 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -16,6 +16,7 @@ config ARC
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
+	select GENERIC_BUILTIN_DTB
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_DIRECT_REMAP
@@ -549,11 +550,11 @@ config ARC_DBG_JUMP_LABEL
 	  part of static keys (jump labels) related code.
 endif
 
-config ARC_BUILTIN_DTB_NAME
+config BUILTIN_DTB_NAME
 	string "Built in DTB"
+	default "nsim_700"
 	help
-	  Set the name of the DTB to embed in the vmlinux binary
-	  Leaving it blank selects the "nsim_700" dtb.
+	  Set the name of the DTB to embed in the vmlinux binary.
 
 endmenu	 # "ARC Architecture Configuration"
 
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 2390dd042e36..deb830bdeaa0 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -82,9 +82,6 @@ KBUILD_CFLAGS	+= $(cflags-y)
 KBUILD_AFLAGS	+= $(KBUILD_CFLAGS)
 KBUILD_LDFLAGS	+= $(ldflags-y)
 
-# w/o this dtb won't embed into kernel binary
-core-y		+= arch/arc/boot/dts/
-
 core-y				+= arch/arc/plat-sim/
 core-$(CONFIG_ARC_PLAT_TB10X)	+= arch/arc/plat-tb10x/
 core-$(CONFIG_ARC_PLAT_AXS10X)	+= arch/arc/plat-axs10x/
diff --git a/arch/arc/boot/dts/Makefile b/arch/arc/boot/dts/Makefile
index 48704dfdf75c..ee5664f0640d 100644
--- a/arch/arc/boot/dts/Makefile
+++ b/arch/arc/boot/dts/Makefile
@@ -1,13 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-# Built-in dtb
-builtindtb-y		:= nsim_700
 
-ifneq ($(CONFIG_ARC_BUILTIN_DTB_NAME),)
-	builtindtb-y	:= $(CONFIG_ARC_BUILTIN_DTB_NAME)
-endif
-
-obj-y   += $(builtindtb-y).dtb.o
-dtb-y := $(builtindtb-y).dtb
+dtb-y	:= $(addsuffix .dtb, $(CONFIG_BUILTIN_DTB_NAME))
 
 # for CONFIG_OF_ALL_DTBS test
 dtb-	:= $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index 89720d6d7e0d..628d55057cde 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -23,7 +23,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARC_PLAT_AXS10X=y
 CONFIG_AXS101=y
 CONFIG_ARC_CACHE_LINE_SHIFT=5
-CONFIG_ARC_BUILTIN_DTB_NAME="axs101"
+CONFIG_BUILTIN_DTB_NAME="axs101"
 CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index 73ec01ed0492..7e4d4cbf1fb7 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -22,7 +22,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARC_PLAT_AXS10X=y
 CONFIG_AXS103=y
 CONFIG_ISA_ARCV2=y
-CONFIG_ARC_BUILTIN_DTB_NAME="axs103"
+CONFIG_BUILTIN_DTB_NAME="axs103"
 CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 4da0f626fa9d..764cbc781a7d 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -22,7 +22,7 @@ CONFIG_ARC_PLAT_AXS10X=y
 CONFIG_AXS103=y
 CONFIG_ISA_ARCV2=y
 CONFIG_SMP=y
-CONFIG_ARC_BUILTIN_DTB_NAME="axs103_idu"
+CONFIG_BUILTIN_DTB_NAME="axs103_idu"
 CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index 8c3ed5d6e6c3..3a1577112078 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -14,7 +14,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
-CONFIG_ARC_BUILTIN_DTB_NAME="haps_hs"
+CONFIG_BUILTIN_DTB_NAME="haps_hs"
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_COMPACTION is not set
diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
index 6fc98c1b9b36..a3cf940b1f5b 100644
--- a/arch/arc/configs/haps_hs_smp_defconfig
+++ b/arch/arc/configs/haps_hs_smp_defconfig
@@ -16,7 +16,7 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SMP=y
-CONFIG_ARC_BUILTIN_DTB_NAME="haps_hs_idu"
+CONFIG_BUILTIN_DTB_NAME="haps_hs_idu"
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 9e79154b5535..1558e8e87767 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -20,7 +20,7 @@ CONFIG_ISA_ARCV2=y
 CONFIG_SMP=y
 CONFIG_LINUX_LINK_BASE=0x90000000
 CONFIG_LINUX_RAM_BASE=0x80000000
-CONFIG_ARC_BUILTIN_DTB_NAME="hsdk"
+CONFIG_BUILTIN_DTB_NAME="hsdk"
 CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index 51092c39e360..f8b3235d9a65 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -17,7 +17,7 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_COMPAT_BRK is not set
 CONFIG_ISA_ARCOMPACT=y
-CONFIG_ARC_BUILTIN_DTB_NAME="nsim_700"
+CONFIG_BUILTIN_DTB_NAME="nsim_700"
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index 70c17bca4939..ee45dc0877fb 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -19,7 +19,7 @@ CONFIG_ISA_ARCOMPACT=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARC_BUILTIN_DTB_NAME="nsimosci"
+CONFIG_BUILTIN_DTB_NAME="nsimosci"
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
index 59a3b6642fe7..e0a309970c20 100644
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -19,7 +19,7 @@ CONFIG_KPROBES=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ISA_ARCV2=y
-CONFIG_ARC_BUILTIN_DTB_NAME="nsimosci_hs"
+CONFIG_BUILTIN_DTB_NAME="nsimosci_hs"
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
index 1419fc946a08..88325b8b49cf 100644
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -16,7 +16,7 @@ CONFIG_MODULES=y
 CONFIG_ISA_ARCV2=y
 CONFIG_SMP=y
 # CONFIG_ARC_TIMERS_64BIT is not set
-CONFIG_ARC_BUILTIN_DTB_NAME="nsimosci_hs_idu"
+CONFIG_BUILTIN_DTB_NAME="nsimosci_hs_idu"
 CONFIG_PREEMPT=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index 1a68e4beebca..41a90e836e39 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -26,7 +26,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARC_PLAT_TB10X=y
 CONFIG_ARC_CACHE_LINE_SHIFT=5
 CONFIG_HZ=250
-CONFIG_ARC_BUILTIN_DTB_NAME="abilis_tb100_dvk"
+CONFIG_BUILTIN_DTB_NAME="abilis_tb100_dvk"
 CONFIG_PREEMPT_VOLUNTARY=y
 # CONFIG_COMPACTION is not set
 CONFIG_NET=y
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index 50c343913825..03d9ac20baa9 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -13,7 +13,7 @@ CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARC_PLAT_AXS10X=y
 CONFIG_AXS103=y
 CONFIG_ISA_ARCV2=y
-CONFIG_ARC_BUILTIN_DTB_NAME="vdk_hs38"
+CONFIG_BUILTIN_DTB_NAME="vdk_hs38"
 CONFIG_PREEMPT=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
index 6d9e1d9f71d2..c09488992f13 100644
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -15,7 +15,7 @@ CONFIG_AXS103=y
 CONFIG_ISA_ARCV2=y
 CONFIG_SMP=y
 # CONFIG_ARC_TIMERS_64BIT is not set
-CONFIG_ARC_BUILTIN_DTB_NAME="vdk_hs38_smp"
+CONFIG_BUILTIN_DTB_NAME="vdk_hs38_smp"
 CONFIG_PREEMPT=y
 CONFIG_NET=y
 CONFIG_PACKET=y
-- 
2.43.0



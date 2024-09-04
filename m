Return-Path: <linux-arch+bounces-7049-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F0496CB45
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96BC1C2101B
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAC719307B;
	Wed,  4 Sep 2024 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcGeVz6L"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D82C19306B;
	Wed,  4 Sep 2024 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493725; cv=none; b=aZyY5hvXoOL6itREOV0qa9bKITd/FfOEFTFVhTiQvuUgcAzj2cBmz5js0SfBdSRmu0Vf/FKjHlf2v2sKnssrHNAbEyHp+GJF/6VEfBmpeotkJmce2W0AIkleEyzEh/2EZjtU77UFGBgY9xbIPQzPnzY9rXOZ6kVo12UzfgErpj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493725; c=relaxed/simple;
	bh=GAvIRyYGY88KXHCNgA5plk+Rvj05BOMm2Zv8xtvLfvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i17nudppEOGPT+aaw71QlNRWoyRPU6lbIJLpr7yCI1E1hzNKxVb/hoEDgxZrG3ZVaiZDy4NQcHpiXwG6UypHjtwE+ixAx+yI0vY2kfO+SHffurWhTysXdlZF8akR7qc6NeeOgfpK+vD0IizvLt3tlvvlWi0Zq0XYvVN4apV1/+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcGeVz6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49E5C4CECC;
	Wed,  4 Sep 2024 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493725;
	bh=GAvIRyYGY88KXHCNgA5plk+Rvj05BOMm2Zv8xtvLfvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcGeVz6LO53QnNj0mJxAwWueTLOBilwQI/IQ+a0pK86HA9dHli8CwkmxS6DJQvGHY
	 lNpNRaYKpne2uc7raDjurFFtQLbo/PMF4RZWdFrQdfBzJhFtNzQyJNyXEgv/mPfeOD
	 0vnD3Ljumu8eOm6GR1XIC0m8YnGrTbHXYljdH3BHWou5PEkMWmUYngzcIOmHE+4ieB
	 aY1B/f2C2ZEgzYWlw6rqcLsYy2EGAOFge130Yi6Xghc5H9lh2qEkr7OCxe8B1N9KWV
	 7hgQKlTw8JERdZ1zmpHTUxs12YPDH4JcI5XHxmhetbHI5jO6oF7pF3kh+lpZ+P76F6
	 dgSL/Ftd270IA==
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
Subject: [PATCH 12/15] sh: migrate to the generic rule for built-in DTB
Date: Thu,  5 Sep 2024 08:47:48 +0900
Message-ID: <20240904234803.698424-13-masahiroy@kernel.org>
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

Select GENERIC_BUILTIN_DTB when built-in DTB support is enabled.

To keep consistency across architectures, this commit also renames
CONFIG_USE_BUILTIN_DTB to CONFIG_BUILTIN_DTB, and
CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/Kbuild            | 1 -
 arch/sh/Kconfig           | 7 ++++---
 arch/sh/boot/dts/Makefile | 2 +-
 arch/sh/kernel/setup.c    | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sh/Kbuild b/arch/sh/Kbuild
index 056efec72c2a..0da6c6d6821a 100644
--- a/arch/sh/Kbuild
+++ b/arch/sh/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y				+= kernel/ mm/ boards/
 obj-$(CONFIG_SH_FPU_EMU)	+= math-emu/
-obj-$(CONFIG_USE_BUILTIN_DTB)	+= boot/dts/
 
 obj-$(CONFIG_HD6446X_SERIES)	+= cchips/hd6446x/
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 1aa3c4a0c5b2..3b772378773f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -644,10 +644,11 @@ endmenu
 
 menu "Boot options"
 
-config USE_BUILTIN_DTB
+config BUILTIN_DTB
 	bool "Use builtin DTB"
 	default n
 	depends on SH_DEVICE_TREE
+	select GENERIC_BUILTIN_DTB
 	help
 	  Link a device tree blob for particular hardware into the kernel,
 	  suppressing use of the DTB pointer provided by the bootloader.
@@ -655,10 +656,10 @@ config USE_BUILTIN_DTB
 	  not capable of providing a DTB to the kernel, or for experimental
 	  hardware without stable device tree bindings.
 
-config BUILTIN_DTB_SOURCE
+config BUILTIN_DTB_NAME
 	string "Source file for builtin DTB"
 	default ""
-	depends on USE_BUILTIN_DTB
+	depends on BUILTIN_DTB
 	help
 	  Base name (without suffix, relative to arch/sh/boot/dts) for the
 	  a DTS file that will be used to produce the DTB linked into the
diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index 4a6dec9714a9..d109978a5eb9 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_USE_BUILTIN_DTB) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
+obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_NAME))
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 620e5cf8ae1e..aaca94a88dad 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -249,7 +249,7 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 	/* Avoid calling an __init function on secondary cpus. */
 	if (done) return;
 
-#ifdef CONFIG_USE_BUILTIN_DTB
+#ifdef CONFIG_BUILTIN_DTB
 	dt_virt = __dtb_start;
 #else
 	dt_virt = phys_to_virt(dt_phys);
@@ -323,7 +323,7 @@ void __init setup_arch(char **cmdline_p)
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
-#ifdef CONFIG_USE_BUILTIN_DTB
+#ifdef CONFIG_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
 #else
 	unflatten_device_tree();
-- 
2.43.0



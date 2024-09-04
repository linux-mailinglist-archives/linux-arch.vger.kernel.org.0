Return-Path: <linux-arch+bounces-7050-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2196CB4A
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B15A1C21816
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64817188905;
	Wed,  4 Sep 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWq1UtCZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20019340A;
	Wed,  4 Sep 2024 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493728; cv=none; b=dzwUDeXJBJtsbaw2Wm4yKyELZnjtDyXfeAMgGSTPSIUcRBtbvVNE0kN8Z22kvBt1rVkVqujkIA+CVdbJBKK1L7kT4CbxZt62fsLj2icira+IE2Cxge1UJgyZe1p8Fi0S5+RZxaB6S1GCYf0nurI+QQOujw+4x9rD087caQ7yDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493728; c=relaxed/simple;
	bh=BjDiByoacyrF5p/NP/LwM66TJexL9bSHpr0RjtKerQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9f5NrfWujbXgALyk9MQB/7lSPjoa2e0ir+XUyg6CKpSIMKrkdQFT4oRm+/xw1grNd0GQxVRAixGFHiF6wkeRgfewOxaIwwbpiOlvwxc/KB55uy6pBE/cKWKekiz8tex3kelNZoOrONu2HTz/txXi10dimDAC2OYveg2pe8dwsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWq1UtCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CB2C4CEC3;
	Wed,  4 Sep 2024 23:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493728;
	bh=BjDiByoacyrF5p/NP/LwM66TJexL9bSHpr0RjtKerQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWq1UtCZUw8JgXhQSsX3lD0ZvDdyVatWqs8HLRvFbDFUmBZFsVuI5jI25LsH8EBCH
	 vnBLAQe8ThpGx/wOMzWTxbBqL4zuxk3DjWFIbF3JBIcleODYaz2mU0bb0gzkgN82CM
	 iRc5KMuslu9XJxciOQRtVAWAUQvFI6MCmJe1jV5TfBktvuxHzYICv7w7ZfUjFCuDeX
	 eRH0plFPCNrqF3PmMyMEU6m5EW/lqQv4UeYS48di2VpA5b4nbTy/Aiv7oTffpT9Q3b
	 Oq8fTPRXrwd9zUKhsPo+OQaKBaGi5D2ZLOrL50wR/WobCoC01s48Lm14Xp3/LueDww
	 fZxv69Z0WqAjQ==
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
Subject: [PATCH 13/15] microblaze: migrate to the generic rule for built-in DTB
Date: Thu,  5 Sep 2024 08:47:49 +0900
Message-ID: <20240904234803.698424-14-masahiroy@kernel.org>
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

MicroBlaze is the only architecture that embeds the boot DTB into its
own section, __fdt_blob, and hard-codes the section size to 64kB.

All other architectures that support embedded DTBs use the
.dtb.init.rodata handled by include/asm-generic/vmlinux.lds.h.

For safety, arch/microblaze/boot/dts/system.dtb is still placed in the
__fdt_blob section, but removing the MicroBlaze-specific section should
be considered.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/microblaze/Kbuild                | 1 -
 arch/microblaze/Kconfig               | 5 +++++
 arch/microblaze/boot/dts/Makefile     | 5 -----
 arch/microblaze/boot/dts/linked_dtb.S | 2 --
 arch/microblaze/kernel/vmlinux.lds.S  | 2 +-
 5 files changed, 6 insertions(+), 9 deletions(-)
 delete mode 100644 arch/microblaze/boot/dts/linked_dtb.S

diff --git a/arch/microblaze/Kbuild b/arch/microblaze/Kbuild
index 077a0b8e9615..70510389eb92 100644
--- a/arch/microblaze/Kbuild
+++ b/arch/microblaze/Kbuild
@@ -2,7 +2,6 @@
 obj-y			+= kernel/
 obj-y			+= mm/
 obj-$(CONFIG_PCI)	+= pci/
-obj-y			+= boot/dts/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index f18ec02ddeb2..4ed8ca89f0c9 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -10,6 +10,7 @@ config MICROBLAZE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
+	select GENERIC_BUILTIN_DTB
 	select TIMER_OF
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
@@ -47,6 +48,10 @@ config MICROBLAZE
 	select TRACE_IRQFLAGS_SUPPORT
 	select GENERIC_IRQ_MULTI_HANDLER
 
+config BUILTIN_DTB_NAME
+	string
+	default "system"
+
 # Endianness selection
 choice
 	prompt "Endianness selection"
diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index b84e2cbb20ee..87c1d25ff096 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -4,11 +4,6 @@
 dtb-y := system.dtb
 
 ifneq ($(DTB),)
-obj-y += linked_dtb.o
-
-# Ensure system.dtb exists
-$(obj)/linked_dtb.o: $(obj)/system.dtb
-
 # Generate system.dtb from $(DTB).dtb
 ifneq ($(DTB),system)
 $(obj)/system.dtb: $(obj)/$(DTB).dtb
diff --git a/arch/microblaze/boot/dts/linked_dtb.S b/arch/microblaze/boot/dts/linked_dtb.S
deleted file mode 100644
index 23345af3721f..000000000000
--- a/arch/microblaze/boot/dts/linked_dtb.S
+++ /dev/null
@@ -1,2 +0,0 @@
-.section __fdt_blob,"a"
-.incbin "arch/microblaze/boot/dts/system.dtb"
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index ae50d3d04a7d..e86f9ca8e979 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -47,7 +47,7 @@ SECTIONS {
 	. = ALIGN (8) ;
 	__fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
 		_fdt_start = . ;		/* place for fdt blob */
-		*(__fdt_blob) ;			/* Any link-placed DTB */
+		*(.dtb.init.rodata) ;		/* Any link-placed DTB */
 	        . = _fdt_start + 0x10000;	/* Pad up to 64kbyte */
 		_fdt_end = . ;
 	}
-- 
2.43.0



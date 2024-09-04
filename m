Return-Path: <linux-arch+bounces-7051-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D178B96CB51
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 014311C20DE2
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94373193436;
	Wed,  4 Sep 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut0wdZva"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F9119340A;
	Wed,  4 Sep 2024 23:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493731; cv=none; b=dgk8SIB09QQRrHSTJdeX60Jm7ahgWtAgfFWvoXZrFmdgqXE7mXqT4ReyUO25va5na7q94ojyp7FgBv/5EVA3V6Ek2rPRcHmb1DR1jzh0bdyLNyYKgHdX0LTy0rTePDu2QJKBTsZxSsiJ2iZG2UcUdaDK0G/cg8jpPsnPejRu+tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493731; c=relaxed/simple;
	bh=x/Z3v/XK8I1GQANjHhGyOrIDt9xA5TgiJymmIsAjDIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOmWe1qr3RtiIIkPssPWmS/7g73/en2PWSBj8CeB1wdH3Utp3z9khGLSp96XZMBx1d6VyUHMalJWpvX12AXEx4jrW6GJLmMmk8eSp8BexBeCZ83K5U45jRbX3Jv6CjWofRxoeioQ8pSHmqTIISeHruLEketjH+e3Rh1xC4rPFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut0wdZva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995DCC4CEC2;
	Wed,  4 Sep 2024 23:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493730;
	bh=x/Z3v/XK8I1GQANjHhGyOrIDt9xA5TgiJymmIsAjDIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ut0wdZvaJ5RnzqF8X1miesh8kLVoi7K3jVSurqYm2TVdvsx8tDFw/RM8/7O8OzTgU
	 PRwadz+gHFXUGCetAKgR4ILvVeDua8hhV9gwnG1qDGpkMNq7ujfN8W91Ntb+fkXF79
	 ncidnVMVZ8GXjZoURXitQ53eTXWn89MdvYuWkJeoiRnd/IB3IjG26GAxfc2PI44jQI
	 tc9zKtxHjFMd/se+jORyMsG4HlFEDdVqJiyUUWPEUDpqJEARbP7eFMuUHjlAnKFdGF
	 8FZoMpEvyWTX0KyzfI7Dwxxi+sdd3P2aF9qpmpiz2qm5zKNioy7u7zKOPbAJUynlgT
	 GLKV8rfrLwF3g==
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
Subject: [PATCH 14/15] kbuild: rename CONFIG_GENERIC_BUILTIN_DTB to CONFIG_BUILTIN_DTB
Date: Thu,  5 Sep 2024 08:47:50 +0900
Message-ID: <20240904234803.698424-15-masahiroy@kernel.org>
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

Now that all architectures have migrated to the generic built-in
DTB support, the GENERIC_ prefix is no longer necessary.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                             | 2 +-
 arch/arc/Kconfig                     | 2 +-
 arch/loongarch/Kconfig               | 1 -
 arch/microblaze/Kconfig              | 2 +-
 arch/mips/Kconfig                    | 1 -
 arch/nios2/platform/Kconfig.platform | 1 -
 arch/openrisc/Kconfig                | 2 +-
 arch/riscv/Kconfig                   | 1 -
 arch/sh/Kconfig                      | 1 -
 arch/xtensa/Kconfig                  | 2 +-
 drivers/of/Kconfig                   | 2 +-
 scripts/Makefile.vmlinux             | 2 +-
 scripts/link-vmlinux.sh              | 2 +-
 13 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/Makefile b/Makefile
index 1c765c12ab9e..a83edbdbc79c 100644
--- a/Makefile
+++ b/Makefile
@@ -1417,7 +1417,7 @@ ifdef CONFIG_OF_EARLY_FLATTREE
 all: dtbs
 endif
 
-ifdef CONFIG_GENERIC_BUILTIN_DTB
+ifdef CONFIG_BUILTIN_DTB
 vmlinux: dtbs
 endif
 
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 11fe4f497571..05fed3cd8b29 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -16,7 +16,7 @@ config ARC
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
-	select GENERIC_BUILTIN_DTB
+	select BUILTIN_DTB
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_DIRECT_REMAP
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e1d3e5fb6fd2..70f169210b52 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -388,7 +388,6 @@ endchoice
 config BUILTIN_DTB
 	bool "Enable built-in dtb in kernel"
 	depends on OF
-	select GENERIC_BUILTIN_DTB
 	help
 	  Some existing systems do not provide a canonical device tree to
 	  the kernel at boot time. Let's provide a device tree table in the
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 4ed8ca89f0c9..e1a3b5f4d97e 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -10,7 +10,7 @@ config MICROBLAZE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
-	select GENERIC_BUILTIN_DTB
+	select BUILTIN_DTB
 	select TIMER_OF
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 7bfe3fd011f4..fda96e4f2187 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -33,7 +33,6 @@ config MIPS
 	select CPU_NO_EFFICIENT_FFS if (TARGET_ISA_REV < 1)
 	select CPU_PM if CPU_IDLE || SUSPEND
 	select GENERIC_ATOMIC64 if !64BIT
-	select GENERIC_BUILTIN_DTB if BUILTIN_DTB
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_GETTIMEOFDAY
diff --git a/arch/nios2/platform/Kconfig.platform b/arch/nios2/platform/Kconfig.platform
index c75cadd92388..5f0cf551b5ca 100644
--- a/arch/nios2/platform/Kconfig.platform
+++ b/arch/nios2/platform/Kconfig.platform
@@ -38,7 +38,6 @@ config NIOS2_DTB_PHYS_ADDR
 config BUILTIN_DTB
 	bool "Compile and link device tree into kernel image"
 	depends on !COMPILE_TEST
-	select GENERIC_BUILTIN_DTB
 	help
 	  This allows you to specify a dts (device tree source) file
 	  which will be compiled and linked into the kernel image.
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 11ffcf33652c..f55e66be4112 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -10,7 +10,7 @@ config OPENRISC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select GENERIC_BUILTIN_DTB
+	select BUILTIN_DTB
 	select COMMON_CLK
 	select OF
 	select OF_EARLY_FLATTREE
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 019c64ef0826..a63b66b32636 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1110,7 +1110,6 @@ config RISCV_ISA_FALLBACK
 config BUILTIN_DTB
 	bool "Built-in device tree"
 	depends on OF && NONPORTABLE
-	select GENERIC_BUILTIN_DTB
 	help
 	  Build a device tree into the Linux image.
 	  This option should be selected if no bootloader is being used.
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 3b772378773f..b09019cd87d4 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -648,7 +648,6 @@ config BUILTIN_DTB
 	bool "Use builtin DTB"
 	default n
 	depends on SH_DEVICE_TREE
-	select GENERIC_BUILTIN_DTB
 	help
 	  Link a device tree blob for particular hardware into the kernel,
 	  suppressing use of the DTB pointer provided by the bootloader.
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 5fd1d248e147..cccfacb5848d 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -19,7 +19,7 @@ config XTENSA
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
-	select GENERIC_BUILTIN_DTB
+	select BUILTIN_DTB
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_NONCOHERENT_MMAP if MMU
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 5142e7d7fef8..53a227ca3a3c 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -2,7 +2,7 @@
 config DTC
 	bool
 
-config GENERIC_BUILTIN_DTB
+config BUILTIN_DTB
 	bool
 
 config BUILTIN_DTB_ALL
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 4626b472da49..677fc5a4e8c1 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -53,7 +53,7 @@ quiet_cmd_gen_dtbs_list = GEN     $@
 
 targets += .builtin-dtbs-list
 
-ifdef CONFIG_GENERIC_BUILTIN_DTB
+ifdef CONFIG_BUILTIN_DTB
 targets += .builtin-dtbs.S .builtin-dtbs.o
 vmlinux: .builtin-dtbs.o
 endif
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index bd196944e350..c58dc9d86e2d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -68,7 +68,7 @@ vmlinux_link()
 		libs="${KBUILD_VMLINUX_LIBS}"
 	fi
 
-	if is_enabled CONFIG_GENERIC_BUILTIN_DTB; then
+	if is_enabled CONFIG_BUILTIN_DTB; then
 		objs="${objs} .builtin-dtbs.o"
 	fi
 
-- 
2.43.0



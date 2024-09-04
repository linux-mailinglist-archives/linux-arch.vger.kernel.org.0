Return-Path: <linux-arch+bounces-7047-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5057D96CB39
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 01:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10CA1F288DD
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 23:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD6A1925B7;
	Wed,  4 Sep 2024 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhjADhw3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5912B1925B3;
	Wed,  4 Sep 2024 23:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493720; cv=none; b=J0SzsBh/S9tM2PEBm4IgWpdImeUjvh8x+iXKRh9xnsK7NOCrKBVhF1WYAIoshQiY2mI8hg7dyx0gstQKq2xey76siEQmQiq60hik7Sxk1uQcD4tMJIRFN6HxyJGb7BS+sH4o9s8ui7nwoFXe+OtBdNU9c6LXIGJS2ZittshP5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493720; c=relaxed/simple;
	bh=Hx8xawNp6pSOR9yjQH6NLrBLbl8X/A3JIv5Jk19JmG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TK0puNQxUq+esvgtnlcC1AfN4hbJMYXMS8I7wyM5x09/JJnzem9Gk2FHt5nRAqKOYcjXPS+uoUlV+SvAUYTpUU1bD5NCwjvPeVjSA+gmSlU0LFoGazGGWQ0M0aWNhV7HVn7DF0C0BBeHFLPYWUgIXxFUncyMzRPiDcbJM4US9+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhjADhw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F7DC4CEC3;
	Wed,  4 Sep 2024 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493719;
	bh=Hx8xawNp6pSOR9yjQH6NLrBLbl8X/A3JIv5Jk19JmG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhjADhw3VFUuXUNrhgvaImjM65DClBDuU7++FngZwmnnBwfzzLtzQLZ9HdIkkfFB+
	 F7uTpm0Oo7qRXJCNGr5wMCZ1wwaB1/2P7v/RSgdP1GD9DKVuLi+OJRrc2TvfJMiS+G
	 dctbjGIh2kV+BJgqZTa2Hh1/saZNPzv/9X//xp7ANnEymaIThWdtqY0gsmbRjLlNpZ
	 /bRG/F4cMobP20RzhAYovofjxSuuCbIh50W/mi8KxeT1Mn/zj7E5iAd7wnzTYf5diH
	 4UIYVly2da5V/SeZsFWT5gI8Y7mrt4fnrXLFF9bK+qOB25LM4sbjc58enAkkdFmy2V
	 MWWgneAT1nyjA==
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
Subject: [PATCH 10/15] xtensa: migrate to the generic rule for built-in DTB
Date: Thu,  5 Sep 2024 08:47:46 +0900
Message-ID: <20240904234803.698424-11-masahiroy@kernel.org>
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
CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/xtensa/Kbuild                          | 2 +-
 arch/xtensa/Kconfig                         | 3 ++-
 arch/xtensa/boot/dts/Makefile               | 2 +-
 arch/xtensa/configs/audio_kc705_defconfig   | 2 +-
 arch/xtensa/configs/cadence_csp_defconfig   | 2 +-
 arch/xtensa/configs/generic_kc705_defconfig | 2 +-
 arch/xtensa/configs/nommu_kc705_defconfig   | 2 +-
 arch/xtensa/configs/smp_lx200_defconfig     | 2 +-
 arch/xtensa/configs/virt_defconfig          | 2 +-
 arch/xtensa/configs/xip_kc705_defconfig     | 2 +-
 10 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/xtensa/Kbuild b/arch/xtensa/Kbuild
index fd12f61745ba..015baeb765b9 100644
--- a/arch/xtensa/Kbuild
+++ b/arch/xtensa/Kbuild
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += kernel/ mm/ platforms/ boot/dts/
+obj-y += kernel/ mm/ platforms/
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f200a4ec044e..5fd1d248e147 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -19,6 +19,7 @@ config XTENSA
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BUILDTIME_TABLE_SORT
+	select GENERIC_BUILTIN_DTB
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_NONCOHERENT_MMAP if MMU
@@ -461,7 +462,7 @@ config USE_OF
 	help
 	  Include support for flattened device tree machine descriptions.
 
-config BUILTIN_DTB_SOURCE
+config BUILTIN_DTB_NAME
 	string "DTB to build into the kernel image"
 	depends on OF
 
diff --git a/arch/xtensa/boot/dts/Makefile b/arch/xtensa/boot/dts/Makefile
index d6408c16d74e..7271294ce523 100644
--- a/arch/xtensa/boot/dts/Makefile
+++ b/arch/xtensa/boot/dts/Makefile
@@ -7,7 +7,7 @@
 #
 #
 
-obj-$(CONFIG_OF) += $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
+dtb-$(CONFIG_OF) += $(addsuffix .dtb, $(CONFIG_BUILTIN_DTB_NAME))
 
 # for CONFIG_OF_ALL_DTBS test
 dtb-	:= $(patsubst $(src)/%.dts,%.dtb, $(wildcard $(src)/*.dts))
diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index 436b7cac9694..f2af1a32c9c7 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -30,7 +30,7 @@ CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x38000000@0"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB_SOURCE="kc705"
+CONFIG_BUILTIN_DTB_NAME="kc705"
 # CONFIG_COMPACTION is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 91c4c4cae8a7..5a272a278740 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -35,7 +35,7 @@ CONFIG_HIGHMEM=y
 # CONFIG_PCI is not set
 CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB_SOURCE="csp"
+CONFIG_BUILTIN_DTB_NAME="csp"
 # CONFIG_COMPACTION is not set
 CONFIG_XTFPGA_LCD=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index e376238bc5ca..4427907becca 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -29,7 +29,7 @@ CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x38000000@0"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB_SOURCE="kc705"
+CONFIG_BUILTIN_DTB_NAME="kc705"
 # CONFIG_COMPACTION is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index c2ab4306ee20..5828228522ba 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -36,7 +36,7 @@ CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0x9d050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=256M@0x60000000"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB_SOURCE="kc705_nommu"
+CONFIG_BUILTIN_DTB_NAME="kc705_nommu"
 CONFIG_BINFMT_FLAT=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 63b56ce79f83..326966ca7831 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -33,7 +33,7 @@ CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=96M@0"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB_SOURCE="lx200mx"
+CONFIG_BUILTIN_DTB_NAME="lx200mx"
 # CONFIG_COMPACTION is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_NET=y
diff --git a/arch/xtensa/configs/virt_defconfig b/arch/xtensa/configs/virt_defconfig
index 98acb7191cb7..e37048985b47 100644
--- a/arch/xtensa/configs/virt_defconfig
+++ b/arch/xtensa/configs/virt_defconfig
@@ -24,7 +24,7 @@ CONFIG_HIGHMEM=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x80000000@0"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB_SOURCE="virt"
+CONFIG_BUILTIN_DTB_NAME="virt"
 # CONFIG_PARSE_BOOTPARAM is not set
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
diff --git a/arch/xtensa/configs/xip_kc705_defconfig b/arch/xtensa/configs/xip_kc705_defconfig
index 165652c45b85..ee47438f9b51 100644
--- a/arch/xtensa/configs/xip_kc705_defconfig
+++ b/arch/xtensa/configs/xip_kc705_defconfig
@@ -29,7 +29,7 @@ CONFIG_XTENSA_PLATFORM_XTFPGA=y
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon=uart8250,mmio32native,0xfd050020,115200n8 console=ttyS0,115200n8 ip=dhcp root=/dev/nfs rw debug memmap=0x38000000@0"
 CONFIG_USE_OF=y
-CONFIG_BUILTIN_DTB_SOURCE="kc705"
+CONFIG_BUILTIN_DTB_NAME="kc705"
 # CONFIG_PARSE_BOOTPARAM is not set
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
-- 
2.43.0



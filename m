Return-Path: <linux-arch+bounces-11209-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 975AAA78489
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 00:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 643BF7A4319
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 22:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C92321B9FF;
	Tue,  1 Apr 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB/jcYF8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103C21B91F;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545783; cv=none; b=bgLOzxqGFN3uz4MW6Jf6iZ0BNDy2nBmK3dTjcI4WXceaJ5AiK7Fuh0uAv5sB6ATi5Iahq693Y2hoHxEIcgWTUfvDxLk502aRf96qipSHOBhDvs4N1dngzkjlkAYfjbhE/dEmdJwUNxpBhPiDxv39lNF/XR4iYAG7eIv2BClI7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545783; c=relaxed/simple;
	bh=ofyggRei5H59NoAqvRQhzVHP0TKd5kfKntr/amSwb3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgnT26u9y2K8GepYujvsSnB4hOZRcTbMJko27ugwBdt/Meby1HPyNcCkgH9/glLSogICLVMPTqxqmUFTWhwI1bOqMS1KyQt3nqeiTD8qu7mfGkVZVNvO67v+0ZjIXG6LOuXmT7fcR1pNtIK/3cCt49PyFd8/SETFmWwtPlF3xuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB/jcYF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E155C4CEE8;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743545782;
	bh=ofyggRei5H59NoAqvRQhzVHP0TKd5kfKntr/amSwb3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jB/jcYF8lHSq+Oawr10GEI8ESwJW06u2Zm+GhElYF6FsiI7pQsO51XvPttzuT4P8N
	 ocGX2Lw4PARat1Cb3Vfqwq5Kp8SpjZRd+EN9skb1o6B5u0wPCqXfc4DR/3BDlWj6DI
	 xwjRGiGjE1lSdEo4EqfgvYcnGVQc3/oRx41KcUiF4dL8IJ4rNiU9BMKi7+BDs8xSYn
	 HD+xqpG3vCa4kVNErMC/0SekW2DKKOf5dvHD94jerY9HlDrbmwpifyzwjke2A9hgok
	 JQtgANy/5/rctR6NMgePfWr9ojbUuxlvbYFBehyLVlIH0Q5g+g4v4K3k0in3lQ4Ca2
	 69Y2VFunIQWrA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 5/7] lib/crc: remove unnecessary prompt for CONFIG_CRC_ITU_T
Date: Tue,  1 Apr 2025 15:15:58 -0700
Message-ID: <20250401221600.24878-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401221600.24878-1-ebiggers@kernel.org>
References: <20250401221600.24878-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

All modules that need CONFIG_CRC_ITU_T already select it, so there is no
need to bother users about the option.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/configs/lpc18xx_defconfig       | 1 -
 arch/arm/configs/milbeaut_m10v_defconfig | 1 -
 arch/arm/configs/mxs_defconfig           | 1 -
 arch/arm/configs/omap2plus_defconfig     | 1 -
 arch/arm/configs/sama7_defconfig         | 1 -
 arch/arm/configs/stm32_defconfig         | 1 -
 arch/arm/configs/wpcm450_defconfig       | 1 -
 arch/mips/configs/ath79_defconfig        | 1 -
 arch/mips/configs/rt305x_defconfig       | 1 -
 arch/mips/configs/xway_defconfig         | 1 -
 arch/powerpc/configs/skiroot_defconfig   | 1 -
 arch/sh/configs/se7206_defconfig         | 1 -
 lib/Kconfig                              | 7 +------
 13 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 2aa2ac8c6507..2d489186e945 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -145,11 +145,10 @@ CONFIG_EXT2_FS=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
 CONFIG_JFFS2_FS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
-CONFIG_CRC_ITU_T=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index bb35cc0c469e..275ddf7a3a14 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -106,10 +106,9 @@ CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
 CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_AES_ARM_CE=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_ITU_T=m
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index d8a6e43c401e..c76d66135abb 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -158,11 +158,10 @@ CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_CRYPTO_DEV_MXS_DCP=y
-CONFIG_CRC_ITU_T=m
 CONFIG_FONTS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_FRAME_WARN=2048
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d8a35c44b64f..75b326bc7830 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -704,11 +704,10 @@ CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_DEV_OMAP=m
 CONFIG_CRYPTO_DEV_OMAP_SHAM=m
 CONFIG_CRYPTO_DEV_OMAP_AES=m
 CONFIG_CRYPTO_DEV_OMAP_DES=m
-CONFIG_CRC_ITU_T=y
 CONFIG_DMA_CMA=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_PRINTK_TIME=y
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index d850f92a73ea..e14720a9a5ac 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -225,11 +225,10 @@ CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=y
 CONFIG_CRYPTO_DEV_ATMEL_TDES=y
 CONFIG_CRYPTO_DEV_ATMEL_SHA=y
-CONFIG_CRC_ITU_T=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_CMA_ALIGNMENT=9
 # CONFIG_DEBUG_MISC is not set
 # CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 423bb41c4225..dcd9c316072e 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -72,11 +72,10 @@ CONFIG_STM32_ADC=y
 CONFIG_EXT3_FS=y
 # CONFIG_FILE_LOCKING is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
 CONFIG_NLS=y
-CONFIG_CRC_ITU_T=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SLUB_DEBUG is not set
diff --git a/arch/arm/configs/wpcm450_defconfig b/arch/arm/configs/wpcm450_defconfig
index 60e38f5b7dae..cd4b3e70ff68 100644
--- a/arch/arm/configs/wpcm450_defconfig
+++ b/arch/arm/configs/wpcm450_defconfig
@@ -189,11 +189,10 @@ CONFIG_CRYPTO_SHA256=y
 CONFIG_ASYMMETRIC_KEY_TYPE=y
 CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
 CONFIG_X509_CERTIFICATE_PARSER=y
 CONFIG_PKCS7_MESSAGE_PARSER=y
 CONFIG_SYSTEM_TRUSTED_KEYRING=y
-CONFIG_CRC_ITU_T=m
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index 8caa03a41327..cba0b85c6707 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -80,10 +80,9 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_PROC_PAGE_MONITOR is not set
-CONFIG_CRC_ITU_T=m
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
diff --git a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
index 8404e0a9d8b2..8f9701efef19 100644
--- a/arch/mips/configs/rt305x_defconfig
+++ b/arch/mips/configs/rt305x_defconfig
@@ -126,11 +126,10 @@ CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 # CONFIG_JFFS2_ZLIB is not set
 CONFIG_SQUASHFS=y
 # CONFIG_SQUASHFS_ZLIB is not set
 CONFIG_SQUASHFS_XZ=y
 CONFIG_CRYPTO_ARC4=m
-CONFIG_CRC_ITU_T=m
 # CONFIG_XZ_DEC_X86 is not set
 # CONFIG_XZ_DEC_POWERPC is not set
 # CONFIG_XZ_DEC_IA64 is not set
 # CONFIG_XZ_DEC_ARM is not set
 # CONFIG_XZ_DEC_ARMTHUMB is not set
diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
index 7b91edfe3e07..aae8497b6872 100644
--- a/arch/mips/configs/xway_defconfig
+++ b/arch/mips/configs/xway_defconfig
@@ -138,11 +138,10 @@ CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 # CONFIG_JFFS2_ZLIB is not set
 CONFIG_SQUASHFS=y
 # CONFIG_SQUASHFS_ZLIB is not set
 CONFIG_SQUASHFS_XZ=y
 CONFIG_CRYPTO_ARC4=m
-CONFIG_CRC_ITU_T=m
 CONFIG_PRINTK_TIME=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 6c0517961eee..6f436cb7d0c1 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -277,11 +277,10 @@ CONFIG_SECURITY_LOCKDOWN_LSM=y
 CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
 CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY=y
 # CONFIG_INTEGRITY is not set
 CONFIG_LSM="yama,loadpin,safesetid,integrity"
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_ITU_T=y
 # CONFIG_XZ_DEC_X86 is not set
 # CONFIG_XZ_DEC_IA64 is not set
 # CONFIG_XZ_DEC_ARM is not set
 # CONFIG_XZ_DEC_ARMTHUMB is not set
 # CONFIG_XZ_DEC_SPARC is not set
diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
index d881fccbe6f0..64f9308ee586 100644
--- a/arch/sh/configs/se7206_defconfig
+++ b/arch/sh/configs/se7206_defconfig
@@ -99,6 +99,5 @@ CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_ITU_T=y
diff --git a/lib/Kconfig b/lib/Kconfig
index 4301bfd08feb..89470bb24519 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -153,16 +153,11 @@ config ARCH_HAS_CRC_T10DIF
 config CRC_T10DIF_ARCH
 	tristate
 	default CRC_T10DIF if ARCH_HAS_CRC_T10DIF && CRC_OPTIMIZATIONS
 
 config CRC_ITU_T
-	tristate "CRC ITU-T V.41 functions"
-	help
-	  This option is provided for the case where no in-kernel-tree
-	  modules require CRC ITU-T V.41 functions, but a module built outside
-	  the kernel tree does. Such modules that use library CRC ITU-T V.41
-	  functions require M here.
+	tristate
 
 config CRC32
 	tristate
 	select BITREVERSE
 
-- 
2.49.0



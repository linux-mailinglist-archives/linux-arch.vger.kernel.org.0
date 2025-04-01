Return-Path: <linux-arch+bounces-11207-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 250BEA78480
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 00:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCF0016D417
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D4221770C;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucYtp+Gi"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196CD215F76;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545782; cv=none; b=GgOh8conE8Fdr71V2pc4XHZIt8E+ltlkzSdt+knOYpR18cEiCl6NXR/0VtX2Sn739+BbZoDmBx4jca1uGBUVeNlU3sXj37rd/bfM83zgBV5GXIORSeHH5T9/2kxJGCBxfW7/kKQw7FAzYq7/qb0PDmQaVryVdl/xaNYx6CWMmQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545782; c=relaxed/simple;
	bh=wMxGKCu9zqWOb1Hlq6/iwlTdCJ7+Gvd/pZBDj9jxjOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7KQGL+x1uRg3OLbkTFfBUwYGru4LyFZBEbLnktv8au9heQ22dIf4XBWtmTGHOPRFP2QP1kMi6uYGQwsxmf2e/3xllmsicFVgeMp+rCi64wNpPkCCEya7xjtA03uYbetqC/7oMGzxjxKov2ook6F1j+PQE7ihb3gNhi2T6xAOzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucYtp+Gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8ED9C4CEF1;
	Tue,  1 Apr 2025 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743545781;
	bh=wMxGKCu9zqWOb1Hlq6/iwlTdCJ7+Gvd/pZBDj9jxjOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucYtp+Giu84Gcqog8+/VOZKUxI0E/EN2+8LWptsBD/5DD4qX4aDW2GE9q2a58Crcm
	 V1gNPcS67+RxD+Pln2TTNbQTI0U4rDRdDU0o4vCWL5oKRoXVgDu5sVSANHD/GHOaIZ
	 LZT19q+KsaxuqiCe9GuZ0yZi9xrBaHyYuETLTyVYhusRcBw4YGPg2xjCpb9X33kQvc
	 edG5mp2gnnqqDcAEfIGiD1B+obP+TGUSybswGtHrYtp9ES5Lc7tTptrMKwcXHtBt7X
	 uSMg9zdqV2Sb3xl/2fIbqKNslbLyXm7XfYWhgxu8CTE+lh5bqbiUK2uh3ZdSJNF+PR
	 XAj0ditWKTHdg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 3/7] lib/crc: remove unnecessary prompt for CONFIG_CRC16
Date: Tue,  1 Apr 2025 15:15:56 -0700
Message-ID: <20250401221600.24878-4-ebiggers@kernel.org>
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

All modules that need CONFIG_CRC16 already select it, so there is no
need to bother users about the option.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/hexagon/configs/comet_defconfig     | 1 -
 arch/m68k/configs/amcore_defconfig       | 1 -
 arch/mips/configs/omega2p_defconfig      | 1 -
 arch/mips/configs/rb532_defconfig        | 1 -
 arch/mips/configs/sb1250_swarm_defconfig | 1 -
 arch/mips/configs/vocore2_defconfig      | 1 -
 arch/powerpc/configs/skiroot_defconfig   | 1 -
 arch/sh/configs/hp6xx_defconfig          | 1 -
 arch/sh/configs/magicpanelr2_defconfig   | 1 -
 arch/sh/configs/se7206_defconfig         | 1 -
 arch/sh/configs/sh2007_defconfig         | 1 -
 arch/sh/configs/titan_defconfig          | 1 -
 arch/sparc/configs/sparc64_defconfig     | 1 -
 lib/Kconfig                              | 7 +------
 14 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index fed4a64b36fb..902cf30cf54b 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -70,11 +70,10 @@ CONFIG_INET=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC16=y
 CONFIG_CRC_T10DIF=y
 CONFIG_FRAME_WARN=0
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/m68k/configs/amcore_defconfig b/arch/m68k/configs/amcore_defconfig
index 67a0d157122d..110279a64aa4 100644
--- a/arch/m68k/configs/amcore_defconfig
+++ b/arch/m68k/configs/amcore_defconfig
@@ -87,6 +87,5 @@ CONFIG_PANIC_ON_OOPS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_CRYPTO_ECHAINIV is not set
 CONFIG_CRYPTO_ANSI_CPRNG=y
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC16=y
diff --git a/arch/mips/configs/omega2p_defconfig b/arch/mips/configs/omega2p_defconfig
index 128f9abab7fc..e2bcdfd290a1 100644
--- a/arch/mips/configs/omega2p_defconfig
+++ b/arch/mips/configs/omega2p_defconfig
@@ -109,11 +109,10 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
-CONFIG_CRC16=y
 CONFIG_XZ_DEC=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 0261969a6e45..42b161d587c7 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -153,7 +153,6 @@ CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_SQUASHFS=y
 CONFIG_CRYPTO_TEST=m
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC16=m
 CONFIG_STRIP_ASM_SYMS=y
diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index ce855b644bb0..ae2afff00e01 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -97,6 +97,5 @@ CONFIG_CRYPTO_FCRYPT=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC16=m
diff --git a/arch/mips/configs/vocore2_defconfig b/arch/mips/configs/vocore2_defconfig
index 917967fed45f..2a9a9b12847d 100644
--- a/arch/mips/configs/vocore2_defconfig
+++ b/arch/mips/configs/vocore2_defconfig
@@ -109,11 +109,10 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
-CONFIG_CRC16=y
 CONFIG_XZ_DEC=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_STRIP_ASM_SYMS=y
 CONFIG_DEBUG_FS=y
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 1eb446452fc0..6c0517961eee 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -277,11 +277,10 @@ CONFIG_SECURITY_LOCKDOWN_LSM=y
 CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=y
 CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY=y
 # CONFIG_INTEGRITY is not set
 CONFIG_LSM="yama,loadpin,safesetid,integrity"
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC16=y
 CONFIG_CRC_ITU_T=y
 # CONFIG_XZ_DEC_X86 is not set
 # CONFIG_XZ_DEC_IA64 is not set
 # CONFIG_XZ_DEC_ARM is not set
 # CONFIG_XZ_DEC_ARMTHUMB is not set
diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defconfig
index 77e3185f63e4..3b7525510f7c 100644
--- a/arch/sh/configs/hp6xx_defconfig
+++ b/arch/sh/configs/hp6xx_defconfig
@@ -54,7 +54,6 @@ CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC16=y
 CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index a1109762c8ec..93b9aa32dc7c 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -84,6 +84,5 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_DEBUG_KOBJECT=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_FRAME_POINTER=y
-CONFIG_CRC16=m
diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
index bdd29e817ff7..d881fccbe6f0 100644
--- a/arch/sh/configs/se7206_defconfig
+++ b/arch/sh/configs/se7206_defconfig
@@ -99,7 +99,6 @@ CONFIG_FRAME_POINTER=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC16=y
 CONFIG_CRC_ITU_T=y
diff --git a/arch/sh/configs/sh2007_defconfig b/arch/sh/configs/sh2007_defconfig
index 61bc391d443c..cc6292b3235a 100644
--- a/arch/sh/configs/sh2007_defconfig
+++ b/arch/sh/configs/sh2007_defconfig
@@ -191,6 +191,5 @@ CONFIG_CRYPTO_TEA=y
 CONFIG_CRYPTO_TWOFISH=y
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC16=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index 11ff5fd510de..f3fad19b3059 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -263,6 +263,5 @@ CONFIG_CRYPTO_CAST6=m
 CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC16=m
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 01b2bdfbf9a8..f1ba0fefe1f9 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -227,11 +227,10 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC16=m
 CONFIG_VCC=m
 CONFIG_PATA_CMD64X=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_DEVTMPFS=y
diff --git a/lib/Kconfig b/lib/Kconfig
index 81d8ff429dca..372e07c5e31d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -140,16 +140,11 @@ source "lib/crypto/Kconfig"
 
 config CRC_CCITT
 	tristate
 
 config CRC16
-	tristate "CRC16 functions"
-	help
-	  This option is provided for the case where no in-kernel-tree
-	  modules require CRC16 functions, but a module built outside
-	  the kernel tree does. Such modules that use library CRC16
-	  functions require M here.
+	tristate
 
 config CRC_T10DIF
 	tristate "CRC calculation for the T10 Data Integrity Field"
 	help
 	  This option is only needed if a module that's not in the
-- 
2.49.0



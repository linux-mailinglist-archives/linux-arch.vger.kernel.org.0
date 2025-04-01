Return-Path: <linux-arch+bounces-11208-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E5A78485
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 00:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C9616DA8D
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 22:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43121B199;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rj/1Wf7d"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39D521A446;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545782; cv=none; b=f8JUDU5WpoRfXeNAZB8CVZp6mJTNjOQCGsGoM9xvZaIQZxljce7DDzFmklW3tQ60yVA50b4PGFqSaqVUhk/V2WfMTN9HuLWkkdZ1QXF0DecTb3SBYhzp4g30Vk544pXKDp5ifA9wPuNjjD7Ruo1ZZrbTSIBwwCGZJJEGK26EgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545782; c=relaxed/simple;
	bh=YDfbk6BFreJdhRHHCWLbB0LNFAF69sttARGUMYHpvpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXWOLMS3M1Ct4JAAyJr5/vjLvFjYJJH+2mkg72McV4H6TwEjtm9rvqCuhc/99ZMUcfQFb5MkDrAw8g34czJLFaLzMwJHyzkGgzCBfS+15xaffbpwVxbDg+CzJ7sFG+Zzgfct52Sf2exKwktvEmjVfivrOeO2oPyJpScm+ErcX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rj/1Wf7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16317C4CEEF;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743545782;
	bh=YDfbk6BFreJdhRHHCWLbB0LNFAF69sttARGUMYHpvpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rj/1Wf7d9W/dkw2ptoaclLxBy77lMo4uCebMM/DjIR2gCuZ3PSPPcVYyhcEh5uBne
	 T9psftbzAa/ki0xfb9nickTa1zX3Z4eR8frzo6C5rSs6DQK/PJKoFPpDrk2BdfKJ5f
	 /bkeLbnb1opN+0ReOx91qqFtE9m0XZ9+Q+FJ17WwS8cw/Tp8akV7TZIn50+5UnrLpX
	 ZQXrc+NYi+r/PwcN0cEeTCBCrtFSTLbXEt1sLKMUV3MfnZFsaUawm7ZXziG46Rwzy9
	 PeoMfrgkG8kKiL+JDNezsT0Uh98XSCe/Tjta0fqUbR+PHggVqrxTXxOJU3BN3Indjn
	 B3WsJCmMN34Kw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 4/7] lib/crc: remove unnecessary prompt for CONFIG_CRC_T10DIF
Date: Tue,  1 Apr 2025 15:15:57 -0700
Message-ID: <20250401221600.24878-5-ebiggers@kernel.org>
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

All modules that need CONFIG_CRC_T10DIF already select it, so there is no
need to bother users about the option.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm/configs/davinci_all_defconfig            | 1 -
 arch/arm/configs/imx_v6_v7_defconfig              | 1 -
 arch/arm/configs/omap2plus_defconfig              | 1 -
 arch/arm/configs/orion5x_defconfig                | 1 -
 arch/arm/configs/pxa_defconfig                    | 1 -
 arch/hexagon/configs/comet_defconfig              | 1 -
 arch/mips/configs/bigsur_defconfig                | 1 -
 arch/mips/configs/ip22_defconfig                  | 1 -
 arch/mips/configs/ip27_defconfig                  | 1 -
 arch/mips/configs/ip30_defconfig                  | 1 -
 arch/mips/configs/ip32_defconfig                  | 1 -
 arch/parisc/configs/generic-32bit_defconfig       | 1 -
 arch/powerpc/configs/44x/sam440ep_defconfig       | 1 -
 arch/powerpc/configs/44x/warp_defconfig           | 1 -
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   | 1 -
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig | 1 -
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   | 1 -
 arch/powerpc/configs/85xx/ge_imp3a_defconfig      | 1 -
 arch/powerpc/configs/85xx/stx_gp3_defconfig       | 1 -
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig   | 1 -
 arch/powerpc/configs/86xx-hw.config               | 1 -
 arch/powerpc/configs/amigaone_defconfig           | 1 -
 arch/powerpc/configs/chrp32_defconfig             | 1 -
 arch/powerpc/configs/fsl-emb-nonhw.config         | 1 -
 arch/powerpc/configs/g5_defconfig                 | 1 -
 arch/powerpc/configs/linkstation_defconfig        | 1 -
 arch/powerpc/configs/mpc83xx_defconfig            | 1 -
 arch/powerpc/configs/mvme5100_defconfig           | 1 -
 arch/powerpc/configs/pmac32_defconfig             | 1 -
 arch/powerpc/configs/ppc44x_defconfig             | 1 -
 arch/powerpc/configs/ppc64e_defconfig             | 1 -
 arch/powerpc/configs/ps3_defconfig                | 1 -
 arch/powerpc/configs/storcenter_defconfig         | 1 -
 arch/sh/configs/ap325rxa_defconfig                | 1 -
 arch/sh/configs/ecovec24_defconfig                | 1 -
 arch/sh/configs/espt_defconfig                    | 1 -
 arch/sh/configs/hp6xx_defconfig                   | 1 -
 arch/sh/configs/landisk_defconfig                 | 1 -
 arch/sh/configs/lboxre2_defconfig                 | 1 -
 arch/sh/configs/migor_defconfig                   | 1 -
 arch/sh/configs/r7780mp_defconfig                 | 1 -
 arch/sh/configs/r7785rp_defconfig                 | 1 -
 arch/sh/configs/rts7751r2d1_defconfig             | 1 -
 arch/sh/configs/rts7751r2dplus_defconfig          | 1 -
 arch/sh/configs/sdk7780_defconfig                 | 1 -
 arch/sh/configs/se7724_defconfig                  | 1 -
 arch/sh/configs/sh7763rdp_defconfig               | 1 -
 lib/Kconfig                                       | 6 +-----
 tools/testing/selftests/bpf/config.x86_64         | 1 -
 tools/testing/selftests/hid/config.common         | 1 -
 51 files changed, 1 insertion(+), 55 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 3474e475373a..70b8c78386f4 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -247,11 +247,10 @@ CONFIG_NFSD=m
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_T10DIF=m
 CONFIG_DMA_CMA=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_RT_MUTEXES=y
 CONFIG_DEBUG_MUTEXES=y
 # CONFIG_ARM_UNWIND is not set
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 9c2f8a3b30cb..062c1eb8dd60 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -479,11 +479,10 @@ CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_SAHARA=y
 CONFIG_CRYPTO_DEV_MXS_DCP=y
-CONFIG_CRC_T10DIF=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_PRINTK_TIME=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c5238581a8f6..d8a35c44b64f 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -704,11 +704,10 @@ CONFIG_CRYPTO_AES_ARM_BS=m
 CONFIG_CRYPTO_CHACHA20_NEON=m
 CONFIG_CRYPTO_DEV_OMAP=m
 CONFIG_CRYPTO_DEV_OMAP_SHAM=m
 CONFIG_CRYPTO_DEV_OMAP_AES=m
 CONFIG_CRYPTO_DEV_OMAP_DES=m
-CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
 CONFIG_DMA_CMA=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 0629b088a584..62b9c6102789 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -134,11 +134,10 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_2=y
 CONFIG_CRYPTO_CBC=m
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_DEV_MARVELL_CESA=y
-CONFIG_CRC_T10DIF=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SLUB_DEBUG is not set
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index c21ea1d72f7c..24fca8608554 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -661,11 +661,10 @@ CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
 CONFIG_CRYPTO_SHA1_ARM=m
 CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
 CONFIG_CRYPTO_AES_ARM=m
-CONFIG_CRC_T10DIF=m
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_FONT_6x11=y
 CONFIG_FONT_MINI_4x6=y
diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index 902cf30cf54b..c6108f000288 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -70,10 +70,9 @@ CONFIG_INET=y
 # CONFIG_INET_DIAG is not set
 # CONFIG_IPV6 is not set
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_T10DIF=y
 CONFIG_FRAME_WARN=0
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index fe282630b51c..8f7c36868204 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -236,10 +236,9 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRC_T10DIF=m
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_LIST=y
diff --git a/arch/mips/configs/ip22_defconfig b/arch/mips/configs/ip22_defconfig
index 31ca93d3acc5..f1a8ccf2c459 100644
--- a/arch/mips/configs/ip22_defconfig
+++ b/arch/mips/configs/ip22_defconfig
@@ -324,7 +324,6 @@ CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_T10DIF=m
 CONFIG_DEBUG_MEMORY_INIT=y
diff --git a/arch/mips/configs/ip27_defconfig b/arch/mips/configs/ip27_defconfig
index b8907b3d7a33..5d079941fd20 100644
--- a/arch/mips/configs/ip27_defconfig
+++ b/arch/mips/configs/ip27_defconfig
@@ -315,6 +315,5 @@ CONFIG_CRYPTO_KHAZAD=m
 CONFIG_CRYPTO_SEED=m
 CONFIG_CRYPTO_SERPENT=m
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRC_T10DIF=m
diff --git a/arch/mips/configs/ip30_defconfig b/arch/mips/configs/ip30_defconfig
index 270181a7320a..a4524e785469 100644
--- a/arch/mips/configs/ip30_defconfig
+++ b/arch/mips/configs/ip30_defconfig
@@ -177,6 +177,5 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD4=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_XCBC=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRC_T10DIF=m
diff --git a/arch/mips/configs/ip32_defconfig b/arch/mips/configs/ip32_defconfig
index 121e7e48fa77..d8ac11427f69 100644
--- a/arch/mips/configs/ip32_defconfig
+++ b/arch/mips/configs/ip32_defconfig
@@ -175,10 +175,9 @@ CONFIG_CRYPTO_FCRYPT=y
 CONFIG_CRYPTO_KHAZAD=y
 CONFIG_CRYPTO_SERPENT=y
 CONFIG_CRYPTO_TEA=y
 CONFIG_CRYPTO_TWOFISH=y
 CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRC_T10DIF=y
 CONFIG_FONTS=y
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 68c45d39e5b1..5b65c9859613 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -262,11 +262,10 @@ CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_SHA1=y
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_DEFLATE=y
-CONFIG_CRC_T10DIF=y
 CONFIG_FONTS=y
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_MEMORY_INIT=y
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/configs/44x/sam440ep_defconfig
index 2479ab62d12f..98221bda380d 100644
--- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -89,7 +89,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_AFFS_FS=m
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 633dba199d62..5757625469c4 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -83,11 +83,10 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRC_T10DIF=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index 1715ff547442..b99caba8724a 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -71,8 +71,7 @@ CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_8=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
index e65c0057147f..11163052fdba 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
@@ -78,7 +78,6 @@ CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
index 17714bf0ed40..312d39e4242c 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
@@ -70,7 +70,6 @@ CONFIG_VFAT_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index 58fae5131fa7..ac27f99faab8 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -73,8 +73,7 @@ CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index 3cf48f1f729f..7beb36a41d45 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -219,11 +219,10 @@ CONFIG_NLS_ISO8859_13=m
 CONFIG_NLS_ISO8859_14=m
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_KOI8_R=m
 CONFIG_NLS_KOI8_U=m
 CONFIG_NLS_UTF8=y
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_SHA512=m
 CONFIG_CRYPTO_DES=y
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
index ef7c511a6930..0a42072fa23c 100644
--- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -58,9 +58,8 @@ CONFIG_VFAT_FS=m
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=m
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
-CONFIG_CRC_T10DIF=m
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_BDI_SWITCH=y
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 3a6381aa9fdc..488d03ae6d6c 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -130,10 +130,9 @@ CONFIG_JFFS2_SUMMARY=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
-CONFIG_CRC_T10DIF=y
 CONFIG_DETECT_HUNG_TASK=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
diff --git a/arch/powerpc/configs/86xx-hw.config b/arch/powerpc/configs/86xx-hw.config
index 0cb24b33c88e..e7bd265fae5a 100644
--- a/arch/powerpc/configs/86xx-hw.config
+++ b/arch/powerpc/configs/86xx-hw.config
@@ -3,11 +3,10 @@ CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_BROADCOM_PHY=y
 # CONFIG_CARDBUS is not set
 CONFIG_CHR_DEV_SG=y
 CONFIG_CHR_DEV_ST=y
-CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_HMAC=y
 CONFIG_DS1682=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_GEF_WDT=y
 CONFIG_GIANFAR=y
diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
index 200bb1ecb560..69ef3dc31c4b 100644
--- a/arch/powerpc/configs/amigaone_defconfig
+++ b/arch/powerpc/configs/amigaone_defconfig
@@ -104,11 +104,10 @@ CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_AFFS_FS=m
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=m
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index fb314f75ad4b..b799c95480ae 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -108,11 +108,10 @@ CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=m
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/configs/fsl-emb-nonhw.config
index d6d2a458847b..2f81bc2d819e 100644
--- a/arch/powerpc/configs/fsl-emb-nonhw.config
+++ b/arch/powerpc/configs/fsl-emb-nonhw.config
@@ -13,11 +13,10 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_CGROUPS=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_CRC_T10DIF=y
 CONFIG_CPUSETS=y
 CONFIG_CRAMFS=y
 CONFIG_CRYPTO_MD4=y
 CONFIG_CRYPTO_NULL=y
 CONFIG_CRYPTO_PCBC=m
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 9215bed53291..7e58f3e6c987 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -229,11 +229,10 @@ CONFIG_NLS_CODEPAGE_1250=y
 CONFIG_NLS_CODEPAGE_1251=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_BOOTX_TEXT=y
 CONFIG_CRYPTO_TEST=m
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index 8be99d4d5289..b564f9e33a0d 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -123,11 +123,10 @@ CONFIG_NFSD=m
 CONFIG_CIFS=m
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_932=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 83c4710017e9..a815d9e5e3e8 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -95,10 +95,9 @@ CONFIG_EXT4_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_SHA512=y
 CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
index dd7b0f8e50ae..fa2b3b9c5945 100644
--- a/arch/powerpc/configs/mvme5100_defconfig
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -105,11 +105,10 @@ CONFIG_CIFS=m
 CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_CODEPAGE_932=m
 CONFIG_NLS_ISO8859_1=m
 CONFIG_NLS_UTF8=m
-CONFIG_CRC_T10DIF=y
 CONFIG_XZ_DEC=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=20
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index e8b3f67bf3f5..1bc3466bc909 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -274,11 +274,10 @@ CONFIG_NFS_V4=y
 CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 8b595f67068c..41c930f74ed4 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -88,11 +88,10 @@ CONFIG_SQUASHFS_XATTR=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=m
 CONFIG_NLS_ISO8859_1=m
-CONFIG_CRC_T10DIF=m
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 # CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 4c05f4e4d505..d2e659a2d8cb 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -205,11 +205,10 @@ CONFIG_CIFS_POSIX=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRC_T10DIF=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 62376b8c13e9..0b48d2b776c4 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -146,11 +146,10 @@ CONFIG_NLS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_LZO=m
-CONFIG_CRC_T10DIF=y
 CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_DEBUG_STACKOVERFLOW=y
diff --git a/arch/powerpc/configs/storcenter_defconfig b/arch/powerpc/configs/storcenter_defconfig
index 7a978d396991..e415222bd839 100644
--- a/arch/powerpc/configs/storcenter_defconfig
+++ b/arch/powerpc/configs/storcenter_defconfig
@@ -73,6 +73,5 @@ CONFIG_JFFS2_FS=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/ap325rxa_defconfig b/arch/sh/configs/ap325rxa_defconfig
index 4464a2ad42ed..b6f36c938f1d 100644
--- a/arch/sh/configs/ap325rxa_defconfig
+++ b/arch/sh/configs/ap325rxa_defconfig
@@ -97,6 +97,5 @@ CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_CBC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/ecovec24_defconfig b/arch/sh/configs/ecovec24_defconfig
index ee1b36682155..e76694aace25 100644
--- a/arch/sh/configs/ecovec24_defconfig
+++ b/arch/sh/configs/ecovec24_defconfig
@@ -126,6 +126,5 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_CBC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/espt_defconfig b/arch/sh/configs/espt_defconfig
index 67716a44463e..da176f100e00 100644
--- a/arch/sh/configs/espt_defconfig
+++ b/arch/sh/configs/espt_defconfig
@@ -108,6 +108,5 @@ CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defconfig
index 3b7525510f7c..3582af15ad86 100644
--- a/arch/sh/configs/hp6xx_defconfig
+++ b/arch/sh/configs/hp6xx_defconfig
@@ -54,6 +54,5 @@ CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_ECB=y
 CONFIG_CRYPTO_PCBC=y
 CONFIG_CRYPTO_MD5=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
index d871623955c5..924bb3233b0b 100644
--- a/arch/sh/configs/landisk_defconfig
+++ b/arch/sh/configs/landisk_defconfig
@@ -109,6 +109,5 @@ CONFIG_NFSD=m
 CONFIG_SMB_FS=m
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_SH_STANDARD_BIOS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/lboxre2_defconfig b/arch/sh/configs/lboxre2_defconfig
index 6a234761bfd7..0307bb2be79f 100644
--- a/arch/sh/configs/lboxre2_defconfig
+++ b/arch/sh/configs/lboxre2_defconfig
@@ -56,6 +56,5 @@ CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_ROMFS_FS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_SH_STANDARD_BIOS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 2d1e65cad239..fc2010c241fb 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -88,6 +88,5 @@ CONFIG_NFS_FS=y
 CONFIG_ROOT_NFS=y
 CONFIG_DEBUG_FS=y
 CONFIG_CRYPTO_MANAGER=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 # CONFIG_CRYPTO_HW is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/r7780mp_defconfig b/arch/sh/configs/r7780mp_defconfig
index 6bd6c0ae85d7..f28b8c4181c2 100644
--- a/arch/sh/configs/r7780mp_defconfig
+++ b/arch/sh/configs/r7780mp_defconfig
@@ -103,6 +103,5 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/r7785rp_defconfig b/arch/sh/configs/r7785rp_defconfig
index cde668569cc1..3a4239f20ff1 100644
--- a/arch/sh/configs/r7785rp_defconfig
+++ b/arch/sh/configs/r7785rp_defconfig
@@ -101,6 +101,5 @@ CONFIG_DEBUG_STACK_USAGE=y
 CONFIG_4KSTACKS=y
 CONFIG_CRYPTO_ECB=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/rts7751r2d1_defconfig b/arch/sh/configs/rts7751r2d1_defconfig
index c863a11c7592..69568cc40396 100644
--- a/arch/sh/configs/rts7751r2d1_defconfig
+++ b/arch/sh/configs/rts7751r2d1_defconfig
@@ -85,6 +85,5 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_MINIX_FS=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_DEBUG_FS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/rts7751r2dplus_defconfig b/arch/sh/configs/rts7751r2dplus_defconfig
index 7e4f710d46c7..ecb4bdb5bb58 100644
--- a/arch/sh/configs/rts7751r2dplus_defconfig
+++ b/arch/sh/configs/rts7751r2dplus_defconfig
@@ -90,6 +90,5 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_MINIX_FS=y
 CONFIG_NLS_CODEPAGE_932=y
 CONFIG_DEBUG_FS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
index cd24cf08210e..9870d16d9711 100644
--- a/arch/sh/configs/sdk7780_defconfig
+++ b/arch/sh/configs/sdk7780_defconfig
@@ -134,6 +134,5 @@ CONFIG_TIMER_STATS=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 CONFIG_SH_STANDARD_BIOS=y
 CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/se7724_defconfig b/arch/sh/configs/se7724_defconfig
index 96521271758c..9501e69eb886 100644
--- a/arch/sh/configs/se7724_defconfig
+++ b/arch/sh/configs/se7724_defconfig
@@ -126,6 +126,5 @@ CONFIG_NLS_CODEPAGE_932=y
 CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_CBC=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/arch/sh/configs/sh7763rdp_defconfig b/arch/sh/configs/sh7763rdp_defconfig
index 57923c3296cc..b77b3313157e 100644
--- a/arch/sh/configs/sh7763rdp_defconfig
+++ b/arch/sh/configs/sh7763rdp_defconfig
@@ -110,6 +110,5 @@ CONFIG_NLS_KOI8_R=y
 CONFIG_NLS_KOI8_U=y
 CONFIG_NLS_UTF8=y
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRC_T10DIF=y
diff --git a/lib/Kconfig b/lib/Kconfig
index 372e07c5e31d..4301bfd08feb 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -143,15 +143,11 @@ config CRC_CCITT
 
 config CRC16
 	tristate
 
 config CRC_T10DIF
-	tristate "CRC calculation for the T10 Data Integrity Field"
-	help
-	  This option is only needed if a module that's not in the
-	  kernel tree needs to calculate CRC checks for use with the
-	  SCSI data integrity subsystem.
+	tristate
 
 config ARCH_HAS_CRC_T10DIF
 	bool
 
 config CRC_T10DIF_ARCH
diff --git a/tools/testing/selftests/bpf/config.x86_64 b/tools/testing/selftests/bpf/config.x86_64
index 5680befae8c6..5e713ef7caa3 100644
--- a/tools/testing/selftests/bpf/config.x86_64
+++ b/tools/testing/selftests/bpf/config.x86_64
@@ -37,11 +37,10 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_IDLE_GOV_LADDER=y
 CONFIG_CPUSETS=y
-CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_BLAKE2B=y
 CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_XXHASH=y
 CONFIG_DCB=y
 CONFIG_DEBUG_ATOMIC_SLEEP=y
diff --git a/tools/testing/selftests/hid/config.common b/tools/testing/selftests/hid/config.common
index 45b5570441ce..b1f40857307d 100644
--- a/tools/testing/selftests/hid/config.common
+++ b/tools/testing/selftests/hid/config.common
@@ -37,11 +37,10 @@ CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_STAT=y
 CONFIG_CPU_IDLE_GOV_LADDER=y
 CONFIG_CPUSETS=y
-CONFIG_CRC_T10DIF=y
 CONFIG_CRYPTO_BLAKE2B=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
 CONFIG_CRYPTO_SEQIV=y
 CONFIG_CRYPTO_XXHASH=y
 CONFIG_DCB=y
-- 
2.49.0



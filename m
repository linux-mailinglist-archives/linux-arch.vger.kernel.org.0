Return-Path: <linux-arch+bounces-11206-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D6A78481
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 00:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 094387A4333
	for <lists+linux-arch@lfdr.de>; Tue,  1 Apr 2025 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDFE2165E4;
	Tue,  1 Apr 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC+Q+B+y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BB215F49;
	Tue,  1 Apr 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545782; cv=none; b=hrRVRxLI5o2ndmhEfmNBkpK0ArI549PFCFMRxqbvKMtjLoytQi+XPvtkQSVpvL55Tkg44ermLtl2JdIC3MraX4NlM4RBcX8YTLncTHwl8ekXGuLwbNV3dYpRIH6Pp8Dext6sH6ZPBt1VwJxT6R0pb9ivvwpymOlCb1de96Y36F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545782; c=relaxed/simple;
	bh=9L56iWH0HfViEyjnDqaHdARN8V26Mic5HWPR9rwBQC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYTsvRQs86iaEnBWm62lyX99sbFbX10qJ9+E2Sr6Cgeq7HbDke0C3An7FB3UxpuHWIH7rzQr2dQmZPSEGBHTqBg5OCY4dshUq86+hSWdspN9ldN8wyd15JShNT6jqVXTHd4BKgIrbffnYNe0YMyi9/iojl4LpuReJdcliRfu7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC+Q+B+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47565C4CEEB;
	Tue,  1 Apr 2025 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743545781;
	bh=9L56iWH0HfViEyjnDqaHdARN8V26Mic5HWPR9rwBQC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HC+Q+B+ylUl7GgGmb7LBpRAEOhcw8wUzSuEW4uw31y4Ukl9y1ALRaRYCqp7EwjXzf
	 SxRnUxSSWG4yk/ZpuEMSpz336cVg+rW5mun669RpohwQdrW2Op3zr8wZ+rSfAVx6jU
	 Y1HZkJrz5P2QEZAv0SfjITgKUUz/agn694sl8nBDUmBWizaSu95lpYSjQpTTp3p9Om
	 OkXnqowOV4AH/P7PQGs7YlC2x7oPqhuWY1pctLlCKL6/F2UizgD7FaxWBTPdw0q2gO
	 n59gJJCPnOMbFMyXQRHkZzFHgByb35QinoUeAJHmQWu6qG5+svDVjaZGu5q7oSHeWW
	 ZDCWjhxWRO6mA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 1/7] lib/crc: remove unnecessary prompt for CONFIG_CRC32 and drop 'default y'
Date: Tue,  1 Apr 2025 15:15:54 -0700
Message-ID: <20250401221600.24878-2-ebiggers@kernel.org>
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

All modules that need CONFIG_CRC32 already select it, so there is no
need to bother users about the option, nor to default it to y.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/sh/configs/edosk7705_defconfig        | 1 -
 arch/sh/configs/kfr2r09-romimage_defconfig | 1 -
 arch/sh/configs/sh7724_generic_defconfig   | 1 -
 arch/sh/configs/sh7770_generic_defconfig   | 1 -
 lib/Kconfig                                | 8 +-------
 5 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/sh/configs/edosk7705_defconfig b/arch/sh/configs/edosk7705_defconfig
index 296ed768cbbb..ee3f6db7d8da 100644
--- a/arch/sh/configs/edosk7705_defconfig
+++ b/arch/sh/configs/edosk7705_defconfig
@@ -31,6 +31,5 @@ CONFIG_CMDLINE_FROM_BOOTLOADER=y
 # CONFIG_USB_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_PROC_FS is not set
 # CONFIG_SYSFS is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/kfr2r09-romimage_defconfig b/arch/sh/configs/kfr2r09-romimage_defconfig
index 42bf34181a3e..88fbb65cb9f9 100644
--- a/arch/sh/configs/kfr2r09-romimage_defconfig
+++ b/arch/sh/configs/kfr2r09-romimage_defconfig
@@ -47,6 +47,5 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 CONFIG_DEBUG_FS=y
-# CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/sh7724_generic_defconfig b/arch/sh/configs/sh7724_generic_defconfig
index 5440bd0ca4ed..e6298f22623a 100644
--- a/arch/sh/configs/sh7724_generic_defconfig
+++ b/arch/sh/configs/sh7724_generic_defconfig
@@ -37,6 +37,5 @@ CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_PROC_FS is not set
 # CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_CRC32 is not set
diff --git a/arch/sh/configs/sh7770_generic_defconfig b/arch/sh/configs/sh7770_generic_defconfig
index 4338af8d02d0..2e2b46980b58 100644
--- a/arch/sh/configs/sh7770_generic_defconfig
+++ b/arch/sh/configs/sh7770_generic_defconfig
@@ -39,6 +39,5 @@ CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_PROC_FS is not set
 # CONFIG_SYSFS is not set
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_CRC32 is not set
diff --git a/lib/Kconfig b/lib/Kconfig
index 61cce0686b53..c91de83b3e5a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -175,18 +175,12 @@ config CRC_ITU_T
 	  modules require CRC ITU-T V.41 functions, but a module built outside
 	  the kernel tree does. Such modules that use library CRC ITU-T V.41
 	  functions require M here.
 
 config CRC32
-	tristate "CRC32/CRC32c functions"
-	default y
+	tristate
 	select BITREVERSE
-	help
-	  This option is provided for the case where no in-kernel-tree
-	  modules require CRC32/CRC32c functions, but a module built outside
-	  the kernel tree does. Such modules that use library CRC32/CRC32c
-	  functions require M here.
 
 config ARCH_HAS_CRC32
 	bool
 
 config CRC32_ARCH
-- 
2.49.0



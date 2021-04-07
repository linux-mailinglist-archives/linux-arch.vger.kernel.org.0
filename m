Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DEE35634A
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbhDGFfl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345328AbhDGFfa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B23C613D2;
        Wed,  7 Apr 2021 05:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773720;
        bh=0239ZVpF/A0+KAxcPRCh+JViWwBs7E9YBWSypoFdFGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KK6F79PilecPNNzW3JoxL/ZfHPwDWHnJyH/G91ybdZ/RdhIng3E/56ZLN2QtAzcV2
         2tgQc/r7vPMaGcHn2B2dyFQj19zluQH2qaGdIbTaVoQia73bXrOeRZru4S4BJ+9SdU
         J/AkzuxD5gi66yBujOlHRaZbwPBT50rbLYarDxHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 10/20] kbuild: arm: use common install script
Date:   Wed,  7 Apr 2021 07:34:09 +0200
Message-Id: <20210407053419.449796-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The common scripts/install.sh script will now work for arm, all that
is needed is to add the compressed image type to it.  So add that file
type check and the ability to call /sbin/loadmap after copying the
kernel.  With that we can remove the arm-only version of the file.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/Makefile   |  6 ++--
 arch/arm/boot/install.sh | 66 ----------------------------------------
 scripts/install.sh       | 10 +++++-
 3 files changed, 12 insertions(+), 70 deletions(-)
 delete mode 100644 arch/arm/boot/install.sh

diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 0b3cd7a33a26..053187f0b714 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -104,15 +104,15 @@ initrd:
 	(echo You must specify INITRD; exit -1)
 
 install:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh "$(KERNELRELEASE)" \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
 
 zinstall:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh "$(KERNELRELEASE)" \
 	$(obj)/zImage System.map "$(INSTALL_PATH)"
 
 uinstall:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh "$(KERNELRELEASE)" \
 	$(obj)/uImage System.map "$(INSTALL_PATH)"
 
 subdir-	    := bootp compressed dts
diff --git a/arch/arm/boot/install.sh b/arch/arm/boot/install.sh
deleted file mode 100644
index 2a45092a40e3..000000000000
--- a/arch/arm/boot/install.sh
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-#
-# arch/arm/boot/install.sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-# Adapted from code in arch/i386/boot/install.sh by Russell King
-#
-# "make install" script for arm architecture
-#
-# Arguments:
-#   $1 - kernel version
-#   $2 - kernel image file
-#   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
-#
-
-verify () {
-	if [ ! -f "$1" ]; then
-		echo ""                                                   1>&2
-		echo " *** Missing file: $1"                              1>&2
-		echo ' *** You need to run "make" before "make install".' 1>&2
-		echo ""                                                   1>&2
-		exit 1
-	fi
-}
-
-# Make sure the files actually exist
-verify "$2"
-verify "$3"
-
-# User may have a custom install script
-if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
-
-if [ "$(basename $2)" = "zImage" ]; then
-# Compressed install
-  echo "Installing compressed kernel"
-  base=vmlinuz
-else
-# Normal install
-  echo "Installing normal kernel"
-  base=vmlinux
-fi
-
-if [ -f $4/$base-$1 ]; then
-  mv $4/$base-$1 $4/$base-$1.old
-fi
-cat $2 > $4/$base-$1
-
-# Install system map file
-if [ -f $4/System.map-$1 ]; then
-  mv $4/System.map-$1 $4/System.map-$1.old
-fi
-cp $3 $4/System.map-$1
-
-if [ -x /sbin/loadmap ]; then
-  /sbin/loadmap
-else
-  echo "You have to install it yourself"
-fi
diff --git a/scripts/install.sh b/scripts/install.sh
index 9c8a22d96255..73067b535ea0 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -51,7 +51,8 @@ if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
 
 base=$(basename "$2")
 if [ "$base" = "bzImage" ] ||
-   [ "$base" = "Image.gz" ] ; then
+   [ "$base" = "Image.gz" ] ||
+   [ "$base" = "zImage" ] ; then
 	# Compressed install
 	echo "Installing compressed kernel"
 	base=vmlinuz
@@ -78,6 +79,13 @@ sync
 
 # Some architectures like to call specific bootloader "helper" programs:
 case "${ARCH}" in
+	arm)
+		if [ -x /sbin/loadmap ]; then
+			/sbin/loadmap
+		else
+			echo "You have to install it yourself"
+		fi
+		;;
 	x86)
 		if [ -x /sbin/lilo ]; then
 			/sbin/lilo
-- 
2.31.1


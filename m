Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3743356346
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348823AbhDGFfg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348793AbhDGFf0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31FD6613AF;
        Wed,  7 Apr 2021 05:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773717;
        bh=M0BhCTrtn5EN5sNzgfCPhHAstNgxDh2an+uMVidHxhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ge5WWcmT9iOVa9uLfkH50Yi3MDQrPmdbm0uhqMqBzcdyOAJd4TiSHyxi1EsgtkL/F
         FN/DBPAVM+jZMvK4Ilw9O98NjHKmWiiM/6NDudeJcILwKrk+AG1pBeaNTLHGYPoMq8
         dSVx7Wrkhvxxn41kIfIOnfwMsCxAH1qQccsLWOTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/20] kbuild: arm64: use common install script
Date:   Wed,  7 Apr 2021 07:34:08 +0200
Message-Id: <20210407053419.449796-10-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The common scripts/install.sh script will now work for arm65, no changes
needed so convert the arm64 boot Makefile to call it instead of the
arm64-only version of the file and remove the now unused file.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/Makefile   |  4 +--
 arch/arm64/boot/install.sh | 60 --------------------------------------
 2 files changed, 2 insertions(+), 62 deletions(-)
 delete mode 100644 arch/arm64/boot/install.sh

diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index cd3414898d10..08c56332dde2 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -37,9 +37,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 	$(call if_changed,lzo)
 
 install:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
 
 zinstall:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh $(KERNELRELEASE) \
 	$(obj)/Image.gz System.map "$(INSTALL_PATH)"
diff --git a/arch/arm64/boot/install.sh b/arch/arm64/boot/install.sh
deleted file mode 100644
index d91e1f022573..000000000000
--- a/arch/arm64/boot/install.sh
+++ /dev/null
@@ -1,60 +0,0 @@
-#!/bin/sh
-#
-# arch/arm64/boot/install.sh
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
-# "make install" script for the AArch64 Linux port
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
-if [ "$(basename $2)" = "Image.gz" ]; then
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
-- 
2.31.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F02F35633A
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348777AbhDGFfZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348781AbhDGFfQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFBBB613CD;
        Wed,  7 Apr 2021 05:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773707;
        bh=uMG/cQRFUC9+CiAgPW7FU6n8MPg87Dm5ua+Jwmm6WYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlwIWx3BIdtOtnYiA1p8yWZWvoPQEghJXqRP2JQKxUI/OF6UCCJP6MiYTe/TxvjzT
         eNB1gk9ja2C7kL4id3Oof1ETOCNFQJcjP5aSareWcq6dRwxzD/tjzOOWXBTozxaLxC
         HyjTynB5PghiAbL+DTWfDGCNLCyxqb+VzwOZTq3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 19/20] kbuild: sparc: use common install script
Date:   Wed,  7 Apr 2021 07:34:18 +0200
Message-Id: <20210407053419.449796-20-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The common scripts/install.sh script will now work for sparc, all that
is needed is to add it to the list of arches that do not put the version
number in the installed file name.

With that we can remove the sparc-only version of the install script.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/boot/Makefile   |  2 +-
 arch/sparc/boot/install.sh | 50 --------------------------------------
 scripts/install.sh         |  2 +-
 3 files changed, 2 insertions(+), 52 deletions(-)
 delete mode 100644 arch/sparc/boot/install.sh

diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 380e2b018992..952f8e7a40ec 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -72,5 +72,5 @@ $(obj)/tftpboot.img: $(obj)/image $(obj)/piggyback System.map $(ROOT_IMG) FORCE
 	$(call if_changed,piggy)
 
 install:
-	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(obj)/zImage \
+	sh $(srctree)/scripts/install.sh $(KERNELRELEASE) $(obj)/zImage \
 		System.map "$(INSTALL_PATH)"
diff --git a/arch/sparc/boot/install.sh b/arch/sparc/boot/install.sh
deleted file mode 100644
index b32851eae693..000000000000
--- a/arch/sparc/boot/install.sh
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/bin/sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-#
-# "make install" script for SPARC architecture
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
-
-if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
-
-# Default install - same as make zlilo
-
-if [ -f $4/vmlinuz ]; then
-	mv $4/vmlinuz $4/vmlinuz.old
-fi
-
-if [ -f $4/System.map ]; then
-	mv $4/System.map $4/System.old
-fi
-
-cat $2 > $4/vmlinuz
-cp $3 $4/System.map
diff --git a/scripts/install.sh b/scripts/install.sh
index 67c0a5f74af2..225b19bbbfa6 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -67,7 +67,7 @@ fi
 # Some architectures name their files based on version number, and
 # others do not.  Call out the ones that do not to make it obvious.
 case "${ARCH}" in
-	ia64 | m68k | nios2 | powerpc | x86)
+	ia64 | m68k | nios2 | powerpc | sparc | x86)
 		version=""
 		;;
 	*)
-- 
2.31.1


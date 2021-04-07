Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CFE35632F
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345257AbhDGFfL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348757AbhDGFfI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5097B613CE;
        Wed,  7 Apr 2021 05:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773698;
        bh=0om60PPyB8AjfB1ITSmbocahrr+Wf0G845qHknWIX6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4jtnY4z2HLxWTcOOcTN6W4MiZyMAdia1o5HKoroUK2ACGE4CbbU/79glOZ/1jUVI
         rnXUZdQAB42ebhhn1gXsAA/XlkBJLoZ+P2Pe3X/2SqXzH8lyX/jzgJkpk2HKsUjWrZ
         1bpI49yIdPP34X/f8lbP9Anjpv6MvDiZuBBfX8o0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/20] kbuild: powerpc: use common install script
Date:   Wed,  7 Apr 2021 07:34:15 +0200
Message-Id: <20210407053419.449796-17-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The common scripts/install.sh script will now work for powerpc, all that
is needed is to add it to the list of arches that do not put the version
number in the installed file name.

After the kernel is installed, powerpc also likes to install a few
random files, so provide the ability to do that as well.

With that we can remove the powerpc-only version of the install script.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/boot/Makefile   |  4 +--
 arch/powerpc/boot/install.sh | 55 ------------------------------------
 scripts/install.sh           | 14 ++++++++-
 3 files changed, 15 insertions(+), 58 deletions(-)
 delete mode 100644 arch/powerpc/boot/install.sh

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 2b8da923ceca..bbfcbd33e0b7 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -442,11 +442,11 @@ $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
 
 # Only install the vmlinux
 install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
-	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
+	sh -x $(srctree)/scripts/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)"
 
 # Install the vmlinux and other built boot targets.
 zInstall: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
-	sh -x $(srctree)/$(src)/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
+	sh -x $(srctree)/scripts/install.sh "$(KERNELRELEASE)" vmlinux System.map "$(INSTALL_PATH)" $^
 
 PHONY += install zInstall
 
diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
deleted file mode 100644
index b6a256bc96ee..000000000000
--- a/arch/powerpc/boot/install.sh
+++ /dev/null
@@ -1,55 +0,0 @@
-#!/bin/sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Blatantly stolen from in arch/i386/boot/install.sh by Dave Hansen 
-#
-# "make install" script for ppc64 architecture
-#
-# Arguments:
-#   $1 - kernel version
-#   $2 - kernel image file
-#   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
-#   $5 and more - kernel boot files; zImage*, uImage, cuImage.*, etc.
-#
-
-# Bail with error code if anything goes wrong
-set -e
-
-# User may have a custom install script
-
-if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
-
-# Default install
-
-# this should work for both the pSeries zImage and the iSeries vmlinux.sm
-image_name=`basename $2`
-
-if [ -f $4/$image_name ]; then
-	mv $4/$image_name $4/$image_name.old
-fi
-
-if [ -f $4/System.map ]; then
-	mv $4/System.map $4/System.old
-fi
-
-cat $2 > $4/$image_name
-cp $3 $4/System.map
-
-# Copy all the bootable image files
-path=$4
-shift 4
-while [ $# -ne 0 ]; do
-	image_name=`basename $1`
-	if [ -f $path/$image_name ]; then
-		mv $path/$image_name $path/$image_name.old
-	fi
-	cat $1 > $path/$image_name
-	shift
-done;
diff --git a/scripts/install.sh b/scripts/install.sh
index e0ffb95737d4..67c0a5f74af2 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -67,7 +67,7 @@ fi
 # Some architectures name their files based on version number, and
 # others do not.  Call out the ones that do not to make it obvious.
 case "${ARCH}" in
-	ia64 | m68k | nios2 | x86)
+	ia64 | m68k | nios2 | powerpc | x86)
 		version=""
 		;;
 	*)
@@ -93,6 +93,18 @@ case "${ARCH}" in
 			/usr/sbin/elilo
 		fi
 		;;
+	powerpc)
+		# powerpc installation can list other boot targets after the
+		# install path that should be copied to the correct location
+		path=$4
+		shift 4
+		while [ $# -ne 0 ]; do
+			image_name=$(basename "$1")
+			install "$1" "$path"/"$image_name"
+			shift
+		done;
+		sync
+		;;
 	x86)
 		if [ -x /sbin/lilo ]; then
 			/sbin/lilo
-- 
2.31.1


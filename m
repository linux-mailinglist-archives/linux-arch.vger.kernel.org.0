Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112C8356351
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbhDGFfs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348791AbhDGFff (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F532613CC;
        Wed,  7 Apr 2021 05:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773725;
        bh=ouCNsuEblkJkqcCKpXydk5fFIdkMGlk7rAG0PrWREyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zl6se3MSZf7Bbx6lGPOwhll9RDskOF1e5A+NfZEmyM9Pa92fItZ6qdjg8m7qhgbDG
         GjAsElIQZddmy/qiOKqfn/pjBBNKYEAq0nbLX3H3FMfTJrmb8C0/1I+DPbnmPwKNrr
         Af0UHuIf1mo/sCxNU0Spbzn9Hl+qvffg/I5KuYRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 12/20] kbuild: m68k: use common install script
Date:   Wed,  7 Apr 2021 07:34:11 +0200
Message-Id: <20210407053419.449796-13-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The common scripts/install.sh script will now work for m68k, all that
is needed is to add it to the list of arches that do not put the version
number in the installed file name.

With that we can remove the m68k-only version of the install script.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/m68k/Makefile   |  2 +-
 arch/m68k/install.sh | 52 --------------------------------------------
 scripts/install.sh   |  2 +-
 3 files changed, 2 insertions(+), 54 deletions(-)
 delete mode 100644 arch/m68k/install.sh

diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index ea14f2046fb4..e56abf79c313 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -143,4 +143,4 @@ archheaders:
 	$(Q)$(MAKE) $(build)=arch/m68k/kernel/syscalls all
 
 install:
-	sh $(srctree)/arch/m68k/install.sh $(KERNELRELEASE) vmlinux.gz System.map "$(INSTALL_PATH)"
+	sh $(srctree)/scripts/install.sh $(KERNELRELEASE) vmlinux.gz System.map "$(INSTALL_PATH)"
diff --git a/arch/m68k/install.sh b/arch/m68k/install.sh
deleted file mode 100644
index 57d640d4382c..000000000000
--- a/arch/m68k/install.sh
+++ /dev/null
@@ -1,52 +0,0 @@
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
-# "make install" script for m68k architecture
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
-
-sync
diff --git a/scripts/install.sh b/scripts/install.sh
index b6ca2a0f0983..a61a5ce28cad 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -66,7 +66,7 @@ fi
 # Some architectures name their files based on version number, and
 # others do not.  Call out the ones that do not to make it obvious.
 case "${ARCH}" in
-	ia64 | x86)
+	ia64 | m68k | x86)
 		version=""
 		;;
 	*)
-- 
2.31.1


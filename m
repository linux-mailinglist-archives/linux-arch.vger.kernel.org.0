Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C868D35634E
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348841AbhDGFfl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348807AbhDGFfb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24D8F613C0;
        Wed,  7 Apr 2021 05:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773722;
        bh=706RqTA/cj2QimpJUjo370sgwIA6WeaG9eDGyf53tO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qD8nz/66Ub0Wcbbu6j6BHvofj3oVvk+f/iV5Y8bkPDIN5LVbT5cZRC9Dv2FQ38ZsR
         IpBZUbqLWlLCVG7DO6aIkpQ9qKZZ7qLu5pb7Sjnu8bi8l7+c+2pYJmdZxKnXtE4mAG
         38iszQTdaJ2SO13Z8eOiOQg5Pc8jjl+ygwAllMI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-ia64@vger.kernel.org
Subject: [PATCH 11/20] kbuild: ia64: use common install script
Date:   Wed,  7 Apr 2021 07:34:10 +0200
Message-Id: <20210407053419.449796-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The common scripts/install.sh script will now work for ia64, all that
is needed is to add the compressed image type to it.  So add that file
type check and the ability to call /usr/sbin/elilo after copying the
kernel.  With that we can remove the ia64-only version of the file.

Cc: linux-ia64@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/ia64/Makefile   |  2 +-
 arch/ia64/install.sh | 40 ----------------------------------------
 scripts/install.sh   |  8 +++++++-
 3 files changed, 8 insertions(+), 42 deletions(-)
 delete mode 100644 arch/ia64/install.sh

diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 467b7e7f967c..19e20e99f487 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -77,7 +77,7 @@ archheaders:
 CLEAN_FILES += vmlinux.gz
 
 install: vmlinux.gz
-	sh $(srctree)/arch/ia64/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"
+	sh $(srctree)/scripts/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"
 
 define archhelp
   echo '* compressed	- Build compressed kernel image'
diff --git a/arch/ia64/install.sh b/arch/ia64/install.sh
deleted file mode 100644
index 0e932f5dcd1a..000000000000
--- a/arch/ia64/install.sh
+++ /dev/null
@@ -1,40 +0,0 @@
-#!/bin/sh
-#
-# arch/ia64/install.sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-#
-# "make install" script for ia64 architecture
-#
-# Arguments:
-#   $1 - kernel version
-#   $2 - kernel image file
-#   $3 - kernel map file
-#   $4 - default install path (blank if root directory)
-#
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
-test -x /usr/sbin/elilo && /usr/sbin/elilo
diff --git a/scripts/install.sh b/scripts/install.sh
index 73067b535ea0..b6ca2a0f0983 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -52,6 +52,7 @@ if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
 base=$(basename "$2")
 if [ "$base" = "bzImage" ] ||
    [ "$base" = "Image.gz" ] ||
+   [ "$base" = "vmlinux.gz" ] ||
    [ "$base" = "zImage" ] ; then
 	# Compressed install
 	echo "Installing compressed kernel"
@@ -65,7 +66,7 @@ fi
 # Some architectures name their files based on version number, and
 # others do not.  Call out the ones that do not to make it obvious.
 case "${ARCH}" in
-	x86)
+	ia64 | x86)
 		version=""
 		;;
 	*)
@@ -86,6 +87,11 @@ case "${ARCH}" in
 			echo "You have to install it yourself"
 		fi
 		;;
+	ia64)
+		if [ -x /usr/sbin/elilo ]; then
+			/usr/sbin/elilo
+		fi
+		;;
 	x86)
 		if [ -x /sbin/lilo ]; then
 			/sbin/lilo
-- 
2.31.1


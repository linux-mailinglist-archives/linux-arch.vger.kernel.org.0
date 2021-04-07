Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FDC35632B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348739AbhDGFfG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348735AbhDGFfF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA765613C0;
        Wed,  7 Apr 2021 05:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773696;
        bh=uMP12yNGVObvgWoR/JQ2SMvn/xmE14YMI6OCZDUEt6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+kNCQEr8yxoXksUAGeIg0cHAcz58x0yHwYpeE215KR+xLyQrlubB5SdoZhBEI4wF
         pujGtCniuFqLvEs6MGZs79LcD/bn8rDgleSYIcWsnbIut0GzxUucX2m8P3a5Zbzn7N
         tdoHchZFpyC0OEcJG5c+wrTUGJO85+aqpkOJwEwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH 15/20] kbuild: parisc: use common install script
Date:   Wed,  7 Apr 2021 07:34:14 +0200
Message-Id: <20210407053419.449796-16-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The common scripts/install.sh script will now work for parisc, all that
is needed is to add the compressed image type to it.  So add that file
type check, and then we can remove the two different copies of the
parisc install.sh script that were only different by one line and have
the arch call the common install script.

Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/parisc/Makefile        |  4 +--
 arch/parisc/boot/Makefile   |  2 +-
 arch/parisc/boot/install.sh | 65 ------------------------------------
 arch/parisc/install.sh      | 66 -------------------------------------
 scripts/install.sh          |  1 +
 5 files changed, 4 insertions(+), 134 deletions(-)
 delete mode 100644 arch/parisc/boot/install.sh
 delete mode 100644 arch/parisc/install.sh

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 7d9f71aa829a..296d8ab8e2aa 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -164,10 +164,10 @@ vmlinuz: vmlinux
 endif
 
 install:
-	$(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh \
 			$(KERNELRELEASE) vmlinux System.map "$(INSTALL_PATH)"
 zinstall:
-	$(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh \
 			$(KERNELRELEASE) vmlinuz System.map "$(INSTALL_PATH)"
 
 CLEAN_FILES	+= lifimage
diff --git a/arch/parisc/boot/Makefile b/arch/parisc/boot/Makefile
index 61f44142cfe1..ad2611929aee 100644
--- a/arch/parisc/boot/Makefile
+++ b/arch/parisc/boot/Makefile
@@ -17,5 +17,5 @@ $(obj)/compressed/vmlinux: FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
 install: $(CONFIGURE) $(obj)/bzImage
-	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
+	sh -x  $(srctree)/scripts/install.sh $(KERNELRELEASE) $(obj)/bzImage \
 	      System.map "$(INSTALL_PATH)"
diff --git a/arch/parisc/boot/install.sh b/arch/parisc/boot/install.sh
deleted file mode 100644
index 8f7c365fad83..000000000000
--- a/arch/parisc/boot/install.sh
+++ /dev/null
@@ -1,65 +0,0 @@
-#!/bin/sh
-#
-# arch/parisc/install.sh, derived from arch/i386/boot/install.sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-#
-# "make install" script for i386 architecture
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
-
-verify "$2"
-verify "$3"
-
-# User may have a custom install script
-
-if [ -n "${INSTALLKERNEL}" ]; then
-  if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-  if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
-fi
-
-# Default install
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
diff --git a/arch/parisc/install.sh b/arch/parisc/install.sh
deleted file mode 100644
index 056d588befdd..000000000000
--- a/arch/parisc/install.sh
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-#
-# arch/parisc/install.sh, derived from arch/i386/boot/install.sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-#
-# "make install" script for i386 architecture
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
-
-verify "$2"
-verify "$3"
-
-# User may have a custom install script
-
-if [ -n "${INSTALLKERNEL}" ]; then
-  if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-  if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
-fi
-
-# Default install
-
-if [ "$(basename $2)" = "vmlinuz" ]; then
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
diff --git a/scripts/install.sh b/scripts/install.sh
index 407ffa65062c..e0ffb95737d4 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -53,6 +53,7 @@ base=$(basename "$2")
 if [ "$base" = "bzImage" ] ||
    [ "$base" = "Image.gz" ] ||
    [ "$base" = "vmlinux.gz" ] ||
+   [ "$base" = "vmlinuz" ] ||
    [ "$base" = "zImage" ] ; then
 	# Compressed install
 	echo "Installing compressed kernel"
-- 
2.31.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF9356344
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345273AbhDGFff (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345284AbhDGFfY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD09B613B8;
        Wed,  7 Apr 2021 05:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773715;
        bh=1LtG+7DK6bKnBi2fiCGvmOM2s+/3SEL/McsxhTD/qJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FiAjfIrc+lYbxFl7uEMgtFbNoQWG9fQ9+R5YhhD6ILil9yXVjnuxL4vjTRSrdbAN+
         P752TFTKp+ls8/yMWH5+MhgMWcch0jJRAkSetV9r8qHUbw+XmMxqJfnTG7CIsfHIyg
         Zzrl98tHawNoaBMihLWOeOaJj4UFGHJ6hgPWvGJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: [PATCH 08/20] kbuild: riscv: use common install script
Date:   Wed,  7 Apr 2021 07:34:07 +0200
Message-Id: <20210407053419.449796-9-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The common scripts/install.sh script will now work for riscv, all that
is needed is to add the compressed image type to it.  So add that file
type check and remove the riscv-only version of the file.

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/boot/Makefile   |  4 +--
 arch/riscv/boot/install.sh | 60 --------------------------------------
 scripts/install.sh         |  3 +-
 3 files changed, 4 insertions(+), 63 deletions(-)
 delete mode 100644 arch/riscv/boot/install.sh

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 03404c84f971..4ba33aec4ccb 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -47,9 +47,9 @@ $(obj)/loader.bin: $(obj)/loader FORCE
 	$(call if_changed,objcopy)
 
 install:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh $(KERNELRELEASE) \
 	$(obj)/Image System.map "$(INSTALL_PATH)"
 
 zinstall:
-	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(CONFIG_SHELL) $(srctree)/scripts/install.sh $(KERNELRELEASE) \
 	$(obj)/Image.gz System.map "$(INSTALL_PATH)"
diff --git a/arch/riscv/boot/install.sh b/arch/riscv/boot/install.sh
deleted file mode 100644
index 18c39159c0ff..000000000000
--- a/arch/riscv/boot/install.sh
+++ /dev/null
@@ -1,60 +0,0 @@
-#!/bin/sh
-#
-# arch/riscv/boot/install.sh
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
-# "make install" script for the RISC-V Linux port
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
diff --git a/scripts/install.sh b/scripts/install.sh
index 934619f81119..9c8a22d96255 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -50,7 +50,8 @@ if [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "$@"; fi
 if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
 
 base=$(basename "$2")
-if [ "$base" = "bzImage" ]; then
+if [ "$base" = "bzImage" ] ||
+   [ "$base" = "Image.gz" ] ; then
 	# Compressed install
 	echo "Installing compressed kernel"
 	base=vmlinuz
-- 
2.31.1


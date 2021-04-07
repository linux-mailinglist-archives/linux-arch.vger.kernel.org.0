Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A02356333
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348762AbhDGFfO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348763AbhDGFfM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A32613AF;
        Wed,  7 Apr 2021 05:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773702;
        bh=FZFEMVhO0nItcH9QpwU17LByF5JS6aB8jEDu4fnSwk4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TEVuE4W+UF5AV7oHDtC8vvLkNb9vSr9dp6VnJBxyyFoQciAY3G8LU0sa8ZaiLDPDs
         G4ZZ2+H1i9vQTQ5i772Wx/ryExcrVJRN3xp7qzOb5MsfoI0aEuSII+1X3mhFzhw0qi
         Z/CWyv9xMFWtgWQzLAm3QWXOWxCHvBxN8f/yd4lI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 17/20] kbuild: s390: use common install script
Date:   Wed,  7 Apr 2021 07:34:16 +0200
Message-Id: <20210407053419.449796-18-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The common scripts/install.sh script will now work for s390, no changes
needed.  So call that instead and delete the s390-only install script.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/boot/Makefile   |  2 +-
 arch/s390/boot/install.sh | 30 ------------------------------
 2 files changed, 1 insertion(+), 31 deletions(-)
 delete mode 100644 arch/s390/boot/install.sh

diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
index 41a64b8dce25..5e3058d6e59b 100644
--- a/arch/s390/boot/Makefile
+++ b/arch/s390/boot/Makefile
@@ -71,5 +71,5 @@ $(obj)/startup.a: $(OBJECTS) FORCE
 	$(call if_changed,ar)
 
 install:
-	sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
+	sh -x  $(srctree)/scripts/install.sh $(KERNELRELEASE) $(obj)/bzImage \
 	      System.map "$(INSTALL_PATH)"
diff --git a/arch/s390/boot/install.sh b/arch/s390/boot/install.sh
deleted file mode 100644
index 515b27a996b3..000000000000
--- a/arch/s390/boot/install.sh
+++ /dev/null
@@ -1,30 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# arch/s390x/boot/install.sh
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-#
-# "make install" script for s390 architecture
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
-echo "Warning: '${INSTALLKERNEL}' command not available - additional " \
-     "bootloader config required" >&2
-if [ -f $4/vmlinuz-$1 ]; then mv $4/vmlinuz-$1 $4/vmlinuz-$1.old; fi
-if [ -f $4/System.map-$1 ]; then mv $4/System.map-$1 $4/System.map-$1.old; fi
-
-cat $2 > $4/vmlinuz-$1
-cp $3 $4/System.map-$1
-- 
2.31.1


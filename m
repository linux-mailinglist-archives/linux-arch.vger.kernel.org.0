Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7BE356336
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348772AbhDGFfP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348750AbhDGFfN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F57B613C0;
        Wed,  7 Apr 2021 05:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773704;
        bh=eVXzx4Wqy4ji8M24EPqvJ+83p5xmN0OGX+WMwvF+Xus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWUFj7rmHM99R1uuvzEz3HOmAKl5WQb3SLjgCNvi93Sqr6coXL/Z7VEK+kPC4grg+
         9BghTnGAo4S4m0cZBmecxuvXfcE0yktJiEmZ4AZkPK0darn/wXWD39THsjMOPEQwo7
         oMdoAz1EGWOdVrOmTqNnDriTCc7xFpZDXgQYTjFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 18/20] kbuild: sh: remove unused install script
Date:   Wed,  7 Apr 2021 07:34:17 +0200
Message-Id: <20210407053419.449796-19-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The sh arch has a install.sh script, but no Makefile actually calls it.
Remove it to keep anyone from accidentally calling it in the future.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/boot/compressed/install.sh | 56 ------------------------------
 1 file changed, 56 deletions(-)
 delete mode 100644 arch/sh/boot/compressed/install.sh

diff --git a/arch/sh/boot/compressed/install.sh b/arch/sh/boot/compressed/install.sh
deleted file mode 100644
index f9f41818b17e..000000000000
--- a/arch/sh/boot/compressed/install.sh
+++ /dev/null
@@ -1,56 +0,0 @@
-#!/bin/sh
-#
-# arch/sh/boot/install.sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
-#
-# Copyright (C) 1995 by Linus Torvalds
-#
-# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
-# Adapted from code in arch/i386/boot/install.sh by Russell King
-# Adapted from code in arch/arm/boot/install.sh by Stuart Menefy
-#
-# "make install" script for sh architecture
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
-if [ -x /sbin/${INSTALLKERNEL} ]; then
-  exec /sbin/${INSTALLKERNEL} "$@"
-fi
-
-if [ "$2" = "zImage" ]; then
-# Compressed install
-  echo "Installing compressed kernel"
-  if [ -f $4/vmlinuz-$1 ]; then
-    mv $4/vmlinuz-$1 $4/vmlinuz.old
-  fi
-
-  if [ -f $4/System.map-$1 ]; then
-    mv $4/System.map-$1 $4/System.old
-  fi
-
-  cat $2 > $4/vmlinuz-$1
-  cp $3 $4/System.map-$1
-else
-# Normal install
-  echo "Installing normal kernel"
-  if [ -f $4/vmlinux-$1 ]; then
-    mv $4/vmlinux-$1 $4/vmlinux.old
-  fi
-
-  if [ -f $4/System.map ]; then
-    mv $4/System.map $4/System.old
-  fi
-
-  cat $2 > $4/vmlinux-$1
-  cp $3 $4/System.map
-fi
-- 
2.31.1


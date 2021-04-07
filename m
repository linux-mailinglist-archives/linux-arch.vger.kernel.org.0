Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A6A35633E
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 07:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbhDGFf2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 01:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348757AbhDGFfT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DCB6613C0;
        Wed,  7 Apr 2021 05:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773709;
        bh=+2kUjGkzbI5+Kennc9nY5XrJqaqBq+yhZja8ot+rX3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNjbROUKzokuePIzkZLKjJjZgnek8DXYozjChnyIdwLjredFdJWJvjctBU57PgLTE
         KbVSo/aqi8SMFPQveQY8WM7iy89PCbX5bCLJVf8rZgACGVmOnLadcjRwu+eL+PZWoA
         50r1Asrc7FFQ9xJz33IPgbomDvdokjNTcofFSCEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 20/20] kbuild: scripts/install.sh: update documentation
Date:   Wed,  7 Apr 2021 07:34:19 +0200
Message-Id: <20210407053419.449796-21-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a proper SPDX line and document the install.sh file a lot better,
explaining exactly what it does, and update the copyright notice and
provide a better message about the lack of LILO being present or not as
really, no one should be using that anymore...

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/install.sh | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/scripts/install.sh b/scripts/install.sh
index 225b19bbbfa6..dd86fb9971e9 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -1,14 +1,14 @@
 #!/bin/sh
-#
-# This file is subject to the terms and conditions of the GNU General Public
-# License.  See the file "COPYING" in the main directory of this archive
-# for more details.
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (C) 1995 by Linus Torvalds
+# Copyright (C) 2021 Greg Kroah-Hartman
 #
 # Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
+# Adapted from code in arch/i386/boot/install.sh by Russell King
+# Adapted from code in arch/arm/boot/install.sh by Stuart Menefy
 #
-# "make install" script for i386 architecture
+# "make install" script for Linux to be used by all architectures.
 #
 # Arguments:
 #   $1 - kernel version
@@ -16,6 +16,26 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 #
+# Installs the built kernel image and map and symbol file in the specified
+# install location.  If no install path is selected, the files will be placed
+# in the root directory.
+#
+# The name of the kernel image will be "vmlinux-VERSION" for uncompressed
+# kernels or "vmlinuz-VERSION' for compressed kernels.
+#
+# The kernel map file will be named "System.map-VERSION"
+#
+# Note, not all architectures seem to like putting the VERSION number in the
+# file name, see below in the script for a list of those that do not.  For
+# those that do not the "-VERSION" will not be present in the file name.
+#
+# If there is currently a kernel image or kernel map file present with the name
+# of the file to be copied to the location, it will be renamed to contain a
+# ".old" suffix.
+#
+# If ~/bin/${INSTALLKERNEL} or /sbin/${INSTALLKERNEL} is executable, execution
+# will be passed to that program instead of this one to allow for distro or
+# system specific installation scripts to be used.
 
 verify () {
 	if [ ! -f "$1" ]; then
@@ -45,7 +65,6 @@ verify "$2"
 verify "$3"
 
 # User may have a custom install script
-
 if [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "$@"; fi
 if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
 
@@ -111,7 +130,7 @@ case "${ARCH}" in
 		elif [ -x /etc/lilo/install ]; then
 			/etc/lilo/install
 		else
-			echo "Cannot find LILO."
+			echo "Cannot find LILO, ensure your bootloader knows of the new kernel image."
 		fi
 		;;
 esac
-- 
2.31.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BF4515CB8
	for <lists+linux-arch@lfdr.de>; Sat, 30 Apr 2022 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241725AbiD3MVE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 Apr 2022 08:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiD3MVC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Apr 2022 08:21:02 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED22670;
        Sat, 30 Apr 2022 05:17:39 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 23UCHEE2011373;
        Sat, 30 Apr 2022 21:17:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 23UCHEE2011373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651321036;
        bh=KavYiiCN+GcW8/qiHcnlNOpnEUTF1erJ3gDvORjBAvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NU7P/boRxSBM9KMawiK8Vau/wx7sJ2E93UDtg14/BeHfpPO4ZjQWAzAMuYdiaOiKv
         jCurk/nTXCiRnJcb2PaPS94VRSo5mT4oKTXVtrJg8QAUlGhFpI5PQaPVj45ABWdZMq
         wNjfjhoQ+lGCsnftnRAsSge9VFl3plxYc9AwOqTI8syg6tphLPK3ueZW7jaQoGK2pB
         d+YXX2pD+Zu+zIR83/2DQraQRoKAe7hOGtWarXMF0fcb+C0i9y02KInhuVfpcWEcF2
         FQypgUAMtLyD3BYDvkk1/QpKjFHViIWofrzuc0W7u5bXdzlxWWPLo2SAF4kXVuLa/G
         2wnSKNYnqh9VQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] scripts: factor out the common installation code into scripts/install.sh
Date:   Sat, 30 Apr 2022 21:16:39 +0900
Message-Id: <20220430121639.315421-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220430121639.315421-1-masahiroy@kernel.org>
References: <20220430121639.315421-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Many architectures has a similar install.sh script.

The first half is really generic; verifies that the kernel image and
System.map exist, then executes ~/bin/${INSTALLKERNEL} or
/sbin/${INSTALLKERNEL} if available.

The second half is kind of arch-specific. It just copies the kernel image
and System.map to the destination, but the code is slightly different.

This patch factors out the generic part into scripts/install.sh.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                     | 10 ++++++++-
 arch/arm/Makefile            |  4 ++--
 arch/arm/boot/install.sh     | 21 ------------------
 arch/arm64/Makefile          |  6 ++----
 arch/arm64/boot/install.sh   | 21 ------------------
 arch/ia64/Makefile           |  3 ++-
 arch/ia64/install.sh         | 10 ---------
 arch/m68k/Makefile           |  3 ++-
 arch/m68k/install.sh         | 22 -------------------
 arch/nios2/Makefile          |  3 +--
 arch/nios2/boot/install.sh   | 22 -------------------
 arch/parisc/Makefile         | 11 +++++-----
 arch/parisc/install.sh       | 28 ------------------------
 arch/powerpc/Makefile        |  4 ++--
 arch/powerpc/boot/install.sh | 23 --------------------
 arch/riscv/Makefile          |  7 +++---
 arch/riscv/boot/install.sh   | 21 ------------------
 arch/s390/Makefile           |  3 +--
 arch/s390/boot/install.sh    |  5 -----
 arch/sparc/Makefile          |  3 +--
 arch/sparc/boot/install.sh   | 22 -------------------
 arch/x86/Makefile            |  3 +--
 arch/x86/boot/install.sh     | 22 -------------------
 scripts/install.sh           | 41 ++++++++++++++++++++++++++++++++++++
 24 files changed, 72 insertions(+), 246 deletions(-)
 mode change 100644 => 100755 arch/arm/boot/install.sh
 mode change 100644 => 100755 arch/arm64/boot/install.sh
 mode change 100644 => 100755 arch/ia64/install.sh
 mode change 100644 => 100755 arch/m68k/install.sh
 mode change 100644 => 100755 arch/nios2/boot/install.sh
 mode change 100644 => 100755 arch/parisc/install.sh
 mode change 100644 => 100755 arch/powerpc/boot/install.sh
 mode change 100644 => 100755 arch/riscv/boot/install.sh
 mode change 100644 => 100755 arch/s390/boot/install.sh
 mode change 100644 => 100755 arch/sparc/boot/install.sh
 mode change 100644 => 100755 arch/x86/boot/install.sh
 create mode 100755 scripts/install.sh

diff --git a/Makefile b/Makefile
index 9a60f732bb3c..7a82bbc505f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1293,12 +1293,20 @@ scripts_unifdef: scripts_basic
 # ---------------------------------------------------------------------------
 # Install
 
+# Install $(KBUILD_IMAGE) by default.
+# If necessary, override install-image per target.
+install-image = $(KBUILD_IMAGE)
+
 # Many distributions have the custom install script, /sbin/installkernel.
 # If DKMS is installed, 'make install' will eventually recurse back
 # to this Makefile to build and install external modules.
 # Cancel sub_make_done so that options such as M=, V=, etc. are parsed.
 
-install: sub_make_done :=
+quiet_cmd_install = INSTALL $(INSTALL_PATH)
+      cmd_install = \
+	unset sub_make_done; \
+	$(srctree)/scripts/install.sh $(KERNELRELEASE) $(install-image) \
+		System.map "$(INSTALL_PATH)"
 
 # ---------------------------------------------------------------------------
 # Tools
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index a2391b8de5a5..5be38ee44288 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -318,9 +318,9 @@ $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
 	@$(kecho) '  Kernel: $(boot)/$@ is ready'
 
+$(INSTALL_TARGETS): install-image = $(boot)/$(patsubst %install,%Image,$@)
 $(INSTALL_TARGETS):
-	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh "$(KERNELRELEASE)" \
-	$(boot)/$(patsubst %install,%Image,$@) System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
 
 PHONY += vdso_install
 vdso_install:
diff --git a/arch/arm/boot/install.sh b/arch/arm/boot/install.sh
old mode 100644
new mode 100755
index 2a45092a40e3..9ec11fac7d8d
--- a/arch/arm/boot/install.sh
+++ b/arch/arm/boot/install.sh
@@ -1,7 +1,5 @@
 #!/bin/sh
 #
-# arch/arm/boot/install.sh
-#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -18,25 +16,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
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
 
 if [ "$(basename $2)" = "zImage" ]; then
 # Compressed install
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 2f1de88651e6..3a1157d48780 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -162,11 +162,9 @@ Image: vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-install: install-image := Image
-zinstall: install-image := Image.gz
+install: install-image := $(boot)/Image
 install zinstall:
-	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
-	$(boot)/$(install-image) System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
 
 PHONY += vdso_install
 vdso_install:
diff --git a/arch/arm64/boot/install.sh b/arch/arm64/boot/install.sh
old mode 100644
new mode 100755
index d91e1f022573..7399d706967a
--- a/arch/arm64/boot/install.sh
+++ b/arch/arm64/boot/install.sh
@@ -1,7 +1,5 @@
 #!/bin/sh
 #
-# arch/arm64/boot/install.sh
-#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -18,25 +16,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
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
 
 if [ "$(basename $2)" = "Image.gz" ]; then
 # Compressed install
diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
index 6c4bfa54b703..956e46ce3820 100644
--- a/arch/ia64/Makefile
+++ b/arch/ia64/Makefile
@@ -72,8 +72,9 @@ archheaders:
 
 CLEAN_FILES += vmlinux.gz
 
+install: install-image := vmlinux.gz
 install:
-	sh $(srctree)/arch/ia64/install.sh $(KERNELRELEASE) vmlinux.gz System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
 
 define archhelp
   echo '* compressed	- Build compressed kernel image'
diff --git a/arch/ia64/install.sh b/arch/ia64/install.sh
old mode 100644
new mode 100755
index 0e932f5dcd1a..2d4b66a9f362
--- a/arch/ia64/install.sh
+++ b/arch/ia64/install.sh
@@ -1,7 +1,5 @@
 #!/bin/sh
 #
-# arch/ia64/install.sh
-#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -17,14 +15,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
-#
-
-# User may have a custom install script
-
-if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
-
-# Default install - same as make zlilo
 
 if [ -f $4/vmlinuz ]; then
 	mv $4/vmlinuz $4/vmlinuz.old
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 740fc97b9c0f..4878e82ea1ba 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -138,5 +138,6 @@ CLEAN_FILES += vmlinux.gz vmlinux.bz2
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/m68k/kernel/syscalls all
 
+install: install-image := vmlinux.gz
 install:
-	sh $(srctree)/arch/m68k/install.sh $(KERNELRELEASE) vmlinux.gz System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
diff --git a/arch/m68k/install.sh b/arch/m68k/install.sh
old mode 100644
new mode 100755
index 57d640d4382c..af65e16e5147
--- a/arch/m68k/install.sh
+++ b/arch/m68k/install.sh
@@ -15,28 +15,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
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
 
 if [ -f $4/vmlinuz ]; then
 	mv $4/vmlinuz $4/vmlinuz.old
diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
index 02d678559066..d6a7499b814c 100644
--- a/arch/nios2/Makefile
+++ b/arch/nios2/Makefile
@@ -56,8 +56,7 @@ $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(nios2-boot) $(nios2-boot)/$@
 
 install:
-	sh $(srctree)/$(nios2-boot)/install.sh $(KERNELRELEASE) \
-	$(KBUILD_IMAGE) System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
 
 define archhelp
   echo  '* vmImage         - Kernel-only image for U-Boot ($(KBUILD_IMAGE))'
diff --git a/arch/nios2/boot/install.sh b/arch/nios2/boot/install.sh
old mode 100644
new mode 100755
index 3cb3f468bc51..34a2feec42c8
--- a/arch/nios2/boot/install.sh
+++ b/arch/nios2/boot/install.sh
@@ -15,28 +15,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
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
 
 if [ -f $4/vmlinuz ]; then
 	mv $4/vmlinuz $4/vmlinuz.old
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 7583fc39ab2d..f4efcd709df4 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -184,12 +184,11 @@ vdso_install:
 	$(Q)$(MAKE) $(build)=arch/parisc/kernel/vdso $@
 	$(if $(CONFIG_COMPAT_VDSO), \
 		$(Q)$(MAKE) $(build)=arch/parisc/kernel/vdso32 $@)
-install:
-	$(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
-			$(KERNELRELEASE) vmlinux System.map "$(INSTALL_PATH)"
-zinstall:
-	$(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
-			$(KERNELRELEASE) vmlinuz System.map "$(INSTALL_PATH)"
+
+install: install-image := vmlinux
+zinstall: install-image := vmlinuz
+install zinstall:
+	$(call cmd,install)
 
 CLEAN_FILES	+= lifimage
 MRPROPER_FILES	+= palo.conf
diff --git a/arch/parisc/install.sh b/arch/parisc/install.sh
old mode 100644
new mode 100755
index 70d3cffb0251..933d031c249a
--- a/arch/parisc/install.sh
+++ b/arch/parisc/install.sh
@@ -1,7 +1,5 @@
 #!/bin/sh
 #
-# arch/parisc/install.sh, derived from arch/i386/boot/install.sh
-#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -17,32 +15,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
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
-  if [ -x /usr/sbin/${INSTALLKERNEL} ]; then exec /usr/sbin/${INSTALLKERNEL} "$@"; fi
-fi
-
-# Default install
 
 if [ "$(basename $2)" = "vmlinuz" ]; then
 # Compressed install
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index eb541e730d3c..83f367738954 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -407,9 +407,9 @@ define archhelp
 endef
 
 PHONY += install
+install: install-image := vmlinux
 install:
-	sh -x $(srctree)/$(boot)/install.sh "$(KERNELRELEASE)" vmlinux \
-	System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
 
 ifeq ($(KBUILD_EXTMOD),)
 # We need to generate vdso-offsets.h before compiling certain files in kernel/.
diff --git a/arch/powerpc/boot/install.sh b/arch/powerpc/boot/install.sh
old mode 100644
new mode 100755
index 14473150ddb4..461902c8a46d
--- a/arch/powerpc/boot/install.sh
+++ b/arch/powerpc/boot/install.sh
@@ -15,32 +15,9 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
-#
 
-# Bail with error code if anything goes wrong
 set -e
 
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
-# Default install
-
 # this should work for both the pSeries zImage and the iSeries vmlinux.sm
 image_name=`basename $2`
 
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 7d81102cffd4..e292a632f02e 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -139,11 +139,10 @@ $(BOOT_TARGETS): vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
-install: install-image = Image
-zinstall: install-image = Image.gz
+install: install-image = $(boot)/Image
+zinstall: install-image = $(boot)/Image.gz
 install zinstall:
-	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
-	$(boot)/$(install-image) System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
 
 PHONY += rv32_randconfig
 rv32_randconfig:
diff --git a/arch/riscv/boot/install.sh b/arch/riscv/boot/install.sh
old mode 100644
new mode 100755
index 18c39159c0ff..4c63f3f0643d
--- a/arch/riscv/boot/install.sh
+++ b/arch/riscv/boot/install.sh
@@ -1,7 +1,5 @@
 #!/bin/sh
 #
-# arch/riscv/boot/install.sh
-#
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
@@ -18,25 +16,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
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
 
 if [ "$(basename $2)" = "Image.gz" ]; then
 # Compressed install
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 7a65bca1e5af..cc2425539ef0 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -128,8 +128,7 @@ all: bzImage
 KBUILD_IMAGE	:= $(boot)/bzImage
 
 install:
-	sh -x $(srctree)/$(boot)/install.sh $(KERNELRELEASE) $(KBUILD_IMAGE) \
-	      System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
 
 bzImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
diff --git a/arch/s390/boot/install.sh b/arch/s390/boot/install.sh
old mode 100644
new mode 100755
index 515b27a996b3..f3c001a095b2
--- a/arch/s390/boot/install.sh
+++ b/arch/s390/boot/install.sh
@@ -16,11 +16,6 @@
 #   $4 - default install path (blank if root directory)
 #
 
-# User may have a custom install script
-
-if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
-if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
-
 echo "Warning: '${INSTALLKERNEL}' command not available - additional " \
      "bootloader config required" >&2
 if [ -f $4/vmlinuz-$1 ]; then mv $4/vmlinuz-$1 $4/vmlinuz-$1.old; fi
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index c7008bbebc4c..fe58a410b4ce 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -72,8 +72,7 @@ image zImage uImage tftpboot.img vmlinux.aout: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 install:
-	sh $(srctree)/$(boot)/install.sh $(KERNELRELEASE) $(KBUILD_IMAGE) \
-		System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
 
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/sparc/kernel/syscalls all
diff --git a/arch/sparc/boot/install.sh b/arch/sparc/boot/install.sh
old mode 100644
new mode 100755
index b32851eae693..4f130f3f30d6
--- a/arch/sparc/boot/install.sh
+++ b/arch/sparc/boot/install.sh
@@ -15,28 +15,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
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
 
 if [ -f $4/vmlinuz ]; then
 	mv $4/vmlinuz $4/vmlinuz.old
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 63d50f65b828..5e1f21aae12b 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -271,8 +271,7 @@ $(BOOT_TARGETS): vmlinux
 
 PHONY += install
 install:
-	$(CONFIG_SHELL) $(srctree)/$(boot)/install.sh $(KERNELRELEASE) \
-		$(KBUILD_IMAGE) System.map "$(INSTALL_PATH)"
+	$(call cmd,install)
 
 PHONY += vdso_install
 vdso_install:
diff --git a/arch/x86/boot/install.sh b/arch/x86/boot/install.sh
old mode 100644
new mode 100755
index d13ec1c38640..0849f4b42745
--- a/arch/x86/boot/install.sh
+++ b/arch/x86/boot/install.sh
@@ -15,28 +15,6 @@
 #   $2 - kernel image file
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
-#
-
-verify () {
-	if [ ! -f "$1" ]; then
-		echo ""                                                   1>&2
-		echo " *** Missing file: $1"                              1>&2
-		echo ' *** You need to run "make" before "make install".' 1>&2
-		echo ""                                                   1>&2
-		exit 1
- 	fi
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
 
 if [ -f $4/vmlinuz ]; then
 	mv $4/vmlinuz $4/vmlinuz.old
diff --git a/scripts/install.sh b/scripts/install.sh
new file mode 100755
index 000000000000..634a86423600
--- /dev/null
+++ b/scripts/install.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 1995 by Linus Torvalds
+#
+# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
+# Common code factored out by Masahiro Yamada
+#
+# Arguments:
+#   $1 - kernel version
+#   $2 - kernel image file
+#   $3 - kernel map file
+#   $4 - default install path (blank if root directory)
+
+set -e
+
+# Make sure the files actually exist
+for file in "$2" "$3"
+do
+	if [ ! -f "$file" ]; then
+		echo >&2
+		echo >&2 " *** Missing file: $file"
+		echo >&2 ' *** You need to run "make" before "make install".'
+		echo >&2
+		exit 1
+	fi
+done
+
+# User/arch may have a custom install script
+for file in "${HOME}/bin/${INSTALLKERNEL}"		\
+	    "/sbin/${INSTALLKERNEL}"			\
+	    "${srctree}/arch/${SRCARCH}/install.sh"	\
+	    "${srctree}/arch/${SRCARCH}/boot/install.sh"
+do
+	if [ -x "${file}" ]; then
+		exec "${file}" "$@"
+	fi
+done
+
+echo "No install script found" >&2
+exit 1
-- 
2.32.0


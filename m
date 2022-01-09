Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0C488B8E
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 19:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiAISQQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 13:16:16 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31213 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiAISQL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 13:16:11 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 209IFWZx030890;
        Mon, 10 Jan 2022 03:15:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 209IFWZx030890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641752132;
        bh=xJqrI0VPWaFJ8l3XbINJ/1PkDU8rQXznE1lusSMRuuw=;
        h=From:To:Cc:Subject:Date:From;
        b=0lRmUzhj46SJOuGSEv9Y4r4r26/ApSiS4iwtN8LfORqQ/p93z2beYGUkh5llI4VMe
         cLJo0rjxdjXlleVz7O2nSPzvqltWm3jpEpv9W/54tn04gP0L61QIqK0J08x0GlWxLP
         unkVHIdY115BMKXMWTRgfovD0P7uiq3PYXtTf2w3K3ElxKXdBZx+731/L0SG6us0oh
         T5ddcVq02OPTeRvYzM/8+Nj32WuyhSND67NdpzftiUffn12UJ64/iZrh9xkuMldY04
         PEwBdyfpX2CLSf8OeZLH8iFzh2+sqvPOONkSNn5pONVyJ9lFZmzqhbsMlHDx7s1kZl
         G2SrCKeCCoDFg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/5] sh: rename suffix-y to suffix_y
Date:   Mon, 10 Jan 2022 03:15:25 +0900
Message-Id: <20220109181529.351420-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

'export suffix-y' does not work reliably because hyphens are disallowed
in shell variables.

A similar issue was fixed by commit 2bfbe7881ee0 ("kbuild: Do not use
hyphen in exported variable name").

If I do similar in dash, ARCH=sh fails to build.

  $ mv linux linux~
  $ cd linux~
  $ dash
  $ make O=foo/bar ARCH=sh CROSS_COMPILE=sh4-linux-gnu- defconfig all
  make[1]: Entering directory '/home/masahiro/linux~/foo/bar'
    [ snip ]
  make[4]: *** No rule to make target 'arch/sh/boot/compressed/vmlinux.bin.', needed by 'arch/sh/boot/compressed/piggy.o'.  Stop.
  make[3]: *** [/home/masahiro/linux~/arch/sh/boot/Makefile:40: arch/sh/boot/compressed/vmlinux] Error 2
  make[2]: *** [/home/masahiro/linux~/arch/sh/Makefile:194: zImage] Error 2
  make[1]: *** [/home/masahiro/linux~/Makefile:350: __build_one_by_one] Error 2
  make[1]: Leaving directory '/home/masahiro/linux~/foo/bar'
  make: *** [Makefile:219: __sub-make] Error 2

The maintainer of GNU Make stated that there is no consistent way to
export variables that do not meet the shell's naming criteria.
(https://savannah.gnu.org/bugs/?55719)

Consequently, you cannot use hyphens in exported variables.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/boot/Makefile            | 16 ++++++++--------
 arch/sh/boot/compressed/Makefile |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index 5c123f5b2797..1f5d2df3c7e0 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -19,12 +19,12 @@ CONFIG_ZERO_PAGE_OFFSET	?= 0x00001000
 CONFIG_ENTRY_OFFSET	?= 0x00001000
 CONFIG_PHYSICAL_START	?= $(CONFIG_MEMORY_START)
 
-suffix-y := bin
-suffix-$(CONFIG_KERNEL_GZIP)	:= gz
-suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
-suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
-suffix-$(CONFIG_KERNEL_XZ)	:= xz
-suffix-$(CONFIG_KERNEL_LZO)	:= lzo
+suffix_y := bin
+suffix_$(CONFIG_KERNEL_GZIP)	:= gz
+suffix_$(CONFIG_KERNEL_BZIP2)	:= bz2
+suffix_$(CONFIG_KERNEL_LZMA)	:= lzma
+suffix_$(CONFIG_KERNEL_XZ)	:= xz
+suffix_$(CONFIG_KERNEL_LZO)	:= lzo
 
 targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz \
 	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin \
@@ -106,10 +106,10 @@ OBJCOPYFLAGS_uImage.srec := -I binary -O srec
 $(obj)/uImage.srec: $(obj)/uImage FORCE
 	$(call if_changed,objcopy)
 
-$(obj)/uImage: $(obj)/uImage.$(suffix-y)
+$(obj)/uImage: $(obj)/uImage.$(suffix_y)
 	@ln -sf $(notdir $<) $@
 	@echo '  Image $@ is ready'
 
 export CONFIG_PAGE_OFFSET CONFIG_MEMORY_START CONFIG_BOOT_LINK_OFFSET \
        CONFIG_PHYSICAL_START CONFIG_ZERO_PAGE_OFFSET CONFIG_ENTRY_OFFSET \
-       KERNEL_MEMORY suffix-y
+       KERNEL_MEMORY suffix_y
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index cf3174df7859..c1eb9a62de55 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -64,5 +64,5 @@ OBJCOPYFLAGS += -R .empty_zero_page
 
 LDFLAGS_piggy.o := -r --format binary --oformat $(ld-bfd) -T
 
-$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix-y) FORCE
+$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix_y) FORCE
 	$(call if_changed,ld)
-- 
2.32.0


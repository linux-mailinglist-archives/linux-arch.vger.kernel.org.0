Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBED488B86
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 19:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiAISQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 13:16:13 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31198 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiAISQK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 13:16:10 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 209IFWa2030890;
        Mon, 10 Jan 2022 03:15:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 209IFWa2030890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641752134;
        bh=MAkh9/MBoZ6KGeV+2jOjzmtdPFvtRU9xzW4nfvzR4Bo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q78n4ix4XkpD/+sK8/sZP+mcoheGXFqUjWCT5wUz5qFDcKro4BPIWPfwGDZzphIHI
         iWl9/CjjL2PVsakUut3w4eALo2ps8JSMLE7Jwsq+xE44JK8SYzbuh/rTorL4ZjqG2G
         L8gTLgxUZbm+m8/CHzI6sWUSSFAChs5q+fuwI5mxDQa32c9UI2wIiA9NJdnXqqwCSJ
         hya52arRb4cNPc1EUfA2I/fnk4Vf5nwXHNZqowAxH/d/68I7hLo0FrA9kfPTuw7x2z
         pPpsV64BBzENXCMmIQLrw748kkVmwZkqjmtVEHraZgiPfoxAXlzLTcwB9DgXtAFJSP
         mWOpYwrrlveqw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/5] arch: decompressor: remove useless vmlinux.bin.all-y
Date:   Mon, 10 Jan 2022 03:15:28 +0900
Message-Id: <20220109181529.351420-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220109181529.351420-1-masahiroy@kernel.org>
References: <20220109181529.351420-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Presumably, arch/{parisc,s390,sh}/boot/compressed/Makefile copied
arch/x86/boot/compressed/Makefile, but vmlinux.bin.all-y is useless
here because it is the same as $(obj)/vmlinux.bin.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/boot/compressed/Makefile | 14 ++++++--------
 arch/s390/boot/compressed/Makefile   | 16 +++++++---------
 arch/sh/boot/compressed/Makefile     | 12 +++++-------
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index 2640f72d69ce..877a7099b5e1 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -58,8 +58,6 @@ OBJCOPYFLAGS_vmlinux.bin := -R .comment -R .note -S
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
-vmlinux.bin.all-y := $(obj)/vmlinux.bin
-
 suffix-$(CONFIG_KERNEL_GZIP)  := gz
 suffix-$(CONFIG_KERNEL_BZIP2) := bz2
 suffix-$(CONFIG_KERNEL_LZ4)  := lz4
@@ -67,17 +65,17 @@ suffix-$(CONFIG_KERNEL_LZMA)  := lzma
 suffix-$(CONFIG_KERNEL_LZO)  := lzo
 suffix-$(CONFIG_KERNEL_XZ)  := xz
 
-$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,bzip2_with_size)
-$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.lz4: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lz4_with_size)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzma_with_size)
-$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzo_with_size)
-$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,xzkern_with_size)
 
 LDFLAGS_piggy.o := -r --format binary --oformat $(LD_BFD) -T
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 8ea880b7c3ec..d04e0e7de0b3 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -58,8 +58,6 @@ OBJCOPYFLAGS_vmlinux.bin := -O binary --remove-section=.comment --remove-section
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
-vmlinux.bin.all-y := $(obj)/vmlinux.bin
-
 suffix-$(CONFIG_KERNEL_GZIP)  := .gz
 suffix-$(CONFIG_KERNEL_BZIP2) := .bz2
 suffix-$(CONFIG_KERNEL_LZ4)  := .lz4
@@ -68,19 +66,19 @@ suffix-$(CONFIG_KERNEL_LZO)  := .lzo
 suffix-$(CONFIG_KERNEL_XZ)  := .xz
 suffix-$(CONFIG_KERNEL_ZSTD)  := .zst
 
-$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,bzip2_with_size)
-$(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.lz4: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lz4_with_size)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzma_with_size)
-$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzo_with_size)
-$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,xzkern_with_size)
-$(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.zst: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,zstd22_with_size)
 
 OBJCOPYFLAGS_piggy.o := -I binary -O elf64-s390 -B s390:64-bit --rename-section .data=.vmlinux.bin.compressed
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index a6808a403f4b..591125c42d49 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -47,17 +47,15 @@ $(obj)/vmlinux: $(addprefix $(obj)/, $(OBJECTS)) FORCE
 $(obj)/vmlinux.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
 
-vmlinux.bin.all-y := $(obj)/vmlinux.bin
-
-$(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,gzip)
-$(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,bzip2_with_size)
-$(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzma_with_size)
-$(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,xzkern_with_size)
-$(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
+$(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
 	$(call if_changed,lzo_with_size)
 
 OBJCOPYFLAGS += -R .empty_zero_page
-- 
2.32.0


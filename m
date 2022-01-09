Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F008488B89
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 19:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiAISQN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 13:16:13 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:31206 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiAISQL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 13:16:11 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 209IFWa1030890;
        Mon, 10 Jan 2022 03:15:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 209IFWa1030890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641752133;
        bh=Hu1pSO8kr5W4s+4aiz6WXTloSIaIfnMydKHNKnjhhZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YBg0Uya7JsJ9xe1FSsHpzo9R0K39PIqo3EQt3BdCU8JlfkPoJUlFwsvCBhr8F6PKD
         0tjLZBplF+GQW89UANJdymAhd6jX/fc9Hmog1EPdtyL1r7/hDfaGE4hk7MsQIloUYS
         yxShvbaJ4UCQfvwgPNXwUfXwre/esm4IJm1MI/oeVibwJVPnMEd0mMup/zOhJv2tgb
         6jiyiSD2IqL2dwcuWLb+UvZFntpx+N4+QMXnP+5rjtQYXgoi52lE+lssV4wNyolrWl
         0Q7CGIzTxfC7fOtV0Lhz9J2qhPk2cgErjlh3mWW/YURVfbWOBoHKfTfd0+vEzbO/cw
         Fxcm9w4CiTIfg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/5] kbuild: rename cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}
Date:   Mon, 10 Jan 2022 03:15:27 +0900
Message-Id: <20220109181529.351420-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220109181529.351420-1-masahiroy@kernel.org>
References: <20220109181529.351420-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GZIP-compressed files end with 4 byte data that represents the size
of the original input. The decompressors (the self-extracting kernel)
exploit it to know the vmlinux size beforehand. To mimic the GZIP's
trailer, Kbuild provides cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}.
Unfortunately these macros are used everywhere despite the appended
size data is only useful for the decompressors.

There is no guarantee that such hand-crafted trailers are safely ignored.
In fact, the kernel refuses compressed initramdisks with the garbage
data. That is why usr/Makefile overrides size_append to make it no-op.

To limit the use of such broken compressed files, this commit renames
the existing macros as follows:

  cmd_bzip2   --> cmd_bzip2_with_size
  cmd_lzma    --> cmd_lzma_with_size
  cmd_lzo     --> cmd_lzo_with_size
  cmd_lz4     --> cmd_lz4_with_size
  cmd_xzkern  --> cmd_xzkern_with_size
  cmd_zstd22  --> cmd_zstd22_with_size

To keep the decompressors working, I updated the following Makefiles
accordingly:

  arch/arm/boot/compressed/Makefile
  arch/h8300/boot/compressed/Makefile
  arch/mips/boot/compressed/Makefile
  arch/parisc/boot/compressed/Makefile
  arch/s390/boot/compressed/Makefile
  arch/sh/boot/compressed/Makefile
  arch/x86/boot/compressed/Makefile

I reused the current macro names for the normal usecases; they produce
the compressed data in the proper format.

I did not touch the following:

  arch/arc/boot/Makefile
  arch/arm64/boot/Makefile
  arch/csky/boot/Makefile
  arch/mips/boot/Makefile
  arch/riscv/boot/Makefile
  arch/sh/boot/Makefile
  kernel/Makefile

This means those Makefiles will stop appending the size data.

I dropped the 'override size_append' hack from usr/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm/boot/compressed/Makefile    |  8 ++++----
 arch/h8300/boot/compressed/Makefile  |  4 +++-
 arch/mips/boot/compressed/Makefile   | 12 +++++------
 arch/parisc/boot/compressed/Makefile | 10 +++++-----
 arch/s390/boot/compressed/Makefile   | 12 +++++------
 arch/sh/boot/compressed/Makefile     |  8 ++++----
 arch/x86/boot/compressed/Makefile    | 12 +++++------
 scripts/Makefile.lib                 | 30 ++++++++++++++++++++++------
 usr/Makefile                         |  5 -----
 9 files changed, 58 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 91265e7ff672..adc0e318a1ea 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -77,10 +77,10 @@ CPPFLAGS_vmlinux.lds += -DTEXT_OFFSET="$(TEXT_OFFSET)"
 CPPFLAGS_vmlinux.lds += -DMALLOC_SIZE="$(MALLOC_SIZE)"
 
 compress-$(CONFIG_KERNEL_GZIP) = gzip
-compress-$(CONFIG_KERNEL_LZO)  = lzo
-compress-$(CONFIG_KERNEL_LZMA) = lzma
-compress-$(CONFIG_KERNEL_XZ)   = xzkern
-compress-$(CONFIG_KERNEL_LZ4)  = lz4
+compress-$(CONFIG_KERNEL_LZO)  = lzo_with_size
+compress-$(CONFIG_KERNEL_LZMA) = lzma_with_size
+compress-$(CONFIG_KERNEL_XZ)   = xzkern_with_size
+compress-$(CONFIG_KERNEL_LZ4)  = lz4_with_size
 
 libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
 
diff --git a/arch/h8300/boot/compressed/Makefile b/arch/h8300/boot/compressed/Makefile
index 5942793f77a0..6ab2fa5ba105 100644
--- a/arch/h8300/boot/compressed/Makefile
+++ b/arch/h8300/boot/compressed/Makefile
@@ -30,9 +30,11 @@ $(obj)/vmlinux.bin: vmlinux FORCE
 
 suffix-$(CONFIG_KERNEL_GZIP)    := gzip
 suffix-$(CONFIG_KERNEL_LZO)     := lzo
+compress-$(CONFIG_KERNEL_GZIP)  := gzip
+compress-$(CONFIG_KERNEL_LZO)   := lzo_with_size
 
 $(obj)/vmlinux.bin.$(suffix-y): $(obj)/vmlinux.bin FORCE
-	$(call if_changed,$(suffix-y))
+	$(call if_changed,$(compress-y))
 
 LDFLAGS_piggy.o := -r --format binary --oformat elf32-h8300-linux -T
 OBJCOPYFLAGS := -O binary
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index f27cf31b4140..832f8001d7d9 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -64,12 +64,12 @@ $(obj)/vmlinux.bin: $(KBUILD_IMAGE) FORCE
 	$(call if_changed,objcopy)
 
 tool_$(CONFIG_KERNEL_GZIP)    = gzip
-tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
-tool_$(CONFIG_KERNEL_LZ4)     = lz4
-tool_$(CONFIG_KERNEL_LZMA)    = lzma
-tool_$(CONFIG_KERNEL_LZO)     = lzo
-tool_$(CONFIG_KERNEL_XZ)      = xzkern
-tool_$(CONFIG_KERNEL_ZSTD)    = zstd22
+tool_$(CONFIG_KERNEL_BZIP2)   = bzip2_with_size
+tool_$(CONFIG_KERNEL_LZ4)     = lz4_with_size
+tool_$(CONFIG_KERNEL_LZMA)    = lzma_with_size
+tool_$(CONFIG_KERNEL_LZO)     = lzo_with_size
+tool_$(CONFIG_KERNEL_XZ)      = xzkern_with_size
+tool_$(CONFIG_KERNEL_ZSTD)    = zstd22_with_size
 
 targets += vmlinux.bin.z
 
diff --git a/arch/parisc/boot/compressed/Makefile b/arch/parisc/boot/compressed/Makefile
index bf4f2891d0b7..2640f72d69ce 100644
--- a/arch/parisc/boot/compressed/Makefile
+++ b/arch/parisc/boot/compressed/Makefile
@@ -70,15 +70,15 @@ suffix-$(CONFIG_KERNEL_XZ)  := xz
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
 $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,bzip2)
+	$(call if_changed,bzip2_with_size)
 $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lz4)
+	$(call if_changed,lz4_with_size)
 $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzma)
+	$(call if_changed,lzma_with_size)
 $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzo)
+	$(call if_changed,lzo_with_size)
 $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,xzkern)
+	$(call if_changed,xzkern_with_size)
 
 LDFLAGS_piggy.o := -r --format binary --oformat $(LD_BFD) -T
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix-y) FORCE
diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 3b860061e84d..8ea880b7c3ec 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -71,17 +71,17 @@ suffix-$(CONFIG_KERNEL_ZSTD)  := .zst
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
 $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,bzip2)
+	$(call if_changed,bzip2_with_size)
 $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lz4)
+	$(call if_changed,lz4_with_size)
 $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzma)
+	$(call if_changed,lzma_with_size)
 $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzo)
+	$(call if_changed,lzo_with_size)
 $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,xzkern)
+	$(call if_changed,xzkern_with_size)
 $(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,zstd22)
+	$(call if_changed,zstd22_with_size)
 
 OBJCOPYFLAGS_piggy.o := -I binary -O elf64-s390 -B s390:64-bit --rename-section .data=.vmlinux.bin.compressed
 $(obj)/piggy.o: $(obj)/vmlinux.bin$(suffix-y) FORCE
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index c1eb9a62de55..a6808a403f4b 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -52,13 +52,13 @@ vmlinux.bin.all-y := $(obj)/vmlinux.bin
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
 $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,bzip2)
+	$(call if_changed,bzip2_with_size)
 $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzma)
+	$(call if_changed,lzma_with_size)
 $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,xzkern)
+	$(call if_changed,xzkern_with_size)
 $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzo)
+	$(call if_changed,lzo_with_size)
 
 OBJCOPYFLAGS += -R .empty_zero_page
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..2825c74bcae3 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -123,17 +123,17 @@ vmlinux.bin.all-$(CONFIG_X86_NEED_RELOCS) += $(obj)/vmlinux.relocs
 $(obj)/vmlinux.bin.gz: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,gzip)
 $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,bzip2)
+	$(call if_changed,bzip2_with_size)
 $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzma)
+	$(call if_changed,lzma_with_size)
 $(obj)/vmlinux.bin.xz: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,xzkern)
+	$(call if_changed,xzkern_with_size)
 $(obj)/vmlinux.bin.lzo: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lzo)
+	$(call if_changed,lzo_with_size)
 $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,lz4)
+	$(call if_changed,lz4_with_size)
 $(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
-	$(call if_changed,zstd22)
+	$(call if_changed,zstd22_with_size)
 
 suffix-$(CONFIG_KERNEL_GZIP)	:= gz
 suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 5366466ea0e4..4207a72d429f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -395,19 +395,31 @@ printf "%08x\n" $$dec_size |						\
 )
 
 quiet_cmd_bzip2 = BZIP2   $@
-      cmd_bzip2 = { cat $(real-prereqs) | $(KBZIP2) -9; $(size_append); } > $@
+      cmd_bzip2 = cat $(real-prereqs) | $(KBZIP2) -9 > $@
+
+quiet_cmd_bzip2_with_size = BZIP2   $@
+      cmd_bzip2_with_size = { cat $(real-prereqs) | $(KBZIP2) -9; $(size_append); } > $@
 
 # Lzma
 # ---------------------------------------------------------------------------
 
 quiet_cmd_lzma = LZMA    $@
-      cmd_lzma = { cat $(real-prereqs) | $(LZMA) -9; $(size_append); } > $@
+      cmd_lzma = cat $(real-prereqs) | $(LZMA) -9 > $@
+
+quiet_cmd_lzma_with_size = LZMA    $@
+      cmd_lzma_with_size = { cat $(real-prereqs) | $(LZMA) -9; $(size_append); } > $@
 
 quiet_cmd_lzo = LZO     $@
-      cmd_lzo = { cat $(real-prereqs) | $(KLZOP) -9; $(size_append); } > $@
+      cmd_lzo = cat $(real-prereqs) | $(KLZOP) -9 > $@
+
+quiet_cmd_lzo_with_size = LZO     $@
+      cmd_lzo_with_size = { cat $(real-prereqs) | $(KLZOP) -9; $(size_append); } > $@
 
 quiet_cmd_lz4 = LZ4     $@
-      cmd_lz4 = { cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout; \
+      cmd_lz4 = cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout > $@
+
+quiet_cmd_lz4_with_size = LZ4     $@
+      cmd_lz4_with_size = { cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout; \
                   $(size_append); } > $@
 
 # U-Boot mkimage
@@ -450,7 +462,10 @@ quiet_cmd_uimage = UIMAGE  $@
 # big dictionary would increase the memory usage too much in the multi-call
 # decompression mode. A BCJ filter isn't used either.
 quiet_cmd_xzkern = XZKERN  $@
-      cmd_xzkern = { cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh; \
+      cmd_xzkern = cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh > $@
+
+quiet_cmd_xzkern_with_size = XZKERN  $@
+      cmd_xzkern_with_size = { cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh; \
                      $(size_append); } > $@
 
 quiet_cmd_xzmisc = XZMISC  $@
@@ -476,7 +491,10 @@ quiet_cmd_zstd = ZSTD    $@
       cmd_zstd = cat $(real-prereqs) | $(ZSTD) -19 > $@
 
 quiet_cmd_zstd22 = ZSTD22  $@
-      cmd_zstd22 = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
+      cmd_zstd22 = cat $(real-prereqs) | $(ZSTD) -22 --ultra > $@
+
+quiet_cmd_zstd22_with_size = ZSTD22  $@
+      cmd_zstd22_with_size = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@
 
 # ASM offsets
 # ---------------------------------------------------------------------------
diff --git a/usr/Makefile b/usr/Makefile
index b1a81a40eab1..7b89c0175a3a 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -3,11 +3,6 @@
 # kbuild file for usr/ - including initramfs image
 #
 
-# cmd_bzip2, cmd_lzma, cmd_lzo, cmd_lz4 from scripts/Makefile.lib appends the
-# size at the end of the compressed file, which unfortunately does not work
-# with unpack_to_rootfs(). Make size_append no-op.
-override size_append := :
-
 compress-y					:= shipped
 compress-$(CONFIG_INITRAMFS_COMPRESSION_GZIP)	:= gzip
 compress-$(CONFIG_INITRAMFS_COMPRESSION_BZIP2)	:= bzip2
-- 
2.32.0


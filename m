Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A974C5A20
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 10:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiB0JLp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 04:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB0JLp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 04:11:45 -0500
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B48D6D4EF;
        Sun, 27 Feb 2022 01:11:08 -0800 (PST)
Received: from grover.. (133-32-176-37.west.xps.vectant.ne.jp [133.32.176.37]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21R9AVvT024355;
        Sun, 27 Feb 2022 18:10:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21R9AVvT024355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645953032;
        bh=mOcLKSAIGUfePOBI6By4Xw9RDNdqliYg+gQKo6ayREY=;
        h=From:To:Cc:Subject:Date:From;
        b=u+OvsUi5UrQcZL572ybd+7hoT1bMDmH6vZCZMl7d/dSHUCB8gnkUT5iXVqWOsQCmv
         kXFe2PPQoGZCTklE8bLQQC5X2TgRWZscIdXVkDrETRYUrS44wNSAhJgdK/ILeOixzZ
         cqsKhVo+1Qra14yEgasbuYbFBbxSAmpvHL29pgBZRb5rlgGi3IylwEbcs2dXaz0mMv
         de7jmBlljwOlnmMd9L0qNAZrqcP+ExeqNsSvZzMDl1EBfBFBHvW7rSJ7D98Uawdd51
         z1jlewjTPSYY1rF4vaNJqVH+DBexY/1KaMHupMUavXnlKjwl68mMR+ymG1xxRE3Vn5
         0aJ5XjGeyOx6Q==
X-Nifty-SrcIP: [133.32.176.37]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] arch: syscalls: simplify uapi/kapi directory creation
Date:   Sun, 27 Feb 2022 18:10:24 +0900
Message-Id: <20220227091024.207786-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

$(shell ...) expands to empty. There is no need to assign it to _dummy.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/alpha/kernel/syscalls/Makefile      | 3 +--
 arch/arm/tools/Makefile                  | 3 +--
 arch/ia64/kernel/syscalls/Makefile       | 3 +--
 arch/m68k/kernel/syscalls/Makefile       | 3 +--
 arch/microblaze/kernel/syscalls/Makefile | 3 +--
 arch/mips/kernel/syscalls/Makefile       | 3 +--
 arch/parisc/kernel/syscalls/Makefile     | 3 +--
 arch/powerpc/kernel/syscalls/Makefile    | 3 +--
 arch/s390/kernel/syscalls/Makefile       | 3 +--
 arch/sh/kernel/syscalls/Makefile         | 3 +--
 arch/sparc/kernel/syscalls/Makefile      | 3 +--
 arch/x86/entry/syscalls/Makefile         | 3 +--
 arch/xtensa/kernel/syscalls/Makefile     | 3 +--
 13 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/Makefile b/arch/alpha/kernel/syscalls/Makefile
index 6713c65a25e1..b265e4bc16c2 100644
--- a/arch/alpha/kernel/syscalls/Makefile
+++ b/arch/alpha/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
diff --git a/arch/arm/tools/Makefile b/arch/arm/tools/Makefile
index 4a5c50f67ced..81f13bdf32f2 100644
--- a/arch/arm/tools/Makefile
+++ b/arch/arm/tools/Makefile
@@ -29,8 +29,7 @@ kapi:	$(kapi-hdrs-y) $(gen-y)
 uapi:	$(uapi-hdrs-y)
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \
-          $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')
+$(shell mkdir -p $(kapi) $(uapi))
 
 quiet_cmd_gen_mach = GEN     $@
       cmd_gen_mach = $(AWK) -f $(real-prereqs) > $@
diff --git a/arch/ia64/kernel/syscalls/Makefile b/arch/ia64/kernel/syscalls/Makefile
index 14f40ecf8b65..d009f927a048 100644
--- a/arch/ia64/kernel/syscalls/Makefile
+++ b/arch/ia64/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
diff --git a/arch/m68k/kernel/syscalls/Makefile b/arch/m68k/kernel/syscalls/Makefile
index 6713c65a25e1..b265e4bc16c2 100644
--- a/arch/m68k/kernel/syscalls/Makefile
+++ b/arch/m68k/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
diff --git a/arch/microblaze/kernel/syscalls/Makefile b/arch/microblaze/kernel/syscalls/Makefile
index 6713c65a25e1..b265e4bc16c2 100644
--- a/arch/microblaze/kernel/syscalls/Makefile
+++ b/arch/microblaze/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
diff --git a/arch/mips/kernel/syscalls/Makefile b/arch/mips/kernel/syscalls/Makefile
index 10bf90dc02c0..e6b21de65cca 100644
--- a/arch/mips/kernel/syscalls/Makefile
+++ b/arch/mips/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syshdr := $(srctree)/scripts/syscallhdr.sh
 sysnr := $(srctree)/$(src)/syscallnr.sh
diff --git a/arch/parisc/kernel/syscalls/Makefile b/arch/parisc/kernel/syscalls/Makefile
index d63f18dd058d..8440c16dfb22 100644
--- a/arch/parisc/kernel/syscalls/Makefile
+++ b/arch/parisc/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
diff --git a/arch/powerpc/kernel/syscalls/Makefile b/arch/powerpc/kernel/syscalls/Makefile
index 5476f62eb80f..9d7bd81510b8 100644
--- a/arch/powerpc/kernel/syscalls/Makefile
+++ b/arch/powerpc/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
diff --git a/arch/s390/kernel/syscalls/Makefile b/arch/s390/kernel/syscalls/Makefile
index b98f25029b8e..fb85e797946d 100644
--- a/arch/s390/kernel/syscalls/Makefile
+++ b/arch/s390/kernel/syscalls/Makefile
@@ -21,8 +21,7 @@ uapi:	$(uapi-hdrs-y)
 
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)') \
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 filechk_syshdr = $(CONFIG_SHELL) '$(systbl)' -H -a $(syshdr_abi_$(basetarget)) -f "$2" < $<
 
diff --git a/arch/sh/kernel/syscalls/Makefile b/arch/sh/kernel/syscalls/Makefile
index 6713c65a25e1..b265e4bc16c2 100644
--- a/arch/sh/kernel/syscalls/Makefile
+++ b/arch/sh/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
diff --git a/arch/sparc/kernel/syscalls/Makefile b/arch/sparc/kernel/syscalls/Makefile
index d63f18dd058d..8440c16dfb22 100644
--- a/arch/sparc/kernel/syscalls/Makefile
+++ b/arch/sparc/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
diff --git a/arch/x86/entry/syscalls/Makefile b/arch/x86/entry/syscalls/Makefile
index 5b3efed0e4e8..9104039cd8f2 100644
--- a/arch/x86/entry/syscalls/Makefile
+++ b/arch/x86/entry/syscalls/Makefile
@@ -3,8 +3,7 @@ out := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
 # Create output directory if not already present
-_dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)') \
-	  $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')
+$(shell mkdir -p $(out) $(uapi))
 
 syscall32 := $(src)/syscall_32.tbl
 syscall64 := $(src)/syscall_64.tbl
diff --git a/arch/xtensa/kernel/syscalls/Makefile b/arch/xtensa/kernel/syscalls/Makefile
index 6713c65a25e1..b265e4bc16c2 100644
--- a/arch/xtensa/kernel/syscalls/Makefile
+++ b/arch/xtensa/kernel/syscalls/Makefile
@@ -2,8 +2,7 @@
 kapi := arch/$(SRCARCH)/include/generated/asm
 uapi := arch/$(SRCARCH)/include/generated/uapi/asm
 
-_dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
-	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
+$(shell mkdir -p $(uapi) $(kapi))
 
 syscall := $(src)/syscall.tbl
 syshdr := $(srctree)/scripts/syscallhdr.sh
-- 
2.32.0


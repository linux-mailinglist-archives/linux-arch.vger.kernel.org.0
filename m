Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEDA4DAB5A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Mar 2022 08:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354087AbiCPHHL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 03:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354220AbiCPHGX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 03:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4052251D;
        Wed, 16 Mar 2022 00:05:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C3F61027;
        Wed, 16 Mar 2022 07:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EA7C340E9;
        Wed, 16 Mar 2022 07:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647414304;
        bh=6vp86t6L9YNVq1oOxZY4ODPiNHsPcvWwCzpmlPVsE6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1Or+he1VwgDnRV6nze/y02U1ydON9hW/+PkV3EuLUWhOE7aFCRrq5gt78gLJvLc4
         uFzOROVeeZxSKZ1vn70sArdd2CsEUs9+Nf5UeQAG8Nnaw20wBIo7sfNcin/KHKLeYg
         TGHCHYWHfthH5PW/KRMV+gPRRZY06skCpH32DB3pm+wrL2c0BzWirNdmvNh9oqpRIG
         ZkbjIaIK70YRQPGC94wZEVdVKOj2gELQDF2A7V0HHw2aPIC4XpVULqV6NhQfr+mgyN
         5lsTR/pJuzxCZuASU604/QmrW4PHxGGbPA08Fd2a4twWpH4KuxO7DhP1JSi3YnQVCd
         oYEa359D2jiuA==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V8 16/20] riscv: compat: vdso: Add COMPAT_VDSO base code implementation
Date:   Wed, 16 Mar 2022 15:03:13 +0800
Message-Id: <20220316070317.1864279-17-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316070317.1864279-1-guoren@kernel.org>
References: <20220316070317.1864279-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There is no vgettimeofday supported in rv32 that makes simple to
generate rv32 vdso code which only needs riscv64 compiler. Other
architectures need change compiler or -m (machine parameter) to
support vdso32 compiling. If rv32 support vgettimeofday (which
cause C compile) in future, we would add CROSS_COMPILE to support
that makes more requirement on compiler enviornment.

linux-rv64/arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:
file format elf64-littleriscv

Disassembly of section .text:

0000000000000800 <__vdso_rt_sigreturn>:
 800:   08b00893                li      a7,139
 804:   00000073                ecall
 808:   0000                    unimp
        ...

000000000000080c <__vdso_getcpu>:
 80c:   0a800893                li      a7,168
 810:   00000073                ecall
 814:   8082                    ret
        ...

0000000000000818 <__vdso_flush_icache>:
 818:   10300893                li      a7,259
 81c:   00000073                ecall
 820:   8082                    ret

linux-rv32/arch/riscv/kernel/vdso/vdso.so.dbg:
file format elf32-littleriscv

Disassembly of section .text:

00000800 <__vdso_rt_sigreturn>:
 800:   08b00893                li      a7,139
 804:   00000073                ecall
 808:   0000                    unimp
        ...

0000080c <__vdso_getcpu>:
 80c:   0a800893                li      a7,168
 810:   00000073                ecall
 814:   8082                    ret
        ...

00000818 <__vdso_flush_icache>:
 818:   10300893                li      a7,259
 81c:   00000073                ecall
 820:   8082                    ret

Finally, reuse all *.S from vdso in compat_vdso that makes
implementation clear and readable.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/Makefile                           |  5 ++
 arch/riscv/include/asm/vdso.h                 |  9 +++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/compat_vdso/.gitignore      |  2 +
 arch/riscv/kernel/compat_vdso/Makefile        | 78 +++++++++++++++++++
 arch/riscv/kernel/compat_vdso/compat_vdso.S   |  8 ++
 .../kernel/compat_vdso/compat_vdso.lds.S      |  3 +
 arch/riscv/kernel/compat_vdso/flush_icache.S  |  3 +
 .../compat_vdso/gen_compat_vdso_offsets.sh    |  5 ++
 arch/riscv/kernel/compat_vdso/getcpu.S        |  3 +
 arch/riscv/kernel/compat_vdso/note.S          |  3 +
 arch/riscv/kernel/compat_vdso/rt_sigreturn.S  |  3 +
 arch/riscv/kernel/vdso/vdso.S                 |  6 +-
 13 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/compat_vdso/.gitignore
 create mode 100644 arch/riscv/kernel/compat_vdso/Makefile
 create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.S
 create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
 create mode 100644 arch/riscv/kernel/compat_vdso/flush_icache.S
 create mode 100755 arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
 create mode 100644 arch/riscv/kernel/compat_vdso/getcpu.S
 create mode 100644 arch/riscv/kernel/compat_vdso/note.S
 create mode 100644 arch/riscv/kernel/compat_vdso/rt_sigreturn.S

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index c6ca1b9cbf71..6a494029b8bd 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -112,12 +112,17 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 PHONY += vdso_install
 vdso_install:
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
+	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
+		$(build)=arch/riscv/kernel/compat_vdso $@)
 
 ifeq ($(KBUILD_EXTMOD),)
 ifeq ($(CONFIG_MMU),y)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
+		$(build)=arch/riscv/kernel/compat_vdso include/generated/compat_vdso-offsets.h)
+
 endif
 endif
 
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index bc6f75f3a199..af981426fe0f 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -21,6 +21,15 @@
 
 #define VDSO_SYMBOL(base, name)							\
 	(void __user *)((unsigned long)(base) + __vdso_##name##_offset)
+
+#ifdef CONFIG_COMPAT
+#include <generated/compat_vdso-offsets.h>
+
+#define COMPAT_VDSO_SYMBOL(base, name)						\
+	(void __user *)((unsigned long)(base) + compat__vdso_##name##_offset)
+
+#endif /* CONFIG_COMPAT */
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* CONFIG_MMU */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 3b3e425aadd2..6365f382d2fd 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
 obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
+obj-$(CONFIG_COMPAT)		+= compat_vdso/
diff --git a/arch/riscv/kernel/compat_vdso/.gitignore b/arch/riscv/kernel/compat_vdso/.gitignore
new file mode 100644
index 000000000000..19d83d846c1e
--- /dev/null
+++ b/arch/riscv/kernel/compat_vdso/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+compat_vdso.lds
diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/compat_vdso/Makefile
new file mode 100644
index 000000000000..260daf3236d3
--- /dev/null
+++ b/arch/riscv/kernel/compat_vdso/Makefile
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for compat_vdso
+#
+
+# Symbols present in the compat_vdso
+compat_vdso-syms  = rt_sigreturn
+compat_vdso-syms += getcpu
+compat_vdso-syms += flush_icache
+
+COMPAT_CC := $(CC)
+COMPAT_LD := $(LD)
+
+COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
+COMPAT_LD_FLAGS := -melf32lriscv
+
+# Files to link into the compat_vdso
+obj-compat_vdso = $(patsubst %, %.o, $(compat_vdso-syms)) note.o
+
+# Build rules
+targets := $(obj-compat_vdso) compat_vdso.so compat_vdso.so.dbg compat_vdso.lds
+obj-compat_vdso := $(addprefix $(obj)/, $(obj-compat_vdso))
+
+obj-y += compat_vdso.o
+CPPFLAGS_compat_vdso.lds += -P -C -U$(ARCH)
+
+# Disable profiling and instrumentation for VDSO code
+GCOV_PROFILE := n
+KCOV_INSTRUMENT := n
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+
+# Force dependency
+$(obj)/compat_vdso.o: $(obj)/compat_vdso.so
+
+# link rule for the .so file, .lds has to be first
+$(obj)/compat_vdso.so.dbg: $(obj)/compat_vdso.lds $(obj-compat_vdso) FORCE
+	$(call if_changed,compat_vdsold)
+LDFLAGS_compat_vdso.so.dbg = -shared -S -soname=linux-compat_vdso.so.1 \
+	--build-id=sha1 --hash-style=both --eh-frame-hdr
+
+$(obj-compat_vdso): %.o: %.S FORCE
+	$(call if_changed_dep,compat_vdsoas)
+
+# strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# Generate VDSO offsets using helper script
+gen-compat_vdsosym := $(srctree)/$(src)/gen_compat_vdso_offsets.sh
+quiet_cmd_compat_vdsosym = VDSOSYM $@
+	cmd_compat_vdsosym = $(NM) $< | $(gen-compat_vdsosym) | LC_ALL=C sort > $@
+
+include/generated/compat_vdso-offsets.h: $(obj)/compat_vdso.so.dbg FORCE
+	$(call if_changed,compat_vdsosym)
+
+# actual build commands
+# The DSO images are built using a special linker script
+# Make sure only to export the intended __compat_vdso_xxx symbol offsets.
+quiet_cmd_compat_vdsold = VDSOLD  $@
+      cmd_compat_vdsold = $(COMPAT_LD) $(ld_flags) $(COMPAT_LD_FLAGS) -T $(filter-out FORCE,$^) -o $@.tmp && \
+                   $(OBJCOPY) $(patsubst %, -G __compat_vdso_%, $(compat_vdso-syms)) $@.tmp $@ && \
+                   rm $@.tmp
+
+# actual build commands
+quiet_cmd_compat_vdsoas = VDSOAS $@
+      cmd_compat_vdsoas = $(COMPAT_CC) $(a_flags) $(COMPAT_CC_FLAGS) -c -o $@ $<
+
+# install commands for the unstripped file
+quiet_cmd_compat_vdso_install = INSTALL $@
+      cmd_compat_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/compat_vdso/$@
+
+compat_vdso.so: $(obj)/compat_vdso.so.dbg
+	@mkdir -p $(MODLIB)/compat_vdso
+	$(call cmd,compat_vdso_install)
+
+compat_vdso_install: compat_vdso.so
diff --git a/arch/riscv/kernel/compat_vdso/compat_vdso.S b/arch/riscv/kernel/compat_vdso/compat_vdso.S
new file mode 100644
index 000000000000..fea4a8b0c45d
--- /dev/null
+++ b/arch/riscv/kernel/compat_vdso/compat_vdso.S
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#define	vdso_start	compat_vdso_start
+#define	vdso_end	compat_vdso_end
+
+#define	__VDSO_PATH	"arch/riscv/kernel/compat_vdso/compat_vdso.so"
+
+#include <../vdso/vdso.S>
diff --git a/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S b/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
new file mode 100644
index 000000000000..02a9ec5dc7f6
--- /dev/null
+++ b/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <../vdso/vdso.lds.S>
diff --git a/arch/riscv/kernel/compat_vdso/flush_icache.S b/arch/riscv/kernel/compat_vdso/flush_icache.S
new file mode 100644
index 000000000000..88e21a84a974
--- /dev/null
+++ b/arch/riscv/kernel/compat_vdso/flush_icache.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <../vdso/flush_icache.S>
diff --git a/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh b/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
new file mode 100755
index 000000000000..8ac070c783b3
--- /dev/null
+++ b/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+LC_ALL=C
+sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define compat\2_offset\t0x\1/p'
diff --git a/arch/riscv/kernel/compat_vdso/getcpu.S b/arch/riscv/kernel/compat_vdso/getcpu.S
new file mode 100644
index 000000000000..946449a15a94
--- /dev/null
+++ b/arch/riscv/kernel/compat_vdso/getcpu.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <../vdso/getcpu.S>
diff --git a/arch/riscv/kernel/compat_vdso/note.S b/arch/riscv/kernel/compat_vdso/note.S
new file mode 100644
index 000000000000..67c50898b8e5
--- /dev/null
+++ b/arch/riscv/kernel/compat_vdso/note.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <../vdso/note.S>
diff --git a/arch/riscv/kernel/compat_vdso/rt_sigreturn.S b/arch/riscv/kernel/compat_vdso/rt_sigreturn.S
new file mode 100644
index 000000000000..f4c98f18c053
--- /dev/null
+++ b/arch/riscv/kernel/compat_vdso/rt_sigreturn.S
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <../vdso/rt_sigreturn.S>
diff --git a/arch/riscv/kernel/vdso/vdso.S b/arch/riscv/kernel/vdso/vdso.S
index df222245be05..83f1c899e8d8 100644
--- a/arch/riscv/kernel/vdso/vdso.S
+++ b/arch/riscv/kernel/vdso/vdso.S
@@ -7,12 +7,16 @@
 #include <linux/linkage.h>
 #include <asm/page.h>
 
+#ifndef __VDSO_PATH
+#define __VDSO_PATH "arch/riscv/kernel/vdso/vdso.so"
+#endif
+
 	__PAGE_ALIGNED_DATA
 
 	.globl vdso_start, vdso_end
 	.balign PAGE_SIZE
 vdso_start:
-	.incbin "arch/riscv/kernel/vdso/vdso.so"
+	.incbin __VDSO_PATH
 	.balign PAGE_SIZE
 vdso_end:
 
-- 
2.25.1


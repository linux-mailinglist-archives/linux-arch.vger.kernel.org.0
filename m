Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF4E91CCC
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2019 07:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfHSF5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Aug 2019 01:57:41 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:53285 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSF5l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 01:57:41 -0400
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-07.nifty.com with ESMTP id x7J5scDE001566
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 14:54:38 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7J5sRot016240;
        Mon, 19 Aug 2019 14:54:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7J5sRot016240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566194068;
        bh=rhvPyXX5uGqHs4FunKgbmjgbKY+jf3P80OmmX7W5cHE=;
        h=From:To:Cc:Subject:Date:From;
        b=PyQIeDd1AlyFTEhtzdKzbwtVy50BH+qGEJvFNO7bf3X65+8FqP+6adZR38iIMrPyo
         Ee6CVj9zT79RHE/4893BWpgipiNrP6tmBBVTGjIl5DMwlubez+atRoAnpfVlMEVX59
         N97Fm5DyUjH9bcWW6EOQkC2E7dcnGUcw72ZuCIM4+80ZrcHTboFQm5iDIa01WBeg+S
         61VvzLAEX0XxvWhPKOt5uadpgEu80leYR5ytVGNkMEjaJnOROHMZgCfp47vCj/8gLD
         UmiceGa0rk1fg0RFK7VbvYW7AbHH6qlH38rMAbCprRz918kgzR6YU0oSBoCIhsbQMA
         gxVIILpfc8tPg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] kbuild: add CONFIG_ASM_MODVERSIONS
Date:   Mon, 19 Aug 2019 14:54:20 +0900
Message-Id: <20190819055421.13482-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add CONFIG_ASM_MODVERSIONS to remove one if-conditional nesting
from Makefile.build

This also avoid $(wildcard ...) evaluation for every descending,
but I did not see measurable performance improvement.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/Kconfig           | 7 +++++++
 arch/alpha/Kconfig     | 1 +
 arch/arm64/Kconfig     | 1 +
 arch/ia64/Kconfig      | 1 +
 arch/m68k/Kconfig      | 1 +
 arch/mips/Kconfig      | 1 +
 arch/powerpc/Kconfig   | 1 +
 arch/riscv/Kconfig     | 1 +
 arch/s390/Kconfig      | 1 +
 arch/sparc/Kconfig     | 1 +
 arch/um/Kconfig        | 1 +
 arch/x86/Kconfig       | 1 +
 init/Kconfig           | 8 ++++++++
 scripts/Makefile.build | 7 +------
 14 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a7b57dd42c26..7d7b1b6af851 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -289,6 +289,13 @@ config ARCH_32BIT_OFF_T
 	  still support 32-bit off_t. This option is enabled for all such
 	  architectures explicitly.
 
+config HAVE_ASM_MODVERSIONS
+	bool
+	help
+	  This symbol should be selected by an architecure if it provides
+	  <asm/asm-prototypes.h> to support the module versioning for symbols
+	  exported from assembly code.
+
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index f7b19b813a70..ef179033a7c2 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -11,6 +11,7 @@ config ALPHA
 	select PCI_DOMAINS if PCI
 	select PCI_SYSCALL if PCI
 	select HAVE_AOUT
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_PCSPKR_PLATFORM
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..cb16d4ade6aa 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -135,6 +135,7 @@ config ARM64
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_VMAP_STACK
 	select HAVE_ARM_SMCCC
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_EBPF_JIT
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CMPXCHG_DOUBLE
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 7468d8e50467..3dead116a6d7 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -17,6 +17,7 @@ config IA64
 	select FORCE_PCI if (!IA64_HP_SIM)
 	select PCI_DOMAINS if PCI
 	select PCI_SYSCALL if PCI
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_EXIT_THREAD
 	select HAVE_IDE
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index c518d695c376..00a20fa0bdcc 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -14,6 +14,7 @@ config M68K
 	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
 	select HAVE_IDE
 	select HAVE_AOUT if MMU
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_ATOMIC64
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index d50fafd7bf3a..3db919b5c93a 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -44,6 +44,7 @@ config MIPS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES && 64BIT
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_EBPF_JIT if (!CPU_MICROMIPS)
 	select HAVE_CONTEXT_TRACKING
 	select HAVE_COPY_THREAD_TLS
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d8dcd8820369..ec1e047200f3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -177,6 +177,7 @@ config PPC
 	select HAVE_ARCH_NVRAM_OPS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CBPF_JIT			if !PPC64
 	select HAVE_STACKPROTECTOR		if PPC64 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r13)
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59a4727ecd6c..66603f02675a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -31,6 +31,7 @@ config RISCV
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_ATOMIC64 if !64BIT
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_FUTEX_CMPXCHG if FUTEX
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a4ad2733eedf..c06ebe34e0f9 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -131,6 +131,7 @@ config S390
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_EBPF_JIT if PACK_STACK && HAVE_MARCH_Z196_FEATURES
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 7926a2e11bdc..fbc1aecf0f94 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -17,6 +17,7 @@ config SPARC
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select OF
 	select OF_PROMTREE
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB if !SMP || SPARC64
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 3c3adfc486f2..fec6b4ca2b6e 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -9,6 +9,7 @@ config UML
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_UID16
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..66bb9f25e9df 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -147,6 +147,7 @@ config X86
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if X86_64
 	select HAVE_ARCH_VMAP_STACK		if X86_64
 	select HAVE_ARCH_WITHIN_STACK_FRAMES
+	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..bf971b5c707d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1989,6 +1989,14 @@ config MODVERSIONS
 	  make them incompatible with the kernel you are running.  If
 	  unsure, say N.
 
+config ASM_MODVERSIONS
+	bool
+	default HAVE_ASM_MODVERSIONS && MODVERSIONS
+	help
+	  This enables module versioning for exported symbols also from
+	  assembly. This can be enabled only when the target architecture
+	  supports it.
+
 config MODULE_REL_CRCS
 	bool
 	depends on MODVERSIONS
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2f66ed388d1c..f58c9396aba4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -356,11 +356,7 @@ $(obj)/%.s: $(src)/%.S FORCE
 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
       cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
 
-ifdef CONFIG_MODVERSIONS
-
-ASM_PROTOTYPES := $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h)
-
-ifneq ($(ASM_PROTOTYPES),)
+ifdef CONFIG_ASM_MODVERSIONS
 
 # versioning matches the C process described above, with difference that
 # we parse asm-prototypes.h C header to get function definitions.
@@ -376,7 +372,6 @@ cmd_modversions_S =								\
 		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
 	fi
 endif
-endif
 
 $(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
 	$(call if_changed_rule,as_o_S)
-- 
2.17.1


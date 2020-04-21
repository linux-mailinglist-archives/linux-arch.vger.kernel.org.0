Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2BB1B2C12
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 18:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgDUQOg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 12:14:36 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:20068 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgDUQOf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 12:14:35 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03LGE0EK029890;
        Wed, 22 Apr 2020 01:14:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03LGE0EK029890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587485640;
        bh=A92vaWYsm/R81gtu29PQ7qPZwGCwJSxP/ZmxFgy/G1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=13ZhGqyPzfPnWkxPsZWYiZzQdM+WeDFIrm0I+1apSJfoD4ZMRsHrT9F9KCKJg5ZjB
         8br3jPNXIb6MPYUYVjY8HleLFC1PD0MqVjL8LLB56gcCVMXIegutSBhyK4/kKNP5rt
         LVtq6ak3tCJXeXuuvEsv+8J032OMzuMkIIgAQnbNumuseUp+LCd3oqaNhMNUHuGQz3
         5INj/obJ3tPtKcJ6CjbVJfZaRSoaVAl8S1XKsSFHrm89296lrU+020lesx+mL1SC+H
         WMrgsuK1bLCrlCLAithmu9Ty9OzIpQtXRQATxPMC7MCb/Dqspvz02usIHNqSnWy4t4
         0XcvBEorhkcNw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2] arch: split MODULE_ARCH_VERMAGIC definitions out to <asm/vermagic.h>
Date:   Wed, 22 Apr 2020 01:13:55 +0900
Message-Id: <20200421161355.1357112-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As the bug report [1] pointed out, <linux/vermagic.h> must be included
after <linux/module.h>.

I believe we should not impose any include order restriction. We often
sort include directives alphabetically, but it is just coding style
convention. Technically, we can include header files in any order by
making every header self-contained.

Currently, arch-specific MODULE_ARCH_VERMAGIC is defined in
<asm/module.h>, which is not included from <linux/vermagic.h>.

Hence, the straight-forward fix-up would be as follows:

|--- a/include/linux/vermagic.h
|+++ b/include/linux/vermagic.h
|@@ -1,5 +1,6 @@
| /* SPDX-License-Identifier: GPL-2.0 */
| #include <generated/utsrelease.h>
|+#include <linux/module.h>
|
| /* Simply sanity version stamp for modules. */
| #ifdef CONFIG_SMP

This works enough, but for further cleanups, I split MODULE_ARCH_VERMAGIC
definitions into <asm/vermagic.h>.

With this, <linux/module.h> and <linux/vermagic.h> will be orthogonal,
and the location of MODULE_ARCH_VERMAGIC definitions will be consistent.

For arc and ia64, MODULE_PROC_FAMILY is only used for defining
MODULE_ARCH_VERMAGIC. I squashed it.

For hexagon, nds32, and xtensa, I removed <asm/modules.h> entirely
because they contained nothing but MODULE_ARCH_VERMAGIC definition.
Kbuild will automatically generate <asm/modules.h> at build-time,
wrapping <asm-generic/module.h>.

[1] https://lore.kernel.org/lkml/20200411155623.GA22175@zn.tnic

Reported-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I do not mean to replace the work by Leon Romanovsky:
https://lkml.org/lkml/2020/4/19/201

His work intends to hide <linux/vermagic.h> from driver writers.
It is solving a different problem.
It does not solve the include order restriction reported by [1].
It still relies on kernel/module.c and *.mod.c
include <linux/vermagic.h> after <linux/module.h>.

I believe we should not impose any restriction about the include order.
So, this patch is the direct answer to the bug report [1].

BTW, I think commit f58dd03b1157bdf3b64c36e9525f8d7f69c25df2
was a bad way to suppress the problem, but that is another story.


Changes in v2:
  - add include/asm-generic/vermagic.h
  - add Reported-by

 arch/arc/include/asm/module.h                 |  5 --
 arch/arc/include/asm/vermagic.h               |  8 +++
 arch/arm/include/asm/module.h                 | 24 -------
 arch/arm/include/asm/vermagic.h               | 31 +++++++++
 arch/arm64/include/asm/module.h               |  2 -
 arch/arm64/include/asm/vermagic.h             | 10 +++
 .../include/asm/{module.h => vermagic.h}      |  8 +--
 arch/ia64/include/asm/module.h                |  4 --
 arch/ia64/include/asm/vermagic.h              | 15 ++++
 arch/mips/include/asm/module.h                | 61 -----------------
 arch/mips/include/asm/vermagic.h              | 66 ++++++++++++++++++
 .../include/asm/{module.h => vermagic.h}      |  8 +--
 arch/powerpc/include/asm/module.h             | 18 -----
 arch/powerpc/include/asm/vermagic.h           | 20 ++++++
 arch/riscv/include/asm/module.h               |  2 -
 arch/riscv/include/asm/vermagic.h             |  9 +++
 arch/sh/include/asm/module.h                  | 28 --------
 arch/sh/include/asm/vermagic.h                | 34 ++++++++++
 arch/x86/include/asm/module.h                 | 60 ----------------
 arch/x86/include/asm/vermagic.h               | 68 +++++++++++++++++++
 .../include/asm/{module.h => vermagic.h}      | 13 ++--
 include/asm-generic/Kbuild                    |  1 +
 include/asm-generic/vermagic.h                |  7 ++
 include/linux/vermagic.h                      |  8 ++-
 24 files changed, 287 insertions(+), 223 deletions(-)
 create mode 100644 arch/arc/include/asm/vermagic.h
 create mode 100644 arch/arm/include/asm/vermagic.h
 create mode 100644 arch/arm64/include/asm/vermagic.h
 rename arch/hexagon/include/asm/{module.h => vermagic.h} (64%)
 create mode 100644 arch/ia64/include/asm/vermagic.h
 create mode 100644 arch/mips/include/asm/vermagic.h
 rename arch/nds32/include/asm/{module.h => vermagic.h} (52%)
 create mode 100644 arch/powerpc/include/asm/vermagic.h
 create mode 100644 arch/riscv/include/asm/vermagic.h
 create mode 100644 arch/sh/include/asm/vermagic.h
 create mode 100644 arch/x86/include/asm/vermagic.h
 rename arch/xtensa/include/asm/{module.h => vermagic.h} (72%)
 create mode 100644 include/asm-generic/vermagic.h

diff --git a/arch/arc/include/asm/module.h b/arch/arc/include/asm/module.h
index 48f13a4ace4b..f534a1fef070 100644
--- a/arch/arc/include/asm/module.h
+++ b/arch/arc/include/asm/module.h
@@ -3,7 +3,6 @@
  * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
  *
  * Amit Bhor, Sameer Dhavale: Codito Technologies 2004
-
  */
 
 #ifndef _ASM_ARC_MODULE_H
@@ -19,8 +18,4 @@ struct mod_arch_specific {
 	const char *secstr;
 };
 
-#define MODULE_PROC_FAMILY "ARC700"
-
-#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY
-
 #endif /* _ASM_ARC_MODULE_H */
diff --git a/arch/arc/include/asm/vermagic.h b/arch/arc/include/asm/vermagic.h
new file mode 100644
index 000000000000..a10257d2c62c
--- /dev/null
+++ b/arch/arc/include/asm/vermagic.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#define MODULE_ARCH_VERMAGIC "ARC700"
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 182163b55546..4b0df09cbe67 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -37,30 +37,6 @@ struct mod_arch_specific {
 struct module;
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
 
-/*
- * Add the ARM architecture version to the version magic string
- */
-#define MODULE_ARCH_VERMAGIC_ARMVSN "ARMv" __stringify(__LINUX_ARM_ARCH__) " "
-
-/* Add __virt_to_phys patching state as well */
-#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
-#define MODULE_ARCH_VERMAGIC_P2V "p2v8 "
-#else
-#define MODULE_ARCH_VERMAGIC_P2V ""
-#endif
-
-/* Add instruction set architecture tag to distinguish ARM/Thumb kernels */
-#ifdef CONFIG_THUMB2_KERNEL
-#define MODULE_ARCH_VERMAGIC_ARMTHUMB "thumb2 "
-#else
-#define MODULE_ARCH_VERMAGIC_ARMTHUMB ""
-#endif
-
-#define MODULE_ARCH_VERMAGIC \
-	MODULE_ARCH_VERMAGIC_ARMVSN \
-	MODULE_ARCH_VERMAGIC_ARMTHUMB \
-	MODULE_ARCH_VERMAGIC_P2V
-
 #ifdef CONFIG_THUMB2_KERNEL
 #define HAVE_ARCH_KALLSYMS_SYMBOL_VALUE
 static inline unsigned long kallsyms_symbol_value(const Elf_Sym *sym)
diff --git a/arch/arm/include/asm/vermagic.h b/arch/arm/include/asm/vermagic.h
new file mode 100644
index 000000000000..62ce94e26a63
--- /dev/null
+++ b/arch/arm/include/asm/vermagic.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#include <linux/stringify.h>
+
+/*
+ * Add the ARM architecture version to the version magic string
+ */
+#define MODULE_ARCH_VERMAGIC_ARMVSN "ARMv" __stringify(__LINUX_ARM_ARCH__) " "
+
+/* Add __virt_to_phys patching state as well */
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+#define MODULE_ARCH_VERMAGIC_P2V "p2v8 "
+#else
+#define MODULE_ARCH_VERMAGIC_P2V ""
+#endif
+
+/* Add instruction set architecture tag to distinguish ARM/Thumb kernels */
+#ifdef CONFIG_THUMB2_KERNEL
+#define MODULE_ARCH_VERMAGIC_ARMTHUMB "thumb2 "
+#else
+#define MODULE_ARCH_VERMAGIC_ARMTHUMB ""
+#endif
+
+#define MODULE_ARCH_VERMAGIC \
+	MODULE_ARCH_VERMAGIC_ARMVSN \
+	MODULE_ARCH_VERMAGIC_ARMTHUMB \
+	MODULE_ARCH_VERMAGIC_P2V
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 1e93de68c044..4e7fa2623896 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -7,8 +7,6 @@
 
 #include <asm-generic/module.h>
 
-#define MODULE_ARCH_VERMAGIC	"aarch64"
-
 #ifdef CONFIG_ARM64_MODULE_PLTS
 struct mod_plt_sec {
 	int			plt_shndx;
diff --git a/arch/arm64/include/asm/vermagic.h b/arch/arm64/include/asm/vermagic.h
new file mode 100644
index 000000000000..a1eec6a000f1
--- /dev/null
+++ b/arch/arm64/include/asm/vermagic.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#define MODULE_ARCH_VERMAGIC	"aarch64"
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/hexagon/include/asm/module.h b/arch/hexagon/include/asm/vermagic.h
similarity index 64%
rename from arch/hexagon/include/asm/module.h
rename to arch/hexagon/include/asm/vermagic.h
index e8de4fe03543..0e8dedc8c486 100644
--- a/arch/hexagon/include/asm/module.h
+++ b/arch/hexagon/include/asm/vermagic.h
@@ -3,11 +3,11 @@
  * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
  */
 
-#ifndef _ASM_MODULE_H
-#define _ASM_MODULE_H
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
 
-#include <asm-generic/module.h>
+#include <linux/stringify.h>
 
 #define MODULE_ARCH_VERMAGIC __stringify(PROCESSOR_MODEL_NAME) " "
 
-#endif
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/ia64/include/asm/module.h b/arch/ia64/include/asm/module.h
index f319144260ce..5a29652e6def 100644
--- a/arch/ia64/include/asm/module.h
+++ b/arch/ia64/include/asm/module.h
@@ -26,10 +26,6 @@ struct mod_arch_specific {
 	unsigned int next_got_entry;	/* index of next available got entry */
 };
 
-#define MODULE_PROC_FAMILY	"ia64"
-#define MODULE_ARCH_VERMAGIC	MODULE_PROC_FAMILY \
-	"gcc-" __stringify(__GNUC__) "." __stringify(__GNUC_MINOR__)
-
 #define ARCH_SHF_SMALL	SHF_IA_64_SHORT
 
 #endif /* _ASM_IA64_MODULE_H */
diff --git a/arch/ia64/include/asm/vermagic.h b/arch/ia64/include/asm/vermagic.h
new file mode 100644
index 000000000000..29c7424f4c25
--- /dev/null
+++ b/arch/ia64/include/asm/vermagic.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2003 Hewlett-Packard Co
+ *	David Mosberger-Tang <davidm@hpl.hp.com>
+ */
+
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#include <linux/stringify.h>
+
+#define MODULE_ARCH_VERMAGIC	"ia64" \
+	"gcc-" __stringify(__GNUC__) "." __stringify(__GNUC_MINOR__)
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/mips/include/asm/module.h b/arch/mips/include/asm/module.h
index 9846047b3d3d..724a0882576b 100644
--- a/arch/mips/include/asm/module.h
+++ b/arch/mips/include/asm/module.h
@@ -83,65 +83,4 @@ search_module_dbetables(unsigned long addr)
 }
 #endif
 
-#ifdef CONFIG_CPU_BMIPS
-#define MODULE_PROC_FAMILY "BMIPS "
-#elif defined CONFIG_CPU_MIPS32_R1
-#define MODULE_PROC_FAMILY "MIPS32_R1 "
-#elif defined CONFIG_CPU_MIPS32_R2
-#define MODULE_PROC_FAMILY "MIPS32_R2 "
-#elif defined CONFIG_CPU_MIPS32_R6
-#define MODULE_PROC_FAMILY "MIPS32_R6 "
-#elif defined CONFIG_CPU_MIPS64_R1
-#define MODULE_PROC_FAMILY "MIPS64_R1 "
-#elif defined CONFIG_CPU_MIPS64_R2
-#define MODULE_PROC_FAMILY "MIPS64_R2 "
-#elif defined CONFIG_CPU_MIPS64_R6
-#define MODULE_PROC_FAMILY "MIPS64_R6 "
-#elif defined CONFIG_CPU_R3000
-#define MODULE_PROC_FAMILY "R3000 "
-#elif defined CONFIG_CPU_TX39XX
-#define MODULE_PROC_FAMILY "TX39XX "
-#elif defined CONFIG_CPU_VR41XX
-#define MODULE_PROC_FAMILY "VR41XX "
-#elif defined CONFIG_CPU_R4X00
-#define MODULE_PROC_FAMILY "R4X00 "
-#elif defined CONFIG_CPU_TX49XX
-#define MODULE_PROC_FAMILY "TX49XX "
-#elif defined CONFIG_CPU_R5000
-#define MODULE_PROC_FAMILY "R5000 "
-#elif defined CONFIG_CPU_R5500
-#define MODULE_PROC_FAMILY "R5500 "
-#elif defined CONFIG_CPU_NEVADA
-#define MODULE_PROC_FAMILY "NEVADA "
-#elif defined CONFIG_CPU_R10000
-#define MODULE_PROC_FAMILY "R10000 "
-#elif defined CONFIG_CPU_RM7000
-#define MODULE_PROC_FAMILY "RM7000 "
-#elif defined CONFIG_CPU_SB1
-#define MODULE_PROC_FAMILY "SB1 "
-#elif defined CONFIG_CPU_LOONGSON32
-#define MODULE_PROC_FAMILY "LOONGSON32 "
-#elif defined CONFIG_CPU_LOONGSON2EF
-#define MODULE_PROC_FAMILY "LOONGSON2EF "
-#elif defined CONFIG_CPU_LOONGSON64
-#define MODULE_PROC_FAMILY "LOONGSON64 "
-#elif defined CONFIG_CPU_CAVIUM_OCTEON
-#define MODULE_PROC_FAMILY "OCTEON "
-#elif defined CONFIG_CPU_XLR
-#define MODULE_PROC_FAMILY "XLR "
-#elif defined CONFIG_CPU_XLP
-#define MODULE_PROC_FAMILY "XLP "
-#else
-#error MODULE_PROC_FAMILY undefined for your processor configuration
-#endif
-
-#ifdef CONFIG_32BIT
-#define MODULE_KERNEL_TYPE "32BIT "
-#elif defined CONFIG_64BIT
-#define MODULE_KERNEL_TYPE "64BIT "
-#endif
-
-#define MODULE_ARCH_VERMAGIC \
-	MODULE_PROC_FAMILY MODULE_KERNEL_TYPE
-
 #endif /* _ASM_MODULE_H */
diff --git a/arch/mips/include/asm/vermagic.h b/arch/mips/include/asm/vermagic.h
new file mode 100644
index 000000000000..24dc3d35161c
--- /dev/null
+++ b/arch/mips/include/asm/vermagic.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#ifdef CONFIG_CPU_BMIPS
+#define MODULE_PROC_FAMILY "BMIPS "
+#elif defined CONFIG_CPU_MIPS32_R1
+#define MODULE_PROC_FAMILY "MIPS32_R1 "
+#elif defined CONFIG_CPU_MIPS32_R2
+#define MODULE_PROC_FAMILY "MIPS32_R2 "
+#elif defined CONFIG_CPU_MIPS32_R6
+#define MODULE_PROC_FAMILY "MIPS32_R6 "
+#elif defined CONFIG_CPU_MIPS64_R1
+#define MODULE_PROC_FAMILY "MIPS64_R1 "
+#elif defined CONFIG_CPU_MIPS64_R2
+#define MODULE_PROC_FAMILY "MIPS64_R2 "
+#elif defined CONFIG_CPU_MIPS64_R6
+#define MODULE_PROC_FAMILY "MIPS64_R6 "
+#elif defined CONFIG_CPU_R3000
+#define MODULE_PROC_FAMILY "R3000 "
+#elif defined CONFIG_CPU_TX39XX
+#define MODULE_PROC_FAMILY "TX39XX "
+#elif defined CONFIG_CPU_VR41XX
+#define MODULE_PROC_FAMILY "VR41XX "
+#elif defined CONFIG_CPU_R4X00
+#define MODULE_PROC_FAMILY "R4X00 "
+#elif defined CONFIG_CPU_TX49XX
+#define MODULE_PROC_FAMILY "TX49XX "
+#elif defined CONFIG_CPU_R5000
+#define MODULE_PROC_FAMILY "R5000 "
+#elif defined CONFIG_CPU_R5500
+#define MODULE_PROC_FAMILY "R5500 "
+#elif defined CONFIG_CPU_NEVADA
+#define MODULE_PROC_FAMILY "NEVADA "
+#elif defined CONFIG_CPU_R10000
+#define MODULE_PROC_FAMILY "R10000 "
+#elif defined CONFIG_CPU_RM7000
+#define MODULE_PROC_FAMILY "RM7000 "
+#elif defined CONFIG_CPU_SB1
+#define MODULE_PROC_FAMILY "SB1 "
+#elif defined CONFIG_CPU_LOONGSON32
+#define MODULE_PROC_FAMILY "LOONGSON32 "
+#elif defined CONFIG_CPU_LOONGSON2EF
+#define MODULE_PROC_FAMILY "LOONGSON2EF "
+#elif defined CONFIG_CPU_LOONGSON64
+#define MODULE_PROC_FAMILY "LOONGSON64 "
+#elif defined CONFIG_CPU_CAVIUM_OCTEON
+#define MODULE_PROC_FAMILY "OCTEON "
+#elif defined CONFIG_CPU_XLR
+#define MODULE_PROC_FAMILY "XLR "
+#elif defined CONFIG_CPU_XLP
+#define MODULE_PROC_FAMILY "XLP "
+#else
+#error MODULE_PROC_FAMILY undefined for your processor configuration
+#endif
+
+#ifdef CONFIG_32BIT
+#define MODULE_KERNEL_TYPE "32BIT "
+#elif defined CONFIG_64BIT
+#define MODULE_KERNEL_TYPE "64BIT "
+#endif
+
+#define MODULE_ARCH_VERMAGIC \
+	MODULE_PROC_FAMILY MODULE_KERNEL_TYPE
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/nds32/include/asm/module.h b/arch/nds32/include/asm/vermagic.h
similarity index 52%
rename from arch/nds32/include/asm/module.h
rename to arch/nds32/include/asm/vermagic.h
index a3a08e993c65..f772e7ba33f1 100644
--- a/arch/nds32/include/asm/module.h
+++ b/arch/nds32/include/asm/vermagic.h
@@ -1,11 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2005-2017 Andes Technology Corporation
 
-#ifndef _ASM_NDS32_MODULE_H
-#define _ASM_NDS32_MODULE_H
-
-#include <asm-generic/module.h>
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
 
 #define MODULE_ARCH_VERMAGIC	"NDS32v3"
 
-#endif /* _ASM_NDS32_MODULE_H */
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index 356658711a86..5398bfc465b4 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -3,28 +3,10 @@
 #define _ASM_POWERPC_MODULE_H
 #ifdef __KERNEL__
 
-/*
- */
-
 #include <linux/list.h>
 #include <asm/bug.h>
 #include <asm-generic/module.h>
 
-
-#ifdef CONFIG_MPROFILE_KERNEL
-#define MODULE_ARCH_VERMAGIC_FTRACE	"mprofile-kernel "
-#else
-#define MODULE_ARCH_VERMAGIC_FTRACE	""
-#endif
-
-#ifdef CONFIG_RELOCATABLE
-#define MODULE_ARCH_VERMAGIC_RELOCATABLE	"relocatable "
-#else
-#define MODULE_ARCH_VERMAGIC_RELOCATABLE	""
-#endif
-
-#define MODULE_ARCH_VERMAGIC MODULE_ARCH_VERMAGIC_FTRACE MODULE_ARCH_VERMAGIC_RELOCATABLE
-
 #ifndef __powerpc64__
 /*
  * Thanks to Paul M for explaining this.
diff --git a/arch/powerpc/include/asm/vermagic.h b/arch/powerpc/include/asm/vermagic.h
new file mode 100644
index 000000000000..b054a8576e5d
--- /dev/null
+++ b/arch/powerpc/include/asm/vermagic.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#ifdef CONFIG_MPROFILE_KERNEL
+#define MODULE_ARCH_VERMAGIC_FTRACE	"mprofile-kernel "
+#else
+#define MODULE_ARCH_VERMAGIC_FTRACE	""
+#endif
+
+#ifdef CONFIG_RELOCATABLE
+#define MODULE_ARCH_VERMAGIC_RELOCATABLE	"relocatable "
+#else
+#define MODULE_ARCH_VERMAGIC_RELOCATABLE	""
+#endif
+
+#define MODULE_ARCH_VERMAGIC \
+		MODULE_ARCH_VERMAGIC_FTRACE MODULE_ARCH_VERMAGIC_RELOCATABLE
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
index 46202dad365d..76aa96a9fc08 100644
--- a/arch/riscv/include/asm/module.h
+++ b/arch/riscv/include/asm/module.h
@@ -6,8 +6,6 @@
 
 #include <asm-generic/module.h>
 
-#define MODULE_ARCH_VERMAGIC    "riscv"
-
 struct module;
 unsigned long module_emit_got_entry(struct module *mod, unsigned long val);
 unsigned long module_emit_plt_entry(struct module *mod, unsigned long val);
diff --git a/arch/riscv/include/asm/vermagic.h b/arch/riscv/include/asm/vermagic.h
new file mode 100644
index 000000000000..7b9441a57466
--- /dev/null
+++ b/arch/riscv/include/asm/vermagic.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2017 Andes Technology Corporation */
+
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#define MODULE_ARCH_VERMAGIC    "riscv"
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/sh/include/asm/module.h b/arch/sh/include/asm/module.h
index 9f38fb35fe96..337663a028db 100644
--- a/arch/sh/include/asm/module.h
+++ b/arch/sh/include/asm/module.h
@@ -11,32 +11,4 @@ struct mod_arch_specific {
 };
 #endif
 
-#ifdef CONFIG_CPU_LITTLE_ENDIAN
-# ifdef CONFIG_CPU_SH2
-#  define MODULE_PROC_FAMILY "SH2LE "
-# elif defined  CONFIG_CPU_SH3
-#  define MODULE_PROC_FAMILY "SH3LE "
-# elif defined  CONFIG_CPU_SH4
-#  define MODULE_PROC_FAMILY "SH4LE "
-# elif defined  CONFIG_CPU_SH5
-#  define MODULE_PROC_FAMILY "SH5LE "
-# else
-#  error unknown processor family
-# endif
-#else
-# ifdef CONFIG_CPU_SH2
-#  define MODULE_PROC_FAMILY "SH2BE "
-# elif defined  CONFIG_CPU_SH3
-#  define MODULE_PROC_FAMILY "SH3BE "
-# elif defined  CONFIG_CPU_SH4
-#  define MODULE_PROC_FAMILY "SH4BE "
-# elif defined  CONFIG_CPU_SH5
-#  define MODULE_PROC_FAMILY "SH5BE "
-# else
-#  error unknown processor family
-# endif
-#endif
-
-#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY
-
 #endif /* _ASM_SH_MODULE_H */
diff --git a/arch/sh/include/asm/vermagic.h b/arch/sh/include/asm/vermagic.h
new file mode 100644
index 000000000000..13d8eaa9188e
--- /dev/null
+++ b/arch/sh/include/asm/vermagic.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+# ifdef CONFIG_CPU_SH2
+#  define MODULE_PROC_FAMILY "SH2LE "
+# elif defined  CONFIG_CPU_SH3
+#  define MODULE_PROC_FAMILY "SH3LE "
+# elif defined  CONFIG_CPU_SH4
+#  define MODULE_PROC_FAMILY "SH4LE "
+# elif defined  CONFIG_CPU_SH5
+#  define MODULE_PROC_FAMILY "SH5LE "
+# else
+#  error unknown processor family
+# endif
+#else
+# ifdef CONFIG_CPU_SH2
+#  define MODULE_PROC_FAMILY "SH2BE "
+# elif defined  CONFIG_CPU_SH3
+#  define MODULE_PROC_FAMILY "SH3BE "
+# elif defined  CONFIG_CPU_SH4
+#  define MODULE_PROC_FAMILY "SH4BE "
+# elif defined  CONFIG_CPU_SH5
+#  define MODULE_PROC_FAMILY "SH5BE "
+# else
+#  error unknown processor family
+# endif
+#endif
+
+#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/x86/include/asm/module.h b/arch/x86/include/asm/module.h
index c215d2762488..e988bac0a4a1 100644
--- a/arch/x86/include/asm/module.h
+++ b/arch/x86/include/asm/module.h
@@ -13,64 +13,4 @@ struct mod_arch_specific {
 #endif
 };
 
-#ifdef CONFIG_X86_64
-/* X86_64 does not define MODULE_PROC_FAMILY */
-#elif defined CONFIG_M486SX
-#define MODULE_PROC_FAMILY "486SX "
-#elif defined CONFIG_M486
-#define MODULE_PROC_FAMILY "486 "
-#elif defined CONFIG_M586
-#define MODULE_PROC_FAMILY "586 "
-#elif defined CONFIG_M586TSC
-#define MODULE_PROC_FAMILY "586TSC "
-#elif defined CONFIG_M586MMX
-#define MODULE_PROC_FAMILY "586MMX "
-#elif defined CONFIG_MCORE2
-#define MODULE_PROC_FAMILY "CORE2 "
-#elif defined CONFIG_MATOM
-#define MODULE_PROC_FAMILY "ATOM "
-#elif defined CONFIG_M686
-#define MODULE_PROC_FAMILY "686 "
-#elif defined CONFIG_MPENTIUMII
-#define MODULE_PROC_FAMILY "PENTIUMII "
-#elif defined CONFIG_MPENTIUMIII
-#define MODULE_PROC_FAMILY "PENTIUMIII "
-#elif defined CONFIG_MPENTIUMM
-#define MODULE_PROC_FAMILY "PENTIUMM "
-#elif defined CONFIG_MPENTIUM4
-#define MODULE_PROC_FAMILY "PENTIUM4 "
-#elif defined CONFIG_MK6
-#define MODULE_PROC_FAMILY "K6 "
-#elif defined CONFIG_MK7
-#define MODULE_PROC_FAMILY "K7 "
-#elif defined CONFIG_MK8
-#define MODULE_PROC_FAMILY "K8 "
-#elif defined CONFIG_MELAN
-#define MODULE_PROC_FAMILY "ELAN "
-#elif defined CONFIG_MCRUSOE
-#define MODULE_PROC_FAMILY "CRUSOE "
-#elif defined CONFIG_MEFFICEON
-#define MODULE_PROC_FAMILY "EFFICEON "
-#elif defined CONFIG_MWINCHIPC6
-#define MODULE_PROC_FAMILY "WINCHIPC6 "
-#elif defined CONFIG_MWINCHIP3D
-#define MODULE_PROC_FAMILY "WINCHIP3D "
-#elif defined CONFIG_MCYRIXIII
-#define MODULE_PROC_FAMILY "CYRIXIII "
-#elif defined CONFIG_MVIAC3_2
-#define MODULE_PROC_FAMILY "VIAC3-2 "
-#elif defined CONFIG_MVIAC7
-#define MODULE_PROC_FAMILY "VIAC7 "
-#elif defined CONFIG_MGEODEGX1
-#define MODULE_PROC_FAMILY "GEODEGX1 "
-#elif defined CONFIG_MGEODE_LX
-#define MODULE_PROC_FAMILY "GEODE "
-#else
-#error unknown processor family
-#endif
-
-#ifdef CONFIG_X86_32
-# define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY
-#endif
-
 #endif /* _ASM_X86_MODULE_H */
diff --git a/arch/x86/include/asm/vermagic.h b/arch/x86/include/asm/vermagic.h
new file mode 100644
index 000000000000..75884d2cdec3
--- /dev/null
+++ b/arch/x86/include/asm/vermagic.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
+
+#ifdef CONFIG_X86_64
+/* X86_64 does not define MODULE_PROC_FAMILY */
+#elif defined CONFIG_M486SX
+#define MODULE_PROC_FAMILY "486SX "
+#elif defined CONFIG_M486
+#define MODULE_PROC_FAMILY "486 "
+#elif defined CONFIG_M586
+#define MODULE_PROC_FAMILY "586 "
+#elif defined CONFIG_M586TSC
+#define MODULE_PROC_FAMILY "586TSC "
+#elif defined CONFIG_M586MMX
+#define MODULE_PROC_FAMILY "586MMX "
+#elif defined CONFIG_MCORE2
+#define MODULE_PROC_FAMILY "CORE2 "
+#elif defined CONFIG_MATOM
+#define MODULE_PROC_FAMILY "ATOM "
+#elif defined CONFIG_M686
+#define MODULE_PROC_FAMILY "686 "
+#elif defined CONFIG_MPENTIUMII
+#define MODULE_PROC_FAMILY "PENTIUMII "
+#elif defined CONFIG_MPENTIUMIII
+#define MODULE_PROC_FAMILY "PENTIUMIII "
+#elif defined CONFIG_MPENTIUMM
+#define MODULE_PROC_FAMILY "PENTIUMM "
+#elif defined CONFIG_MPENTIUM4
+#define MODULE_PROC_FAMILY "PENTIUM4 "
+#elif defined CONFIG_MK6
+#define MODULE_PROC_FAMILY "K6 "
+#elif defined CONFIG_MK7
+#define MODULE_PROC_FAMILY "K7 "
+#elif defined CONFIG_MK8
+#define MODULE_PROC_FAMILY "K8 "
+#elif defined CONFIG_MELAN
+#define MODULE_PROC_FAMILY "ELAN "
+#elif defined CONFIG_MCRUSOE
+#define MODULE_PROC_FAMILY "CRUSOE "
+#elif defined CONFIG_MEFFICEON
+#define MODULE_PROC_FAMILY "EFFICEON "
+#elif defined CONFIG_MWINCHIPC6
+#define MODULE_PROC_FAMILY "WINCHIPC6 "
+#elif defined CONFIG_MWINCHIP3D
+#define MODULE_PROC_FAMILY "WINCHIP3D "
+#elif defined CONFIG_MCYRIXIII
+#define MODULE_PROC_FAMILY "CYRIXIII "
+#elif defined CONFIG_MVIAC3_2
+#define MODULE_PROC_FAMILY "VIAC3-2 "
+#elif defined CONFIG_MVIAC7
+#define MODULE_PROC_FAMILY "VIAC7 "
+#elif defined CONFIG_MGEODEGX1
+#define MODULE_PROC_FAMILY "GEODEGX1 "
+#elif defined CONFIG_MGEODE_LX
+#define MODULE_PROC_FAMILY "GEODE "
+#else
+#error unknown processor family
+#endif
+
+#ifdef CONFIG_X86_32
+# define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY
+#else
+# define MODULE_ARCH_VERMAGIC ""
+#endif
+
+#endif /* _ASM_VERMAGIC_H */
diff --git a/arch/xtensa/include/asm/module.h b/arch/xtensa/include/asm/vermagic.h
similarity index 72%
rename from arch/xtensa/include/asm/module.h
rename to arch/xtensa/include/asm/vermagic.h
index 488b40c6f9b9..6f9e359a54ac 100644
--- a/arch/xtensa/include/asm/module.h
+++ b/arch/xtensa/include/asm/vermagic.h
@@ -1,6 +1,4 @@
 /*
- * include/asm-xtensa/module.h
- *
  * This file contains the module code specific to the Xtensa architecture.
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -10,11 +8,12 @@
  * Copyright (C) 2001 - 2005 Tensilica Inc.
  */
 
-#ifndef _XTENSA_MODULE_H
-#define _XTENSA_MODULE_H
+#ifndef _ASM_VERMAGIC_H
+#define _ASM_VERMAGIC_H
 
-#define MODULE_ARCH_VERMAGIC "xtensa-" __stringify(XCHAL_CORE_ID) " "
+#include <linux/stringify.h>
+#include <variant/core.h>
 
-#include <asm-generic/module.h>
+#define MODULE_ARCH_VERMAGIC "xtensa-" __stringify(XCHAL_CORE_ID) " "
 
-#endif	/* _XTENSA_MODULE_H */
+#endif	/* _ASM_VERMAGIC_H */
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 36341dfded70..44ec80e70518 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -56,6 +56,7 @@ mandatory-y += topology.h
 mandatory-y += trace_clock.h
 mandatory-y += uaccess.h
 mandatory-y += unaligned.h
+mandatory-y += vermagic.h
 mandatory-y += vga.h
 mandatory-y += word-at-a-time.h
 mandatory-y += xor.h
diff --git a/include/asm-generic/vermagic.h b/include/asm-generic/vermagic.h
new file mode 100644
index 000000000000..084274a1219e
--- /dev/null
+++ b/include/asm-generic/vermagic.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_GENERIC_VERMAGIC_H
+#define _ASM_GENERIC_VERMAGIC_H
+
+#define MODULE_ARCH_VERMAGIC ""
+
+#endif /* _ASM_GENERIC_VERMAGIC_H */
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index 9aced11e9000..dc236577b92f 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -1,5 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VERMAGIC_H
+#define _LINUX_VERMAGIC_H
+
 #include <generated/utsrelease.h>
+#include <asm/vermagic.h>
 
 /* Simply sanity version stamp for modules. */
 #ifdef CONFIG_SMP
@@ -24,9 +28,6 @@
 #else
 #define MODULE_VERMAGIC_MODVERSIONS ""
 #endif
-#ifndef MODULE_ARCH_VERMAGIC
-#define MODULE_ARCH_VERMAGIC ""
-#endif
 #ifdef RANDSTRUCT_PLUGIN
 #include <generated/randomize_layout_hash.h>
 #define MODULE_RANDSTRUCT_PLUGIN "RANDSTRUCT_PLUGIN_" RANDSTRUCT_HASHED_SEED
@@ -41,3 +42,4 @@
 	MODULE_ARCH_VERMAGIC						\
 	MODULE_RANDSTRUCT_PLUGIN
 
+#endif /* _LINUX_VERMAGIC_H */
-- 
2.25.1


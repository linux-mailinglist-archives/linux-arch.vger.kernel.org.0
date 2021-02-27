Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1388F326E4D
	for <lists+linux-arch@lfdr.de>; Sat, 27 Feb 2021 18:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhB0RPe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Feb 2021 12:15:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:57209 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhB0RKj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Feb 2021 12:10:39 -0500
IronPort-SDR: PirgmHn7xyLTuNT/IUZ6dMTaJj27glakKmRYH7hFT8BP1vU/qXA6rTEh0qMLzJ7apBGnya1GR1
 um+HnXxoy40A==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="205700332"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="205700332"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 09:03:58 -0800
IronPort-SDR: 4+f4u1i75SajTtUtIQTGOiFmZpHuAZXhUDTjcei9hbNrkCywKnEqqAu777JL+gWM6dHrT9hLqd
 VPZPV04x8Zvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="503906848"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2021 09:03:58 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH v6 3/6] x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
Date:   Sat, 27 Feb 2021 08:59:08 -0800
Message-Id: <20210227165911.32757-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210227165911.32757-1-chang.seok.bae@intel.com>
References: <20210227165911.32757-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Historically, signal.h defines MINSIGSTKSZ (2KB) and SIGSTKSZ (8KB), for
use by all architectures with sigaltstack(2). Over time, the hardware state
size grew, but these constants did not evolve. Today, literal use of these
constants on several architectures may result in signal stack overflow, and
thus user data corruption.

A few years ago, the ARM team addressed this issue by establishing
getauxval(AT_MINSIGSTKSZ). This enables the kernel to supply at runtime
value that is an appropriate replacement on the current and future
hardware.

Add getauxval(AT_MINSIGSTKSZ) support to x86, analogous to the support
added for ARM in commit 94b07c1f8c39 ("arm64: signal: Report signal frame
size to userspace via auxv").

Also, include a documentation to describe x86-specific auxiliary vectors.

Reported-by: Florian Weimer <fweimer@redhat.com>
Fixes: c2bc11f10a39 ("x86, AVX-512: Enable AVX-512 States Context Switch")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: H.J. Lu <hjl.tools@gmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: x86@kernel.org
Cc: libc-alpha@sourceware.org
Cc: linux-arch@vger.kernel.org
Cc: linux-api@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=153531
---
Changes from v5:
* Added a documentation.
---
 Documentation/x86/elf_auxvec.rst   | 56 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/elf.h         |  4 +++
 arch/x86/include/uapi/asm/auxvec.h |  4 +--
 arch/x86/kernel/signal.c           |  5 +++
 4 files changed, 67 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/x86/elf_auxvec.rst

diff --git a/Documentation/x86/elf_auxvec.rst b/Documentation/x86/elf_auxvec.rst
new file mode 100644
index 000000000000..751c552c4048
--- /dev/null
+++ b/Documentation/x86/elf_auxvec.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+x86-specific ELF Auxiliary Vectors
+==================================
+
+This document describes the semantics of the x86 auxiliary vectors.
+
+1. Introduction
+---------------
+
+ELF Auxiliary vectors enable the kernel to efficiently provide
+configuration specific parameters to userspace. In this example, a program
+allocates an alternate stack based on the kernel-provided size.
+
+   #include <sys/auxv.h>
+   #include <elf.h>
+
+   #ifndef AT_MINSIGSTKSZ
+   #define AT_MINSIGSTKSZ	51
+   #endif
+
+   stack_t ss;
+   int err;
+
+   ss.ss_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
+   ss.ss_sp = malloc(ss.ss_size);
+   ...
+
+   err = sigaltstack(&ss, NULL);
+   ...
+
+
+2. The exposed auxiliary vectors
+---------------------------------
+
+AT_SYSINFO
+    The entry point to the system call function the virtual Dynamic Shared
+    Object (vDSO), not exported on 64-bit.
+
+AT_SYSINFO_EHDR
+    The start address of the page containing vDSO.
+
+AT_MINSIGSTKSZ
+    The minimum stack size required to deliver a signal. It is a calculated
+    sigframe size based on the largest possible user context. When programs
+    use sigaltstack() to provide alternate signal stack, that stack must be
+    at least the size to function properly on this hardware. Note that this
+    is a minimum of the kernel to correctly get to the signal handler.
+    Additional space must be added to handle objects pushed onto the stack
+    by the signal handlers, as well as for nested signal delivery.
+
+    The purpose of this parameter is to accommodate the different stack
+    sizes required by different hardware configuration. E.g., the x86
+    system supporting the Advanced Vector Extension needs at least 8KB more
+    than the one without it.
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 66bdfe838d61..cd10795c178e 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -312,6 +312,7 @@ do {									\
 		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);			\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_CURRENT_BASE);	\
 	}								\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
 } while (0)
 
 /*
@@ -328,6 +329,7 @@ extern unsigned long task_size_32bit(void);
 extern unsigned long task_size_64bit(int full_addr_space);
 extern unsigned long get_mmap_base(int is_legacy);
 extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
+extern unsigned long get_sigframe_size(void);
 
 #ifdef CONFIG_X86_32
 
@@ -349,6 +351,7 @@ do {									\
 	if (vdso64_enabled)						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 			    (unsigned long __force)current->mm->context.vdso); \
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
 } while (0)
 
 /* As a historical oddity, the x32 and x86_64 vDSOs are controlled together. */
@@ -357,6 +360,7 @@ do {									\
 	if (vdso64_enabled)						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 			    (unsigned long __force)current->mm->context.vdso); \
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
 } while (0)
 
 #define AT_SYSINFO		32
diff --git a/arch/x86/include/uapi/asm/auxvec.h b/arch/x86/include/uapi/asm/auxvec.h
index 580e3c567046..6beb55bbefa4 100644
--- a/arch/x86/include/uapi/asm/auxvec.h
+++ b/arch/x86/include/uapi/asm/auxvec.h
@@ -12,9 +12,9 @@
 
 /* entries in ARCH_DLINFO: */
 #if defined(CONFIG_IA32_EMULATION) || !defined(CONFIG_X86_64)
-# define AT_VECTOR_SIZE_ARCH 2
+# define AT_VECTOR_SIZE_ARCH 3
 #else /* else it's non-compat x86-64 */
-# define AT_VECTOR_SIZE_ARCH 1
+# define AT_VECTOR_SIZE_ARCH 2
 #endif
 
 #endif /* _ASM_X86_AUXVEC_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 800243afd1ef..0d24f64d0145 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -716,6 +716,11 @@ void __init init_sigframe_size(void)
 	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);
 }
 
+unsigned long get_sigframe_size(void)
+{
+	return max_frame_size;
+}
+
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
 	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
-- 
2.17.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4AD3678F5
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 06:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhDVEyz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 00:54:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:45532 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhDVEyw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 00:54:52 -0400
IronPort-SDR: Ourq/tovdnwffCLF2GT9hShRxTmxnUZA7NBH1JGOSeD70PUg/md5x0m/3OADgxGn+elh5qMdnY
 K+J0qSXwj1sg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="183311516"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="183311516"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 21:54:16 -0700
IronPort-SDR: qdKqGUa0FHzHAbRHJdzWhsII7wvPIbJDqxO8e8yCnveqsTJQtYEyYpyYgcbsGka8lA0BDodrKG
 0kkgNeMy5MRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="524515410"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2021 21:54:15 -0700
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
Subject: [PATCH v8 3/6] x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
Date:   Wed, 21 Apr 2021 21:48:53 -0700
Message-Id: <20210422044856.27250-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210422044856.27250-1-chang.seok.bae@intel.com>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
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
---
Changes from v7:
* Delegated the bugfix notion to the other patch.

Changes from v6:
* Revised the documentation and fixed the build issue. (Borislav Petkov)
* Fixed the vertical alignment of '\'. (Borislav Petkov)

Changes from v5:
* Added a documentation.
---
 Documentation/x86/elf_auxvec.rst   | 53 ++++++++++++++++++++++++++++++
 Documentation/x86/index.rst        |  1 +
 arch/x86/include/asm/elf.h         |  4 +++
 arch/x86/include/uapi/asm/auxvec.h |  4 +--
 arch/x86/kernel/signal.c           |  5 +++
 5 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/x86/elf_auxvec.rst

diff --git a/Documentation/x86/elf_auxvec.rst b/Documentation/x86/elf_auxvec.rst
new file mode 100644
index 000000000000..6c75b26f5efb
--- /dev/null
+++ b/Documentation/x86/elf_auxvec.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+x86-specific ELF Auxiliary Vectors
+==================================
+
+This document describes the semantics of the x86 auxiliary vectors.
+
+Introduction
+============
+
+ELF Auxiliary vectors enable the kernel to efficiently provide
+configuration specific parameters to userspace. In this example, a program
+allocates an alternate stack based on the kernel-provided size::
+
+   #include <sys/auxv.h>
+   #include <elf.h>
+   #include <signal.h>
+   #include <stdlib.h>
+   #include <assert.h>
+   #include <err.h>
+
+   #ifndef AT_MINSIGSTKSZ
+   #define AT_MINSIGSTKSZ	51
+   #endif
+
+   ....
+   stack_t ss;
+
+   ss.ss_sp = malloc(ss.ss_size);
+   assert(ss.ss_sp);
+
+   ss.ss_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
+   ss.ss_flags = 0;
+
+   if (sigaltstack(&ss, NULL))
+        err(1, "sigaltstack");
+
+
+The exposed auxiliary vectors
+=============================
+
+AT_SYSINFO is used for locating the vsyscall entry point.  It is not
+exported on 64-bit mode.
+
+AT_SYSINFO_EHDR is the start address of the page containing the vDSO.
+
+AT_MINSIGSTKSZ denotes the minimum stack size required by the kernel to
+deliver a signal to user-space.  AT_MINSIGSTKSZ comprehends the space
+consumed by the kernel to accommodate the user context for the current
+hardware configuration.  It does not comprehend subsequent user-space stack
+consumption, which must be added by the user.  (e.g. Above, user-space adds
+SIGSTKSZ to AT_MINSIGSTKSZ.)
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 4693e192b447..d58614d5cde6 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -35,3 +35,4 @@ x86-specific Documentation
    sva
    sgx
    features
+   elf_auxvec
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 9224d40cdefe..18d9b1117871 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -312,6 +312,7 @@ do {									\
 		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);			\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_CURRENT_BASE);	\
 	}								\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());		\
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
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());		\
 } while (0)
 
 /* As a historical oddity, the x32 and x86_64 vDSOs are controlled together. */
@@ -357,6 +360,7 @@ do {									\
 	if (vdso64_enabled)						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 			    (unsigned long __force)current->mm->context.vdso); \
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());		\
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
index bf1e83d79326..ca8fd18fba1f 100644
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


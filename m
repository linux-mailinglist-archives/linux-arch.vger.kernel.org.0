Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A327D990
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgI2VCA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:02:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:60573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbgI2VBv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Sep 2020 17:01:51 -0400
IronPort-SDR: YfTyMfrbguWZmnCuRGV4SOXMdINRAy6uJ0kLele/ysjaM9MC5uf8lFGWn6Z8yvDP96OnAZEzFp
 ofY45jg1Aseg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="149947658"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="149947658"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 14:01:23 -0700
IronPort-SDR: xLvnenyORWIZmPprRiCX1izRF7kqy5wrzHxD/KHxNIyKhTIns+BNG/UChh/Lz0XXN/pzrKHNCj
 1Xgig24QjiHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="514024813"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga006.fm.intel.com with ESMTP; 29 Sep 2020 14:01:22 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, mpe@ellerman.id.au, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 2/4] x86/elf: Support a new ELF aux vector AT_MINSIGSTKSZ
Date:   Tue, 29 Sep 2020 13:57:44 -0700
Message-Id: <20200929205746.6763-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929205746.6763-1-chang.seok.bae@intel.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Historically, signal.h defines MINSIGSTKSZ (2KB) and SIGSTKSZ (8KB), for
use by all architectures with sigaltstack(2). Over time, the hardware state
size grew, but these constants did not evolve. Today, literal use of these
constants on several architectures may result in signal stack overflow, and
thus user data corruption.

A few years ago, the ARM team addressed this issue by establishing
getauxval(AT_MINSIGSTKSZ), such that the kernel can supply at runtime value
that is an appropriate replacement on the current and future hardware.

Add getauxval(AT_MINSIGSTKSZ) support to x86, analogous to the support
added for ARM in commit 94b07c1f8c39 ("arm64: signal: Report signal frame
size to userspace via auxv").

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
Cc: linux-kernel@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=153531
---
 arch/x86/include/asm/elf.h         | 4 ++++
 arch/x86/include/uapi/asm/auxvec.h | 6 ++++--
 arch/x86/kernel/signal.c           | 5 +++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index b9a5d488f1a5..044b024abea1 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -311,6 +311,7 @@ do {									\
 		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);			\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_CURRENT_BASE);	\
 	}								\
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
 } while (0)
 
 /*
@@ -327,6 +328,7 @@ extern unsigned long task_size_32bit(void);
 extern unsigned long task_size_64bit(int full_addr_space);
 extern unsigned long get_mmap_base(int is_legacy);
 extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
+extern unsigned long get_sigframe_size(void);
 
 #ifdef CONFIG_X86_32
 
@@ -348,6 +350,7 @@ do {									\
 	if (vdso64_enabled)						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 			    (unsigned long __force)current->mm->context.vdso); \
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
 } while (0)
 
 /* As a historical oddity, the x32 and x86_64 vDSOs are controlled together. */
@@ -356,6 +359,7 @@ do {									\
 	if (vdso64_enabled)						\
 		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 			    (unsigned long __force)current->mm->context.vdso); \
+	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
 } while (0)
 
 #define AT_SYSINFO		32
diff --git a/arch/x86/include/uapi/asm/auxvec.h b/arch/x86/include/uapi/asm/auxvec.h
index 580e3c567046..edd7808060e6 100644
--- a/arch/x86/include/uapi/asm/auxvec.h
+++ b/arch/x86/include/uapi/asm/auxvec.h
@@ -10,11 +10,13 @@
 #endif
 #define AT_SYSINFO_EHDR		33
 
+#define AT_MINSIGSTKSZ		51
+
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
index 239a0b23a4b0..2a313d34ec49 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -708,6 +708,11 @@ void __init init_sigframe_size(void)
 	max_frame_size += fpu__get_fpstate_sigframe_size() + MAX_XSAVE_PADDING;
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


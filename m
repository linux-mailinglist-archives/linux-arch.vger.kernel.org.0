Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC04633CE34
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 07:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhCPG5p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 02:57:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:44607 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235769AbhCPG5N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 02:57:13 -0400
IronPort-SDR: BzopSCgqqjD9FUPkAm9OGV5/C5fFZREOPbE9T3MSac0OkphZmz8jyB3KLoFuYEmlVqkdszGASz
 98ZC7+7wC/9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253227832"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="253227832"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 23:57:12 -0700
IronPort-SDR: QDtTWaXEVK1zPnbQp+ZWu+Ef+lmjTDBtdmzHTL47mYiwsZgqK14FK3x5r6av65DHb+404k1htU
 e1u63ExRGjag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="511296076"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 15 Mar 2021 23:57:11 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, jannh@google.com, mpe@ellerman.id.au,
        carlos@redhat.com, tony.luck@intel.com, ravi.v.shankar@intel.com,
        libc-alpha@sourceware.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v7 2/6] x86/signal: Introduce helpers to get the maximum signal frame size
Date:   Mon, 15 Mar 2021 23:52:11 -0700
Message-Id: <20210316065215.23768-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210316065215.23768-1-chang.seok.bae@intel.com>
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signal frames do not have a fixed format and can vary in size when a number
of things change: support XSAVE features, 32 vs. 64-bit apps. Add the code
to support a runtime method for userspace to dynamically discover how large
a signal stack needs to be.

Introduce a new variable, max_frame_size, and helper functions for the
calculation to be used in a new user interface. Set max_frame_size to a
system-wide worst-case value, instead of storing multiple app-specific
values.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: H.J. Lu <hjl.tools@gmail.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Renamed the fpstate size helper with cleanup (Borislav Petkov)
* Moved the sigframe struct size defines to where used (Borislav Petkov)
* Removed unneeded sentence in the changelog (Borislav Petkov)

Change from v1:
* Took stack alignment into account for sigframe size (Dave Martin)
---
 arch/x86/include/asm/fpu/signal.h |  2 ++
 arch/x86/include/asm/sigframe.h   |  2 ++
 arch/x86/kernel/cpu/common.c      |  3 ++
 arch/x86/kernel/fpu/signal.c      | 19 +++++++++++
 arch/x86/kernel/signal.c          | 57 +++++++++++++++++++++++++++++--
 5 files changed, 81 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 7fb516b6893a..8b6631dffefd 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -29,6 +29,8 @@ unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size);
 
+unsigned long fpu__get_fpstate_size(void);
+
 extern void fpu__init_prepare_fx_sw_frame(void);
 
 #endif /* _ASM_X86_FPU_SIGNAL_H */
diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index 84eab2724875..5b1ed650b124 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -85,4 +85,6 @@ struct rt_sigframe_x32 {
 
 #endif /* CONFIG_X86_64 */
 
+void __init init_sigframe_size(void);
+
 #endif /* _ASM_X86_SIGFRAME_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ab640abe26b6..c49ef3ad34dc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -58,6 +58,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/sigframe.h>
 
 #include "cpu.h"
 
@@ -1334,6 +1335,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	fpu__init_system(c);
 
+	init_sigframe_size();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a4ec65317a7f..dbb304e48f16 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -507,6 +507,25 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 	return sp;
 }
+
+unsigned long fpu__get_fpstate_size(void)
+{
+	unsigned long ret = xstate_sigframe_size();
+
+	/*
+	 * This space is needed on (most) 32-bit kernels, or when a 32-bit
+	 * app is running on a 64-bit kernel. To keep things simple, just
+	 * assume the worst case and always include space for 'freg_state',
+	 * even for 64-bit apps on 64-bit kernels. This wastes a bit of
+	 * space, but keeps the code simple.
+	 */
+	if ((IS_ENABLED(CONFIG_IA32_EMULATION) ||
+	     IS_ENABLED(CONFIG_X86_32)) && use_fxsr())
+		ret += sizeof(struct fregs_state);
+
+	return ret;
+}
+
 /*
  * Prepare the SW reserved portion of the fxsave memory layout, indicating
  * the presence of the extended state information in the memory layout
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ea794a083c44..800243afd1ef 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -212,6 +212,11 @@ do {									\
  * Set up a signal frame.
  */
 
+/* x86 ABI requires 16-byte alignment */
+#define FRAME_ALIGNMENT	16UL
+
+#define MAX_FRAME_PADDING	(FRAME_ALIGNMENT - 1)
+
 /*
  * Determine which stack to use..
  */
@@ -222,9 +227,9 @@ static unsigned long align_sigframe(unsigned long sp)
 	 * Align the stack pointer according to the i386 ABI,
 	 * i.e. so that on function entry ((sp + 4) & 15) == 0.
 	 */
-	sp = ((sp + 4) & -16ul) - 4;
+	sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
 #else /* !CONFIG_X86_32 */
-	sp = round_down(sp, 16) - 8;
+	sp = round_down(sp, FRAME_ALIGNMENT) - 8;
 #endif
 	return sp;
 }
@@ -663,6 +668,54 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return 0;
 }
 
+/*
+ * There are four different struct types for signal frame: sigframe_ia32,
+ * rt_sigframe_ia32, rt_sigframe_x32, and rt_sigframe. Use the worst case
+ * -- the largest size. It means the size for 64-bit apps is a bit more
+ * than needed, but this keeps the code simple.
+ */
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+# define MAX_FRAME_SIGINFO_UCTXT_SIZE	sizeof(struct sigframe_ia32)
+#else
+# define MAX_FRAME_SIGINFO_UCTXT_SIZE	sizeof(struct rt_sigframe)
+#endif
+
+/*
+ * The FP state frame contains an XSAVE buffer which must be 64-byte aligned.
+ * If a signal frame starts at an unaligned address, extra space is required.
+ * This is the max alignment padding, conservatively.
+ */
+#define MAX_XSAVE_PADDING	63UL
+
+/*
+ * The frame data is composed of the following areas and laid out as:
+ *
+ * -------------------------
+ * | alignment padding     |
+ * -------------------------
+ * | (f)xsave frame        |
+ * -------------------------
+ * | fsave header          |
+ * -------------------------
+ * | alignment padding     |
+ * -------------------------
+ * | siginfo + ucontext    |
+ * -------------------------
+ */
+
+/* max_frame_size tells userspace the worst case signal stack size. */
+static unsigned long __ro_after_init max_frame_size;
+
+void __init init_sigframe_size(void)
+{
+	max_frame_size = MAX_FRAME_SIGINFO_UCTXT_SIZE + MAX_FRAME_PADDING;
+
+	max_frame_size += fpu__get_fpstate_size() + MAX_XSAVE_PADDING;
+
+	/* Userspace expects an aligned size. */
+	max_frame_size = round_up(max_frame_size, FRAME_ALIGNMENT);
+}
+
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
 	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
-- 
2.17.1


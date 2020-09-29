Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF62427D992
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgI2VBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:01:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:60573 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbgI2VBp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Sep 2020 17:01:45 -0400
IronPort-SDR: n8W0OCJLb/60tdjioq91xS66Kp0kw65wcLCZXNZofvQ9Jun/cMsv4xDffo7N7UFF3rmQkYC9Qv
 RlSk5mOhFF8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="149947657"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="149947657"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 14:01:23 -0700
IronPort-SDR: VS3vL4SKHXpAtfklpP5FNf6dKd6xCFeE0RBTUi3A3hTIteGHYUaB2vp2lUr/uvuY6aEfbfuAg5
 GFuzNYoWkYOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="514024810"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga006.fm.intel.com with ESMTP; 29 Sep 2020 14:01:22 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, mingo@kernel.org, bp@suse.de, luto@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, hjl.tools@gmail.com,
        Dave.Martin@arm.com, mpe@ellerman.id.au, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
Subject: [RFC PATCH 1/4] x86/signal: Introduce helpers to get the maximum signal frame size
Date:   Tue, 29 Sep 2020 13:57:43 -0700
Message-Id: <20200929205746.6763-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929205746.6763-1-chang.seok.bae@intel.com>
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
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

Locate the body of the helper function -- fpu__get_fpstate_sigframe_size()
in fpu/signal.c for its relevance.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/fpu/signal.h |  2 ++
 arch/x86/include/asm/sigframe.h   | 23 ++++++++++++++++
 arch/x86/kernel/cpu/common.c      |  3 +++
 arch/x86/kernel/fpu/signal.c      | 20 ++++++++++++++
 arch/x86/kernel/signal.c          | 45 +++++++++++++++++++++++++++++++
 5 files changed, 93 insertions(+)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 7fb516b6893a..5bfbf8f2e5a3 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -29,6 +29,8 @@ unsigned long
 fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 		     unsigned long *buf_fx, unsigned long *size);
 
+unsigned long fpu__get_fpstate_sigframe_size(void);
+
 extern void fpu__init_prepare_fx_sw_frame(void);
 
 #endif /* _ASM_X86_FPU_SIGNAL_H */
diff --git a/arch/x86/include/asm/sigframe.h b/arch/x86/include/asm/sigframe.h
index 84eab2724875..ac77f3f90bc9 100644
--- a/arch/x86/include/asm/sigframe.h
+++ b/arch/x86/include/asm/sigframe.h
@@ -52,6 +52,15 @@ struct rt_sigframe_ia32 {
 	char retcode[8];
 	/* fp state follows here */
 };
+
+#define SIZEOF_sigframe_ia32	sizeof(struct sigframe_ia32)
+#define SIZEOF_rt_sigframe_ia32	sizeof(struct rt_sigframe_ia32)
+
+#else
+
+#define SIZEOF_sigframe_ia32	0
+#define SIZEOF_rt_sigframe_ia32	0
+
 #endif /* defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION) */
 
 #ifdef CONFIG_X86_64
@@ -81,8 +90,22 @@ struct rt_sigframe_x32 {
 	/* fp state follows here */
 };
 
+#define SIZEOF_rt_sigframe_x32	sizeof(struct rt_sigframe_x32)
+
 #endif /* CONFIG_X86_X32_ABI */
 
+#define SIZEOF_rt_sigframe	sizeof(struct rt_sigframe)
+
+#else
+
+#define SIZEOF_rt_sigframe	0
+
 #endif /* CONFIG_X86_64 */
 
+#ifndef SIZEOF_rt_sigframe_x32
+#define SIZEOF_rt_sigframe_x32	0
+#endif
+
+void __init init_sigframe_size(void);
+
 #endif /* _ASM_X86_SIGFRAME_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c5d6f17d9b9d..d0363e15ec2e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -57,6 +57,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/sigframe.h>
 
 #include "cpu.h"
 
@@ -1276,6 +1277,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	fpu__init_system(c);
 
+	init_sigframe_size();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Regardless of whether PCID is enumerated, the SDM says
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index a4ec65317a7f..9f009525f551 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -507,6 +507,26 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 	return sp;
 }
+
+unsigned long fpu__get_fpstate_sigframe_size(void)
+{
+	unsigned long xstate_size = xstate_sigframe_size();
+	unsigned long fsave_header_size = 0;
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
+		fsave_header_size = sizeof(struct fregs_state);
+
+	return fsave_header_size + xstate_size;
+}
+
 /*
  * Prepare the SW reserved portion of the fxsave memory layout, indicating
  * the presence of the extended state information in the memory layout
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index be0d7d4152ec..239a0b23a4b0 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -663,6 +663,51 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return 0;
 }
 
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
+ * | siginfo + ucontext    |
+ * -------------------------
+ */
+
+/* max_frame_size tells userspace the worst case signal stack size. */
+static unsigned long __ro_after_init max_frame_size;
+
+void __init init_sigframe_size(void)
+{
+	/*
+	 * Use the largest of possible structure formats. This might
+	 * slightly oversize the frame for 64-bit apps.
+	 */
+
+	if (IS_ENABLED(CONFIG_X86_32) ||
+	    IS_ENABLED(CONFIG_IA32_EMULATION))
+		max_frame_size = max((unsigned long)SIZEOF_sigframe_ia32,
+				     (unsigned long)SIZEOF_rt_sigframe_ia32);
+
+	if (IS_ENABLED(CONFIG_X86_X32_ABI))
+		max_frame_size = max(max_frame_size, (unsigned long)SIZEOF_rt_sigframe_x32);
+
+	if (IS_ENABLED(CONFIG_X86_64))
+		max_frame_size = max(max_frame_size, (unsigned long)SIZEOF_rt_sigframe);
+
+	max_frame_size += fpu__get_fpstate_sigframe_size() + MAX_XSAVE_PADDING;
+}
+
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
 	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
-- 
2.17.1


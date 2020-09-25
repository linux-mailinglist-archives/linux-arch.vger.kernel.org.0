Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA3278B78
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgIYO6f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 10:58:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:47916 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729165AbgIYO6R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Sep 2020 10:58:17 -0400
IronPort-SDR: aon0WTaC9Y32Z3xQc2t7vA1gkmzccV1F86r3xzuXdzrtHRuz+a9fbG+NUunhTQLO8HlNfYO8Le
 Z6f24t+FOGVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="225704499"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="225704499"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:58:15 -0700
IronPort-SDR: mk4f5HgZi9QgZiPRFPoL0+ZOP49MveK1M7h2fTdfm5ELo0AwQdsVLEWDy06xhC/j8QvOhtdJMe
 58vuIGKuUIlA==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="512916985"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:58:15 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect Branch Tracking for vsyscall emulation
Date:   Fri, 25 Sep 2020 07:58:04 -0700
Message-Id: <20200925145804.5821-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925145804.5821-1-yu-cheng.yu@intel.com>
References: <20200925145804.5821-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Vsyscall entry points are effectively branch targets.  Mark them with
ENDBR64 opcodes.  When emulating the RET instruction, unwind shadow stack
and reset IBT state machine.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v13:
- Check shadow stack address is canonical.
- Change from writing to MSRs to writing to CET xstate.

 arch/x86/entry/vsyscall/vsyscall_64.c     | 34 +++++++++++++++++++++++
 arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 ++++++
 arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
 3 files changed, 44 insertions(+)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 44c33103a955..315ee3572664 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -38,6 +38,9 @@
 #include <asm/fixmap.h>
 #include <asm/traps.h>
 #include <asm/paravirt.h>
+#include <asm/fpu/xstate.h>
+#include <asm/fpu/types.h>
+#include <asm/fpu/internal.h>
 
 #define CREATE_TRACE_POINTS
 #include "vsyscall_trace.h"
@@ -286,6 +289,37 @@ bool emulate_vsyscall(unsigned long error_code,
 	/* Emulate a ret instruction. */
 	regs->ip = caller;
 	regs->sp += 8;
+
+#ifdef CONFIG_X86_CET
+	if (tsk->thread.cet.shstk_size || tsk->thread.cet.ibt_enabled) {
+		struct cet_user_state *cet;
+		struct fpu *fpu;
+
+		fpu = &tsk->thread.fpu;
+		fpregs_lock();
+
+		if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
+			copy_fpregs_to_fpstate(fpu);
+			set_thread_flag(TIF_NEED_FPU_LOAD);
+		}
+
+		cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
+		if (!cet) {
+			fpregs_unlock();
+			goto sigsegv;
+		}
+
+		if (cet->user_ssp && ((cet->user_ssp + 8) < TASK_SIZE_MAX))
+			cet->user_ssp += 8;
+
+		if (cet->user_cet & CET_ENDBR_EN)
+			cet->user_cet &= ~CET_WAIT_ENDBR;
+
+		__fpu_invalidate_fpregs_state(fpu);
+		fpregs_unlock();
+	}
+#endif
+
 	return true;
 
 sigsegv:
diff --git a/arch/x86/entry/vsyscall/vsyscall_emu_64.S b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
index 2e203f3a25a7..b2fa92104cdb 100644
--- a/arch/x86/entry/vsyscall/vsyscall_emu_64.S
+++ b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
@@ -17,16 +17,25 @@ __PAGE_ALIGNED_DATA
 	.type __vsyscall_page, @object
 __vsyscall_page:
 
+#ifdef CONFIG_X86_BRANCH_TRACKING_USER
+	endbr64
+#endif
 	mov $__NR_gettimeofday, %rax
 	syscall
 	ret
 
 	.balign 1024, 0xcc
+#ifdef CONFIG_X86_BRANCH_TRACKING_USER
+	endbr64
+#endif
 	mov $__NR_time, %rax
 	syscall
 	ret
 
 	.balign 1024, 0xcc
+#ifdef CONFIG_X86_BRANCH_TRACKING_USER
+	endbr64
+#endif
 	mov $__NR_getcpu, %rax
 	syscall
 	ret
diff --git a/arch/x86/entry/vsyscall/vsyscall_trace.h b/arch/x86/entry/vsyscall/vsyscall_trace.h
index 3c3f9765a85c..7aa2101ada44 100644
--- a/arch/x86/entry/vsyscall/vsyscall_trace.h
+++ b/arch/x86/entry/vsyscall/vsyscall_trace.h
@@ -25,6 +25,7 @@ TRACE_EVENT(emulate_vsyscall,
 #endif
 
 #undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_PATH ../../arch/x86/entry/vsyscall/
 #define TRACE_INCLUDE_FILE vsyscall_trace
 #include <trace/define_trace.h>
-- 
2.21.0


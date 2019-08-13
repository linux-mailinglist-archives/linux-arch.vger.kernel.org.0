Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 253F28C2CB
	for <lists+linux-arch@lfdr.de>; Tue, 13 Aug 2019 23:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfHMVEN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Aug 2019 17:04:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:18664 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbfHMVDo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 17:03:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="194275998"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by fmsmga001.fm.intel.com with ESMTP; 13 Aug 2019 14:03:41 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 11/14] x86/vsyscall/64: Fixup shadow stack and branch tracking for vsyscall
Date:   Tue, 13 Aug 2019 13:53:56 -0700
Message-Id: <20190813205359.12196-12-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813205359.12196-1-yu-cheng.yu@intel.com>
References: <20190813205359.12196-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When emulating a RET, also unwind the task's shadow stack and cancel
the current branch tracking status.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c    | 29 ++++++++++++++++++++++++
 arch/x86/entry/vsyscall/vsyscall_trace.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index e7c596dea947..27ff81f75c82 100644
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
@@ -286,6 +289,32 @@ bool emulate_vsyscall(unsigned long error_code,
 	/* Emulate a ret instruction. */
 	regs->ip = caller;
 	regs->sp += 8;
+
+	/* Unwind shadow stack. */
+
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+	if (current->thread.cet.shstk_enabled) {
+		u64 r;
+
+		modify_fpu_regs_begin();
+		rdmsrl(MSR_IA32_PL3_SSP, r);
+		wrmsrl(MSR_IA32_PL3_SSP, r + 8);
+		modify_fpu_regs_end();
+	}
+#endif
+
+	/* Fixup branch tracking */
+#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+	if (current->thread.cet.ibt_enabled) {
+		u64 r;
+
+		modify_fpu_regs_begin();
+		rdmsrl(MSR_IA32_U_CET, r);
+		wrmsrl(MSR_IA32_U_CET, r & ~MSR_IA32_CET_WAIT_ENDBR);
+		modify_fpu_regs_end();
+	}
+#endif
+
 	return true;
 
 sigsegv:
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
2.17.1


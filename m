Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B682735DC
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 00:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgIUWhe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 18:37:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:58593 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgIUWhd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Sep 2020 18:37:33 -0400
IronPort-SDR: TnflJpEN31GUmjr/01l3jOpf0IwJSRMewJk/69qTPNiuy6lF8vqptV+052im4rsqZthzLQO+4r
 pUE65alWzn3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="222083345"
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="222083345"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 15:37:33 -0700
IronPort-SDR: qLhQ1OkrUy99PaYWzKxdc8kzimJCDisdO2ck0sLDqtmJyw43B3lyGUcTKfOjJLZVWgQMcHe5QE
 06w2SvVI8lUg==
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="485690200"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 15:37:32 -0700
Message-ID: <24718de58ab7bc6d7288c58d3567ad802eeb6542.camel@intel.com>
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is
 enabled
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Mon, 21 Sep 2020 15:37:32 -0700
In-Reply-To: <c96c98ec-d72a-81a3-06e2-2040f3ece33a@intel.com>
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
         <20200918192312.25978-9-yu-cheng.yu@intel.com>
         <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
         <c96c98ec-d72a-81a3-06e2-2040f3ece33a@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2020-09-21 at 09:22 -0700, Yu, Yu-cheng wrote:
> On 9/18/2020 5:11 PM, Andy Lutomirski wrote:
> > On Fri, Sep 18, 2020 at 12:23 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > Emulation of the legacy vsyscall page is required by some programs
> > > built before 2013.  Newer programs after 2013 don't use it.
> > > Disable vsyscall emulation when Control-flow Enforcement (CET) is
> > > enabled to enhance security.
> > > 
> > > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
[...]
> > 
> > Nope, try again.  Having IBT on does *not* mean that every library in
> > the process knows that we have indirect branch tracking.  The legacy
> > bitmap exists for a reason.  Also, I want a way to flag programs as
> > not using the vsyscall page, but that flag should not be called CET.
> > And a process with vsyscalls off should not be able to read the
> > vsyscall page, and /proc/self/maps should be correct.
> > 
> > So you have some choices:
> > 
> > 1. Drop this patch and make it work.
> > 
> > 2. Add a real per-process vsyscall control.  Either make it depend on
> > vsyscall=xonly and wire it up correctly or actually make it work
> > correctly with vsyscall=emulate.
> > 
> > NAK to any hacks in this space.  Do it right or don't do it at all.
> > 
> 
> We can drop this patch, and bring back the previous patch that fixes up 
> shadow stack and ibt.  That makes vsyscall emulation work correctly, and 
> does not force the application to do anything different from what is 
> working now.  I will post the previous patch as a reply to this thread 
> so that people can make comments on it.
> 
> Yu-cheng

Here is the patch:

------

From dfdee39c795ee5dcee2c77f6ba344a61f4d8124b Mon Sep 17 00:00:00 2001
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 29 Nov 2018 14:15:38 -0800
Subject: [PATCH 34/43] x86/vsyscall/64: Fixup Shadow Stack and Indirect Branch
 Tracking for vsyscall emulation

Vsyscall entry points are effectively branch targets.  Mark them with
ENDBR64 opcodes.  When emulating the RET instruction, unwind the shadow
stack and reset IBT state machine.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c     | 29 +++++++++++++++++++++++
 arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 +++++++
 arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
 3 files changed, 39 insertions(+)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
b/arch/x86/entry/vsyscall/vsyscall_64.c
index 44c33103a955..0131c9f7f9c5 100644
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
+	if (current->thread.cet.shstk_size ||
+	    current->thread.cet.ibt_enabled) {
+		u64 r;
+
+		fpregs_lock();
+		if (test_thread_flag(TIF_NEED_FPU_LOAD))
+			__fpregs_load_activate();
+
+#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+		/* Fixup branch tracking */
+		if (current->thread.cet.ibt_enabled) {
+			rdmsrl(MSR_IA32_U_CET, r);
+			wrmsrl(MSR_IA32_U_CET, r & ~CET_WAIT_ENDBR);
+		}
+#endif
+
+#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
+		/* Unwind shadow stack. */
+		if (current->thread.cet.shstk_size) {
+			rdmsrl(MSR_IA32_PL3_SSP, r);
+			wrmsrl(MSR_IA32_PL3_SSP, r + 8);
+		}
+#endif
+		fpregs_unlock();
+	}
 	return true;
 
 sigsegv:
diff --git a/arch/x86/entry/vsyscall/vsyscall_emu_64.S
b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
index 2e203f3a25a7..040696333457 100644
--- a/arch/x86/entry/vsyscall/vsyscall_emu_64.S
+++ b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
@@ -17,16 +17,25 @@ __PAGE_ALIGNED_DATA
 	.type __vsyscall_page, @object
 __vsyscall_page:
 
+#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+	endbr64
+#endif
 	mov $__NR_gettimeofday, %rax
 	syscall
 	ret
 
 	.balign 1024, 0xcc
+#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+	endbr64
+#endif
 	mov $__NR_time, %rax
 	syscall
 	ret
 
 	.balign 1024, 0xcc
+#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
+	endbr64
+#endif
 	mov $__NR_getcpu, %rax
 	syscall
 	ret
diff --git a/arch/x86/entry/vsyscall/vsyscall_trace.h
b/arch/x86/entry/vsyscall/vsyscall_trace.h
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


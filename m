Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235C427B2A3
	for <lists+linux-arch@lfdr.de>; Mon, 28 Sep 2020 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgI1Q7f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Sep 2020 12:59:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:24851 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgI1Q7e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Sep 2020 12:59:34 -0400
IronPort-SDR: z/JT+AsoGyvvd6hBVjcQV+E/6qCmZQxF7hLpBBT3NodUSqBt8H4kl4TCpaWbdHTqfbOo2FYD+P
 GHf7gBKgzPoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="162909776"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="162909776"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:59:32 -0700
IronPort-SDR: v4S0BhB4JOt8w8+C6wAYJOzwxm6jJAdzApLEgaZKt1x4jjzcU6zXSSjhd5qg7rFNwc4DRjcrvM
 f41hiv4yqHjw==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="349910113"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 09:59:32 -0700
Message-ID: <d9099183dadde8fe675e1b10e589d13b0d46831f.camel@intel.com>
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and
 Indirect Branch Tracking for vsyscall emulation
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Date:   Mon, 28 Sep 2020 09:59:24 -0700
In-Reply-To: <99B32E59-CFF2-4756-89BD-AEA0021F355F@amacapital.net>
References: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
         <99B32E59-CFF2-4756-89BD-AEA0021F355F@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 2020-09-25 at 09:51 -0700, Andy Lutomirski wrote:
> > On Sep 25, 2020, at 9:48 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
> > 
> > ﻿On 9/25/2020 9:31 AM, Andy Lutomirski wrote:
> > > > On Fri, Sep 25, 2020 at 7:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > > 
> > 
> > [...]
> > 
> > > > @@ -286,6 +289,37 @@ bool emulate_vsyscall(unsigned long error_code,
> > > >         /* Emulate a ret instruction. */
> > > >         regs->ip = caller;
> > > >         regs->sp += 8;
> > > > +
> > > > +#ifdef CONFIG_X86_CET
> > > > +       if (tsk->thread.cet.shstk_size || tsk->thread.cet.ibt_enabled) {
> > > > +               struct cet_user_state *cet;
> > > > +               struct fpu *fpu;
> > > > +
> > > > +               fpu = &tsk->thread.fpu;
> > > > +               fpregs_lock();
> > > > +
> > > > +               if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
> > > > +                       copy_fpregs_to_fpstate(fpu);
> > > > +                       set_thread_flag(TIF_NEED_FPU_LOAD);
> > > > +               }
> > > > +
> > > > +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
> > > > +               if (!cet) {
> > > > +                       fpregs_unlock();
> > > > +                       goto sigsegv;
> > > I *think* your patchset tries to keep cet.shstk_size and
> > > cet.ibt_enabled in sync with the MSR, in which case it should be
> > > impossible to get here, but a comment and a warning would be much
> > > better than a random sigsegv.
> > 
> > Yes, it should be impossible to get here.  I will add a comment and a warning, but still do sigsegv.  Should this happen, and the function return, the app gets a control-protection fault.  Why not let it fail early?
> 
> I’m okay with either approach as long as we get a comment and warning.
> 

Here is the updated patch.  I can also re-send the whole series as v14.  Thanks!

======

From 09803e66dca38d7784e32687d0693550948199ed Mon Sep 17 00:00:00 2001
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 29 Nov 2018 14:15:38 -0800
Subject: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect Branch
 Tracking for vsyscall emulation

Vsyscall entry points are effectively branch targets.  Mark them with
ENDBR64 opcodes.  When emulating the RET instruction, unwind shadow stack
and reset IBT state machine.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
v13:
- Check shadow stack address is canonical.
- Change from writing to MSRs to
writing to CET xstate.

 arch/x86/entry/vsyscall/vsyscall_64.c     | 34 +++++++++++++++++++++++
 arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 ++++++
 arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
 3 files changed, 44 insertions(+)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
b/arch/x86/entry/vsyscall/vsyscall_64.c
index 44c33103a955..30b166091d46 100644
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
@@ -286,6 +289,42 @@ bool emulate_vsyscall(unsigned long error_code,
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
+			/*
+			 * This is an unlikely case where the task is
+			 * CET-enabled, but CET xstate is in INIT.
+			 */
+			WARN_ONCE(1, "CET is enabled, but no xstates");
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
diff --git a/arch/x86/entry/vsyscall/vsyscall_emu_64.S
b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
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




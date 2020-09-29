Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D37027D5ED
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgI2ShW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 14:37:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:40268 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2ShW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Sep 2020 14:37:22 -0400
IronPort-SDR: YFXuKotdLt7Url2oOI3K4vEt6J+WcS8pmldf61TdKOwxBqqwJ6zw5kbyuKiUGYYTCN3zC1xuoF
 2nxDniGXmnOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="161483164"
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="161483164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 11:37:22 -0700
IronPort-SDR: Mj/KOp4W0zQLSYgXIcIgO1KumZzF8lg7j9lzm+HKUzibluw1cpzsR/McLT5193vD4Pv1dhgAc/
 qF/9GFzXl4KQ==
X-IronPort-AV: E=Sophos;i="5.77,319,1596524400"; 
   d="scan'208";a="340957279"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.63.108]) ([10.212.63.108])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 11:37:20 -0700
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect
 Branch Tracking for vsyscall emulation
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <d0e4077e-129f-6823-dcea-a101ef626e8c@intel.com>
 <99B32E59-CFF2-4756-89BD-AEA0021F355F@amacapital.net>
 <d9099183dadde8fe675e1b10e589d13b0d46831f.camel@intel.com>
 <CALCETrWuhPE3A7eWC=ERJa7i7jLtsXnfu04PKUFJ-Gybro+p=Q@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <b8797fcd-9d70-5749-2277-ef61f2e1be1f@intel.com>
Date:   Tue, 29 Sep 2020 11:37:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWuhPE3A7eWC=ERJa7i7jLtsXnfu04PKUFJ-Gybro+p=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/28/2020 10:37 AM, Andy Lutomirski wrote:
> On Mon, Sep 28, 2020 at 9:59 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> On Fri, 2020-09-25 at 09:51 -0700, Andy Lutomirski wrote:
>>>> On Sep 25, 2020, at 9:48 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>> +
>> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>> +               if (!cet) {
>> +                       /*
>> +                        * This is an unlikely case where the task is
>> +                        * CET-enabled, but CET xstate is in INIT.
>> +                        */
>> +                       WARN_ONCE(1, "CET is enabled, but no xstates");
> 
> "unlikely" doesn't really cover this.
> 
>> +                       fpregs_unlock();
>> +                       goto sigsegv;
>> +               }
>> +
>> +               if (cet->user_ssp && ((cet->user_ssp + 8) < TASK_SIZE_MAX))
>> +                       cet->user_ssp += 8;
> 
> This looks buggy.  The condition should be "if SHSTK is on, then add 8
> to user_ssp".  If the result is noncanonical, then some appropriate
> exception should be generated, probably by the FPU restore code -- see
> below.  You should be checking the SHSTK_EN bit, not SSP.

Updated.  Is this OK?  I will resend the whole series later.

Thanks,
Yu-cheng

======

 From 09803e66dca38d7784e32687d0693550948199ed Mon Sep 17 00:00:00 2001
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Thu, 29 Nov 2018 14:15:38 -0800
Subject: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and 
Indirect Branch
  Tracking for vsyscall emulation

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
@@ -286,6 +289,44 @@ bool emulate_vsyscall(unsigned long error_code,
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
+			 * This should not happen.  The task is
+			 * CET-enabled, but CET xstate is in INIT.
+			 */
+			WARN_ONCE(1, "CET is enabled, but no xstates");
+			fpregs_unlock();
+			goto sigsegv;
+		}
+
+		if (cet->user_cet & CET_SHSTK_EN) {
+			if (cet->user_ssp && (cet->user_ssp + 8 < TASK_SIZE_MAX))
+				cet->user_ssp += 8;
+		}
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

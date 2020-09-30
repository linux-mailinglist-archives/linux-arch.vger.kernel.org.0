Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A7327F52E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 00:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgI3WdK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Sep 2020 18:33:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:34675 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgI3WdJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Sep 2020 18:33:09 -0400
IronPort-SDR: 3GFSjnGSWTfEG1ujI4CdXsFCcx0gzaDdYnI2YvSXdvO/pwx+acyGQwl0e7B+Rgst9GkExh9Iq+
 0ou+vpYBsthw==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="180720804"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="180720804"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 15:33:07 -0700
IronPort-SDR: LynQB5zDsmodcp7qTjccsh3CjBr5J1MSwpEQwLMX6LGIR6+r6pgxBonSOc081FFuL6V6tJdHxx
 tNF2DuthHuYQ==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="312756564"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.248.51]) ([10.212.248.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 15:33:05 -0700
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
 <b8797fcd-9d70-5749-2277-ef61f2e1be1f@intel.com>
 <CALCETrWvWAxEuyteLaPmmu-r5LcWdh_DuW4JAOh3pVD4skWoBQ@mail.gmail.com>
 <CALCETrVvob1dbdWSvaB0ZK1kJ19o9ZKy=U3tFifwOR++_xk=zA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <dd4310bd-a76b-cf19-4f12-0b52d7bc483d@intel.com>
Date:   Wed, 30 Sep 2020 15:33:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVvob1dbdWSvaB0ZK1kJ19o9ZKy=U3tFifwOR++_xk=zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/29/2020 1:00 PM, Andy Lutomirski wrote:
> On Tue, Sep 29, 2020 at 12:57 PM Andy Lutomirski <luto@kernel.org> wrote:
>>
>> On Tue, Sep 29, 2020 at 11:37 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>>
>>> On 9/28/2020 10:37 AM, Andy Lutomirski wrote:
>>>> On Mon, Sep 28, 2020 at 9:59 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>>>
>>>>> On Fri, 2020-09-25 at 09:51 -0700, Andy Lutomirski wrote:
>>>>>>> On Sep 25, 2020, at 9:48 AM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>>>> +
>>>>> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>>>>> +               if (!cet) {
>>>>> +                       /*
>>>>> +                        * This is an unlikely case where the task is
>>>>> +                        * CET-enabled, but CET xstate is in INIT.
>>>>> +                        */
>>>>> +                       WARN_ONCE(1, "CET is enabled, but no xstates");
>>>>
>>>> "unlikely" doesn't really cover this.
>>>>
>>>>> +                       fpregs_unlock();
>>>>> +                       goto sigsegv;
>>>>> +               }
>>>>> +
>>>>> +               if (cet->user_ssp && ((cet->user_ssp + 8) < TASK_SIZE_MAX))
>>>>> +                       cet->user_ssp += 8;
>>>>
>>>> This looks buggy.  The condition should be "if SHSTK is on, then add 8
>>>> to user_ssp".  If the result is noncanonical, then some appropriate
>>>> exception should be generated, probably by the FPU restore code -- see
>>>> below.  You should be checking the SHSTK_EN bit, not SSP.
>>>
>>> Updated.  Is this OK?  I will resend the whole series later.
>>>
>>> Thanks,
>>> Yu-cheng
>>>
>>> ======
>>>
>>>   From 09803e66dca38d7784e32687d0693550948199ed Mon Sep 17 00:00:00 2001
>>> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>> Date: Thu, 29 Nov 2018 14:15:38 -0800
>>> Subject: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and
>>> Indirect Branch
>>>    Tracking for vsyscall emulation
>>>
>>> Vsyscall entry points are effectively branch targets.  Mark them with
>>> ENDBR64 opcodes.  When emulating the RET instruction, unwind shadow stack
>>> and reset IBT state machine.
>>>
>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>> ---
>>> v13:
>>> - Check shadow stack address is canonical.
>>> - Change from writing to MSRs to writing to CET xstate.
>>>
>>>    arch/x86/entry/vsyscall/vsyscall_64.c     | 34 +++++++++++++++++++++++
>>>    arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 ++++++
>>>    arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
>>>    3 files changed, 44 insertions(+)
>>>
>>> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
>>> b/arch/x86/entry/vsyscall/vsyscall_64.c
>>> index 44c33103a955..30b166091d46 100644
>>> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
>>> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
>>> @@ -38,6 +38,9 @@
>>>    #include <asm/fixmap.h>
>>>    #include <asm/traps.h>
>>>    #include <asm/paravirt.h>
>>> +#include <asm/fpu/xstate.h>
>>> +#include <asm/fpu/types.h>
>>> +#include <asm/fpu/internal.h>
>>>
>>>    #define CREATE_TRACE_POINTS
>>>    #include "vsyscall_trace.h"
>>> @@ -286,6 +289,44 @@ bool emulate_vsyscall(unsigned long error_code,
>>>          /* Emulate a ret instruction. */
>>>          regs->ip = caller;
>>>          regs->sp += 8;
>>> +
>>> +#ifdef CONFIG_X86_CET
>>> +       if (tsk->thread.cet.shstk_size || tsk->thread.cet.ibt_enabled) {
>>> +               struct cet_user_state *cet;
>>> +               struct fpu *fpu;
>>> +
>>> +               fpu = &tsk->thread.fpu;
>>> +               fpregs_lock();
>>> +
>>> +               if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
>>> +                       copy_fpregs_to_fpstate(fpu);
>>> +                       set_thread_flag(TIF_NEED_FPU_LOAD);
>>> +               }
>>> +
>>> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>>> +               if (!cet) {
>>> +                       /*
>>> +                        * This should not happen.  The task is
>>> +                        * CET-enabled, but CET xstate is in INIT.
>>> +                        */
>>
>> Can the comment explain better, please?  I would say something like:
>>
>> If the kernel thinks this task has CET enabled (because
>> tsk->thread.cet has one of the features enabled), then the
>> corresponding bits must also be set in the CET XSAVES region.  If the
>> CET XSAVES region is in the INIT state, then the kernel's concept of
>> the task's CET state is corrupt.
>>
>>> +                       WARN_ONCE(1, "CET is enabled, but no xstates");
>>> +                       fpregs_unlock();
>>> +                       goto sigsegv;
>>> +               }
>>> +
>>> +               if (cet->user_cet & CET_SHSTK_EN) {
>>> +                       if (cet->user_ssp && (cet->user_ssp + 8 < TASK_SIZE_MAX))
>>> +                               cet->user_ssp += 8;
>>> +               }
>>
>> This makes so sense to me.  Also, the vsyscall emulation code is
>> intended to be as rigid as possible to minimize the chance that it
>> gets used as an exploit gadget.  So we should not silently corrupt
>> anything.  Moreover, this code seems quite dangerous -- you've created
>> a gadget that does RET without actually verifying the SHSTK token.  If
>> SHSTK and some form of strong indirect branch/call CFI is in use, then
>> the existance of a CFI-bypassing return primitive at a fixed address
>> seems quite problematic.
>>
>> So I think you need to write a function that reasonably accurately
>> emulates a usermode RET.
>>
> 
> For what it's worth, I think there is an alternative.  If you all
> (userspace people, etc) can come up with a credible way for a user
> program to statically declare that it doesn't need vsyscalls, then we
> could make SHSTK depend on *that*, and we could avoid this mess.  This
> breaks orthogonality, but it's probably a decent outcome.
> 

Would an arch_prctl(DISABLE_VSYSCALL) work?  The kernel then sets a 
thread flag, and in emulate_vsyscall(), checks the flag.

When CET is enabled, ld-linux will do DISABLE_VSYSCALL.

How is that?

Yu-cheng

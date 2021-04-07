Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29E3357502
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 21:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355637AbhDGTgS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 15:36:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:30011 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345628AbhDGTgR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 15:36:17 -0400
IronPort-SDR: TdEZj9cmyPaIWVjf2/EKdRQ/MEP2ty4BQrWm5MmqCmz4urQoWL+LUS7UMnK6gpVtcNqSCTNszz
 yo9nMxPOyu5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193499952"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="193499952"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 12:36:07 -0700
IronPort-SDR: rAPVXak+nGDVnXg9E3NIe27rAWHjK35mnoyvbDaT6d99UCplYkjy2wqj9cOCpfHty8nh69qdk1
 E3HjT8/jTPWA==
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="448370025"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.254.186.83]) ([10.254.186.83])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 12:36:05 -0700
Subject: Re: [PATCH v24 25/30] x86/cet/shstk: Handle signals for shadow stack
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-26-yu-cheng.yu@intel.com>
 <CALCETrWa+gjf2c2WDVxk23xd11kTnrUmiqrMsOVXOKPL4Eg-JA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <76743437-24b3-7c33-2570-6100c8811165@intel.com>
Date:   Wed, 7 Apr 2021 12:36:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWa+gjf2c2WDVxk23xd11kTnrUmiqrMsOVXOKPL4Eg-JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/6/2021 3:50 PM, Andy Lutomirski wrote:
> On Thu, Apr 1, 2021 at 3:11 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> When shadow stack is enabled, a task's shadow stack states must be saved
>> along with the signal context and later restored in sigreturn.  However,
>> currently there is no systematic facility for extending a signal context.
>>
>> Introduce a signal context extension struct 'sc_ext', which is used to save
>> shadow stack restore token address and WAIT_ENDBR status[1].  The extension
>> is located above the fpu states, plus alignment.
>>
>> Introduce routines for the allocation, save, and restore for sc_ext:
>> - fpu__alloc_sigcontext_ext(),
>> - save_extra_state_to_sigframe(),
>> - get_extra_state_from_sigframe(),
>> - restore_extra_state().
>>
>> [1] WAIT_ENDBR will be introduced later in the Indirect Branch Tracking
>>      series, but add that into sc_ext now to keep the struct stable in case
>>      the IBT series is applied later.
> 
> Please don't.  Instead, please figure out how that structure gets
> extended for real, and organize your patches to demonstrate that the
> extension works.
> 
>>
>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> ---
>> v24:
>> - Split out shadow stack token routines to a separate patch.
>> - Put signal frame save/restore routines to fpu/signal.c and re-name accordingly.
>>
>>   arch/x86/ia32/ia32_signal.c            |  16 +++
>>   arch/x86/include/asm/cet.h             |   2 +
>>   arch/x86/include/asm/fpu/internal.h    |   2 +
>>   arch/x86/include/uapi/asm/sigcontext.h |   9 ++
>>   arch/x86/kernel/fpu/signal.c           | 143 +++++++++++++++++++++++++
>>   arch/x86/kernel/signal.c               |   9 ++
>>   6 files changed, 181 insertions(+)
>>

[...]

>> diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
>> index 844d60eb1882..cf2d55db3be4 100644
>> --- a/arch/x86/include/uapi/asm/sigcontext.h
>> +++ b/arch/x86/include/uapi/asm/sigcontext.h
>> @@ -196,6 +196,15 @@ struct _xstate {
>>          /* New processor state extensions go here: */
>>   };
>>
>> +/*
>> + * Located at the end of sigcontext->fpstate, aligned to 8.
>> + */
>> +struct sc_ext {
>> +       unsigned long total_size;
>> +       unsigned long ssp;
>> +       unsigned long wait_endbr;
>> +};
> 
> We need some proper documentation and an extensibility story for this.
> This won't be the last time we extend the signal state.  Keep in mind
> that the FPU state is very likely to become genuinely variable sized
> due to AVX-512 and AMX.
> 

Right now, on the signal stack, we have:

- siginfo, ucontext,
- fpu states (xsave state),

We might not want to change ucontext.  The concern is breaking existing 
app's.

Fpu states are all user states (vs. ssp, wait_endbr are supervisor 
states).  Therefore, we cannot put ssp and wait_endbr in fpu states. 
Fpu states can grow to whatever size (AVX-512 etc.), the extension is 
always above it if the user stack has room.  If the user stack does not 
have enough room, fpu__aloc_mathframe() fails.

The struct sc_ext has a simple 'total_size' field for error checking. 
To extend it, newer fields are always added to the end and total_size 
keeps track of it.  I will put more comments about this.

> We also have the ability to extend ucontext, I believe, and I'd like
> some analysis of why we want to put ssp and wait_endbr into the FPU
> context instead of the ucontext.
> 

[...]

>> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
>> index a4ec65317a7f..2e56f2fe8be0 100644
>> --- a/arch/x86/kernel/fpu/signal.c
>> +++ b/arch/x86/kernel/fpu/signal.c

[...]

>> +
>> +/*
>> + * Called from __fpu__restore_sig() and XSAVES buffer is protected by
>> + * set_thread_flag(TIF_NEED_FPU_LOAD) in the slow path.
>> + */
>> +void restore_extra_state(struct sc_ext *sc_ext)
>> +{
>> +#ifdef CONFIG_X86_CET
>> +       struct cet_status *cet = &current->thread.cet;
>> +       struct cet_user_state *cet_user_state;
>> +       u64 msr_val = 0;
>> +
>> +       if (!cpu_feature_enabled(X86_FEATURE_CET))
>> +               return;
>> +
>> +       cet_user_state = get_xsave_addr(&current->thread.fpu.state.xsave,
>> +                                       XFEATURE_CET_USER);
>> +       if (!cet_user_state)
>> +               return;
>> +
>> +       if (cet->shstk_size) {
> 
> Is fpregs_lock() needed?

This path is already protected.

> 
>> +               if (test_thread_flag(TIF_NEED_FPU_LOAD))
>> +                       cet_user_state->user_ssp = sc_ext->ssp;
>> +               else
>> +                       wrmsrl(MSR_IA32_PL3_SSP, sc_ext->ssp);
> 
> wrmsrl_safe() please.
> 
>> +
>> +               msr_val |= CET_SHSTK_EN;
>> +       }
>> +
>> +       if (test_thread_flag(TIF_NEED_FPU_LOAD))
>> +               cet_user_state->user_cet = msr_val;
>> +       else
>> +               wrmsrl(MSR_IA32_U_CET, msr_val);
>> +#endif
> 
> I don't understand. Why are you recomputing MSR_IA32_U_CET here?
> 
> As another general complaint about this patch set, there's
> cet->shstk_size and there's MSR_IA32_U_CET (and its copy in the fpu
> state), and they seem to be used somewhat interchangably.  Why are
> both needed?  Could there be some new helpers to help manage them all
> in a unified way?
> 

Indeed, shadow stack/IBT states are cached in the thread header.  Their 
MSRs and XSAVES states are accessed only when necessary.  The signal 
restore path has been optimized in the past and I hope not to put in 
code that negates past work.

I agree with your other comments for the patch and will update in the 
next revision.

Thanks,
Yu-cheng

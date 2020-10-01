Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B174280448
	for <lists+linux-arch@lfdr.de>; Thu,  1 Oct 2020 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732360AbgJAQvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Oct 2020 12:51:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:59840 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbgJAQvl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Oct 2020 12:51:41 -0400
IronPort-SDR: jgp66Icb9SwbB6eEHv6R1yhBmm+K2sToWhrceCkSOhX1EkToiMCa1iRc4pE2mt+K3Sys9OcYJb
 g5FQxk1SXxkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="180933792"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="180933792"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 09:51:38 -0700
IronPort-SDR: MI//hR/qDfigJQ/WhDVCXIhf6/vl8bAvbmWqe3dt+FZvFbfeHbaqAKVc7xnQKoOak2hvZBeZho
 A8V7kczDvZog==
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="346148630"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.213.183.12]) ([10.213.183.12])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 09:51:35 -0700
Subject: Re: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and Indirect
 Branch Tracking for vsyscall emulation
To:     Andy Lutomirski <luto@kernel.org>, "H.J. Lu" <hjl.tools@gmail.com>
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
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
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
 <dd4310bd-a76b-cf19-4f12-0b52d7bc483d@intel.com>
 <CALCETrXgde6yHTKw1Njnxp9cANp6Ee8bmG9C2X4e-Fz0ZZCuBw@mail.gmail.com>
 <CAMe9rOonjX-b46sJ3AYSJZV84d=oU6-KhScnk5vksVqoLgQ90A@mail.gmail.com>
 <CALCETrWoGXDDEvy10LoYVY6c_tkpMVABhCy+8pse9Rw8L9L=5A@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <79d1e67d-2394-1ce6-3bad-cce24ba792bd@intel.com>
Date:   Thu, 1 Oct 2020 09:51:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWoGXDDEvy10LoYVY6c_tkpMVABhCy+8pse9Rw8L9L=5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/30/2020 6:10 PM, Andy Lutomirski wrote:
> On Wed, Sep 30, 2020 at 6:01 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>>
>> On Wed, Sep 30, 2020 at 4:44 PM Andy Lutomirski <luto@kernel.org> wrote:

[...]

>>>>>>>    From 09803e66dca38d7784e32687d0693550948199ed Mon Sep 17 00:00:00 2001
>>>>>>> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>>>>>> Date: Thu, 29 Nov 2018 14:15:38 -0800
>>>>>>> Subject: [PATCH v13 8/8] x86/vsyscall/64: Fixup Shadow Stack and
>>>>>>> Indirect Branch
>>>>>>>     Tracking for vsyscall emulation
>>>>>>>
>>>>>>> Vsyscall entry points are effectively branch targets.  Mark them with
>>>>>>> ENDBR64 opcodes.  When emulating the RET instruction, unwind shadow stack
>>>>>>> and reset IBT state machine.
>>>>>>>
>>>>>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>>>>>> ---
>>>>>>> v13:
>>>>>>> - Check shadow stack address is canonical.
>>>>>>> - Change from writing to MSRs to writing to CET xstate.
>>>>>>>
>>>>>>>     arch/x86/entry/vsyscall/vsyscall_64.c     | 34 +++++++++++++++++++++++
>>>>>>>     arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 ++++++
>>>>>>>     arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
>>>>>>>     3 files changed, 44 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
>>>>>>> b/arch/x86/entry/vsyscall/vsyscall_64.c
>>>>>>> index 44c33103a955..30b166091d46 100644
>>>>>>> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
>>>>>>> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
>>>>>>> @@ -38,6 +38,9 @@
>>>>>>>     #include <asm/fixmap.h>
>>>>>>>     #include <asm/traps.h>
>>>>>>>     #include <asm/paravirt.h>
>>>>>>> +#include <asm/fpu/xstate.h>
>>>>>>> +#include <asm/fpu/types.h>
>>>>>>> +#include <asm/fpu/internal.h>
>>>>>>>
>>>>>>>     #define CREATE_TRACE_POINTS
>>>>>>>     #include "vsyscall_trace.h"
>>>>>>> @@ -286,6 +289,44 @@ bool emulate_vsyscall(unsigned long error_code,
>>>>>>>           /* Emulate a ret instruction. */
>>>>>>>           regs->ip = caller;
>>>>>>>           regs->sp += 8;
>>>>>>> +
>>>>>>> +#ifdef CONFIG_X86_CET
>>>>>>> +       if (tsk->thread.cet.shstk_size || tsk->thread.cet.ibt_enabled) {
>>>>>>> +               struct cet_user_state *cet;
>>>>>>> +               struct fpu *fpu;
>>>>>>> +
>>>>>>> +               fpu = &tsk->thread.fpu;
>>>>>>> +               fpregs_lock();
>>>>>>> +
>>>>>>> +               if (!test_thread_flag(TIF_NEED_FPU_LOAD)) {
>>>>>>> +                       copy_fpregs_to_fpstate(fpu);
>>>>>>> +                       set_thread_flag(TIF_NEED_FPU_LOAD);
>>>>>>> +               }
>>>>>>> +
>>>>>>> +               cet = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>>>>>>> +               if (!cet) {
>>>>>>> +                       /*
>>>>>>> +                        * This should not happen.  The task is
>>>>>>> +                        * CET-enabled, but CET xstate is in INIT.
>>>>>>> +                        */
>>>>>>
[...]
>>>>>>
>>>>>
>>>>> For what it's worth, I think there is an alternative.  If you all
>>>>> (userspace people, etc) can come up with a credible way for a user
>>>>> program to statically declare that it doesn't need vsyscalls, then we
>>>>> could make SHSTK depend on *that*, and we could avoid this mess.  This
>>>>> breaks orthogonality, but it's probably a decent outcome.
>>>>>
>>>>
>>>> Would an arch_prctl(DISABLE_VSYSCALL) work?  The kernel then sets a
>>>> thread flag, and in emulate_vsyscall(), checks the flag.
>>>>
>>>> When CET is enabled, ld-linux will do DISABLE_VSYSCALL.
>>>>
>>>> How is that?
>>>
>>> Backwards, no?  Presumably vsyscall needs to be disabled before or
>>> concurrently with CET being enabled, not after.
>>>
>>> I think the solution of making vsyscall emulation work correctly with
>>> CET is going to be better and possibly more straightforward.
>>>
>>
>> We can do
>>
>> 1. Add ARCH_X86_DISABLE_VSYSCALL to disable the vsyscall page.
>> 2. If CPU supports CET and the program is CET enabled:
>>      a. Disable the vsyscall page.
>>      b. Pass control to user.
>>      c. Enable the vsyscall page when ARCH_X86_CET_DISABLE is called.
>>
>> So when control is passed from kernel to user, the vsyscall page is
>> disabled if the program
>> is CET enabled.
> 
> Let me say this one more time:
> 
> If we have a per-process vsyscall disable control and a per-process
> CET control, we are going to keep those settings orthogonal.  I'm
> willing to entertain an option in which enabling SHSTK without also
> disabling vsyscalls is disallowed, We are *not* going to have any CET
> flags magically disable vsyscalls, though, and we are not going to
> have a situation where disabling vsyscalls on process startup requires
> enabling SHSTK.
> 
> Any possible static vsyscall controls (and CET controls, for that
> matter) also need to come with some explanation of whether they are
> properties set on the ELF loader, the ELF program being loaded, or
> both.  And this explanation needs to cover what happens when old
> binaries link against new libc versions and vice versa.  A new
> CET-enabled binary linked against old libc running on a new kernel
> that is expected to work on a non-CET CPU MUST work on a CET CPU, too.
> 
> Right now, literally the only thing preventing vsyscall emulation from
> coexisting with SHSTK is that the implementation eeds work.
> 
> So your proposal is rejected.  Sorry.
>
I think, even with shadow stack/ibt enabled, we can still allow XONLY 
without too much mess.

What about this?

Thanks,
Yu-cheng

======

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c 
b/arch/x86/entry/vsyscall/vsyscall_64.c
index 8b0b32ac7791..d39da0a15521 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -48,16 +48,16 @@
  static enum { EMULATE, XONLY, NONE } vsyscall_mode __ro_after_init =
  #ifdef CONFIG_LEGACY_VSYSCALL_NONE
         NONE;
-#elif defined(CONFIG_LEGACY_VSYSCALL_XONLY)
+#elif defined(CONFIG_LEGACY_VSYSCALL_XONLY) || defined(CONFIG_X86_CET)
         XONLY;
-#else
+#else
         EMULATE;
  #endif

  static int __init vsyscall_setup(char *str)
  {
         if (str) {
-               if (!strcmp("emulate", str))
+               if (!strcmp("emulate", str) && !IS_ENABLED(CONFIG_X86_CET))
                         vsyscall_mode = EMULATE;
                 else if (!strcmp("xonly", str))
                         vsyscall_mode = XONLY;

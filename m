Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C018727638D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 00:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIWWHi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 18:07:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:4747 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbgIWWHi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Sep 2020 18:07:38 -0400
IronPort-SDR: 3KLQLjmwtefAohujkxfcPErNhpmdhR37arjuGNrf/rHzf5nTHG30Pf2uUuXGRY/JRqKqIQeKoD
 x0Vjk0FIzidg==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="161957687"
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="161957687"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 15:07:37 -0700
IronPort-SDR: 8/nCNdvR1Yu+v3Mm6u3D2OpVY2JEFnr7Z+ho3MLY1KMtk3aBCEv1l+R7At79+gzntTR2rKuS+i
 K87HxPIy+6Sw==
X-IronPort-AV: E=Sophos;i="5.77,295,1596524400"; 
   d="scan'208";a="455088682"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.121.128]) ([10.212.121.128])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 15:07:34 -0700
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is
 enabled
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
References: <20200918192312.25978-1-yu-cheng.yu@intel.com>
 <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <CALCETrXfixDGJhf0yPw-OckjEdeF2SbYjWFm8VbLriiP0Krhrg@mail.gmail.com>
 <c96c98ec-d72a-81a3-06e2-2040f3ece33a@intel.com>
 <24718de58ab7bc6d7288c58d3567ad802eeb6542.camel@intel.com>
 <CALCETrWssUxxfhPPJZgPOmpaQcf4o9qCe1j-P7yiPyZVV+O8ZQ@mail.gmail.com>
 <b3defc91-1e8e-d0d5-2ac3-3861a7e3355c@intel.com>
 <CALCETrUVUqK6_bjFNSmOjnWVNscwfWmMa6Bt9fQrpFa5m3xNwA@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <3747f6f2-4eb0-0e70-68e5-4e8f161bcb6e@intel.com>
Date:   Wed, 23 Sep 2020 15:07:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUVUqK6_bjFNSmOjnWVNscwfWmMa6Bt9fQrpFa5m3xNwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/23/2020 2:34 PM, Andy Lutomirski wrote:
> On Tue, Sep 22, 2020 at 10:46 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>
>> On 9/21/2020 4:48 PM, Andy Lutomirski wrote:
>>> On Mon, Sep 21, 2020 at 3:37 PM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>>
>>>> On Mon, 2020-09-21 at 09:22 -0700, Yu, Yu-cheng wrote:
>>
>> [...]
>>
>>>>
>>>> Here is the patch:
>>>>
>>>> ------
>>>>
>>>>   From dfdee39c795ee5dcee2c77f6ba344a61f4d8124b Mon Sep 17 00:00:00 2001
>>>> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>>> Date: Thu, 29 Nov 2018 14:15:38 -0800
>>>> Subject: [PATCH 34/43] x86/vsyscall/64: Fixup Shadow Stack and Indirect Branch
>>>>    Tracking for vsyscall emulation
>>>>
>>>> Vsyscall entry points are effectively branch targets.  Mark them with
>>>> ENDBR64 opcodes.  When emulating the RET instruction, unwind the shadow
>>>> stack and reset IBT state machine.
>>>>
>>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>>> ---
>>>>    arch/x86/entry/vsyscall/vsyscall_64.c     | 29 +++++++++++++++++++++++
>>>>    arch/x86/entry/vsyscall/vsyscall_emu_64.S |  9 +++++++
>>>>    arch/x86/entry/vsyscall/vsyscall_trace.h  |  1 +
>>>>    3 files changed, 39 insertions(+)
>>>>
>>>> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c
>>>> b/arch/x86/entry/vsyscall/vsyscall_64.c
>>>> index 44c33103a955..0131c9f7f9c5 100644
>>>> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
>>>> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
>>>> @@ -38,6 +38,9 @@
>>>>    #include <asm/fixmap.h>
>>>>    #include <asm/traps.h>
>>>>    #include <asm/paravirt.h>
>>>> +#include <asm/fpu/xstate.h>
>>>> +#include <asm/fpu/types.h>
>>>> +#include <asm/fpu/internal.h>
>>>>
>>>>    #define CREATE_TRACE_POINTS
>>>>    #include "vsyscall_trace.h"
>>>> @@ -286,6 +289,32 @@ bool emulate_vsyscall(unsigned long error_code,
>>>>           /* Emulate a ret instruction. */
>>>>           regs->ip = caller;
>>>>           regs->sp += 8;
>>>> +
>>>> +       if (current->thread.cet.shstk_size ||
>>>> +           current->thread.cet.ibt_enabled) {
>>>> +               u64 r;
>>>> +
>>>> +               fpregs_lock();
>>>> +               if (test_thread_flag(TIF_NEED_FPU_LOAD))
>>>> +                       __fpregs_load_activate();
>>>
>>> Wouldn't this be nicer if you operated on the memory image, not the registers?
>>
>> Do you mean writing to the XSAVES area?
> 
> Yes.
> 
>>
>>>
>>>> +
>>>> +#ifdef CONFIG_X86_INTEL_BRANCH_TRACKING_USER
>>>> +               /* Fixup branch tracking */
>>>> +               if (current->thread.cet.ibt_enabled) {
>>>> +                       rdmsrl(MSR_IA32_U_CET, r);
>>>> +                       wrmsrl(MSR_IA32_U_CET, r & ~CET_WAIT_ENDBR);
>>>> +               }
>>>> +#endif
>>>
>>> Seems reasonable on first glance.
>>>
>>>> +
>>>> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
>>>> +               /* Unwind shadow stack. */
>>>> +               if (current->thread.cet.shstk_size) {
>>>> +                       rdmsrl(MSR_IA32_PL3_SSP, r);
>>>> +                       wrmsrl(MSR_IA32_PL3_SSP, r + 8);
>>>> +               }
>>>> +#endif
>>>
>>> What happens if the result is noncanonical?  A quick skim of the SDM
>>> didn't find anything.  This latter issue goes away if you operate on
>>> the memory image, though -- writing a bogus value is just fine, since
>>> the FP restore will handle it.
>>>
>>
>> At this point, the MSR's value can still be valid or is already saved to
>> memory.  If we are going to write to memory, then the MSR must be saved
>> first.  So I chose to do __fpregs_load_activate() and write the MSR.
>>
>> Maybe we can check the address before writing it to the MSR?
> 
> Performance is almost irrelevant here, and the writing-to-XSAVES-area
> approach should have the benefit that the exception handling and
> signaling happens for free.
> 

Ok, I will change it.

Thanks,
Yu-cheng

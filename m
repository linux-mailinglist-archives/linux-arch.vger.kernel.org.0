Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84AECE0282
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2019 13:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730847AbfJVLJl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Oct 2019 07:09:41 -0400
Received: from [217.140.110.172] ([217.140.110.172]:49408 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbfJVLJl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Oct 2019 07:09:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2705E1FB;
        Tue, 22 Oct 2019 04:09:16 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 353BE3F718;
        Tue, 22 Oct 2019 04:09:13 -0700 (PDT)
Subject: Re: [PATCH v2 09/12] arm64: traps: Fix inconsistent faulting
 instruction skipping
To:     Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?Q?Kristina_Mart=c5=a1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-10-git-send-email-Dave.Martin@arm.com>
 <20191011152453.GF33537@lakrids.cambridge.arm.com>
 <20191015152108.GX27757@arm.com>
 <20191015164204.GC24604@lakrids.cambridge.arm.com>
 <20191015164904.GY27757@arm.com> <20191018164037.GG27757@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <139b3e05-d060-d024-7ef2-88b0e5921324@arm.com>
Date:   Tue, 22 Oct 2019 12:09:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191018164037.GG27757@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 18/10/2019 17:40, Dave Martin wrote:
> On Tue, Oct 15, 2019 at 05:49:05PM +0100, Dave Martin wrote:
>> On Tue, Oct 15, 2019 at 05:42:04PM +0100, Mark Rutland wrote:
>>> On Tue, Oct 15, 2019 at 04:21:09PM +0100, Dave Martin wrote:
>>>> On Fri, Oct 11, 2019 at 04:24:53PM +0100, Mark Rutland wrote:
>>>>> On Thu, Oct 10, 2019 at 07:44:37PM +0100, Dave Martin wrote:
>>>>>> Correct skipping of an instruction on AArch32 works a bit
>>>>>> differently from AArch64, mainly due to the different CPSR/PSTATE
>>>>>> semantics.
>>>>>>
>>>>>> There have been various attempts to get this right.  Currenty
>>>>>> arm64_skip_faulting_instruction() mostly does the right thing, but
>>>>>> does not advance the IT state machine for the AArch32 case.
>>>>>>
>>>>>> arm64_compat_skip_faulting_instruction() handles the IT state
>>>>>> machine but is local to traps.c, and porting other code to use it
>>>>>> will make a mess since there are some call sites that apply for
>>>>>> both the compat and native cases.
>>>>>>
>>>>>> Since manual instruction skipping implies a trap, it's a relatively
>>>>>> slow path.
>>>>>>
>>>>>> So, make arm64_skip_faulting_instruction() handle both compat and
>>>>>> native, and get rid of the arm64_compat_skip_faulting_instruction()
>>>>>> special case.
>>>>>>
>>>>>> Fixes: 32a3e635fb0e ("arm64: compat: Add CNTFRQ trap handler")
>>>>>> Fixes: 1f1c014035a8 ("arm64: compat: Add condition code checks and IT advance")
>>>>>> Fixes: 6436beeee572 ("arm64: Fix single stepping in kernel traps")
>>>>>> Fixes: bd35a4adc413 ("arm64: Port SWP/SWPB emulation support from arm")
>>>>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>>>>> ---
>>>>>>   arch/arm64/kernel/traps.c | 18 ++++++++----------
>>>>>>   1 file changed, 8 insertions(+), 10 deletions(-)
>>>>>
>>>>> This looks good to me; it's certainly easier to reason about.
>>>>>
>>>>> I couldn't spot a place where we do the wrong thing today, given AFAICT
>>>>> all the instances in arch/arm64/kernel/armv8_deprecated.c would be
>>>>> UNPREDICTABLE within an IT block.
>>>>>
>>>>> It might be worth calling out an example in the commit message to
>>>>> justify the fixes tags.
>>>>
>>>> IIRC I found no bug here; rather we have pointlessly fragmented code,
>>>> so I followed the "if fixing the same bug in multiple places, merge
>>>> those places so you need only fix it in one place next time" rule.
>>>
>>> Sure thing, that makes sense to me.
>>>
>>>> Since arm64_skip_faulting_instruction() is most of the way to being
>>>> generically usable anyway, this series merges all the special-case
>>>> handling into it.
>>>>
>>>> I could add something like
>>>>
>>>> --8<--
>>>>
>>>> This allows this fiddly operation to be maintained in a single
>>>> place rather than trying to maintain fragmented versions spread
>>>> around arch/arm64.
>>>>
>>>> -->8--
>>>>
>>>> Any good?
>>>
>>> My big concern is that the commit message reads as a fix, implying that
>>> there's an existing correctness bug. I think that simplifying it to make
>>> it clearer that it's a cleanup/improvement would be preferable.
>>>
>>> How about:
>>>
>>> | arm64: unify native/compat instruction skipping
>>> |
>>> | Skipping of an instruction on AArch32 works a bit differently from
>>> | AArch64, mainly due to the different CPSR/PSTATE semantics.
>>> |
>>> | Currently arm64_skip_faulting_instruction() is only suitable for
>>> | AArch64, and arm64_compat_skip_faulting_instruction() handles the IT
>>> | state machine but is local to traps.c.
>>> |
>>> | Since manual instruction skipping implies a trap, it's a relatively
>>> | slow path.
>>> |
>>> | So, make arm64_skip_faulting_instruction() handle both compat and
>>> | native, and get rid of the arm64_compat_skip_faulting_instruction()
>>> | special case.
>>> |
>>> | Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>
>> And drop the Fixes tags.  Yes, I think that's reasonable.
>>
>> I think I was probably glossing over the fact that we don't need to get
>> the ITSTATE machine advance correct for the compat insn emulation; as
>> you say, I can't see what else this patch "fixes".
>>
>>> With that, feel free to add:
>>>
>>> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>>
>> Thanks!
>>
>>> We could even point out that the armv8_deprecated cases are
>>> UNPREDICTABLE in an IT block, and correctly emulated either way.
>>
>> Yes, I'll add something along those lines.
> 
> Taking another look, I now can't track down where e.g., SWP in an IT
> block is specified to be UNPREDICTABLE.  I only see e.g.,
> ARM DDI 0487E.a Section 1.8.2 ("F1.8.2 Partial deprecation of IT"),
> which only deprecates the affected instructions.
> 
> The legacy AArch32 SWP{B} insn is obsoleted by ARMv8, but the whole
> point of the armv8_deprecated stuff is to provide some backwards
> compatiblity with v7.
> 
> 
> So, this needs a closer look.
> 
> I'll leave the Fixes tags for now, so that the archaeology doesn't need
> to redone if we decide that this patch does fix incorrect behaviour.

The Thumb encoding of SETEND is explicitly not allowed in an IT block, 
while a Thumb encoding of SWB{B} has never existed, so that's moot.

As far as I can see from DDI0406C.c, nothing prevents a Thumb MCR/MRC 
from being in an IT block (the ARM encodings are conditional, after all) 
so while they do fall under the performance deprecation, it would seem 
to be our bug if we don't already handle conditional CP15 barriers 
correctly.

Robin.

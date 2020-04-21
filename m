Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16E11B25D8
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDUMWq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 08:22:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2855 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgDUMWq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 08:22:46 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DD693E80D4C4184FD20D;
        Tue, 21 Apr 2020 20:22:42 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 20:22:35 +0800
Subject: Re: [PATCH v1 6/6] arm64: tlb: Set the TTL field in flush_tlb_range
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     <mark.rutland@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>, <arnd@arndb.de>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
 <20200403090048.938-7-yezhenyu2@huawei.com>
 <20200420121055.GF20696@hirez.programming.kicks-ass.net>
 <20200420200616.44c7c7ea@oasis.local.home>
 <20200421083043.GP20730@hirez.programming.kicks-ass.net>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <25267000-9c39-cd1c-33c8-c62bfb41d905@huawei.com>
Date:   Tue, 21 Apr 2020 20:22:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200421083043.GP20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/4/21 16:30, Peter Zijlstra wrote:
> On Mon, Apr 20, 2020 at 08:06:16PM -0400, Steven Rostedt wrote:
>> Peter Zijlstra <peterz@infradead.org> wrote:
>>> On Fri, Apr 03, 2020 at 05:00:48PM +0800, Zhenyu Ye wrote:
> 
>>>> +static inline int tlb_get_level(struct mmu_gather *tlb)
>>>> +{
>>>> +	int sum = tlb->cleared_ptes + tlb->cleared_pmds +
>>>> +		  tlb->cleared_puds + tlb->cleared_p4ds;
>>>> +
>>>> +	if (sum != 1)
>>>> +		return 0;
>>>> +	else if (tlb->cleared_ptes)
>>>> +		return 3;
>>>> +	else if (tlb->cleared_pmds)
>>>> +		return 2;
>>>> +	else if (tlb->cleared_puds)
>>>> +		return 1;
>>>> +
>>>> +	return 0;
>>>> +}  
>>>
>>> That's some mighty wonky code. Please look at the generated asm.
>>
>> Without even looking at the generated asm, if a condition returns,
>> there's no reason to add an else for that condition.
> 
> Not really the point; he wants to guarantee he only returns >0 when
> there's a single bit set. But the thing is, cleared_* is a bitfield, and
> I'm afraid that the above will result in some terrible code-gen.
> 
> Maybe something like:
> 
> 	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
> 				   tlb->cleared_puds ||
> 				   tlb->cleared_p4ds))
> 		return 3;
> 
> 	if (tlb->cleared_pmds && !(tlb->cleared_ptes ||
> 				   tlb->cleared_puds ||
> 				   tlb->cleared_p4ds))
> 		return 2;
> 
> 	if (tlb->cleared_puds && !(tlb->cleared_ptes ||
> 				   tlb->cleared_pmds ||
> 				   tlb->cleared_p4ds))
> 		return 1;
> 
> 	return 0;
> 
> Which I admit is far too much typing, but I suspect it generates far
> saner code (just a few masks and branches).
> 
> But maybe the compiler surprises us, what do I konw.

Thanks for your review.  In my view, the asm-code should behave the same
as the C code, even if cleared_* are bitfields (below 02 optimization).

Below is the generated asm of my code (gcc version is 7.3.0):

<tlb_flush_mmu_tlbonly.part.110>:
	...
	ubfx	x5, x2, #3, #1		// x2 stores the values of cleared_*
	ubfx	x1, x2, #4, #1
	add	w1, w1, w5
	ubfx	x5, x2, #5, #1
	add	w1, w1, w5
	ubfx	x2, x2, #6, #1
	add	w1, w1, w2		// then the w1 = sum of cleared_*
	tbnz	w3, #3, 001030f8b8
	tbz	w3, #4, 001030fac0
	cmp	w1, #0x1		// cmp the w1 to select branch
	mov	w5, #0x2
	...				// do the if-else below...


Then with your code above, the generated asm is:

<tlb_flush_mmu_tlbonly.part.110>:
	...
	tbnz    w1, #3, 001030f8a0	// w1 stores the values of cleared_*
	tbz     w1, #4, 001030fac0
	and     w2, w1, #0x78		// mask the cleared_* to w2
	mov     x4, #0x200000
	mov     w7, #0x15
	mov     w6, #0x3
	cmp     w2, #0x8		// cmp the w2 to 0x8, 0x10, 0x20 to
					// select branch
	b.ne    ffff80001030f8b8
	...				// do the if-else below...

So at the gen-asm level, both of our codes are OK.  But your code is really
more saner than mine at the gen-asm level.

Thanks for your suggestion of this, I will send a new patch series soon.

Zhenyu

.




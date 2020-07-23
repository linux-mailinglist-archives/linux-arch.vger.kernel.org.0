Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E2722B6CA
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 21:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGWTdy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 15:33:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgGWTdy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jul 2020 15:33:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73CF2D6E;
        Thu, 23 Jul 2020 12:33:53 -0700 (PDT)
Received: from [192.168.178.35] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7E3F3F66E;
        Thu, 23 Jul 2020 12:33:51 -0700 (PDT)
Subject: Re: [PATCH v7 18/29] arm64: mte: Allow user control of the tag check
 mode via prctl()
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-19-catalin.marinas@arm.com>
 <e9feb87e-41a8-17e6-eeba-4038da3bdde2@arm.com>
 <20200720170050.GJ30452@arm.com>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <da31171b-283d-8478-8bc1-e8129018bbdd@arm.com>
Date:   Thu, 23 Jul 2020 20:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200720170050.GJ30452@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 20/07/2020 18:00, Dave Martin wrote:
> On Mon, Jul 20, 2020 at 04:30:35PM +0100, Kevin Brodsky wrote:
>> On 15/07/2020 18:08, Catalin Marinas wrote:
>>> By default, even if PROT_MTE is set on a memory range, there is no tag
>>> check fault reporting (SIGSEGV). Introduce a set of option to the
>>> exiting prctl(PR_SET_TAGGED_ADDR_CTRL) to allow user control of the tag
>>> check fault mode:
>>>
>>>    PR_MTE_TCF_NONE  - no reporting (default)
>>>    PR_MTE_TCF_SYNC  - synchronous tag check fault reporting
>>>    PR_MTE_TCF_ASYNC - asynchronous tag check fault reporting
>>>
>>> These options translate into the corresponding SCTLR_EL1.TCF0 bitfield,
>>> context-switched by the kernel. Note that uaccess done by the kernel is
>>> not checked and cannot be configured by the user.
>>>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> ---
>>>
>>> Notes:
>>>      v3:
>>>      - Use SCTLR_EL1_TCF0_NONE instead of 0 for consistency.
>>>      - Move mte_thread_switch() in this patch from an earlier one. In
>>>        addition, it is called after the dsb() in __switch_to() so that any
>>>        asynchronous tag check faults have been registered in the TFSR_EL1
>>>        registers (to be added with the in-kernel MTE support.
>>>      v2:
>>>      - Handle SCTLR_EL1_TCF0_NONE explicitly for consistency with PR_MTE_TCF_NONE.
>>>      - Fix SCTLR_EL1 register setting in flush_mte_state() (thanks to Peter
>>>        Collingbourne).
>>>      - Added ISB to update_sctlr_el1_tcf0() since, with the latest
>>>        architecture update/fix, the TCF0 field is used by the uaccess
>>>        routines.
> [...]
>
>>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> [...]
>
>>> +void mte_thread_switch(struct task_struct *next)
>>> +{
>>> +	if (!system_supports_mte())
>>> +		return;
>>> +
>>> +	/* avoid expensive SCTLR_EL1 accesses if no change */
>>> +	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
>> I think this could be improved by checking whether `next` is a kernel
>> thread, in which case thread.sctlr_tcf0 is 0 but there is no point in
>> setting SCTLR_EL1.TCF0, since there should not be any access via TTBR0.
> Out of interest, do we have a nice way of testing for a kernel thread
> now?

Isn't it as simple as checking if PF_KTHREAD is set in tsk->flags? At least this is 
what ssbs_thread_switch() does.

Kevin

> I remember fpsimd_thread_switch() used to check for task->mm, but we
> seem to have got rid of that at some point.  set_mm() can defeat this,
> and anyway the heavy lifting for FPSIMD is now deferred until returning
> to userspace.
>
> Cheers
> ---Dave


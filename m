Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1486F26549C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 23:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725308AbgIJV6r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 17:58:47 -0400
Received: from foss.arm.com ([217.140.110.172]:33474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbgIJLNe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Sep 2020 07:13:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A46231B;
        Thu, 10 Sep 2020 04:12:38 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 879433F68F;
        Thu, 10 Sep 2020 04:12:36 -0700 (PDT)
Subject: Re: [PATCH v9 09/29] arm64: mte: Clear the tags when a page is mapped
 in user-space with PROT_MTE
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-10-catalin.marinas@arm.com>
 <5c2ebe16-2ac9-6cff-3456-6d8ac96b5fb7@arm.com> <20200910105258.GA4030@gaia>
From:   Steven Price <steven.price@arm.com>
Message-ID: <19137fdc-64c6-a5c2-d6f6-ebcf4f553816@arm.com>
Date:   Thu, 10 Sep 2020 12:12:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910105258.GA4030@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/09/2020 11:52, Catalin Marinas wrote:
> On Thu, Sep 10, 2020 at 11:23:33AM +0100, Steven Price wrote:
>> On 04/09/2020 11:30, Catalin Marinas wrote:
>>> --- /dev/null
>>> +++ b/arch/arm64/lib/mte.S
>>> @@ -0,0 +1,34 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (C) 2020 ARM Ltd.
>>> + */
>>> +#include <linux/linkage.h>
>>> +
>>> +#include <asm/assembler.h>
>>> +#include <asm/sysreg.h>
>>> +
>>> +	.arch	armv8.5-a+memtag
>>> +
>>> +/*
>>> + * multitag_transfer_size - set \reg to the block size that is accessed by the
>>> + * LDGM/STGM instructions.
>>> + */
>>> +	.macro	multitag_transfer_size, reg, tmp
>>> +	mrs_s	\reg, SYS_GMID_EL1
>>> +	ubfx	\reg, \reg, #SYS_GMID_EL1_BS_SHIFT, #SYS_GMID_EL1_BS_SIZE
>>> +	mov	\tmp, #4
>>> +	lsl	\reg, \tmp, \reg
>>> +	.endm
>>> +
>>> +/*
>>> + * Clear the tags in a page
>>> + *   x0 - address of the page to be cleared
>>> + */
>>> +SYM_FUNC_START(mte_clear_page_tags)
>>> +	multitag_transfer_size x1, x2
>>> +1:	stgm	xzr, [x0]
>>> +	add	x0, x0, x1
>>> +	tst	x0, #(PAGE_SIZE - 1)
>>> +	b.ne	1b
>>> +	ret
>>> +SYM_FUNC_END(mte_clear_page_tags)
>>
>> Could the value of SYS_GMID_EL1 vary between CPUs and do we therefore need a
>> preempt_disable() around mte_clear_page_tags() (and other functions in later
>> patches)?
> 
> If they differ, disabling preemption here is not sufficient. We'd have
> to trap the GMID_EL1 access at EL2 as well and emulate it (we do this
> for CTR_EL0 in dcache_line_size).

Hmm, good point. It's actually not possible to properly emulate this - 
EL2 can trap GMID_EL1 to provide a different (presumably smaller) size, 
but LDGM/STGM will still read/store the number of tags of the underlying 
hardware. While simple loops like we've got at the moment won't care 
(we'll just end up doing useless work), it won't be architecturally 
correct. The guest can always deduce the underlying value. So I think we 
can safely consider this broken hardware.

> I don't want to proactively implement this just in case we'll have
> broken hardware (I feel a bit more optimistic today ;)).

Given the above I think if we do have broken hardware the only sane 
thing to do would be to provide a way of overriding 
multitag_transfer_size to return the smallest size of all CPUs. Which 
works well enough for the uses we've currently got.

Steve

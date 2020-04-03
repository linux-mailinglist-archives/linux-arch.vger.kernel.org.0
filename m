Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A219CFAE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 07:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgDCFPF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 01:15:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbgDCFPE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Apr 2020 01:15:04 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B7A21FC5A06C31E14932;
        Fri,  3 Apr 2020 13:14:32 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 3 Apr 2020
 13:14:23 +0800
Subject: Re: [RFC PATCH v5 4/8] mm: tlb: Pass struct mmu_gather to
 flush_pmd_tlb_range
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mark.rutland@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <maz@kernel.org>, <suzuki.poulose@arm.com>,
        <tglx@linutronix.de>, <yuzhao@google.com>, <Dave.Martin@arm.com>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>, <corbet@lwn.net>, <vgupta@synopsys.com>,
        <tony.luck@intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
 <20200331142927.1237-5-yezhenyu2@huawei.com>
 <20200331151331.GS20730@hirez.programming.kicks-ass.net>
 <fe12101e-8efe-22ad-0258-e6aeafc798cc@huawei.com>
 <20200401122004.GE20713@hirez.programming.kicks-ass.net>
 <53675fb9-21c7-5309-07b8-1bbc1e775f9b@huawei.com>
 <20200402163849.GM20713@hirez.programming.kicks-ass.net>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <d512b28f-99d3-5a26-d189-2ebac7a412c7@huawei.com>
Date:   Fri, 3 Apr 2020 13:14:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200402163849.GM20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On 2020/4/3 0:38, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 07:24:04PM +0800, Zhenyu Ye wrote:
>> Thanks for your detailed explanation.  I notice that you used
>> `tlb_end_vma` replace `flush_tlb_range`, which will call `tlb_flush`,
>> then finally call `flush_tlb_range` in generic code.  However, some
>> architectures define tlb_end_vma|tlb_flush|flush_tlb_range themselves,
>> so this may cause problems.
>>
>> For example, in s390, it defines:
>>
>> #define tlb_end_vma(tlb, vma)			do { } while (0)
>>
>> And it doesn't define it's own flush_pmd_tlb_range().  So there will be
>> a mistake if we changed flush_pmd_tlb_range() using tlb_end_vma().
>>
>> Is this really a problem or something I understand wrong ?
> 
> If tlb_end_vma() is a no-op, then tlb_finish_mmu() will do:
> tlb_flush_mmu() -> tlb_flush_mmu_tlbonly() -> tlb_flush()
> 
> And s390 has tlb_flush().
> 
> If tlb_end_vma() is not a no-op and it calls tlb_flush_mmu_tlbonly(),
> then tlb_finish_mmu()'s invocation of tlb_flush_mmu_tlbonly() will
> terniate early due o no flags set.
> 
> IOW, it should all just work.
> 
> 
> FYI the whole tlb_{start,end}_vma() thing is a only needed when the
> architecture doesn't implement tlb_flush() and instead default to using
> flush_tlb_range(), at which point we need to provide a 'fake' vma.
> 
> At the time I audited all architectures and they only look at VM_EXEC
> (to do $I invalidation) and VM_HUGETLB (for pmd level invalidations),
> but I forgot which architectures that were.

Many architectures, such as alpha, arc, arm and so on.
I really understand why you hate making vma->vm_flags more important for
tlbi :).

> But that is all legacy code; eventually we'll get all archs a native
> tlb_flush() and this can go away.
> 

Thanks for your reply.  Currently, to enable the TTL feature, extending
the flush_*tlb_range() may be more convenient.
I will send a formal PATCH soon.

Thanks,
Zhenyu


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83EC192ADE
	for <lists+linux-arch@lfdr.de>; Wed, 25 Mar 2020 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgCYONi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Mar 2020 10:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727595AbgCYONi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Mar 2020 10:13:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF89020775;
        Wed, 25 Mar 2020 14:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585145616;
        bh=qlOAQRMIm0GGFaeho3ziBvwjLtET2PoABAy89OgzKyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SkrWAIq4H7pJ9y+jlvN4oV22fQbkmHoHKIwDWNuWYUxRxlW07Y3N+34rJaTgnIab5
         Inq/zbIIU5aU2ETLSgghqV77vrwcY3oxWPrDhboudGzOyz2iUYz5j0hYOUVBdjHEiK
         VY7RVN5r0uma6A/LZxPJaMBeKAlWr13ZCKUYzWNg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jH6ml-00Far0-2B; Wed, 25 Mar 2020 14:13:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Mar 2020 14:13:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de,
        rostedt@goodmis.org, suzuki.poulose@arm.com, tglx@linutronix.de,
        yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com,
        broonie@kernel.org, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com
Subject: Re: [RFC PATCH v4 5/6] arm64: tlb: Use translation level hint in
 vm_flags
In-Reply-To: <986be927-02c6-3cc2-ca39-30ccad60eae0@huawei.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <20200324134534.1570-6-yezhenyu2@huawei.com> <20200324144514.340c78d9@why>
 <986be927-02c6-3cc2-ca39-30ccad60eae0@huawei.com>
Message-ID: <2f4cb3ef52c5589b388225e487651a2b@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yezhenyu2@huawei.com, will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de, rostedt@goodmis.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-03-25 08:00, Zhenyu Ye wrote:
> Hi Marc,
> 
> Thanks for your review.
> 
> On 2020/3/24 22:45, Marc Zyngier wrote:
>> On Tue, 24 Mar 2020 21:45:33 +0800
>> Zhenyu Ye <yezhenyu2@huawei.com> wrote:
>> 
>>> This patch used the VM_LEVEL flags in vma->vm_flags to set the
>>> TTL field in tlbi instruction.
>>> 
>>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>>> ---
>>>  arch/arm64/include/asm/mmu.h      |  2 ++
>>>  arch/arm64/include/asm/tlbflush.h | 14 ++++++++------
>>>  arch/arm64/mm/mmu.c               | 14 ++++++++++++++
>>>  3 files changed, 24 insertions(+), 6 deletions(-)
>>> 
>>> diff --git a/arch/arm64/include/asm/mmu.h 
>>> b/arch/arm64/include/asm/mmu.h
>>> index d79ce6df9e12..a8b8824a7405 100644
>>> --- a/arch/arm64/include/asm/mmu.h
>>> +++ b/arch/arm64/include/asm/mmu.h
>>> @@ -86,6 +86,8 @@ extern void create_pgd_mapping(struct mm_struct 
>>> *mm, phys_addr_t phys,
>>>  extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, 
>>> pgprot_t prot);
>>>  extern void mark_linear_text_alias_ro(void);
>>>  extern bool kaslr_requires_kpti(void);
>>> +extern unsigned int get_vma_level(struct vm_area_struct *vma);
>>> +
>>> 
>>>  #define INIT_MM_CONTEXT(name)	\
>>>  	.pgd = init_pg_dir,
>>> diff --git a/arch/arm64/include/asm/tlbflush.h 
>>> b/arch/arm64/include/asm/tlbflush.h
>>> index d141c080e494..93bb09fdfafd 100644
>>> --- a/arch/arm64/include/asm/tlbflush.h
>>> +++ b/arch/arm64/include/asm/tlbflush.h
>>> @@ -218,10 +218,11 @@ static inline void flush_tlb_page_nosync(struct 
>>> vm_area_struct *vma,
>>>  					 unsigned long uaddr)
>>>  {
>>>  	unsigned long addr = __TLBI_VADDR(uaddr, ASID(vma->vm_mm));
>>> +	unsigned int level = get_vma_level(vma);
>>> 
>>>  	dsb(ishst);
>>> -	__tlbi_level(vale1is, addr, 0);
>>> -	__tlbi_user_level(vale1is, addr, 0);
>>> +	__tlbi_level(vale1is, addr, level);
>>> +	__tlbi_user_level(vale1is, addr, level);
>>>  }
>>> 
>>>  static inline void flush_tlb_page(struct vm_area_struct *vma,
>>> @@ -242,6 +243,7 @@ static inline void __flush_tlb_range(struct 
>>> vm_area_struct *vma,
>>>  				     unsigned long stride, bool last_level)
>>>  {
>>>  	unsigned long asid = ASID(vma->vm_mm);
>>> +	unsigned int level = get_vma_level(vma);
>>>  	unsigned long addr;
>>> 
>>>  	start = round_down(start, stride);
>>> @@ -261,11 +263,11 @@ static inline void __flush_tlb_range(struct 
>>> vm_area_struct *vma,
>>>  	dsb(ishst);
>>>  	for (addr = start; addr < end; addr += stride) {
>>>  		if (last_level) {
>>> -			__tlbi_level(vale1is, addr, 0);
>>> -			__tlbi_user_level(vale1is, addr, 0);
>>> +			__tlbi_level(vale1is, addr, level);
>>> +			__tlbi_user_level(vale1is, addr, level);
>>>  		} else {
>>> -			__tlbi_level(vae1is, addr, 0);
>>> -			__tlbi_user_level(vae1is, addr, 0);
>>> +			__tlbi_level(vae1is, addr, level);
>>> +			__tlbi_user_level(vae1is, addr, level);
>>>  		}
>>>  	}
>>>  	dsb(ish);
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 128f70852bf3..e6a1221cd86b 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -60,6 +60,20 @@ static pud_t bm_pud[PTRS_PER_PUD] 
>>> __page_aligned_bss __maybe_unused;
>>> 
>>>  static DEFINE_SPINLOCK(swapper_pgdir_lock);
>>> 
>>> +inline unsigned int get_vma_level(struct vm_area_struct *vma)
>>> +{
>>> +	unsigned int level = 0;
>>> +	if (vma->vm_flags & VM_LEVEL_PUD)
>>> +		level = 1;
>>> +	else if (vma->vm_flags & VM_LEVEL_PMD)
>>> +		level = 2;
>>> +	else if (vma->vm_flags & VM_LEVEL_PTE)
>>> +		level = 3;
>>> +
>>> +	vma->vm_flags &= ~(VM_LEVEL_PUD | VM_LEVEL_PMD | VM_LEVEL_PTE);
>>> +	return level;
>>> +}
>>> +
>>>  void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>>>  {
>>>  	pgd_t *fixmap_pgdp;
>> 
>> 
>> If feels bizarre a TLBI is now a destructive operation: you've lost 
>> the
>> flags by having cleared them. Even if that's not really a problem in
>> practice (you issue TLBI because you've unmapped the VMA), it remains
>> that the act of invalidating TLBs isn't expected to change a kernel
>> structure (and I'm not even thinking about potential races here).
> 
> I cleared vm_flags here just out of caution, because every TLBI flush
> action should set vm_flags themself. As I know, the TLB_LEVEL of an vma
> will only be changed by transparent hugepage collapse and merge when
> the page is not mapped, so there may not have potential races.
> 
> But you are right that TLBI should't change a kernel structure.
> I will remove the clear action and add some notices here.

More than that. You are changing the VMA flags at TLBI time already,
when calling get_vma_level(). That is already unacceptable -- I don't
think (and Peter will certainly correct me if I'm wrong) that you
are allowed to change the flags on that code path, as you probably
don't hold the write_lock.

>> If anything, I feel this should be based around the mmu_gather
>> structure, which already tracks the right level of information and
>> additionally knows about the P4D level which is missing in your 
>> patches
>> (even if arm64 is so far limited to 4 levels).
>> 
>> Thanks,
>> 
>> 	M.
>> 
> 
> mmu_gather structure has tracked the level information, but we can only
> use the info in the tlb_flush interface. If we want to use the info in
> flush_tlb_range, we may should have to add a parameter to this 
> interface,
> such as:
> 
> 	flush_tlb_range(vma, start, end, flags);
> 
> However, the flush_tlb_range is a common interface to all 
> architectures,
> I'm not sure if this is feasible because this feature is only supported
> by ARM64 currently.

You could always build an on-stack mmu_gather structure and pass it down
to the TLB invalidation helpers.

And frankly, you are not going to be able to fit such a change in the
way Linux deals with TLBs by adding hacks at the periphery. You'll need
to change some of the core abstractions.

Finally, as Peter mentioned separately, there is Power9 which has 
similar
instructions, and could make use of it too. So that's yet another reason
to stop hacking at the arch level.

> 
> Or can we ignore the flush_tlb_range and only set the TTL field in
> tlb_flush?  Waiting for your suggestion...

You could, but you could also ignore TTL altogether (what's the point
in only having half of it?). See my suggestion above.

> For P4D level, the TTL field is limited to 4 bit(2 for translation 
> granule
> and 2 for page table level), so we can no longer afford more levels :).

You clearly didn't read the bit that said "even if arm64 is so far 
limited
to 4 levels". But again, this is Linux, a multi-architecture kernel, and
not an arm64-special. Changes you make have to work for all 
architectures,
and be extensible enough for future changes.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

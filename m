Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07B01A1C63
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 09:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgDHHMR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 03:12:17 -0400
Received: from foss.arm.com ([217.140.110.172]:34992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgDHHMR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 03:12:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AED131B;
        Wed,  8 Apr 2020 00:12:15 -0700 (PDT)
Received: from [10.163.1.2] (unknown [10.163.1.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 246B63F68F;
        Wed,  8 Apr 2020 00:16:17 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 0/3] mm/debug: Add more arch page table helper tests
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     linux-mm@kvack.org, christophe.leroy@c-s.fr,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
 <20200331143059.29fca8fa@thinkpad>
 <e3e35885-6852-16aa-3889-e22750a0cc87@arm.com>
 <20200407175440.41cc00a5@thinkpad>
Message-ID: <253cf5c8-e43e-5737-24e8-3eda3b6ba7b3@arm.com>
Date:   Wed, 8 Apr 2020 12:41:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200407175440.41cc00a5@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 04/07/2020 09:24 PM, Gerald Schaefer wrote:
> On Sun, 5 Apr 2020 17:58:14 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
> [...]
>>>
>>> Could be fixed like this (the first de-reference is a bit special,
>>> because at that point *ptep does not really point to a large (pmd) entry
>>> yet, it is initially an invalid pte entry, which breaks our huge_ptep_get()  
>>
>> There seems to be an inconsistency on s390 platform. Even though it defines
>> a huge_ptep_get() override, it does not subscribe __HAVE_ARCH_HUGE_PTEP_GET
>> which should have forced it fallback on generic huge_ptep_get() but it does
>> not :) Then I realized that __HAVE_ARCH_HUGE_PTEP_GET only makes sense when
>> an arch uses <asm-generic/hugetlb.h>. s390 does not use that and hence gets
>> away with it's own huge_ptep_get() without __HAVE_ARCH_HUGE_PTEP_GET. Sounds
>> confusing ? But I might not have the entire context here.
> 
> Yes, that sounds very confusing. Also a bit ironic, since huge_ptep_get()
> was initially introduced because of s390, and now we don't select
> __HAVE_ARCH_HUGE_PTEP_GET...
> 
> As you realized, I guess this is because we do not use generic hugetlb.h.
> And when __HAVE_ARCH_HUGE_PTEP_GET was introduced with commit 544db7597ad
> ("hugetlb: introduce generic version of huge_ptep_get"), that was probably
> the reason why we did not get our share of __HAVE_ARCH_HUGE_PTEP_GET.

Understood.

> 
> Nothing really wrong with that, but yes, very confusing. Maybe we could
> also select it for s390, even though it wouldn't have any functional
> impact (so far), just for less confusion. Maybe also thinking about
> using the generic hugetlb.h, not sure if the original reasons for not
> doing so would still apply. Now I only need to find the time...

Seems like something worth to explore if we could remove this confusion.

> 
>>
>>> conversion logic. I also added PMD_MASK alignment for RANDOM_ORVALUE,
>>> because we do have some special bits there in our large pmds. It seems
>>> to also work w/o that alignment, but it feels a bit wrong):  
>>
>> Sure, we can accommodate that.
>>
>>>
>>> @@ -731,26 +731,26 @@ static void __init hugetlb_advanced_test
>>>                                           unsigned long vaddr, pgprot_t prot)
>>>  {
>>>         struct page *page = pfn_to_page(pfn);
>>> -       pte_t pte = READ_ONCE(*ptep);
>>> +       pte_t pte;
>>>
>>> -       pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
>>> +       pte = pte_mkhuge(mk_pte_phys(RANDOM_ORVALUE & PMD_MASK, prot));  
>>
>> So that keeps the existing value in 'ptep' pointer at bay and instead
>> construct a PTE from scratch. I would rather have READ_ONCE(*ptep) at
>> least provide the seed that can be ORed with RANDOM_ORVALUE before
>> being masked with PMD_MASK. Do you see any problem ?
> 
> Yes, unfortunately. The problem is that the resulting pte is not marked
> as present. The conversion pte -> (huge) pmd, which is done in
> set_huge_pte_at() for s390, will establish an empty pmd for non-present
> ptes, all the RANDOM_ORVALUE stuff is lost. And a subsequent
> huge_ptep_get() will not result in the same original pte value. If you

Ohh.

> want to preserve and check the RANDOM_ORVALUE, it has to be a present
> pte, hence the mk_pte(_phys).

Understood and mk_pte() is also available on all platforms.

> 
>>
>> Some thing like this instead.
>>
>> pte_t pte = READ_ONCE(*ptep);
>> pte = pte_mkhuge(__pte((pte_val(pte) | RANDOM_ORVALUE) & PMD_MASK));
>>
>> We cannot use mk_pte_phys() as it is defined only on some platforms
>> without any generic fallback for others.
> 
> Oh, didn't know that, sorry. What about using mk_pte() instead, at least
> it would result in a present pte:
> 
> pte = pte_mkhuge(mk_pte(phys_to_page(RANDOM_ORVALUE & PMD_MASK), prot));

Lets use mk_pte() here but can we do this instead

paddr = (__pfn_to_phys(pfn) | RANDOM_ORVALUE) & PMD_MASK;
pte = pte_mkhuge(mk_pte(phys_to_page(paddr), prot));

> 
> And if you also want to do some with the existing value, which seems
> to be an empty pte, then maybe just check if writing and reading that
> value with set_huge_pte_at() / huge_ptep_get() returns the same,
> i.e. initially w/o RANDOM_ORVALUE.
> 
> So, in combination, like this (BTW, why is the barrier() needed, it
> is not used for the other set_huge_pte_at() calls later?):

Ahh missed, will add them. Earlier we faced problem without it after
set_pte_at() for a test on powerpc (64) platform. Hence just added it
here to be extra careful.

> 
> @@ -733,24 +733,28 @@ static void __init hugetlb_advanced_test
>         struct page *page = pfn_to_page(pfn);
>         pte_t pte = READ_ONCE(*ptep);
>  
> -       pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
> +       set_huge_pte_at(mm, vaddr, ptep, pte);
> +       WARN_ON(!pte_same(pte, huge_ptep_get(ptep)));
> +
> +       pte = pte_mkhuge(mk_pte(phys_to_page(RANDOM_ORVALUE & PMD_MASK), prot));
>         set_huge_pte_at(mm, vaddr, ptep, pte);
>         barrier();
>         WARN_ON(!pte_same(pte, huge_ptep_get(ptep)));
> 
> This would actually add a new test "write empty pte with
> set_huge_pte_at(), then verify with huge_ptep_get()", which happens
> to trigger a warning on s390 :-)

On arm64 as well which checks for pte_present() in set_huge_pte_at().
But PTE present check is not really present in each set_huge_pte_at()
implementation especially without __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT.
Hence wondering if we should add this new test here which will keep
giving warnings on s390 and arm64 (at the least).

> 
> That (new) warning actually points to misbehavior on s390, we do not
> write a correct empty pmd in this case, but one that is empty and also
> marked as large. huge_ptep_get() will then not correctly recognize it
> as empty and do wrong conversion. It is also not consistent with
> huge_ptep_get_and_clear(), where we write the empty pmd w/o marking
> as large. Last but not least it would also break our pmd_protnone()
> logic (see below). Another nice finding on s390 :-)

:) 

> 
> I don't think this has any effect in practice (yet), but I will post a
> fix for that, just in case you will add / change this test.

Okay.

> 
>>
>>>         set_huge_pte_at(mm, vaddr, ptep, pte);
>>>         barrier();
>>>         WARN_ON(!pte_same(pte, huge_ptep_get(ptep)));
>>>         huge_pte_clear(mm, vaddr, ptep, PMD_SIZE);
>>> -       pte = READ_ONCE(*ptep);
>>> +       pte = huge_ptep_get(ptep);
>>>         WARN_ON(!huge_pte_none(pte));
>>>  
>>>         pte = mk_huge_pte(page, prot);
>>>         set_huge_pte_at(mm, vaddr, ptep, pte);
>>>         huge_ptep_set_wrprotect(mm, vaddr, ptep);
>>> -       pte = READ_ONCE(*ptep);
>>> +       pte = huge_ptep_get(ptep);
>>>         WARN_ON(huge_pte_write(pte));
>>>  
>>>         pte = mk_huge_pte(page, prot);
>>>         set_huge_pte_at(mm, vaddr, ptep, pte);
>>>         huge_ptep_get_and_clear(mm, vaddr, ptep);
>>> -       pte = READ_ONCE(*ptep);
>>> +       pte = huge_ptep_get(ptep);
>>>         WARN_ON(!huge_pte_none(pte));
>>>  
>>>         pte = mk_huge_pte(page, prot);
>>> @@ -759,7 +759,7 @@ static void __init hugetlb_advanced_test
>>>         pte = huge_pte_mkwrite(pte);
>>>         pte = huge_pte_mkdirty(pte);
>>>         huge_ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
>>> -       pte = READ_ONCE(*ptep);
>>> +       pte = huge_ptep_get(ptep);
>>>         WARN_ON(!(huge_pte_write(pte) && huge_pte_dirty(pte)));
>>>  }
>>>  #else
>>>
>>> 3) The pmd_protnone_tests() has an issue, because it passes a pmd to
>>> pmd_protnone() which has not been marked as large. We check for large
>>> pmd in the s390 implementation of pmd_protnone(), and will fail if a
>>> pmd is not large. We had similar issues before, in other helpers, where
>>> I changed the logic on s390 to not require the pmd large check, but I'm
>>> not so sure in this case. Is there a valid use case for doing
>>> pmd_protnone() on "normal" pmds? Or could this be changed like this:  
>>
>> That is a valid question. IIUC, all existing callers for pmd_protnone()
>> ensure that it is indeed a huge PMD. But even assuming otherwise should
>> not the huge PMD requirement get checked in the caller itself rather than
>> in the arch helper which is just supposed to check the existence of the
>> dedicated PTE bit(s) for this purpose. Purely from a helper perspective
>> pmd_protnone() should not really care about being large even though it
>> might never get used without one.
>>
>> Also all platforms (except s390) derive the pmd_protnone() from their
>> respective pte_protnone(). I wonder why should s390 be any different
>> unless it is absolutely necessary.
> 
> This is again because of our different page table entry layouts for
> pte/pmd and (large) pmd. The bits we check for pmd_protnone() are
> not valid for normal pmd/pte, and we would return undefined result for
> normal entries.
> 
> Of course, we could rely on nobody calling pmd_protnone() on normal
> pmds, but in this case we also use pmd_large() check in pmd_protnone()
> for indication if the pmd is present. W/o that, we would return
> true for empty pmds, that doesn't sound right. Not sure if we also
> want to rely on nobody calling pmd_protnone() on empty pmds.

That might be problematic.

> 
> Anyway, if in practice it is not correct to use pmd_protnone()
> on normal pmds, then I would suggest that your tests should also
> not do / test it. And I strongly assume that it is not correct, at
> least I cannot think of a valid case, and of course s390 would
> already be broken if there was such a case.

Okay, will use huge PMD here as you had suggested earlier.

> 
> Regards,
> Gerald
> 
> 

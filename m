Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7119EB37
	for <lists+linux-arch@lfdr.de>; Sun,  5 Apr 2020 14:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDEM2d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Apr 2020 08:28:33 -0400
Received: from foss.arm.com ([217.140.110.172]:39040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgDEM2d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Apr 2020 08:28:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8481F31B;
        Sun,  5 Apr 2020 05:28:32 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD9653F68F;
        Sun,  5 Apr 2020 05:28:22 -0700 (PDT)
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
Message-ID: <e3e35885-6852-16aa-3889-e22750a0cc87@arm.com>
Date:   Sun, 5 Apr 2020 17:58:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200331143059.29fca8fa@thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/31/2020 06:00 PM, Gerald Schaefer wrote:
> On Tue, 24 Mar 2020 10:52:52 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> This series adds more arch page table helper tests. The new tests here are
>> either related to core memory functions and advanced arch pgtable helpers.
>> This also creates a documentation file enlisting all expected semantics as
>> suggested by Mike Rapoport (https://lkml.org/lkml/2020/1/30/40).
>>
>> This series has been tested on arm64 and x86 platforms. There is just one
>> expected failure on arm64 that will be fixed when we enable THP migration.
>>
>> [   21.741634] WARNING: CPU: 0 PID: 1 at mm/debug_vm_pgtable.c:782
>>
>> which corresponds to
>>
>> WARN_ON(!pmd_present(pmd_mknotpresent(pmd_mkhuge(pmd))))
>>
>> There are many TRANSPARENT_HUGEPAGE and ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD
>> ifdefs scattered across the test. But consolidating all the fallback stubs
>> is not very straight forward because ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD is
>> not explicitly dependent on ARCH_HAS_TRANSPARENT_HUGEPAGE.
>>
>> This series has been build tested on many platforms including the ones that
>> subscribe the test through ARCH_HAS_DEBUG_VM_PGTABLE.
>>
> 
> Hi Anshuman,
> 
> thanks for the update. There are a couple of issues on s390, some might
> also affect other archs.

Sure, thanks for taking a look and giving it a spin on s390.

> 
> 1) The pxd_huge_tests are using pxd_set/clear_huge, which defaults to
> returning 0 if !CONFIG_HAVE_ARCH_HUGE_VMAP. As result, the checks for
> !pxd_test/clear_huge in the pxd_huge_tests will always trigger the
> warning. This should affect all archs w/o CONFIG_HAVE_ARCH_HUGE_VMAP.
> Could be fixed like this:
> 
> @@ -923,8 +923,10 @@ void __init debug_vm_pgtable(void)
>         pmd_leaf_tests(pmd_aligned, prot);
>         pud_leaf_tests(pud_aligned, prot);
>  
> -       pmd_huge_tests(pmdp, pmd_aligned, prot);
> -       pud_huge_tests(pudp, pud_aligned, prot);
> +       if (IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMAP)) {
> +               pmd_huge_tests(pmdp, pmd_aligned, prot);
> +               pud_huge_tests(pudp, pud_aligned, prot);
> +       }

That is correct. It was an omission on my part and will fix it.

>  
>         pte_savedwrite_tests(pte_aligned, prot);
>         pmd_savedwrite_tests(pmd_aligned, prot);
> 
> BTW, please add some comments to the various #ifdef/#else stuff, especially
> when the different parts are far away and/or nested.

Sure, will do.

> 
> 2) The hugetlb_advanced_test will fail because it directly de-references
> huge *ptep pointers instead of using huge_ptep_get() for this. We have
> very different pagetable entry layout for pte and (large) pmd on s390,
> and unfortunately the whole hugetlbfs code is using pte_t instead of pmd_t
> like THP. For this reason, huge_ptep_get() was introduced, which will
> return a "converted" pte, because directly reading from a *ptep (pointing
> to a large pmd) will not return a proper pte. Only ARM has also an
> implementation of huge_ptep_get(), so they could be affected, depending
> on what exactly they need it for.

Currently, we dont support ARM (32). But as huge_ptep_get() already got a
fallback, its better to use that than a direct READ_ONCE().

> 
> Could be fixed like this (the first de-reference is a bit special,
> because at that point *ptep does not really point to a large (pmd) entry
> yet, it is initially an invalid pte entry, which breaks our huge_ptep_get()

There seems to be an inconsistency on s390 platform. Even though it defines
a huge_ptep_get() override, it does not subscribe __HAVE_ARCH_HUGE_PTEP_GET
which should have forced it fallback on generic huge_ptep_get() but it does
not :) Then I realized that __HAVE_ARCH_HUGE_PTEP_GET only makes sense when
an arch uses <asm-generic/hugetlb.h>. s390 does not use that and hence gets
away with it's own huge_ptep_get() without __HAVE_ARCH_HUGE_PTEP_GET. Sounds
confusing ? But I might not have the entire context here.

> conversion logic. I also added PMD_MASK alignment for RANDOM_ORVALUE,
> because we do have some special bits there in our large pmds. It seems
> to also work w/o that alignment, but it feels a bit wrong):

Sure, we can accommodate that.

> 
> @@ -731,26 +731,26 @@ static void __init hugetlb_advanced_test
>                                           unsigned long vaddr, pgprot_t prot)
>  {
>         struct page *page = pfn_to_page(pfn);
> -       pte_t pte = READ_ONCE(*ptep);
> +       pte_t pte;
> 
> -       pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
> +       pte = pte_mkhuge(mk_pte_phys(RANDOM_ORVALUE & PMD_MASK, prot));

So that keeps the existing value in 'ptep' pointer at bay and instead
construct a PTE from scratch. I would rather have READ_ONCE(*ptep) at
least provide the seed that can be ORed with RANDOM_ORVALUE before
being masked with PMD_MASK. Do you see any problem ?

Some thing like this instead.

pte_t pte = READ_ONCE(*ptep);
pte = pte_mkhuge(__pte((pte_val(pte) | RANDOM_ORVALUE) & PMD_MASK));

We cannot use mk_pte_phys() as it is defined only on some platforms
without any generic fallback for others.

>         set_huge_pte_at(mm, vaddr, ptep, pte);
>         barrier();
>         WARN_ON(!pte_same(pte, huge_ptep_get(ptep)));
>         huge_pte_clear(mm, vaddr, ptep, PMD_SIZE);
> -       pte = READ_ONCE(*ptep);
> +       pte = huge_ptep_get(ptep);
>         WARN_ON(!huge_pte_none(pte));
>  
>         pte = mk_huge_pte(page, prot);
>         set_huge_pte_at(mm, vaddr, ptep, pte);
>         huge_ptep_set_wrprotect(mm, vaddr, ptep);
> -       pte = READ_ONCE(*ptep);
> +       pte = huge_ptep_get(ptep);
>         WARN_ON(huge_pte_write(pte));
>  
>         pte = mk_huge_pte(page, prot);
>         set_huge_pte_at(mm, vaddr, ptep, pte);
>         huge_ptep_get_and_clear(mm, vaddr, ptep);
> -       pte = READ_ONCE(*ptep);
> +       pte = huge_ptep_get(ptep);
>         WARN_ON(!huge_pte_none(pte));
>  
>         pte = mk_huge_pte(page, prot);
> @@ -759,7 +759,7 @@ static void __init hugetlb_advanced_test
>         pte = huge_pte_mkwrite(pte);
>         pte = huge_pte_mkdirty(pte);
>         huge_ptep_set_access_flags(vma, vaddr, ptep, pte, 1);
> -       pte = READ_ONCE(*ptep);
> +       pte = huge_ptep_get(ptep);
>         WARN_ON(!(huge_pte_write(pte) && huge_pte_dirty(pte)));
>  }
>  #else
> 
> 3) The pmd_protnone_tests() has an issue, because it passes a pmd to
> pmd_protnone() which has not been marked as large. We check for large
> pmd in the s390 implementation of pmd_protnone(), and will fail if a
> pmd is not large. We had similar issues before, in other helpers, where
> I changed the logic on s390 to not require the pmd large check, but I'm
> not so sure in this case. Is there a valid use case for doing
> pmd_protnone() on "normal" pmds? Or could this be changed like this:

That is a valid question. IIUC, all existing callers for pmd_protnone()
ensure that it is indeed a huge PMD. But even assuming otherwise should
not the huge PMD requirement get checked in the caller itself rather than
in the arch helper which is just supposed to check the existence of the
dedicated PTE bit(s) for this purpose. Purely from a helper perspective
pmd_protnone() should not really care about being large even though it
might never get used without one.

Also all platforms (except s390) derive the pmd_protnone() from their
respective pte_protnone(). I wonder why should s390 be any different
unless it is absolutely necessary.

> 
> @@ -537,7 +537,7 @@ static void __init pte_protnone_tests(un
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static void __init pmd_protnone_tests(unsigned long pfn, pgprot_t prot)
>  {
> -       pmd_t pmd = pfn_pmd(pfn, prot);
> +       pmd_t pmd = mk_huge_pmd(pfn_to_page(pfn), prot);
> 
>         if (!IS_ENABLED(CONFIG_NUMA_BALANCING))
>                 return;
> 
> Regards,
> Gerald
> 
> 

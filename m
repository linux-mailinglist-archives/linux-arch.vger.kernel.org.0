Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C11C196DE0
	for <lists+linux-arch@lfdr.de>; Sun, 29 Mar 2020 16:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgC2OWL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 Mar 2020 10:22:11 -0400
Received: from foss.arm.com ([217.140.110.172]:58914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727488AbgC2OWL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 29 Mar 2020 10:22:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5D9C31B;
        Sun, 29 Mar 2020 07:22:10 -0700 (PDT)
Received: from [10.163.1.70] (unknown [10.163.1.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 542D63F68F;
        Sun, 29 Mar 2020 07:22:01 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 0/3] mm/debug: Add more arch page table helper tests
To:     Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
 <2bb4badc-2b7a-e15d-a99b-b1bd38c9d9bf@arm.com>
 <a46d18ed-8911-1ec3-c32f-58b6e0d959d7@c-s.fr>
 <9675882f-0ec5-5e46-551f-dd3aa38bf8d8@arm.com>
 <ef28cb75-40b8-5ab5-83ba-84fd4384c7c5@c-s.fr>
Message-ID: <bf4558b2-1fe9-f0cc-3e6f-34bdf3734056@arm.com>
Date:   Sun, 29 Mar 2020 19:51:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ef28cb75-40b8-5ab5-83ba-84fd4384c7c5@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 03/27/2020 12:30 PM, Christophe Leroy wrote:
> 
> 
> On 03/27/2020 06:46 AM, Anshuman Khandual wrote:
>>
>> On 03/26/2020 08:53 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 26/03/2020 à 03:23, Anshuman Khandual a écrit :
>>>>
>>>>
>>>> On 03/24/2020 10:52 AM, Anshuman Khandual wrote:
>>>>> This series adds more arch page table helper tests. The new tests here are
>>>>> either related to core memory functions and advanced arch pgtable helpers.
>>>>> This also creates a documentation file enlisting all expected semantics as
>>>>> suggested by Mike Rapoport (https://lkml.org/lkml/2020/1/30/40).
>>>>>
>>>>> This series has been tested on arm64 and x86 platforms.
>>>>
>>>> If folks can test these patches out on remaining ARCH_HAS_DEBUG_VM_PGTABLE
>>>> enabled platforms i.e s390, arc, powerpc (32 and 64), that will be really
>>>> appreciated. Thank you.
>>>>
>>>
>>> On powerpc 8xx (PPC32), I get:
>>>
>>> [   53.338368] debug_vm_pgtable: debug_vm_pgtable: Validating architecture page table helpers
>>> [   53.347403] ------------[ cut here ]------------
>>> [   53.351832] WARNING: CPU: 0 PID: 1 at mm/debug_vm_pgtable.c:647 debug_vm_pgtable+0x280/0x3f4
>>
>> mm/debug_vm_pgtable.c:647 ?
>>
>> With the following commits in place
>>
>> 53a8338ce (HEAD) Documentation/mm: Add descriptions for arch page table helper
>> 5d4913fc1 mm/debug: Add tests validating arch advanced page table helpers
>> bcaf120a7 mm/debug: Add tests validating arch page table helpers for core features
>> d6ed5a4a5 x86/memory: Drop pud_mknotpresent()
>> 0739d1f8d mm/debug: Add tests validating architecture page table helpers
>> 16fbf79b0 (tag: v5.6-rc7) Linux 5.6-rc7
> 
> I have:
> 
> facaa5eb5909 (HEAD -> helpers0) mm/debug: Add tests validating arch advanced page table helpers
> 6389fed515fc mm/debug: Add tests validating arch page table helpers for core features
> dc14ecc8b94e mm/debug: add tests validating architecture page table helpers
> c6624071c338 (origin/merge, merge) Automatic merge of branches 'master', 'next' and 'fixes' into merge
> 58e05c5508e6 Automatic merge of branches 'master', 'next' and 'fixes' into merge
> 1b649e0bcae7 (origin/master, origin/HEAD) Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> 
> origin is https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
> 
> I can't see your last patch in powerpc mailing list (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=166237)

My bad, did not update the last patch with required lists (will fix).

> 
>>
>> mm/debug_vm_pgtable.c:647 is here.
> 
> Line 647 is:
> 
>     WARN_ON(!pte_same(pte, __swp_entry_to_pte(swp)));

Both set of definitions suggest that the last three bits (if present)
on the PTE will be discarded during PTE->SWP->PTE conversion which
might be leading to this mismatch and subsequent failure.

arch/powerpc/include/asm/nohash/32/pgtable.h
arch/powerpc/include/asm/book3s/32/pgtable.h

#define __pte_to_swp_entry(pte)         ((swp_entry_t) { pte_val(pte) >> 3 })
#define __swp_entry_to_pte(x)           ((pte_t) { (x).val << 3 })

Also there are some more architectures (microblaze, sh, etc) where these
conversions are not always preserving. On powerpc64, it sets back _PAGE_PTE
irrespective of whether the bit was originally set or not.

Probably it is wrong to expect that PTE->SWP->PTE conversion will be always
preserving. So wondering if it is worth changing this test to accommodate
all such architectures or just drop it instead.

> 
> 
>>
>> #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
>> static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
>> {
>>          swp_entry_t swp;
>>          pmd_t pmd;  -----------------------------> Line #647
>>
>>          pmd = pfn_pmd(pfn, prot);
>>          swp = __pmd_to_swp_entry(pmd);
>>          WARN_ON(!pmd_same(pmd, __swp_entry_to_pmd(swp)));
>> }
>> #else
>> static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot) { }
>> #end
>>
>> Did I miss something ?
>>
> 
> [...]
> 
>> Could you please point me to the exact test which is failing ?
>>
>>> [   53.519778] Freeing unused kernel memory: 608K
>>>
>>>
>> So I assume that the system should have come till runtime just fine apart from
>> the above warning message because.
>>
> 
> Yes it boots fine otherwise.

Cool, that is good to know.

> 
> Christophe
> 

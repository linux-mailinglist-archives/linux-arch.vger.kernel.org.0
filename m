Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F8C20C015
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 10:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgF0IRx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 04:17:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46046 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgF0IRx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jun 2020 04:17:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49v67c3vRsz9tyVp;
        Sat, 27 Jun 2020 10:17:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id LVJHe2PffxRU; Sat, 27 Jun 2020 10:17:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49v67c2nSlz9tyVn;
        Sat, 27 Jun 2020 10:17:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ACB498B772;
        Sat, 27 Jun 2020 10:17:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i_8AMg20BFyg; Sat, 27 Jun 2020 10:17:49 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C3F508B75B;
        Sat, 27 Jun 2020 10:17:47 +0200 (CEST)
Subject: Re: [PATCH V3 0/4] mm/debug_vm_pgtable: Add some more tests
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     christophe.leroy@c-s.fr, ziy@nvidia.com,
        gerald.schaefer@de.ibm.com, Jonathan Corbet <corbet@lwn.net>,
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
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
 <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <0ed75013-6ac4-3902-391a-1f7152510c6d@csgroup.eu>
Date:   Sat, 27 Jun 2020 10:17:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 24/06/2020 à 05:13, Anshuman Khandual a écrit :
> 
> 
> On 06/15/2020 09:07 AM, Anshuman Khandual wrote:
>> This series adds some more arch page table helper validation tests which
>> are related to core and advanced memory functions. This also creates a
>> documentation, enlisting expected semantics for all page table helpers as
>> suggested by Mike Rapoport previously (https://lkml.org/lkml/2020/1/30/40).
>>
>> There are many TRANSPARENT_HUGEPAGE and ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD
>> ifdefs scattered across the test. But consolidating all the fallback stubs
>> is not very straight forward because ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD is
>> not explicitly dependent on ARCH_HAS_TRANSPARENT_HUGEPAGE.
>>
>> Tested on arm64, x86 platforms but only build tested on all other enabled
>> platforms through ARCH_HAS_DEBUG_VM_PGTABLE i.e powerpc, arc, s390. The
>> following failure on arm64 still exists which was mentioned previously. It
>> will be fixed with the upcoming THP migration on arm64 enablement series.
>>
>> WARNING .... mm/debug_vm_pgtable.c:860 debug_vm_pgtable+0x940/0xa54
>> WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))))
>>
>> This series is based on v5.8-rc1.
>>
>> Changes in V3:
>>
>> - Replaced HAVE_ARCH_SOFT_DIRTY with MEM_SOFT_DIRTY
>> - Added HAVE_ARCH_HUGE_VMAP checks in pxx_huge_tests() per Gerald
>> - Updated documentation for pmd_thp_tests() per Zi Yan
>> - Replaced READ_ONCE() with huge_ptep_get() per Gerald
>> - Added pte_mkhuge() and masking with PMD_MASK per Gerald
>> - Replaced pte_same() with holding pfn check in pxx_swap_tests()
>> - Added documentation for all (#ifdef #else #endif) per Gerald
>> - Updated pmd_protnone_tests() per Gerald
>> - Updated HugeTLB PTE creation in hugetlb_advanced_tests() per Gerald
>> - Replaced [pmd|pud]_mknotpresent() with [pmd|pud]_mkinvalid()
>> - Added has_transparent_hugepage() check for PMD and PUD tests
>> - Added a patch which debug prints all individual tests being executed
>> - Updated documentation for renamed [pmd|pud]_mkinvalid() helpers
> 
> Hello Gerald/Christophe/Vineet,
> 
> It would be really great if you could give this series a quick test
> on s390/ppc/arc platforms respectively. Thank you.
> 

Running ok on powerpc 8xx after fixing build failures.

Christophe

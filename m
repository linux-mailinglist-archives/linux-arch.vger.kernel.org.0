Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC64206A6F
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 05:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbgFXDNb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 23:13:31 -0400
Received: from foss.arm.com ([217.140.110.172]:43162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgFXDNa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Jun 2020 23:13:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D1A01FB;
        Tue, 23 Jun 2020 20:13:29 -0700 (PDT)
Received: from [10.163.82.47] (unknown [10.163.82.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C237B3F71E;
        Tue, 23 Jun 2020 20:13:19 -0700 (PDT)
Subject: Re: [PATCH V3 0/4] mm/debug_vm_pgtable: Add some more tests
To:     linux-mm@kvack.org
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
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
Date:   Wed, 24 Jun 2020 08:43:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 06/15/2020 09:07 AM, Anshuman Khandual wrote:
> This series adds some more arch page table helper validation tests which
> are related to core and advanced memory functions. This also creates a
> documentation, enlisting expected semantics for all page table helpers as
> suggested by Mike Rapoport previously (https://lkml.org/lkml/2020/1/30/40).
> 
> There are many TRANSPARENT_HUGEPAGE and ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD
> ifdefs scattered across the test. But consolidating all the fallback stubs
> is not very straight forward because ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD is
> not explicitly dependent on ARCH_HAS_TRANSPARENT_HUGEPAGE.
> 
> Tested on arm64, x86 platforms but only build tested on all other enabled
> platforms through ARCH_HAS_DEBUG_VM_PGTABLE i.e powerpc, arc, s390. The
> following failure on arm64 still exists which was mentioned previously. It
> will be fixed with the upcoming THP migration on arm64 enablement series.
> 
> WARNING .... mm/debug_vm_pgtable.c:860 debug_vm_pgtable+0x940/0xa54
> WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))))
> 
> This series is based on v5.8-rc1.
> 
> Changes in V3:
> 
> - Replaced HAVE_ARCH_SOFT_DIRTY with MEM_SOFT_DIRTY
> - Added HAVE_ARCH_HUGE_VMAP checks in pxx_huge_tests() per Gerald
> - Updated documentation for pmd_thp_tests() per Zi Yan
> - Replaced READ_ONCE() with huge_ptep_get() per Gerald
> - Added pte_mkhuge() and masking with PMD_MASK per Gerald
> - Replaced pte_same() with holding pfn check in pxx_swap_tests()
> - Added documentation for all (#ifdef #else #endif) per Gerald
> - Updated pmd_protnone_tests() per Gerald
> - Updated HugeTLB PTE creation in hugetlb_advanced_tests() per Gerald
> - Replaced [pmd|pud]_mknotpresent() with [pmd|pud]_mkinvalid()
> - Added has_transparent_hugepage() check for PMD and PUD tests
> - Added a patch which debug prints all individual tests being executed
> - Updated documentation for renamed [pmd|pud]_mkinvalid() helpers

Hello Gerald/Christophe/Vineet,

It would be really great if you could give this series a quick test
on s390/ppc/arc platforms respectively. Thank you.

- Anshuman

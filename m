Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D1F24D0DC
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgHUIwE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 04:52:04 -0400
Received: from foss.arm.com ([217.140.110.172]:56110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgHUIwE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 04:52:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDEF030E;
        Fri, 21 Aug 2020 01:52:03 -0700 (PDT)
Received: from [10.163.67.49] (unknown [10.163.67.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFDDB3F66B;
        Fri, 21 Aug 2020 01:51:58 -0700 (PDT)
Subject: Re: [PATCH v2 00/13] mm/debug_vm_pgtable fixes
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        "x86@kernel.org" <x86@kernel.org>
References: <20200819130107.478414-1-aneesh.kumar@linux.ibm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <52e9743e-fa2f-3fd2-f50e-2c6c38464b96@arm.com>
Date:   Fri, 21 Aug 2020 14:21:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200819130107.478414-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 08/19/2020 06:30 PM, Aneesh Kumar K.V wrote:
> This patch series includes fixes for debug_vm_pgtable test code so that
> they follow page table updates rules correctly. The first two patches introduce
> changes w.r.t ppc64. The patches are included in this series for completeness. We can
> merge them via ppc64 tree if required.
> 
> Hugetlb test is disabled on ppc64 because that needs larger change to satisfy
> page table update rules.
> 
> Changes from V1:
> * Address review feedback
> * drop test specific pfn_pte and pfn_pmd.
> * Update ppc64 page table helper to add _PAGE_PTE 
> 
> Aneesh Kumar K.V (13):
>   powerpc/mm: Add DEBUG_VM WARN for pmd_clear
>   powerpc/mm: Move setting pte specific flags to pfn_pte
>   mm/debug_vm_pgtable/ppc64: Avoid setting top bits in radom value
>   mm/debug_vm_pgtables/hugevmap: Use the arch helper to identify huge
>     vmap support.
>   mm/debug_vm_pgtable/savedwrite: Enable savedwrite test with
>     CONFIG_NUMA_BALANCING
>   mm/debug_vm_pgtable/THP: Mark the pte entry huge before using
>     set_pmd/pud_at
>   mm/debug_vm_pgtable/set_pte/pmd/pud: Don't use set_*_at to update an
>     existing pte entry
>   mm/debug_vm_pgtable/thp: Use page table depost/withdraw with THP
>   mm/debug_vm_pgtable/locks: Move non page table modifying test together
>   mm/debug_vm_pgtable/locks: Take correct page table lock
>   mm/debug_vm_pgtable/pmd_clear: Don't use pmd/pud_clear on pte entries
>   mm/debug_vm_pgtable/hugetlb: Disable hugetlb test on ppc64
>   mm/debug_vm_pgtable: populate a pte entry before fetching it
> 
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  29 +++-
>  arch/powerpc/include/asm/nohash/pgtable.h    |   5 -
>  arch/powerpc/mm/book3s64/pgtable.c           |   2 +-
>  arch/powerpc/mm/pgtable.c                    |   5 -
>  include/linux/io.h                           |  12 ++
>  mm/debug_vm_pgtable.c                        | 151 +++++++++++--------
>  6 files changed, 127 insertions(+), 77 deletions(-)
> 

Changes proposed here will impact other enabled platforms as well.
Adding the following folks and mailing lists, and hoping to get a
broader review and test coverage. Please do include them in the
next iteration as well.

+ linux-arm-kernel@lists.infradead.org
+ linux-s390@vger.kernel.org
+ linux-snps-arc@lists.infradead.org
+ x86@kernel.org
+ linux-arch@vger.kernel.org

+ Gerald Schaefer <gerald.schaefer@de.ibm.com>
+ Christophe Leroy <christophe.leroy@c-s.fr>
+ Christophe Leroy <christophe.leroy@csgroup.eu>
+ Vineet Gupta <vgupta@synopsys.com>
+ Mike Rapoport <rppt@linux.ibm.com>
+ Qian Cai <cai@lca.pw>

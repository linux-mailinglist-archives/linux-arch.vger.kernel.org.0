Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DAC19638E
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 05:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgC1EbE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Mar 2020 00:31:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgC1EbE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Mar 2020 00:31:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7A61A296AB1C88EDC8D1;
        Sat, 28 Mar 2020 12:30:59 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 28 Mar 2020
 12:30:52 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     Peter Zijlstra <peterz@infradead.org>, <npiggin@gmail.com>,
        <will.deacon@arm.com>, <mingo@kernel.org>,
        <torvalds@linux-foundation.org>, <schwidefsky@de.ibm.com>,
        <akpm@linux-foundation.org>, <luto@kernel.org>, <bp@alien8.de>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <arm@kernel.org>, <xiexiangyou@huawei.com>, <yezhenyu2@huawei.com>
Subject: [RFC][Qusetion] the value of cleared_(ptes|pmds|puds|p4ds) in struct
 mmu_gather
Message-ID: <fbb00ac0-9104-8d25-f225-7b3d1b17a01f@huawei.com>
Date:   Sat, 28 Mar 2020 12:30:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

commit a6d60245 "Track which levels of the page tables have been cleared"
added cleared_(ptes|pmds|puds|p4ds) in struct mmu_gather, and the values
of them are set in some places. For example:

In include/asm-generic/tlb.h, pte_free_tlb() set the tlb->cleared_pmds:
---8<---
#ifndef pte_free_tlb
#define pte_free_tlb(tlb, ptep, address)			\
	do {							\
		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
		tlb->freed_tables = 1;				\
		tlb->cleared_pmds = 1;				\
		__pte_free_tlb(tlb, ptep, address);		\
	} while (0)
#endif
---8<---


However, in arch/s390/include/asm/tlb.h, pte_free_tlb() set the tlb->cleared_ptes:
---8<---
static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
                                unsigned long address)
{
	__tlb_adjust_range(tlb, address, PAGE_SIZE);
	tlb->mm->context.flush_mm = 1;
	tlb->freed_tables = 1;
	tlb->cleared_ptes = 1;
	/*
	 * page_table_free_rcu takes care of the allocation bit masks
	 * of the 2K table fragments in the 4K page table page,
	 * then calls tlb_remove_table.
	 */
	page_table_free_rcu(tlb, (unsigned long *) pte, address);
}
---8<---


In my view, the cleared_(ptes|pmds|puds) and (pte|pmd|pud)_free_tlb
correspond one-to-one.  So we should set cleared_ptes in pte_free_tlb(),
then use it when needed.

I'm very confused about this. Which is wrong? Or is there something
I understand wrong?


Thanks,
Zhenyu



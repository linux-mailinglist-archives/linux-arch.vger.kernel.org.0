Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E20197BAB
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgC3MRN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 08:17:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbgC3MRM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 08:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1TmVSV9PEicpV15saljgYzRTqRrIyUodG1iYOZDlCEw=; b=jug3rhODTJBTFOCabmEpKv3Ciy
        OQM9n6+JLCgJaVH13pLjAddV5iCyN6VkzJewzO5/zEWXS0jthSH5yZe4C+fBjXhYKc8qcHxnPjBJ2
        3k0FhnMmnjUl6Z8PZwD0cHVa8+QzePq02+E7Qr1bv4keJir+bSI1/esyOwt5AYFDjDetGBu2r2CHQ
        8ZDHvI7evDFQxiGZK2RtBJ6wCGAZsIN5cGaqdjOtB85vmkkhbKSeK2gMBqRRNxfr1+aFDoj104nQq
        QuwEtQdU3Cqt+u9I7HuSEBBq2KVdHmPuVh1ef2y2D7+8la/4B4ZcASgg37TwV3AIfzXRHcYGJfC6B
        abEyRCXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jItLd-0004XC-Ka; Mon, 30 Mar 2020 12:16:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EAFAE303C41;
        Mon, 30 Mar 2020 14:16:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDA5F29D04D6E; Mon, 30 Mar 2020 14:16:54 +0200 (CEST)
Date:   Mon, 30 Mar 2020 14:16:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     npiggin@gmail.com, will.deacon@arm.com, mingo@kernel.org,
        torvalds@linux-foundation.org, schwidefsky@de.ibm.com,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arm@kernel.org, xiexiangyou@huawei.com
Subject: Re: [RFC][Qusetion] the value of cleared_(ptes|pmds|puds|p4ds) in
 struct mmu_gather
Message-ID: <20200330121654.GL20696@hirez.programming.kicks-ass.net>
References: <fbb00ac0-9104-8d25-f225-7b3d1b17a01f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbb00ac0-9104-8d25-f225-7b3d1b17a01f@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 28, 2020 at 12:30:50PM +0800, Zhenyu Ye wrote:
> Hi all,
> 
> commit a6d60245 "Track which levels of the page tables have been cleared"
> added cleared_(ptes|pmds|puds|p4ds) in struct mmu_gather, and the values
> of them are set in some places. For example:
> 
> In include/asm-generic/tlb.h, pte_free_tlb() set the tlb->cleared_pmds:
> ---8<---
> #ifndef pte_free_tlb
> #define pte_free_tlb(tlb, ptep, address)			\
> 	do {							\
> 		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
> 		tlb->freed_tables = 1;				\
> 		tlb->cleared_pmds = 1;				\
> 		__pte_free_tlb(tlb, ptep, address);		\
> 	} while (0)
> #endif
> ---8<---
> 
> 
> However, in arch/s390/include/asm/tlb.h, pte_free_tlb() set the tlb->cleared_ptes:
> ---8<---
> static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>                                 unsigned long address)
> {
> 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
> 	tlb->mm->context.flush_mm = 1;
> 	tlb->freed_tables = 1;
> 	tlb->cleared_ptes = 1;
> 	/*
> 	 * page_table_free_rcu takes care of the allocation bit masks
> 	 * of the 2K table fragments in the 4K page table page,
> 	 * then calls tlb_remove_table.
> 	 */
> 	page_table_free_rcu(tlb, (unsigned long *) pte, address);
> }
> ---8<---
> 
> 
> In my view, the cleared_(ptes|pmds|puds) and (pte|pmd|pud)_free_tlb
> correspond one-to-one.  So we should set cleared_ptes in pte_free_tlb(),
> then use it when needed.

So pte_free_tlb() clears a table of PTE entries, or a PMD level entity,
also see free_pte_range(). So the generic code makes sense to me. The
PTE level invalidations will have happened on tlb_remove_tlb_entry().

> I'm very confused about this. Which is wrong? Or is there something
> I understand wrong?

I agree the s390 case is puzzling, Martin does s390 need a PTE level
invalidate for removing a PTE table or was this a mistake?

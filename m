Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3A33B18E0
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 13:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFWLan (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 07:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhFWLan (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 07:30:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF9926102A;
        Wed, 23 Jun 2021 11:28:23 +0000 (UTC)
Date:   Wed, 23 Jun 2021 12:28:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Zhenyu Ye <yezhenyu2@huawei.com>, aneesh.kumar@linux.ibm.com,
        Marc Zyngier <maz@kernel.org>, steven.price@arm.com,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Xiexiangyou <xiexiangyou@huawei.com>, liushixin2@huawei.com,
        huyaqin <huyaqin1@huawei.com>, zhurui3@huawei.com
Subject: Re: [PATCH v1] arm64: tlb: fix the TTL value of tlb_get_level
Message-ID: <20210623112819.GB3718@arm.com>
References: <b80ead47-1f88-3a00-18e1-cacc22f54cc4@huawei.com>
 <20210623110412.GA32177@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623110412.GA32177@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 23, 2021 at 12:04:12PM +0100, Will Deacon wrote:
> On Wed, Jun 23, 2021 at 03:05:22PM +0800, Zhenyu Ye wrote:
> > The TTL field indicates the level of page table walk holding the *leaf*
> > entry for the address being invalidated. But currently, the TTL field
> > may be set to an incorrent value in the following stack:
> > 
> > pte_free_tlb
> >     __pte_free_tlb
> >         tlb_remove_table
> >             tlb_table_invalidate
> >                 tlb_flush_mmu_tlbonly
> >                     tlb_flush
> > 
> > In this case, we just want to flush a PTE page, but the tlb->cleared_pmds
> > is set and we get tlb_level = 2 in the tlb_get_level() function. This may
> > cause some unexpected problems.
> > 
> > This patch set the TTL field to 0 if tlb->freed_tables is set. The
> > tlb->freed_tables indicates page table pages are freed, not the leaf
> > entry.
> > 
> > Fixes: c4ab2cbc1d87 ("arm64: tlb: Set the TTL field in flush_tlb_range")
> > Reported-by: ZhuRui <zhurui3@huawei.com>
> > Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> > ---
> >  arch/arm64/include/asm/tlb.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > index 61c97d3b58c7..c995d1f4594f 100644
> > --- a/arch/arm64/include/asm/tlb.h
> > +++ b/arch/arm64/include/asm/tlb.h
> > @@ -28,6 +28,10 @@ static void tlb_flush(struct mmu_gather *tlb);
> >   */
> >  static inline int tlb_get_level(struct mmu_gather *tlb)
> >  {
> > +	/* The TTL field is only valid for the leaf entry. */
> > +	if (tlb->freed_tables)
> > +		return 0;
> > +
> >  	if (tlb->cleared_ptes && !(tlb->cleared_pmds ||
> >  				   tlb->cleared_puds ||
> >  				   tlb->cleared_p4ds))
> 
> Thanks. I can't see a better way around this, so I'll queue the patch.

If you haven't queued it already, feel free to add:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I'd also add:

Cc: <stable@vger.kernel.org> # 5.9.x

-- 
Catalin

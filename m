Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006571B1A62
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 02:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDUAGV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Apr 2020 20:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDUAGU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Apr 2020 20:06:20 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E69C20782;
        Tue, 21 Apr 2020 00:06:18 +0000 (UTC)
Date:   Mon, 20 Apr 2020 20:06:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zhenyu Ye <yezhenyu2@huawei.com>, mark.rutland@arm.com,
        will@kernel.org, catalin.marinas@arm.com,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        npiggin@gmail.com, arnd@arndb.de, maz@kernel.org,
        suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com,
        Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org,
        guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com,
        prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com,
        kuhn.chenqun@huawei.com
Subject: Re: [PATCH v1 6/6] arm64: tlb: Set the TTL field in flush_tlb_range
Message-ID: <20200420200616.44c7c7ea@oasis.local.home>
In-Reply-To: <20200420121055.GF20696@hirez.programming.kicks-ass.net>
References: <20200403090048.938-1-yezhenyu2@huawei.com>
        <20200403090048.938-7-yezhenyu2@huawei.com>
        <20200420121055.GF20696@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 20 Apr 2020 14:10:55 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Apr 03, 2020 at 05:00:48PM +0800, Zhenyu Ye wrote:
> > This patch uses the cleared_* in struct mmu_gather to set the
> > TTL field in flush_tlb_range().
> > 
> > Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> > ---
> >  arch/arm64/include/asm/tlb.h      | 26 +++++++++++++++++++++++++-
> >  arch/arm64/include/asm/tlbflush.h | 14 ++++++++------
> >  2 files changed, 33 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > index b76df828e6b7..d5ab72eccff4 100644
> > --- a/arch/arm64/include/asm/tlb.h
> > +++ b/arch/arm64/include/asm/tlb.h
> > @@ -21,11 +21,34 @@ static void tlb_flush(struct mmu_gather *tlb);
> >  
> >  #include <asm-generic/tlb.h>
> >  
> > +/*
> > + * get the tlbi levels in arm64.  Default value is 0 if more than one
> > + * of cleared_* is set or neither is set.
> > + * Arm64 doesn't support p4ds now.
> > + */
> > +static inline int tlb_get_level(struct mmu_gather *tlb)
> > +{
> > +	int sum = tlb->cleared_ptes + tlb->cleared_pmds +
> > +		  tlb->cleared_puds + tlb->cleared_p4ds;
> > +
> > +	if (sum != 1)
> > +		return 0;
> > +	else if (tlb->cleared_ptes)
> > +		return 3;
> > +	else if (tlb->cleared_pmds)
> > +		return 2;
> > +	else if (tlb->cleared_puds)
> > +		return 1;
> > +
> > +	return 0;
> > +}  
> 
> That's some mighty wonky code. Please look at the generated asm.

Without even looking at the generated asm, if a condition returns,
there's no reason to add an else for that condition.

	if (x)
		return 1;
	else if (y)
		return 2;
	else
		return 3;

Is exactly the same as:

	if (x)
		return 1;
	if (y)
		return 2;
	return 3;

-- Steve


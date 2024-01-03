Return-Path: <linux-arch+bounces-1244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936B982340A
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 18:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403CD286F00
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 17:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC1D1D536;
	Wed,  3 Jan 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ61WSOk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B61D52A;
	Wed,  3 Jan 2024 17:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25872C433CB;
	Wed,  3 Jan 2024 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704304671;
	bh=EQmqIwt5epCeJn4AJ4OZUCyNlDG/sWGPlg++mDoiWxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQ61WSOkYHvDu+NAujBX1iKQQZ8LBc7cOd7ZSkJdNDefaZuBx9ynYYZVtX4jJdGb+
	 7XOT6chUxOsHLsEnmmvvdLULKAFhQAYEnDaeLySVJ4sicSBeTl1tnAmJxJOG36YvXX
	 Ms9+4/7u7PMcapNSeVrTinr/tC5NoN2SrdI6TT4Y1/nJCvPFNr90TPRnY4X++JGbln
	 dp6/3BqX3NvceDJ1L6d9p4FcLzK+bE6jV5LWDAamgcqerXB0coCHYs6xCp4t1vOTc5
	 GJ700QXwCSqBl067oofTfdRi3BHCUE+ZrADAp/W+bEhUxVqMQidoVCPQFTYFgr5ua0
	 q6BvF2SdkCRUw==
Date: Wed, 3 Jan 2024 17:57:43 +0000
From: Will Deacon <will@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Nadav Amit <namit@vmware.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Yu Zhao <yuzhao@google.com>,
	x86@kernel.org
Subject: Re: [PATCH 1/2] mm/tlb: fix fullmm semantics
Message-ID: <20240103175743.GG5954@willie-the-truck>
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-2-jszhang@kernel.org>
 <20240103175001.GF5954@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103175001.GF5954@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Jan 03, 2024 at 05:50:01PM +0000, Will Deacon wrote:
> On Thu, Dec 28, 2023 at 04:46:41PM +0800, Jisheng Zhang wrote:
> > From: Nadav Amit <namit@vmware.com>
> > 
> > fullmm in mmu_gather is supposed to indicate that the mm is torn-down
> > (e.g., on process exit) and can therefore allow certain optimizations.
> > However, tlb_finish_mmu() sets fullmm, when in fact it want to say that
> > the TLB should be fully flushed.
> > 
> > Change tlb_finish_mmu() to set need_flush_all and check this flag in
> > tlb_flush_mmu_tlbonly() when deciding whether a flush is needed.
> > 
> > At the same time, bring the arm64 fullmm on process exit optimization back.
> > 
> > Signed-off-by: Nadav Amit <namit@vmware.com>
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Yu Zhao <yuzhao@google.com>
> > Cc: Nick Piggin <npiggin@gmail.com>
> > Cc: x86@kernel.org
> > ---
> >  arch/arm64/include/asm/tlb.h | 5 ++++-
> >  include/asm-generic/tlb.h    | 2 +-
> >  mm/mmu_gather.c              | 2 +-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > index 846c563689a8..6164c5f3b78f 100644
> > --- a/arch/arm64/include/asm/tlb.h
> > +++ b/arch/arm64/include/asm/tlb.h
> > @@ -62,7 +62,10 @@ static inline void tlb_flush(struct mmu_gather *tlb)
> >  	 * invalidating the walk-cache, since the ASID allocator won't
> >  	 * reallocate our ASID without invalidating the entire TLB.
> >  	 */
> > -	if (tlb->fullmm) {
> > +	if (tlb->fullmm)
> > +		return;
> > +
> > +	if (tlb->need_flush_all) {
> >  		if (!last_level)
> >  			flush_tlb_mm(tlb->mm);
> >  		return;
> 
> Why isn't the 'last_level' check sufficient here? In other words, when do
> we perform a !last_level invalidation with 'fullmm' set outside of teardown?

Sorry, logic inversion typo there. I should've said:

  When do we perform a last_level invalidation with 'fullmm' set outside
  of teardown?

I remember this used to be the case for OOM ages ago, but 687cb0884a71
("mm, oom_reaper: gather each vma to prevent leaking TLB entry") sorted
that out.

I'm not against making this clearer and/or more robust, I'm just trying
to understand whether this is fixing a bug (as implied by the subject)
or not.

Will


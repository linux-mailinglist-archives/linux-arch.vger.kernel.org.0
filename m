Return-Path: <linux-arch+bounces-1222-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD6982168F
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 03:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D6B281F19
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jan 2024 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7291020FA;
	Tue,  2 Jan 2024 02:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyJf3ixC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5314020F9;
	Tue,  2 Jan 2024 02:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A37C433C8;
	Tue,  2 Jan 2024 02:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704164065;
	bh=11z9yjbOWrH6tSiyWTkbin1v0ZP1GSqeHEVZ1qpwWW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyJf3ixCiPi9UvwUkSVUpOmKCh2ropGCL0NBDwtKRDYXQBHVLgzbEDPcu3Fja3YJG
	 jSZs8VQEgmsEJFXxqzyDTpXLIyEvLGB9gRcZcYNrAM16lNkkiVRzm+TveG0nnUdsDO
	 Cz9Xw1AdV6g9B3vuf+hPBycNosrLD86ng+fYciVOev6XLcgrRF4jz70RQMH5NzMvdv
	 pcsyHKuZwX9hcMrpv5EtGFEKrqiVHYWwXPKdQhUADat9VR8ZW3EnNoQU9k4MY3EztT
	 7r9FaoDjSiOJIV8ph/7zp97UKkY4ISTBuOqOvwxFU52/3up2s1I2mMBs9cjS3+GXOv
	 b0gUGT9N0gE1A==
Date: Tue, 2 Jan 2024 10:41:40 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Nadav Amit <nadav.amit@broadcom.com>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Nadav Amit <namit@vmware.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Yu Zhao <yuzhao@google.com>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 1/2] mm/tlb: fix fullmm semantics
Message-ID: <ZZN35DTJTNExCNXW@xhacker>
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-2-jszhang@kernel.org>
 <204B6410-2EFA-462B-9DF7-64CC5F1D3AD2@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <204B6410-2EFA-462B-9DF7-64CC5F1D3AD2@broadcom.com>

On Sat, Dec 30, 2023 at 11:54:02AM +0200, Nadav Amit wrote:
> 
> 
> > On Dec 28, 2023, at 10:46 AM, Jisheng Zhang <jszhang@kernel.org> wrote:
> > 
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
> > arch/arm64/include/asm/tlb.h | 5 ++++-
> > include/asm-generic/tlb.h    | 2 +-
> > mm/mmu_gather.c              | 2 +-
> > 3 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> > index 846c563689a8..6164c5f3b78f 100644
> > --- a/arch/arm64/include/asm/tlb.h
> > +++ b/arch/arm64/include/asm/tlb.h
> > @@ -62,7 +62,10 @@ static inline void tlb_flush(struct mmu_gather *tlb)
> > 	 * invalidating the walk-cache, since the ASID allocator won't
> > 	 * reallocate our ASID without invalidating the entire TLB.
> > 	 */
> > -	if (tlb->fullmm) {
> > +	if (tlb->fullmm)
> > +		return;
> > +
> > +	if (tlb->need_flush_all) {
> > 		if (!last_level)
> > 			flush_tlb_mm(tlb->mm);
> > 		return;
> > 
> 
> Thanks for pulling my patch out of the abyss, but the chunk above
> did not come from my old patch.

I stated this in cover letter msg ;) IMHO, current arm64 uses fullmm as
need_flush_all, so I think we need at least the need_flush_all line.

I'd like to see comments from arm64 experts.

> 
> My knowledge of arm64 is a bit limited, but the code does not seem
> to match the comment, so if it is correct (which I strongly doubt),
> the comment should be updated.

will do if the above change is accepted by arm64

> 
> [1] https://lore.kernel.org/all/20210131001132.3368247-2-namit@vmware.com/
> 
> 
> -- 
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.


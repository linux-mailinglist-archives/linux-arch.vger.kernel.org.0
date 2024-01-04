Return-Path: <linux-arch+bounces-1283-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497678243F8
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 15:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE332282FC7
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD9A22F1A;
	Thu,  4 Jan 2024 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmMMliqp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F09822F10;
	Thu,  4 Jan 2024 14:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0633AC433C7;
	Thu,  4 Jan 2024 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704379221;
	bh=mKB4DEZxIw57eKu739it6g3eVDl5U5ssEGaV5HTsHMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CmMMliqpZQ3d3p5RkVIPwbQ8Unhh9n57IKcVI9zAgcZFqIqGa9h0Hu+55ZdK0D5nq
	 wt6xrFMuRiHKv/RvSMSvDQFyGvXZxrodci/0xVv4XS49CDNeNLVxXvmY3QEZhQHayg
	 daO/lorO4VIRrEm//7YzcjlSaAzPRU+1qK7nNO7IptjTby4G8GP/yybFjxN5CN3L7f
	 UnTX0iHH4qx/J9L22NBgxcfDBVKYRDTZrnbVvl2NMekyRJ9x5bvZVHeLJFOd3DXFyH
	 1obF2vxG5o8SLmHhqrTE6QMA3pUGnaA2Jlw+hSvh1a+6tx0CfrWYTq2Qr1laOTlWAj
	 mRjU16QNsUJqA==
Date: Thu, 4 Jan 2024 14:40:13 +0000
From: Will Deacon <will@kernel.org>
To: Nadav Amit <nadav.amit@broadcom.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
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
Message-ID: <20240104144013.GA7179@willie-the-truck>
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-2-jszhang@kernel.org>
 <204B6410-2EFA-462B-9DF7-64CC5F1D3AD2@broadcom.com>
 <ZZN35DTJTNExCNXW@xhacker>
 <0468E994-273E-4A8B-A521-150723DA9774@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0468E994-273E-4A8B-A521-150723DA9774@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Jan 04, 2024 at 03:26:43PM +0200, Nadav Amit wrote:
> 
> 
> > On Jan 2, 2024, at 4:41 AM, Jisheng Zhang <jszhang@kernel.org> wrote:
> > 
> > On Sat, Dec 30, 2023 at 11:54:02AM +0200, Nadav Amit wrote:
> > 
> >> 
> >> My knowledge of arm64 is a bit limited, but the code does not seem
> >> to match the comment, so if it is correct (which I strongly doubt),
> >> the comment should be updated.
> > 
> > will do if the above change is accepted by arm64
> 
> Jisheng, I expected somebody with arm64 knowledge to point it out, and
> maybe I am wrong, but I really don’t understand something about the
> correctness, if you can please explain.
> 
> In the following code:
> 
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -62,7 +62,10 @@ static inline void tlb_flush(struct mmu_gather *tlb)
> 	 * invalidating the walk-cache, since the ASID allocator won't
> 	 * reallocate our ASID without invalidating the entire TLB.
> 	 */
> -	if (tlb->fullmm) {
> +	if (tlb->fullmm)
> +		return;
> 
> You skip flush if fullmm is on. But if page-tables are freed, you may
> want to flush immediately and not wait for ASID to be freed to avoid
> speculative page walks; these walks at least on x86 caused a mess.
> 
> No?

I think Catalin made the same observation here:

https://lore.kernel.org/r/ZZWh4c3ZUtadFqD1@arm.com

and it does indeed look broken.

Will


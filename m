Return-Path: <linux-arch+bounces-1243-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D28233D0
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 18:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236D41C23836
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9029F1C29D;
	Wed,  3 Jan 2024 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNPoyeCq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF71C296;
	Wed,  3 Jan 2024 17:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148E0C433C8;
	Wed,  3 Jan 2024 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704304208;
	bh=a1eB5V5dv9FsKtuAgCrEoiM/zZTQE0AOc1G/QrOZMvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNPoyeCqDgsu3BE73CiRzBofXmm/w3pz76XB97b/iprlVnMmRWf9yAYU3brWptOXC
	 wx/v9G2JBn/xtRJWz+ZmIoFP/fZ2F+nxqeqUSgB+4PeLfbntRX9gLLbdp1knHXjki1
	 8QBRTHFkdyIgM1o1z0S+Z+ICo+EiiwXV9DOlV+qNdxTe9oQzjUQuZxSZRhV/SO2QIv
	 AdTisd3vVx2K001275d+QRLb/yghZHtZ8qKpbv0da/tV1s8rEBvtWVDHvvfjAln8v3
	 MusFr71gFIOgO/A9FAQJpE/UtL+K/3hdUMK4TFO6SDgW3Nnjdb+/PPoLpnkI4OvDhm
	 rtg+LdZPtE5tQ==
Date: Wed, 3 Jan 2024 17:50:01 +0000
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
Message-ID: <20240103175001.GF5954@willie-the-truck>
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228084642.1765-2-jszhang@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 28, 2023 at 04:46:41PM +0800, Jisheng Zhang wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> fullmm in mmu_gather is supposed to indicate that the mm is torn-down
> (e.g., on process exit) and can therefore allow certain optimizations.
> However, tlb_finish_mmu() sets fullmm, when in fact it want to say that
> the TLB should be fully flushed.
> 
> Change tlb_finish_mmu() to set need_flush_all and check this flag in
> tlb_flush_mmu_tlbonly() when deciding whether a flush is needed.
> 
> At the same time, bring the arm64 fullmm on process exit optimization back.
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: x86@kernel.org
> ---
>  arch/arm64/include/asm/tlb.h | 5 ++++-
>  include/asm-generic/tlb.h    | 2 +-
>  mm/mmu_gather.c              | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index 846c563689a8..6164c5f3b78f 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -62,7 +62,10 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>  	 * invalidating the walk-cache, since the ASID allocator won't
>  	 * reallocate our ASID without invalidating the entire TLB.
>  	 */
> -	if (tlb->fullmm) {
> +	if (tlb->fullmm)
> +		return;
> +
> +	if (tlb->need_flush_all) {
>  		if (!last_level)
>  			flush_tlb_mm(tlb->mm);
>  		return;

Why isn't the 'last_level' check sufficient here? In other words, when do
we perform a !last_level invalidation with 'fullmm' set outside of teardown?

Will


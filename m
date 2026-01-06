Return-Path: <linux-arch+bounces-15674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BD3CF953C
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 17:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14F7A300D80F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 16:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1C314A6C;
	Tue,  6 Jan 2026 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2J5zPsU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE65329378;
	Tue,  6 Jan 2026 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716702; cv=none; b=rOnHvJpCslHxgpeNrsDatsJlhkAA9z6D+lIA4hQLjMSQuexP58d9O4Ly2r5n/v1AytmWjhy8YAlzGCtVsO6EKNVWdKR0/fxhC8Ft7J71DL7uEJUuRrpLubEGV1IBX+dhqs8z5eQHMA7IRwlSvgmNzbpzfcRHavTP2KfQgSg3juc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716702; c=relaxed/simple;
	bh=FgbVbjWstxtVReE+uVrnBgSNR1ljBRwNUEeFtwyXQjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiqMGTxLH16FwnkokMy+G5bl6Hus62Iaf1S+GkoVgvNmSPoBayCEY4UEKzLdtvVSNmLAbSXu5zGMQp+CHVmtJ6tlvfrvz7UDM0hIQ/Vl+jEib+L5Dg/jW/oqXVMXCWaw7WMgn08NB/mVthQmPHSvvGvv3GyPNdD7K2iw6O/syJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2J5zPsU; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767716700; x=1799252700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FgbVbjWstxtVReE+uVrnBgSNR1ljBRwNUEeFtwyXQjA=;
  b=F2J5zPsUTQ7FUa2FGKowI/laNL2wNJdCfkKFQh4XkRaRXzEmqZvkSwva
   aaWJtDA3jKYmh4GkShGqNaqREfqEfhzfRKcLCtdl2c74HP88gPgAOoqXP
   Lw1Db1JNzzl8q8u2SjCX06V9O3rKUcHy5yZQ5qqa4/3Dtlh8MoPQlDwRv
   MXOqwvdvHFU7oey7+P1q/gs1qO+85HQ1EjLDQoeAJjazTRw7ZeTK7GNx0
   8Gym1YmbA+KrTtp7ccZafPv5Xmxw+u7hE6izhdKmGNEdfdey/BUef+CXy
   8YrcLsmy6T486OfyvjiawKNkPzqFAMdYR230RoqLPcYLhajl/p3o8Kyk2
   w==;
X-CSE-ConnectionGUID: 0dzj7e2ISe64j3oziRsI1A==
X-CSE-MsgGUID: L7AdzeD8RKW6b2iuI1+DGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="79717501"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="79717501"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 08:24:59 -0800
X-CSE-ConnectionGUID: 4r2XnTedSR661g4k+b1XLQ==
X-CSE-MsgGUID: GBe/ka8KSW2hj94lXax2Ow==
X-ExtLoop1: 1
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.109.89]) ([10.125.109.89])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 08:24:57 -0800
Message-ID: <a20ab449-e6b4-45c7-86df-bb194304503c@intel.com>
Date: Tue, 6 Jan 2026 08:24:57 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 1/2] mm/tlb: skip redundant IPI when TLB flush
 already synchronized
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: david@kernel.org, dave.hansen@linux.intel.com, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260106120303.38124-1-lance.yang@linux.dev>
 <20260106120303.38124-2-lance.yang@linux.dev>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260106120303.38124-2-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 04:03, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> When unsharing hugetlb PMD page tables, we currently send two IPIs: one
> for TLB invalidation, and another to synchronize with concurrent GUP-fast
> walkers via tlb_remove_table_sync_one().
> 
> However, if the TLB flush already sent IPIs to all CPUs (when freed_tables
> or unshared_tables is true), the second IPI is redundant. GUP-fast runs
> with IRQs disabled, so when the TLB flush IPI completes, any concurrent
> GUP-fast must have finished.
> 
> To avoid the redundant IPI, we add a flag to mmu_gather to track whether
> the TLB flush sent IPIs. We pass the mmu_gather pointer through the TLB
> flush path via flush_tlb_info, so native_flush_tlb_multi() can set the
> flag when it sends IPIs for freed_tables. We also set the flag for
> local-only flushes, since disabling IRQs provides the same guarantee.

The lack of imperative voice is killing me. :)

> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
> index 866ea78ba156..c5950a92058c 100644
> --- a/arch/x86/include/asm/tlb.h
> +++ b/arch/x86/include/asm/tlb.h
> @@ -20,7 +20,8 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>  		end = tlb->end;
>  	}
>  
> -	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
> +	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
> +			   tlb->freed_tables || tlb->unshared_tables, tlb);
>  }

I think this hunk sums up v3 pretty well. Where there was a single boolean, now there are two. To add to that, the structure that contains the booleans is itself being passed in. The boolean is still named 'freed_tables', and is going from:

	tlb->freed_tables

which is pretty obviously correct to:

	tlb->freed_tables || tlb->unshared_tables

which is _far_ from obviously correct.

I'm at a loss for why the patch wouldn't just do this:

-	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
+	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb);

I suspect these were sent out in a bit of haste, which isn't the first time I've gotten that feeling with this series.

Could we slow down, please?

>  static inline void invlpg(unsigned long addr)
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 00daedfefc1b..83c260c88b80 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -220,6 +220,7 @@ struct flush_tlb_info {
>  	 *   will be zero.
>  	 */
>  	struct mm_struct	*mm;
> +	struct mmu_gather	*tlb;
>  	unsigned long		start;
>  	unsigned long		end;
>  	u64			new_tlb_gen;

This also gives me pause.

There is a *lot* of redundant information between 'struct mmu_gather' and 'struct tlb_flush_info'. There needs to at least be a description of what the relationship is and how these relate to each other. I would have naively thought that the right move here would be to pull the mmu_gather data out at one discrete time rather than store a pointer to it.

What I see here is, I suspect, the most expedient way to do it. I'd _certainly_ have done this myself if I was just hacking something together to play with as quickly as possible.

So, in the end, I don't hate the approach here (yet). But it is almost impossible to evaluate it because the series is taking some rather egregious shortcuts and is lacking any real semblance of a refactoring effort.


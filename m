Return-Path: <linux-arch+bounces-14749-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A651C5CDAF
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 12:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA1ED4F098D
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1C2313E23;
	Fri, 14 Nov 2025 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UXfRqxSY"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD72FB0A0
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763119248; cv=none; b=ChcStLRmDt25eHGtbKsSQ3TVC50dCfkIL4zD2iAJGTEFACT3rv+0c3Kpn4KmIPkHODEfpjIPr9pi4tpL81ulQgMpbyoOs81doYLcuQF5jCqBEHxcfar1wsUi07lp48P1fSYg7t49PgtAZCikj3/KxGVnYf4seu1Gvul8nRW+PkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763119248; c=relaxed/simple;
	bh=XfvCDo+1eG68OiQUxswvZBtDPW7pDceSd0YHkS/rGQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swj8NnjgzPnU1tuToagt6hUr8gUK884RMIipz6aYGObMlQoAcjnd5xZD0hRt0Q6R/wxwALBpiALvTXCGxA1P6Q3I0ZVpHBwbxLW62AWv5gKkTU50/cVrV1MmYcS2d/VYTRM+Vumbxa1tWa0wcsQkCOIubUn2ZNA0MBCHthO0W4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UXfRqxSY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5199c367-aabb-43e7-951e-452657dcdddc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763119233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XNy4CVtGzelyvviljfMndhZwOP8iEHHQBelXlL4nqTk=;
	b=UXfRqxSYKG2iIMsq0y7QI0YBpjYVA43NAZ9FotdfgEA7smTT1ii+ka8Donlv0ylAHxiqBn
	RyGAslbUmXZRKFrWlOaihR1yjcUSTjpJEG9FlXij0/eiQO2C2bzMCPOKJbOhp0uN/N5ZXK
	KS3JrJ92b7MC5d87CAz8uAxX76wAATE=
Date: Fri, 14 Nov 2025 19:20:02 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] arc: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
 david@redhat.com, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Vineet Gupta <vgupta@kernel.org>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <6a4192f5cef3049f123f08cb04ef5cd0179c3281.1763117269.git.zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <6a4192f5cef3049f123f08cb04ef5cd0179c3281.1763117269.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/14/25 7:11 PM, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
> empty PTE page table pages (such as 100GB+). To resolve this problem,
> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
> PT_RECLAIM feature, which resolves this problem.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Cc: Vineet Gupta <vgupta@kernel.org>
> ---
>   arch/arc/Kconfig               | 1 +
>   arch/arc/include/asm/pgalloc.h | 9 ++++++---
>   2 files changed, 7 insertions(+), 3 deletions(-)

Strangely, it seems that only ARC does not define CONFIG_64BIT?

Does the ARC architecture support 64-bit? Did I miss something?

> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index f27e6b90428e4..47db93952386d 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -54,6 +54,7 @@ config ARC
>   	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32
>   	select TRACE_IRQFLAGS_SUPPORT
>   	select HAVE_EBPF_JIT if ISA_ARCV2
> +	select MMU_GATHER_RCU_TABLE_FREE
>   
>   config LOCKDEP_SUPPORT
>   	def_bool y
> diff --git a/arch/arc/include/asm/pgalloc.h b/arch/arc/include/asm/pgalloc.h
> index dfae070fe8d55..b1c6619435613 100644
> --- a/arch/arc/include/asm/pgalloc.h
> +++ b/arch/arc/include/asm/pgalloc.h
> @@ -72,7 +72,8 @@ static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4dp, pud_t *pudp)
>   	set_p4d(p4dp, __p4d((unsigned long)pudp));
>   }
>   
> -#define __pud_free_tlb(tlb, pmd, addr)  pud_free((tlb)->mm, pmd)
> +#define __pud_free_tlb(tlb, pud, addr)	\
> +	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pud))
>   
>   #endif
>   
> @@ -83,10 +84,12 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmdp)
>   	set_pud(pudp, __pud((unsigned long)pmdp));
>   }
>   
> -#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
> +#define __pmd_free_tlb(tlb, pmd, addr)	\
> +	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd))
>   
>   #endif
>   
> -#define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)
> +#define __pte_free_tlb(tlb, pte, addr)	\
> +	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
>   
>   #endif /* _ASM_ARC_PGALLOC_H */



Return-Path: <linux-arch+bounces-15493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85066CCBF66
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 14:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B2E8306AA3E
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D05F338592;
	Thu, 18 Dec 2025 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ+66Ylx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9680A3358D4;
	Thu, 18 Dec 2025 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063299; cv=none; b=A6rmTfHQ2MMe3OLgoJgLqA+OX7x/Y4P7DyK7mc/1uQP2V06exSgopcqZCtQButaRDmfnPYIJBePpNolJZx59KuvpxNsgFLqRsmMEOBxKtQsSTGrwPcPcxgPr8Vx4Wrx510ARrmGGnplq1yqmTaZy3Hc4TSZwVS0c1V3goJzWNzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063299; c=relaxed/simple;
	bh=xGSeZoo8A4otZiM+Me0157v7z6QWInhRsz4o+w4d45E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JBQKoc7UtfSP+KDBT9UBcZ4R969w4WLSCpAPPPy+bXtSMdkdqC5opbpK9HPK6II/BB7z2CHAt70o6pVUI6sV+zW3hvNZ4imfF5csG8r4brl1l4KLzbZuMwlqu8LPFeyftabWL1kxIOBUs4mHzJyHDEimfySL9GDmhx1pmHOh55w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ+66Ylx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC60C4CEFB;
	Thu, 18 Dec 2025 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766063298;
	bh=xGSeZoo8A4otZiM+Me0157v7z6QWInhRsz4o+w4d45E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KQ+66YlxanK99AmGFS+hJoQ0JNeSpw9MPMZirOXFW/OpdDAd+sh93g+L4GQS+tWLH
	 nkiK3IdUgd1FfMP1BU59L4AERAy1K8TK5wGG48+tgvAawKgdlVwHF9/VEOhGT8HN8T
	 PpP+oi058arCeHD6iSJy4aRNuJrpIsVh7Rl6OpDpp5OfpM2/zaNwX3GEdyfx9n1cNO
	 63LWQAa1NjHuz26AGjgsJxZeqgDBdA8o6/kF6rOThkruCypAwDTTCVqBmHi3o2grIf
	 qaUzDtiSBioKw6iSWz/1xoDEV0V20uyOZdDJL14ew5bp5R9wwlQMYVJIXd7xbHLsx3
	 69ENOKt+sXqrg==
Message-ID: <c36501bc-2690-4ed2-b85e-13e64c41baaf@kernel.org>
Date: Thu, 18 Dec 2025 14:08:07 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] x86/mm: implement redundant IPI elimination for
 PMD unsharing
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251213080038.10917-1-lance.yang@linux.dev>
 <20251213080038.10917-3-lance.yang@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251213080038.10917-3-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/13/25 09:00, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> Pass both freed_tables and unshared_tables to flush_tlb_mm_range() to
> ensure lazy-TLB CPUs receive IPIs and flush their paging-structure caches:
> 
> 	flush_tlb_mm_range(..., freed_tables || unshared_tables);
> 
> Implement tlb_table_flush_implies_ipi_broadcast() for x86: on native x86
> without paravirt or INVLPGB, the TLB flush IPI already provides necessary
> synchronization, allowing the second IPI to be skipped. For paravirt with
> non-native flush_tlb_multi and for INVLPGB, conservatively keep both IPIs.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   arch/x86/include/asm/tlb.h | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
> index 866ea78ba156..96602b7b7210 100644
> --- a/arch/x86/include/asm/tlb.h
> +++ b/arch/x86/include/asm/tlb.h
> @@ -5,10 +5,24 @@
>   #define tlb_flush tlb_flush
>   static inline void tlb_flush(struct mmu_gather *tlb);
>   
> +#define tlb_table_flush_implies_ipi_broadcast tlb_table_flush_implies_ipi_broadcast
> +static inline bool tlb_table_flush_implies_ipi_broadcast(void);
> +
>   #include <asm-generic/tlb.h>
>   #include <linux/kernel.h>
>   #include <vdso/bits.h>
>   #include <vdso/page.h>
> +#include <asm/paravirt.h>
> +
> +static inline bool tlb_table_flush_implies_ipi_broadcast(void)
> +{
> +#ifdef CONFIG_PARAVIRT
> +	/* Paravirt may use hypercalls that don't send real IPIs. */
> +	if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
> +		return false;
> +#endif
> +	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);

Right, here I was wondering whether we should have a new pv_ops callback 
to indicate that instead.

pv_ops.mmu.tlb_table_flush_implies_ipi_broadcast()

Or a simple boolean property that pv init code properly sets.

Something for x86 folks to give suggestions for. :)

-- 
Cheers

David


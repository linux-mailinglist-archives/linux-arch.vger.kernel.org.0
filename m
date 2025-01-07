Return-Path: <linux-arch+bounces-9618-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95581A03E5B
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 12:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409E53A3152
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072B1EB9FA;
	Tue,  7 Jan 2025 11:58:22 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F321D515B;
	Tue,  7 Jan 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251102; cv=none; b=GXLQKJrwWtucQqzz9t3kg+AEaxJ6K2FOACi/PENhNjk26Y3WnM93DnQ1Pz4B2w45YKyiwLOV8m98etlgpMs3qOSlgSJuPPWd+jDnqKyaX7MwkHE+GR1rhiXyK1i+6FRs6BilW3m505XpJ9o4SmXAv+Fa2nSxZdxBBdHxk9bYW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251102; c=relaxed/simple;
	bh=TGGJkJPzJ/ul/QAPsmtmQeMD95tQCTIq4WEnha2ywd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTksGiH29RekQpS/HmVTxAieX1HLdhlgk9ETu9EwTg7LgtI/LNdz+P0BHiV5vCiEGBV1ZEfgz364kQqjWIrcg6bJCmhDJkpZBMBKkz/GEb6faSh0oqegoOyMmw55NrOCqhsZTLTN0BTeE+nrJgNHbOwTjJ/aco21OgzPQebDXNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9DC6143D;
	Tue,  7 Jan 2025 03:58:45 -0800 (PST)
Received: from [10.44.160.93] (e126510-lin.lund.arm.com [10.44.160.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 187FC3F673;
	Tue,  7 Jan 2025 03:58:09 -0800 (PST)
Message-ID: <4a0b5edb-6fc7-4df4-93d9-ca834e6a760b@arm.com>
Date: Tue, 7 Jan 2025 12:58:08 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: agordeev@linux.ibm.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
 peterz@infradead.org, akpm@linux-foundation.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
 <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
 <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
 <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
 <e9fe97d4-99d5-443e-b722-43903655a76e@bytedance.com>
 <31e1a033-00a7-4953-81e7-0caedd0227a9@bytedance.com>
 <d9a14211-4bbd-4fb6-ba87-a555a40bb67a@arm.com>
 <de8756aa-dbf7-4f6f-91f0-934270397192@bytedance.com>
 <ee393a7f-d01e-4e5d-9bf8-779795613af1@arm.com>
 <07e0c05f-cb69-4263-885d-6d20d4442152@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <07e0c05f-cb69-4263-885d-6d20d4442152@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/01/2025 11:51, Qi Zheng wrote:
> [...]
>
> Author: Qi Zheng <zhengqi.arch@bytedance.com>
> Date:   Fri Dec 13 17:13:48 2024 +0800
>
>     mm: pgtable: completely move pagetable_dtor() to generic
> tlb_remove_table()
>
>     For the generic tlb_remove_table(), it is implemented in the
> following two
>     forms:
>
>     1) CONFIG_MMU_GATHER_TABLE_FREE is enabled
>
>     tlb_remove_table
>     --> generic __tlb_remove_table()
>
>     2) CONFIG_MMU_GATHER_TABLE_FREE is disabled
>
>     tlb_remove_table
>     --> tlb_remove_page
>
>     For case 1), the pagetable_dtor() has already been moved to generic
>     __tlb_remove_table().
>
>     For case 2), now only arm will call
> tlb_remove_table()/tlb_remove_ptdesc()
>     when CONFIG_MMU_GATHER_TABLE_FREE is disabled. Let's move
> pagetable_dtor()
>     completely to generic tlb_remove_table(), so that the
> architectures can
>     follow more easily.
>
>     Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index b8eebdb598631..ea4fbe7b17f6f 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -34,10 +34,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t
> pte, unsigned long addr)
>  {
>         struct ptdesc *ptdesc = page_ptdesc(pte);
>
> -#ifndef CONFIG_MMU_GATHER_TABLE_FREE
> -       pagetable_dtor(ptdesc);
> -#endif

I guess this hunk will disappear since this call isn't present to start
with.

> -
>  #ifndef CONFIG_ARM_LPAE
>         /*
>          * With the classic ARM MMU, a pte page has two corresponding pmd
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 69de47c7ef3c5..53ae7748f555b 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -220,14 +220,20 @@ static inline void __tlb_remove_table(void *table)
>
>  extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>
> -#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
> +#else /* !CONFIG_MMU_GATHER_TABLE_FREE */

Good catch!

>
> +static inline void tlb_remove_page(struct mmu_gather *tlb, struct
> page *page);

Nit: might be better to move the declaration up, e.g. above #ifdef
CONFIG_MMU_GATHER_TABLE_FREE.

>  /*
>   * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have
> page based
>   * page directories and we can use the normal page batching to free
> them.
>   */
> -#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
> +static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
> +{
> +       struct page *page = (struct page *)table;
>
> +       pagetable_dtor(page_ptdesc(page));
> +       tlb_remove_page(tlb, page);
> +}
>  #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
>
>  #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE

Looks good to me otherwise.

- Kevin


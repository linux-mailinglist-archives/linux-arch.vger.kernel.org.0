Return-Path: <linux-arch+bounces-9564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852F4A0057A
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 09:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9E91884132
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86161C8FD7;
	Fri,  3 Jan 2025 08:03:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681A322619;
	Fri,  3 Jan 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735891393; cv=none; b=G6G2++D2HUUc/hOvbkcJnyl2/UTwGqu1Uv4g5f8WFZocCcOda5OeRdnh//5KkUdCKpDeX6WeHmTdLFYCQnri5pi+rctyllPBmTSJAyKB/kQ7n/+z+zLXZHIaONfJlvQaS1DVG6bVLhqlPVL8e5G5gvtM+2VXfmzGjj8LOWi7jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735891393; c=relaxed/simple;
	bh=/OeHPFYsSusQTMTpEoomDP6spK4mL3gkKfUc71lXwpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nr0zHSSyXpUcIzDMO3K8qXR+9elbfvFODdj+Ph6/rherPfmFCaa48Aqes6IjYoDRfjuslm8bGAWeghiqGP0A8eVCU8bAZXdRJDQM3AEtdQedU5nJjaJJkrDKYX3s/BcwHzPDudQz0FbEdFXwTlPMESqjnvMn86UmE5Wz3dnwueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D277D150C;
	Fri,  3 Jan 2025 00:03:37 -0800 (PST)
Received: from [10.57.92.237] (unknown [10.57.92.237])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CED73F673;
	Fri,  3 Jan 2025 00:03:01 -0800 (PST)
Message-ID: <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
Date: Fri, 3 Jan 2025 09:02:59 +0100
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
Cc: peterz@infradead.org, agordeev@linux.ibm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
 <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
 <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/01/2025 04:48, Qi Zheng wrote:
> Hi Kevin,
>
> On 2025/1/3 00:53, Kevin Brodsky wrote:
>> On 30/12/2024 10:07, Qi Zheng wrote:
>>>   static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb,
>>> void *pt)
>>>   {
>>> -    if (riscv_use_sbi_for_rfence())
>>> +    if (riscv_use_sbi_for_rfence()) {
>>>           tlb_remove_ptdesc(tlb, pt);
>>> -    else
>>> +    } else {
>>> +        pagetable_dtor(pt);
>>>           tlb_remove_page_ptdesc(tlb, pt);
>>
>> I find the imbalance pretty confusing: pagetable_dtor() is called
>> explicitly before using tlb_remove_page() but not tlb_remove_ptdesc().
>> Doesn't that assume that CONFIG_MMU_GATHER_HAVE_TABLE_FREE is selected?
>> Could we not call pagetable_dtor() from __tlb_batch_free_encoded_pages()
>> to ensure that the dtor is always called just before freeing, and remove
>
> In __tlb_batch_free_encoded_pages(), we can indeed detect PageTable()
> and call pagetable_dtor() to dtor the page table pages.
> But __tlb_batch_free_encoded_pages() is also used to free normal pages
> (not page table pages), so I don't want to add overhead there.

Interesting, can a tlb batch refer to pages than are not PTPs then?

>
> But now I think maybe we can do this in tlb_remove_page_ptdesc(), like
> this:
>
> diff --git a/arch/csky/include/asm/pgalloc.h
> b/arch/csky/include/asm/pgalloc.h
> index f1ce5b7b28f22..e45c7e91dcbf9 100644
> --- a/arch/csky/include/asm/pgalloc.h
> +++ b/arch/csky/include/asm/pgalloc.h
> @@ -63,7 +63,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>
>  #define __pte_free_tlb(tlb, pte, address)              \
>  do {                                                   \
> -       pagetable_dtor(page_ptdesc(pte));               \
>         tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));  \
>  } while (0)
>
> [...]
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index a96d4b440f3da..a59205863f431 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -506,6 +506,7 @@ static inline void tlb_remove_ptdesc(struct
> mmu_gather *tlb, void *pt)
>  /* Like tlb_remove_ptdesc, but for page-like page directories. */
>  static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb,
> struct ptdesc *pt)
>  {
> +       pagetable_dtor(pt);
>         tlb_remove_page(tlb, ptdesc_page(pt));
>  }

I think this is an interesting idea, it does make arch code easier to
follow. OTOH it would have been more natural to me to call
pagetable_dtor() from tlb_remove_page(). I can however see that this
doesn't work, because tlb_remove_table() is defined as tlb_remove_page()
if CONFIG_MMU_GATHER_HAVE_TABLE_FREE isn't selected. Which brings me
back to my earlier question: in that case, aren't we missing a call to
pagetable_dtor() when using tlb_remove_table() (or tlb_remove_ptdesc())?

- Kevin


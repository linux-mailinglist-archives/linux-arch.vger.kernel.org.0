Return-Path: <linux-arch+bounces-9616-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B085A03BA2
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 10:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C19165A0A
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 09:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74671E1C1F;
	Tue,  7 Jan 2025 09:58:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EC97081E;
	Tue,  7 Jan 2025 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736243891; cv=none; b=N5P3xGbFMitG/jv2nuI5MrsVQm0iw/E97SjclsQI0sj2j22CWGeW/Fzd4zQobT0AvksPPTIfIKH+hRCUzrH96zDY3tsXgY7x9DIX5j3qBIgdp0J+QUI518AtXehRAOCaqioM7ReLtLvsEERWnTCFxlc+fnFZ51s5OD8IGsmOgZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736243891; c=relaxed/simple;
	bh=zdmYeT6nirJQQeULEz/Mx26Ga9KASAi8ohiMId5QGl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JyZ05x7LizVYQhRJsTBoR5p2pLU9xhDsiOYoHxo7Hvh3vqOhxJRVFL7xOzsDCFlAcHlCGTviQZPPbCAIQZn11fgh4CnM30ugX5xYYGZHA7CXWByXK8d6QI78NOwK6dtqrPPG3d9zHHZfsAEOYr9l6D07v6O2eWJC7ynqcEVTWnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D1D0143D;
	Tue,  7 Jan 2025 01:58:37 -0800 (PST)
Received: from [10.44.160.93] (e126510-lin.lund.arm.com [10.44.160.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46B0F3F673;
	Tue,  7 Jan 2025 01:58:01 -0800 (PST)
Message-ID: <ee393a7f-d01e-4e5d-9bf8-779795613af1@arm.com>
Date: Tue, 7 Jan 2025 10:57:59 +0100
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
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <de8756aa-dbf7-4f6f-91f0-934270397192@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/01/2025 04:49, Qi Zheng wrote:
> [...]
>
>> Once this is done, we should be able to replace all those confusing
>> calls to tlb_remove_page() on PTPs with tlb_remove_table() and remove
>> the explicit call to pagetable_dtor(). AIUI this is essentially what
>> Peter suggested on v3 [2].
>
> Since this patch series is mainly for bug fix, I think that these things
> can be done in separate patch series later.

Sure that's fair.

>
>>
>> [...]
>>
>>> Or can we just not let tlb_remove_table() fall back to
>>> tlb_remove_page()? Like the following:
>>>
>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>>> index a59205863f431..354ffaa4bd120 100644
>>> --- a/include/asm-generic/tlb.h
>>> +++ b/include/asm-generic/tlb.h
>>> @@ -195,8 +195,6 @@
>>>    *  various ptep_get_and_clear() functions.
>>>    */
>>>
>>> -#ifdef CONFIG_MMU_GATHER_TABLE_FREE
>>> -
>>>   struct mmu_table_batch {
>>>   #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
>>>          struct rcu_head         rcu;
>>> @@ -219,16 +217,6 @@ static inline void __tlb_remove_table(void *table)
>>>
>>>   extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>>>
>>> -#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
>>> -
>>> -/*
>>> - * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have
>>> page based
>>> - * page directories and we can use the normal page batching to free
>>> them.
>>> - */
>>> -#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
>>
>> We still need a different implementation of tlb_remove_table() in this
>> case. We could define it inline here:
>>
>> static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
>> {
>>      struct page *page = table;
>>
>>      pagetable_dtor(page_ptdesc(page));
>>      tlb_remove_page(page);
>> }
>
> Right. As I said above, will add this to the updated patch #8.

I think it would be preferable to make it a standalone patch, because
this is a change to generic code that could in principle impact other
arch's too.

- Kevin


Return-Path: <linux-arch+bounces-14786-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC9C5E2CD
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 110413C6AF2
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BDE330B13;
	Fri, 14 Nov 2025 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g/B/dUgx"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F832E759
	for <linux-arch@vger.kernel.org>; Fri, 14 Nov 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135791; cv=none; b=udGsdodyUm9t/BEMQIut5/knwNJhkdkpDihFQDmpj9k4d87LIuSPUnjlrswwptCvdL9lyV+Fm6I1yWDHYH8PUa+CFxNpT68xoXOOsyg0ocWX7DWDcWVuetWA1e1eRgdRe4kQz5Bf1h6ZR3+IiGKM4nWO+TBMfoR0pUQPPOvFF4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135791; c=relaxed/simple;
	bh=oCfKqzUObEJiEhQh9AzT8v3OnOWB3D/LAB7Z/M9UFNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/0Hs5XPU9jFuR3XQAdepsMPoFEGcA1BNCyo/jAPFSfrt0/VWDP9HgmLe7JjkUS/eVx2l+YZtxpFbK6DgXC9fXZbX8rPzcwAy1hMdHM5fvnSCGTAgehK8CONrOulbFGAPx6iCVc4iwk/TmBkhNLUE/uub278j8vwPlR2uUYdXkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g/B/dUgx; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc08c1a8-f469-43f1-93c0-7fcd2b1c477c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763135775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKysolUqeVjYcgMrPs/ejmALi8P8XvxL85H5NRIJlY8=;
	b=g/B/dUgxQJEHGDks1FfISlakIsod43sd1FWkLD53noWx1K51GzX035cGzeBE8Edv7rjSas
	eRoApfQqE5kMQiTGhq6jTv0fxdja6UCOlpRx6Wco9NKN4CqyYrziO6a9K/p051HV0WDT14
	Mhzi2WwkSotO4sbe8SdPRtkBrzsJI8U=
Date: Fri, 14 Nov 2025 23:55:11 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] loongarch: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Huacai Chen <chenhuacai@kernel.org>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
 david@redhat.com, ioworker0@gmail.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, WANG Xuerui <kernel@xen0n.name>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <146b5a0207052b38d04caac6b20756a61c2189b3.1763117269.git.zhengqi.arch@bytedance.com>
 <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Huacai,

On 11/14/25 10:17 PM, Huacai Chen wrote:
> Hi, Qi Zheng,
> 
> We usually use LoongArch rather than loongarch, but if you want to
> keep consistency for all patches, just do it.

OK, will change to use LoongArch.

> 
> On Fri, Nov 14, 2025 at 7:13 PM Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
>> empty PTE page table pages (such as 100GB+). To resolve this problem,
>> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
>> PT_RECLAIM feature, which resolves this problem.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Cc: Huacai Chen <chenhuacai@kernel.org>
>> Cc: WANG Xuerui <kernel@xen0n.name>
>> ---
>>   arch/loongarch/Kconfig               | 1 +
>>   arch/loongarch/include/asm/pgalloc.h | 6 ++++--
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 5b1116733d881..3bf2f2a9cd647 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -210,6 +210,7 @@ config LOONGARCH
>>          select USER_STACKTRACE_SUPPORT
>>          select VDSO_GETRANDOM
>>          select ZONE_DMA32
>> +       select MMU_GATHER_RCU_TABLE_FREE
> Please use alpha-betical order.

OK, will do.

> 
>>
>>   config 32BIT
>>          bool
>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
>> index 1c63a9d9a6d35..0539d04bf1525 100644
>> --- a/arch/loongarch/include/asm/pgalloc.h
>> +++ b/arch/loongarch/include/asm/pgalloc.h
>> @@ -79,7 +79,8 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>>          return pmd;
>>   }
>>
>> -#define __pmd_free_tlb(tlb, x, addr)   pmd_free((tlb)->mm, x)
>> +#define __pmd_free_tlb(tlb, x, addr)   \
>> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
> I think we can define it in one line.

will do.

> 
>>
>>   #endif
>>
>> @@ -99,7 +100,8 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>>          return pud;
>>   }
>>
>> -#define __pud_free_tlb(tlb, x, addr)   pud_free((tlb)->mm, x)
>> +#define __pud_free_tlb(tlb, x, addr)   \
>> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
> The same.
> 
> Other patches have the same problem.

Got it, will convert them all to the one-line type.

Thanks,
Qi

> 
> Huacai
> 
>>
>>   #endif /* __PAGETABLE_PUD_FOLDED */
>>
>> --
>> 2.20.1
>>



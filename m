Return-Path: <linux-arch+bounces-9569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA684A007E9
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 11:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDF5318809CC
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 10:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C5C1D131E;
	Fri,  3 Jan 2025 10:36:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6061C3C05;
	Fri,  3 Jan 2025 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735900576; cv=none; b=rCw9ie1BUqfQUsnx7pwt2ODVRLBnwY/tSea6FRVwFtuZekBrmm//uq0yNsaBT/cWiKCrA0KYAlK1qQ/KU9zLxBU3WAXDo64gkcwVsm14weYtyQSOTWWA5j7joGSw69coyoQdyQFwIx/DxTJpVe/cSMpgAvUlYF565V5Ucsfa4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735900576; c=relaxed/simple;
	bh=KqzYXTStRwHdA2r44yWtS6M9tFw/JByatD25oVsaaPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BU+4jAtGdsUBBBIbBkHlvgEeHY+TO+RaAOhh2jjyR1zluC5l1RXs7+JNRSoSps61I0No0I3tNabcGL4eXZ6CZq0VZCEfX4BZfTqkxZP+tixD5+I49zSyBceA31SntVsW5YnYunjamUbKryZZKB0Gcr+imw+5ttnpMgsTAmW5e5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45A1D150C;
	Fri,  3 Jan 2025 02:36:41 -0800 (PST)
Received: from [10.44.160.93] (e126510-lin.lund.arm.com [10.44.160.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8736A3F6A8;
	Fri,  3 Jan 2025 02:36:06 -0800 (PST)
Message-ID: <39925677-4619-411d-b0b1-40f9db09374f@arm.com>
Date: Fri, 3 Jan 2025 11:36:03 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] riscv: mm: Skip pgtable level check in
 {pud,p4d}_alloc_one
To: Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, loongarch@lists.linux.dev, x86@kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-6-kevin.brodsky@arm.com>
 <2aed338a-97a4-40e3-8a95-99458756ca28@ghiti.fr>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <2aed338a-97a4-40e3-8a95-99458756ca28@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+Qi

On 03/01/2025 11:31, Alexandre Ghiti wrote:
> Hi Kevin,
>
> On 19/12/2024 17:44, Kevin Brodsky wrote:
>> {pmd,pud,p4d}_alloc_one() is never called if the corresponding page
>> table level is folded, as {pmd,pud,p4d}_alloc() already does the
>> required check. We can therefore remove the runtime page table level
>> checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
>> the generic version, so we remove it altogether.
>>
>> This is consistent with the way arm64 and x86 handle this situation
>> (runtime check in p4d_free() only).
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>   arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
>>   1 file changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/pgalloc.h
>> b/arch/riscv/include/asm/pgalloc.h
>> index f52264304f77..8ad0bbe838a2 100644
>> --- a/arch/riscv/include/asm/pgalloc.h
>> +++ b/arch/riscv/include/asm/pgalloc.h
>> @@ -12,7 +12,6 @@
>>   #include <asm/tlb.h>
>>     #ifdef CONFIG_MMU
>> -#define __HAVE_ARCH_PUD_ALLOC_ONE
>>   #define __HAVE_ARCH_PUD_FREE
>>   #include <asm-generic/pgalloc.h>
>>   @@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct
>> mm_struct *mm, pgd_t *pgd,
>>       }
>>   }
>>   -#define pud_alloc_one pud_alloc_one
>> -static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned
>> long addr)
>> -{
>> -    if (pgtable_l4_enabled)
>> -        return __pud_alloc_one(mm, addr);
>> -
>> -    return NULL;
>> -}
>> -
>>   #define pud_free pud_free
>>   static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>>   {
>> @@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct
>> mmu_gather *tlb, pud_t *pud,
>>   #define p4d_alloc_one p4d_alloc_one
>>   static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned
>> long addr)
>>   {
>> -    if (pgtable_l5_enabled) {
>> -        gfp_t gfp = GFP_PGTABLE_USER;
>> -
>> -        if (mm == &init_mm)
>> -            gfp = GFP_PGTABLE_KERNEL;
>> -        return (p4d_t *)get_zeroed_page(gfp);
>> -    }
>> +    gfp_t gfp = GFP_PGTABLE_USER;
>>   -    return NULL;
>> +    if (mm == &init_mm)
>> +        gfp = GFP_PGTABLE_KERNEL;
>> +    return (p4d_t *)get_zeroed_page(gfp);
>>   }
>>     static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
>
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the review! Just FYI this patch is now part of Qi's series
[1], I will drop it when posting the next version of this series.

- Kevin

[1]
https://lore.kernel.org/linux-mm/84ddf857508b98a195a790bc6ff6ab8849b44633.1735549103.git.zhengqi.arch@bytedance.com/


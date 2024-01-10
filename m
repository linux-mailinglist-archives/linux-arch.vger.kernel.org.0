Return-Path: <linux-arch+bounces-1328-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2829829CD9
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 15:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A151C21890
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BDA4BA81;
	Wed, 10 Jan 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="fBAd9Iel"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AE4BA86
	for <linux-arch@vger.kernel.org>; Wed, 10 Jan 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3608402ab93so17130075ab.0
        for <linux-arch@vger.kernel.org>; Wed, 10 Jan 2024 06:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1704898354; x=1705503154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVtS8rM9wqn1PqYUXWdr8pk/hBP2Hc85AVIVtCVRz8Y=;
        b=fBAd9Ielfai7WtsDEiImQ+n13vIY5JGFL4UN4Frm8tf5PH+KJiw9nsut0HqsTk34FV
         CJX0ulbEAjTRJTkGjFFK5Gxv4o+Zpl5F5sT1n3bPUnmQtR+WF+NKdih1trzmTv3++COp
         LdrSw/6GFQra2zDd7tMLVdJ9dIawUsIOplwkxD1VpUKwj9qHQZzgtC0CkOdG7mLKGAIF
         yToVlKmiAX7EUyECETvtzeCHIOaL9xrr9DEsKJN/h/AIdz+cZwZpt8M8jGnUQD4pBPNe
         IB4AFDt+vOsTSF8kLXQlj9LLR3p2NR/eNgumqRN9tDDR0Lhrhzz7/eGQhnhs0Ub9i7Pe
         80lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898354; x=1705503154;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVtS8rM9wqn1PqYUXWdr8pk/hBP2Hc85AVIVtCVRz8Y=;
        b=a5QCDqxnNO1ImI/sm4sNJ/D/jAo62pEfV6EPrF4QDCLNg2M2Hl+oeADRXBQoOEaBX6
         XbjySHUjgm+4FnlHJI79jjTlWT23jYK25ivuKtaUJ892/2293I3lAn914WCH5GRHmpyu
         pSFSLN1Uk5kINeY4V6DMeVVGGQnArP9oaiZZrdLLRvK82EUk9gVpzkKb/vnDYNgGwwYk
         RdKKX99EpZWLJ0nFzeE6ZtGB39nyEuvvqrFAvgTKNNURZnjNZllXKSkxy86GGsL9Rn23
         VKMftLq+aMG8fp58K0f7Hj8zL2ycsUqt+VV2Ju0G47AXgZNk56T27OglUDmTM/Awljl1
         a1Sg==
X-Gm-Message-State: AOJu0YzCV214aMhjGHZWLXqbvB4Pg/k5OywhepQJJ/DXzJBvvibCMYXK
	LYtNCsBYbUU0r2asGineTU7CTVSXNnG2+A==
X-Google-Smtp-Source: AGHT+IFvaD94WRGIWckQ9Hv3P7P0TvTdYRGacf1iIOKv8qIUaj9Zvtv4eSDrKd5J5ma8n/u1tTQeFQ==
X-Received: by 2002:a05:6e02:34a0:b0:360:90c2:f7ca with SMTP id bp32-20020a056e0234a000b0036090c2f7camr1673156ilb.40.1704898354434;
        Wed, 10 Jan 2024 06:52:34 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id bc25-20020a056e02009900b0035fabab7985sm1278883ilb.21.2024.01.10.06.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:52:33 -0800 (PST)
Date: Wed, 10 Jan 2024 06:52:33 -0800 (PST)
X-Google-Original-Date: Wed, 10 Jan 2024 06:52:32 PST (-0800)
Subject:     Re: [PATCH 1/4] riscv: tlb: fix __p*d_free_tlb()
In-Reply-To: <36166acf-aa32-40b6-806a-ade59bc645ad@ghiti.fr>
CC: jszhang@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, Will Deacon <will@kernel.org>, aneesh.kumar@linux.ibm.com,
  akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org,
  Conor Dooley <conor.dooley@microchip.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org, linux-mm@kvack.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: alex@ghiti.fr
Message-ID: <mhng-53f8ef0e-67ee-4a85-ba8a-84124df534ce@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 04 Jan 2024 02:55:40 PST (-0800), alex@ghiti.fr wrote:
> On 19/12/2023 18:50, Jisheng Zhang wrote:
>> If non-leaf PTEs I.E pmd, pud or p4d is modified, a sfence.vma is
>> a must for safe, imagine if an implementation caches the non-leaf
>> translation in TLB, although I didn't meet this HW so far, but it's
>> possible in theory.
>
>
> And since this is a fix, it would be worth trying to add a Fixes tag
> here. Not easy I agree because it fixes several commits (I have
> 07037db5d479f,  e8a62cc26ddf5, d10efa21a9374 and c5e9b2c2ae822 if you
> implement tlb_flush() as I suggested).
>
> So I would add the latest commit as the Fixes commit (which would be
> c5e9b2c2ae822), and then I'd send a patch to stable for each commit with
> the right Fixes tag...@Conor: let me know if you have a simpler idea or
> if this is wrong.

I just went with

Fixes: c5e9b2c2ae82 ("riscv: Improve tlb_flush()")
Cc: stable@vger.kernel.org

hopefully that's fine.  It's still getting tested, it's batched up with 
some other stuff and I managed to find a bad merge so it might take a 
bit...

>
> Thanks,
>
> Alex
>
>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>   arch/riscv/include/asm/pgalloc.h | 20 +++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
>> index d169a4f41a2e..a12fb83fa1f5 100644
>> --- a/arch/riscv/include/asm/pgalloc.h
>> +++ b/arch/riscv/include/asm/pgalloc.h
>> @@ -95,7 +95,13 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>>   		__pud_free(mm, pud);
>>   }
>>
>> -#define __pud_free_tlb(tlb, pud, addr)  pud_free((tlb)->mm, pud)
>> +#define __pud_free_tlb(tlb, pud, addr)					\
>> +do {									\
>> +	if (pgtable_l4_enabled) {					\
>> +		pagetable_pud_dtor(virt_to_ptdesc(pud));		\
>> +		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
>> +	}								\
>> +} while (0)
>>
>>   #define p4d_alloc_one p4d_alloc_one
>>   static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
>> @@ -124,7 +130,11 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>>   		__p4d_free(mm, p4d);
>>   }
>>
>> -#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
>> +#define __p4d_free_tlb(tlb, p4d, addr)					\
>> +do {									\
>> +	if (pgtable_l5_enabled)						\
>> +		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(p4d));	\
>> +} while (0)
>>   #endif /* __PAGETABLE_PMD_FOLDED */
>>
>>   static inline void sync_kernel_mappings(pgd_t *pgd)
>> @@ -149,7 +159,11 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>>
>>   #ifndef __PAGETABLE_PMD_FOLDED
>>
>> -#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
>> +#define __pmd_free_tlb(tlb, pmd, addr)				\
>> +do {								\
>> +	pagetable_pmd_dtor(virt_to_ptdesc(pmd));		\
>> +	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
>> +} while (0)
>>
>>   #endif /* __PAGETABLE_PMD_FOLDED */
>>


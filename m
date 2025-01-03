Return-Path: <linux-arch+bounces-9567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E56A0071B
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 10:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEAD3A0883
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78A41F8EF3;
	Fri,  3 Jan 2025 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ReqPhI4L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC79B1F9403
	for <linux-arch@vger.kernel.org>; Fri,  3 Jan 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896950; cv=none; b=ivZmteyhpeyKGOOvJWciJ5ZwdjJ2loVbpg9ArPGZmOT8y/HpXmXBj+6wa/m/6rMtyypOQ1iXxgsEABc4w+po6Lc/XvEsa5maP2CoCl2F2yrsGQQR0NDZ/Bx4XCnctMVD9Jqo8wcevUijmt+S4KFWXCx/DQ/JBKDYXsX1XpJbMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896950; c=relaxed/simple;
	bh=z3KUSQuQ6fUzdXdRu0kLqVdkc9nzsYb+5BilIA5WCiM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KZkkzcx3HjXhfx/Wsslhk1BlJvkTS8/oiUSRMYEmOUVvDJR31aLT+9dcTD343L2AfNVvjVBmGBI+3kPCRWH0pJJDWiLcR732zsxyx+ELKW9BZLlFFx/LlrcSOE9azwZX1+gUg5IfJAcex1IDJfjU2Q/L4s8x3YWii4XtlDdRyuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ReqPhI4L; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21654fdd5daso156330205ad.1
        for <linux-arch@vger.kernel.org>; Fri, 03 Jan 2025 01:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735896946; x=1736501746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWtjK5g4BM/SvEXkEBPomhMpQ0cOqD61cD7+kwN1xqo=;
        b=ReqPhI4LEx49LBYsSLjW2hQFzzDvJuzr+PX7F9nW/Ji6URux5pu5n0rvMAfG5TWVXD
         cUh7fqIb9KlGpPN7HyMeBXlpfpBgAoynwg4zbsRCGeeMwXoQQd6VVM3/VIvIg4LX0UmQ
         XCmzTN14ItWg6b7sJUlryeGUeotHDxuV8wFlcZZSl98XTGaSOD+NX6Py1QvLT5rcsXT7
         szfYHcXsJBAS3o93OH2/9nHfbU2G8IQkCdJOasbYWjvXNv/tLHRNAaLETWzlA+IoWVCy
         CQ6ENApTXq+K0YcISamA4qym7/cm1nEz/mFtmlOQnBvzQkZIJD3GVZsTTXzfbpKAtsrI
         eXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735896946; x=1736501746;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWtjK5g4BM/SvEXkEBPomhMpQ0cOqD61cD7+kwN1xqo=;
        b=bKjgDVGutqz9MVf4l3JlWi2AXSfkJ6e/0Etxzx7U/zkGAELtObBqub0YP0vtA8pxjs
         SsQZrxuseeVGnoNtT9voILKOs453VjzjzLs6GBXLfhVBumlDT40ICeBTcdO/VaXmSlvc
         N+XC2OO6hF7CQYFObmq70AT2pega2QMwhgg+2C2vouOtRyMfCi+aZLOSexKtv1n219T7
         GLBGxBbTE1i8s3ZsBvfcawmRrxKukUCeR9sDtaeULgVaqdr6SUKuFccmESOknmCSVfjr
         eFY8xb71yL+mRg6WhWOCuFjkJW7ayqLlXsPmaLqcopLnYnDf5lZMh/6ncWt9589r9CxQ
         uIfg==
X-Forwarded-Encrypted: i=1; AJvYcCULWMR9BXyN6Jg6ZUvFhONILyUwGbvbhmYi9qv/sImDOGYT8DDduSr8C/RRJYDaCqbwpj26Mnw0ye8N@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdpQFyyIhpo3DGAyRm5MW9NBHTfjN76CcMfEungdkmcit8Foh
	zkhXwPXcggte4KiX7MNVMnItycCOYsvFofbcSU7apDLxMm216LCHIlIy/Lt5fdI=
X-Gm-Gg: ASbGnct67bxK2gcISKvZ6Vz6gmLFoxQ/9b2plFY5pfgUNDjOTIBWFWXM0fFGpOtHzi/
	OZs9GGSB0KxBrzkHFpE3Pz5d0geOPA2e6bQGk1t7uhHYjwzoycZIYkIEHDkchUPFt+jkHSygJVq
	04JEzgtUC3CoYppuxTuFn6f07xAJFm3XM8OPpPCapAPCwHzfdxJkJrlwSAl14hCBjEBu9YWCxLu
	IsOl0eNCBbt77EYB2+Lhqq+2NF9mTj8KJAFEP4HYgCcakbPUemk/cMWN3XjWKhoi8u/LxkF6t9e
	W2ia7Q==
X-Google-Smtp-Source: AGHT+IE9O96BS3RyGLgD9ozZE9cvlEJyEf8vCWPZNZOt2fNtD1RyepOtwaueaYCtTF24hvZZQqYEyw==
X-Received: by 2002:a17:902:d481:b0:215:6fcd:6cd1 with SMTP id d9443c01a7336-219e6e8c508mr551854195ad.7.1735896945927;
        Fri, 03 Jan 2025 01:35:45 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cddf2sm241537305ad.166.2025.01.03.01.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 01:35:45 -0800 (PST)
Message-ID: <31e1a033-00a7-4953-81e7-0caedd0227a9@bytedance.com>
Date: Fri, 3 Jan 2025 17:35:30 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>, peterz@infradead.org
Cc: agordeev@linux.ibm.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
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
 <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
 <e9fe97d4-99d5-443e-b722-43903655a76e@bytedance.com>
In-Reply-To: <e9fe97d4-99d5-443e-b722-43903655a76e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/1/3 17:13, Qi Zheng wrote:
> 
> 
> On 2025/1/3 16:02, Kevin Brodsky wrote:
>> On 03/01/2025 04:48, Qi Zheng wrote:
>>> Hi Kevin,
>>>
>>> On 2025/1/3 00:53, Kevin Brodsky wrote:
>>>> On 30/12/2024 10:07, Qi Zheng wrote:
>>>>>    static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb,
>>>>> void *pt)
>>>>>    {
>>>>> -    if (riscv_use_sbi_for_rfence())
>>>>> +    if (riscv_use_sbi_for_rfence()) {
>>>>>            tlb_remove_ptdesc(tlb, pt);
>>>>> -    else
>>>>> +    } else {
>>>>> +        pagetable_dtor(pt);
>>>>>            tlb_remove_page_ptdesc(tlb, pt);
>>>>
>>>> I find the imbalance pretty confusing: pagetable_dtor() is called
>>>> explicitly before using tlb_remove_page() but not tlb_remove_ptdesc().
>>>> Doesn't that assume that CONFIG_MMU_GATHER_HAVE_TABLE_FREE is selected?
>>>> Could we not call pagetable_dtor() from 
>>>> __tlb_batch_free_encoded_pages()
>>>> to ensure that the dtor is always called just before freeing, and 
>>>> remove
>>>
>>> In __tlb_batch_free_encoded_pages(), we can indeed detect PageTable()
>>> and call pagetable_dtor() to dtor the page table pages.
>>> But __tlb_batch_free_encoded_pages() is also used to free normal pages
>>> (not page table pages), so I don't want to add overhead there.
>>
>> Interesting, can a tlb batch refer to pages than are not PTPs then?
> 
> Yes, you can see the caller of __tlb_remove_folio_pages() or 
> tlb_remove_page_size().
> 
>>
>>>
>>> But now I think maybe we can do this in tlb_remove_page_ptdesc(), like
>>> this:
>>>
>>> diff --git a/arch/csky/include/asm/pgalloc.h
>>> b/arch/csky/include/asm/pgalloc.h
>>> index f1ce5b7b28f22..e45c7e91dcbf9 100644
>>> --- a/arch/csky/include/asm/pgalloc.h
>>> +++ b/arch/csky/include/asm/pgalloc.h
>>> @@ -63,7 +63,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>>>
>>>   #define __pte_free_tlb(tlb, pte, address)              \
>>>   do {                                                   \
>>> -       pagetable_dtor(page_ptdesc(pte));               \
>>>          tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));  \
>>>   } while (0)
>>>
>>> [...]
>>>
>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>>> index a96d4b440f3da..a59205863f431 100644
>>> --- a/include/asm-generic/tlb.h
>>> +++ b/include/asm-generic/tlb.h
>>> @@ -506,6 +506,7 @@ static inline void tlb_remove_ptdesc(struct
>>> mmu_gather *tlb, void *pt)
>>>   /* Like tlb_remove_ptdesc, but for page-like page directories. */
>>>   static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb,
>>> struct ptdesc *pt)
>>>   {
>>> +       pagetable_dtor(pt);
>>>          tlb_remove_page(tlb, ptdesc_page(pt));
>>>   }
>>
>> I think this is an interesting idea, it does make arch code easier to
>> follow. OTOH it would have been more natural to me to call
>> pagetable_dtor() from tlb_remove_page(). I can however see that this
>> doesn't work, because tlb_remove_table() is defined as tlb_remove_page()
>> if CONFIG_MMU_GATHER_HAVE_TABLE_FREE isn't selected. Which brings me
>> back to my earlier question: in that case, aren't we missing a call to
>> pagetable_dtor() when using tlb_remove_table() (or tlb_remove_ptdesc())?
> 
> Thank you for pointing this out!
> 
> Now, there are the following architectures selected 
> CONFIG_MMU_GATHER_RCU_TABLE_FREE:
> 
> 1. arm: select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
> 2. arm64: select MMU_GATHER_RCU_TABLE_FREE
> 3. powerpc: select MMU_GATHER_RCU_TABLE_FREE
> 4. riscv: select MMU_GATHER_RCU_TABLE_FREE if SMP && MMU
> 5. s390: select MMU_GATHER_RCU_TABLE_FREE
> 6. sparc: select MMU_GATHER_RCU_TABLE_FREE if SMP
> 7. x86: select MMU_GATHER_RCU_TABLE_FREE    if PARAVIRT
> 
> If CONFIG_MMU_GATHER_TABLE_FREE is selected, an architecture is expected
> to provide __tlb_remove_table(). This patch series modifies the
> __tlb_remove_table() in arm, arm64, riscv, s390 and x86. Among them,
> arm64 and s390 unconditionally select MMU_GATHER_RCU_TABLE_FREE, so we
> only need to double-check arm, riscv and x86.
> 
> For x86, it was called tlb_remove_page() in the non-PARAVIRT case, and I
> added pagetable_dtor() for it explicitly (see patch #11), so this should
> be no problem.
> 
> For riscv, it will only call tlb_remove_ptdesc() in the case of
> SMP && MMU, so this should be no problem.
> 
> For arm, the call to pagetable_dtor() is indeed missed in the
> non-MMU_GATHER_RCU_TABLE_FREE case. This needs to be fixed. But we
> can't fix this by adding pagetable_dtor() to tlb_remove_table(),
> because some architectures call tlb_remove_table() but don't support
> page table statistics, like sparc.
> 
> So a more direct fix might be:
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index a59205863f431..0a131444a18ca 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -500,6 +500,9 @@ static inline void tlb_remove_page(struct mmu_gather 
> *tlb, struct page *page)
> 
>   static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
>   {
> +#ifndef CONFIG_MMU_GATHER_TABLE_FREE
> +       pagetable_dtor(pt);
> +#endif
>          tlb_remove_table(tlb, pt);
>   }
> 
> Or fix it directly in arm? Like the following:
> 
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index ea4fbe7b17f6f..cf5d0ca021440 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -43,6 +43,9 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, 
> unsigned long addr)
>          __tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
>   #endif
> 
> +#ifndef CONFIG_MMU_GATHER_TABLE_FREE
> +       pagetable_dtor(ptdesc);
> +#endif
>          tlb_remove_ptdesc(tlb, ptdesc);
>   }

Or can we just not let tlb_remove_table() fall back to
tlb_remove_page()? Like the following:

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index a59205863f431..354ffaa4bd120 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -195,8 +195,6 @@
   *  various ptep_get_and_clear() functions.
   */

-#ifdef CONFIG_MMU_GATHER_TABLE_FREE
-
  struct mmu_table_batch {
  #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
         struct rcu_head         rcu;
@@ -219,16 +217,6 @@ static inline void __tlb_remove_table(void *table)

  extern void tlb_remove_table(struct mmu_gather *tlb, void *table);

-#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
-
-/*
- * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have 
page based
- * page directories and we can use the normal page batching to free them.
- */
-#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
-
-#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
-
  #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
  /*
   * This allows an architecture that does not use the linux page-tables for

> 
> Thanks,
> Qi
> 
>>
>> - Kevin


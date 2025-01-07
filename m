Return-Path: <linux-arch+bounces-9619-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ED5A03F2F
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 13:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B470C3A5E66
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 12:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CEC1EE014;
	Tue,  7 Jan 2025 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H+ZukA1D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4A1E1C02
	for <linux-arch@vger.kernel.org>; Tue,  7 Jan 2025 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253093; cv=none; b=SsetbYaHnLFh8tCoatEaT5MwHEWI2RlkvmdzR1807WXpQXL7rE22sCndgR1zKmFN4fuZvElJW6oG4M9QIB+qN3Zu7PEDUxIDnbq6OZrtsRzBNvzCAYTyBzh2lhxb0dS8mUKbVkV9Xa/79nBMmcbdz16llgJiRdrYSSItNQlP/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253093; c=relaxed/simple;
	bh=34vcDRGNbJs9/rF9Nwk+RqGOpzLc/F/ty++YlbWokmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WV5krzNbLdMg/RlyGVBfDXwqosU5UK1zzpoiZsEloMI8eEjkXxMCZjDAsg9Do5mPcZFMCjNeZYmFYhuUhkeownT7931vG2qcS5iMjXhcG7xBLH8w5hD51C9uLKk+abS2MWcxoqQSjg2xjnXl/NSLhIx/hUqIHYLYh58i/7VUqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H+ZukA1D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215770613dbso167964075ad.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Jan 2025 04:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736253088; x=1736857888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2Sg0kNPwV4gGCFeUvrc0oDDUwUGkE4XjlNGrPro8W4=;
        b=H+ZukA1DPmA9BWgrtPtywilc7xRhQwNnPHZK6aOmh6ZlL0rg5elfG/fnhlEWHcNFio
         UYwLeZbbd0VGC2TxixJDtQFUs5PXmhbplyeTuzWf3Mwfw5X77Pxtit4sK88rQXIDr2XQ
         RDcU7xEiISQvf/wv+DvK0MEaN29vRf/PJjkdRYpPSqXkhvFr7t5B2o+ORIiSwRCkjwq9
         xFf1gRwCwS05jUXLJ2RI2CJ4F5lFttVo7jIFev+6jLD/SjGzCvSr9Ns260jncC9/l4af
         JF1LfusYFcCrN8Og7iuqp2CYVH4NgUYHYjL1ZbQOidYWKgmN7NVqiACOgCJ9eY/t3gfR
         XKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736253088; x=1736857888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2Sg0kNPwV4gGCFeUvrc0oDDUwUGkE4XjlNGrPro8W4=;
        b=JKPk5jsOhj92kt3o6HC4tE1piiy0lJsHQJfTdBs7T7v8R3H4UbfbZMMH5NZVYoZerM
         IBPcHxOY66NGd/67EgTc3mqurXUnoUmaWfaspl1R+0NW+pvaGvllomhbEnaQUykUrC1y
         2Ju97LDm+cFQgSXiQvZ4p3ydYE2jV7mzZ0pJubpXoJtHXuKIYeNnOu248g0ojus/NkIb
         d+p8CewS8AdSeXi3vtiFxqBRUjQEffylUmt/1KeHqkuC2XgwEBL3SYfZttoKqVtWwN9L
         NSaVPlMiEaeGZ44gUvhAih7tqX/Uqia6msF3SQMCFLp9D2N7PYXcGLhoxsONVTs2ewP5
         uC/w==
X-Forwarded-Encrypted: i=1; AJvYcCUOqEeOUQagy9n6iVa6VUIlkKVDaw7ZrOSisVnhnWy/lyYG5iENyE65geaOTzxcloiln08pwJZZKM42@vger.kernel.org
X-Gm-Message-State: AOJu0YwVi9g0hcP7F8Db2l4DKW9lEY4m0PVI6akesDpf2Nv+8m7y3IsI
	84heaJRD5hxqHtOxbsbBvha+0EWuE2C5kZ7c2rs6z8jmc6WZjVSssl1RmKyF+BI=
X-Gm-Gg: ASbGnctdVy8T72PHTcu3PuO/P2e1+ppshcsBVV6x0BaUML9Qn6tapetdC0SFFReQ1K0
	LWDZFiKrETike0Il9qPCKa5yCasohRFhYLaQlkAPnJVCKmMdPElziUqeADcq67pa1A/5rOB21vb
	LKt6Y+EySxQJzJ+n6mSvCXzbpqZCEP7MxMTfOhq7+G93jnCuxiuByVTEGir1F/e8w8+CFaABsc0
	U7YvtB/7Iati02GPVJLngMzoYCmRSiVL+Wzy9STqMz1rSAbIBDpCt1NIFIE1kR36QPLMEZvpRQz
	vNnw
X-Google-Smtp-Source: AGHT+IHdrC/g0o4yqle0rmLjmhkyYNUhmDJ4pfXjCTmOvwgBk4798gzhlJqtML37UPom2J/Tnd9DQg==
X-Received: by 2002:a17:902:ce81:b0:216:282d:c692 with SMTP id d9443c01a7336-219e6ec1499mr788151455ad.34.1736253087824;
        Tue, 07 Jan 2025 04:31:27 -0800 (PST)
Received: from [10.4.33.153] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca006fasm309326755ad.227.2025.01.07.04.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:31:27 -0800 (PST)
Message-ID: <fca0d7de-b563-4d11-9ed8-c6b8290c4cf9@bytedance.com>
Date: Tue, 7 Jan 2025 20:31:10 +0800
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
To: Kevin Brodsky <kevin.brodsky@arm.com>
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
 <4a0b5edb-6fc7-4df4-93d9-ca834e6a760b@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <4a0b5edb-6fc7-4df4-93d9-ca834e6a760b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/1/7 19:58, Kevin Brodsky wrote:
> On 07/01/2025 11:51, Qi Zheng wrote:
>> [...]
>>
>> Author: Qi Zheng <zhengqi.arch@bytedance.com>
>> Date:   Fri Dec 13 17:13:48 2024 +0800
>>
>>      mm: pgtable: completely move pagetable_dtor() to generic
>> tlb_remove_table()
>>
>>      For the generic tlb_remove_table(), it is implemented in the
>> following two
>>      forms:
>>
>>      1) CONFIG_MMU_GATHER_TABLE_FREE is enabled
>>
>>      tlb_remove_table
>>      --> generic __tlb_remove_table()
>>
>>      2) CONFIG_MMU_GATHER_TABLE_FREE is disabled
>>
>>      tlb_remove_table
>>      --> tlb_remove_page
>>
>>      For case 1), the pagetable_dtor() has already been moved to generic
>>      __tlb_remove_table().
>>
>>      For case 2), now only arm will call
>> tlb_remove_table()/tlb_remove_ptdesc()
>>      when CONFIG_MMU_GATHER_TABLE_FREE is disabled. Let's move
>> pagetable_dtor()
>>      completely to generic tlb_remove_table(), so that the
>> architectures can
>>      follow more easily.
>>
>>      Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

I missed your Suggested-by, will add it in v5.

>>
>> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
>> index b8eebdb598631..ea4fbe7b17f6f 100644
>> --- a/arch/arm/include/asm/tlb.h
>> +++ b/arch/arm/include/asm/tlb.h
>> @@ -34,10 +34,6 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t
>> pte, unsigned long addr)
>>   {
>>          struct ptdesc *ptdesc = page_ptdesc(pte);
>>
>> -#ifndef CONFIG_MMU_GATHER_TABLE_FREE
>> -       pagetable_dtor(ptdesc);
>> -#endif
> 
> I guess this hunk will disappear since this call isn't present to start
> with.

Yes, I plan to add this in the patch #8, and remove it in this patch.

> 
>> -
>>   #ifndef CONFIG_ARM_LPAE
>>          /*
>>           * With the classic ARM MMU, a pte page has two corresponding pmd
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index 69de47c7ef3c5..53ae7748f555b 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -220,14 +220,20 @@ static inline void __tlb_remove_table(void *table)
>>
>>   extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>>
>> -#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
>> +#else /* !CONFIG_MMU_GATHER_TABLE_FREE */
> 
> Good catch!
> 
>>
>> +static inline void tlb_remove_page(struct mmu_gather *tlb, struct
>> page *page);
> 
> Nit: might be better to move the declaration up, e.g. above #ifdef
> CONFIG_MMU_GATHER_TABLE_FREE.

Now only the tlb_remove_table() below calls it, maybe it's better to
keep the impact to minimum?

> 
>>   /*
>>    * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have
>> page based
>>    * page directories and we can use the normal page batching to free
>> them.
>>    */
>> -#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
>> +static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
>> +{
>> +       struct page *page = (struct page *)table;
>>
>> +       pagetable_dtor(page_ptdesc(page));
>> +       tlb_remove_page(tlb, page);
>> +}
>>   #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
>>
>>   #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
> 
> Looks good to me otherwise.

I will add your Reviewed-by to all patches (except yours) in v5, can
I also add it to this new added patch? (if we agree with the discussion
above) ;)

Thanks!

> 
> - Kevin


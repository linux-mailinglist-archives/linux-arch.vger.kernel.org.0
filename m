Return-Path: <linux-arch+bounces-9620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950A6A03F43
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 13:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E383163042
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 12:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74AD4C9D;
	Tue,  7 Jan 2025 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XndSTJj6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB021C695
	for <linux-arch@vger.kernel.org>; Tue,  7 Jan 2025 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253284; cv=none; b=JmPYt/viuGtv1Lh1FP8Sbr6IDK11vq70fvnHHI6k5o6e7NEEbOzWBUaTsk0yiSHSzH0qVAp1GgzxWcxDhW7iLDwuXDwRhtqs/b7b6OER8cRIe3wH/Kia/ap4ZJbCPFYyuMSeP1J/eGv8e3GrAfyLhJ6kI437CZdwrHP2leq7l1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253284; c=relaxed/simple;
	bh=L5KICzKmsigasu6zMZMdF6uhXD7qpbyhNomRWavNigA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMft5rBJJSJESDj8UlahKrfsbhxKS6F5IzxHUNc5FEXo4kKtXGoLu2u3r55EDHB3nHZeqkMURT+IMcTxFOCYyrCSgOTXGUDw1HRBivMwrZTyIsVKhaFMweiGYLvzba+0kdi+aX4sNFzOBnMP8cBvY8boJ2U1fteZszImimjSmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XndSTJj6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2164b1f05caso220663625ad.3
        for <linux-arch@vger.kernel.org>; Tue, 07 Jan 2025 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736253281; x=1736858081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBNgt4Pp+5r8EWFOkpTfSkW0RGZvpIi++k6cMXShG00=;
        b=XndSTJj6T19P4ePWBnTSHiIk3XFiWJiB2mHNvZN9zTY9kwuvEVf/qjjaNUsobv+HqA
         KFtpU7kFUUH8jxfSoK0H52F49pSpmFllptS9KX+jRe7M9Fo6QdpRk8v6Io96TtBW67k1
         qmtAiV0qYwnRXBi5BCdw0iYJ3W/Al3dMBLo9Cms4qbQdnDIDwM3ackmSEb11/fqtxQHw
         BIS0I30u9LetARsEtYVAA8oovPUfic4rHV3Fe/nYg1Jo6uKQZfxQuG1/CB6feQk133YL
         cWA0TS+emAijd1njTDlHYPWKn97dEy4AmmYaSkQfUiY6ZKxBomo72Zhnodn2wQz0AHVL
         UYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736253281; x=1736858081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBNgt4Pp+5r8EWFOkpTfSkW0RGZvpIi++k6cMXShG00=;
        b=iQTbf55x+81hoTXBk22JJZjyn0lasoleTGM4E6tWXYqOp6+0yXDt4U7rTVLgWaV//i
         WrXWHAg0dfIGaNAGnvvPmrcUVDEYReKfRKx+8/b8MY/YzH6U2WoCvKTFmikibXSJ/LJx
         Jg7p3OUNTiSgOWoEGgD0wXBUiTLJyK5rVx3znCHJXslJjnia+PUAhNrfWQaXYwHj9Aoh
         0v9YSQ4eYNlDkjKGNhyEbV9fPsnh10h51/u7GOtb4PBXmHtanVvga6mFP63wM2aAzadF
         YTkwrjKmISIN9t7T+8lofHmsFPhlI0CXJ3NQYwWWufYy0/8Axp0HYmjqTkCWL/gl4l6b
         IjYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYw6picFJkPy3nG5gBxmgeef4qbIt/8pfK9I5n3wW8hWIPAwvCUYpyr+o7b/DTwZy5qc/+1S9UCAJC@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYMzB06wR0aGTcCvK7oFHucD2nWBSa3BMjrjT01Kx3Os+OIPG
	mSwOUGzdOun8osPNIyFIRkpYiJXHxFJG+Ja3UNI6lo8uePF1KDa010GoTGN9OOo=
X-Gm-Gg: ASbGncsakGIM85iTxdo6dpaJlQrK8B3gW2TSP4Kj0F3/nZD/bc0+8OzykdW0GcNxkMF
	SUCkKDfZtfdAUxrg9cqVVzJRDtf7Lk3ArLQX7F6g3U0+g5s5emDOVt4A/exzAXZF5jZ8vVuAaxB
	NuQ30iTMk31mg8zgsNLsv+KaRnMeVDoqWacxxXAExHc7iofAbXXXAnSV55sU6QZypKKh75cT7EQ
	iNN/s5AL4ZF7hdwc1xreqQMKWploikaPZ7ueypYpwl4XwOu6bEDcsTOm4hHeB1Z1YvnsyUH34jA
	pXOQ
X-Google-Smtp-Source: AGHT+IE3yUUkb0m+aLP2spLDFrGsHc6y1BQTdsXYC7/WM0wTJqWEm80meD2oBwGaRCvgAk0D5TXwug==
X-Received: by 2002:a17:902:e746:b0:215:8847:435c with SMTP id d9443c01a7336-219e6e8c595mr965146185ad.12.1736253280842;
        Tue, 07 Jan 2025 04:34:40 -0800 (PST)
Received: from [10.4.33.153] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962cddsm311379695ad.48.2025.01.07.04.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:34:40 -0800 (PST)
Message-ID: <9040b9ee-88c9-4347-b8b6-5894b45e62b8@bytedance.com>
Date: Tue, 7 Jan 2025 20:34:22 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] mm: pgtable: introduce generic
 __tlb_remove_table()
Content-Language: en-US
To: Andreas Larsson <andreas@gaisler.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
 palmer@dabbelt.com, tglx@linutronix.de, david@redhat.com, jannh@google.com,
 hughd@google.com, yuzhao@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <f7febc7719fd84673a8eae8af71b7b4278d3e110.1735549103.git.zhengqi.arch@bytedance.com>
 <6e1aa2aa-a70d-4292-9c5e-21c8fea386f5@gaisler.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <6e1aa2aa-a70d-4292-9c5e-21c8fea386f5@gaisler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/7 20:32, Andreas Larsson wrote:
> On 2024-12-30 10:07, Qi Zheng wrote:
>> diff --git a/arch/sparc/include/asm/tlb_32.h b/arch/sparc/include/asm/tlb_32.h
>> index 5cd28a8793e39..910254867dfbd 100644
>> --- a/arch/sparc/include/asm/tlb_32.h
>> +++ b/arch/sparc/include/asm/tlb_32.h
>> @@ -2,6 +2,7 @@
>>   #ifndef _SPARC_TLB_H
>>   #define _SPARC_TLB_H
>>   
>> +#define __HAVE_ARCH_TLB_REMOVE_TABLE
> 
> sparc32 does not select MMU_GATHER_TABLE_FREE, and therefore does not
> have (nor need) __tlb_remove_table, so this define should not be added.

Got it. Will remove it in v5.

> 
> 
>>   #include <asm-generic/tlb.h>
>>   
>>   #endif /* _SPARC_TLB_H */
>> diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
>> index 3037187482db7..1a6e694418e39 100644
>> --- a/arch/sparc/include/asm/tlb_64.h
>> +++ b/arch/sparc/include/asm/tlb_64.h
>> @@ -33,6 +33,7 @@ void flush_tlb_pending(void);
>>   #define tlb_needs_table_invalidate()	(false)
>>   #endif
>>   
>> +#define __HAVE_ARCH_TLB_REMOVE_TABLE
>>   #include <asm-generic/tlb.h>
>>   
>>   #endif /* _SPARC64_TLB_H */
> LGTM.
> 
> 
> With the removal of the define for sparc32 in v5:
> 
> Acked-by: Andreas Larsson <andreas@gaisler.com> # sparc

Thanks!

> 
> Thanks,
> Andreas
> 


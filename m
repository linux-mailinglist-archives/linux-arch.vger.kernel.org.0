Return-Path: <linux-arch+bounces-9451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBF9F9411
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 15:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5397A1ECB
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9679A2163B1;
	Fri, 20 Dec 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iOEw1diV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB721C5488
	for <linux-arch@vger.kernel.org>; Fri, 20 Dec 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704196; cv=none; b=PHE2S7esPh8EMVr9jj0IZLDbaHkCkStBNDD/sDjlZja0r6aNsK9kbL5wUHTlQ+RsEFqIN6Bu8LIbKqayjWcR0GcBv7iJ6X+KWxd1DWmFSMomqHFRWqqLLYkIz+dGj5hatuIYZ/gbRuzQaI0JuDO809nz1OM8i8Anf9gds5c9GNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704196; c=relaxed/simple;
	bh=s7rqpd1mjl40lUv0Se4TtYGvbPHUeMLFx/l0Mmxbw0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1vmnw/0mtFzEen4re5gVvaH940Ufg33iwJnPx9Wmj9QnA3B5JYlKTmq2sSz5f/gVK8+RB1vSYbKJ11GNoefZiUAjbRkYoA3DbqgvSiHwhn3EiTLkQA0KjhdGdbzxBMUZPRmwjBt9t/I5jkdVuiEYPXpwl0GXzYhlj7GpIyMhJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iOEw1diV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21628b3fe7dso17296275ad.3
        for <linux-arch@vger.kernel.org>; Fri, 20 Dec 2024 06:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734704194; x=1735308994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7iBLKI/TaFFZvOKdERySTto1DEdoOqdcbn/lUOJJc0=;
        b=iOEw1diVGNDvJCSZDLo6D3/pO5fI+lQI0kI6qgCPa1InTToTAKBddg33i8O22vf00i
         P1R6x5OMOon4qFlG9iJkRyUYigqHrnBDqXgpNlap8Zr5ADiN8151wGPA9fMpk1z/ZSCp
         qeuWKR/c7vMGL4ooMPmULX3BQDAa/59bDvYriM3/1B8ojXyd5LwPwoQG1DBIRXkYG4EW
         M18OaSfoVs1AFk2sCmRicxyA0buOSA96wM6J21TrujiLiTJDrQnvMX8VHVKGHxKnCC9z
         Mmz01Q4gCgueCohG66pUJU8hALHgMS1PcgdZmMk7g+5tF1oydAeZRGZaCS+5nyyapOti
         qXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704194; x=1735308994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7iBLKI/TaFFZvOKdERySTto1DEdoOqdcbn/lUOJJc0=;
        b=TGgG8RSXsHn3IYpm3txpglUULdXjhEjsA/djUrqv3KQ1qZu4UGGNN0eTNO0nlRosjp
         z85sQMmkh5S6wpppTfB+jhejZNGKR4gP/N9xt74eIkZFrhqggL0WDueDY1OrR5wmdZJ2
         ha85n2LKpqpy+K+Q99/DrRcTXprOE/hp5Fx+GaZwrbGzHqUVKbTLIyJupAO/d+ugSY1l
         vuX6uObRaa4Ih5pljBqPgft5qr9/EcoMpO2ZjV4JA0k5XwOOX3PnuVQFlI7TomZmdr7+
         OsdRx6TrcZuXzsXEoVVMnHQE7IPFPCOw4zvIaCEYy78RrAlX5sjOurlHSNY6SZ50rJFH
         GLhg==
X-Forwarded-Encrypted: i=1; AJvYcCXzN0yN00rLRkQPTn1YKiBz0+oMk+bsTdtK8ZgfIr7l0wnoXHi9RHhuDBc7AKxDtvqr2TpO72PlaFrc@vger.kernel.org
X-Gm-Message-State: AOJu0YyO/NKeivCXXdBnTJ5CvmbZNNSS0OdZR+ICXRcwV47RhmobJnfw
	OhKfUeRvjKYqmoRRRloYx3NQVBanDBHjcWe7IYZQgzfkyg36T/xsCRopEh+J8TE=
X-Gm-Gg: ASbGncu3t6PcGrFAp/9kU2z/bhv8Nq1M3dT/gEv3zoEDdi2LHgq8SMYpWkxSoD1CMFy
	YG26LI7BxlNGwpLrBcj/bvXaNvLe62AeZa0dFf4Rziek2Od5nXgKTjqIvARr9jLogFBwJc4ELep
	tZx2Y2LSgfePMDGSspgZOtm2rUe+xne2ISkK8waJeIUfoNQYq1w8aWrkkj3brepb5sQW5srfs4R
	s8rNr7STiUpNfI1VCfoKMcTeuKvvPiHRE/Oh/BzTr3KZg3NcINtVu0POqrnxjFMBRxWhfMsT7T6
	bL3VdUgv3lo4EFc9Q3spmMTojVlzx1WGCGjZcZU8W7Lz1bGuEbxBZNA=
X-Google-Smtp-Source: AGHT+IEEYygST4Gz03iGTM9RRiblbKn1x180pLztYOSIYhLMIpPKwcn4PYi8F34LVLcH4FrG3CDhdg==
X-Received: by 2002:a17:902:d481:b0:216:770e:f46 with SMTP id d9443c01a7336-219e6f26692mr39017935ad.54.1734704193630;
        Fri, 20 Dec 2024 06:16:33 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:3764:dc48:fb1b:dd06:cba7? ([2409:8a28:f44:3764:dc48:fb1b:dd06:cba7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc972734sm29423545ad.88.2024.12.20.06.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 06:16:33 -0800 (PST)
Message-ID: <33ce9b58-4787-49cd-a7f2-34272cb3ecf7@bytedance.com>
Date: Fri, 20 Dec 2024 22:16:22 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: Move common parts of pagetable_*_[cd]tor to
 helpers
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 loongarch@lists.linux.dev, x86@kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-2-kevin.brodsky@arm.com>
 <20241219171920.GB26279@noisy.programming.kicks-ass.net>
 <75cb4ff8-eb0c-4519-a30a-f8be717ba278@arm.com>
 <0daabd32-cba4-4345-baa8-e8c66bc899ff@bytedance.com>
 <2f65f93e-9d44-4acc-b63c-8f5a35f59699@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2f65f93e-9d44-4acc-b63c-8f5a35f59699@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/20 21:50, Kevin Brodsky wrote:
> On 20/12/2024 12:46, Qi Zheng wrote:
>> Hi Kevin,
>>
>> On 2024/12/20 18:49, Kevin Brodsky wrote:
>>> [...]
>>>
>>> Qi, shall we collaborate to make our series complementary? I believe my
>>> series covers patch 2 and 4 of your series, but it goes further by
>>> covering all levels and all architectures, and patches introducing
>>> ctor/dtor are already split as Alexander suggested on your series. So my
>>> suggestion would be:
>>>
>>> * Remove patch 1 in my series - I'd just introduce
>>> pagetable_{p4d,pgd}_[cd]tor with the same implementation as
>>> pagetable_pud_[cd]tor.
>>> * Remove patch 2 and 4 from your series and rebase it on mine.
>>
>> I quickly went through your patch series. It looks like my patch 2 and
>> your patch 6 are duplicated, so you want me to remove my patch 2.
>>
>> But I think you may not be able to simple let arm64, riscv and x86 to
>> use generic p4d_{alloc_one,free}(). Because even if
>> CONFIG_PGTABLE_LEVELS > 4, the pgtable_l5_enabled() may not be true.
>>
>> For example, in arm64:
>>
>> #if CONFIG_PGTABLE_LEVELS > 4
>>
>> static __always_inline bool pgtable_l5_enabled(void)
>> {
>>      if (!alternative_has_cap_likely(ARM64_ALWAYS_BOOT))
>>          return vabits_actual == VA_BITS;
>>      return alternative_has_cap_unlikely(ARM64_HAS_VA52);
>> }
> 
> Correct. That's why the implementation of p4d_free() I introduce in
> patch 6 checks mm_p4d_folded(), which is implemented as
> !pgtable_l5_enabled() on those architectures (see last paragraph in
> commit message). In fact it turns out Alexander suggested exactly this
> approach [2].

OK, I see.

> 
>>
>> Did I miss something?
>>
>> My patch series is not only for cleanup, but also for fixes of
>> UAF issue [1], so is it possible to rebase your patch series onto
>> mine? I can post v3 ASAP.
> 
> I see, yours should be merged first then. The issue is that yours would
> depend on some of the patches in mine, not the other way round.
> 
> My suggestion would then be for you to take patch 5, 6 and 7 from my
> series, as they match Alexander's suggestions (and patch 5 is I think a
> useful simplification), and replace patch 2 in your series with those. I
> would then rebase my series on top and adapt it accordingly. Does that
> sound reasonable?

Sounds good. But maybe just patch 5 and 6. Because I actually did
the work of your patch 7 in my patch 2 and 4.

So, is it okay to do something like the following?

1. I separate the ctor()/dtor() part from my patch 2, and then replace
    the rest with your patch 6.
2. take your patch 5 form your series

If it's ok, I will post the v3 next Monday. ;)

Thanks!

> 
> - Kevin
> 
> [2]
> https://lore.kernel.org/all/Z2RKpdv7pL34MIEt@tuxmaker.boeblingen.de.ibm.com/
> 


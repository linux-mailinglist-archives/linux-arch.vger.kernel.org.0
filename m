Return-Path: <linux-arch+bounces-13257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D25EB33B89
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 11:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A0C1B26679
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D139F29CB32;
	Mon, 25 Aug 2025 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEvthUFl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D97CA6F;
	Mon, 25 Aug 2025 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115182; cv=none; b=DrQErLdziGVgBi17gp02ylI/+3v6kCpgJszOhLbjpw2xGVYmhP6tpvjy/yLoTaBhJA6sc9hV0gm+Q0Y7gwn9qPcli4Xrd36U9+VvZFI0Fk2cNmsw7eYMHs2MUPuzOFFCUdnZSHRr4TyjPlYaUfz+GQ4xFBb+BIKHjgfT4qteDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115182; c=relaxed/simple;
	bh=H2ZktNpJ2w+x6Ps+H/dAzLcu/l8hGCEFFeruuYhpia0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gebDlynbiwF9LD5dSlSxKjcgHiqRWo/E13/Ww1EDx6jnhSUFSgaa+8AwcUfZ+/IvMSoVKZU/HG38V0QLrO1S4SOTxEGPz24Z26Fbwn7SFr9xVyOSIJrF1BMW6BKR7A4+ieDcMSGpWpIlgYF09EFc94M7cf3xagHgONcvRjLlP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEvthUFl; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3366004736aso3636841fa.1;
        Mon, 25 Aug 2025 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756115179; x=1756719979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vA6vI044zEdIbfha2CiMeRJA/WTffOEZFr4+NNjxx2k=;
        b=XEvthUFlHmMW685icm0qfOOOulst6KaV+or8KtEDwm0MdLgfrOEDeFu63pVpYcuqaF
         aOVqdVnS4ZbmlgTnq3aK1KU5JDd61wU+I7sSpcVc/PQJLz+dg2xTirk8OSOR92BNSeFZ
         OPNv8K2RXZkTRcVt9ujcBKIAlVS4rKhjBQRqReGaO3nPjQvrRWqd8gtcP/2pC7EKArgi
         zuOuBUMalvLaX1ao+20xB2GpbvksMUbg/YPRgc+QSFlcoe8FqUE1uJRrNSHDwFCWY3DN
         0scG/6v0LuImPB8XE/Du9W77SydKK2xnU33bCD9Ks+bY3J8th++/vLJuzDyaTW1hZKD4
         8Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115179; x=1756719979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vA6vI044zEdIbfha2CiMeRJA/WTffOEZFr4+NNjxx2k=;
        b=e/km1/2RAxseFp8efnxm6R2JKr9jsKS7sLho9t3DusYQtBoYfXoNhUJPHkAouoRYzJ
         o7uJT+rOSmeLQxolvDUQr+UidH4mBvnmrx3x5Y3cJlQg1/5V6G/vyWQFtpvJoTx4jX6s
         HiPPlwBsk+ZySb4xirYKesKMabWgTNRRqvZ/xxNobMR38/20ytW/3xB0BnLVcRxkW/j3
         ZSyd8o6ZxuPgvE0DtynZSDSYudPdl4aTQrCJKmKAPpvBl/yTNG0ANoVTtyT/+qcs21qP
         tZaAHl4aPR+wp5wz5EoE2JLpHUMJK3010W/re+Gu0pkTpXFff9DM77vtIG1OsBh4mFqq
         lZtw==
X-Forwarded-Encrypted: i=1; AJvYcCUm/q3pQPNJP1bysjAoTi3tC4vcWms+1GtvSvfJE9fzWprBsPXkHUv9UraLec7gu2cJbKL2DfKW@vger.kernel.org, AJvYcCVU4BdQoPzHl52u2nuekUaTEmfBrGIkugsgdIk5C23uQ8m2tNllx+6tb58TgA+dYFrQOiNNwov+8rBa@vger.kernel.org, AJvYcCWIdlAfzpnryQLXri+0/nSIh+T5iS2/yjM4Mme0BocM8LAjCxgvqafF6GKRrPIihnUSjS76+NWNJEWrx27O@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zrAtDumcDManV4tyT7HkKRTYbIoFlRkzRT4AknmYC6seoxT2
	I0+TFwAUTxo3Ee5KgQ6WtjvhW0LkLCoayB60TwpFX2RKdzJzNFCAHdyC
X-Gm-Gg: ASbGncvVuFR3Itb+NEAsyXos3KB5KMExbPu4nxGWKQHDrjxfmgxn9w2dDORISl0hqGD
	sUaf7csEeKL8y3x5JErVA8siIQZFwBfBINC7rOBXAPSW3gdVD1i9HwGA0q68fPyf9BPakXxmKhf
	HkBhep0wejE7KpW5OgiuxIM4VCPmcrevWOfK6ocraA1vuLxnah5G/4pgbgVBELzwMhfEi6i22ca
	bGbUXGPc0YtL1cnGXzJEyVlx+9l4djK2pEfSuOEty02KOzYBJIW+Vf399YWk1NeNyugX0s0/WzQ
	DO95/334kAvOCIVJeDgh37uvRTz8NQlqQlmuvOdMWr8l1BqziaUK3IV5/H1AYewDCpjXUaphdSq
	NrtzTcroPynGZ4r2EB07HgOotNbNt
X-Google-Smtp-Source: AGHT+IH1efX+K+mAJdmcOpmqJG6368qZBIn8i/p3/9xVotsBIWed+ijE4z8OQ+KPmvT3ummuxgSxVg==
X-Received: by 2002:a05:6512:2527:b0:553:ad91:d400 with SMTP id 2adb3069b0e04-55f0cce52f4mr1975986e87.6.1756115178725;
        Mon, 25 Aug 2025 02:46:18 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c12072sm1557498e87.44.2025.08.25.02.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 02:46:17 -0700 (PDT)
Message-ID: <8077d344-580b-431b-b7dc-a84dc4ba6b44@gmail.com>
Date: Mon, 25 Aug 2025 11:46:12 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix KASAN build error due to p*d_populate_kernel()
To: Dave Hansen <dave.hansen@intel.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
 aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, apopple@nvidia.com,
 ardb@kernel.org, arnd@arndb.de, bp@alien8.de, cl@gentwo.org,
 dave.hansen@linux.intel.com, david@redhat.com, dennis@kernel.org,
 dev.jain@arm.com, dvyukov@google.com, glider@google.com,
 gwan-gyeong.mun@intel.com, hpa@zyccr.com, jane.chu@oracle.com,
 jgross@suse.de, jhubbard@nvidia.com, joao.m.martins@oracle.com,
 joro@8bytes.org, kas@kernel.org, kevin.brodsky@arm.com,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, luto@kernel.org,
 maobibo@loongson.cn, mhocko@suse.com, mingo@redhat.com, osalvador@suse.de,
 peterx@redhat.com, peterz@infradead.org, rppt@kernel.org,
 ryan.roberts@arm.com, stable@vger.kernel.org, surenb@google.com,
 tglx@linutronix.de, thuth@redhat.com, tj@kernel.org, urezki@gmail.com,
 vbabka@suse.cz, vincenzo.frascino@arm.com, x86@kernel.org,
 zhengqi.arch@bytedance.com
References: <20250821093542.37844-1-harry.yoo@oracle.com>
 <20250821115731.137284-1-harry.yoo@oracle.com>
 <3976ef5d-a959-408a-b538-7feba1f0ab7a@intel.com> <aKfDrKBaMc24cNgC@hyeyoo>
 <79027c6f-f2f3-41b2-9ff3-c5576fc06c5c@intel.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <79027c6f-f2f3-41b2-9ff3-c5576fc06c5c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/25 7:08 PM, Dave Hansen wrote:
> On 8/21/25 18:11, Harry Yoo wrote:
>> On Thu, Aug 21, 2025 at 10:36:12AM -0700, Dave Hansen wrote:
>>> On 8/21/25 04:57, Harry Yoo wrote:
>>>> However, {pgd,p4d}_populate_kernel() is defined as a function regardless
>>>> of the number of page table levels, so the compiler may not optimize
>>>> them away. In this case, the following linker error occurs:
>>
>> Hi, thanks for taking a look, Dave!
>>
>> First of all, this is a fix-up patch of a mm-hotfixes patch series that
>> fixes a bug (I should have explained that in the changelog) [1].
>>
>> [1] https://lore.kernel.org/linux-mm/20250818020206.4517-1-harry.yoo@oracle.com
>>
>> I think we can continue discussing it and perhaps do that as part of
>> a follow-up series, because the current patch series need to be backported
>> to -stable and your suggestion to improve existing code doesn't require
>> -stable backports.
>>
>> Does that sound fine?
>>
>>> This part of the changelog confused me. I think it's focusing on the
>>> wrong thing.
>>>
>>> The code that's triggering this is literally:
>>>
>>>>                         pgd_populate(&init_mm, pgd,
>>>>                                         lm_alias(kasan_early_shadow_p4d));
>>>
>>> It sure _looks_ like it's unconditionally referencing the
>>> 'kasan_early_shadow_p4d' symbol. I think it's wrong to hide that with
>>> macro magic and just assume that the macros won't reference it.
>>>
>>> If a symbol isn't being defined, it shouldn't be referenced in C code.:q
>>
>> A fair point, and that's what KASAN code has been doing for years.
>>
>>> The right way to do it is to have an #ifdef in a header that avoids
>>> compiling in the reference to the symbol.
>>
>> You mean defining some wrapper functions for p*d_populate_kernel() in
>> KASAN with different implementations based on ifdeffery?
> 
> That would work.
> 
> So would something like:
> 
> #if CONFIG_PGTABLE_LEVELS >= 4
> extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
> #else
> #define kasan_early_shadow_p4d NULL
> #endif
> 

This won't work. It will fix the linker error, but will introduce runtime bug instead:

lm_alias(kasan_early_shadow_p4d) -> __va(__phys_addr_symbol(NULL))

On arm64:

phys_addr_t __phys_addr_symbol(unsigned long x)
	VIRTUAL_BUG_ON(x < (unsigned long) KERNEL_START ||
		       x > (unsigned long) KERNEL_END);

And NULL is < KERNEL_START.

Since __phys_addr_symbol() isn't pure or const,  compiler has no right to eliminate such
call even though the return value is unused.



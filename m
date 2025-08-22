Return-Path: <linux-arch+bounces-13253-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14472B3202A
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 18:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6275F5861B0
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538292882CE;
	Fri, 22 Aug 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiVc7+0f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEC25DAE7;
	Fri, 22 Aug 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878568; cv=none; b=UzeoCxxQ8mH02pJNtxu2MnBmXyFlmJdrjJnxlMtCWpxho+0uT1ewfzyh8ZzfFhxnY9othJAqEudGO0hMsQ43QSfS6/Q1GIIKNEwdogI9CRW769nrDCj3E/rZ+WJm1iPNvrhyus1OGkMIWtootRhKTjKpnYW2RGQq+NmP74T39pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878568; c=relaxed/simple;
	bh=ix73bSoNn7yvd8cn3z1HdCW0ZY0XpvKwTxIznMfcvLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJrti5uf8JelK2OgLeM7OMF/jk9gTWYohQxnjFs7ihVvQmKiIKPWZxRZjxx8szw4bKekCxaUgs4htSLp4J1asIl2VKwf6ABgrb7R/Grx7k3/H2XSZE3P9sp7CjHA0KQoYIKd8tV/nXoeBxaIx1m2vUqJWRlWYqct41+TDVvjR3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiVc7+0f; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f34d792c4so61285e87.3;
        Fri, 22 Aug 2025 09:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755878564; x=1756483364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x+hhnaziEbvfcvK+nslqj/VWqrGu2JLJjIG2S0rWuqQ=;
        b=PiVc7+0fLRSGjiYBuSZPamCvyujMhSPcA3xBJSg0+VqfnvmRFaQeb2nFfy5szPCikd
         A8zQtQbQSALxFfxbIn6GSntw9RdTHdTFgQ/6FxyECO70Kg8xk0ijNZitRxLzclNa9PcO
         AbvMURGyyggjMAxv6zg+C9Pi33LJCZimYuEokyPorYycA0YRbU9BjIH8v9RGac9dGQQ3
         vpjJIF9yeRSV9V9adZTdfDhJ1RpxQ2pNewkmRQPQXqBv+FqzRG/VHrnCyk9bqMU3el3h
         loIkqhqcJ8aTNdHseVhvt1SuRaYEX1Xgypqw3QxA3zsZtfjNrT5HAiW7s9ukY/mKGVyo
         LtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878564; x=1756483364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+hhnaziEbvfcvK+nslqj/VWqrGu2JLJjIG2S0rWuqQ=;
        b=uft/VNRTcpeM7y2H8BY9VEFrXS/bEVHAYTk/5d6g/NxIGrbbLL6l1Zf5zu607aR75h
         65M52ytOAaVv5MYdbFMteeHOsN4pU+2hJE7U+eWOKgzjrIWcxxnkC5kTIpcMnkpRdXvW
         I1ICHIqALh0Qwau3n6Mts9Lj26rfXk1QJjsx4+Cu+TcdvVPwTXgmK+ooMlGZDIPsErre
         sDyLauE83oDnluYT+GjKkzAu4uXq30qRVED0TGM7jvQbgZ5JBN5bRlQt38bMEjhoLW2O
         wOLBVwqqLftCQFtCNUiDf+yg4cfNGy8iTCqpyqBwYdLw1DC8b+J1Kq62ZWQEMe9jkW1d
         hdpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8hdu3g+Lqdij5Tv3f6W2GB0ZpO6SYJQ+hGnCPviK+ndi7huCb20JwLvfZDxOwcmjP9W9Bkw95@vger.kernel.org, AJvYcCUfvRPhuhp5YnZAn0RiEE8JbM8ADIC+4ARTyPb/k9wjAuVhfkvGI5Qk940dHNF3HVL8xj/v9rQI9U1Q@vger.kernel.org, AJvYcCXENbh3fki6I4awF52RGQ0tdKEBz1uuxntXH9Cpv6GCYq85zojC1lBa8kKSli7UQm3xNKT5s4/SvUFdNpXx@vger.kernel.org
X-Gm-Message-State: AOJu0YztootUYyk+HosBxCET9hipQw+f0SX7rwbnY7zY0p4KI/VRcasm
	whIWK6RqPkvuXxFqfM/orOxC/uSnU5kcRYmboLtfQ8NN9uEy7a5NdnHr
X-Gm-Gg: ASbGnctthQbVDB6C+9x0EQ/dqkdocBvN6e4GS1TpTzHy+iqEZw1Y0dfn6GEtdb7eJET
	NDfGLCJlRI9ZchpEXCBDQQYYiSeNJFPTzurwzdTcNbYRxCASfVA+m76D7vYmBRLwRnnYATRqNsL
	2sE6fk/f2vjJoQjNDvhKSXeRNnLq+BNkOfG3hwoAcjRKRvcnVU5+j0nehLS/DtHNXtdk8XFj+lv
	i2DqPelXOPOQsSMxjjn6ULwAMqSFIyMiV9OBBH3CvPoqfTGTpH+UlI5fd1jp0Yx4H1VqpcgAwjb
	qaLgStXzDnrNPvE1gkOJQbVwEeHagpAMSGiPoVMpKLE3LbGf/eErEjXwwb15PDCeRKkRIaeiHIs
	dOTct71w9IDxNsi10o6b9xM0DJgH7
X-Google-Smtp-Source: AGHT+IGQszajDGNQAKf7QN48qEfm9n4yUiAaOTXLuqd4oLvJ2QirlJ8t5DPSvNvccFn1KcRv53kJsg==
X-Received: by 2002:a05:6512:220f:b0:55b:2242:a9d8 with SMTP id 2adb3069b0e04-55f0d36fademr679617e87.7.1755878564032;
        Fri, 22 Aug 2025 09:02:44 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c02c89sm37612e87.34.2025.08.22.09.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 09:02:43 -0700 (PDT)
Message-ID: <2fb52098-3952-48f1-b6c3-bbc95ce00d8d@gmail.com>
Date: Fri, 22 Aug 2025 18:02:40 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fix KASAN build error due to p*d_populate_kernel()
To: Harry Yoo <harry.yoo@oracle.com>, Dave Hansen <dave.hansen@intel.com>
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
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <aKfDrKBaMc24cNgC@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/22/25 3:11 AM, Harry Yoo wrote:
> On Thu, Aug 21, 2025 at 10:36:12AM -0700, Dave Hansen wrote:
>> On 8/21/25 04:57, Harry Yoo wrote:
>>> However, {pgd,p4d}_populate_kernel() is defined as a function regardless
>>> of the number of page table levels, so the compiler may not optimize
>>> them away. In this case, the following linker error occurs:
> 
> Hi, thanks for taking a look, Dave!
> 
> First of all, this is a fix-up patch of a mm-hotfixes patch series that
> fixes a bug (I should have explained that in the changelog) [1].
> 
> [1] https://lore.kernel.org/linux-mm/20250818020206.4517-1-harry.yoo@oracle.com
> 
> I think we can continue discussing it and perhaps do that as part of
> a follow-up series, because the current patch series need to be backported
> to -stable and your suggestion to improve existing code doesn't require
> -stable backports.
> 
> Does that sound fine?
> 
>> This part of the changelog confused me. I think it's focusing on the
>> wrong thing.
>>
>> The code that's triggering this is literally:
>>
>>>                         pgd_populate(&init_mm, pgd,
>>>                                         lm_alias(kasan_early_shadow_p4d));
>>
>> It sure _looks_ like it's unconditionally referencing the
>> 'kasan_early_shadow_p4d' symbol. I think it's wrong to hide that with
>> macro magic and just assume that the macros won't reference it.
>>
>> If a symbol isn't being defined, it shouldn't be referenced in C code.:q


That's not exactly the case for the kernel. It historically relied on being
compiled with optimization and compiler being able to eliminate unused references.
AFAIR BUILD_BUG_ON() works like that, there are also plenty of code like

if  (IS_ENABLED(CONFIG_SOMETHING))
	ptr = &something;
else
	ptr = &something_else; 

e.g. irq_remaping_prepare();


> 
> A fair point, and that's what KASAN code has been doing for years.
> 
>> The right way to do it is to have an #ifdef in a header that avoids
>> compiling in the reference to the symbol.
> 
> You mean defining some wrapper functions for p*d_populate_kernel() in
> KASAN with different implementations based on ifdeffery?
> 
> Just to clarify, what should be the exact ifdeffery to cover these cases?
> #if CONFIG_PGTABLE_LEVELS == 4 and 5, or
> #ifdef __PAGETABLE_P4D_FOLDED and __PAGETABLE_PUD_FOLDED ?
> 

I think ifdef should be the same as for symbol, so '#if CONFIG_PGTABLE_LEVELS > 4'
for *_p4d and '#if CONFIG_PGTABLE_LEVELS > 3' for *_pud


> I have no strong opinion on this, let's hear what KASAN folks think.
> 

So, I think we have following options:

1. Macros as you did.
2. Hide references in function under  '#if CONFIG_PGTABLE_LEVELS > x', like Dave suggested.
3. It should be enough to just add if in code like
            if (CONFIG_PGTABLE_LEVELS > 4)
		pgd_populate_kernel(addr, pgd,
                                          lm_alias(kasan_early_shadow_p4d));
Compiler should be able to optimize it away.

4. I guess that the link error is due to enabled CONFIG_DEBUG_VIRTUAL=y
lm_alias() ends up with __phys_addr_symbol() function call which compiler can't optimize away.
Technically we can declare __phys_addr_symbol() with __attribute__((pure)), so compiler will
be able to optimize away this call, because the result should be unused.
But I'm not sure we really want that, because it's debug function and even if the result is unused
we might want to still have a check if symbol address is correct.


I would probably prefer 3rd option, but I don't really have very strong opinion, so either way is fine.



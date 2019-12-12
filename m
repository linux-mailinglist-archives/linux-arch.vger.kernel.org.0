Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047AB11C967
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 10:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfLLJit (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 04:38:49 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:22030 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfLLJit (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 04:38:49 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47YTJQ19QQz9tx9d;
        Thu, 12 Dec 2019 10:38:46 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=ud0LAurH; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PtgGjD3L2HhS; Thu, 12 Dec 2019 10:38:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47YTJQ04Spz9tx9b;
        Thu, 12 Dec 2019 10:38:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576143526; bh=PmEFgaQ7Eo9rbAL5MPouRGU/8Glf/6NoE8/kyEXX9XI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=ud0LAurHVCHTtzHonbn8ggiFwj8yqRLCq120So6BnJYTKnINs+gq8gijKGFlcEk8d
         +TgnRymV/wNbxtAsJKay2iOmRUp+H61LLodMFeYPw1Athio8oP8JCZjOortSPz5NQK
         1pwHjkeNU9ObsJxl02zEkD5UarY4Tr0gAvrMwPFM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E80E8B85B;
        Thu, 12 Dec 2019 10:38:47 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kkSWjlcM3lXj; Thu, 12 Dec 2019 10:38:47 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 350948B776;
        Thu, 12 Dec 2019 10:38:46 +0100 (CET)
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
To:     Balbir Singh <bsingharora@gmail.com>,
        Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-5-dja@axtens.net>
 <71751e27-e9c5-f685-7a13-ca2e007214bc@gmail.com>
 <875zincu8a.fsf@dja-thinkpad.axtens.net>
 <2e0f21e6-7552-815b-1bf3-b54b0fc5caa9@gmail.com>
 <87wob3aqis.fsf@dja-thinkpad.axtens.net>
 <1bffad2d-db13-9808-afc9-5594f02dcf01@gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <2f017b74-b6f4-5723-591a-fe7525b85419@c-s.fr>
Date:   Thu, 12 Dec 2019 10:38:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1bffad2d-db13-9808-afc9-5594f02dcf01@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 12/12/2019 à 08:42, Balbir Singh a écrit :
> 
> 
> On 12/12/19 1:24 am, Daniel Axtens wrote:
>> Hi Balbir,
>>
>>>>>> +Discontiguous memory can occur when you have a machine with memory spread
>>>>>> +across multiple nodes. For example, on a Talos II with 64GB of RAM:
>>>>>> +
>>>>>> + - 32GB runs from 0x0 to 0x0000_0008_0000_0000,
>>>>>> + - then there's a gap,
>>>>>> + - then the final 32GB runs from 0x0000_2000_0000_0000 to 0x0000_2008_0000_0000
>>>>>> +
>>>>>> +This can create _significant_ issues:
>>>>>> +
>>>>>> + - If we try to treat the machine as having 64GB of _contiguous_ RAM, we would
>>>>>> +   assume that ran from 0x0 to 0x0000_0010_0000_0000. We'd then reserve the
>>>>>> +   last 1/8th - 0x0000_000e_0000_0000 to 0x0000_0010_0000_0000 as the shadow
>>>>>> +   region. But when we try to access any of that, we'll try to access pages
>>>>>> +   that are not physically present.
>>>>>> +
>>>>>
>>>>> If we reserved memory for KASAN from each node (discontig region), we might survive
>>>>> this no? May be we need NUMA aware KASAN? That might be a generic change, just thinking
>>>>> out loud.
>>>>
>>>> The challenge is that - AIUI - in inline instrumentation, the compiler
>>>> doesn't generate calls to things like __asan_loadN and
>>>> __asan_storeN. Instead it uses -fasan-shadow-offset to compute the
>>>> checks, and only calls the __asan_report* family of functions if it
>>>> detects an issue. This also matches what I can observe with objdump
>>>> across outline and inline instrumentation settings.
>>>>
>>>> This means that for this sort of thing to work we would need to either
>>>> drop back to out-of-line calls, or teach the compiler how to use a
>>>> nonlinear, NUMA aware mem-to-shadow mapping.
>>>
>>> Yes, out of line is expensive, but seems to work well for all use cases.
>>
>> I'm not sure this is true. Looking at scripts/Makefile.kasan, allocas,
>> stacks and globals will only be instrumented if you can provide
>> KASAN_SHADOW_OFFSET. In the case you're proposing, we can't provide a
>> static offset. I _think_ this is a compiler limitation, where some of
>> those instrumentations only work/make sense with a static offset, but
>> perhaps that's not right? Dmitry and Andrey, can you shed some light on
>> this?
>>
> 
>  From what I can read, everything should still be supported, the info page
> for gcc states that globals, stack asan should be enabled by default.
> allocas may have limited meaning if stack-protector is turned on (no?)

Where do you read that ?

As far as I can see, there is not much details about 
-fsanitize=kernel-address and -fasan-shadow-offset=number in GCC doc 
(https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html)

[...]


>>
> 
> I think I got CONFIG_PHYS_MEM_SIZE_FOR_KASN wrong, honestly I don't get why
> we need this size? The size is in MB and the default is 0.
> 
> Why does the powerpc port of KASAN need the SIZE to be explicitly specified?
> 

AFAICS, it is explained in details in Daniel's commit log. That's 
because on book3s64, KVM requires KASAN to also work when MMU is off.

The 0 default is for when CONFIG_KASAN is not selected, in order to 
avoid a forest of #ifdefs in the code.

Christophe

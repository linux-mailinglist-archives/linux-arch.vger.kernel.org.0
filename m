Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C64B111C69A
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 08:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfLLHmz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 02:42:55 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38868 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbfLLHmz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 02:42:55 -0500
Received: by mail-lf1-f66.google.com with SMTP id r14so915323lfm.5;
        Wed, 11 Dec 2019 23:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PkUsNGoqFdl5gXqJP6bnP2J6yrhC8TrnSK9hjm92v8k=;
        b=NMCNzYEm9Gfegz6VLnF8XP0V5Hn0WezwnX7U9NkH5MQWw+pZmvdE45rMspF3sLqxbF
         ZZnNXwqhT2Q5GUIlC1rnmGWdvyOao7Mv2wdJk0VOhiLJ/8ruwz7CzgzsU9HcBqUHN8xb
         OlyZ2qODoD9obyPBZzL0HLC0LDMy+X8yU/eWI5IZxzHqW/dN5qNLoU6c8k6x83yi0cTH
         yY3XvA65/q1EilVfL5O1Awlr4X/HW8bO8iCGiDKbMOtMsyKX1Owmv2jHdInhOqTPfUY4
         DTV3Brysx5psuGFJ/sIoP9BO6zN1aE1N5mB96sZ/Z4CD9q24KbeourzxSb0xwN0ZLlvx
         75SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PkUsNGoqFdl5gXqJP6bnP2J6yrhC8TrnSK9hjm92v8k=;
        b=mOj+WDtPPnHdPG4E8aPRBCWurxxy+xGiOAiO9pEebtVBtcIwoDJNf3IqcXg6nUoLQE
         b/S+mzM/W96hsjaVAxd6oeUrjoZCy3RSpYLEKgr4YnHAFAoRSklfj5j1f+r+pnFtFVve
         R5YIK5v68FssEl3Okd4yb1dSh/YLd1Dt/Mta5bC06F+n/PeoLdUBtjRXf4w/6N6D8toI
         SuotGfOUoFasuqJIfWAJxf+E/JKbpWFVZGNE/PgaNXqTAOX1a5dhy2BM3/l/0Xf+NcUR
         ZM0LzGnFSg5IXy5GGeQBzG8Y+xvlduSEggSrXnOJkPJCEv9Vqyd3o16mN3dQk0N/q/Cy
         WxzA==
X-Gm-Message-State: APjAAAUuVgp7qZUMqixufk9JwckNMEe1vmj35rjXwXA1ku7kLi5pOdRv
        KfIoX8EiPpIDMsb6YfIltcs=
X-Google-Smtp-Source: APXvYqw61Nc9c1M7/MZ1ZVdl9tv4GQZF2ss+5I1aVe+a5lUKM/oLVCrLyFH8YTXcNcxBfb4SaCbXuQ==
X-Received: by 2002:ac2:5975:: with SMTP id h21mr4695940lfp.165.1576136571817;
        Wed, 11 Dec 2019 23:42:51 -0800 (PST)
Received: from [192.168.68.108] (115-64-122-209.tpgi.com.au. [115.64.122.209])
        by smtp.gmail.com with ESMTPSA id v5sm2444547ljk.67.2019.12.11.23.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 23:42:51 -0800 (PST)
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-5-dja@axtens.net>
 <71751e27-e9c5-f685-7a13-ca2e007214bc@gmail.com>
 <875zincu8a.fsf@dja-thinkpad.axtens.net>
 <2e0f21e6-7552-815b-1bf3-b54b0fc5caa9@gmail.com>
 <87wob3aqis.fsf@dja-thinkpad.axtens.net>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <1bffad2d-db13-9808-afc9-5594f02dcf01@gmail.com>
Date:   Thu, 12 Dec 2019 18:42:40 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87wob3aqis.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 12/12/19 1:24 am, Daniel Axtens wrote:
> Hi Balbir,
> 
>>>>> +Discontiguous memory can occur when you have a machine with memory spread
>>>>> +across multiple nodes. For example, on a Talos II with 64GB of RAM:
>>>>> +
>>>>> + - 32GB runs from 0x0 to 0x0000_0008_0000_0000,
>>>>> + - then there's a gap,
>>>>> + - then the final 32GB runs from 0x0000_2000_0000_0000 to 0x0000_2008_0000_0000
>>>>> +
>>>>> +This can create _significant_ issues:
>>>>> +
>>>>> + - If we try to treat the machine as having 64GB of _contiguous_ RAM, we would
>>>>> +   assume that ran from 0x0 to 0x0000_0010_0000_0000. We'd then reserve the
>>>>> +   last 1/8th - 0x0000_000e_0000_0000 to 0x0000_0010_0000_0000 as the shadow
>>>>> +   region. But when we try to access any of that, we'll try to access pages
>>>>> +   that are not physically present.
>>>>> +
>>>>
>>>> If we reserved memory for KASAN from each node (discontig region), we might survive
>>>> this no? May be we need NUMA aware KASAN? That might be a generic change, just thinking
>>>> out loud.
>>>
>>> The challenge is that - AIUI - in inline instrumentation, the compiler
>>> doesn't generate calls to things like __asan_loadN and
>>> __asan_storeN. Instead it uses -fasan-shadow-offset to compute the
>>> checks, and only calls the __asan_report* family of functions if it
>>> detects an issue. This also matches what I can observe with objdump
>>> across outline and inline instrumentation settings.
>>>
>>> This means that for this sort of thing to work we would need to either
>>> drop back to out-of-line calls, or teach the compiler how to use a
>>> nonlinear, NUMA aware mem-to-shadow mapping.
>>
>> Yes, out of line is expensive, but seems to work well for all use cases.
> 
> I'm not sure this is true. Looking at scripts/Makefile.kasan, allocas,
> stacks and globals will only be instrumented if you can provide
> KASAN_SHADOW_OFFSET. In the case you're proposing, we can't provide a
> static offset. I _think_ this is a compiler limitation, where some of
> those instrumentations only work/make sense with a static offset, but
> perhaps that's not right? Dmitry and Andrey, can you shed some light on
> this?
> 

From what I can read, everything should still be supported, the info page
for gcc states that globals, stack asan should be enabled by default.
allocas may have limited meaning if stack-protector is turned on (no?)

> Also, as it currently stands, the speed difference between inline and
> outline is approximately 2x, and given that we'd like to run this
> full-time in syzkaller I think there is value in trading off speed for
> some limitations.
> 

Full speed vs actually working across different configurations?

>> BTW, the current set of patches just hang if I try to make the default
>> mode as out of line
> 
> Do you have CONFIG_RELOCATABLE?
> 
> I've tested the following process:
> 
> # 1) apply patches on a fresh linux-next
> # 2) output dir
> mkdir ../out-3s-kasan
> 
> # 3) merge in the relevant config snippets
> cat > kasan.config << EOF
> CONFIG_EXPERT=y
> CONFIG_LD_HEAD_STUB_CATCH=y
> 
> CONFIG_RELOCATABLE=y
> 
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> CONFIG_KASAN_OUTLINE=y
> 
> CONFIG_PHYS_MEM_SIZE_FOR_KASAN=2048
> EOF
> 

I think I got CONFIG_PHYS_MEM_SIZE_FOR_KASN wrong, honestly I don't get why
we need this size? The size is in MB and the default is 0. 

Why does the powerpc port of KASAN need the SIZE to be explicitly specified?

Balbir Singh.

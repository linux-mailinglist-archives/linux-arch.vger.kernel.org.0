Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC911CA08
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 10:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfLLJ5y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 04:57:54 -0500
Received: from relay.sw.ru ([185.231.240.75]:57816 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbfLLJ5y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 04:57:54 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1ifLDd-00051z-5a; Thu, 12 Dec 2019 12:57:13 +0300
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
To:     Daniel Axtens <dja@axtens.net>,
        Balbir Singh <bsingharora@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        Dmitry Vyukov <dvyukov@google.com>
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-5-dja@axtens.net>
 <71751e27-e9c5-f685-7a13-ca2e007214bc@gmail.com>
 <875zincu8a.fsf@dja-thinkpad.axtens.net>
 <2e0f21e6-7552-815b-1bf3-b54b0fc5caa9@gmail.com>
 <87wob3aqis.fsf@dja-thinkpad.axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <023d59f1-c007-e153-9893-3231a4caf7d1@virtuozzo.com>
Date:   Thu, 12 Dec 2019 12:56:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <87wob3aqis.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/11/19 5:24 PM, Daniel Axtens wrote:
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

There is no code in the kernel is poisoning/unpoisoning
redzones/variables on stack. It's because it's always done by the compiler, it inserts
some code in prologue/epilogue of every function.
So compiler needs to know the shadow offset which will be used to poison/unpoison
stack frames.

There is no such kind of limitation on globals instrumentation. The only reason globals
instrumentation depends on -fasan-shadow-offset is because there was some bug related to
globals in old gcc version which didn't support -fasan-shadow-offset.


If you want stack instrumentation with not standard mem-to-shadow mapping, the options are:
1. Patch compiler to make it possible the poisoning/unpoisonig of stack frames via function calls.
2. Use out-line instrumentation and do whatever mem-to-shadow mapping you want, but keep all kernel
stacks in some special place for which standard mem-to-shadow mapping (addr >>3 +offset)
works.


> Also, as it currently stands, the speed difference between inline and
> outline is approximately 2x, and given that we'd like to run this
> full-time in syzkaller I think there is value in trading off speed for
> some limitations.
> 

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6CD500393
	for <lists+linux-arch@lfdr.de>; Thu, 14 Apr 2022 03:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbiDNBX7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 21:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbiDNBX6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 21:23:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5427522E7;
        Wed, 13 Apr 2022 18:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=eO6g3QJQoh9UepWfm4OKwawAGep6aOU9+cq2xVm+3vg=; b=SPONtgEmQitAtBRkT6U+Opulqj
        iGTs+IXxV3jha+HGHodDBTF5C0FhWNzu1gQEUJY5+lXdzP5N1NtCLVcHoPFuKSNkNUzfrSDq7izzC
        cyzgpN7QQF3ko097QhpvB1w4/+gvllHQB5I+aE2AGsaH9CpHwBz46YNz0/LB2jEX6JUIAbGe2lfaz
        xhP6a69Hwp0cshjsIl/9+38GLlyNnpyJ7TSRZeUGN0NifBRy4sX/E9KOMX+h5s4DSTH2wEA1ebjao
        P/QRREnPL5sPzYfFIUt82ZeiapFgtj1wHTj9/Hr6wQ3MtW3L+ucURLW9v+c+jvE+qqghLr+gJQm7f
        PHmjToXg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neoAW-004qcD-1n; Thu, 14 Apr 2022 01:21:09 +0000
Message-ID: <98d190a3-b3f3-0fa5-be0f-8d602ffe7aea@infradead.org>
Date:   Wed, 13 Apr 2022 18:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RESEND 1/1] lib/Kconfig: remove DEBUG_PER_CPU_MAPS
 dependency for CPUMASK_OFFSTACK
Content-Language: en-US
To:     Libo Chen <libo.chen@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>
References: <20220412231508.32629-1-libo.chen@oracle.com>
 <20220412231508.32629-2-libo.chen@oracle.com>
 <c7d26e9d-8c70-86a6-cdab-b180a365804f@infradead.org>
 <157cb46a-d134-2e72-4a65-14e378dd2b8e@oracle.com>
 <26855467-107d-4ba1-4f32-2afd5918d5b7@infradead.org>
 <cbb6b94e-3b9d-c7b6-a10e-6203a3a8b3f3@oracle.com>
 <4c6b3445-78b2-090f-c7c9-291d49c45019@infradead.org>
 <506db9a9-47ff-658a-a821-27315949e8c3@oracle.com>
 <8eb6f58a-2621-0977-1b67-b2c58e4d5fba@infradead.org>
 <c2e6bb8b-c9d9-ad39-7a8e-3df6849b2fb2@oracle.com>
 <CAK8P3a3wgbYPY6CxbkkFkEboXYLWREaL3oUmHyet5wPYpc4Vng@mail.gmail.com>
 <ce420ed3-4a36-122f-460d-8cccd0310033@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ce420ed3-4a36-122f-460d-8cccd0310033@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 4/13/22 14:50, Libo Chen wrote:
> 
> 
> On 4/13/22 13:52, Arnd Bergmann wrote:
>> On Wed, Apr 13, 2022 at 9:28 PM Libo Chen <libo.chen@oracle.com> wrote:
>>> On 4/13/22 08:41, Randy Dunlap wrote:
>>>> On 4/12/22 23:56, Libo Chen wrote:
>>>>>> --- a/lib/Kconfig
>>>>>> +++ b/lib/Kconfig
>>>>>> @@ -511,7 +511,8 @@ config CHECK_SIGNATURE
>>>>>>         bool
>>>>>>       config CPUMASK_OFFSTACK
>>>>>> -    bool "Force CPU masks off stack" if DEBUG_PER_CPU_MAPS
>>>>>> +    bool "Force CPU masks off stack"
>>>>>> +    depends on DEBUG_PER_CPU_MAPS
>>>>> This forces every arch to enable DEBUG_PER_CPU_MAPS if they want to enable CPUMASK_OFFSTACK, it's even stronger than "if". My whole argument is CPUMASK_OFFSTACK should be enable/disabled independent of DEBUG_PER_CPU_MASK
>>>>>>         help
>>>>>>           Use dynamic allocation for cpumask_var_t, instead of putting
>>>>>>           them on the stack.  This is a bit more expensive, but avoids
>>>>>>
>>>>>>
>>>>>> As I said earlier, the "if" on the "bool" line just controls the prompt message.
>>>>>> This patch make CPUMASK_OFFSTACK require DEBUG_PER_CPU_MAPS -- which might be overkill.
>>>>>>
>>>>> Okay I understand now "if" on the "boot" is not a dependency and it only controls the prompt message, then the question is why we cannot enable CPUMASK_OFFSTACK without DEBUG_PER_CPU_MAPS if it only controls prompt message? Is it not the behavior we expect?
>>>> Yes, it is. I don't know that the problem is...
>>> Masahiro explained that CPUMASK_OFFSTACK can only be configured by
>>> options not users if DEBUG_PER_CPU_MASK is not enabled. This doesn't
>>> seem to be what we want.
>> I think the correct way to do it is to follow x86 and powerpc, and tying
>> CPUMASK_OFFSTACK to "large" values of CONFIG_NR_CPUS.

Sure. Just FTR, I was just trying to see if an arch (arm64) would build OK or not
when CPUMASK_OFFSTACK was enabled. and it does.
My patch wasn't meant to have a very long life.

>> For smaller values of NR_CPUS, the onstack masks are obviously
>> cheaper, we just need to decide what the cut-off point is.
> I agree. It appears enabling CPUMASK_OFFSTACK breaks kernel builds on some architectures such as parisc and nios2 as reported by kernel test robot. Maybe it makes sense to use DEBUG_PER_CPU_MAPS as some kind of guard on CPUMASK_OFFSTACK.
>> In x86, the onstack masks can be selected for normal SMP builds with
>> up to 512 CPUs, while CONFIG_MAXSMP=y raises the limit to 8192
>> CPUs while selecting CPUMASK_OFFSTACK.
>> PowerPC does it the other way round, selecting CPUMASK_OFFSTACK
>> implicitly whenever NR_CPUS is set to 8192 or more.
>>
>> I think we can easily do the same as powerpc on arm64. With the
> I am leaning more towards x86's way because even NR_CPUS=160 is too expensive for 4-core arm64 VMs according to apachebench. I highly doubt that there is a good cut-off point to make everybody happy (or not unhappy).
>> ApacheBench test you cite in the patch description, what is the
>> value of NR_CPUS at which you start seeing a noticeable
>> benefit for offstack masks? Can you do the same test for
>> NR_CPUS=1024 or 2048?
> As mentioned above, a good cut-off point moves depends on the actual number of CPUs. But yeah I can do the same test for 1024 or even smaller NR_CPUs values on the same 64-core arm64 VM setup.


-- 
~Randy

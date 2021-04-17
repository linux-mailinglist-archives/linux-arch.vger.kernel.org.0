Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC236316E
	for <lists+linux-arch@lfdr.de>; Sat, 17 Apr 2021 19:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbhDQR1H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Apr 2021 13:27:07 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55863 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbhDQR1H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Apr 2021 13:27:07 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.12] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 39881E0003;
        Sat, 17 Apr 2021 17:26:37 +0000 (UTC)
Subject: Re: [PATCH] riscv: Protect kernel linear mapping only if
 CONFIG_STRICT_KERNEL_RWX is set
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     anup@brainfault.org, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <mhng-9ab3280b-4523-4892-9f9a-338f55df8108@palmerdabbelt-glaptop>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <72130961-0419-9b1f-e88e-aa1e933f2942@ghiti.fr>
Date:   Sat, 17 Apr 2021 13:26:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <mhng-9ab3280b-4523-4892-9f9a-338f55df8108@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 4/16/21 à 12:33 PM, Palmer Dabbelt a écrit :
> On Fri, 16 Apr 2021 03:47:19 PDT (-0700), alex@ghiti.fr wrote:
>> Hi Anup,
>>
>> Le 4/16/21 à 6:41 AM, Anup Patel a écrit :
>>> On Thu, Apr 15, 2021 at 4:34 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>> If CONFIG_STRICT_KERNEL_RWX is not set, we cannot set different 
>>>> permissions
>>>> to the kernel data and text sections, so make sure it is defined before
>>>> trying to protect the kernel linear mapping.
>>>>
>>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>>
>>> Maybe you should add "Fixes:" tag in commit tag ?
>>
>> Yes you're right I should have done that. Maybe Palmer will squash it as
>> it just entered for-next?
> 
> Ya, I'll do it.  My testing box was just tied up last night for the rc8 
> PR, so I threw this on for-next to get the buildbots to take a look. 
> It's a bit too late to take something for this week, as I try to be 
> pretty conservative this late in the cycle.  There's another kprobes fix 
> on the list so if we end up with an rc8 I might send this along with 
> that, otherwise this'll just go onto for-next before the linear map 
> changes that exercise the bug.
> 
> You're more than welcome to just dig up the fixes tag and reply, my 
> scripts pull all tags from replies (just like Revieweb-by).  Otherwise 
> I'll do it myself, most people don't really post Fixes tags that 
> accurately so I go through it for pretty much everything anyway.

Here it is:

Fixes: 4b67f48da707 ("riscv: Move kernel mapping outside of linear mapping")

Thanks,

> 
> Thanks for sorting this out so quickly!
> 
>>
>>>
>>> Otherwise it looks good.
>>>
>>> Reviewed-by: Anup Patel <anup@brainfault.org>
>>
>> Thank you!
>>
>> Alex
>>
>>>
>>> Regards,
>>> Anup
>>>
>>>> ---
>>>>   arch/riscv/kernel/setup.c | 8 ++++----
>>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>>>> index 626003bb5fca..ab394d173cd4 100644
>>>> --- a/arch/riscv/kernel/setup.c
>>>> +++ b/arch/riscv/kernel/setup.c
>>>> @@ -264,12 +264,12 @@ void __init setup_arch(char **cmdline_p)
>>>>
>>>>          sbi_init();
>>>>
>>>> -       if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
>>>> +       if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
>>>>                  protect_kernel_text_data();
>>>> -
>>>> -#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>>>> -       protect_kernel_linear_mapping_text_rodata();
>>>> +#ifdef CONFIG_64BIT
>>>> +               protect_kernel_linear_mapping_text_rodata();
>>>>   #endif
>>>> +       }
>>>>
>>>>   #ifdef CONFIG_SWIOTLB
>>>>          swiotlb_init(1);
>>>> -- 
>>>> 2.20.1
>>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

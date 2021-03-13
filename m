Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD08339CE4
	for <lists+linux-arch@lfdr.de>; Sat, 13 Mar 2021 09:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhCMIYI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 13 Mar 2021 03:24:08 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:33515 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbhCMIXv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 Mar 2021 03:23:51 -0500
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 24807200003;
        Sat, 13 Mar 2021 08:23:44 +0000 (UTC)
Subject: Re: [PATCH 2/3] Documentation: riscv: Add documentation that
 describes the VM layout
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20210225080453.1314-1-alex@ghiti.fr>
 <20210225080453.1314-3-alex@ghiti.fr>
 <5279e97c-3841-717c-2a16-c249a61573f9@redhat.com>
 <7d9036d9-488b-47cc-4673-1b10c11baad0@ghiti.fr>
 <CAK8P3a3mVDwJG6k7PZEKkteszujP06cJf8Zqhq43F0rNsU=h4g@mail.gmail.com>
 <236a9788-8093-9876-a024-b0ad0d672c72@ghiti.fr>
 <CAK8P3a1+vSoEBqHPzj9S07B7h-Xuwvccpsh1pnn+1xJmS3UdbA@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <50109729-9a86-6b49-b608-dd5c8eb2d88e@ghiti.fr>
Date:   Sat, 13 Mar 2021 03:23:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1+vSoEBqHPzj9S07B7h-Xuwvccpsh1pnn+1xJmS3UdbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

Le 3/11/21 à 3:42 AM, Arnd Bergmann a écrit :
> On Wed, Mar 10, 2021 at 8:12 PM Alex Ghiti <alex@ghiti.fr> wrote:
>> Le 3/10/21 à 6:42 AM, Arnd Bergmann a écrit :
>>> On Thu, Feb 25, 2021 at 12:56 PM Alex Ghiti <alex@ghiti.fr> wrote:
>>>>
>>>> Le 2/25/21 à 5:34 AM, David Hildenbrand a écrit :
>>>>>                     |            |                  |         |> +
>>>>> ffffffc000000000 | -256    GB | ffffffc7ffffffff |   32 GB | kasan
>>>>>> +   ffffffcefee00000 | -196    GB | ffffffcefeffffff |    2 MB | fixmap
>>>>>> +   ffffffceff000000 | -196    GB | ffffffceffffffff |   16 MB | PCI io
>>>>>> +   ffffffcf00000000 | -196    GB | ffffffcfffffffff |    4 GB | vmemmap
>>>>>> +   ffffffd000000000 | -192    GB | ffffffdfffffffff |   64 GB |
>>>>>> vmalloc/ioremap space
>>>>>> +   ffffffe000000000 | -128    GB | ffffffff7fffffff |  126 GB |
>>>>>> direct mapping of all physical memory
>>>>>
>>>>> ^ So you could never ever have more than 126 GB, correct?
>>>>>
>>>>> I assume that's nothing new.
>>>>>
>>>>
>>>> Before this patch, the limit was 128GB, so in my sense, there is nothing
>>>> new. If ever we want to increase that limit, we'll just have to lower
>>>> PAGE_OFFSET, there is still some unused virtual addresses after kasan
>>>> for example.
>>>
>>> Linus Walleij is looking into changing the arm32 code to have the kernel
>>> direct map inside of the vmalloc area, which would be another place
>>> that you could use here. It would be nice to not have too many different
>>> ways of doing this, but I'm not sure how hard it would be to rework your
>>> code, or if there are any downsides of doing this.
>>
>> This was what my previous version did: https://lkml.org/lkml/2020/6/7/28.
>>
>> This approach was not welcomed very well and it fixed only the problem
>> of the implementation of relocatable kernel. The second issue I'm trying
>> to resolve here is to support both 3 and 4 level page tables using the
>> same kernel without being relocatable (which would introduce performance
>> penalty). I can't do it when the kernel mapping is in the vmalloc region
>> since vmalloc region relies on PAGE_OFFSET which is different on both 3
>> and 4 level page table and that would then require the kernel to be
>> relocatable.
> 
> Ok, I see.
> 
> I suppose it might work if you moved the direct-map to the lowest
> address and the vmalloc area (incorporating the kernel mapping,
> modules, pio, and fixmap at fixed addresses) to the very top of the
> address space, but you probably already considered and rejected
> that for other reasons.
> 

Yes I considered it...when you re-proposed it :) I'm not opposed to your 
solution in the vmalloc region but I can't find any advantage over the 
current solution, are there ? That would harmonize with Linus's work, 
but then we'd be quite different from x86 address space.

And by the way, thanks for having suggested the current solution in a 
previous conversation :)

Thanks again,

Alex

>           Arnd
> 

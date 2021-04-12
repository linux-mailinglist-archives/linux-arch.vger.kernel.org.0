Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00BFF35B9BE
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 07:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhDLFMp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 01:12:45 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41753 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhDLFMp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 01:12:45 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B2748E0007;
        Mon, 12 Apr 2021 05:12:23 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v7] RISC-V: enable XIP
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>
References: <20210409065115.11054-1-alex@ghiti.fr>
 <3500f3cb-b660-5bbc-ae8d-0c9770e4a573@ghiti.fr>
 <be575094-badf-bac7-1629-36808ca530cc@redhat.com>
 <c4e78916-7e4c-76db-47f6-4dda3f09c871@ghiti.fr>
 <YHBEsDuEvPAnL8Vb@linux.ibm.com>
 <e7e87306-bb04-2d4f-7e7f-aabd40dccb3b@redhat.com>
 <YHBdzPsHantT9r8t@linux.ibm.com>
 <CAM4kBBKyHSYz+NNDpT=fWseWccsQ4HZ3teBc01jYT2g8j7Ze2A@mail.gmail.com>
Message-ID: <ec1117a5-63fa-f800-1193-b5737eee6150@ghiti.fr>
Date:   Mon, 12 Apr 2021 01:12:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAM4kBBKyHSYz+NNDpT=fWseWccsQ4HZ3teBc01jYT2g8j7Ze2A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 4/9/21 à 10:42 AM, Vitaly Wool a écrit :
> On Fri, Apr 9, 2021 at 3:59 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
>>
>> On Fri, Apr 09, 2021 at 02:46:17PM +0200, David Hildenbrand wrote:
>>>>>> Also, will that memory properly be exposed in the resource tree as
>>>>>> System RAM (e.g., /proc/iomem) ? Otherwise some things (/proc/kcore)
>>>>>> won't work as expected - the kernel won't be included in a dump.
>>>> Do we really need a XIP kernel to included in kdump?
>>>> And does not it sound weird to expose flash as System RAM in /proc/iomem? ;-)
>>>
>>> See my other mail, maybe we actually want something different.
>>>
>>>>
>>>>> I have just checked and it does not appear in /proc/iomem.
>>>>>
>>>>> Ok your conclusion would be to have struct page, I'm going to implement this
>>>>> version then using memblock as you described.
>>>>
>>>> I'm not sure this is required. With XIP kernel text never gets into RAM, so
>>>> it does not seem to require struct page.
>>>>
>>>> XIP by definition has some limitations relatively to "normal" operation,
>>>> so lack of kdump could be one of them.
>>>
>>> I agree.
>>>
>>>>
>>>> I might be wrong, but IMHO, artificially creating a memory map for part of
>>>> flash would cause more problems in the long run.
>>>
>>> Can you elaborate?
>>
>> Nothing particular, just a gut feeling. Usually, when you force something
>> it comes out the wrong way later.
> 
> It's possible still that MTD_XIP is implemented allowing to write to
> the flash used for XIP. While flash is being written, memory map
> doesn't make sense at all. I can't come up with a real life example
> when it can actually lead to problems but it is indeed weird when
> System RAM suddenly becomes unreadable. I really don't think exposing
> it in /proc/iomem is a good idea.
> 
>>>> BTW, how does XIP account the kernel text on other architectures that
>>>> implement it?
>>>
>>> Interesting point, I thought XIP would be something new on RISC-V (well, at
>>> least to me :) ). If that concept exists already, we better mimic what
>>> existing implementations do.
>>
>> I had quick glance at ARM, it seems that kernel text does not have memory
>> map and does not show up in System RAM.
> 
> Exactly, and I believe ARM64 won't do that too when it gets its own
> XIP support (which is underway).
> 


memmap does not seem necessary and ARM/ARM64 do not use it.

But if someone tries to get a struct page from a physical address that 
lies in flash, as mentioned by David, that could lead to silent 
corruptions if something exists at the address where the struct page 
should be. And it is hard to know which features in the kernel depends 
on that.

Regarding SPARSEMEM, the vmemmap lies in its own region so that's 
unlikely to happen, so we will catch those invalid accesses (and that's 
what I observed on riscv).

But for FLATMEM, memmap is in the linear mapping, then that could very 
likely happen silently.

Could a simple solution be to force SPARSEMEM for those XIP kernels ? 
Then wrong things could happen, but we would see those and avoid 
spending hours to debug :)

I will at least send a v8 to remove the pfn_valid modifications for 
FLATMEM that now returns true to pfn in flash.

Thanks,



> Best regards,
>     Vitaly
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

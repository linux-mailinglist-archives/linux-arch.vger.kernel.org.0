Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBD1359F6E
	for <lists+linux-arch@lfdr.de>; Fri,  9 Apr 2021 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhDIM6L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Apr 2021 08:58:11 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:38167 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbhDIM6J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Apr 2021 08:58:09 -0400
X-Originating-IP: 82.65.183.113
Received: from [172.16.5.113] (82-65-183-113.subs.proxad.net [82.65.183.113])
        (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BB8BBFF803;
        Fri,  9 Apr 2021 12:57:51 +0000 (UTC)
Subject: Re: [PATCH v7] RISC-V: enable XIP
To:     David Hildenbrand <david@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20210409065115.11054-1-alex@ghiti.fr>
 <3500f3cb-b660-5bbc-ae8d-0c9770e4a573@ghiti.fr>
 <be575094-badf-bac7-1629-36808ca530cc@redhat.com>
 <c4e78916-7e4c-76db-47f6-4dda3f09c871@ghiti.fr>
 <d4d771a8-c731-acaf-b42d-44800c61f2e6@redhat.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <e06f5c63-c897-51a8-8398-ff844a27ff48@ghiti.fr>
Date:   Fri, 9 Apr 2021 08:57:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d4d771a8-c731-acaf-b42d-44800c61f2e6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Le 4/9/21 à 8:07 AM, David Hildenbrand a écrit :
> On 09.04.21 13:39, Alex Ghiti wrote:
>> Hi David,
>>
>> Le 4/9/21 à 4:23 AM, David Hildenbrand a écrit :
>>> On 09.04.21 09:14, Alex Ghiti wrote:
>>>> Le 4/9/21 à 2:51 AM, Alexandre Ghiti a écrit :
>>>>> From: Vitaly Wool <vitaly.wool@konsulko.com>
>>>>>
>>>>> Introduce XIP (eXecute In Place) support for RISC-V platforms.
>>>>> It allows code to be executed directly from non-volatile storage
>>>>> directly addressable by the CPU, such as QSPI NOR flash which can
>>>>> be found on many RISC-V platforms. This makes way for significant
>>>>> optimization of RAM footprint. The XIP kernel is not compressed
>>>>> since it has to run directly from flash, so it will occupy more
>>>>> space on the non-volatile storage. The physical flash address used
>>>>> to link the kernel object files and for storing it has to be known
>>>>> at compile time and is represented by a Kconfig option.
>>>>>
>>>>> XIP on RISC-V will for the time being only work on MMU-enabled
>>>>> kernels.
>>>>>
>>>> I added linux-mm and linux-arch to get feedbacks because I noticed that
>>>> DEBUG_VM_PGTABLE fails for SPARSEMEM (it works for FLATMEM but I think
>>>> it does not do what is expected): the fact that we don't have any 
>>>> struct
>>>> page to back the text and rodata in flash is the problem but to which
>>>> extent ?
>>>
>>> Just wondering, why can't we create a memmap for that memory -- or is it
>>> even desireable to not do that explicity? There might be some nasty side
>>> effects when not having a memmap for text and rodata.
>>
>>
>> Do you have examples of such effects ? Any feature that will not work
>> without that ?
>>
> 
> At least if it's not part of /proc/iomem in any way (maybe "System RAM" 
> is not what we want without a memmap, TBD), kexec-tools won't be able to 
> handle it properly e.g., for kdump. But not sure if that is really 
> relevant in your setup.
> 
> Regarding other features, anything that does a pfn_valid(), 
> pfn_to_page() or pfn_to_online_page() would behave differently now -- 
> assuming the kernel doesn't fall into a section with other System RAM 
> (whereby we would still allocate the memmap for the whole section).
> 
> I guess you might stumble over some surprises in some code paths, but 
> nothing really comes to mind. Not sure if your zeropage is part of the 
> kernel image on RISC-V (I remember that we sometimes need a memmap 
> there, but I might be wrong)?


It is in the kernel image and is located in bss which will be in RAM and 
then be backed by a memmap.


> 
> I assume you still somehow create the direct mapping for the kernel, 
> right? So it's really some memory region with a direct mapping but 
> without a memmap (and right now, without a resource), correct?
> 


No I don't create any direct mapping for the text and the rodata.


> [...]
> 
>>>
>>> Also, will that memory properly be exposed in the resource tree as
>>> System RAM (e.g., /proc/iomem) ? Otherwise some things (/proc/kcore)
>>> won't work as expected - the kernel won't be included in a dump.
>>
>>
>> I have just checked and it does not appear in /proc/iomem.
>>
>> Ok your conclusion would be to have struct page, I'm going to implement
>> this version then using memblock as you described.
> 
> Let's first evaluate what the harm could be. You could (and should?) 
> create the kernel resource manually - IIRC, that's independent of the 
> memmap/memblock thing.
> 
> @Mike, what's your take on not having a memmap for kernel text and ro data?
> 

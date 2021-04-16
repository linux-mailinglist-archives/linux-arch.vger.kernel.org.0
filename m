Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB936250E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239551AbhDPQBY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 12:01:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238563AbhDPQAy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Apr 2021 12:00:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCBA011B3;
        Fri, 16 Apr 2021 09:00:29 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 098F13F99C;
        Fri, 16 Apr 2021 09:00:27 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] mm: ptdump: Provide page size to notepage()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1618506910.git.christophe.leroy@csgroup.eu>
 <1ef6b954fb7b0f4dfc78820f1e612d2166c13227.1618506910.git.christophe.leroy@csgroup.eu>
 <41819925-3ee5-4771-e98b-0073e8f095cf@arm.com>
 <da53d2f2-b472-0c38-bdd5-99c5a098675d@csgroup.eu>
 <1102cda1-b00f-b6ef-6bf3-22068cc11510@arm.com>
 <6ff4816b-8ff6-19de-73a2-3fcadc003ccd@csgroup.eu>
 <e39d500a-2154-3c5d-9393-8bf53a567fad@arm.com>
 <b6b5300d-35a0-3bc0-ad1d-f2af433ef27e@csgroup.eu>
 <b245cf06-f2e5-87a5-9a5e-64efc39d415a@csgroup.eu>
 <10adad00-14de-61b6-ce2a-bdde23a34bcf@csgroup.eu>
From:   Steven Price <steven.price@arm.com>
Message-ID: <a94fa51b-577f-b520-f8e8-a9304425c265@arm.com>
Date:   Fri, 16 Apr 2021 17:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <10adad00-14de-61b6-ce2a-bdde23a34bcf@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 16/04/2021 16:15, Christophe Leroy wrote:
> 
> 
> Le 16/04/2021 à 17:04, Christophe Leroy a écrit :
>>
>>
>> Le 16/04/2021 à 16:40, Christophe Leroy a écrit :
>>>
>>>
>>> Le 16/04/2021 à 15:00, Steven Price a écrit :
>>>> On 16/04/2021 12:08, Christophe Leroy wrote:
>>>>>
>>>>>
>>>>> Le 16/04/2021 à 12:51, Steven Price a écrit :
>>>>>> On 16/04/2021 11:38, Christophe Leroy wrote:
>>>>>>>
>>>>>>>
>>>>>>> Le 16/04/2021 à 11:28, Steven Price a écrit :
>>>>>>>> To be honest I don't fully understand why powerpc requires the 
>>>>>>>> page_size - it appears to be using it purely to find "holes" in 
>>>>>>>> the calls to note_page(), but I haven't worked out why such 
>>>>>>>> holes would occur.
>>>>>>>
>>>>>>> I was indeed introduced for KASAN. We have a first commit 
>>>>>>> https://github.com/torvalds/linux/commit/cabe8138 which uses page 
>>>>>>> size to detect whether it is a KASAN like stuff.
>>>>>>>
>>>>>>> Then came https://github.com/torvalds/linux/commit/b00ff6d8c as a 
>>>>>>> fix. I can't remember what the problem was exactly, something 
>>>>>>> around the use of hugepages for kernel memory, came as part of 
>>>>>>> the series 
>>>>>>> https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1589866984.git.christophe.leroy@csgroup.eu/ 
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Ah, that's useful context. So it looks like powerpc took a 
>>>>>> different route to reducing the KASAN output to x86.
>>>>>>
>>>>>> Given the generic ptdump code has handling for KASAN already it 
>>>>>> should be possible to drop that from the powerpc arch code, which 
>>>>>> I think means we don't actually need to provide page size to 
>>>>>> notepage(). Hopefully that means more code to delete ;)
>>>>>>
>>>>>
>>>>> Yes ... and no.
>>>>>
>>>>> It looks like the generic ptdump handles the case when several 
>>>>> pgdir entries points to the same kasan_early_shadow_pte. But it 
>>>>> doesn't take into account the powerpc case where we have regular 
>>>>> page tables where several (if not all) PTEs are pointing to the 
>>>>> kasan_early_shadow_page .
>>>>
>>>> I'm not sure I follow quite how powerpc is different here. But could 
>>>> you have a similar check for PTEs against kasan_early_shadow_pte as 
>>>> the other levels already have?
>>>>
>>>> I'm just worried that page_size isn't well defined in this interface 
>>>> and it's going to cause problems in the future.
>>>>
>>>
>>> I'm trying. I reverted the two commits b00ff6d8c and cabe8138.
>>>
>>> At the moment, I don't get exactly what I expect: For linear memory I 
>>> get one line for each 8M page whereas before reverting the patches I 
>>> got one 16M line and one 112M line.
>>>
>>> And for KASAN shadow area I get two lines for the 2x 8M pages 
>>> shadowing linear mem then I get one 4M line for each PGDIR entry 
>>> pointing to kasan_early_shadow_pte.
>>>
>>> 0xf8000000-0xf87fffff 0x07000000         8M   huge        rw       
>>> present
>>> 0xf8800000-0xf8ffffff 0x07800000         8M   huge        rw       
>>> present
>>> 0xf9000000-0xf93fffff 0x01430000         4M               r        
>>> present
>> ...
>>> 0xfec00000-0xfeffffff 0x01430000         4M               r        
>>> present
>>>
>>> Any idea ?
>>>
>>
>>
>> I think the different with other architectures is here:
>>
>>      } else if (flag != st->current_flags || level != st->level ||
>>             addr >= st->marker[1].start_address ||
>>             pa != st->last_pa + PAGE_SIZE) {
>>
>>
>> In addition to the checks everyone do, powerpc also checks "pa != 
>> st->last_pa + PAGE_SIZE".
>> And it is definitely for that test that page_size argument add been 
>> added.
> 
> By replacing that test by (pa - st->start_pa != addr - 
> st->start_address) it works again. So we definitely don't need the real 
> page size.

Yes that should work. Thanks for figuring it out!

> 
>>
>> I see that other architectures except RISCV don't dump the physical 
>> address. But even RISCV doesn't include that check.

Yes not having the physical address certainly simplifies things - 
although I can see why that can be handy to see. The disadvantage is 
that user space or vmalloc()'d memory will produce a lot of output 
because the physical addresses are unlikely to be contiguous. And for 
most uses you don't need the information.

>> That physical address dump was added by commit aaa229529244 
>> ("powerpc/mm: Add physical address to Linux page table dump") 
>> [https://github.com/torvalds/linux/commit/aaa2295]
>>
>> How do other architectures deal with the problem described by the 
>> commit log of that patch ?

AFAIK other architectures are "broken" in this regard. In practice I 
don't think it often causes an issue though.

Steve

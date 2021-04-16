Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB6362300
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbhDPOlw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 10:41:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52168 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245411AbhDPOlV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Apr 2021 10:41:21 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FMJmN2hxGz9vBnG;
        Fri, 16 Apr 2021 16:40:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4QkMRAzEi_DN; Fri, 16 Apr 2021 16:40:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FMJmN11tvz9vBnC;
        Fri, 16 Apr 2021 16:40:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 781F48B84E;
        Fri, 16 Apr 2021 16:40:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id D0sjjGIwO1la; Fri, 16 Apr 2021 16:40:53 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 91A338B84C;
        Fri, 16 Apr 2021 16:40:52 +0200 (CEST)
Subject: Re: [PATCH v1 3/5] mm: ptdump: Provide page size to notepage()
To:     Steven Price <steven.price@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org
References: <cover.1618506910.git.christophe.leroy@csgroup.eu>
 <1ef6b954fb7b0f4dfc78820f1e612d2166c13227.1618506910.git.christophe.leroy@csgroup.eu>
 <41819925-3ee5-4771-e98b-0073e8f095cf@arm.com>
 <da53d2f2-b472-0c38-bdd5-99c5a098675d@csgroup.eu>
 <1102cda1-b00f-b6ef-6bf3-22068cc11510@arm.com>
 <6ff4816b-8ff6-19de-73a2-3fcadc003ccd@csgroup.eu>
 <e39d500a-2154-3c5d-9393-8bf53a567fad@arm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b6b5300d-35a0-3bc0-ad1d-f2af433ef27e@csgroup.eu>
Date:   Fri, 16 Apr 2021 16:40:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <e39d500a-2154-3c5d-9393-8bf53a567fad@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 16/04/2021 à 15:00, Steven Price a écrit :
> On 16/04/2021 12:08, Christophe Leroy wrote:
>>
>>
>> Le 16/04/2021 à 12:51, Steven Price a écrit :
>>> On 16/04/2021 11:38, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 16/04/2021 à 11:28, Steven Price a écrit :
>>>>> On 15/04/2021 18:18, Christophe Leroy wrote:
>>>>>> In order to support large pages on powerpc, notepage()
>>>>>> needs to know the page size of the page.
>>>>>>
>>>>>> Add a page_size argument to notepage().
>>>>>>
>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>>>>> ---
>>>>>>   arch/arm64/mm/ptdump.c         |  2 +-
>>>>>>   arch/riscv/mm/ptdump.c         |  2 +-
>>>>>>   arch/s390/mm/dump_pagetables.c |  3 ++-
>>>>>>   arch/x86/mm/dump_pagetables.c  |  2 +-
>>>>>>   include/linux/ptdump.h         |  2 +-
>>>>>>   mm/ptdump.c                    | 16 ++++++++--------
>>>>>>   6 files changed, 14 insertions(+), 13 deletions(-)
>>>>>>
>>>>> [...]
>>>>>> diff --git a/mm/ptdump.c b/mm/ptdump.c
>>>>>> index da751448d0e4..61cd16afb1c8 100644
>>>>>> --- a/mm/ptdump.c
>>>>>> +++ b/mm/ptdump.c
>>>>>> @@ -17,7 +17,7 @@ static inline int note_kasan_page_table(struct mm_walk *walk,
>>>>>>   {
>>>>>>       struct ptdump_state *st = walk->private;
>>>>>> -    st->note_page(st, addr, 4, pte_val(kasan_early_shadow_pte[0]));
>>>>>> +    st->note_page(st, addr, 4, pte_val(kasan_early_shadow_pte[0]), PAGE_SIZE);
>>>>>
>>>>> I'm not completely sure what the page_size is going to be used for, but note that KASAN 
>>>>> presents an interesting case here. We short-cut by detecting it's a KASAN region at a high 
>>>>> level (PGD/P4D/PUD/PMD) and instead of walking the tree down just call note_page() *once* but 
>>>>> with level==4 because we know KASAN sets up the page table like that.
>>>>>
>>>>> However the one call actually covers a much larger region - so while PAGE_SIZE matches the 
>>>>> level it doesn't match the region covered. AFAICT this will lead to odd results if you enable 
>>>>> KASAN on powerpc.
>>>>
>>>> Hum .... I successfully tested it with KASAN, I now realise that I tested it with 
>>>> CONFIG_KASAN_VMALLOC selected. In this situation, since 
>>>> https://github.com/torvalds/linux/commit/af3d0a686 we don't have any common shadow page table 
>>>> anymore.
>>>>
>>>> I'll test again without CONFIG_KASAN_VMALLOC.
>>>>
>>>>>
>>>>> To be honest I don't fully understand why powerpc requires the page_size - it appears to be 
>>>>> using it purely to find "holes" in the calls to note_page(), but I haven't worked out why such 
>>>>> holes would occur.
>>>>
>>>> I was indeed introduced for KASAN. We have a first commit 
>>>> https://github.com/torvalds/linux/commit/cabe8138 which uses page size to detect whether it is a 
>>>> KASAN like stuff.
>>>>
>>>> Then came https://github.com/torvalds/linux/commit/b00ff6d8c as a fix. I can't remember what the 
>>>> problem was exactly, something around the use of hugepages for kernel memory, came as part of 
>>>> the series 
>>>> https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1589866984.git.christophe.leroy@csgroup.eu/ 
>>>
>>>
>>>
>>>
>>> Ah, that's useful context. So it looks like powerpc took a different route to reducing the KASAN 
>>> output to x86.
>>>
>>> Given the generic ptdump code has handling for KASAN already it should be possible to drop that 
>>> from the powerpc arch code, which I think means we don't actually need to provide page size to 
>>> notepage(). Hopefully that means more code to delete ;)
>>>
>>
>> Yes ... and no.
>>
>> It looks like the generic ptdump handles the case when several pgdir entries points to the same 
>> kasan_early_shadow_pte. But it doesn't take into account the powerpc case where we have regular 
>> page tables where several (if not all) PTEs are pointing to the kasan_early_shadow_page .
> 
> I'm not sure I follow quite how powerpc is different here. But could you have a similar check for 
> PTEs against kasan_early_shadow_pte as the other levels already have?
> 
> I'm just worried that page_size isn't well defined in this interface and it's going to cause 
> problems in the future.
> 

I'm trying. I reverted the two commits b00ff6d8c and cabe8138.

At the moment, I don't get exactly what I expect: For linear memory I get one line for each 8M page 
whereas before reverting the patches I got one 16M line and one 112M line.

And for KASAN shadow area I get two lines for the 2x 8M pages shadowing linear mem then I get one 4M 
line for each PGDIR entry pointing to kasan_early_shadow_pte.

0xf8000000-0xf87fffff 0x07000000         8M   huge        rw       present
0xf8800000-0xf8ffffff 0x07800000         8M   huge        rw       present
0xf9000000-0xf93fffff 0x01430000         4M               r        present
0xf9400000-0xf97fffff 0x01430000         4M               r        present
0xf9800000-0xf9bfffff 0x01430000         4M               r        present
0xf9c00000-0xf9ffffff 0x01430000         4M               r        present
0xfa000000-0xfa3fffff 0x01430000         4M               r        present
0xfa400000-0xfa7fffff 0x01430000         4M               r        present
0xfa800000-0xfabfffff 0x01430000         4M               r        present
0xfac00000-0xfaffffff 0x01430000         4M               r        present
0xfb000000-0xfb3fffff 0x01430000         4M               r        present
0xfb400000-0xfb7fffff 0x01430000         4M               r        present
0xfb800000-0xfbbfffff 0x01430000         4M               r        present
0xfbc00000-0xfbffffff 0x01430000         4M               r        present
0xfc000000-0xfc3fffff 0x01430000         4M               r        present
0xfc400000-0xfc7fffff 0x01430000         4M               r        present
0xfc800000-0xfcbfffff 0x01430000         4M               r        present
0xfcc00000-0xfcffffff 0x01430000         4M               r        present
0xfd000000-0xfd3fffff 0x01430000         4M               r        present
0xfd400000-0xfd7fffff 0x01430000         4M               r        present
0xfd800000-0xfdbfffff 0x01430000         4M               r        present
0xfdc00000-0xfdffffff 0x01430000         4M               r        present
0xfe000000-0xfe3fffff 0x01430000         4M               r        present
0xfe400000-0xfe7fffff 0x01430000         4M               r        present
0xfe800000-0xfebfffff 0x01430000         4M               r        present
0xfec00000-0xfeffffff 0x01430000         4M               r        present

Any idea ?

Christophe

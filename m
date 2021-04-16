Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F0D361E3E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 12:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbhDPKvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 06:51:46 -0400
Received: from foss.arm.com ([217.140.110.172]:38604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239598AbhDPKvq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Apr 2021 06:51:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31375106F;
        Fri, 16 Apr 2021 03:51:21 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D9123F85F;
        Fri, 16 Apr 2021 03:51:19 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] mm: ptdump: Provide page size to notepage()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
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
From:   Steven Price <steven.price@arm.com>
Message-ID: <1102cda1-b00f-b6ef-6bf3-22068cc11510@arm.com>
Date:   Fri, 16 Apr 2021 11:51:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <da53d2f2-b472-0c38-bdd5-99c5a098675d@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 16/04/2021 11:38, Christophe Leroy wrote:
> 
> 
> Le 16/04/2021 à 11:28, Steven Price a écrit :
>> On 15/04/2021 18:18, Christophe Leroy wrote:
>>> In order to support large pages on powerpc, notepage()
>>> needs to know the page size of the page.
>>>
>>> Add a page_size argument to notepage().
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/arm64/mm/ptdump.c         |  2 +-
>>>   arch/riscv/mm/ptdump.c         |  2 +-
>>>   arch/s390/mm/dump_pagetables.c |  3 ++-
>>>   arch/x86/mm/dump_pagetables.c  |  2 +-
>>>   include/linux/ptdump.h         |  2 +-
>>>   mm/ptdump.c                    | 16 ++++++++--------
>>>   6 files changed, 14 insertions(+), 13 deletions(-)
>>>
>> [...]
>>> diff --git a/mm/ptdump.c b/mm/ptdump.c
>>> index da751448d0e4..61cd16afb1c8 100644
>>> --- a/mm/ptdump.c
>>> +++ b/mm/ptdump.c
>>> @@ -17,7 +17,7 @@ static inline int note_kasan_page_table(struct 
>>> mm_walk *walk,
>>>   {
>>>       struct ptdump_state *st = walk->private;
>>> -    st->note_page(st, addr, 4, pte_val(kasan_early_shadow_pte[0]));
>>> +    st->note_page(st, addr, 4, pte_val(kasan_early_shadow_pte[0]), 
>>> PAGE_SIZE);
>>
>> I'm not completely sure what the page_size is going to be used for, 
>> but note that KASAN presents an interesting case here. We short-cut by 
>> detecting it's a KASAN region at a high level (PGD/P4D/PUD/PMD) and 
>> instead of walking the tree down just call note_page() *once* but with 
>> level==4 because we know KASAN sets up the page table like that.
>>
>> However the one call actually covers a much larger region - so while 
>> PAGE_SIZE matches the level it doesn't match the region covered. 
>> AFAICT this will lead to odd results if you enable KASAN on powerpc.
> 
> Hum .... I successfully tested it with KASAN, I now realise that I 
> tested it with CONFIG_KASAN_VMALLOC selected. In this situation, since 
> https://github.com/torvalds/linux/commit/af3d0a686 we don't have any 
> common shadow page table anymore.
> 
> I'll test again without CONFIG_KASAN_VMALLOC.
> 
>>
>> To be honest I don't fully understand why powerpc requires the 
>> page_size - it appears to be using it purely to find "holes" in the 
>> calls to note_page(), but I haven't worked out why such holes would 
>> occur.
> 
> I was indeed introduced for KASAN. We have a first commit 
> https://github.com/torvalds/linux/commit/cabe8138 which uses page size 
> to detect whether it is a KASAN like stuff.
> 
> Then came https://github.com/torvalds/linux/commit/b00ff6d8c as a fix. I 
> can't remember what the problem was exactly, something around the use of 
> hugepages for kernel memory, came as part of the series 
> https://patchwork.ozlabs.org/project/linuxppc-dev/cover/cover.1589866984.git.christophe.leroy@csgroup.eu/ 

Ah, that's useful context. So it looks like powerpc took a different 
route to reducing the KASAN output to x86.

Given the generic ptdump code has handling for KASAN already it should 
be possible to drop that from the powerpc arch code, which I think means 
we don't actually need to provide page size to notepage(). Hopefully 
that means more code to delete ;)

Steve

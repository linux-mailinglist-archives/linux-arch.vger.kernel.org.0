Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AFE364868
	for <lists+linux-arch@lfdr.de>; Mon, 19 Apr 2021 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhDSQlt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Apr 2021 12:41:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10096 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232125AbhDSQlt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Apr 2021 12:41:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FPCHr05Bbz9vBmZ;
        Mon, 19 Apr 2021 18:41:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ByG0UeFaG4_7; Mon, 19 Apr 2021 18:41:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FPCHq6Dlmz9vBmY;
        Mon, 19 Apr 2021 18:41:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D43E8B7C9;
        Mon, 19 Apr 2021 18:41:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nDGl7TOpMiLz; Mon, 19 Apr 2021 18:41:17 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 56BD68B7C6;
        Mon, 19 Apr 2021 18:41:16 +0200 (CEST)
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
 <627ee414-2f78-94e3-b77b-1013f52e77e3@csgroup.eu>
 <4a76fbda-aa9d-867b-e2eb-a1951780aeec@arm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4cdd8dc0-34d6-11a3-f3b2-d6eb58c435c7@csgroup.eu>
Date:   Mon, 19 Apr 2021 18:41:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <4a76fbda-aa9d-867b-e2eb-a1951780aeec@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 19/04/2021 à 16:00, Steven Price a écrit :
> On 19/04/2021 14:14, Christophe Leroy wrote:
>>
>>
>> Le 16/04/2021 à 12:51, Steven Price a écrit :
>>> On 16/04/2021 11:38, Christophe Leroy wrote:
>>>>
>>>>
>>>> Le 16/04/2021 à 11:28, Steven Price a écrit :
>>>>> On 15/04/2021 18:18, Christophe Leroy wrote:
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
>> Looking at how the generic ptdump code handles KASAN, I'm a bit sceptic.
>>
>> IIUC, it is checking that kasan_early_shadow_pte is in the same page as the pgtable referred by 
>> the PMD entry. But what happens if that PMD entry is referring another pgtable which is inside the 
>> same page as kasan_early_shadow_pte ?
>>
>> Shouldn't the test be
>>
>>      if (pmd_page_vaddr(val) == lm_alias(kasan_early_shadow_pte))
>>          return note_kasan_page_table(walk, addr);
> 
> Now I come to look at this code again, I think you're right. On arm64 this doesn't cause a problem - 
> page tables are page sized and page aligned, so there couldn't be any non-KASAN pgtables sharing the 
> page. Obviously that's not necessarily true of other architectures.
> 
> Feel free to add a patch to your series ;)
> 

Ok.

I'll leave that outside of the series, it is not a show stopper because early shadow page 
directories are all tagged __bss_page_aligned so we can't have two of them in the same page and it 
is really unlikely that we'll have any other statically defined page directory in the same pages either.

And for the special case of powerpc 8xx which is the only one for which we have both KASAN and 
HUGEPD at the time being, there are only two levels of page directories so no issue.

Christophe

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A29313D4A
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 19:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhBHSWY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 13:22:24 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:35234 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235484AbhBHSVQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 13:21:16 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZD102Hn6zB09Zb;
        Mon,  8 Feb 2021 18:44:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CNsTdCz66tzp; Mon,  8 Feb 2021 18:44:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZD101NMQzB09ZZ;
        Mon,  8 Feb 2021 18:44:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ABEFB8B7B3;
        Mon,  8 Feb 2021 18:44:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Xw3J-TpXLojL; Mon,  8 Feb 2021 18:44:25 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D98298B7B2;
        Mon,  8 Feb 2021 18:44:24 +0100 (CET)
Subject: Re: [PATCH] MIPS: make userspace mapping young by default
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Huang Pei <huangpei@loongson.cn>, ambrosehua@gmail.com,
        Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20210204013942.8398-1-huangpei@loongson.cn>
 <20210204152239.GA14292@alpha.franken.de>
 <20210205154105.32bb13df439aa49b7fc167e7@linux-foundation.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <30b3fcb5-a60d-228f-15d2-cd182953de45@csgroup.eu>
Date:   Mon, 8 Feb 2021 18:44:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210205154105.32bb13df439aa49b7fc167e7@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 06/02/2021 à 00:41, Andrew Morton a écrit :
> On Thu, 4 Feb 2021 16:22:39 +0100 Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> 
>> On Thu, Feb 04, 2021 at 09:39:42AM +0800, Huang Pei wrote:
>>> MIPS page fault path(except huge page) takes 3 exceptions (1 TLB Miss
>>> + 2 TLB Invalid), butthe second TLB Invalid exception is just
>>> triggered by __update_tlb from do_page_fault writing tlb without
>>> _PAGE_VALID set. With this patch, user space mapping prot is made
>>> young by default (with both _PAGE_VALID and _PAGE_YOUNG set),
>>> and it only take 1 TLB Miss + 1 TLB Invalid exception
>>>
>>> Remove pte_sw_mkyoung without polluting MM code and make page fault
>>> delay of MIPS on par with other architecture
>>>
>>> Signed-off-by: Huang Pei <huangpei@loongson.cn>
>>> ---
>>>   arch/mips/mm/cache.c    | 30 ++++++++++++++++--------------
>>>   include/linux/pgtable.h |  8 --------
>>>   mm/memory.c             |  3 ---
>>>   3 files changed, 16 insertions(+), 25 deletions(-)
>>
>> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>>
>> Andrew, can you take this patch through your tree ?
> 
> Sure.  I'll drop Christophe's "mm/memory.c: remove pte_sw_mkyoung()"
> (https://lkml.kernel.org/r/f302ef92c48d1f08a0459aaee1c568ca11213814.1612345700.git.christophe.leroy@csgroup.eu)
> in favour of this one.
> 

Pitty. My patch was improving page faults on powerpc/32. That one is only addressing MIPS.

Any plan to take the series from Nick 
https://patchwork.kernel.org/project/linux-mm/list/?series=404539 ?

Christophe

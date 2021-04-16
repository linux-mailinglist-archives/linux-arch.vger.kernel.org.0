Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A5036193D
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 07:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhDPF0E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 01:26:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47140 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhDPF0E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Apr 2021 01:26:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FM4Rj5BTJzB09bL;
        Fri, 16 Apr 2021 07:25:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id IiPlMveTf2d4; Fri, 16 Apr 2021 07:25:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FM4Rj3d6HzB09bK;
        Fri, 16 Apr 2021 07:25:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E55D8B81C;
        Fri, 16 Apr 2021 07:25:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2-smQfjtxhxm; Fri, 16 Apr 2021 07:25:38 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F75E8B81A;
        Fri, 16 Apr 2021 07:25:37 +0200 (CEST)
Subject: Re: [PATCH v1 4/5] mm: ptdump: Support hugepd table entries
To:     Daniel Axtens <dja@axtens.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1618506910.git.christophe.leroy@csgroup.eu>
 <f41a177a0fd5a71db616e586a9ec5c51102c6656.1618506910.git.christophe.leroy@csgroup.eu>
 <87zgxzyvn3.fsf@dja-thinkpad.axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <0e7b9312-888c-2e53-b7fd-a887fd9fb429@csgroup.eu>
Date:   Fri, 16 Apr 2021 07:25:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <87zgxzyvn3.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Daniel,

Le 16/04/2021 à 01:29, Daniel Axtens a écrit :
> Hi Christophe,
> 
>> Which hugepd, page table entries can be at any level
>> and can be of any size.
>>
>> Add support for them.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   mm/ptdump.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/ptdump.c b/mm/ptdump.c
>> index 61cd16afb1c8..6efdb8c15a7d 100644
>> --- a/mm/ptdump.c
>> +++ b/mm/ptdump.c
>> @@ -112,11 +112,24 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
>>   {
>>   	struct ptdump_state *st = walk->private;
>>   	pte_t val = ptep_get(pte);
>> +	unsigned long page_size = next - addr;
>> +	int level;
>> +
>> +	if (page_size >= PGDIR_SIZE)
>> +		level = 0;
>> +	else if (page_size >= P4D_SIZE)
>> +		level = 1;
>> +	else if (page_size >= PUD_SIZE)
>> +		level = 2;
>> +	else if (page_size >= PMD_SIZE)
>> +		level = 3;
>> +	else
>> +		level = 4;
>>   
>>   	if (st->effective_prot)
>> -		st->effective_prot(st, 4, pte_val(val));
>> +		st->effective_prot(st, level, pte_val(val));
>>   
>> -	st->note_page(st, addr, 4, pte_val(val), PAGE_SIZE);
>> +	st->note_page(st, addr, level, pte_val(val), page_size);
> 
> It seems to me that passing both level and page_size is a bit redundant,
> but I guess it does reduce the impact on each arch's code?

Exactly, as shown above, the level can be re-calculated based on the page size, but it would be a 
unnecessary impact on all architectures and would duplicate the re-calculation of the level whereas 
in most cases we get it for free from the caller.

> 
> Kind regards,
> Daniel
> 
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.25.0

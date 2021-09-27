Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33447419569
	for <lists+linux-arch@lfdr.de>; Mon, 27 Sep 2021 15:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhI0Nwt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Sep 2021 09:52:49 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52289 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234589AbhI0Nwt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Sep 2021 09:52:49 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HJ3vL1zTlz9sXy;
        Mon, 27 Sep 2021 15:51:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UxKXWkRZpdci; Mon, 27 Sep 2021 15:51:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HJ3vL0qqRz9sXw;
        Mon, 27 Sep 2021 15:51:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 074478B76E;
        Mon, 27 Sep 2021 15:51:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id nsEoLaYG6VnV; Mon, 27 Sep 2021 15:51:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CA6948B763;
        Mon, 27 Sep 2021 15:51:09 +0200 (CEST)
Subject: Re: [PATCH 1/3] mm: Make generic arch_is_kernel_initmem_freed() do
 what it says
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
References: <0b55650058a5bf64f7d74781871a1ada2298c8b4.1632491308.git.christophe.leroy@csgroup.eu>
 <87h7e6kvs3.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f206b856-f5a8-3e47-03cb-49aaa5c521f0@csgroup.eu>
Date:   Mon, 27 Sep 2021 15:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87h7e6kvs3.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 27/09/2021 à 15:11, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Commit 7a5da02de8d6 ("locking/lockdep: check for freed initmem in
>> static_obj()") added arch_is_kernel_initmem_freed() which is supposed
>> to report whether an object is part of already freed init memory.
>>
>> For the time being, the generic version of arch_is_kernel_initmem_freed()
>> always reports 'false', allthough free_initmem() is generically called
>> on all architectures.
>>
>> Therefore, change the generic version of arch_is_kernel_initmem_freed()
>> to check whether free_initmem() has been called. If so, then check
>> if a given address falls into init memory.
>>
>> In order to use function init_section_contains(), the fonction is
>> moved at the end of asm-generic/section.h
>>
>> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   include/asm-generic/sections.h | 31 +++++++++++++++++--------------
>>   1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>> index d16302d3eb59..d1e5bb2c6b72 100644
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -172,4 +158,21 @@ static inline bool is_kernel_rodata(unsigned long addr)
>>   	       addr < (unsigned long)__end_rodata;
>>   }
>>   
>> +/*
>> + * Check if an address is part of freed initmem. This is needed on architectures
>> + * with virt == phys kernel mapping, for code that wants to check if an address
>> + * is part of a static object within [_stext, _end]. After initmem is freed,
>> + * memory can be allocated from it, and such allocations would then have
>> + * addresses within the range [_stext, _end].
>> + */
>> +#ifndef arch_is_kernel_initmem_freed
>> +static inline int arch_is_kernel_initmem_freed(unsigned long addr)
>> +{
>> +	if (system_state < SYSTEM_RUNNING)
>> +		return 0;
>> +
>> +	return init_section_contains((void *)addr, 1);
>> +}
>> +#endif
> 
> This will return an incorrect result for a short period during boot
> won't it?
> 
> See init/main.c:
> 
> static int __ref kernel_init(void *unused)
> {
> 	...
> 	free_initmem();			<- memory is freed here
> 	mark_readonly();
> 
> 	/*
> 	 * Kernel mappings are now finalized - update the userspace page-table
> 	 * to finalize PTI.
> 	 */
> 	pti_finalize();
> 
> 	system_state = SYSTEM_RUNNING;
> 
> 
> After free_initmem() we have address ranges that are now freed initmem,
> but arch_is_kernel_initmem_freed() continues to return 0 (false) for all
> addresses, until we update system_state.
> 
> Possibly that doesn't matter for any of the current callers, but it
> seems pretty dicey to me.
> 

Yes I saw it but as function core_kernel_text() uses that criteria for 
deciding whether a given init text address is valid or not, I thought it 
was just ok.

Should we add an intermediate state called for exemple 
SYSTEM_FREEING_INIT just before SYSTEM_RUNNING ?

Christophe

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A329361933
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 07:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbhDPFUO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Apr 2021 01:20:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51714 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234768AbhDPFUO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Apr 2021 01:20:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FM4K01LdRzB09bJ;
        Fri, 16 Apr 2021 07:19:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id n0Rd_tp0QaYj; Fri, 16 Apr 2021 07:19:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FM4Jz6gV6zB09b1;
        Fri, 16 Apr 2021 07:19:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B55238B81C;
        Fri, 16 Apr 2021 07:19:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3r3x5D8gtbOn; Fri, 16 Apr 2021 07:19:48 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E3F818B81A;
        Fri, 16 Apr 2021 07:19:47 +0200 (CEST)
Subject: Re: [PATCH v1 3/5] mm: ptdump: Provide page size to notepage()
To:     Daniel Axtens <dja@axtens.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org
References: <cover.1618506910.git.christophe.leroy@csgroup.eu>
 <1ef6b954fb7b0f4dfc78820f1e612d2166c13227.1618506910.git.christophe.leroy@csgroup.eu>
 <8735vr16sd.fsf@dja-thinkpad.axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ce7773ea-80d0-14c8-3547-d53424682469@csgroup.eu>
Date:   Fri, 16 Apr 2021 07:19:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <8735vr16sd.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 16/04/2021 à 01:12, Daniel Axtens a écrit :
> Hi Christophe,
> 
>>   static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>> -		      u64 val)
>> +		      u64 val, unsigned long page_size)
> 
> Compilers can warn about unused parameters at -Wextra level.  However,
> reading scripts/Makefile.extrawarn it looks like the warning is
> explicitly _disabled_ in the kernel at W=1 and not reenabled at W=2 or
> W=3. So I guess this is fine...

There are a lot lot lot functions having unused parameters in the kernel , especially the ones that 
are re-implemented by each architecture.

> 
>> @@ -126,7 +126,7 @@ static int ptdump_hole(unsigned long addr, unsigned long next,
>>   {
>>   	struct ptdump_state *st = walk->private;
>>   
>> -	st->note_page(st, addr, depth, 0);
>> +	st->note_page(st, addr, depth, 0, 0);
> 
> I know it doesn't matter at this point, but I'm not really thrilled by
> the idea of passing 0 as the size here. Doesn't the hole have a known
> page size?

The hole has a size for sure, I don't think we can call it a page size:

On powerpc 8xx, we have 4 page sizes: 8M, 512k, 16k and 4k.
A page table will cover 4M areas and will contain pages of size 512k, 16k and 4k.
A PGD table contains either entries which points to a page table (covering 4M), or two identical 
consecutive entries pointing to the same hugepd which contains a single PTE for an 8M page.

So, if a PGD entry is empty, the hole is 4M, it corresponds to none of the page sizes the 
architecture supports.


But looking at what is done with that size, it can make sense to pass it to notepage() anyway. Let's 
do that.

> 
>>   
>>   	return 0;
>>   }
>> @@ -153,5 +153,5 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
>>   	mmap_read_unlock(mm);
>>   
>>   	/* Flush out the last page */
>> -	st->note_page(st, 0, -1, 0);
>> +	st->note_page(st, 0, -1, 0, 0);
> 
> I'm more OK with the idea of passing 0 as the size when the depth is -1
> (don't know): if we don't know the depth we conceptually can't know the
> page size.
> 
> Regards,
> Daniel
> 

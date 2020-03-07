Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F5717CC95
	for <lists+linux-arch@lfdr.de>; Sat,  7 Mar 2020 08:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgCGHFO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 Mar 2020 02:05:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:2841 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgCGHFO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 7 Mar 2020 02:05:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48ZFqW22V5zB09Zy;
        Sat,  7 Mar 2020 08:05:11 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=hFwvKFlt; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id JH70JFMo2Nhm; Sat,  7 Mar 2020 08:05:11 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48ZFqW06j2zB09Zx;
        Sat,  7 Mar 2020 08:05:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1583564711; bh=KLykoiwakmvXlj7iOgiNeBA+k4S6on8FDV27weKg6MI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hFwvKFlt5tItEoeChiMcVbq8Z6WEJiAIueL914VqsjAkNiTW/tX4E4mkXgZPRPVQp
         1TSwGC1wl0uEf1SM3tvrvXA0/srRG2BvZ2uOnFi+rWlXqmPEgF9Of2NNwJRqkfVxFW
         8RUJEw8G1tWI+NWaS36EliXDmOzscoTf3q3gSbXQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D550D8B784;
        Sat,  7 Mar 2020 08:05:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OhKGFoGl11OV; Sat,  7 Mar 2020 08:05:11 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4A0DC8B776;
        Sat,  7 Mar 2020 08:05:09 +0100 (CET)
Subject: Re: [PATCH V15] mm/debug: Add tests validating architecture page
 table helpers
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <61250cdc-f80b-2e50-5168-2ec67ec6f1e6@arm.com>
 <CEEAD95E-D468-4C58-A65B-7E8AED91168A@lca.pw>
 <a45834bc-e6f2-ac21-de9e-1aff67d12797@arm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c40d907a-b64b-ae0d-e58f-33dddf0e8edc@c-s.fr>
Date:   Sat, 7 Mar 2020 08:05:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a45834bc-e6f2-ac21-de9e-1aff67d12797@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 07/03/2020 à 01:56, Anshuman Khandual a écrit :
> 
> 
> On 03/07/2020 06:04 AM, Qian Cai wrote:
>>
>>
>>> On Mar 6, 2020, at 7:03 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>>
>>> Hmm, set_pte_at() function is not preferred here for these tests. The idea
>>> is to avoid or atleast minimize TLB/cache flushes triggered from these sort
>>> of 'static' tests. set_pte_at() is platform provided and could/might trigger
>>> these flushes or some other platform specific synchronization stuff. Just
>>
>> Why is that important for this debugging option?
> 
> Primarily reason is to avoid TLB/cache flush instructions on the system
> during these tests that only involve transforming different page table
> level entries through helpers. Unless really necessary, why should it
> emit any TLB/cache flush instructions ?

What's the problem with thoses flushes ?

> 
>>
>>> wondering is there specific reason with respect to the soft lock up problem
>>> making it necessary to use set_pte_at() rather than a simple WRITE_ONCE() ?
>>
>> Looks at the s390 version of set_pte_at(), it has this comment,
>> vmaddr);
>>
>> /*
>>   * Certain architectures need to do special things when PTEs
>>   * within a page table are directly modified.  Thus, the following
>>   * hook is made available.
>>   */
>>
>> I can only guess that powerpc  could be the same here.
> 
> This comment is present in multiple platforms while defining set_pte_at().
> Is not 'barrier()' here alone good enough ? Else what exactly set_pte_at()
> does as compared to WRITE_ONCE() that avoids the soft lock up, just trying
> to understand.
> 


Argh ! I didn't realise that you were writing directly into the page 
tables. When it works, that's only by chance I guess.

To properly set the page table entries, set_pte_at() has to be used:
- On powerpc 8xx, with 16k pages, the page table entry must be copied 
four times. set_pte_at() does it, WRITE_ONCE() doesn't.
- On powerpc book3s/32 (hash MMU), the flag _PAGE_HASHPTE must be 
preserved among writes. set_pte_at() preserves it, WRITE_ONCE() doesn't.

set_pte_at() also does a few other mandatory things, like calling 
pte_mkpte()

So, the WRITE_ONCE() must definitely become a set_pte_at()

Christophe

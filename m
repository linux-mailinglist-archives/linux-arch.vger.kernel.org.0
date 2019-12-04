Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F56112C7A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 14:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfLDNWc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Dec 2019 08:22:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32891 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbfLDNWc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 08:22:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id y206so3666328pfb.0;
        Wed, 04 Dec 2019 05:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wZJOF5sLAkP6Lj5JLT4j1oHbVGDdAKwvCkWIUq+dheE=;
        b=pyRyiRJsR/LSFSgykNDNtWvgkjb/xDhjdWYPO4bvDoYwIrAiXaC8Q9Mfe1qKKmYaYR
         JGPz6eDAEudYkUKAeATKN7m8fsMYj1DteNEskTvJFGYJ/At5faDtqSL/RU12cSxucLnA
         RrbwncZHxyOUZ6HvOlL/m+ImhQucJU7j0tMmCXkom+JkJkQJJcg0/2JiLLTYBFhrYNX2
         ZRhSs1k59HQ9adQyGfpYEk2vMSekJHU9onLCDZyH8bdnlj6UzaUbsTkXclR6XB+ik+1m
         dflGFJf6R4P6X7Ct5JDhiuAiIqObkM0FdrlxMLHxzgMiyfo83v/ANwBZVNjQ358K8BkO
         TxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wZJOF5sLAkP6Lj5JLT4j1oHbVGDdAKwvCkWIUq+dheE=;
        b=jflCQXiOv7+nLXKn1YlY6cF/4OqdpBthPswq6VHKIaxAwDlJpdprXoIJzwO9m3X3+p
         jzgDBL915P4/P9r76qeVC2f1GC8TXvq5n68Le1DgRE1sam8IcwekcYxWVBxLF+4nIB3N
         qRwDdlvva5fFi5anU6oi1oJnYZCND0SIpXYlmymLqJ+WTE9wRW/t/l3omc0zSqLyfFTl
         w+uOuteupy4o7BJQ3KAvr8vBq8MULKPylUvgqdDxArRDrm/cRXLbROSFiwVPofMzcGaQ
         vwfIFNBGmKI/ddEQ05vWsCX8mmDWJ7qm6IvBdrjZx3oi229htzJTxhfHi3uwRRNGdHsb
         4mmA==
X-Gm-Message-State: APjAAAUt/VA/InQSXCCx1aN6R0x1dowIFVxiV7nGvnSi/mJzxjJQmE79
        tyVC5viUDx34xRjkVgrwnIjONQFq
X-Google-Smtp-Source: APXvYqwkk/5MouzqntAeuXQGGYrBHHJiqg16oYZsk0XxEdxvjahSNBUzsQvvraKzr9vzruaDkgwQtw==
X-Received: by 2002:aa7:8ad3:: with SMTP id b19mr3489646pfd.134.1575465751097;
        Wed, 04 Dec 2019 05:22:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s7sm7911105pfe.22.2019.12.04.05.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 05:22:30 -0800 (PST)
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <156fa92f-4c5a-08bd-bcda-20029724c0de@roeck-us.net>
Date:   Wed, 4 Dec 2019 05:22:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/4/19 4:32 AM, Geert Uytterhoeven wrote:
> Hoi Peter,
> 
> On Wed, Dec 4, 2019 at 11:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> On Tue, Dec 03, 2019 at 12:19:00PM +0100, Geert Uytterhoeven wrote:
>>> On Tue, Feb 19, 2019 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>> Generic mmu_gather provides everything SH needs (range tracking and
>>>> cache coherency).
>>>>
>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Nick Piggin <npiggin@gmail.com>
>>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>> Cc: Rich Felker <dalias@libc.org>
>>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>
>>> I got remote access to an SH7722-based Migo-R again, which spews a long
>>> sequence of BUGs during userspace startup.  I've bisected this to commit
>>> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
>>
>> Whoopsy.. also, is this really the first time anybody booted an SH
>> kernel in over a year ?!?
> 
> Nah, but the v5.4-rc3 I booted recently on qemu -M r2d had
> CONFIG_PGTABLE_LEVELS=2, so it didn't show the problem.
> 

Guess that explains why I do not see the problem with my qemu boots.
I use rts7751r2dplus_defconfig. Is it possible to reproduce the problem
with qemu ? I don't think so, but maybe I am missing something.

Guenter

>>> Do you have a clue?
>>
>> Does the below help?
> 
> Unfortunately not.
> 
>> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
>> index 22d968bfe9bb..73a2c00de6c5 100644
>> --- a/arch/sh/include/asm/pgalloc.h
>> +++ b/arch/sh/include/asm/pgalloc.h
>> @@ -36,9 +36,8 @@ do {                                                  \
>>   #if CONFIG_PGTABLE_LEVELS > 2
>>   #define __pmd_free_tlb(tlb, pmdp, addr)                        \
>>   do {                                                   \
>> -       struct page *page = virt_to_page(pmdp);         \
>> -       pgtable_pmd_page_dtor(page);                    \
>> -       tlb_remove_page((tlb), page);                   \
>> +       pgtable_pmd_page_dtor(pmdp);                    \
> 
> expected ‘struct page *’ but argument is of type ‘pmd_t * {aka struct
> <anonymous> *}’
> 
>> +       tlb_remove_page((tlb), (pmdp));                 \
> 
> likewise
> 
>>   } while (0);
>>   #endif
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


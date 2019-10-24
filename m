Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D9E2A58
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 08:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437742AbfJXGXO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 02:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727750AbfJXGXO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Oct 2019 02:23:14 -0400
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C14921655;
        Thu, 24 Oct 2019 06:23:06 +0000 (UTC)
Subject: Re: [PATCH 04/12] m68k: nommu: use pgtable-nopud instead of
 4level-fixup
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jeff Dike <jdike@addtoit.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
        sparclinux@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-5-git-send-email-rppt@kernel.org>
 <de03a882-fb1a-455c-7c60-84ab0c4f9674@linux-m68k.org>
 <20191024053533.GA12281@rapoport-lnx>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <24454c38-184a-b5fe-e534-aad3713c157e@linux-m68k.org>
Date:   Thu, 24 Oct 2019 16:23:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191024053533.GA12281@rapoport-lnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

On 24/10/19 3:35 pm, Mike Rapoport wrote:
> Hi Greg,
> 
> On Thu, Oct 24, 2019 at 02:09:01PM +1000, Greg Ungerer wrote:
>> Hi Mike,
>>
>> On 23/10/19 7:28 pm, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> The generic nommu implementation of page table manipulation takes care of
>>> folding of the upper levels and does not require fixups.
>>>
>>> Simply replace of include/asm-generic/4level-fixup.h with
>>> include/asm-generic/pgtable-nopud.h.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>> ---
>>>   arch/m68k/include/asm/pgtable_no.h | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
>>> index c18165b..ccc4568 100644
>>> --- a/arch/m68k/include/asm/pgtable_no.h
>>> +++ b/arch/m68k/include/asm/pgtable_no.h
>>> @@ -2,7 +2,7 @@
>>>   #ifndef _M68KNOMMU_PGTABLE_H
>>>   #define _M68KNOMMU_PGTABLE_H
>>> -#include <asm-generic/4level-fixup.h>
>>> +#include <asm-generic/pgtable-nopud.h>
>>>   /*
>>>    * (C) Copyright 2000-2002, Greg Ungerer <gerg@snapgear.com>
>>
>> This fails to compile for me (targeting m5208evb_defconfig):
>>
>>    CC      init/main.o
>> In file included from ./arch/m68k/include/asm/pgtable_no.h:56:0,
>>                   from ./arch/m68k/include/asm/pgtable.h:3,
>>                   from ./include/linux/mm.h:99,
>>                   from ./include/linux/ring_buffer.h:5,
>>                   from ./include/linux/trace_events.h:6,
>>                   from ./include/trace/syscall.h:7,
>>                   from ./include/linux/syscalls.h:85,
>>                   from init/main.c:21:
>> ./include/asm-generic/pgtable.h:738:34: error: unknown type name ‘pmd_t’
>>   static inline int pmd_soft_dirty(pmd_t pmd)
>>                                    ^
> 
> ...
> 
>> scripts/Makefile.build:265: recipe for target 'init/main.o' failed
>> make[1]: *** [init/main.o] Error 1
>> Makefile:1649: recipe for target 'init' failed
>> make: *** [init] Error 2
> 
> The hunk below fixes the build.
> 
> diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
> index c00b67a..05e1e1e 100644
> --- a/arch/m68k/include/asm/page.h
> +++ b/arch/m68k/include/asm/page.h
> @@ -21,7 +21,7 @@
>   /*
>    * These are used to make use of C type-checking..
>    */
> -#if CONFIG_PGTABLE_LEVELS == 3
> +#if !defined(CONFIG_MMU) || CONFIG_PGTABLE_LEVELS == 3
>   typedef struct { unsigned long pmd[16]; } pmd_t;
>   #define pmd_val(x)	((&x)->pmd[0])
>   #define __pmd(x)	((pmd_t) { { (x) }, })

That looks better. Thanks.
Tested and working on m68knommu. For the combined patches:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



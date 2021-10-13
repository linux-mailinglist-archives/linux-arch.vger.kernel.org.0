Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097DA42B919
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 09:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbhJMHb6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:31:58 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:35339 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238446AbhJMHb6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Oct 2021 03:31:58 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HTkh172KBz9sST;
        Wed, 13 Oct 2021 09:29:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8P4NSX8HwSC7; Wed, 13 Oct 2021 09:29:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HTkh160rrz9sSS;
        Wed, 13 Oct 2021 09:29:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B6CEE8B77E;
        Wed, 13 Oct 2021 09:29:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id RP-ZD3PoBsMw; Wed, 13 Oct 2021 09:29:53 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 93FBA8B763;
        Wed, 13 Oct 2021 09:29:53 +0200 (CEST)
Subject: Re: [PATCH v1 08/10] lkdtm: Really write into kernel text in
 WRITE_KERN
To:     Kees Cook <keescook@chromium.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <624940395e5d81967246f911a65740b9a15b5a70.1633964380.git.christophe.leroy@csgroup.eu>
 <202110130004.880A6C841@keescook>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <336f314c-2db3-0899-b012-18c493ae0e3a@csgroup.eu>
Date:   Wed, 13 Oct 2021 09:29:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202110130004.880A6C841@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 13/10/2021 à 09:05, Kees Cook a écrit :
> On Mon, Oct 11, 2021 at 05:25:35PM +0200, Christophe Leroy wrote:
>> WRITE_KERN is supposed to overwrite some kernel text, namely
>> do_overwritten() function.
>>
>> But at the time being it overwrites do_overwritten() function
>> descriptor, not function text.
>>
>> Fix it by dereferencing the function descriptor to obtain
>> function text pointer.
>>
>> And make do_overwritten() noinline so that it is really
>> do_overwritten() which is called by lkdtm_WRITE_KERN().
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   drivers/misc/lkdtm/perms.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
>> index 60b3b2fe929d..442d60ed25ef 100644
>> --- a/drivers/misc/lkdtm/perms.c
>> +++ b/drivers/misc/lkdtm/perms.c
>> @@ -5,6 +5,7 @@
>>    * even non-readable regions.
>>    */
>>   #include "lkdtm.h"
>> +#include <linux/kallsyms.h>
> 
> Why not #include <asm/sections.h> instead here?

dereference_symbol_descriptor() is defined in linux/kallsyms.h

> 
>>   #include <linux/slab.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/mman.h>
>> @@ -37,7 +38,7 @@ static noinline void do_nothing(void)
>>   }
>>   
>>   /* Must immediately follow do_nothing for size calculuations to work out. */
>> -static void do_overwritten(void)
>> +static noinline void do_overwritten(void)
>>   {
>>   	pr_info("do_overwritten wasn't overwritten!\n");
>>   	return;
>> @@ -113,8 +114,9 @@ void lkdtm_WRITE_KERN(void)
>>   	size_t size;
>>   	volatile unsigned char *ptr;
>>   
>> -	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
>> -	ptr = (unsigned char *)do_overwritten;
>> +	size = (unsigned long)dereference_symbol_descriptor(do_overwritten) -
>> +	       (unsigned long)dereference_symbol_descriptor(do_nothing);
>> +	ptr = dereference_symbol_descriptor(do_overwritten);
> 
> But otherwise, yup, I expect there will be a bunch of things like this
> to clean up in LKDTM. :| Sorry about that!
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
>>   
>>   	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
>>   	memcpy((void *)ptr, (unsigned char *)do_nothing, size);
>> -- 
>> 2.31.1
>>
> 

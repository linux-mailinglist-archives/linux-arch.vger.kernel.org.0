Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FB642B944
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 09:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhJMHhj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:37:39 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:34967 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232634AbhJMHhj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Oct 2021 03:37:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HTkpb11MYz9sSS;
        Wed, 13 Oct 2021 09:35:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KISzn_mNvu5e; Wed, 13 Oct 2021 09:35:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HTkpb079hz9sRn;
        Wed, 13 Oct 2021 09:35:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0E038B77E;
        Wed, 13 Oct 2021 09:35:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UMXHteUt4-Xt; Wed, 13 Oct 2021 09:35:34 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF3C08B763;
        Wed, 13 Oct 2021 09:35:34 +0200 (CEST)
Subject: Re: [PATCH v1 09/10] lkdtm: Fix lkdtm_EXEC_RODATA()
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
 <7da92e59e148bd23564d63bdd8bcfaba0ba6d1f1.1633964380.git.christophe.leroy@csgroup.eu>
 <202110130008.EC5E957D4A@keescook>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5181d261-fe93-5e21-5013-321d85e22354@csgroup.eu>
Date:   Wed, 13 Oct 2021 09:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202110130008.EC5E957D4A@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 13/10/2021 à 09:09, Kees Cook a écrit :
> On Mon, Oct 11, 2021 at 05:25:36PM +0200, Christophe Leroy wrote:
>> Behind a location, lkdtm_EXEC_RODATA() executes a real function,
>> not a copy of do_nothing().
>>
>> So do it directly instead of using execute_location().
> 
> I don't understand this. Why does the next patch not fix this?

Well, probably it would, but it looked incorrect in my mind.

lkdtm_rodata_do_nothing() is a function which has its own function 
descriptor, it is not a copy of do_nothing().

If we use execute_location() as modified by next patch, then we will 
execute it using the function descriptor of do_nothing(). Allthough it 
most likely works (at least on powerpc as it uses the same TOC) it looks 
odd to me to do so.

Am I missing something ?

Christophe


> 
> -Kees
> 
>>
>> And fix displayed addresses by dereferencing the function descriptors.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   drivers/misc/lkdtm/perms.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
>> index 442d60ed25ef..da16564e1ecd 100644
>> --- a/drivers/misc/lkdtm/perms.c
>> +++ b/drivers/misc/lkdtm/perms.c
>> @@ -153,7 +153,14 @@ void lkdtm_EXEC_VMALLOC(void)
>>   
>>   void lkdtm_EXEC_RODATA(void)
>>   {
>> -	execute_location(lkdtm_rodata_do_nothing, CODE_AS_IS);
>> +	pr_info("attempting ok execution at %px\n",
>> +		dereference_symbol_descriptor(do_nothing));
>> +	do_nothing();
>> +
>> +	pr_info("attempting bad execution at %px\n",
>> +		dereference_symbol_descriptor(lkdtm_rodata_do_nothing));
>> +	lkdtm_rodata_do_nothing();
>> +	pr_err("FAIL: func returned\n");
>>   }
>>   
>>   void lkdtm_EXEC_USERSPACE(void)
>> -- 
>> 2.31.1
>>
> 

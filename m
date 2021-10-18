Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E780D431120
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 09:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhJRHLR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 03:11:17 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:58019 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230375AbhJRHLH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Oct 2021 03:11:07 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HXnzW21G5z9sSY;
        Mon, 18 Oct 2021 09:08:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7w9sEQhgZ9a0; Mon, 18 Oct 2021 09:08:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HXnzW18Trz9sSD;
        Mon, 18 Oct 2021 09:08:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 09C118B76C;
        Mon, 18 Oct 2021 09:08:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lqbCB8AX-POP; Mon, 18 Oct 2021 09:08:54 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C49F38B763;
        Mon, 18 Oct 2021 09:08:54 +0200 (CEST)
Subject: Re: [PATCH v3 04/12] powerpc: Prepare func_desc_t for refactorisation
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1634457599.git.christophe.leroy@csgroup.eu>
 <86c393ce0a6f603f94e6d2ceca08d535f654bb23.1634457599.git.christophe.leroy@csgroup.eu>
 <1634536863.oq0s171f8c.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1f66d234-3624-7ba2-7b03-5d0e1bea087f@csgroup.eu>
Date:   Mon, 18 Oct 2021 09:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1634536863.oq0s171f8c.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 18/10/2021 à 08:27, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of October 17, 2021 10:38 pm:
>> In preparation of making func_desc_t generic, change the ELFv2
>> version to a struct containing 'addr' element.
>>
>> This allows using single helpers common to ELFv1 and ELFv2.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
>> ---
>>   arch/powerpc/kernel/module_64.c | 32 ++++++++++++++------------------
>>   1 file changed, 14 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
>> index a89da0ee25e2..b687ef88c4c4 100644
>> --- a/arch/powerpc/kernel/module_64.c
>> +++ b/arch/powerpc/kernel/module_64.c
>> @@ -33,19 +33,13 @@
>>   #ifdef PPC64_ELF_ABI_v2
>>   
>>   /* An address is simply the address of the function. */
>> -typedef unsigned long func_desc_t;
>> +typedef struct {
>> +	unsigned long addr;
>> +} func_desc_t;
> 
> I'm not quite following why this change is done. I guess it is so you
> can move this func_desc_t type into core code, but why do that? Is it
> just to avoid using the preprocessor?

I explained it in patch 7 but yes it probably also deserves some more 
explanation here as well.

That's right, it's to avoid having to spread #ifdefs everywhere.

> 
> On its own this patch looks okay.
> 
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> 

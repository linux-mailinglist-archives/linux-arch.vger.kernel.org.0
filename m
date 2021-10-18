Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2661431105
	for <lists+linux-arch@lfdr.de>; Mon, 18 Oct 2021 09:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJRHJf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 03:09:35 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:60449 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230346AbhJRHJe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Oct 2021 03:09:34 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HXnxj6V6bz9sSY;
        Mon, 18 Oct 2021 09:07:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ufy2FvxmcmR8; Mon, 18 Oct 2021 09:07:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HXnxj5chVz9sSD;
        Mon, 18 Oct 2021 09:07:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A85088B76C;
        Mon, 18 Oct 2021 09:07:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 67lhJDwjeAym; Mon, 18 Oct 2021 09:07:21 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BB678B763;
        Mon, 18 Oct 2021 09:07:21 +0200 (CEST)
Subject: Re: [PATCH v3 07/12] asm-generic: Define 'func_desc_t' to commonly
 describe function descriptors
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
 <a33107c5b82580862510cc20af0d61e33a2b841d.1634457599.git.christophe.leroy@csgroup.eu>
 <1634538449.eah9b31bbz.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <802b3ff9-8ada-b45b-2b69-b6a23f0c3664@csgroup.eu>
Date:   Mon, 18 Oct 2021 09:07:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1634538449.eah9b31bbz.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 18/10/2021 à 08:29, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of October 17, 2021 10:38 pm:
>> We have three architectures using function descriptors, each with its
>> own type and name.
>>
>> Add a common typedef that can be used in generic code.
>>
>> Also add a stub typedef for architecture without function descriptors,
>> to avoid a forest of #ifdefs.
>>
>> It replaces the similar 'func_desc_t' previously defined in
>> arch/powerpc/kernel/module_64.c
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
> 
> [...]
> 
>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>> index a918388d9bf6..33b51efe3a24 100644
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -63,6 +63,9 @@ extern __visible const void __nosave_begin, __nosave_end;
>>   #else
>>   #define dereference_function_descriptor(p) ((void *)(p))
>>   #define dereference_kernel_function_descriptor(p) ((void *)(p))
>> +typedef struct {
>> +	unsigned long addr;
>> +} func_desc_t;
>>   #endif
>>   
> 
> I think that deserves a comment. If it's just to allow ifdef to be
> avoided, I guess that's okay with a comment. Would be nice if you could
> cause it to generate a link time error if it was ever used like
> undefined functions, but I guess you can't. It's not a necessity though.
> 

I tried to explain it in the commit message, but I can add a comment 
here in addition for sure.

By the way, it IS used in powerpc's module_64.c:

static func_desc_t func_desc(unsigned long addr)
{
	return (func_desc_t){addr};
}

static unsigned long func_addr(unsigned long addr)
{
	return func_desc(addr).addr;
}

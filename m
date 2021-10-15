Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4942E85C
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 07:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbhJOFVj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 01:21:39 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:42297 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhJOFVj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Oct 2021 01:21:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVvhh0J8Lz9sSF;
        Fri, 15 Oct 2021 07:19:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jtk3Nwe2afkT; Fri, 15 Oct 2021 07:19:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVvhg5r1Zz9sSD;
        Fri, 15 Oct 2021 07:19:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A27F58B788;
        Fri, 15 Oct 2021 07:19:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tLs2964MJCL0; Fri, 15 Oct 2021 07:19:31 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.253])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 721608B763;
        Fri, 15 Oct 2021 07:19:30 +0200 (CEST)
Subject: Re: [PATCH v2 03/13] powerpc: Remove func_descr_t
To:     Daniel Axtens <dja@axtens.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <16eef6afbf7322d0c07760ebf827b8f9f50f7c6e.1634190022.git.christophe.leroy@csgroup.eu>
 <874k9j45fm.fsf@dja-thinkpad.axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b02d5211-2f00-b303-766b-d612c1bd4402@csgroup.eu>
Date:   Fri, 15 Oct 2021 07:19:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <874k9j45fm.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 15/10/2021 à 00:17, Daniel Axtens a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> 'func_descr_t' is redundant with 'struct ppc64_opd_entry'
> 
> So, if I understand the overall direction of the series, you're
> consolidating powerpc around one single type for function descriptors,
> and then you're creating a generic typedef so that generic code can
> always do ((func_desc_t)x)->addr to get the address of a function out of
> a function descriptor regardless of arch. (And regardless of whether the
> arch uses function descriptors or not.)

An architecture not using function descriptors won't do much with 
((func_desc_t *)x)->addr. This is just done to allow building stuff 
regardless.

I prefer something like

	if (have_function_descriptors())
		addr = (func_desc_t *)ptr)->addr;
	else
		addr = ptr;

over

	#ifdef HAVE_FUNCTION_DESCRIPTORS
		addr = (func_desc_t *)ptr)->addr;
	#else
		addr = ptr;
	#endif

> 
> So:
> 
>   - why pick ppc64_opd_entry over func_descr_t?

Good question. At the begining it was because it was in UAPI headers, 
and also because it was the one used in our 
dereference_function_descriptor().

But at the end maybe that's not the more logical choice. I need to look 
a bit more.

> 
>   - Why not make our struct just called func_desc_t - why have a
>     ppc64_opd_entry type or a func_descr_t typedef?

Well ... you usually don't flag a struct name with _t, _t will most of 
the time refer to a typedef.

If I want to avoid typedef (I know they are deprecated in kernel coding 
stype), it means the name of the struct must be changed in every 
architecture and it becomes tricky and it adds more churn in them, which 
is what I want to avoid.

At the end we risk to end-up with a messy set of #ifdefs.

Maybe this can be done as a second step, but I would like to minimise 
impact in this series and focus on fixing lkdtm.


> 
>   - Should this patch wait until after you've made the generic
>     func_desc_t change and move directly to that new interface? (rather
>     than move from func_descr_t -> ppc64_opd_entry -> ...) Or is there a
>     particular reason arch specific code should use an arch-specific
>     struct or named type?

As mentioned in kernel coding style, typedefs reduce readability, see 
https://www.kernel.org/doc/html/latest/process/coding-style.html#typedefs

But yes, we could make a step in the direction of a common 'struct 
func_desc'. Let's see if I can do that.

Thanks for your comments.

Christophe

> 
>> Remove it.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/include/asm/code-patching.h | 2 +-
>>   arch/powerpc/include/asm/types.h         | 6 ------
>>   arch/powerpc/kernel/signal_64.c          | 8 ++++----
>>   3 files changed, 5 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
>> index 4ba834599c4d..f3445188d319 100644
>> --- a/arch/powerpc/include/asm/code-patching.h
>> +++ b/arch/powerpc/include/asm/code-patching.h
>> @@ -110,7 +110,7 @@ static inline unsigned long ppc_function_entry(void *func)
>>   	 * function's descriptor. The first entry in the descriptor is the
>>   	 * address of the function text.
>>   	 */
>> -	return ((func_descr_t *)func)->entry;
>> +	return ((struct ppc64_opd_entry *)func)->addr;
>>   #else
>>   	return (unsigned long)func;
>>   #endif
>> diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
>> index f1630c553efe..97da77bc48c9 100644
>> --- a/arch/powerpc/include/asm/types.h
>> +++ b/arch/powerpc/include/asm/types.h
>> @@ -23,12 +23,6 @@
>>   
>>   typedef __vector128 vector128;
>>   
>> -typedef struct {
>> -	unsigned long entry;
>> -	unsigned long toc;
>> -	unsigned long env;
>> -} func_descr_t;
> 
> I was a little concerned about going from a 3-element struct to a
> 2-element struct (as ppc64_opd_entry doesn't have an element for env) -
> but we don't seem to take the sizeof this anywhere, nor do we use env
> anywhere, nor do we do funky macro stuff with it in the signal handling
> code that might implictly use the 3rd element, so I guess this will
> work. Still, func_descr_t seems to describe the underlying ABI better
> than ppc64_opd_entry...
> 
>>   #endif /* __ASSEMBLY__ */
>>   
>>   #endif /* _ASM_POWERPC_TYPES_H */
>> diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
>> index 1831bba0582e..63ddbe7b108c 100644
>> --- a/arch/powerpc/kernel/signal_64.c
>> +++ b/arch/powerpc/kernel/signal_64.c
>> @@ -933,11 +933,11 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
>>   		 * descriptor is the entry address of signal and the second
>>   		 * entry is the TOC value we need to use.
>>   		 */
>> -		func_descr_t __user *funct_desc_ptr =
>> -			(func_descr_t __user *) ksig->ka.sa.sa_handler;
>> +		struct ppc64_opd_entry __user *funct_desc_ptr =
>> +			(struct ppc64_opd_entry __user *)ksig->ka.sa.sa_handler;
>>   
>> -		err |= get_user(regs->ctr, &funct_desc_ptr->entry);
>> -		err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
>> +		err |= get_user(regs->ctr, &funct_desc_ptr->addr);
>> +		err |= get_user(regs->gpr[2], &funct_desc_ptr->r2);
> 
> Likewise, r2 seems like a worse name than toc. I guess we could clean
> that up another time though.
> 
> Kind regards,
> Daniel
> 
>>   	}
>>   
>>   	/* enter the signal handler in native-endian mode */
>> -- 
>> 2.31.1

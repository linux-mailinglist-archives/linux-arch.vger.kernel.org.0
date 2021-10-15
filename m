Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83EE42E8EE
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 08:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhJOG0s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 02:26:48 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49629 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232124AbhJOG0r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Oct 2021 02:26:47 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVx7q1sVsz9sSD;
        Fri, 15 Oct 2021 08:24:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HClYwJ8ghBf8; Fri, 15 Oct 2021 08:24:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVx7q0sMcz9sSB;
        Fri, 15 Oct 2021 08:24:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 072218B788;
        Fri, 15 Oct 2021 08:24:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jDarZQCPleJ2; Fri, 15 Oct 2021 08:24:38 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.255])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DC558B763;
        Fri, 15 Oct 2021 08:24:37 +0200 (CEST)
Subject: Re: [PATCH v2 06/13] asm-generic: Use HAVE_FUNCTION_DESCRIPTORS to
 define associated stubs
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
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <4fda65cda906e56aa87806b658e0828c64792403.1634190022.git.christophe.leroy@csgroup.eu>
 <1634278340.5yp7xtm7um.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7523a005-ea69-7c4c-64ad-bc2537921975@csgroup.eu>
Date:   Fri, 15 Oct 2021 08:24:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1634278340.5yp7xtm7um.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 15/10/2021 à 08:16, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of October 14, 2021 3:49 pm:
>> Replace HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR by
>> HAVE_FUNCTION_DESCRIPTORS and use it instead of
>> 'dereference_function_descriptor' macro to know
>> whether an arch has function descriptors.
>>
>> To limit churn in one of the following patches, use
>> an #ifdef/#else construct with empty first part
>> instead of an #ifndef in asm-generic/sections.h
> 
> Is it worth putting this into Kconfig if you're going to
> change it? In any case

That was what I wanted to do in the begining but how can I do that in 
Kconfig ?

#ifdef __powerpc64__
#if defined(_CALL_ELF) && _CALL_ELF == 2
#define PPC64_ELF_ABI_v2
#else
#define PPC64_ELF_ABI_v1
#endif
#endif /* __powerpc64__ */

#ifdef PPC64_ELF_ABI_v1
#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1

Christophe

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/ia64/include/asm/sections.h    | 5 +++--
>>   arch/parisc/include/asm/sections.h  | 6 ++++--
>>   arch/powerpc/include/asm/sections.h | 6 ++++--
>>   include/asm-generic/sections.h      | 3 ++-
>>   include/linux/kallsyms.h            | 2 +-
>>   5 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
>> index 35f24e52149a..6e55e545bf02 100644
>> --- a/arch/ia64/include/asm/sections.h
>> +++ b/arch/ia64/include/asm/sections.h
>> @@ -9,6 +9,9 @@
>>   
>>   #include <linux/elf.h>
>>   #include <linux/uaccess.h>
>> +
>> +#define HAVE_FUNCTION_DESCRIPTORS 1
>> +
>>   #include <asm-generic/sections.h>
>>   
>>   extern char __phys_per_cpu_start[];
>> @@ -27,8 +30,6 @@ extern char __start_gate_brl_fsys_bubble_down_patchlist[], __end_gate_brl_fsys_b
>>   extern char __start_unwind[], __end_unwind[];
>>   extern char __start_ivt_text[], __end_ivt_text[];
>>   
>> -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
>> -
>>   #undef dereference_function_descriptor
>>   static inline void *dereference_function_descriptor(void *ptr)
>>   {
>> diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm/sections.h
>> index bb52aea0cb21..85149a89ff3e 100644
>> --- a/arch/parisc/include/asm/sections.h
>> +++ b/arch/parisc/include/asm/sections.h
>> @@ -2,6 +2,10 @@
>>   #ifndef _PARISC_SECTIONS_H
>>   #define _PARISC_SECTIONS_H
>>   
>> +#ifdef CONFIG_64BIT
>> +#define HAVE_FUNCTION_DESCRIPTORS 1
>> +#endif
>> +
>>   /* nothing to see, move along */
>>   #include <asm-generic/sections.h>
>>   
>> @@ -9,8 +13,6 @@ extern char __alt_instructions[], __alt_instructions_end[];
>>   
>>   #ifdef CONFIG_64BIT
>>   
>> -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
>> -
>>   #undef dereference_function_descriptor
>>   void *dereference_function_descriptor(void *);
>>   
>> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
>> index 32e7035863ac..bba97b8c38cf 100644
>> --- a/arch/powerpc/include/asm/sections.h
>> +++ b/arch/powerpc/include/asm/sections.h
>> @@ -8,6 +8,10 @@
>>   
>>   #define arch_is_kernel_initmem_freed arch_is_kernel_initmem_freed
>>   
>> +#ifdef PPC64_ELF_ABI_v1
>> +#define HAVE_FUNCTION_DESCRIPTORS 1
>> +#endif
>> +
>>   #include <asm-generic/sections.h>
>>   
>>   extern bool init_mem_is_free;
>> @@ -69,8 +73,6 @@ static inline int overlaps_kernel_text(unsigned long start, unsigned long end)
>>   
>>   #ifdef PPC64_ELF_ABI_v1
>>   
>> -#define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
>> -
>>   #undef dereference_function_descriptor
>>   static inline void *dereference_function_descriptor(void *ptr)
>>   {
>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>> index d16302d3eb59..b677e926e6b3 100644
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -59,7 +59,8 @@ extern char __noinstr_text_start[], __noinstr_text_end[];
>>   extern __visible const void __nosave_begin, __nosave_end;
>>   
>>   /* Function descriptor handling (if any).  Override in asm/sections.h */
>> -#ifndef dereference_function_descriptor
>> +#ifdef HAVE_FUNCTION_DESCRIPTORS
>> +#else
>>   #define dereference_function_descriptor(p) ((void *)(p))
>>   #define dereference_kernel_function_descriptor(p) ((void *)(p))
>>   #endif
>> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
>> index a1d6fc82d7f0..9f277baeb559 100644
>> --- a/include/linux/kallsyms.h
>> +++ b/include/linux/kallsyms.h
>> @@ -57,7 +57,7 @@ static inline int is_ksym_addr(unsigned long addr)
>>   
>>   static inline void *dereference_symbol_descriptor(void *ptr)
>>   {
>> -#ifdef HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR
>> +#ifdef HAVE_FUNCTION_DESCRIPTORS
>>   	struct module *mod;
>>   
>>   	ptr = dereference_kernel_function_descriptor(ptr);
>> -- 
>> 2.31.1
>>
>>
>>

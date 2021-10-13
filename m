Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446E142B8F3
	for <lists+linux-arch@lfdr.de>; Wed, 13 Oct 2021 09:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238386AbhJMH0F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 03:26:05 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50053 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238307AbhJMH0D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Oct 2021 03:26:03 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HTkY93BjVz9sST;
        Wed, 13 Oct 2021 09:23:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4hf0ycKUqtHN; Wed, 13 Oct 2021 09:23:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HTkY929sHz9sSS;
        Wed, 13 Oct 2021 09:23:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 33BA88B77D;
        Wed, 13 Oct 2021 09:23:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 18BEj8t-Aal3; Wed, 13 Oct 2021 09:23:57 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F2D588B763;
        Wed, 13 Oct 2021 09:23:56 +0200 (CEST)
Subject: Re: [PATCH v1 05/10] asm-generic: Define 'funct_descr_t' to commonly
 describe function descriptors
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
 <02224551451ab9c37055499fc621c41246c81125.1633964380.git.christophe.leroy@csgroup.eu>
 <202110130001.11A50456@keescook>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <cf0e465e-e678-692c-3ca5-fde70ba4fc97@csgroup.eu>
Date:   Wed, 13 Oct 2021 09:23:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202110130001.11A50456@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 13/10/2021 à 09:01, Kees Cook a écrit :
> On Mon, Oct 11, 2021 at 05:25:32PM +0200, Christophe Leroy wrote:
>> We have three architectures using function descriptors, each with its
>> own name.
>>
>> Add a common typedef that can be used in generic code.
>>
>> Also add a stub typedef for architecture without function descriptors,
> 
> nit: funct_descr_t reads weird to me. why not func_desc_t ? Either way:

func_desc_t already exists in powerpc. I have a patch to remove it as it 
is redundant with struct ppc64_opd_entry, but I didnt' want to include 
it in this series.

But after all I can add it in this series, I'll add it in v2.

Christophe

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> 
>> to avoid a forest of #ifdefs.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/ia64/include/asm/sections.h    | 1 +
>>   arch/parisc/include/asm/sections.h  | 1 +
>>   arch/powerpc/include/asm/sections.h | 1 +
>>   include/asm-generic/sections.h      | 3 +++
>>   4 files changed, 6 insertions(+)
>>
>> diff --git a/arch/ia64/include/asm/sections.h b/arch/ia64/include/asm/sections.h
>> index 80f5868afb06..929b5c535620 100644
>> --- a/arch/ia64/include/asm/sections.h
>> +++ b/arch/ia64/include/asm/sections.h
>> @@ -8,6 +8,7 @@
>>    */
>>   
>>   #define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
>> +typedef struct fdesc funct_descr_t;
>>   
>>   #include <linux/elf.h>
>>   #include <linux/uaccess.h>
>> diff --git a/arch/parisc/include/asm/sections.h b/arch/parisc/include/asm/sections.h
>> index 2e781ee19b66..329e80f7af0a 100644
>> --- a/arch/parisc/include/asm/sections.h
>> +++ b/arch/parisc/include/asm/sections.h
>> @@ -4,6 +4,7 @@
>>   
>>   #ifdef CONFIG_64BIT
>>   #define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
>> +typedef Elf64_Fdesc funct_descr_t;
>>   #endif
>>   
>>   /* nothing to see, move along */
>> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
>> index b7f1ba04e756..d0d5287fa568 100644
>> --- a/arch/powerpc/include/asm/sections.h
>> +++ b/arch/powerpc/include/asm/sections.h
>> @@ -10,6 +10,7 @@
>>   
>>   #ifdef PPC64_ELF_ABI_v1
>>   #define HAVE_DEREFERENCE_FUNCTION_DESCRIPTOR 1
>> +typedef struct ppc64_opd_entry funct_descr_t;
>>   #endif
>>   
>>   #include <asm-generic/sections.h>
>> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
>> index 1db5cfd69817..436412d94054 100644
>> --- a/include/asm-generic/sections.h
>> +++ b/include/asm-generic/sections.h
>> @@ -63,6 +63,9 @@ extern __visible const void __nosave_begin, __nosave_end;
>>   #else
>>   #define dereference_function_descriptor(p) ((void *)(p))
>>   #define dereference_kernel_function_descriptor(p) ((void *)(p))
>> +typedef struct {
>> +	unsigned long addr;
>> +} funct_descr_t;
>>   #endif
>>   
>>   /* random extra sections (if any).  Override
>> -- 
>> 2.31.1
>>
> 

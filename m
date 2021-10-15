Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2100242E832
	for <lists+linux-arch@lfdr.de>; Fri, 15 Oct 2021 06:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhJOFBl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Oct 2021 01:01:41 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:59639 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235329AbhJOFBk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Oct 2021 01:01:40 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HVvFc6pczz9sSF;
        Fri, 15 Oct 2021 06:59:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qdOizQdCd5vD; Fri, 15 Oct 2021 06:59:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HVvFc5VNgz9sSD;
        Fri, 15 Oct 2021 06:59:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9ACDF8B788;
        Fri, 15 Oct 2021 06:59:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qhm_fwfmQYir; Fri, 15 Oct 2021 06:59:32 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.253])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D8058B763;
        Fri, 15 Oct 2021 06:59:31 +0200 (CEST)
Subject: Re: [PATCH v2 02/13] powerpc: Rename 'funcaddr' to 'addr' in 'struct
 ppc64_opd_entry'
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
 <49f59a8bf2c4d95cfaa03bd3dd3c1569822ad6ba.1634190022.git.christophe.leroy@csgroup.eu>
 <877def46xc.fsf@dja-thinkpad.axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <6f1c3624-eef4-fc6c-9f2f-d649d8c93cdf@csgroup.eu>
Date:   Fri, 15 Oct 2021 06:59:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <877def46xc.fsf@dja-thinkpad.axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 14/10/2021 à 23:45, Daniel Axtens a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> There are three architectures with function descriptors, try to
>> have common names for the address they contain in order to
>> refactor some functions into generic functions later.
>>
>> powerpc has 'funcaddr'
>> ia64 has 'ip'
>> parisc has 'addr'
>>
>> Vote for 'addr' and update 'struct ppc64_opd_entry' accordingly.
> 
> I would have picked 'funcaddr', but at least 'addr' is better than 'ip'!
> And I agree that consistency, and then making things generic is worthwhile.

It's a function descriptor, there is only one address field, I don't 
think there is any ambiguïty here, and I prefer modifying the least 
impacted architectures.

Changing addr to funcaddr in PARISC would result in the following 
changes, on an architecture I know nothing about. It's more changes than 
we have on powerpc.

  arch/parisc/include/asm/elf.h |  4 ++--
  arch/parisc/kernel/kexec.c    |  2 +-
  arch/parisc/kernel/module.c   | 12 ++++++------
  arch/parisc/kernel/process.c  |  2 +-
  arch/parisc/kernel/signal.c   |  4 ++--
  5 files changed, 12 insertions(+), 12 deletions(-)



> 
> I grepped the latest powerpc/next for uses of 'funcaddr'. There were 5,
> your patch changes all 5.
> 
> The series passes build tests and this patch has no checkpatch or other
> style concerns.
> 
> On that basis:
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> 
> Kind regards,
> Daniel
> 
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/include/asm/elf.h      | 2 +-
>>   arch/powerpc/include/asm/sections.h | 2 +-
>>   arch/powerpc/kernel/module_64.c     | 6 +++---
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
>> index a4406714c060..bb0f278f9ed4 100644
>> --- a/arch/powerpc/include/asm/elf.h
>> +++ b/arch/powerpc/include/asm/elf.h
>> @@ -178,7 +178,7 @@ void relocate(unsigned long final_address);
>>   
>>   /* There's actually a third entry here, but it's unused */
>>   struct ppc64_opd_entry {
>> -	unsigned long funcaddr;
>> +	unsigned long addr;
>>   	unsigned long r2;
>>   };
>>   
>> diff --git a/arch/powerpc/include/asm/sections.h b/arch/powerpc/include/asm/sections.h
>> index 6e4af4492a14..32e7035863ac 100644
>> --- a/arch/powerpc/include/asm/sections.h
>> +++ b/arch/powerpc/include/asm/sections.h
>> @@ -77,7 +77,7 @@ static inline void *dereference_function_descriptor(void *ptr)
>>   	struct ppc64_opd_entry *desc = ptr;
>>   	void *p;
>>   
>> -	if (!get_kernel_nofault(p, (void *)&desc->funcaddr))
>> +	if (!get_kernel_nofault(p, (void *)&desc->addr))
>>   		ptr = p;
>>   	return ptr;
>>   }
>> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
>> index 6baa676e7cb6..82908c9be627 100644
>> --- a/arch/powerpc/kernel/module_64.c
>> +++ b/arch/powerpc/kernel/module_64.c
>> @@ -72,11 +72,11 @@ static func_desc_t func_desc(unsigned long addr)
>>   }
>>   static unsigned long func_addr(unsigned long addr)
>>   {
>> -	return func_desc(addr).funcaddr;
>> +	return func_desc(addr).addr;
>>   }
>>   static unsigned long stub_func_addr(func_desc_t func)
>>   {
>> -	return func.funcaddr;
>> +	return func.addr;
>>   }
>>   static unsigned int local_entry_offset(const Elf64_Sym *sym)
>>   {
>> @@ -187,7 +187,7 @@ static int relacmp(const void *_x, const void *_y)
>>   static unsigned long get_stubs_size(const Elf64_Ehdr *hdr,
>>   				    const Elf64_Shdr *sechdrs)
>>   {
>> -	/* One extra reloc so it's always 0-funcaddr terminated */
>> +	/* One extra reloc so it's always 0-addr terminated */
>>   	unsigned long relocs = 1;
>>   	unsigned i;
>>   
>> -- 
>> 2.31.1

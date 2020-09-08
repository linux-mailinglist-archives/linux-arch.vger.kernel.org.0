Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061B2260D53
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 10:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgIHIRc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 04:17:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:20076 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbgIHIRb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Sep 2020 04:17:31 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BlygQ2VM3z9tyfZ;
        Tue,  8 Sep 2020 10:17:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8E9ZAY1YbiyQ; Tue,  8 Sep 2020 10:17:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BlygQ1YKJz9tyfY;
        Tue,  8 Sep 2020 10:17:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B1BE8B7A1;
        Tue,  8 Sep 2020 10:17:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id k9FC2ZI-dL_g; Tue,  8 Sep 2020 10:17:23 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D4E3E8B768;
        Tue,  8 Sep 2020 10:17:20 +0200 (CEST)
Subject: Re: [RFC PATCH v2 2/3] mm: make pXd_addr_end() functions page-table
 entry aware
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
 <31dfb3ed-a0cc-3024-d389-ab9bd19e881f@csgroup.eu>
 <20200908074638.GA19099@oc3871087118.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5d4f5546-afd0-0b8f-664d-700ae346b9ec@csgroup.eu>
Date:   Tue, 8 Sep 2020 10:16:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908074638.GA19099@oc3871087118.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 08/09/2020 à 09:46, Alexander Gordeev a écrit :
> On Tue, Sep 08, 2020 at 07:14:38AM +0200, Christophe Leroy wrote:
>> You forgot arch/powerpc/mm/book3s64/subpage_prot.c it seems.
> 
> Yes, and also two more sources :/
> 	arch/powerpc/mm/kasan/8xx.c
> 	arch/powerpc/mm/kasan/kasan_init_32.c
> 
> But these two are not quite obvious wrt pgd_addr_end() used
> while traversing pmds. Could you please clarify a bit?
> 
> 
> diff --git a/arch/powerpc/mm/kasan/8xx.c b/arch/powerpc/mm/kasan/8xx.c
> index 2784224..89c5053 100644
> --- a/arch/powerpc/mm/kasan/8xx.c
> +++ b/arch/powerpc/mm/kasan/8xx.c
> @@ -15,8 +15,8 @@
>   	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd += 2, block += SZ_8M) {
>   		pte_basic_t *new;
>   
> -		k_next = pgd_addr_end(k_cur, k_end);
> -		k_next = pgd_addr_end(k_next, k_end);
> +		k_next = pmd_addr_end(k_cur, k_end);
> +		k_next = pmd_addr_end(k_next, k_end);

No, I don't think so.
On powerpc32 we have only two levels, so pgd and pmd are more or less 
the same.
But pmd_addr_end() as defined in include/asm-generic/pgtable-nopmd.h is 
a no-op, so I don't think it will work.

It is likely that this function should iterate on pgd, then you get pmd 
= pmd_offset(pud_offset(p4d_offset(pgd)));

>   		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
>   			continue;
>   
> diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/kasan_init_32.c
> index fb29404..3f7d6dc6 100644
> --- a/arch/powerpc/mm/kasan/kasan_init_32.c
> +++ b/arch/powerpc/mm/kasan/kasan_init_32.c
> @@ -38,7 +38,7 @@ int __init kasan_init_shadow_page_tables(unsigned long k_start, unsigned long k_
>   	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd++) {
>   		pte_t *new;
>   
> -		k_next = pgd_addr_end(k_cur, k_end);
> +		k_next = pmd_addr_end(k_cur, k_end);

Same here I get, iterate on pgd then get pmd = 
pmd_offset(pud_offset(p4d_offset(pgd)));

>   		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
>   			continue;
>   
> @@ -196,7 +196,7 @@ void __init kasan_early_init(void)
>   	kasan_populate_pte(kasan_early_shadow_pte, PAGE_KERNEL);
>   
>   	do {
> -		next = pgd_addr_end(addr, end);
> +		next = pmd_addr_end(addr, end);
>   		pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_pte);
>   	} while (pmd++, addr = next, addr != end);
>   
> 

Christophe

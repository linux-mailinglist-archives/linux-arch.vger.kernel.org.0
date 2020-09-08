Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76222609E4
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 07:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgIHFTu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 01:19:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8843 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgIHFTu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Sep 2020 01:19:50 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BltkT4qvvz9tyfH;
        Tue,  8 Sep 2020 07:19:45 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mF_Z1FlHMh_F; Tue,  8 Sep 2020 07:19:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BltkT3c0Rz9tyfG;
        Tue,  8 Sep 2020 07:19:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 48B608B793;
        Tue,  8 Sep 2020 07:19:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id G7-bMta_Fa-y; Tue,  8 Sep 2020 07:19:46 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B4918B768;
        Tue,  8 Sep 2020 07:19:44 +0200 (CEST)
Subject: Re: [RFC PATCH v2 3/3] mm: make generic pXd_addr_end() macros inline
 functions
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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
 <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4c101685-5b29-dace-9dd2-b6f0ae193a9c@csgroup.eu>
Date:   Tue, 8 Sep 2020 07:19:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 07/09/2020 à 20:00, Gerald Schaefer a écrit :
> From: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Since pXd_addr_end() macros take pXd page-table entry as a
> parameter it makes sense to check the entry type on compile.
> Even though most archs do not make use of page-table entries
> in pXd_addr_end() calls, checking the type in traversal code
> paths could help to avoid subtle bugs.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>   include/linux/pgtable.h | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 67ebc22cf83d..d9e7d16c2263 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -656,31 +656,35 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>    */
>   
>   #ifndef pgd_addr_end
> -#define pgd_addr_end(pgd, addr, end)					\
> -({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define pgd_addr_end pgd_addr_end

I think that #define is pointless, usually there is no such #define for 
the default case.

> +static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + PGDIR_SIZE) & PGDIR_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}

Please use the standard layout, ie entry { and exit } alone on their 
line, and space between local vars declaration and the rest.

Also remove the leading __ in front of var names as it's not needed once 
it is not macros anymore.

f_name()
{
	some_local_var;

	do_something();
}

>   #endif
>   
>   #ifndef p4d_addr_end
> -#define p4d_addr_end(p4d, addr, end)					\
> -({	unsigned long __boundary = ((addr) + P4D_SIZE) & P4D_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define p4d_addr_end p4d_addr_end
> +static inline unsigned long p4d_addr_end(p4d_t p4d, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + P4D_SIZE) & P4D_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>   #endif
>   
>   #ifndef pud_addr_end
> -#define pud_addr_end(pud, addr, end)					\
> -({	unsigned long __boundary = ((addr) + PUD_SIZE) & PUD_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define pud_addr_end pud_addr_end
> +static inline unsigned long pud_addr_end(pud_t pud, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + PUD_SIZE) & PUD_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>   #endif
>   
>   #ifndef pmd_addr_end
> -#define pmd_addr_end(pmd, addr, end)					\
> -({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define pmd_addr_end pmd_addr_end
> +static inline unsigned long pmd_addr_end(pmd_t pmd, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + PMD_SIZE) & PMD_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>   #endif
>   
>   /*
> 

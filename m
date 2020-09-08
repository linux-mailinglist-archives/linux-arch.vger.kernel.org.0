Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95EEF2609DE
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 07:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgIHFOw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 01:14:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1177 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgIHFOw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Sep 2020 01:14:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bltcl5vwGz9tyfC;
        Tue,  8 Sep 2020 07:14:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CHegWz2Zqd7i; Tue,  8 Sep 2020 07:14:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bltcl4S93z9tyfB;
        Tue,  8 Sep 2020 07:14:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FA238B78F;
        Tue,  8 Sep 2020 07:14:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id p7u0ZX_PNhu5; Tue,  8 Sep 2020 07:14:48 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E7EF18B768;
        Tue,  8 Sep 2020 07:14:45 +0200 (CEST)
Subject: Re: [RFC PATCH v2 2/3] mm: make pXd_addr_end() functions page-table
 entry aware
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
 <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <31dfb3ed-a0cc-3024-d389-ab9bd19e881f@csgroup.eu>
Date:   Tue, 8 Sep 2020 07:14:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
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
> Unlike all other page-table abstractions pXd_addr_end() do not take
> into account a particular table entry in which context the functions
> are called. On architectures with dynamic page-tables folding that
> might lead to lack of necessary information that is difficult to
> obtain other than from the table entry itself. That already led to
> a subtle memory corruption issue on s390.
> 
> By letting pXd_addr_end() functions know about the page-table entry
> we allow archs not only make extra checks, but also optimizations.
> 
> As result of this change the pXd_addr_end_folded() functions used
> in gup_fast traversal code become unnecessary and get replaced with
> universal pXd_addr_end() variants.
> 
> The arch-specific updates not only add dereferencing of page-table
> entry pointers, but also small changes to the code flow to make those
> dereferences possible, at least for x86 and powerpc. Also for arm64,
> but in way that should not have any impact.
> 

[...]

> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>   arch/arm/include/asm/pgtable-2level.h    |  2 +-
>   arch/arm/mm/idmap.c                      |  6 ++--
>   arch/arm/mm/mmu.c                        |  8 ++---
>   arch/arm64/kernel/hibernate.c            | 16 ++++++----
>   arch/arm64/kvm/mmu.c                     | 16 +++++-----
>   arch/arm64/mm/kasan_init.c               |  8 ++---
>   arch/arm64/mm/mmu.c                      | 25 +++++++--------
>   arch/powerpc/mm/book3s64/radix_pgtable.c |  7 ++---
>   arch/powerpc/mm/hugetlbpage.c            |  6 ++--

You forgot arch/powerpc/mm/book3s64/subpage_prot.c it seems.

>   arch/s390/include/asm/pgtable.h          |  8 ++---
>   arch/s390/mm/page-states.c               |  8 ++---
>   arch/s390/mm/pageattr.c                  |  8 ++---
>   arch/s390/mm/vmem.c                      |  8 ++---
>   arch/sparc/mm/hugetlbpage.c              |  6 ++--
>   arch/um/kernel/tlb.c                     |  8 ++---
>   arch/x86/mm/init_64.c                    | 15 ++++-----
>   arch/x86/mm/kasan_init_64.c              | 16 +++++-----
>   include/asm-generic/pgtable-nop4d.h      |  2 +-
>   include/asm-generic/pgtable-nopmd.h      |  2 +-
>   include/asm-generic/pgtable-nopud.h      |  2 +-
>   include/linux/pgtable.h                  | 26 ++++-----------
>   mm/gup.c                                 |  8 ++---
>   mm/ioremap.c                             |  8 ++---
>   mm/kasan/init.c                          | 17 +++++-----
>   mm/madvise.c                             |  4 +--
>   mm/memory.c                              | 40 ++++++++++++------------
>   mm/mlock.c                               | 18 ++++++++---
>   mm/mprotect.c                            |  8 ++---
>   mm/pagewalk.c                            |  8 ++---
>   mm/swapfile.c                            |  8 ++---
>   mm/vmalloc.c                             | 16 +++++-----
>   31 files changed, 165 insertions(+), 173 deletions(-)

Christophe

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2626056F
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 22:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgIGUNR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 16:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgIGUNP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Sep 2020 16:13:15 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30E5C21556;
        Mon,  7 Sep 2020 20:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599509594;
        bh=Txq0SHMAQgqfdmcGMkwaxwK8bh+LCMYp/KURZ2semt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLpipW8sQvLhlZFZtsFQwKo1Znbs/0KAcD4LFEfe7h7JTvYMqqR6v+seDpO4Yd/cu
         RrfBDF0lYv41owv1h519SaLJN7kE80eKoMCgi8/Hj0LT+ao5fgTb95OgH+il6wLukz
         qp6QPtSS/AB4nQIMNuSph4bC4G+E+gDc26AyDbdg=
Date:   Mon, 7 Sep 2020 23:12:56 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200907201256.GC1976319@kernel.org>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 07, 2020 at 08:00:55PM +0200, Gerald Schaefer wrote:
> This is v2 of an RFC previously discussed here:
> https://lore.kernel.org/lkml/20200828140314.8556-1-gerald.schaefer@linux.ibm.com/
> 
> Patch 1 is a fix for a regression in gup_fast on s390, after our conversion
> to common gup_fast code. It will introduce special helper functions
> pXd_addr_end_folded(), which have to be used in places where pagetable walk
> is done w/o lock and with READ_ONCE, so currently only in gup_fast.
> 
> Patch 2 is an attempt to make that more generic, i.e. change pXd_addr_end()
> themselves by adding an extra pXd value parameter. That was suggested by
> Jason during v1 discussion, because he is already thinking of some other
> places where he might want to switch to the READ_ONCE logic for pagetable
> walks. In general, that would be the cleanest / safest solution, but there
> is some impact on other architectures and common code, hence the new and
> greatly enlarged recipient list.
> 
> Patch 3 is a "nice to have" add-on, which makes pXd_addr_end() inline
> functions instead of #defines, so that we get some type checking for the
> new pXd value parameter.
> 
> Not sure about Fixes/stable tags for the generic solution. Only patch 1
> fixes a real bug on s390, and has Fixes/stable tags. Patches 2 + 3 might
> still be nice to have in stable, to ease future backports, but I guess
> "nice to have" does not really qualify for stable backports.

I also think that adding pXd parameter to pXd_addr_end() is a cleaner
way and with this patch 1 is not really required. I would even merge
patches 2 and 3 into a single patch and use only it as the fix.

[ /me apologises to stable@ team :-) ]

> Changes in v2:
> - Pick option 2 from v1 discussion (pXd_addr_end_folded helpers)
> - Add patch 2 + 3 for more generic approach
> 
> Alexander Gordeev (3):
>   mm/gup: fix gup_fast with dynamic page table folding
>   mm: make pXd_addr_end() functions page-table entry aware
>   mm: make generic pXd_addr_end() macros inline functions
> 
>  arch/arm/include/asm/pgtable-2level.h    |  2 +-
>  arch/arm/mm/idmap.c                      |  6 ++--
>  arch/arm/mm/mmu.c                        |  8 ++---
>  arch/arm64/kernel/hibernate.c            | 16 +++++----
>  arch/arm64/kvm/mmu.c                     | 16 ++++-----
>  arch/arm64/mm/kasan_init.c               |  8 ++---
>  arch/arm64/mm/mmu.c                      | 25 +++++++-------
>  arch/powerpc/mm/book3s64/radix_pgtable.c |  7 ++--
>  arch/powerpc/mm/hugetlbpage.c            |  6 ++--
>  arch/s390/include/asm/pgtable.h          | 42 ++++++++++++++++++++++++
>  arch/s390/mm/page-states.c               |  8 ++---
>  arch/s390/mm/pageattr.c                  |  8 ++---
>  arch/s390/mm/vmem.c                      |  8 ++---
>  arch/sparc/mm/hugetlbpage.c              |  6 ++--
>  arch/um/kernel/tlb.c                     |  8 ++---
>  arch/x86/mm/init_64.c                    | 15 ++++-----
>  arch/x86/mm/kasan_init_64.c              | 16 ++++-----
>  include/asm-generic/pgtable-nop4d.h      |  2 +-
>  include/asm-generic/pgtable-nopmd.h      |  2 +-
>  include/asm-generic/pgtable-nopud.h      |  2 +-
>  include/linux/pgtable.h                  | 38 ++++++++++++---------
>  mm/gup.c                                 |  8 ++---
>  mm/ioremap.c                             |  8 ++---
>  mm/kasan/init.c                          | 17 +++++-----
>  mm/madvise.c                             |  4 +--
>  mm/memory.c                              | 40 +++++++++++-----------
>  mm/mlock.c                               | 18 +++++++---
>  mm/mprotect.c                            |  8 ++---
>  mm/pagewalk.c                            |  8 ++---
>  mm/swapfile.c                            |  8 ++---
>  mm/vmalloc.c                             | 16 ++++-----
>  31 files changed, 219 insertions(+), 165 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

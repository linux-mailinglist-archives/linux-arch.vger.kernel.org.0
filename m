Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE48912B32
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 12:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfECKFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 May 2019 06:05:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57752 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbfECKFS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 May 2019 06:05:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3CB1374;
        Fri,  3 May 2019 03:05:16 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC463F557;
        Fri,  3 May 2019 03:05:11 -0700 (PDT)
Date:   Fri, 3 May 2019 11:05:09 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        nios2-dev@lists.rocketboards.org
Subject: Re: [PATCH 04/15] arm64: switch to generic version of pte allocation
Message-ID: <20190503100508.GB47811@lakrids.cambridge.arm.com>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-5-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556810922-20248-5-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Thu, May 02, 2019 at 06:28:31PM +0300, Mike Rapoport wrote:
> The PTE allocations in arm64 are identical to the generic ones modulo the
> GFP flags.
> 
> Using the generic pte_alloc_one() functions ensures that the user page
> tables are allocated with __GFP_ACCOUNT set.
> 
> The arm64 definition of PGALLOC_GFP is removed and replaced with
> GFP_PGTABLE_USER for p[gum]d_alloc_one() and for KVM memory cache.
> 
> The mappings created with create_pgd_mapping() are now using
> GFP_PGTABLE_KERNEL.
> 
> The conversion to the generic version of pte_free_kernel() removes the NULL
> check for pte.
> 
> The pte_free() version on arm64 is identical to the generic one and
> can be simply dropped.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/arm64/include/asm/pgalloc.h | 43 ++++------------------------------------
>  arch/arm64/mm/mmu.c              |  2 +-
>  arch/arm64/mm/pgd.c              |  4 ++--
>  virt/kvm/arm/mmu.c               |  2 +-
>  4 files changed, 8 insertions(+), 43 deletions(-)

[...]

> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> index 289f911..2ef1a53 100644
> --- a/arch/arm64/mm/pgd.c
> +++ b/arch/arm64/mm/pgd.c
> @@ -31,9 +31,9 @@ static struct kmem_cache *pgd_cache __ro_after_init;
>  pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
>  	if (PGD_SIZE == PAGE_SIZE)
> -		return (pgd_t *)__get_free_page(PGALLOC_GFP);
> +		return (pgd_t *)__get_free_page(GFP_PGTABLE_USER);
>  	else
> -		return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
> +		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_USER);
>  }

In efi_virtmap_init() we use pgd_alloc() to allocate a pgd for EFI
runtime services, which we map with a special kernel page table.

I'm not sure if accounting that is problematic, as it's allocated in a
kernel thread off the back of an early_initcall.

Just to check, Is that sound, or do we need a pgd_alloc_kernel()?

Thanks,
Mark.

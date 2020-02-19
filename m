Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190B81643EB
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 13:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgBSMH7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 07:07:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:63773 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgBSMH7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 07:07:59 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48MxLg3psQz9v9Dt;
        Wed, 19 Feb 2020 13:07:55 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XonlV0Z+; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AFyfJZVf4xTO; Wed, 19 Feb 2020 13:07:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48MxLg2Kzcz9v9Ds;
        Wed, 19 Feb 2020 13:07:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1582114075; bh=SUPm/xbOXqzg/7rTrLgpDJn6K3q1CABhJDtHqKqTUfA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XonlV0Z+kSYp9DXtpHiZkNHEHxFMw6PZijdFfIFeuIK/K+RCtqkXv0VtzGY+2wuZu
         xOicb9401xVMMs8rHDmTPmm6KlS2ffHsw+cSbAZdq3j0YAum02eQePHOFl9npiNl8S
         akY+ce7GONPJifLUkacYEEGeIusgoWWVvfKmbJes=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8CDA98B83F;
        Wed, 19 Feb 2020 13:07:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ix2R2LHOLPeo; Wed, 19 Feb 2020 13:07:56 +0100 (CET)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B4B6E8B837;
        Wed, 19 Feb 2020 13:07:55 +0100 (CET)
Subject: Re: [PATCH v2 07/13] powerpc: add support for folded p4d page tables
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20200216081843.28670-1-rppt@kernel.org>
 <20200216081843.28670-8-rppt@kernel.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5b7c3929-5833-8ceb-85c8-a8e92e6a138e@c-s.fr>
Date:   Wed, 19 Feb 2020 13:07:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200216081843.28670-8-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 16/02/2020 à 09:18, Mike Rapoport a écrit :
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # 8xx and 83xx
> ---
>   arch/powerpc/include/asm/book3s/32/pgtable.h  |  1 -
>   arch/powerpc/include/asm/book3s/64/hash.h     |  4 +-
>   arch/powerpc/include/asm/book3s/64/pgalloc.h  |  4 +-
>   arch/powerpc/include/asm/book3s/64/pgtable.h  | 58 ++++++++++--------
>   arch/powerpc/include/asm/book3s/64/radix.h    |  6 +-
>   arch/powerpc/include/asm/nohash/32/pgtable.h  |  1 -
>   arch/powerpc/include/asm/nohash/64/pgalloc.h  |  2 +-
>   .../include/asm/nohash/64/pgtable-4k.h        | 32 +++++-----
>   arch/powerpc/include/asm/nohash/64/pgtable.h  |  6 +-
>   arch/powerpc/include/asm/pgtable.h            |  8 +++
>   arch/powerpc/kvm/book3s_64_mmu_radix.c        | 59 ++++++++++++++++---
>   arch/powerpc/lib/code-patching.c              |  7 ++-
>   arch/powerpc/mm/book3s32/mmu.c                |  2 +-
>   arch/powerpc/mm/book3s32/tlb.c                |  4 +-
>   arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 +-
>   arch/powerpc/mm/book3s64/radix_pgtable.c      | 19 ++++--
>   arch/powerpc/mm/book3s64/subpage_prot.c       |  6 +-
>   arch/powerpc/mm/hugetlbpage.c                 | 28 +++++----
>   arch/powerpc/mm/kasan/kasan_init_32.c         |  8 +--
>   arch/powerpc/mm/mem.c                         |  4 +-
>   arch/powerpc/mm/nohash/40x.c                  |  4 +-
>   arch/powerpc/mm/nohash/book3e_pgtable.c       | 15 +++--
>   arch/powerpc/mm/pgtable.c                     | 25 +++++++-
>   arch/powerpc/mm/pgtable_32.c                  | 28 +++++----
>   arch/powerpc/mm/pgtable_64.c                  | 10 ++--
>   arch/powerpc/mm/ptdump/hashpagetable.c        | 20 ++++++-
>   arch/powerpc/mm/ptdump/ptdump.c               | 22 ++++++-
>   arch/powerpc/xmon/xmon.c                      | 17 +++++-
>   28 files changed, 284 insertions(+), 120 deletions(-)
> 
> diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> index 206156255247..7bd4b81d5b5d 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.c
> +++ b/arch/powerpc/mm/ptdump/ptdump.c
> @@ -277,9 +277,9 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
>   	}
>   }
>   
> -static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
> +static void walk_pud(struct pg_state *st, p4d_t *p4d, unsigned long start)
>   {
> -	pud_t *pud = pud_offset(pgd, 0);
> +	pud_t *pud = pud_offset(p4d, 0);
>   	unsigned long addr;
>   	unsigned int i;
>   
> @@ -293,6 +293,22 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
>   	}
>   }
>   
> +static void walk_p4d(struct pg_state *st, pgd_t *pgd, unsigned long start)
> +{
> +	p4d_t *p4d = p4d_offset(pgd, 0);
> +	unsigned long addr;
> +	unsigned int i;
> +
> +	for (i = 0; i < PTRS_PER_P4D; i++, p4d++) {
> +		addr = start + i * P4D_SIZE;
> +		if (!p4d_none(*p4d) && !p4d_is_leaf(*p4d))
> +			/* p4d exists */
> +			walk_pud(st, p4d, addr);
> +		else
> +			note_page(st, addr, 2, p4d_val(*p4d));

Level 2 is already used by walk_pud().

I think you have to increment the level used in walk_pud() and 
walk_pmd() and walk_pte()

> +	}
> +}
> +
>   static void walk_pagetables(struct pg_state *st)
>   {
>   	unsigned int i;
> @@ -306,7 +322,7 @@ static void walk_pagetables(struct pg_state *st)
>   	for (i = pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
>   		if (!pgd_none(*pgd) && !pgd_is_leaf(*pgd))
>   			/* pgd exists */
> -			walk_pud(st, pgd, addr);
> +			walk_p4d(st, pgd, addr);
>   		else
>   			note_page(st, addr, 1, pgd_val(*pgd));
>   	}

Christophe

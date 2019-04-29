Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2FE6A0
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2019 17:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfD2Pf5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Apr 2019 11:35:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39727 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfD2Pf5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Apr 2019 11:35:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 44t7z96kGcz9vD31;
        Mon, 29 Apr 2019 17:35:49 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Q5o3w0VV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id kbO7e4z3Oado; Mon, 29 Apr 2019 17:35:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 44t7z95Zr4z9vD30;
        Mon, 29 Apr 2019 17:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1556552149; bh=XXe83/pZb9AFMZAVXoUoxnryoMR8eaO+qKHpnqnFOB8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Q5o3w0VVtDkuaQJ720CrXVg1D1EEff1tyfslomh/gdc4+yk1/Dkug0ZmjOpliak9E
         SNq24Cb/75QU4Vbo8GkPeMa5ZqrlcCuuxHVxWzptG/UbSIeVfGgHzF9GoK962b/vuv
         2GQOk16RVxWf7DSmpu538h1my8dNOApiD0oga2ow=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EDA2C8B8B4;
        Mon, 29 Apr 2019 17:35:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P3bLUxeO-Wfq; Mon, 29 Apr 2019 17:35:54 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AEE718B8B3;
        Mon, 29 Apr 2019 17:35:54 +0200 (CEST)
Subject: Re: [RESEND PATCH v3 09/11] powerpc/mm/radix: mark
 __radix__flush_tlb_range_psize() as __always_inline
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Mathieu Malaterre <malat@debian.org>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-10-yamada.masahiro@socionext.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <40b48947-b80e-7971-376d-52b594e26d17@c-s.fr>
Date:   Mon, 29 Apr 2019 17:35:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423034959.13525-10-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 23/04/2019 à 05:49, Masahiro Yamada a écrit :
> This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> place. We need to eliminate potential issues beforehand.

How did you identify the functions requiring __always_inline as this one 
? Just by 'test and see if it fails', or did you have some script or so ?

Here the problem is that one of the parameters of the function are used 
as "immediate" constraint for the inline assembly, therefore requiring 
the function to always be inline.

I guess this should be explained in the commit log and I'm wondering how 
you ensure that you did identify all functions like this.

Christophe

> 
> If it is enabled for powerpc, the following error is reported:
> 
> arch/powerpc/mm/tlb-radix.c: In function '__radix__flush_tlb_range_psize':
> arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't match constraints [-Werror]
>    asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>    ^~~
> arch/powerpc/mm/tlb-radix.c:104:2: error: impossible constraint in 'asm'
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
>    - split into a separate patch
> 
>   arch/powerpc/mm/tlb-radix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 6a23b9ebd2a1..a2b2848f0ae3 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -928,7 +928,7 @@ void radix__tlb_flush(struct mmu_gather *tlb)
>   	tlb->need_flush_all = 0;
>   }
>   
> -static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
> +static __always_inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
>   				unsigned long start, unsigned long end,
>   				int psize, bool also_pwc)
>   {
> 

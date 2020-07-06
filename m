Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4936D215506
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 11:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgGFJxX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 05:53:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56862 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgGFJxX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jul 2020 05:53:23 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4B0gqY2RjZz9tyqs;
        Mon,  6 Jul 2020 11:53:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XzUCMcJxLDBR; Mon,  6 Jul 2020 11:53:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4B0gqY1TY9z9tyqj;
        Mon,  6 Jul 2020 11:53:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4CF2F8B7A4;
        Mon,  6 Jul 2020 11:53:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id C4o_KNoywjMz; Mon,  6 Jul 2020 11:53:19 +0200 (CEST)
Received: from [172.25.230.105] (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D0498B798;
        Mon,  6 Jul 2020 11:53:17 +0200 (CEST)
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-arch@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20200706021822.1515189-1-npiggin@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
Date:   Mon, 6 Jul 2020 11:53:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706021822.1515189-1-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 06/07/2020 à 04:18, Nicholas Piggin a écrit :
> powerpc return from interrupt and return from system call sequences are
> context synchronising.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   .../features/sched/membarrier-sync-core/arch-support.txt      | 4 ++--
>   arch/powerpc/Kconfig                                          | 1 +
>   arch/powerpc/include/asm/exception-64s.h                      | 4 ++++
>   3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> index 8a521a622966..52ad74a25f54 100644
> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -5,7 +5,7 @@
>   #
>   # Architecture requirements
>   #
> -# * arm/arm64
> +# * arm/arm64/powerpc
>   #
>   # Rely on implicit context synchronization as a result of exception return
>   # when returning from IPI handler, and when returning to user-space.
> @@ -45,7 +45,7 @@
>       |       nios2: | TODO |
>       |    openrisc: | TODO |
>       |      parisc: | TODO |
> -    |     powerpc: | TODO |
> +    |     powerpc: |  ok  |
>       |       riscv: | TODO |
>       |        s390: | TODO |
>       |          sh: | TODO |
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9fa23eb320ff..920c4e3ca4ef 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -131,6 +131,7 @@ config PPC
>   	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_MEMBARRIER_CALLBACKS
> +	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>   	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
>   	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
>   	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 47bd4ea0837d..b88cb3a989b6 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -68,6 +68,10 @@
>    *
>    * The nop instructions allow us to insert one or more instructions to flush the
>    * L1-D cache when returning to userspace or a guest.
> + *
> + * powerpc relies on return from interrupt/syscall being context synchronising
> + * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SYNC_CORE
> + * without additional additional synchronisation instructions.

This file is dedicated to BOOK3S/64. What about other ones ?

On 32 bits, this is also valid as 'rfi' is also context synchronising, 
but then why just add some comment in exception-64s.h and only there ?

>    */
>   #define RFI_FLUSH_SLOT							\
>   	RFI_FLUSH_FIXUP_SECTION;					\
> 


Christophe

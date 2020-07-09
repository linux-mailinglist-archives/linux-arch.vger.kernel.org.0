Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772DA219D88
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 12:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgGIKSL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 06:18:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48913 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgGIKSL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 06:18:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B2XDx5w9fz9sSd;
        Thu,  9 Jul 2020 20:18:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594289889;
        bh=ou5GvH7X+W5XkenHcVbChXPfY+zWQZQPug6Gv9qz3HE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Vq+WB38V5Vr/85nXNhGqpqupy+34Vv3WSzVEQwoNCfqjMOzALtdReOZo98sRNdF4v
         sGsRiBQZQRt9C10DozPjdUV+RVnAD+xtRpukIAyztq9aHvkQ7/XJdsPUAl3LuHK+wj
         I+iQuTB21OEn2hVajUA+VVaiYzvot5nUEtDX3PWAK0rNKp94aOfUACCnwCPfDJHTD/
         KdBs6WLMY5gzQ3OaXS2KwOuuu+1z1BuTcE9hZDf/FSr1zbkU2zqJX99Vfvgk6YPtuA
         Jd7OYgdjaDbdWZq1nwUULVHLrRzs0jKC70v2D3AgBk59KBxHS6YKhIhksR5MJn+pvZ
         8f7eEgvbfiJuA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 4/6] powerpc/64s: implement queued spinlocks and rwlocks
In-Reply-To: <20200706043540.1563616-5-npiggin@gmail.com>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-5-npiggin@gmail.com>
Date:   Thu, 09 Jul 2020 20:20:25 +1000
Message-ID: <877dvdvvkm.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> These have shown significantly improved performance and fairness when
> spinlock contention is moderate to high on very large systems.
>
>  [ Numbers hopefully forthcoming after more testing, but initial
>    results look good ]

Would be good to have something here, even if it's preliminary.

> Thanks to the fast path, single threaded performance is not noticably
> hurt.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/Kconfig                      | 13 ++++++++++++
>  arch/powerpc/include/asm/Kbuild           |  2 ++
>  arch/powerpc/include/asm/qspinlock.h      | 25 +++++++++++++++++++++++
>  arch/powerpc/include/asm/spinlock.h       |  5 +++++
>  arch/powerpc/include/asm/spinlock_types.h |  5 +++++
>  arch/powerpc/lib/Makefile                 |  3 +++

>  include/asm-generic/qspinlock.h           |  2 ++

Who's ack do we need for that part?

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 24ac85c868db..17663ea57697 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -492,6 +494,17 @@ config HOTPLUG_CPU
>  
>  	  Say N if you are unsure.
>  
> +config PPC_QUEUED_SPINLOCKS
> +	bool "Queued spinlocks"
> +	depends on SMP
> +	default "y" if PPC_BOOK3S_64

Not sure about default y? At least until we've got a better idea of the
perf impact on a range of small/big new/old systems.

> +	help
> +	  Say Y here to use to use queued spinlocks which are more complex
> +	  but give better salability and fairness on large SMP and NUMA
> +	  systems.
> +
> +	  If unsure, say "Y" if you have lots of cores, otherwise "N".

Would be nice if we could give a range for "lots".

> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index dadbcf3a0b1e..1dd8b6adff5e 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -6,5 +6,7 @@ generated-y += syscall_table_spu.h
>  generic-y += export.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> +generic-y += qrwlock.h
> +generic-y += qspinlock.h

The 2nd line spits a warning about a redundant entry. I think you want
to just drop it.


cheers

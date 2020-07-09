Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58C219E36
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGIKvG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 06:51:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34817 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGIKvG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 06:51:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B2Xyv3zTwz9sQt;
        Thu,  9 Jul 2020 20:51:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594291864;
        bh=VI4aFN/tvbsGFEJ4xA4/0VeUoMRZZnfq/gpr3pAx8G0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IKD2ten4BhzVwExubvn3K93mtWqnC3WWAZoRzc+c3H8YbG4WdsqsYIsWtHE7Mr0GH
         nGpjcBK6Dan3kZ/RMkJ8HleBBVOarl2j8GlhAGagpMFmLzOUokO9woJyZe4KB9Tvwf
         0gHMuKiiBQ3KcLbW84Ee0saFgPCykKlyofIbboYWIBK9RSlMTJJFeFiEwRu+zC4apq
         bE4ngiBaxW+gJCjWBfPK2R/oK0LL8F7QhMQriTR0TsdOezFACf1z9JYBLvElvotO+B
         y9apR0IOzs3WlCA9v8OvGe3t3FZaAfE4Haq+4aFUFiz6O2rlfWYCuDwrQiPGASWc69
         zr4ZnuPJOXulA==
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
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for SPLPAR
In-Reply-To: <20200706043540.1563616-6-npiggin@gmail.com>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-6-npiggin@gmail.com>
Date:   Thu, 09 Jul 2020 20:53:16 +1000
Message-ID: <874kqhvu1v.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/paravirt.h           | 28 ++++++++
>  arch/powerpc/include/asm/qspinlock.h          | 66 +++++++++++++++++++
>  arch/powerpc/include/asm/qspinlock_paravirt.h |  7 ++
>  arch/powerpc/platforms/pseries/Kconfig        |  5 ++
>  arch/powerpc/platforms/pseries/setup.c        |  6 +-
>  include/asm-generic/qspinlock.h               |  2 +

Another ack?

> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
> index 7a8546660a63..f2d51f929cf5 100644
> --- a/arch/powerpc/include/asm/paravirt.h
> +++ b/arch/powerpc/include/asm/paravirt.h
> @@ -45,6 +55,19 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
>  {
>  	___bad_yield_to_preempted(); /* This would be a bug */
>  }
> +
> +extern void ___bad_yield_to_any(void);
> +static inline void yield_to_any(void)
> +{
> +	___bad_yield_to_any(); /* This would be a bug */
> +}

Why do we do that rather than just not defining yield_to_any() at all
and letting the build fail on that?

There's a condition somewhere that we know will false at compile time
and drop the call before linking?

> diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
> new file mode 100644
> index 000000000000..750d1b5e0202
> --- /dev/null
> +++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __ASM_QSPINLOCK_PARAVIRT_H
> +#define __ASM_QSPINLOCK_PARAVIRT_H

_ASM_POWERPC_QSPINLOCK_PARAVIRT_H please.

> +
> +EXPORT_SYMBOL(__pv_queued_spin_unlock);

Why's that in a header? Should that (eventually) go with the generic implementation?

> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index 24c18362e5ea..756e727b383f 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -25,9 +25,14 @@ config PPC_PSERIES
>  	select SWIOTLB
>  	default y
>  
> +config PARAVIRT_SPINLOCKS
> +	bool
> +	default n

default n is the default.

> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 2db8469e475f..747a203d9453 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -771,8 +771,12 @@ static void __init pSeries_setup_arch(void)
>  	if (firmware_has_feature(FW_FEATURE_LPAR)) {
>  		vpa_init(boot_cpuid);
>  
> -		if (lppaca_shared_proc(get_lppaca()))
> +		if (lppaca_shared_proc(get_lppaca())) {
>  			static_branch_enable(&shared_processor);
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +			pv_spinlocks_init();
> +#endif
> +		}

We could avoid the ifdef with this I think?

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 434615f1d761..6ec72282888d 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -10,5 +10,9 @@
 #include <asm/simple_spinlock.h>
 #endif

+#ifndef CONFIG_PARAVIRT_SPINLOCKS
+static inline void pv_spinlocks_init(void) { }
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SPINLOCK_H */


cheers

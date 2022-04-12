Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D924FCEE6
	for <lists+linux-arch@lfdr.de>; Tue, 12 Apr 2022 07:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbiDLFXn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 01:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344061AbiDLFXm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 01:23:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A106C21E2D;
        Mon, 11 Apr 2022 22:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E669B8170E;
        Tue, 12 Apr 2022 05:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D328C385A8;
        Tue, 12 Apr 2022 05:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649740883;
        bh=Hk0JupZmK+77hh8DcViQmBEiAoyyeTBt5VKHZR/+NK0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oQKnwwDckO97+u/W2uqap49q2MLWlFTfM/9IGt2IYYfN7v3tyw0p/j0FoDul6tVU1
         yNq9V2gVwCjYaD2qsTr0+ER0OZ7KfUeipAQV74lMEnsy/FNSl5BfIX4+zWx1mr3+5O
         co7lCmRTJUUK9/wiIxA7WJVILvhGYfIymaT/REuzN76yO7kpy1zFe4cQz3LRVVnkdG
         n/yQePdp8zuSBZ72dXtLINl37KPkpciFtBcE6qNgBpcGv94mQaHp05OcvmbZkhrcfE
         nmfV/xpzQJVHTM8+B/k6OEmr3SMpYQLYg0/yE1IV4NCtT27oCx/UDcwZBXXJumDz7h
         Xascn0LVWh51A==
Received: by mail-ua1-f52.google.com with SMTP id i26so7862514uap.6;
        Mon, 11 Apr 2022 22:21:22 -0700 (PDT)
X-Gm-Message-State: AOAM533ATBAx1w4N4Z3M18qiSy3f1MbmEs2CbSWOa9M3ni1Uka+Zepfh
        oDkO5bbhB/wZoFpGrV1+BtX5AY5U+WMf5+mr0l0=
X-Google-Smtp-Source: ABdhPJxYdjWWLlNY1l74RL1kKccV0tyPKJ7/b6vMQm1sKOIlwB2yiNIALpaFXGAE5NSilAPXH/lnKbG7yOflsesJbHE=
X-Received: by 2002:ab0:375b:0:b0:355:c2b3:f6c with SMTP id
 i27-20020ab0375b000000b00355c2b30f6cmr865007uat.84.1649740882036; Mon, 11 Apr
 2022 22:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220411145146.920314-1-guoren@kernel.org> <20220411145146.920314-3-guoren@kernel.org>
In-Reply-To: <20220411145146.920314-3-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 12 Apr 2022 13:21:10 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSJi3a7CEUzTwofP3dwFiD1+LssM6xy-uFDqOczGByd+A@mail.gmail.com>
Message-ID: <CAJF2gTSJi3a7CEUzTwofP3dwFiD1+LssM6xy-uFDqOczGByd+A@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] csky: atomic: Add custom atomic.h implementation
To:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 11, 2022 at 10:52 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The generic atomic.h used cmpxchg to implement the atomic
> operations, it will cause daul loop to reduce the forward
> guarantee. The patch implement csky custom atomic operations with
> ldex/stex instructions for the best performance.
>
> Important reference comment by Rutland:
> 8e86f0b409a4 ("arm64: atomics: fix use of acquire + release for
> full barrier semantics")
>
> Link: https://lore.kernel.org/linux-riscv/CAJF2gTSAxpAi=LbAdu7jntZRUa=-dJwL0VfmDfBV5MHB=rcZ-w@mail.gmail.com/T/#m27a0f1342995deae49ce1d0e1f2683f8a181d6c3
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
> Changes in V2:
>  - Fixup use of acquire + release for barrier semantics by Rutland.
> ---
>  arch/csky/include/asm/atomic.h | 130 +++++++++++++++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 arch/csky/include/asm/atomic.h
>
> diff --git a/arch/csky/include/asm/atomic.h b/arch/csky/include/asm/atomic.h
> new file mode 100644
> index 000000000000..2e1a22f55ea1
> --- /dev/null
> +++ b/arch/csky/include/asm/atomic.h
> @@ -0,0 +1,130 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_CSKY_ATOMIC_H
> +#define __ASM_CSKY_ATOMIC_H
> +
> +#ifdef CONFIG_SMP
> +# include <asm-generic/atomic64.h>
> +
> +#include <asm/cmpxchg.h>
> +#include <asm/barrier.h>
> +
> +#define __atomic_acquire_fence()       __smp_acquire_fence()
> +
> +#define __atomic_release_fence()       __smp_release_fence()
> +
> +static __always_inline int arch_atomic_read(const atomic_t *v)
> +{
> +       return READ_ONCE(v->counter);
> +}
> +static __always_inline void arch_atomic_set(atomic_t *v, int i)
> +{
> +       WRITE_ONCE(v->counter, i);
> +}
> +
> +#define ATOMIC_OP(op, asm_op, I)                                       \
> +static __always_inline                                                 \
> +void arch_atomic_##op(int i, atomic_t *v)                              \
> +{                                                                      \
> +       unsigned long tmp;                                              \
> +       __asm__ __volatile__ (                                          \
> +       "1:     ldex.w          %0, (%2)        \n"                     \
> +       "       " #op "         %0, %1          \n"                     \
> +       "       stex.w          %0, (%2)        \n"                     \
> +       "       bez             %0, 1b          \n"                     \
> +       : "=&r" (tmp)                                                   \
> +       : "r" (I), "r" (&v->counter)                                    \
> +       : "memory");                                                    \
> +}
> +
> +ATOMIC_OP(add, add,  i)
> +ATOMIC_OP(sub, add, -i)
> +ATOMIC_OP(and, and,  i)
> +ATOMIC_OP( or,  or,  i)
> +ATOMIC_OP(xor, xor,  i)
Sorry, it should be fixed up by:

#define ATOMIC_OP(op)                                                   \
static __always_inline                                                  \
void arch_atomic_##op(int i, atomic_t *v)                               \
{                                                                       \
        unsigned long tmp;                                              \
        __asm__ __volatile__ (                                          \
        "1:     ldex.w          %0, (%2)        \n"                     \
        "       " #op "         %0, %1          \n"                     \
        "       stex.w          %0, (%2)        \n"                     \
        "       bez             %0, 1b          \n"                     \
        : "=&r" (tmp)                                                   \
        : "r" (i), "r" (&v->counter)                                    \
        : "memory");                                                    \
}

ATOMIC_OP(add)
ATOMIC_OP(sub)
ATOMIC_OP(and)
ATOMIC_OP( or)
ATOMIC_OP(xor)


> +
> +#undef ATOMIC_OP
> +
> +#define ATOMIC_FETCH_OP(op, asm_op, I)                                 \
> +static __always_inline                                                 \
> +int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)               \
> +{                                                                      \
> +       register int ret, tmp;                                          \
> +       __asm__ __volatile__ (                                          \
> +       "1:     ldex.w          %0, (%3) \n"                            \
> +       "       mov             %1, %0   \n"                            \
> +       "       " #op "         %0, %2   \n"                            \
> +       "       stex.w          %0, (%3) \n"                            \
> +       "       bez             %0, 1b   \n"                            \
> +               : "=&r" (tmp), "=&r" (ret)                              \
> +               : "r" (I), "r"(&v->counter)                             \
> +               : "memory");                                            \
> +       return ret;                                                     \
> +}
> +
> +#define ATOMIC_OP_RETURN(op, asm_op, c_op, I)                          \
> +static __always_inline                                                 \
> +int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)              \
> +{                                                                      \
> +        return arch_atomic_fetch_##op##_relaxed(i, v) c_op I;          \
> +}
> +
> +#define ATOMIC_OPS(op, asm_op, c_op, I)                                        \
> +        ATOMIC_FETCH_OP( op, asm_op,       I)                          \
> +        ATOMIC_OP_RETURN(op, asm_op, c_op, I)
> +
> +ATOMIC_OPS(add, add, +,  i)
> +ATOMIC_OPS(sub, add, +, -i)
> +
> +#define arch_atomic_fetch_add_relaxed  arch_atomic_fetch_add_relaxed
> +#define arch_atomic_fetch_sub_relaxed  arch_atomic_fetch_sub_relaxed
> +
> +#define arch_atomic_add_return_relaxed arch_atomic_add_return_relaxed
> +#define arch_atomic_sub_return_relaxed arch_atomic_sub_return_relaxed
> +
> +#undef ATOMIC_OPS
> +#undef ATOMIC_OP_RETURN
> +
> +#define ATOMIC_OPS(op, asm_op, I)                                      \
> +        ATOMIC_FETCH_OP(op, asm_op, I)
> +
> +ATOMIC_OPS(and, and, i)
> +ATOMIC_OPS( or,  or, i)
> +ATOMIC_OPS(xor, xor, i)
> +
> +#define arch_atomic_fetch_and_relaxed  arch_atomic_fetch_and_relaxed
> +#define arch_atomic_fetch_or_relaxed   arch_atomic_fetch_or_relaxed
> +#define arch_atomic_fetch_xor_relaxed  arch_atomic_fetch_xor_relaxed
> +
> +#undef ATOMIC_OPS
> +
> +#undef ATOMIC_FETCH_OP
> +
> +#define ATOMIC_OP()                                                    \
> +static __always_inline                                                 \
> +int arch_atomic_xchg_relaxed(atomic_t *v, int n)                       \
> +{                                                                      \
> +       return __xchg_relaxed(n, &(v->counter), 4);                     \
> +}                                                                      \
> +static __always_inline                                                 \
> +int arch_atomic_cmpxchg_relaxed(atomic_t *v, int o, int n)             \
> +{                                                                      \
> +       return __cmpxchg_relaxed(&(v->counter), o, n, 4);               \
> +}
> +
> +#define ATOMIC_OPS()                                                   \
> +       ATOMIC_OP()
> +
> +ATOMIC_OPS()
> +
> +#define arch_atomic_xchg_relaxed       arch_atomic_xchg_relaxed
> +#define arch_atomic_cmpxchg_relaxed    arch_atomic_cmpxchg_relaxed
> +
> +#undef ATOMIC_OPS
> +#undef ATOMIC_OP
> +
> +#else
> +# include <asm-generic/atomic.h>
> +#endif
> +
> +#endif /* __ASM_CSKY_ATOMIC_H */
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

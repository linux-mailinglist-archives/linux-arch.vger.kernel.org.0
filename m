Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A204F50AE92
	for <lists+linux-arch@lfdr.de>; Fri, 22 Apr 2022 05:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443788AbiDVDqL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 23:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDVDqK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 23:46:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C314D61A;
        Thu, 21 Apr 2022 20:43:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B50EB828CB;
        Fri, 22 Apr 2022 03:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB35C385A7;
        Fri, 22 Apr 2022 03:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650598995;
        bh=7uYhOc0+kMiTbpE+8vQhFWCmnKskiiNfOUCZex/874Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FCFakF/83od49heeKq5w6doNeS8OKwTDk0jI7NYVMZQaUGAERv3GgAbKrQWzvDmtv
         3pr3W7w8fxIR9HmCSGyQSgOtcmmnNiatraRIMDyLuBhXXjN415qtx2waB6CcujleuI
         DODcPpwciF/5D+K3LKDG3DIyDzLkjtBHqVVfFziBH5kSmYpccSdBrU80hSxgEGZxkA
         fN2RREN3xKPgGxBjXzgN5Px0wjV+yjy+s5wq9cBdbMHEXcHzMvlsZ/LNzZ9tCD5//A
         KqOcwT2XVvLe6LmPxc0xMNkmc6hsIO/he6p26uwupiYqjMML9stQlAUIhit+BBgGnn
         J7kiMOu95hMXQ==
Received: by mail-vk1-f172.google.com with SMTP id w128so3249108vkd.3;
        Thu, 21 Apr 2022 20:43:15 -0700 (PDT)
X-Gm-Message-State: AOAM530f/kGgYOx6BO0m32/As+1I5M9ftfSR6NDO03AyxZRYvtjIXo/Y
        2n8IoOfaWwRK7XVv7ah2Fb8Ik7b1VrGAMYM6nVg=
X-Google-Smtp-Source: ABdhPJzhI8CsgdOCTQD/ey0dW8b4hivF1LJiWL8gAyT0Xo3epmg5BxsRXA3DudyhHHdWvvfvfFzF0/j6H/tbr65ishA=
X-Received: by 2002:a1f:2387:0:b0:345:23ac:a503 with SMTP id
 j129-20020a1f2387000000b0034523aca503mr800292vkj.28.1650598994153; Thu, 21
 Apr 2022 20:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220420144417.2453958-1-guoren@kernel.org> <20220420144417.2453958-3-guoren@kernel.org>
In-Reply-To: <20220420144417.2453958-3-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 22 Apr 2022 11:43:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSY18boHNLzGK-oGoeue1PkH5m6DZeCX_mx1D9G3W72Ag@mail.gmail.com>
Message-ID: <CAJF2gTSY18boHNLzGK-oGoeue1PkH5m6DZeCX_mx1D9G3W72Ag@mail.gmail.com>
Subject: Re: [PATCH V3 2/5] riscv: atomic: Optimize acquire and release for
 AMO operations
To:     Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ping Boqun & Daniel & Andrea,

Have you any comments on the patch? This revert 0123f4d76ca6
("riscv/spinlock: Strengthen implementations with fences").

But I think it's considerable because reducing the fence would gain
benefits in performance in our hardware.

In RISC-V ISA manual
     - .aq:   If the aq bit is set, then no later memory operations
              in this RISC-V hart can be observed to take place
              before the AMO.
     - .rl:   If the rl bit is set, then other RISC-V harts will not
              observe the AMO before memory accesses preceding the
              AMO in this RISC-V hart.
     - .aqrl: Setting both the aq and the rl bit on an AMO makes the
              sequence sequentially consistent, meaning that it cannot
              be reordered with earlier or later memory operations
              from the same hart.
On Wed, Apr 20, 2022 at 10:44 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Current acquire & release implementations from atomic-arch-
> fallback.h are using __atomic_acquire/release_fence(), it cause
> another extra "fence r, rw/fence rw,w" instruction after/before
> AMO instruction. RISC-V AMO instructions could combine acquire
> and release in the instruction self which could reduce a fence
> instruction. Here is from RISC-V ISA 10.4 Atomic Memory
> Operations:
>
> To help implement multiprocessor synchronization, the AMOs
> optionally provide release consistency semantics.
>  - .aq:   If the aq bit is set, then no later memory operations
>           in this RISC-V hart can be observed to take place
>           before the AMO.
>  - .rl:   If the rl bit is set, then other RISC-V harts will not
>           observe the AMO before memory accesses preceding the
>           AMO in this RISC-V hart.
>  - .aqrl: Setting both the aq and the rl bit on an AMO makes the
>           sequence sequentially consistent, meaning that it cannot
>           be reordered with earlier or later memory operations
>           from the same hart.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Dan Lustig <dlustig@nvidia.com>
> ---
>  arch/riscv/include/asm/atomic.h  | 64 ++++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/cmpxchg.h | 12 ++----
>  2 files changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> index ac9bdf4fc404..20ce8b83bc18 100644
> --- a/arch/riscv/include/asm/atomic.h
> +++ b/arch/riscv/include/asm/atomic.h
> @@ -99,6 +99,30 @@ c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,          \
>         return ret;                                                     \
>  }                                                                      \
>  static __always_inline                                                 \
> +c_type arch_atomic##prefix##_fetch_##op##_acquire(c_type i,            \
> +                                            atomic##prefix##_t *v)     \
> +{                                                                      \
> +       register c_type ret;                                            \
> +       __asm__ __volatile__ (                                          \
> +               "       amo" #asm_op "." #asm_type ".aq %1, %2, %0"     \
> +               : "+A" (v->counter), "=r" (ret)                         \
> +               : "r" (I)                                               \
> +               : "memory");                                            \
> +       return ret;                                                     \
> +}                                                                      \
> +static __always_inline                                                 \
> +c_type arch_atomic##prefix##_fetch_##op##_release(c_type i,            \
> +                                            atomic##prefix##_t *v)     \
> +{                                                                      \
> +       register c_type ret;                                            \
> +       __asm__ __volatile__ (                                          \
> +               "       amo" #asm_op "." #asm_type ".rl %1, %2, %0"     \
> +               : "+A" (v->counter), "=r" (ret)                         \
> +               : "r" (I)                                               \
> +               : "memory");                                            \
> +       return ret;                                                     \
> +}                                                                      \
> +static __always_inline                                                 \
>  c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)       \
>  {                                                                      \
>         register c_type ret;                                            \
> @@ -118,6 +142,18 @@ c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,               \
>          return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;        \
>  }                                                                      \
>  static __always_inline                                                 \
> +c_type arch_atomic##prefix##_##op##_return_acquire(c_type i,           \
> +                                             atomic##prefix##_t *v)    \
> +{                                                                      \
> +        return arch_atomic##prefix##_fetch_##op##_acquire(i, v) c_op I;        \
> +}                                                                      \
> +static __always_inline                                                 \
> +c_type arch_atomic##prefix##_##op##_return_release(c_type i,           \
> +                                             atomic##prefix##_t *v)    \
> +{                                                                      \
> +        return arch_atomic##prefix##_fetch_##op##_release(i, v) c_op I;        \
> +}                                                                      \
> +static __always_inline                                                 \
>  c_type arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)    \
>  {                                                                      \
>          return arch_atomic##prefix##_fetch_##op(i, v) c_op I;          \
> @@ -140,22 +176,38 @@ ATOMIC_OPS(sub, add, +, -i)
>
>  #define arch_atomic_add_return_relaxed arch_atomic_add_return_relaxed
>  #define arch_atomic_sub_return_relaxed arch_atomic_sub_return_relaxed
> +#define arch_atomic_add_return_acquire arch_atomic_add_return_acquire
> +#define arch_atomic_sub_return_acquire arch_atomic_sub_return_acquire
> +#define arch_atomic_add_return_release arch_atomic_add_return_release
> +#define arch_atomic_sub_return_release arch_atomic_sub_return_release
>  #define arch_atomic_add_return         arch_atomic_add_return
>  #define arch_atomic_sub_return         arch_atomic_sub_return
>
>  #define arch_atomic_fetch_add_relaxed  arch_atomic_fetch_add_relaxed
>  #define arch_atomic_fetch_sub_relaxed  arch_atomic_fetch_sub_relaxed
> +#define arch_atomic_fetch_add_acquire  arch_atomic_fetch_add_acquire
> +#define arch_atomic_fetch_sub_acquire  arch_atomic_fetch_sub_acquire
> +#define arch_atomic_fetch_add_release  arch_atomic_fetch_add_release
> +#define arch_atomic_fetch_sub_release  arch_atomic_fetch_sub_release
>  #define arch_atomic_fetch_add          arch_atomic_fetch_add
>  #define arch_atomic_fetch_sub          arch_atomic_fetch_sub
>
>  #ifndef CONFIG_GENERIC_ATOMIC64
>  #define arch_atomic64_add_return_relaxed       arch_atomic64_add_return_relaxed
>  #define arch_atomic64_sub_return_relaxed       arch_atomic64_sub_return_relaxed
> +#define arch_atomic64_add_return_acquire       arch_atomic64_add_return_acquire
> +#define arch_atomic64_sub_return_acquire       arch_atomic64_sub_return_acquire
> +#define arch_atomic64_add_return_release       arch_atomic64_add_return_release
> +#define arch_atomic64_sub_return_release       arch_atomic64_sub_return_release
>  #define arch_atomic64_add_return               arch_atomic64_add_return
>  #define arch_atomic64_sub_return               arch_atomic64_sub_return
>
>  #define arch_atomic64_fetch_add_relaxed        arch_atomic64_fetch_add_relaxed
>  #define arch_atomic64_fetch_sub_relaxed        arch_atomic64_fetch_sub_relaxed
> +#define arch_atomic64_fetch_add_acquire        arch_atomic64_fetch_add_acquire
> +#define arch_atomic64_fetch_sub_acquire        arch_atomic64_fetch_sub_acquire
> +#define arch_atomic64_fetch_add_release        arch_atomic64_fetch_add_release
> +#define arch_atomic64_fetch_sub_release        arch_atomic64_fetch_sub_release
>  #define arch_atomic64_fetch_add                arch_atomic64_fetch_add
>  #define arch_atomic64_fetch_sub                arch_atomic64_fetch_sub
>  #endif
> @@ -178,6 +230,12 @@ ATOMIC_OPS(xor, xor, i)
>  #define arch_atomic_fetch_and_relaxed  arch_atomic_fetch_and_relaxed
>  #define arch_atomic_fetch_or_relaxed   arch_atomic_fetch_or_relaxed
>  #define arch_atomic_fetch_xor_relaxed  arch_atomic_fetch_xor_relaxed
> +#define arch_atomic_fetch_and_acquire  arch_atomic_fetch_and_acquire
> +#define arch_atomic_fetch_or_acquire   arch_atomic_fetch_or_acquire
> +#define arch_atomic_fetch_xor_acquire  arch_atomic_fetch_xor_acquire
> +#define arch_atomic_fetch_and_release  arch_atomic_fetch_and_release
> +#define arch_atomic_fetch_or_release   arch_atomic_fetch_or_release
> +#define arch_atomic_fetch_xor_release  arch_atomic_fetch_xor_release
>  #define arch_atomic_fetch_and          arch_atomic_fetch_and
>  #define arch_atomic_fetch_or           arch_atomic_fetch_or
>  #define arch_atomic_fetch_xor          arch_atomic_fetch_xor
> @@ -186,6 +244,12 @@ ATOMIC_OPS(xor, xor, i)
>  #define arch_atomic64_fetch_and_relaxed        arch_atomic64_fetch_and_relaxed
>  #define arch_atomic64_fetch_or_relaxed arch_atomic64_fetch_or_relaxed
>  #define arch_atomic64_fetch_xor_relaxed        arch_atomic64_fetch_xor_relaxed
> +#define arch_atomic64_fetch_and_acquire        arch_atomic64_fetch_and_acquire
> +#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
> +#define arch_atomic64_fetch_xor_acquire        arch_atomic64_fetch_xor_acquire
> +#define arch_atomic64_fetch_and_release        arch_atomic64_fetch_and_release
> +#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or_release
> +#define arch_atomic64_fetch_xor_release        arch_atomic64_fetch_xor_release
>  #define arch_atomic64_fetch_and                arch_atomic64_fetch_and
>  #define arch_atomic64_fetch_or         arch_atomic64_fetch_or
>  #define arch_atomic64_fetch_xor                arch_atomic64_fetch_xor
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 12debce235e5..1af8db92250b 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -52,16 +52,14 @@
>         switch (size) {                                                 \
>         case 4:                                                         \
>                 __asm__ __volatile__ (                                  \
> -                       "       amoswap.w %0, %2, %1\n"                 \
> -                       RISCV_ACQUIRE_BARRIER                           \
> +                       "       amoswap.w.aq %0, %2, %1\n"              \
>                         : "=r" (__ret), "+A" (*__ptr)                   \
>                         : "r" (__new)                                   \
>                         : "memory");                                    \
>                 break;                                                  \
>         case 8:                                                         \
>                 __asm__ __volatile__ (                                  \
> -                       "       amoswap.d %0, %2, %1\n"                 \
> -                       RISCV_ACQUIRE_BARRIER                           \
> +                       "       amoswap.d.aq %0, %2, %1\n"              \
>                         : "=r" (__ret), "+A" (*__ptr)                   \
>                         : "r" (__new)                                   \
>                         : "memory");                                    \
> @@ -87,16 +85,14 @@
>         switch (size) {                                                 \
>         case 4:                                                         \
>                 __asm__ __volatile__ (                                  \
> -                       RISCV_RELEASE_BARRIER                           \
> -                       "       amoswap.w %0, %2, %1\n"                 \
> +                       "       amoswap.w.rl %0, %2, %1\n"              \
>                         : "=r" (__ret), "+A" (*__ptr)                   \
>                         : "r" (__new)                                   \
>                         : "memory");                                    \
>                 break;                                                  \
>         case 8:                                                         \
>                 __asm__ __volatile__ (                                  \
> -                       RISCV_RELEASE_BARRIER                           \
> -                       "       amoswap.d %0, %2, %1\n"                 \
> +                       "       amoswap.d.rl %0, %2, %1\n"              \
>                         : "=r" (__ret), "+A" (*__ptr)                   \
>                         : "r" (__new)                                   \
>                         : "memory");                                    \
> --
> 2.25.1
>


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30A3751BE
	for <lists+linux-arch@lfdr.de>; Thu,  6 May 2021 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhEFJno (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 05:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231837AbhEFJnn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 May 2021 05:43:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95E1961378;
        Thu,  6 May 2021 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620294165;
        bh=N6vJFenGuFxHixk8TVV07rhPCHUdSJDRNxicUfyx2dA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XUeTYxWU4THwQsDkX2jLY1UlGiCWDTp+bLRarEe4f5dqZtt7nIzxFloPVUuTkapUW
         4R8j3A9nEPa8EQO/0zSwwZkH/X42icdIG3JjotCI/TJbcmk27Lwv6IxZ7hg50AIHAL
         b0L8R76KiQBGrMrPx3KINnRm6jWvYI6DT+NK5wol+hDhaqysJ5fGgrlLTw42hTc4Vg
         zPLDBlvZPrxMP+OKmafpskHtBtfe4KYATsEtqYg+woCtaN69XWkDKDCPDlETRilfAw
         Gifvj74EHRFaiBJcsQAnDEQhf8p0Ksvpqh/QhuZ6LOUZrSG7adi3mhvlqEC7pLMp9O
         vMScChtdV+q1g==
Received: by mail-lf1-f47.google.com with SMTP id c3so6873634lfs.7;
        Thu, 06 May 2021 02:42:45 -0700 (PDT)
X-Gm-Message-State: AOAM532tYnRmDics7K2JnBmccsZ+3nMTHumMqGq7bdidep6wHxSL64E9
        k7aO9cotoH7d/v9Pqo7nay61jawSFQ/uAqkKfgU=
X-Google-Smtp-Source: ABdhPJyaW4zi53exgQ4/EIRhYAePPBtQ4FmeZh+X6SFhnGbnNgBcT5o2VVp8x2odt3vDqPUz4VsbhEgd2AUXQJZOeBU=
X-Received: by 2002:a19:7504:: with SMTP id y4mr2196771lfe.41.1620294163716;
 Thu, 06 May 2021 02:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <1619009626-93453-2-git-send-email-guoren@kernel.org> <mhng-7181822d-02c1-4ef4-b1be-83c1034d79ba@palmerdabbelt-glaptop>
In-Reply-To: <mhng-7181822d-02c1-4ef4-b1be-83c1034d79ba@palmerdabbelt-glaptop>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 6 May 2021 17:42:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRR2SAA_qfxyeRX5MTJDiVNa1aRDTpX7UJfxR3yjC1T9g@mail.gmail.com>
Message-ID: <CAJF2gTRR2SAA_qfxyeRX5MTJDiVNa1aRDTpX7UJfxR3yjC1T9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: atomic: Using ARCH_ATOMIC in asm/atomic.h
To:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Palmer,

On Thu, May 6, 2021 at 2:03 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Wed, 21 Apr 2021 05:53:46 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The linux/atomic-arch-fallback.h has been there for a while, but
> > only x86 & arm64 support it. Let's make riscv follow the
> > linux/arch/* development trendy and make the codes more readable
> > and maintainable.
> >
> > This patch also cleanup some codes:
> >  - Add atomic_andnot_* operation
> >  - Using amoswap.w.rl & amoswap.w.aq instructions in xchg
> >  - Remove cmpxchg_acquire/release unnecessary optimization
>
> Thanks.  I haven't gotten the time to review this properly yet, but I
> don't really see any issues.  Regardless, it was too late for this merge
> window anyway -- these sorts of things are a bit subtle and require a
> proper look, right at the end of the cycle things are just a bit too
> hectic.
>
> I'll take a look once things calm down a bit, there's still some fixes
> out that I'd like to look at first.
>
> I'm also only getting patch 2, and your lore link points to a different
> patch set.
Mark Rutland is preparing a new patchset to let ARCH_ATOMIC become the
default for all arch. I'm waiting for his patchset and atop my
modification on it.
https://lore.kernel.org/linux-riscv/CAJF2gTS9y1QZx-8pu2NW22xs1Gky0y4Hs31Wrn7gZg3FiAq8NA@mail.gmail.com/

So, please abandon the patch, I'll send a new version patchset based
on Mark's work.


>
> Thanks!
>
> > Change in v3:
> >  - Revert to origin atomic(64)_read/set coding style
> >
> > Change in v2:
> >  - Fixup andnot bug by Peter Zijlstra
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Link: https://lore.kernel.org/linux-riscv/CAK8P3a0FG3cpqBNUP7kXj3713cMUqV1WcEh-vcRnGKM00WXqxw@mail.gmail.com/
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > ---
> >  arch/riscv/include/asm/atomic.h  | 216 ++++++++++++++++-----------------------
> >  arch/riscv/include/asm/cmpxchg.h | 199 ++----------------------------------
> >  2 files changed, 98 insertions(+), 317 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> > index 400a8c8..b825bdb 100644
> > --- a/arch/riscv/include/asm/atomic.h
> > +++ b/arch/riscv/include/asm/atomic.h
> > @@ -8,13 +8,8 @@
> >  #ifndef _ASM_RISCV_ATOMIC_H
> >  #define _ASM_RISCV_ATOMIC_H
> >
> > -#ifdef CONFIG_GENERIC_ATOMIC64
> > -# include <asm-generic/atomic64.h>
> > -#else
> > -# if (__riscv_xlen < 64)
> > -#  error "64-bit atomics require XLEN to be at least 64"
> > -# endif
> > -#endif
> > +#include <linux/compiler.h>
> > +#include <linux/types.h>
> >
> >  #include <asm/cmpxchg.h>
> >  #include <asm/barrier.h>
> > @@ -25,22 +20,22 @@
> >  #define __atomic_release_fence()                                     \
> >       __asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
> >
> > -static __always_inline int atomic_read(const atomic_t *v)
> > +static __always_inline int arch_atomic_read(const atomic_t *v)
> >  {
> >       return READ_ONCE(v->counter);
> >  }
> > -static __always_inline void atomic_set(atomic_t *v, int i)
> > +static __always_inline void arch_atomic_set(atomic_t *v, int i)
> >  {
> >       WRITE_ONCE(v->counter, i);
> >  }
> >
> >  #ifndef CONFIG_GENERIC_ATOMIC64
> >  #define ATOMIC64_INIT(i) { (i) }
> > -static __always_inline s64 atomic64_read(const atomic64_t *v)
> > +static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
> >  {
> >       return READ_ONCE(v->counter);
> >  }
> > -static __always_inline void atomic64_set(atomic64_t *v, s64 i)
> > +static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
> >  {
> >       WRITE_ONCE(v->counter, i);
> >  }
> > @@ -53,7 +48,7 @@ static __always_inline void atomic64_set(atomic64_t *v, s64 i)
> >   */
> >  #define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)           \
> >  static __always_inline                                                       \
> > -void atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)          \
> > +void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)     \
> >  {                                                                    \
> >       __asm__ __volatile__ (                                          \
> >               "       amo" #asm_op "." #asm_type " zero, %1, %0"      \
> > @@ -76,6 +71,12 @@ ATOMIC_OPS(sub, add, -i)
> >  ATOMIC_OPS(and, and,  i)
> >  ATOMIC_OPS( or,  or,  i)
> >  ATOMIC_OPS(xor, xor,  i)
> > +ATOMIC_OPS(andnot, and,  ~i)
> > +
> > +#define arch_atomic_andnot   arch_atomic_andnot
> > +#ifndef CONFIG_GENERIC_ATOMIC64
> > +#define arch_atomic64_andnot arch_atomic64_andnot
> > +#endif
> >
> >  #undef ATOMIC_OP
> >  #undef ATOMIC_OPS
> > @@ -87,7 +88,7 @@ ATOMIC_OPS(xor, xor,  i)
> >   */
> >  #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)     \
> >  static __always_inline                                                       \
> > -c_type atomic##prefix##_fetch_##op##_relaxed(c_type i,                       \
> > +c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,          \
> >                                            atomic##prefix##_t *v)     \
> >  {                                                                    \
> >       register c_type ret;                                            \
> > @@ -99,7 +100,7 @@ c_type atomic##prefix##_fetch_##op##_relaxed(c_type i,                     \
> >       return ret;                                                     \
> >  }                                                                    \
> >  static __always_inline                                                       \
> > -c_type atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)  \
> > +c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)\
> >  {                                                                    \
> >       register c_type ret;                                            \
> >       __asm__ __volatile__ (                                          \
> > @@ -112,15 +113,16 @@ c_type atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)     \
> >
> >  #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)      \
> >  static __always_inline                                                       \
> > -c_type atomic##prefix##_##op##_return_relaxed(c_type i,                      \
> > +c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,         \
> >                                             atomic##prefix##_t *v)    \
> >  {                                                                    \
> > -        return atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;   \
> > +        return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;      \
> >  }                                                                    \
> >  static __always_inline                                                       \
> > -c_type atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)       \
> > +c_type arch_atomic##prefix##_##op##_return(c_type i,                 \
> > +                                             atomic##prefix##_t *v)  \
> >  {                                                                    \
> > -        return atomic##prefix##_fetch_##op(i, v) c_op I;             \
> > +        return arch_atomic##prefix##_fetch_##op(i, v) c_op I;                \
> >  }
> >
> >  #ifdef CONFIG_GENERIC_ATOMIC64
> > @@ -138,26 +140,26 @@ c_type atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)  \
> >  ATOMIC_OPS(add, add, +,  i)
> >  ATOMIC_OPS(sub, add, +, -i)
> >
> > -#define atomic_add_return_relaxed    atomic_add_return_relaxed
> > -#define atomic_sub_return_relaxed    atomic_sub_return_relaxed
> > -#define atomic_add_return            atomic_add_return
> > -#define atomic_sub_return            atomic_sub_return
> > +#define arch_atomic_add_return_relaxed               arch_atomic_add_return_relaxed
> > +#define arch_atomic_sub_return_relaxed               arch_atomic_sub_return_relaxed
> > +#define arch_atomic_add_return                       arch_atomic_add_return
> > +#define arch_atomic_sub_return                       arch_atomic_sub_return
> >
> > -#define atomic_fetch_add_relaxed     atomic_fetch_add_relaxed
> > -#define atomic_fetch_sub_relaxed     atomic_fetch_sub_relaxed
> > -#define atomic_fetch_add             atomic_fetch_add
> > -#define atomic_fetch_sub             atomic_fetch_sub
> > +#define arch_atomic_fetch_add_relaxed                arch_atomic_fetch_add_relaxed
> > +#define arch_atomic_fetch_sub_relaxed                arch_atomic_fetch_sub_relaxed
> > +#define arch_atomic_fetch_add                        arch_atomic_fetch_add
> > +#define arch_atomic_fetch_sub                        arch_atomic_fetch_sub
> >
> >  #ifndef CONFIG_GENERIC_ATOMIC64
> > -#define atomic64_add_return_relaxed  atomic64_add_return_relaxed
> > -#define atomic64_sub_return_relaxed  atomic64_sub_return_relaxed
> > -#define atomic64_add_return          atomic64_add_return
> > -#define atomic64_sub_return          atomic64_sub_return
> > -
> > -#define atomic64_fetch_add_relaxed   atomic64_fetch_add_relaxed
> > -#define atomic64_fetch_sub_relaxed   atomic64_fetch_sub_relaxed
> > -#define atomic64_fetch_add           atomic64_fetch_add
> > -#define atomic64_fetch_sub           atomic64_fetch_sub
> > +#define arch_atomic64_add_return_relaxed     arch_atomic64_add_return_relaxed
> > +#define arch_atomic64_sub_return_relaxed     arch_atomic64_sub_return_relaxed
> > +#define arch_atomic64_add_return             arch_atomic64_add_return
> > +#define arch_atomic64_sub_return             arch_atomic64_sub_return
> > +
> > +#define arch_atomic64_fetch_add_relaxed              arch_atomic64_fetch_add_relaxed
> > +#define arch_atomic64_fetch_sub_relaxed              arch_atomic64_fetch_sub_relaxed
> > +#define arch_atomic64_fetch_add                      arch_atomic64_fetch_add
> > +#define arch_atomic64_fetch_sub                      arch_atomic64_fetch_sub
> >  #endif
> >
> >  #undef ATOMIC_OPS
> > @@ -172,23 +174,28 @@ ATOMIC_OPS(sub, add, +, -i)
> >  #endif
> >
> >  ATOMIC_OPS(and, and, i)
> > +ATOMIC_OPS(andnot, and, ~i)
> >  ATOMIC_OPS( or,  or, i)
> >  ATOMIC_OPS(xor, xor, i)
> >
> > -#define atomic_fetch_and_relaxed     atomic_fetch_and_relaxed
> > -#define atomic_fetch_or_relaxed              atomic_fetch_or_relaxed
> > -#define atomic_fetch_xor_relaxed     atomic_fetch_xor_relaxed
> > -#define atomic_fetch_and             atomic_fetch_and
> > -#define atomic_fetch_or                      atomic_fetch_or
> > -#define atomic_fetch_xor             atomic_fetch_xor
> > +#define arch_atomic_fetch_and_relaxed                arch_atomic_fetch_and_relaxed
> > +#define arch_atomic_fetch_andnot_relaxed     arch_atomic_fetch_andnot_relaxed
> > +#define arch_atomic_fetch_or_relaxed         arch_atomic_fetch_or_relaxed
> > +#define arch_atomic_fetch_xor_relaxed                arch_atomic_fetch_xor_relaxed
> > +#define arch_atomic_fetch_and                        arch_atomic_fetch_and
> > +#define arch_atomic_fetch_andnot             arch_atomic_fetch_andnot
> > +#define arch_atomic_fetch_or                 arch_atomic_fetch_or
> > +#define arch_atomic_fetch_xor                        arch_atomic_fetch_xor
> >
> >  #ifndef CONFIG_GENERIC_ATOMIC64
> > -#define atomic64_fetch_and_relaxed   atomic64_fetch_and_relaxed
> > -#define atomic64_fetch_or_relaxed    atomic64_fetch_or_relaxed
> > -#define atomic64_fetch_xor_relaxed   atomic64_fetch_xor_relaxed
> > -#define atomic64_fetch_and           atomic64_fetch_and
> > -#define atomic64_fetch_or            atomic64_fetch_or
> > -#define atomic64_fetch_xor           atomic64_fetch_xor
> > +#define arch_atomic64_fetch_and_relaxed              arch_atomic64_fetch_and_relaxed
> > +#define arch_atomic64_fetch_andnot_relaxed   arch_atomic64_fetch_andnot_relaxed
> > +#define arch_atomic64_fetch_or_relaxed               arch_atomic64_fetch_or_relaxed
> > +#define arch_atomic64_fetch_xor_relaxed              arch_atomic64_fetch_xor_relaxed
> > +#define arch_atomic64_fetch_and                      arch_atomic64_fetch_and
> > +#define arch_atomic64_fetch_andnot           arch_atomic64_fetch_andnot
> > +#define arch_atomic64_fetch_or                       arch_atomic64_fetch_or
> > +#define arch_atomic64_fetch_xor                      arch_atomic64_fetch_xor
> >  #endif
> >
> >  #undef ATOMIC_OPS
> > @@ -197,7 +204,7 @@ ATOMIC_OPS(xor, xor, i)
> >  #undef ATOMIC_OP_RETURN
> >
> >  /* This is required to provide a full barrier on success. */
> > -static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
> > +static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
> >  {
> >         int prev, rc;
> >
> > @@ -214,10 +221,10 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
> >               : "memory");
> >       return prev;
> >  }
> > -#define atomic_fetch_add_unless atomic_fetch_add_unless
> > +#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
> >
> >  #ifndef CONFIG_GENERIC_ATOMIC64
> > -static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
> > +static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
> >  {
> >         s64 prev;
> >         long rc;
> > @@ -235,82 +242,10 @@ static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
> >               : "memory");
> >       return prev;
> >  }
> > -#define atomic64_fetch_add_unless atomic64_fetch_add_unless
> > +#define arch_atomic64_fetch_add_unless               arch_atomic64_fetch_add_unless
> >  #endif
> >
> > -/*
> > - * atomic_{cmp,}xchg is required to have exactly the same ordering semantics as
> > - * {cmp,}xchg and the operations that return, so they need a full barrier.
> > - */
> > -#define ATOMIC_OP(c_t, prefix, size)                                 \
> > -static __always_inline                                                       \
> > -c_t atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)              \
> > -{                                                                    \
> > -     return __xchg_relaxed(&(v->counter), n, size);                  \
> > -}                                                                    \
> > -static __always_inline                                                       \
> > -c_t atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)              \
> > -{                                                                    \
> > -     return __xchg_acquire(&(v->counter), n, size);                  \
> > -}                                                                    \
> > -static __always_inline                                                       \
> > -c_t atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)              \
> > -{                                                                    \
> > -     return __xchg_release(&(v->counter), n, size);                  \
> > -}                                                                    \
> > -static __always_inline                                                       \
> > -c_t atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)                      \
> > -{                                                                    \
> > -     return __xchg(&(v->counter), n, size);                          \
> > -}                                                                    \
> > -static __always_inline                                                       \
> > -c_t atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,          \
> > -                                  c_t o, c_t n)                      \
> > -{                                                                    \
> > -     return __cmpxchg_relaxed(&(v->counter), o, n, size);            \
> > -}                                                                    \
> > -static __always_inline                                                       \
> > -c_t atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,          \
> > -                                  c_t o, c_t n)                      \
> > -{                                                                    \
> > -     return __cmpxchg_acquire(&(v->counter), o, n, size);            \
> > -}                                                                    \
> > -static __always_inline                                                       \
> > -c_t atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,          \
> > -                                  c_t o, c_t n)                      \
> > -{                                                                    \
> > -     return __cmpxchg_release(&(v->counter), o, n, size);            \
> > -}                                                                    \
> > -static __always_inline                                                       \
> > -c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)    \
> > -{                                                                    \
> > -     return __cmpxchg(&(v->counter), o, n, size);                    \
> > -}
> > -
> > -#ifdef CONFIG_GENERIC_ATOMIC64
> > -#define ATOMIC_OPS()                                                 \
> > -     ATOMIC_OP(int,   , 4)
> > -#else
> > -#define ATOMIC_OPS()                                                 \
> > -     ATOMIC_OP(int,   , 4)                                           \
> > -     ATOMIC_OP(s64, 64, 8)
> > -#endif
> > -
> > -ATOMIC_OPS()
> > -
> > -#define atomic_xchg_relaxed atomic_xchg_relaxed
> > -#define atomic_xchg_acquire atomic_xchg_acquire
> > -#define atomic_xchg_release atomic_xchg_release
> > -#define atomic_xchg atomic_xchg
> > -#define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
> > -#define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
> > -#define atomic_cmpxchg_release atomic_cmpxchg_release
> > -#define atomic_cmpxchg atomic_cmpxchg
> > -
> > -#undef ATOMIC_OPS
> > -#undef ATOMIC_OP
> > -
> > -static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
> > +static __always_inline int arch_atomic_sub_if_positive(atomic_t *v, int offset)
> >  {
> >         int prev, rc;
> >
> > @@ -327,11 +262,11 @@ static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
> >               : "memory");
> >       return prev - offset;
> >  }
> > +#define arch_atomic_dec_if_positive(v)       arch_atomic_sub_if_positive(v, 1)
> >
> > -#define atomic_dec_if_positive(v)    atomic_sub_if_positive(v, 1)
> >
> >  #ifndef CONFIG_GENERIC_ATOMIC64
> > -static __always_inline s64 atomic64_sub_if_positive(atomic64_t *v, s64 offset)
> > +static __always_inline s64 arch_atomic64_sub_if_positive(atomic64_t *v, s64 offset)
> >  {
> >         s64 prev;
> >         long rc;
> > @@ -349,8 +284,35 @@ static __always_inline s64 atomic64_sub_if_positive(atomic64_t *v, s64 offset)
> >               : "memory");
> >       return prev - offset;
> >  }
> > +#define arch_atomic64_dec_if_positive(v)     arch_atomic64_sub_if_positive(v, 1)
> > +#endif
> > +
> > +#define arch_atomic_xchg_relaxed(v, new) \
> > +     arch_xchg_relaxed(&((v)->counter), (new))
> > +#define arch_atomic_xchg_acquire(v, new) \
> > +     arch_xchg_acquire(&((v)->counter), (new))
> > +#define arch_atomic_xchg_release(v, new) \
> > +     arch_xchg_release(&((v)->counter), (new))
> > +#define arch_atomic_xchg(v, new) \
> > +     arch_xchg(&((v)->counter), (new))
> > +
> > +#define arch_atomic_cmpxchg_relaxed(v, old, new) \
> > +     arch_cmpxchg_relaxed(&((v)->counter), (old), (new))
> > +#define arch_atomic_cmpxchg_acquire(v, old, new) \
> > +     arch_cmpxchg_acquire(&((v)->counter), (old), (new))
> > +#define arch_atomic_cmpxchg_release(v, old, new) \
> > +     arch_cmpxchg_release(&((v)->counter), (old), (new))
> > +#define arch_atomic_cmpxchg(v, old, new) \
> > +     arch_cmpxchg(&((v)->counter), (old), (new))
> >
> > -#define atomic64_dec_if_positive(v)  atomic64_sub_if_positive(v, 1)
> > +#ifndef CONFIG_GENERIC_ATOMIC64
> > +#define arch_atomic64_xchg_relaxed           arch_atomic_xchg_relaxed
> > +#define arch_atomic64_xchg                   arch_atomic_xchg
> > +
> > +#define arch_atomic64_cmpxchg_relaxed                arch_atomic_cmpxchg_relaxed
> > +#define arch_atomic64_cmpxchg                        arch_atomic_cmpxchg
> >  #endif
> >
> > +#define ARCH_ATOMIC
> > +
> >  #endif /* _ASM_RISCV_ATOMIC_H */
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > index 262e5bb..16195a6 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -37,7 +37,7 @@
> >       __ret;                                                          \
> >  })
> >
> > -#define xchg_relaxed(ptr, x)                                         \
> > +#define arch_xchg_relaxed(ptr, x)                                    \
> >  ({                                                                   \
> >       __typeof__(*(ptr)) _x_ = (x);                                   \
> >       (__typeof__(*(ptr))) __xchg_relaxed((ptr),                      \
> > @@ -52,16 +52,14 @@
> >       switch (size) {                                                 \
> >       case 4:                                                         \
> >               __asm__ __volatile__ (                                  \
> > -                     "       amoswap.w %0, %2, %1\n"                 \
> > -                     RISCV_ACQUIRE_BARRIER                           \
> > +                     "       amoswap.w.aq %0, %2, %1\n"              \
> >                       : "=r" (__ret), "+A" (*__ptr)                   \
> >                       : "r" (__new)                                   \
> >                       : "memory");                                    \
> >               break;                                                  \
> >       case 8:                                                         \
> >               __asm__ __volatile__ (                                  \
> > -                     "       amoswap.d %0, %2, %1\n"                 \
> > -                     RISCV_ACQUIRE_BARRIER                           \
> > +                     "       amoswap.d.aq %0, %2, %1\n"              \
> >                       : "=r" (__ret), "+A" (*__ptr)                   \
> >                       : "r" (__new)                                   \
> >                       : "memory");                                    \
> > @@ -72,7 +70,7 @@
> >       __ret;                                                          \
> >  })
> >
> > -#define xchg_acquire(ptr, x)                                         \
> > +#define arch_xchg_acquire(ptr, x)                                    \
> >  ({                                                                   \
> >       __typeof__(*(ptr)) _x_ = (x);                                   \
> >       (__typeof__(*(ptr))) __xchg_acquire((ptr),                      \
> > @@ -87,16 +85,14 @@
> >       switch (size) {                                                 \
> >       case 4:                                                         \
> >               __asm__ __volatile__ (                                  \
> > -                     RISCV_RELEASE_BARRIER                           \
> > -                     "       amoswap.w %0, %2, %1\n"                 \
> > +                     "       amoswap.w.rl %0, %2, %1\n"              \
> >                       : "=r" (__ret), "+A" (*__ptr)                   \
> >                       : "r" (__new)                                   \
> >                       : "memory");                                    \
> >               break;                                                  \
> >       case 8:                                                         \
> >               __asm__ __volatile__ (                                  \
> > -                     RISCV_RELEASE_BARRIER                           \
> > -                     "       amoswap.d %0, %2, %1\n"                 \
> > +                     "       amoswap.d.rl %0, %2, %1\n"              \
> >                       : "=r" (__ret), "+A" (*__ptr)                   \
> >                       : "r" (__new)                                   \
> >                       : "memory");                                    \
> > @@ -107,7 +103,7 @@
> >       __ret;                                                          \
> >  })
> >
> > -#define xchg_release(ptr, x)                                         \
> > +#define arch_xchg_release(ptr, x)                                    \
> >  ({                                                                   \
> >       __typeof__(*(ptr)) _x_ = (x);                                   \
> >       (__typeof__(*(ptr))) __xchg_release((ptr),                      \
> > @@ -140,24 +136,12 @@
> >       __ret;                                                          \
> >  })
> >
> > -#define xchg(ptr, x)                                                 \
> > +#define arch_xchg(ptr, x)                                            \
> >  ({                                                                   \
> >       __typeof__(*(ptr)) _x_ = (x);                                   \
> >       (__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));        \
> >  })
> >
> > -#define xchg32(ptr, x)                                                       \
> > -({                                                                   \
> > -     BUILD_BUG_ON(sizeof(*(ptr)) != 4);                              \
> > -     xchg((ptr), (x));                                               \
> > -})
> > -
> > -#define xchg64(ptr, x)                                                       \
> > -({                                                                   \
> > -     BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > -     xchg((ptr), (x));                                               \
> > -})
> > -
> >  /*
> >   * Atomic compare and exchange.  Compare OLD with MEM, if identical,
> >   * store NEW in MEM.  Return the initial value in MEM.  Success is
> > @@ -199,7 +183,7 @@
> >       __ret;                                                          \
> >  })
> >
> > -#define cmpxchg_relaxed(ptr, o, n)                                   \
> > +#define arch_cmpxchg_relaxed(ptr, o, n)                                      \
> >  ({                                                                   \
> >       __typeof__(*(ptr)) _o_ = (o);                                   \
> >       __typeof__(*(ptr)) _n_ = (n);                                   \
> > @@ -207,169 +191,4 @@
> >                                       _o_, _n_, sizeof(*(ptr)));      \
> >  })
> >
> > -#define __cmpxchg_acquire(ptr, old, new, size)                               \
> > -({                                                                   \
> > -     __typeof__(ptr) __ptr = (ptr);                                  \
> > -     __typeof__(*(ptr)) __old = (old);                               \
> > -     __typeof__(*(ptr)) __new = (new);                               \
> > -     __typeof__(*(ptr)) __ret;                                       \
> > -     register unsigned int __rc;                                     \
> > -     switch (size) {                                                 \
> > -     case 4:                                                         \
> > -             __asm__ __volatile__ (                                  \
> > -                     "0:     lr.w %0, %2\n"                          \
> > -                     "       bne  %0, %z3, 1f\n"                     \
> > -                     "       sc.w %1, %z4, %2\n"                     \
> > -                     "       bnez %1, 0b\n"                          \
> > -                     RISCV_ACQUIRE_BARRIER                           \
> > -                     "1:\n"                                          \
> > -                     : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > -                     : "rJ" ((long)__old), "rJ" (__new)              \
> > -                     : "memory");                                    \
> > -             break;                                                  \
> > -     case 8:                                                         \
> > -             __asm__ __volatile__ (                                  \
> > -                     "0:     lr.d %0, %2\n"                          \
> > -                     "       bne %0, %z3, 1f\n"                      \
> > -                     "       sc.d %1, %z4, %2\n"                     \
> > -                     "       bnez %1, 0b\n"                          \
> > -                     RISCV_ACQUIRE_BARRIER                           \
> > -                     "1:\n"                                          \
> > -                     : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > -                     : "rJ" (__old), "rJ" (__new)                    \
> > -                     : "memory");                                    \
> > -             break;                                                  \
> > -     default:                                                        \
> > -             BUILD_BUG();                                            \
> > -     }                                                               \
> > -     __ret;                                                          \
> > -})
> > -
> > -#define cmpxchg_acquire(ptr, o, n)                                   \
> > -({                                                                   \
> > -     __typeof__(*(ptr)) _o_ = (o);                                   \
> > -     __typeof__(*(ptr)) _n_ = (n);                                   \
> > -     (__typeof__(*(ptr))) __cmpxchg_acquire((ptr),                   \
> > -                                     _o_, _n_, sizeof(*(ptr)));      \
> > -})
> > -
> > -#define __cmpxchg_release(ptr, old, new, size)                               \
> > -({                                                                   \
> > -     __typeof__(ptr) __ptr = (ptr);                                  \
> > -     __typeof__(*(ptr)) __old = (old);                               \
> > -     __typeof__(*(ptr)) __new = (new);                               \
> > -     __typeof__(*(ptr)) __ret;                                       \
> > -     register unsigned int __rc;                                     \
> > -     switch (size) {                                                 \
> > -     case 4:                                                         \
> > -             __asm__ __volatile__ (                                  \
> > -                     RISCV_RELEASE_BARRIER                           \
> > -                     "0:     lr.w %0, %2\n"                          \
> > -                     "       bne  %0, %z3, 1f\n"                     \
> > -                     "       sc.w %1, %z4, %2\n"                     \
> > -                     "       bnez %1, 0b\n"                          \
> > -                     "1:\n"                                          \
> > -                     : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > -                     : "rJ" ((long)__old), "rJ" (__new)              \
> > -                     : "memory");                                    \
> > -             break;                                                  \
> > -     case 8:                                                         \
> > -             __asm__ __volatile__ (                                  \
> > -                     RISCV_RELEASE_BARRIER                           \
> > -                     "0:     lr.d %0, %2\n"                          \
> > -                     "       bne %0, %z3, 1f\n"                      \
> > -                     "       sc.d %1, %z4, %2\n"                     \
> > -                     "       bnez %1, 0b\n"                          \
> > -                     "1:\n"                                          \
> > -                     : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > -                     : "rJ" (__old), "rJ" (__new)                    \
> > -                     : "memory");                                    \
> > -             break;                                                  \
> > -     default:                                                        \
> > -             BUILD_BUG();                                            \
> > -     }                                                               \
> > -     __ret;                                                          \
> > -})
> > -
> > -#define cmpxchg_release(ptr, o, n)                                   \
> > -({                                                                   \
> > -     __typeof__(*(ptr)) _o_ = (o);                                   \
> > -     __typeof__(*(ptr)) _n_ = (n);                                   \
> > -     (__typeof__(*(ptr))) __cmpxchg_release((ptr),                   \
> > -                                     _o_, _n_, sizeof(*(ptr)));      \
> > -})
> > -
> > -#define __cmpxchg(ptr, old, new, size)                                       \
> > -({                                                                   \
> > -     __typeof__(ptr) __ptr = (ptr);                                  \
> > -     __typeof__(*(ptr)) __old = (old);                               \
> > -     __typeof__(*(ptr)) __new = (new);                               \
> > -     __typeof__(*(ptr)) __ret;                                       \
> > -     register unsigned int __rc;                                     \
> > -     switch (size) {                                                 \
> > -     case 4:                                                         \
> > -             __asm__ __volatile__ (                                  \
> > -                     "0:     lr.w %0, %2\n"                          \
> > -                     "       bne  %0, %z3, 1f\n"                     \
> > -                     "       sc.w.rl %1, %z4, %2\n"                  \
> > -                     "       bnez %1, 0b\n"                          \
> > -                     "       fence rw, rw\n"                         \
> > -                     "1:\n"                                          \
> > -                     : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > -                     : "rJ" ((long)__old), "rJ" (__new)              \
> > -                     : "memory");                                    \
> > -             break;                                                  \
> > -     case 8:                                                         \
> > -             __asm__ __volatile__ (                                  \
> > -                     "0:     lr.d %0, %2\n"                          \
> > -                     "       bne %0, %z3, 1f\n"                      \
> > -                     "       sc.d.rl %1, %z4, %2\n"                  \
> > -                     "       bnez %1, 0b\n"                          \
> > -                     "       fence rw, rw\n"                         \
> > -                     "1:\n"                                          \
> > -                     : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > -                     : "rJ" (__old), "rJ" (__new)                    \
> > -                     : "memory");                                    \
> > -             break;                                                  \
> > -     default:                                                        \
> > -             BUILD_BUG();                                            \
> > -     }                                                               \
> > -     __ret;                                                          \
> > -})
> > -
> > -#define cmpxchg(ptr, o, n)                                           \
> > -({                                                                   \
> > -     __typeof__(*(ptr)) _o_ = (o);                                   \
> > -     __typeof__(*(ptr)) _n_ = (n);                                   \
> > -     (__typeof__(*(ptr))) __cmpxchg((ptr),                           \
> > -                                    _o_, _n_, sizeof(*(ptr)));       \
> > -})
> > -
> > -#define cmpxchg_local(ptr, o, n)                                     \
> > -     (__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
> > -
> > -#define cmpxchg32(ptr, o, n)                                         \
> > -({                                                                   \
> > -     BUILD_BUG_ON(sizeof(*(ptr)) != 4);                              \
> > -     cmpxchg((ptr), (o), (n));                                       \
> > -})
> > -
> > -#define cmpxchg32_local(ptr, o, n)                                   \
> > -({                                                                   \
> > -     BUILD_BUG_ON(sizeof(*(ptr)) != 4);                              \
> > -     cmpxchg_relaxed((ptr), (o), (n))                                \
> > -})
> > -
> > -#define cmpxchg64(ptr, o, n)                                         \
> > -({                                                                   \
> > -     BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > -     cmpxchg((ptr), (o), (n));                                       \
> > -})
> > -
> > -#define cmpxchg64_local(ptr, o, n)                                   \
> > -({                                                                   \
> > -     BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > -     cmpxchg_relaxed((ptr), (o), (n));                               \
> > -})
> > -
> >  #endif /* _ASM_RISCV_CMPXCHG_H */



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4B52E951
	for <lists+linux-arch@lfdr.de>; Fri, 20 May 2022 11:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347881AbiETJua (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 May 2022 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238325AbiETJu3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2022 05:50:29 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72824149ABD;
        Fri, 20 May 2022 02:50:27 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id a127so7879540vsa.3;
        Fri, 20 May 2022 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lho52wOW4esdS7d50t6uXUZr97x8v6arZlxI8VA+TcU=;
        b=ZJVW2MDwm4fBKTj4d7LQJ5LPK5U3aeJDl7RSJZVPYwOip1zMUmhWRjre6Ekh2f9MBG
         8En1gjzX1PMevWYpe73++krcLUwWrE4bNbJ68d06Tc2Sx896IPCUqhcZ85cGb2eSde8N
         t4Q/h1+u0qV4XWxg8AJIws+hi84sLAgDMa46fbTGSdFAAayGtEEoxvJ9waQVOGX/od22
         P9kEj/Tof0crNCSrW2/eXCUMaCX49jtRo9/5DvMjjah0cb96Ut4uAC9dt6ELn3uKZ3XU
         n6JvfDGEaD6OJhEMQDX32dwEwdSH7dl8ZoE0DMdI3y3VsVKwZ5gv1E3x2TuNSa9f1qP2
         lOAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lho52wOW4esdS7d50t6uXUZr97x8v6arZlxI8VA+TcU=;
        b=tmrYcVy1Vylnl2+8qDWVmg/J/ham8YhJso6X9OcDPdcFHiLEJ2WxasJTCxfowj//kB
         2WvdLvZvuIRce1NFzvAs2woRqdUV44wGgU5CR7HI8/5DVWH5j994hoivspDaF/0S/k6h
         UI7rK035+W0cvP6pDJtzFMf2ZULT0yKRwAAodmbNhNmQQzgtByB0pEcXaBXU7N8suNJm
         W4xgjc+svWzw15vWRBhbByHp91BNuAa9D2CGgjhm3t+QLHGajE7JxDwGhvJ197K/ODVJ
         bh8NuK3+dZjL0OYwXl63PpjYDwOkvQdT2Pc7c/+oL0ywRkGB0CmFbWBrSAasxop+RG0E
         EzNg==
X-Gm-Message-State: AOAM533NdXTjPOP21UEKT09TcZQrmCtjnApVQo4e/mlNg4F00bCvsaQY
        eYCO/kWPmFcU1i0gkYbINO06R/PFTNN+bYv/3vo=
X-Google-Smtp-Source: ABdhPJwOCYHkK3Y1URBvfm7nnZlwWoenjyojLZXm/RpZoa7SbMaIO6qjkdDi3Oyu6bRfIP9jlD9Ai94IQvitVSBgcrc=
X-Received: by 2002:a67:e1c4:0:b0:335:cdc4:395f with SMTP id
 p4-20020a67e1c4000000b00335cdc4395fmr3746990vsl.71.1653040226443; Fri, 20 May
 2022 02:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-8-chenhuacai@loongson.cn> <CAJF2gTTokRNksuE_5c+T80GW47v-mOOtHqhSC_MkZM7VkqucmQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTokRNksuE_5c+T80GW47v-mOOtHqhSC_MkZM7VkqucmQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 20 May 2022 17:50:18 +0800
Message-ID: <CAAhV-H7ks=uOqM5kaD15-f--sx_F0fGMLe=ng2b93X+yi_DsvQ@mail.gmail.com>
Subject: Re: [PATCH V11 07/22] LoongArch: Add atomic/locking headers
To:     Guo Ren <guoren@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ren,

On Fri, May 20, 2022 at 3:54 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, May 18, 2022 at 5:34 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > Add common headers (atomic, bitops, barrier and locking) for basic
> > LoongArch support.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/atomic.h  | 358 +++++++++++++++++++++++++++
> >  arch/loongarch/include/asm/barrier.h |  51 ++++
> >  arch/loongarch/include/asm/bitops.h  |  33 +++
> >  arch/loongarch/include/asm/bitrev.h  |  34 +++
> >  arch/loongarch/include/asm/cmpxchg.h | 121 +++++++++
> >  arch/loongarch/include/asm/local.h   | 138 +++++++++++
> >  arch/loongarch/include/asm/percpu.h  |  20 ++
> >  7 files changed, 755 insertions(+)
> >  create mode 100644 arch/loongarch/include/asm/atomic.h
> >  create mode 100644 arch/loongarch/include/asm/barrier.h
> >  create mode 100644 arch/loongarch/include/asm/bitops.h
> >  create mode 100644 arch/loongarch/include/asm/bitrev.h
> >  create mode 100644 arch/loongarch/include/asm/cmpxchg.h
> >  create mode 100644 arch/loongarch/include/asm/local.h
> >  create mode 100644 arch/loongarch/include/asm/percpu.h
> >
> > diff --git a/arch/loongarch/include/asm/atomic.h b/arch/loongarch/include/asm/atomic.h
> > new file mode 100644
> > index 000000000000..932352342b12
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/atomic.h
> > @@ -0,0 +1,358 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Atomic operations.
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_ATOMIC_H
> > +#define _ASM_ATOMIC_H
> > +
> > +#include <linux/types.h>
> > +#include <asm/barrier.h>
> > +#include <asm/cmpxchg.h>
> > +#include <asm/compiler.h>
> > +
> > +#if __SIZEOF_LONG__ == 4
> > +#define __LL           "ll.w   "
> > +#define __SC           "sc.w   "
> > +#define __AMADD                "amadd.w        "
> > +#define __AMAND_DB     "amand_db.w     "
> > +#define __AMOR_DB      "amor_db.w      "
> > +#define __AMXOR_DB     "amxor_db.w     "
> > +#elif __SIZEOF_LONG__ == 8
> > +#define __LL           "ll.d   "
> > +#define __SC           "sc.d   "
> > +#define __AMADD                "amadd.d        "
> > +#define __AMAND_DB     "amand_db.d     "
> > +#define __AMOR_DB      "amor_db.d      "
> > +#define __AMXOR_DB     "amxor_db.d     "
> > +#endif
> > +
> > +#define ATOMIC_INIT(i)   { (i) }
> > +
> > +/*
> > + * arch_atomic_read - read atomic variable
> > + * @v: pointer of type atomic_t
> > + *
> > + * Atomically reads the value of @v.
> > + */
> > +#define arch_atomic_read(v)    READ_ONCE((v)->counter)
> > +
> > +/*
> > + * arch_atomic_set - set atomic variable
> > + * @v: pointer of type atomic_t
> > + * @i: required value
> > + *
> > + * Atomically sets the value of @v to @i.
> > + */
> > +#define arch_atomic_set(v, i)  WRITE_ONCE((v)->counter, (i))
> > +
> > +#define ATOMIC_OP(op, I, asm_op)                                       \
> > +static inline void arch_atomic_##op(int i, atomic_t *v)                        \
> > +{                                                                      \
> > +       __asm__ __volatile__(                                           \
> > +       "am"#asm_op"_db.w" " $zero, %1, %0      \n"                     \
> > +       : "+ZB" (v->counter)                                            \
> > +       : "r" (I)                                                       \
> > +       : "memory");                                                    \
> > +}
> > +
> > +#define ATOMIC_OP_RETURN(op, I, asm_op, c_op)                          \
> > +static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)        \
> > +{                                                                      \
> > +       int result;                                                     \
> > +                                                                       \
> > +       __asm__ __volatile__(                                           \
> > +       "am"#asm_op"_db.w" " %1, %2, %0         \n"                     \
> > +       : "+ZB" (v->counter), "=&r" (result)                            \
> > +       : "r" (I)                                                       \
> > +       : "memory");                                                    \
> > +                                                                       \
> > +       return result c_op I;                                           \
> > +}
> > +
> > +#define ATOMIC_FETCH_OP(op, I, asm_op)                                 \
> > +static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v) \
> > +{                                                                      \
> > +       int result;                                                     \
> > +                                                                       \
> > +       __asm__ __volatile__(                                           \
> > +       "am"#asm_op"_db.w" " %1, %2, %0         \n"                     \
> > +       : "+ZB" (v->counter), "=&r" (result)                            \
> > +       : "r" (I)                                                       \
> > +       : "memory");                                                    \
> > +                                                                       \
> > +       return result;                                                  \
> > +}
> > +
> > +#define ATOMIC_OPS(op, I, asm_op, c_op)                                        \
> > +       ATOMIC_OP(op, I, asm_op)                                        \
> > +       ATOMIC_OP_RETURN(op, I, asm_op, c_op)                           \
> > +       ATOMIC_FETCH_OP(op, I, asm_op)
> > +
> > +ATOMIC_OPS(add, i, add, +)
> > +ATOMIC_OPS(sub, -i, add, +)
> > +
> > +#define arch_atomic_add_return_relaxed arch_atomic_add_return_relaxed
> > +#define arch_atomic_sub_return_relaxed arch_atomic_sub_return_relaxed
> > +#define arch_atomic_fetch_add_relaxed  arch_atomic_fetch_add_relaxed
> > +#define arch_atomic_fetch_sub_relaxed  arch_atomic_fetch_sub_relaxed
> > +
> > +#undef ATOMIC_OPS
> > +
> > +#define ATOMIC_OPS(op, I, asm_op)                                      \
> > +       ATOMIC_OP(op, I, asm_op)                                        \
> > +       ATOMIC_FETCH_OP(op, I, asm_op)
> > +
> > +ATOMIC_OPS(and, i, and)
> > +ATOMIC_OPS(or, i, or)
> > +ATOMIC_OPS(xor, i, xor)
> > +
> > +#define arch_atomic_fetch_and_relaxed  arch_atomic_fetch_and_relaxed
> > +#define arch_atomic_fetch_or_relaxed   arch_atomic_fetch_or_relaxed
> > +#define arch_atomic_fetch_xor_relaxed  arch_atomic_fetch_xor_relaxed
> > +
> > +#undef ATOMIC_OPS
> > +#undef ATOMIC_FETCH_OP
> > +#undef ATOMIC_OP_RETURN
> > +#undef ATOMIC_OP
> > +
> > +static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
> > +{
> > +       int prev, rc;
> > +
> > +       __asm__ __volatile__ (
> We need __WEAK_LLSC_MB here, to prevent previous access after sc.w.
LoongArch's ll and sc has implied memory barrier. :)

>
> > +               "0:     ll.w    %[p],  %[c]\n"
> > +               "       beq     %[p],  %[u], 1f\n"
> > +               "       add.w   %[rc], %[p], %[a]\n"
> > +               "       sc.w    %[rc], %[c]\n"
> > +               "       beqz    %[rc], 0b\n"
> > +               "       b       2f\n"
> > +               "1:\n"
> > +               __WEAK_LLSC_MB
> > +               "2:\n"
> > +               : [p]"=&r" (prev), [rc]"=&r" (rc),
> > +                 [c]"=ZB" (v->counter)
> > +               : [a]"r" (a), [u]"r" (u)
> > +               : "memory");
> > +
> > +       return prev;
> > +}
> > +#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
> > +
> > +/*
> > + * arch_atomic_sub_if_positive - conditionally subtract integer from atomic variable
> > + * @i: integer value to subtract
> > + * @v: pointer of type atomic_t
> > + *
> > + * Atomically test @v and subtract @i if @v is greater or equal than @i.
> > + * The function returns the old value of @v minus @i.
> > + */
> > +static inline int arch_atomic_sub_if_positive(int i, atomic_t *v)
> > +{
> > +       int result;
> > +       int temp;
> > +
> > +       if (__builtin_constant_p(i)) {
> > +               __asm__ __volatile__(
> Ditto.
> > +               "1:     ll.w    %1, %2          # atomic_sub_if_positive\n"
> > +               "       addi.w  %0, %1, %3                              \n"
> > +               "       or      %1, %0, $zero                           \n"
> > +               "       blt     %0, $zero, 2f                           \n"
> > +               "       sc.w    %1, %2                                  \n"
> > +               "       beq     $zero, %1, 1b                           \n"
> Need               __WEAK_LLSC_MB ?
> > +               "2:                                                     \n"
> > +               : "=&r" (result), "=&r" (temp),
> > +                 "+" GCC_OFF_SMALL_ASM() (v->counter)
> > +               : "I" (-i));
> > +       } else {
> > +               __asm__ __volatile__(
> Ditto.
> > +               "1:     ll.w    %1, %2          # atomic_sub_if_positive\n"
> > +               "       sub.w   %0, %1, %3                              \n"
> > +               "       or      %1, %0, $zero                           \n"
> > +               "       blt     %0, $zero, 2f                           \n"
> > +               "       sc.w    %1, %2                                  \n"
> Need               __WEAK_LLSC_MB ?
> > +               "       beq     $zero, %1, 1b                           \n"
> > +               "2:                                                     \n"
> > +               : "=&r" (result), "=&r" (temp),
> > +                 "+" GCC_OFF_SMALL_ASM() (v->counter)
> > +               : "r" (i));
> > +       }
> > +
> > +       return result;
> > +}
> > +
> > +#define arch_atomic_cmpxchg(v, o, n) (arch_cmpxchg(&((v)->counter), (o), (n)))
> > +#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), (new)))
> > +
> > +/*
> > + * arch_atomic_dec_if_positive - decrement by 1 if old value positive
> > + * @v: pointer of type atomic_t
> > + */
> > +#define arch_atomic_dec_if_positive(v) arch_atomic_sub_if_positive(1, v)
> > +
> > +#ifdef CONFIG_64BIT
> > +
> > +#define ATOMIC64_INIT(i)    { (i) }
> > +
> > +/*
> > + * arch_atomic64_read - read atomic variable
> > + * @v: pointer of type atomic64_t
> > + *
> > + */
> > +#define arch_atomic64_read(v)  READ_ONCE((v)->counter)
> > +
> > +/*
> > + * arch_atomic64_set - set atomic variable
> > + * @v: pointer of type atomic64_t
> > + * @i: required value
> > + */
> > +#define arch_atomic64_set(v, i)        WRITE_ONCE((v)->counter, (i))
> > +
> > +#define ATOMIC64_OP(op, I, asm_op)                                     \
> > +static inline void arch_atomic64_##op(long i, atomic64_t *v)           \
> > +{                                                                      \
> > +       __asm__ __volatile__(                                           \
> > +       "am"#asm_op"_db.d " " $zero, %1, %0     \n"                     \
> > +       : "+ZB" (v->counter)                                            \
> > +       : "r" (I)                                                       \
> > +       : "memory");                                                    \
> > +}
> > +
> > +#define ATOMIC64_OP_RETURN(op, I, asm_op, c_op)                                        \
> > +static inline long arch_atomic64_##op##_return_relaxed(long i, atomic64_t *v)  \
> > +{                                                                              \
> > +       long result;                                                            \
> > +       __asm__ __volatile__(                                                   \
> > +       "am"#asm_op"_db.d " " %1, %2, %0                \n"                     \
> > +       : "+ZB" (v->counter), "=&r" (result)                                    \
> > +       : "r" (I)                                                               \
> > +       : "memory");                                                            \
> > +                                                                               \
> > +       return result c_op I;                                                   \
> > +}
> > +
> > +#define ATOMIC64_FETCH_OP(op, I, asm_op)                                       \
> > +static inline long arch_atomic64_fetch_##op##_relaxed(long i, atomic64_t *v)   \
> > +{                                                                              \
> > +       long result;                                                            \
> > +                                                                               \
> > +       __asm__ __volatile__(                                                   \
> > +       "am"#asm_op"_db.d " " %1, %2, %0                \n"                     \
> > +       : "+ZB" (v->counter), "=&r" (result)                                    \
> > +       : "r" (I)                                                               \
> > +       : "memory");                                                            \
> > +                                                                               \
> > +       return result;                                                          \
> > +}
> > +
> > +#define ATOMIC64_OPS(op, I, asm_op, c_op)                                    \
> > +       ATOMIC64_OP(op, I, asm_op)                                            \
> > +       ATOMIC64_OP_RETURN(op, I, asm_op, c_op)                               \
> > +       ATOMIC64_FETCH_OP(op, I, asm_op)
> > +
> > +ATOMIC64_OPS(add, i, add, +)
> > +ATOMIC64_OPS(sub, -i, add, +)
> > +
> > +#define arch_atomic64_add_return_relaxed       arch_atomic64_add_return_relaxed
> > +#define arch_atomic64_sub_return_relaxed       arch_atomic64_sub_return_relaxed
> > +#define arch_atomic64_fetch_add_relaxed                arch_atomic64_fetch_add_relaxed
> > +#define arch_atomic64_fetch_sub_relaxed                arch_atomic64_fetch_sub_relaxed
> > +
> > +#undef ATOMIC64_OPS
> > +
> > +#define ATOMIC64_OPS(op, I, asm_op)                                          \
> > +       ATOMIC64_OP(op, I, asm_op)                                            \
> > +       ATOMIC64_FETCH_OP(op, I, asm_op)
> > +
> > +ATOMIC64_OPS(and, i, and)
> > +ATOMIC64_OPS(or, i, or)
> > +ATOMIC64_OPS(xor, i, xor)
> > +
> > +#define arch_atomic64_fetch_and_relaxed        arch_atomic64_fetch_and_relaxed
> > +#define arch_atomic64_fetch_or_relaxed arch_atomic64_fetch_or_relaxed
> > +#define arch_atomic64_fetch_xor_relaxed        arch_atomic64_fetch_xor_relaxed
> > +
> > +#undef ATOMIC64_OPS
> > +#undef ATOMIC64_FETCH_OP
> > +#undef ATOMIC64_OP_RETURN
> > +#undef ATOMIC64_OP
> > +
> > +static inline long arch_atomic64_fetch_add_unless(atomic64_t *v, long a, long u)
> > +{
> > +       long prev, rc;
> > +
> > +       __asm__ __volatile__ (
> Ditto
> > +               "0:     ll.d    %[p],  %[c]\n"
> > +               "       beq     %[p],  %[u], 1f\n"
> > +               "       add.d   %[rc], %[p], %[a]\n"
> > +               "       sc.d    %[rc], %[c]\n"
> > +               "       beqz    %[rc], 0b\n"
> Ditto
> > +               "       b       2f\n"
> > +               "1:\n"
> > +               __WEAK_LLSC_MB
> > +               "2:\n"
> > +               : [p]"=&r" (prev), [rc]"=&r" (rc),
> > +                 [c] "=ZB" (v->counter)
> > +               : [a]"r" (a), [u]"r" (u)
> > +               : "memory");
> > +
> > +       return prev;
> > +}
> > +#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
> > +
> > +/*
> > + * arch_atomic64_sub_if_positive - conditionally subtract integer from atomic variable
> > + * @i: integer value to subtract
> > + * @v: pointer of type atomic64_t
> > + *
> > + * Atomically test @v and subtract @i if @v is greater or equal than @i.
> > + * The function returns the old value of @v minus @i.
> > + */
> > +static inline long arch_atomic64_sub_if_positive(long i, atomic64_t *v)
> > +{
> > +       long result;
> > +       long temp;
> > +
> > +       if (__builtin_constant_p(i)) {
> > +               __asm__ __volatile__(
> Ditto
> > +               "1:     ll.d    %1, %2  # atomic64_sub_if_positive      \n"
> > +               "       addi.d  %0, %1, %3                              \n"
> > +               "       or      %1, %0, $zero                           \n"
> > +               "       blt     %0, $zero, 2f                           \n"
> > +               "       sc.d    %1, %2                                  \n"
> Ditto
> > +               "       beq     %1, $zero, 1b                           \n"
> > +               "2:                                                     \n"
> > +               : "=&r" (result), "=&r" (temp),
> > +                 "+" GCC_OFF_SMALL_ASM() (v->counter)
> > +               : "I" (-i));
> > +       } else {
> > +               __asm__ __volatile__(
> Ditto
> > +               "1:     ll.d    %1, %2  # atomic64_sub_if_positive      \n"
> > +               "       sub.d   %0, %1, %3                              \n"
> > +               "       or      %1, %0, $zero                           \n"
> > +               "       blt     %0, $zero, 2f                           \n"
> > +               "       sc.d    %1, %2                                  \n"
> Ditto
> > +               "       beq     %1, $zero, 1b                           \n"
> > +               "2:                                                     \n"
> > +               : "=&r" (result), "=&r" (temp),
> > +                 "+" GCC_OFF_SMALL_ASM() (v->counter)
> > +               : "r" (i));
> > +       }
> > +
> > +       return result;
> > +}
> > +
> > +#define arch_atomic64_cmpxchg(v, o, n) \
> > +       ((__typeof__((v)->counter))arch_cmpxchg(&((v)->counter), (o), (n)))
> > +#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), (new)))
> > +
> > +/*
> > + * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
> > + * @v: pointer of type atomic64_t
> > + */
> > +#define arch_atomic64_dec_if_positive(v)       arch_atomic64_sub_if_positive(1, v)
> > +
> > +#endif /* CONFIG_64BIT */
> > +
> > +#endif /* _ASM_ATOMIC_H */
> > diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/include/asm/barrier.h
> > new file mode 100644
> > index 000000000000..e57571bcaf4f
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/barrier.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __ASM_BARRIER_H
> > +#define __ASM_BARRIER_H
> > +
> > +#define __sync()       __asm__ __volatile__("dbar 0" : : : "memory")
> > +
> > +#define fast_wmb()     __sync()
> > +#define fast_rmb()     __sync()
> > +#define fast_mb()      __sync()
> > +#define fast_iob()     __sync()
> > +#define wbflush()      __sync()
> > +
> > +#define wmb()          fast_wmb()
> > +#define rmb()          fast_rmb()
> > +#define mb()           fast_mb()
> > +#define iob()          fast_iob()
> > +
> > +/**
> > + * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
> > + * @index: array element index
> > + * @size: number of elements in array
> > + *
> > + * Returns:
> > + *     0 - (@index < @size)
> > + */
> > +#define array_index_mask_nospec array_index_mask_nospec
> > +static inline unsigned long array_index_mask_nospec(unsigned long index,
> > +                                                   unsigned long size)
> > +{
> > +       unsigned long mask;
> > +
> > +       __asm__ __volatile__(
> > +               "sltu   %0, %1, %2\n\t"
> > +#if (__SIZEOF_LONG__ == 4)
> > +               "sub.w  %0, $r0, %0\n\t"
> > +#elif (__SIZEOF_LONG__ == 8)
> > +               "sub.d  %0, $r0, %0\n\t"
> > +#endif
> > +               : "=r" (mask)
> > +               : "r" (index), "r" (size)
> > +               :);
> > +
> > +       return mask;
> > +}
> > +
> > +#include <asm-generic/barrier.h>
> > +
> > +#endif /* __ASM_BARRIER_H */
> > diff --git a/arch/loongarch/include/asm/bitops.h b/arch/loongarch/include/asm/bitops.h
> > new file mode 100644
> > index 000000000000..69e00f8d8034
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/bitops.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_BITOPS_H
> > +#define _ASM_BITOPS_H
> > +
> > +#include <linux/compiler.h>
> > +
> > +#ifndef _LINUX_BITOPS_H
> > +#error only <linux/bitops.h> can be included directly
> > +#endif
> > +
> > +#include <asm/barrier.h>
> > +
> > +#include <asm-generic/bitops/builtin-ffs.h>
> > +#include <asm-generic/bitops/builtin-fls.h>
> > +#include <asm-generic/bitops/builtin-__ffs.h>
> > +#include <asm-generic/bitops/builtin-__fls.h>
> > +
> > +#include <asm-generic/bitops/ffz.h>
> > +#include <asm-generic/bitops/fls64.h>
> > +
> > +#include <asm-generic/bitops/sched.h>
> > +#include <asm-generic/bitops/hweight.h>
> > +
> > +#include <asm-generic/bitops/atomic.h>
> > +#include <asm-generic/bitops/non-atomic.h>
> > +#include <asm-generic/bitops/lock.h>
> > +#include <asm-generic/bitops/le.h>
> > +#include <asm-generic/bitops/ext2-atomic.h>
> > +
> > +#endif /* _ASM_BITOPS_H */
> > diff --git a/arch/loongarch/include/asm/bitrev.h b/arch/loongarch/include/asm/bitrev.h
> > new file mode 100644
> > index 000000000000..46f275b9cdf7
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/bitrev.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __LOONGARCH_ASM_BITREV_H__
> > +#define __LOONGARCH_ASM_BITREV_H__
> > +
> > +#include <linux/swab.h>
> > +
> > +static __always_inline __attribute_const__ u32 __arch_bitrev32(u32 x)
> > +{
> > +       u32 ret;
> > +
> > +       asm("bitrev.4b  %0, %1" : "=r"(ret) : "r"(__swab32(x)));
> > +       return ret;
> > +}
> > +
> > +static __always_inline __attribute_const__ u16 __arch_bitrev16(u16 x)
> > +{
> > +       u16 ret;
> > +
> > +       asm("bitrev.4b  %0, %1" : "=r"(ret) : "r"(__swab16(x)));
> > +       return ret;
> > +}
> > +
> > +static __always_inline __attribute_const__ u8 __arch_bitrev8(u8 x)
> > +{
> > +       u8 ret;
> > +
> > +       asm("bitrev.4b  %0, %1" : "=r"(ret) : "r"(x));
> > +       return ret;
> > +}
> > +
> > +#endif /* __LOONGARCH_ASM_BITREV_H__ */
> > diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
> > new file mode 100644
> > index 000000000000..699925b8ff27
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/cmpxchg.h
> > @@ -0,0 +1,121 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __ASM_CMPXCHG_H
> > +#define __ASM_CMPXCHG_H
> > +
> > +#include <linux/build_bug.h>
> > +
> > +#define __xchg_asm(amswap_db, m, val)          \
> > +({                                             \
> > +               __typeof(val) __ret;            \
> > +                                               \
> > +               __asm__ __volatile__ (          \
> > +               " "amswap_db" %1, %z2, %0 \n"   \
> > +               : "+ZB" (*m), "=&r" (__ret)     \
> > +               : "Jr" (val)                    \
> > +               : "memory");                    \
> > +                                               \
> > +               __ret;                          \
> > +})
> > +
> > +static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> relaxed ?
>
> > +                                  int size)
> > +{
> > +       switch (size) {
> > +       case 4:
> > +               return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
> Your amswap_db don't have any implicit acquire/release, right?
amswap don't have implicit acquire/release, but amswap_db has.

Huacai
>
> > +
> > +       case 8:
> > +               return __xchg_asm("amswap_db.d", (volatile u64 *)ptr, (u64)x);
> > +
> > +       default:
> > +               BUILD_BUG();
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +#define arch_xchg(ptr, x)                                              \
> > +({                                                                     \
> > +       __typeof__(*(ptr)) __res;                                       \
> > +                                                                       \
> > +       __res = (__typeof__(*(ptr)))                                    \
> > +               __xchg((ptr), (unsigned long)(x), sizeof(*(ptr)));      \
> > +                                                                       \
> > +       __res;                                                          \
> > +})
> > +
> > +#define __cmpxchg_asm(ld, st, m, old, new)                             \
> > +({                                                                     \
> > +       __typeof(old) __ret;                                            \
> > +                                                                       \
> > +       __asm__ __volatile__(                                           \
> > +       "1:     " ld "  %0, %2          # __cmpxchg_asm \n"             \
> > +       "       bne     %0, %z3, 2f                     \n"             \
> > +       "       or      $t0, %z4, $zero                 \n"             \
> > +       "       " st "  $t0, %1                         \n"             \
> > +       "       beq     $zero, $t0, 1b                  \n"             \
> > +       "2:                                             \n"             \
> > +       : "=&r" (__ret), "=ZB"(*m)                                      \
> > +       : "ZB"(*m), "Jr" (old), "Jr" (new)                              \
> > +       : "t0", "memory");                                              \
> > +                                                                       \
> > +       __ret;                                                          \
> > +})
> > +
> > +static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> > +                                     unsigned long new, unsigned int size)
> > +{
> > +       switch (size) {
> > +       case 4:
> > +               return __cmpxchg_asm("ll.w", "sc.w", (volatile u32 *)ptr,
> > +                                    (u32)old, new);
> > +
> > +       case 8:
> > +               return __cmpxchg_asm("ll.d", "sc.d", (volatile u64 *)ptr,
> > +                                    (u64)old, new);
> > +
> > +       default:
> > +               BUILD_BUG();
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +#define arch_cmpxchg_local(ptr, old, new)                              \
> > +       ((__typeof__(*(ptr)))                                           \
> > +               __cmpxchg((ptr),                                        \
> > +                         (unsigned long)(__typeof__(*(ptr)))(old),     \
> > +                         (unsigned long)(__typeof__(*(ptr)))(new),     \
> > +                         sizeof(*(ptr))))
> > +
> > +#define arch_cmpxchg(ptr, old, new)                                    \
> Ditto, it's a relaxed implementation, right?
> > +({                                                                     \
> > +       __typeof__(*(ptr)) __res;                                       \
> > +                                                                       \
> > +       __res = arch_cmpxchg_local((ptr), (old), (new));                \
> > +                                                                       \
> > +       __res;                                                          \
> > +})
> > +
> > +#ifdef CONFIG_64BIT
> > +#define arch_cmpxchg64_local(ptr, o, n)                                        \
> > +  ({                                                                   \
> > +       BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > +       arch_cmpxchg_local((ptr), (o), (n));                            \
> > +  })
> > +
> > +#define arch_cmpxchg64(ptr, o, n)                                      \
> > +  ({                                                                   \
> > +       BUILD_BUG_ON(sizeof(*(ptr)) != 8);                              \
> > +       arch_cmpxchg((ptr), (o), (n));                                  \
> > +  })
> > +#else
> > +#include <asm-generic/cmpxchg-local.h>
> > +#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
> > +#define arch_cmpxchg64(ptr, o, n) arch_cmpxchg64_local((ptr), (o), (n))
> > +#endif
> > +
> > +#endif /* __ASM_CMPXCHG_H */
> > diff --git a/arch/loongarch/include/asm/local.h b/arch/loongarch/include/asm/local.h
> > new file mode 100644
> > index 000000000000..2052a2267337
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/local.h
> > @@ -0,0 +1,138 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ARCH_LOONGARCH_LOCAL_H
> > +#define _ARCH_LOONGARCH_LOCAL_H
> > +
> > +#include <linux/percpu.h>
> > +#include <linux/bitops.h>
> > +#include <linux/atomic.h>
> > +#include <asm/cmpxchg.h>
> > +#include <asm/compiler.h>
> > +
> > +typedef struct {
> > +       atomic_long_t a;
> > +} local_t;
> > +
> > +#define LOCAL_INIT(i)  { ATOMIC_LONG_INIT(i) }
> > +
> > +#define local_read(l)  atomic_long_read(&(l)->a)
> > +#define local_set(l, i) atomic_long_set(&(l)->a, (i))
> > +
> > +#define local_add(i, l) atomic_long_add((i), (&(l)->a))
> > +#define local_sub(i, l) atomic_long_sub((i), (&(l)->a))
> > +#define local_inc(l)   atomic_long_inc(&(l)->a)
> > +#define local_dec(l)   atomic_long_dec(&(l)->a)
> > +
> > +/*
> > + * Same as above, but return the result value
> > + */
> > +static inline long local_add_return(long i, local_t *l)
> > +{
> > +       unsigned long result;
> > +
> > +       __asm__ __volatile__(
> > +       "   " __AMADD " %1, %2, %0      \n"
> > +       : "+ZB" (l->a.counter), "=&r" (result)
> > +       : "r" (i)
> > +       : "memory");
> > +       result = result + i;
> > +
> > +       return result;
> > +}
> > +
> > +static inline long local_sub_return(long i, local_t *l)
> > +{
> > +       unsigned long result;
> > +
> > +       __asm__ __volatile__(
> > +       "   " __AMADD "%1, %2, %0       \n"
> > +       : "+ZB" (l->a.counter), "=&r" (result)
> > +       : "r" (-i)
> > +       : "memory");
> > +
> > +       result = result - i;
> > +
> > +       return result;
> > +}
> > +
> > +#define local_cmpxchg(l, o, n) \
> > +       ((long)cmpxchg_local(&((l)->a.counter), (o), (n)))
> > +#define local_xchg(l, n) (atomic_long_xchg((&(l)->a), (n)))
> > +
> > +/**
> > + * local_add_unless - add unless the number is a given value
> > + * @l: pointer of type local_t
> > + * @a: the amount to add to l...
> > + * @u: ...unless l is equal to u.
> > + *
> > + * Atomically adds @a to @l, so long as it was not @u.
> > + * Returns non-zero if @l was not @u, and zero otherwise.
> > + */
> > +#define local_add_unless(l, a, u)                              \
> > +({                                                             \
> > +       long c, old;                                            \
> > +       c = local_read(l);                                      \
> > +       while (c != (u) && (old = local_cmpxchg((l), c, c + (a))) != c) \
> > +               c = old;                                        \
> > +       c != (u);                                               \
> > +})
> > +#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
> > +
> > +#define local_dec_return(l) local_sub_return(1, (l))
> > +#define local_inc_return(l) local_add_return(1, (l))
> > +
> > +/*
> > + * local_sub_and_test - subtract value from variable and test result
> > + * @i: integer value to subtract
> > + * @l: pointer of type local_t
> > + *
> > + * Atomically subtracts @i from @l and returns
> > + * true if the result is zero, or false for all
> > + * other cases.
> > + */
> > +#define local_sub_and_test(i, l) (local_sub_return((i), (l)) == 0)
> > +
> > +/*
> > + * local_inc_and_test - increment and test
> > + * @l: pointer of type local_t
> > + *
> > + * Atomically increments @l by 1
> > + * and returns true if the result is zero, or false for all
> > + * other cases.
> > + */
> > +#define local_inc_and_test(l) (local_inc_return(l) == 0)
> > +
> > +/*
> > + * local_dec_and_test - decrement by 1 and test
> > + * @l: pointer of type local_t
> > + *
> > + * Atomically decrements @l by 1 and
> > + * returns true if the result is 0, or false for all other
> > + * cases.
> > + */
> > +#define local_dec_and_test(l) (local_sub_return(1, (l)) == 0)
> > +
> > +/*
> > + * local_add_negative - add and test if negative
> > + * @l: pointer of type local_t
> > + * @i: integer value to add
> > + *
> > + * Atomically adds @i to @l and returns true
> > + * if the result is negative, or false when
> > + * result is greater than or equal to zero.
> > + */
> > +#define local_add_negative(i, l) (local_add_return(i, (l)) < 0)
> > +
> > +/* Use these for per-cpu local_t variables: on some archs they are
> > + * much more efficient than these naive implementations.  Note they take
> > + * a variable, not an address.
> > + */
> > +
> > +#define __local_inc(l)         ((l)->a.counter++)
> > +#define __local_dec(l)         ((l)->a.counter++)
> > +#define __local_add(i, l)      ((l)->a.counter += (i))
> > +#define __local_sub(i, l)      ((l)->a.counter -= (i))
> > +
> > +#endif /* _ARCH_LOONGARCH_LOCAL_H */
> > diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
> > new file mode 100644
> > index 000000000000..7d5b22ebd834
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/percpu.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef __ASM_PERCPU_H
> > +#define __ASM_PERCPU_H
> > +
> > +/* Use r21 for fast access */
> > +register unsigned long __my_cpu_offset __asm__("$r21");
> > +
> > +static inline void set_my_cpu_offset(unsigned long off)
> > +{
> > +       __my_cpu_offset = off;
> > +       csr_writeq(off, PERCPU_BASE_KS);
> > +}
> > +#define __my_cpu_offset __my_cpu_offset
> > +
> > +#include <asm-generic/percpu.h>
> > +
> > +#endif /* __ASM_PERCPU_H */
> > --
> > 2.27.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/

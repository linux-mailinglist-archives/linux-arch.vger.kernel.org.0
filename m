Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A197A706072
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjEQGvf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEQGvf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401AF9;
        Tue, 16 May 2023 23:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1347563644;
        Wed, 17 May 2023 06:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFECC433A0;
        Wed, 17 May 2023 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684306292;
        bh=ovB+UlXUx8JIYPdcBLhVUy/GyITfx1un/pPYF3FId1M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MfnGyTcFJ43qdJ7CFzaJhZ//KZ3CvfP6HyMDfZ3koQ4Vt7jG60J2QoWPiCjKoZ7DB
         ji8d1XtAIP124FAC3RH3Jkq96RkSQ4mgyNSxCjaZj/wp+f7ckWNhz8p5VZ9rZaDkFW
         MjvcdetollnrkiD8S9fPt5ihM23xlGb/I3wFOL5SfrciXJoucPT7rWTcstne3O3GTM
         7K23H9cu5qXHNko232VkTJ4JCfqmna5ntOP/6VtBc/ZQlQsn0Gn3I2jDj88WCBBQiq
         cICYeJhwxE7qt08Aq+6vwblZ8az/TuYUmT/Uy2os22uq8dzI/ugtWRMjt2WqZAsFcS
         k74jdyPsSM9Iw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso58688366b.2;
        Tue, 16 May 2023 23:51:32 -0700 (PDT)
X-Gm-Message-State: AC+VfDyT4FQAP4Vy8GWC5wLiZB1pmit3ujxt6REDefaVRlINoeq3RD8S
        dGsIFBvlkoVV1ew8paFvQV1KYd1rLlZyPeQ3410=
X-Google-Smtp-Source: ACHHUZ7Vo4dZ9DoWnI29ldbBEOl0wiOePam7HwdKFRDF5eaNOxSotjcneibDdx031Drh7V+pNV9bOukTfGaC0Api4OE=
X-Received: by 2002:a17:907:724d:b0:96a:7034:b32d with SMTP id
 ds13-20020a170907724d00b0096a7034b32dmr19580778ejc.27.1684306290501; Tue, 16
 May 2023 23:51:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230516124536.535343-1-chenhuacai@loongson.cn> <97b57aa9-b3c2-58bc-fa55-804056877d05@xen0n.name>
In-Reply-To: <97b57aa9-b3c2-58bc-fa55-804056877d05@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 17 May 2023 14:51:17 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4uc6FfgBCpSpnthwUFCs0-yrZe+r3ktxsr=MEfCzQVuA@mail.gmail.com>
Message-ID: <CAAhV-H4uc6FfgBCpSpnthwUFCs0-yrZe+r3ktxsr=MEfCzQVuA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Support dbar with different hints
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Jun Yi <yijun@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Tue, May 16, 2023 at 9:24=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> On 2023/5/16 20:45, Huacai Chen wrote:
> > Traditionally, LoongArch uses "dbar 0" (full completion barrier) for
> > everything. But the full completion barrier is a performance killer, so
> > Loongson-3A6000 and newer processors introduce different hints:
>
> "have made finer granularity hints available"
OK, thanks.

>
> >
> > Bit4: ordering or completion (0: completion, 1: ordering)
> > Bit3: barrier for previous read (0: true, 1: false)
> > Bit2: barrier for previous write (0: true, 1: false)
> > Bit1: barrier for succeeding read (0: true, 1: false)
> > Bit0: barrier for succedding write (0: true, 1: false)
>
> "succeeding"
OK, thanks.

>
> >
> > Hint 0x700: barrier for "read after read" from the same address, which
> > is needed by LL-SC loops.
>
> "needed by LL-SC loops on older models"?
Old models need this, whether new models need this depends on the
configuration. If the configuration doesn't allow "read after read on
the same address" reorder, dbar 0x700 behaves as nop, so we can use it
for all models.

>
> >
> > This patch enable various hints for different memory barries, it brings
> > performance improvements for Loongson-3A6000 series, and doesn't impact
> > Loongson-3A5000 series because they treat all hints as "dbar 0".
>
> "This patch makes use of the various new hints for different kinds of
> memory barriers. It brings performance improvements on Loongson-3A6000
> series, while not affecting the existing models because all variants are
> treated as 'dbar 0' there."
OK, thanks.

>
> >
> > Signed-off-by: Jun Yi <yijun@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   arch/loongarch/include/asm/barrier.h | 130 ++++++++++++--------------=
-
> >   arch/loongarch/include/asm/io.h      |   2 +-
> >   arch/loongarch/kernel/smp.c          |   2 +-
> >   arch/loongarch/mm/tlbex.S            |   6 +-
> >   4 files changed, 60 insertions(+), 80 deletions(-)
> >
> > diff --git a/arch/loongarch/include/asm/barrier.h b/arch/loongarch/incl=
ude/asm/barrier.h
> > index cda977675854..0286ae7e3636 100644
> > --- a/arch/loongarch/include/asm/barrier.h
> > +++ b/arch/loongarch/include/asm/barrier.h
> > @@ -5,27 +5,56 @@
> >   #ifndef __ASM_BARRIER_H
> >   #define __ASM_BARRIER_H
> >
> > -#define __sync()     __asm__ __volatile__("dbar 0" : : : "memory")
> > +/*
> > + * Hint types:
>
> "Hint encoding" might be more appropriate?
OK, thanks.

>
> > + *
> > + * Bit4: ordering or completion (0: completion, 1: ordering)
> > + * Bit3: barrier for previous read (0: true, 1: false)
> > + * Bit2: barrier for previous write (0: true, 1: false)
> > + * Bit1: barrier for succeeding read (0: true, 1: false)
> > + * Bit0: barrier for succedding write (0: true, 1: false)
>
> "succeeding"
OK, thanks.

>
> > + *
> > + * Hint 0x700: barrier for "read after read" from the same address
> > + */
> > +
> > +#define DBAR(hint) __asm__ __volatile__("dbar %0 " : : "I"(hint) : "me=
mory")
>
> Why not __builtin_loongarch_dbar (should be usable with both GCC and
> Clang) or __dbar (in <larchintrin.h>)?
The assembly is simple enough, and I think it is more portable.

>
> > +
> > +#define crwrw                0b00000
> > +#define cr_r_                0b00101
> > +#define c_w_w                0b01010
> >
> > -#define fast_wmb()   __sync()
> > -#define fast_rmb()   __sync()
> > -#define fast_mb()    __sync()
> > -#define fast_iob()   __sync()
> > -#define wbflush()    __sync()
> > +#define orwrw                0b10000
> > +#define or_r_                0b10101
> > +#define o_w_w                0b11010
> >
> > -#define wmb()                fast_wmb()
> > -#define rmb()                fast_rmb()
> > -#define mb()         fast_mb()
> > -#define iob()                fast_iob()
> > +#define orw_w                0b10010
> > +#define or_rw                0b10100
> >
> > -#define __smp_mb()   __asm__ __volatile__("dbar 0" : : : "memory")
> > -#define __smp_rmb()  __asm__ __volatile__("dbar 0" : : : "memory")
> > -#define __smp_wmb()  __asm__ __volatile__("dbar 0" : : : "memory")
> > +#define c_sync()     DBAR(crwrw)
> > +#define c_rsync()    DBAR(cr_r_)
> > +#define c_wsync()    DBAR(c_w_w)
> > +
> > +#define o_sync()     DBAR(orwrw)
> > +#define o_rsync()    DBAR(or_r_)
> > +#define o_wsync()    DBAR(o_w_w)
> > +
> > +#define ldacq_mb()   DBAR(or_rw)
> > +#define strel_mb()   DBAR(orw_w)
> > +
> > +#define mb()         c_sync()
> > +#define rmb()                c_rsync()
> > +#define wmb()                c_wsync()
> > +#define iob()                c_sync()
> > +#define wbflush()    c_sync()
> > +
> > +#define __smp_mb()   o_sync()
> > +#define __smp_rmb()  o_rsync()
> > +#define __smp_wmb()  o_wsync()
> >
> >   #ifdef CONFIG_SMP
> > -#define __WEAK_LLSC_MB               "       dbar 0  \n"
> > +#define __WEAK_LLSC_MB               "       dbar 0x700      \n"
> >   #else
> > -#define __WEAK_LLSC_MB               "               \n"
> > +#define __WEAK_LLSC_MB               "                       \n"
> >   #endif
> >
> >   #define __smp_mb__before_atomic()   barrier()
> > @@ -59,68 +88,19 @@ static inline unsigned long array_index_mask_nospec=
(unsigned long index,
> >       return mask;
> >   }
> >
> > -#define __smp_load_acquire(p)                                         =
               \
> > -({                                                                    =
       \
> > -     union { typeof(*p) __val; char __c[1]; } __u;                    =
       \
> > -     unsigned long __tmp =3D 0;                                       =
                 \
> > -     compiletime_assert_atomic_type(*p);                              =
       \
> > -     switch (sizeof(*p)) {                                            =
       \
> > -     case 1:                                                          =
       \
> > -             *(__u8 *)__u.__c =3D *(volatile __u8 *)p;                =
         \
> > -             __smp_mb();                                              =
       \
> > -             break;                                                   =
       \
> > -     case 2:                                                          =
       \
> > -             *(__u16 *)__u.__c =3D *(volatile __u16 *)p;              =
         \
> > -             __smp_mb();                                              =
       \
> > -             break;                                                   =
       \
> > -     case 4:                                                          =
       \
> > -             __asm__ __volatile__(                                    =
       \
> > -             "amor_db.w %[val], %[tmp], %[mem]       \n"              =
               \
> > -             : [val] "=3D&r" (*(__u32 *)__u.__c)                      =
         \
> > -             : [mem] "ZB" (*(u32 *) p), [tmp] "r" (__tmp)             =
       \
> > -             : "memory");                                             =
       \
> > -             break;                                                   =
       \
> > -     case 8:                                                          =
       \
> > -             __asm__ __volatile__(                                    =
       \
> > -             "amor_db.d %[val], %[tmp], %[mem]       \n"              =
               \
> > -             : [val] "=3D&r" (*(__u64 *)__u.__c)                      =
         \
> > -             : [mem] "ZB" (*(u64 *) p), [tmp] "r" (__tmp)             =
       \
> > -             : "memory");                                             =
       \
> > -             break;                                                   =
       \
> > -     }                                                                =
       \
> > -     (typeof(*p))__u.__val;                                           =
               \
> > +#define __smp_load_acquire(p)                                \
> > +({                                                   \
> > +     typeof(*p) ___p1 =3D READ_ONCE(*p);               \
> > +     compiletime_assert_atomic_type(*p);             \
> > +     ldacq_mb();                                     \
> > +     ___p1;                                          \
> >   })
> >
> > -#define __smp_store_release(p, v)                                     =
       \
> > -do {                                                                  =
       \
> > -     union { typeof(*p) __val; char __c[1]; } __u =3D                 =
         \
> > -             { .__val =3D (__force typeof(*p)) (v) };                 =
         \
> > -     unsigned long __tmp;                                             =
       \
> > -     compiletime_assert_atomic_type(*p);                              =
       \
> > -     switch (sizeof(*p)) {                                            =
       \
> > -     case 1:                                                          =
       \
> > -             __smp_mb();                                              =
       \
> > -             *(volatile __u8 *)p =3D *(__u8 *)__u.__c;                =
         \
> > -             break;                                                   =
       \
> > -     case 2:                                                          =
       \
> > -             __smp_mb();                                              =
       \
> > -             *(volatile __u16 *)p =3D *(__u16 *)__u.__c;              =
         \
> > -             break;                                                   =
       \
> > -     case 4:                                                          =
       \
> > -             __asm__ __volatile__(                                    =
       \
> > -             "amswap_db.w %[tmp], %[val], %[mem]     \n"              =
       \
> > -             : [mem] "+ZB" (*(u32 *)p), [tmp] "=3D&r" (__tmp)         =
         \
> > -             : [val] "r" (*(__u32 *)__u.__c)                          =
       \
> > -             : );                                                     =
       \
> > -             break;                                                   =
       \
> > -     case 8:                                                          =
       \
> > -             __asm__ __volatile__(                                    =
       \
> > -             "amswap_db.d %[tmp], %[val], %[mem]     \n"              =
       \
> > -             : [mem] "+ZB" (*(u64 *)p), [tmp] "=3D&r" (__tmp)         =
         \
> > -             : [val] "r" (*(__u64 *)__u.__c)                          =
       \
> > -             : );                                                     =
       \
> > -             break;                                                   =
       \
> > -     }                                                                =
       \
> > +#define __smp_store_release(p, v)                    \
> > +do {                                                 \
> > +     compiletime_assert_atomic_type(*p);             \
> > +     strel_mb();                                     \
> > +     WRITE_ONCE(*p, v);                              \
> >   } while (0)
> >
> >   #define __smp_store_mb(p, v)                                         =
               \
> > diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/a=
sm/io.h
> > index 545e2708fbf7..1c9410220040 100644
> > --- a/arch/loongarch/include/asm/io.h
> > +++ b/arch/loongarch/include/asm/io.h
> > @@ -62,7 +62,7 @@ extern pgprot_t pgprot_wc;
> >   #define ioremap_cache(offset, size) \
> >       ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
> >
> > -#define mmiowb() asm volatile ("dbar 0" ::: "memory")
> > +#define mmiowb() wmb()
> >
> >   /*
> >    * String version of I/O memory access operations.
> > diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
> > index ed167e244cda..8daa97148c8e 100644
> > --- a/arch/loongarch/kernel/smp.c
> > +++ b/arch/loongarch/kernel/smp.c
> > @@ -118,7 +118,7 @@ static u32 ipi_read_clear(int cpu)
> >       action =3D iocsr_read32(LOONGARCH_IOCSR_IPI_STATUS);
> >       /* Clear the ipi register to clear the interrupt */
> >       iocsr_write32(action, LOONGARCH_IOCSR_IPI_CLEAR);
> > -     smp_mb();
> > +     wbflush();
> >
> >       return action;
> >   }
> > diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
> > index 244e2f5aeee5..240ced55586e 100644
> > --- a/arch/loongarch/mm/tlbex.S
> > +++ b/arch/loongarch/mm/tlbex.S
> > @@ -184,7 +184,7 @@ tlb_huge_update_load:
> >       ertn
> >
> >   nopage_tlb_load:
> > -     dbar            0
> > +     dbar            0x700
> >       csrrd           ra, EXCEPTION_KS2
> >       la_abs          t0, tlb_do_page_fault_0
> >       jr              t0
> > @@ -333,7 +333,7 @@ tlb_huge_update_store:
> >       ertn
> >
> >   nopage_tlb_store:
> > -     dbar            0
> > +     dbar            0x700
> >       csrrd           ra, EXCEPTION_KS2
> >       la_abs          t0, tlb_do_page_fault_1
> >       jr              t0
> > @@ -480,7 +480,7 @@ tlb_huge_update_modify:
> >       ertn
> >
> >   nopage_tlb_modify:
> > -     dbar            0
> > +     dbar            0x700
> >       csrrd           ra, EXCEPTION_KS2
> >       la_abs          t0, tlb_do_page_fault_1
> >       jr              t0
>
> Due to not having the manuals, I cannot review any further, but I can at
> least see that semantics on older models should be reasonably conserved,
> and the new bits seem reasonable. Nice cleanups anyway, and thanks to
> all of you for listening to community voices!
Thank you all the same.

Huacai
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA65574CB
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 10:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiFWIEY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 04:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiFWIEV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 04:04:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14629443F4
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 01:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A530661BA3
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 08:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14420C3411B
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655971460;
        bh=W9F13nUUH++x1QvFinQ+pF83Qi6CvNA1tEYk3CJB5vs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EPx/W8Uazp1P3SJjypqfRLqO1Iuvv8npYekoqLFoF8RE+1ZdZsi9YeN2AO+HsfY2T
         HcWQ+6LduqerZ+v73k1H7GX+Ik72Rx0q5F6ESIZWgA88+4M0JHZtw1BWoy5XFwWZnr
         pb9u++O44ig8qpzjILdUL2ogdBPVtPzyKQbrwkE45vXkBgYKBTaCv0OCzLv3XhVYCB
         s/KcltrI/cvFD2ZjXPw0n+RaJrxfdK8MaEyEZhvLhGjiWim9QL+8Fof8gUkQj7oGnp
         Ru0QfGBtE1yk6B+IDpO9yx+26twtEgqAhL2B95pbX61SxtfZfbRJBg12sZGK9kwyN5
         /MdV35AMT5X6g==
Received: by mail-lj1-f171.google.com with SMTP id bn8so4977430ljb.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 01:04:19 -0700 (PDT)
X-Gm-Message-State: AJIora/+PG21wtL8fWvQoxCjBQegydWN6CgZARS0RWss7xo4v434Sa6g
        yXNwBs0O0GBDaDZa26L6zY6SMOY+zRdRb7F+aAo=
X-Google-Smtp-Source: AGRyM1tKlgTgGb/xnSBWsXm8jk5QVcEdflzha6Vw6Bf3jaOsNXaovqNCTnFdaTNl7j+FTuKEpISxZmC5fzqijqj/Kkg=
X-Received: by 2002:a2e:95c8:0:b0:255:abb5:d0e7 with SMTP id
 y8-20020a2e95c8000000b00255abb5d0e7mr3938882ljh.23.1655971458003; Thu, 23 Jun
 2022 01:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn> <CAJF2gTQF-e+OUw9VLFOUvFbyroMnxsYyYxCJepQVWnvOTsx1HQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQF-e+OUw9VLFOUvFbyroMnxsYyYxCJepQVWnvOTsx1HQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 23 Jun 2022 16:04:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4O__55JFr9eoYnitdDUXvtFm2p1k-wniVNqK7OB2uVYA@mail.gmail.com>
Message-ID: <CAAhV-H4O__55JFr9eoYnitdDUXvtFm2p1k-wniVNqK7OB2uVYA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] LoongArch: Add subword xchg/cmpxchg emulation
To:     Guo Ren <guoren@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Rui Wang <wangrui@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Ren,

On Thu, Jun 23, 2022 at 2:49 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Jun 23, 2022 at 12:46 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > LoongArch only support 32-bit/64-bit xchg/cmpxchg in native. But percpu
> > operation and qspinlock need 8-bit/16-bit xchg/cmpxchg. On NUMA system,
> > the performance of subword xchg/cmpxchg emulation is better than the
> > generic implementation (especially for qspinlock, data will be shown in
> > the next patch). This patch (of 2) adds subword xchg/cmpxchg emulation
> > with ll/sc and enable its usage for percpu operations.
> The xchg/cmpxchg are designed for multi-processor data-sharing issues.
> The percpu data won't share with other harts and disabling
> irq/preemption is enough. Do you have the same issue with f97fc810798c
> ("arm64: percpu: Implement this_cpu operations")?
Yes, very similar, our csr operations are even slower than atomic operations. :(

>
>
> >
> > Signed-off-by: Rui Wang <wangrui@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/asm/cmpxchg.h | 98 +++++++++++++++++++++++++++-
> >  arch/loongarch/include/asm/percpu.h  |  8 +++
> >  2 files changed, 105 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
> > index 75b3a4478652..967e64bf2c37 100644
> > --- a/arch/loongarch/include/asm/cmpxchg.h
> > +++ b/arch/loongarch/include/asm/cmpxchg.h
> > @@ -5,8 +5,9 @@
> >  #ifndef __ASM_CMPXCHG_H
> >  #define __ASM_CMPXCHG_H
> >
> > -#include <asm/barrier.h>
> > +#include <linux/bits.h>
> >  #include <linux/build_bug.h>
> > +#include <asm/barrier.h>
> >
> >  #define __xchg_asm(amswap_db, m, val)          \
> >  ({                                             \
> > @@ -21,10 +22,53 @@
> >                 __ret;                          \
> >  })
> >
> > +static inline unsigned int __xchg_small(volatile void *ptr, unsigned int val,
> > +                                       unsigned int size)
> > +{
> > +       unsigned int shift;
> > +       u32 old32, mask, temp;
> > +       volatile u32 *ptr32;
> > +
> > +       /* Mask value to the correct size. */
> > +       mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> > +       val &= mask;
> > +
> > +       /*
> > +        * Calculate a shift & mask that correspond to the value we wish to
> > +        * exchange within the naturally aligned 4 byte integerthat includes
> > +        * it.
> > +        */
> > +       shift = (unsigned long)ptr & 0x3;
> > +       shift *= BITS_PER_BYTE;
> > +       mask <<= shift;
> > +
> > +       /*
> > +        * Calculate a pointer to the naturally aligned 4 byte integer that
> > +        * includes our byte of interest, and load its value.
> > +        */
> > +       ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> > +
> > +       asm volatile (
> > +       "1:     ll.w            %0, %3          \n"
> > +       "       andn            %1, %0, %z4     \n"
> > +       "       or              %1, %1, %z5     \n"
> > +       "       sc.w            %1, %2          \n"
> > +       "       beqz            %1, 1b          \n"
> > +       : "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
> > +       : GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (mask), "Jr" (val << shift)
> > +       : "memory");
> > +
> > +       return (old32 & mask) >> shift;
> > +}
> > +
> >  static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> >                                    int size)
> >  {
> >         switch (size) {
> > +       case 1:
> > +       case 2:
> > +               return __xchg_small(ptr, x, size);
> > +
> >         case 4:
> >                 return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
> >
> > @@ -67,10 +111,62 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> >         __ret;                                                          \
> >  })
> >
> > +static inline unsigned int __cmpxchg_small(volatile void *ptr, unsigned int old,
> > +                                          unsigned int new, unsigned int size)
> > +{
> > +       unsigned int shift;
> > +       u32 old32, mask, temp;
> > +       volatile u32 *ptr32;
> > +
> > +       /* Mask inputs to the correct size. */
> > +       mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> > +       old &= mask;
> > +       new &= mask;
> > +
> > +       /*
> > +        * Calculate a shift & mask that correspond to the value we wish to
> > +        * compare & exchange within the naturally aligned 4 byte integer
> > +        * that includes it.
> > +        */
> > +       shift = (unsigned long)ptr & 0x3;
> > +       shift *= BITS_PER_BYTE;
> > +       old <<= shift;
> > +       new <<= shift;
> > +       mask <<= shift;
> > +
> > +       /*
> > +        * Calculate a pointer to the naturally aligned 4 byte integer that
> > +        * includes our byte of interest, and load its value.
> > +        */
> > +       ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> > +
> > +       asm volatile (
> > +       "1:     ll.w            %0, %3          \n"
> > +       "       and             %1, %0, %z4     \n"
> > +       "       bne             %1, %z5, 2f     \n"
> > +       "       andn            %1, %0, %z4     \n"
> > +       "       or              %1, %1, %z6     \n"
> > +       "       sc.w            %1, %2          \n"
> > +       "       beqz            %1, 1b          \n"
> > +       "       b               3f              \n"
> > +       "2:                                     \n"
> > +       __WEAK_LLSC_MB
> > +       "3:                                     \n"
> > +       : "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
> > +       : GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (mask), "Jr" (old), "Jr" (new)
> > +       : "memory");
> > +
> > +       return (old32 & mask) >> shift;
> > +}
> > +
> >  static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> >                                       unsigned long new, unsigned int size)
> >  {
> >         switch (size) {
> > +       case 1:
> > +       case 2:
> > +               return __cmpxchg_small(ptr, old, new, size);
> > +
> >         case 4:
> >                 return __cmpxchg_asm("ll.w", "sc.w", (volatile u32 *)ptr,
> >                                      (u32)old, new);
> > diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
> > index e6569f18c6dd..0bd6b0110198 100644
> > --- a/arch/loongarch/include/asm/percpu.h
> > +++ b/arch/loongarch/include/asm/percpu.h
> > @@ -123,6 +123,10 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
> >                                                 int size)
> >  {
> >         switch (size) {
> > +       case 1:
> > +       case 2:
> > +               return __xchg_small((volatile void *)ptr, val, size);
> > +
> >         case 4:
> >                 return __xchg_asm("amswap.w", (volatile u32 *)ptr, (u32)val);
> The percpu operations are local and we shouldn't combine them with the
> normal xchg/cmpxchg (They have different semantics one for local, one
> for share.), please implement your own percpu ops here to fix the irq
> disable/enable performance issue.
Yes, percpu operations are local and atomic operations are for
sharing. But we are using atomic ops to implement percpu ops (for
performance), so just implementing common emulated operations and
using it for both percpu ops and qspinlock is just OK?

Huacai
>
> >
> > @@ -204,9 +208,13 @@ do {                                                                       \
> >  #define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
> >  #define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
> >
> > +#define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
> > +#define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
> >  #define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
> >  #define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
> >
> > +#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> > +#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> >  #define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> >  #define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> >
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

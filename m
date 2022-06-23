Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D567B5575BC
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 10:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiFWIng (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 04:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiFWInf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 04:43:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD4D49250
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 01:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8E0FB82206
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 08:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2A6C341C7
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 08:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655973811;
        bh=1SmrLtg/dZvPnbdyKt5xE9DmhbJI/omhXuaynaptDnk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nxmvN7PMpuaICpQeaQSu1+4fpwFrtYXTn2ippOCnFBtYYqIGJ4wC20I8R5LzNKI4n
         vbIU3Gx9ZEhUP8otxP6wFhl3YOGcvRgmmNcjyQ6rC5A15yzOUTwwPlUy33tA25GrG7
         MnMRDoc5XaZK1xmTXXL/huHzpzBtlO7juml2tdMqciPm/IBDFBTAL82NOepXWtdSMY
         Mt3mG8o8C7nW5JP0Qm9ZwaYy76Z4xh0BCoR2WmlBVmoaaoth25JCxrufGWhNk7wnXh
         wdYcwe+sLgdMXIcpjIKPl1DjIxttgvmT5O/XIi7bXQVuTNy5p5H+MCfQlRYDpiKVML
         VyCRBBfvOBc1g==
Received: by mail-vk1-f182.google.com with SMTP id h26so2493021vkc.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 01:43:31 -0700 (PDT)
X-Gm-Message-State: AJIora93e9H/8ORjKUAs2ECOV7mN42fpc9bu54FyvAkZksA0gsg3yDAk
        4spXOGAbw71QJwAoGj0QRW4GS3SpMVsHJQ0qOKk=
X-Google-Smtp-Source: AGRyM1sndJc0K6nOroTmaV5Dw08JPV03PM+rRjnWDZu1Y8v0SoWaH2qGiWZHghLYNWdR5ou3BvJA4lKMwhTuxqbhJEQ=
X-Received: by 2002:a1f:1b4b:0:b0:36c:bc20:3982 with SMTP id
 b72-20020a1f1b4b000000b0036cbc203982mr289898vkb.8.1655973810453; Thu, 23 Jun
 2022 01:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
 <CAJF2gTQF-e+OUw9VLFOUvFbyroMnxsYyYxCJepQVWnvOTsx1HQ@mail.gmail.com> <CAAhV-H4O__55JFr9eoYnitdDUXvtFm2p1k-wniVNqK7OB2uVYA@mail.gmail.com>
In-Reply-To: <CAAhV-H4O__55JFr9eoYnitdDUXvtFm2p1k-wniVNqK7OB2uVYA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 23 Jun 2022 16:43:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQBjetiA1eDaXhBsiEmRYCdOAAWWAGcwVjhZTBYH5BpGQ@mail.gmail.com>
Message-ID: <CAJF2gTQBjetiA1eDaXhBsiEmRYCdOAAWWAGcwVjhZTBYH5BpGQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] LoongArch: Add subword xchg/cmpxchg emulation
To:     Huacai Chen <chenhuacai@kernel.org>
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

On Thu, Jun 23, 2022 at 4:04 PM Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Hi, Ren,
>
> On Thu, Jun 23, 2022 at 2:49 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Thu, Jun 23, 2022 at 12:46 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > LoongArch only support 32-bit/64-bit xchg/cmpxchg in native. But percpu
> > > operation and qspinlock need 8-bit/16-bit xchg/cmpxchg. On NUMA system,
> > > the performance of subword xchg/cmpxchg emulation is better than the
> > > generic implementation (especially for qspinlock, data will be shown in
> > > the next patch). This patch (of 2) adds subword xchg/cmpxchg emulation
> > > with ll/sc and enable its usage for percpu operations.
> > The xchg/cmpxchg are designed for multi-processor data-sharing issues.
> > The percpu data won't share with other harts and disabling
> > irq/preemption is enough. Do you have the same issue with f97fc810798c
> > ("arm64: percpu: Implement this_cpu operations")?
> Yes, very similar, our csr operations are even slower than atomic operations. :(
>
> >
> >
> > >
> > > Signed-off-by: Rui Wang <wangrui@loongson.cn>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > >  arch/loongarch/include/asm/cmpxchg.h | 98 +++++++++++++++++++++++++++-
> > >  arch/loongarch/include/asm/percpu.h  |  8 +++
> > >  2 files changed, 105 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
> > > index 75b3a4478652..967e64bf2c37 100644
> > > --- a/arch/loongarch/include/asm/cmpxchg.h
> > > +++ b/arch/loongarch/include/asm/cmpxchg.h
> > > @@ -5,8 +5,9 @@
> > >  #ifndef __ASM_CMPXCHG_H
> > >  #define __ASM_CMPXCHG_H
> > >
> > > -#include <asm/barrier.h>
> > > +#include <linux/bits.h>
> > >  #include <linux/build_bug.h>
> > > +#include <asm/barrier.h>
> > >
> > >  #define __xchg_asm(amswap_db, m, val)          \
> > >  ({                                             \
> > > @@ -21,10 +22,53 @@
> > >                 __ret;                          \
> > >  })
> > >
> > > +static inline unsigned int __xchg_small(volatile void *ptr, unsigned int val,
> > > +                                       unsigned int size)
> > > +{
> > > +       unsigned int shift;
> > > +       u32 old32, mask, temp;
> > > +       volatile u32 *ptr32;
> > > +
> > > +       /* Mask value to the correct size. */
> > > +       mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> > > +       val &= mask;
> > > +
> > > +       /*
> > > +        * Calculate a shift & mask that correspond to the value we wish to
> > > +        * exchange within the naturally aligned 4 byte integerthat includes
> > > +        * it.
> > > +        */
> > > +       shift = (unsigned long)ptr & 0x3;
> > > +       shift *= BITS_PER_BYTE;
> > > +       mask <<= shift;
> > > +
> > > +       /*
> > > +        * Calculate a pointer to the naturally aligned 4 byte integer that
> > > +        * includes our byte of interest, and load its value.
> > > +        */
> > > +       ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> > > +
> > > +       asm volatile (
> > > +       "1:     ll.w            %0, %3          \n"
> > > +       "       andn            %1, %0, %z4     \n"
> > > +       "       or              %1, %1, %z5     \n"
> > > +       "       sc.w            %1, %2          \n"
> > > +       "       beqz            %1, 1b          \n"
> > > +       : "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
> > > +       : GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (mask), "Jr" (val << shift)
> > > +       : "memory");
> > > +
> > > +       return (old32 & mask) >> shift;
> > > +}
> > > +
> > >  static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> > >                                    int size)
> > >  {
> > >         switch (size) {
> > > +       case 1:
> > > +       case 2:
> > > +               return __xchg_small(ptr, x, size);
> > > +
> > >         case 4:
> > >                 return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
> > >
> > > @@ -67,10 +111,62 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
> > >         __ret;                                                          \
> > >  })
> > >
> > > +static inline unsigned int __cmpxchg_small(volatile void *ptr, unsigned int old,
> > > +                                          unsigned int new, unsigned int size)
> > > +{
> > > +       unsigned int shift;
> > > +       u32 old32, mask, temp;
> > > +       volatile u32 *ptr32;
> > > +
> > > +       /* Mask inputs to the correct size. */
> > > +       mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> > > +       old &= mask;
> > > +       new &= mask;
> > > +
> > > +       /*
> > > +        * Calculate a shift & mask that correspond to the value we wish to
> > > +        * compare & exchange within the naturally aligned 4 byte integer
> > > +        * that includes it.
> > > +        */
> > > +       shift = (unsigned long)ptr & 0x3;
> > > +       shift *= BITS_PER_BYTE;
> > > +       old <<= shift;
> > > +       new <<= shift;
> > > +       mask <<= shift;
> > > +
> > > +       /*
> > > +        * Calculate a pointer to the naturally aligned 4 byte integer that
> > > +        * includes our byte of interest, and load its value.
> > > +        */
> > > +       ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> > > +
> > > +       asm volatile (
> > > +       "1:     ll.w            %0, %3          \n"
> > > +       "       and             %1, %0, %z4     \n"
> > > +       "       bne             %1, %z5, 2f     \n"
> > > +       "       andn            %1, %0, %z4     \n"
> > > +       "       or              %1, %1, %z6     \n"
> > > +       "       sc.w            %1, %2          \n"
> > > +       "       beqz            %1, 1b          \n"
> > > +       "       b               3f              \n"
> > > +       "2:                                     \n"
> > > +       __WEAK_LLSC_MB
> > > +       "3:                                     \n"
> > > +       : "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
> > > +       : GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (mask), "Jr" (old), "Jr" (new)
> > > +       : "memory");
> > > +
> > > +       return (old32 & mask) >> shift;
> > > +}
> > > +
> > >  static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
> > >                                       unsigned long new, unsigned int size)
> > >  {
> > >         switch (size) {
> > > +       case 1:
> > > +       case 2:
> > > +               return __cmpxchg_small(ptr, old, new, size);
> > > +
> > >         case 4:
> > >                 return __cmpxchg_asm("ll.w", "sc.w", (volatile u32 *)ptr,
> > >                                      (u32)old, new);
> > > diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
> > > index e6569f18c6dd..0bd6b0110198 100644
> > > --- a/arch/loongarch/include/asm/percpu.h
> > > +++ b/arch/loongarch/include/asm/percpu.h
> > > @@ -123,6 +123,10 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
> > >                                                 int size)
> > >  {
> > >         switch (size) {
> > > +       case 1:
> > > +       case 2:
> > > +               return __xchg_small((volatile void *)ptr, val, size);
> > > +
> > >         case 4:
> > >                 return __xchg_asm("amswap.w", (volatile u32 *)ptr, (u32)val);
> > The percpu operations are local and we shouldn't combine them with the
> > normal xchg/cmpxchg (They have different semantics one for local, one
> > for share.), please implement your own percpu ops here to fix the irq
> > disable/enable performance issue.
> Yes, percpu operations are local and atomic operations are for
> sharing. But we are using atomic ops to implement percpu ops (for
> performance), so just implementing common emulated operations and
> using it for both percpu ops and qspinlock is just OK?
No, separating them would be fine. The qspinlock only needs
xchg16_relaxed and just leave that in loongarch's cmpxchg.h. That
would be easier for Arnd to cleanup xchg/cmpxchg.

>
> Huacai
> >
> > >
> > > @@ -204,9 +208,13 @@ do {                                                                       \
> > >  #define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
> > >  #define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
> > >
> > > +#define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
> > > +#define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
> > >  #define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
> > >  #define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
> > >
> > > +#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> > > +#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> > >  #define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> > >  #define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> > >
> > > --
> > > 2.27.0
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

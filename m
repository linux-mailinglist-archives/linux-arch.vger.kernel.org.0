Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4225557350
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jun 2022 08:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiFWGtz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiFWGty (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 02:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A2C44761
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2022 23:49:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E1AC6189A
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 06:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39F7C341C5
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2022 06:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655966992;
        bh=FNW5NN00nyYD6AI8NWKJhiUyqCHn2W6/uJcgpMePZvw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZybCNAXK4+Q8xJBDDZr9f/R2s4mgErQs2oGm0q4/Jf57dqt4Bbj/teIBY6Mo94Ior
         BnDHtfSM1US4rqN4w/FHnaiT5jbuIJ1oO9rK9H6yFD3XJJo8YMwfcSO7OhfkKssK1b
         F28042PWWGtAb9Jmj18kuTy2HSx/g7EbAoa1vRKBFtWQ42ucahgAIFa+QCnp6r7YAh
         Mkk3eo1TSYmhUYtKQ0sD7c+Hp/ldTwedExKWPb5+57aHj3YJJPnbP30jqVPzO5U3Ls
         SnR+O4TJRirJxmKYTIbkfrmEqu4iNG0AJMkAzPBv8WBx00ub/ehEuNAhXgU8wDh/YQ
         VaS5aDPoRFGYA==
Received: by mail-vk1-f181.google.com with SMTP id 8so4210730vkg.10
        for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2022 23:49:52 -0700 (PDT)
X-Gm-Message-State: AJIora9fdtVxmaexx6vlP5F//2qNMKxOJoO2w882EvIIJ8wy1P034Ooa
        15TFsUK79Tt+4oVMjOpdjJOKZJ59S5tlaRjMvmY=
X-Google-Smtp-Source: AGRyM1vERNIehdTyzMcVTJQS2KWvw+XXriahB6jjCQ8nZPxXgLSgA83JXpMzoGTd/AE5Y3JzTkdn388WeH7T2aVR/KI=
X-Received: by 2002:a1f:1bc8:0:b0:36c:a88c:961a with SMTP id
 b191-20020a1f1bc8000000b0036ca88c961amr1330446vkb.2.1655966991736; Wed, 22
 Jun 2022 23:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220623044752.2074066-1-chenhuacai@loongson.cn>
In-Reply-To: <20220623044752.2074066-1-chenhuacai@loongson.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 23 Jun 2022 14:49:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQF-e+OUw9VLFOUvFbyroMnxsYyYxCJepQVWnvOTsx1HQ@mail.gmail.com>
Message-ID: <CAJF2gTQF-e+OUw9VLFOUvFbyroMnxsYyYxCJepQVWnvOTsx1HQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] LoongArch: Add subword xchg/cmpxchg emulation
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, linux-arch <linux-arch@vger.kernel.org>,
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

On Thu, Jun 23, 2022 at 12:46 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> LoongArch only support 32-bit/64-bit xchg/cmpxchg in native. But percpu
> operation and qspinlock need 8-bit/16-bit xchg/cmpxchg. On NUMA system,
> the performance of subword xchg/cmpxchg emulation is better than the
> generic implementation (especially for qspinlock, data will be shown in
> the next patch). This patch (of 2) adds subword xchg/cmpxchg emulation
> with ll/sc and enable its usage for percpu operations.
The xchg/cmpxchg are designed for multi-processor data-sharing issues.
The percpu data won't share with other harts and disabling
irq/preemption is enough. Do you have the same issue with f97fc810798c
("arm64: percpu: Implement this_cpu operations")?


>
> Signed-off-by: Rui Wang <wangrui@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/cmpxchg.h | 98 +++++++++++++++++++++++++++-
>  arch/loongarch/include/asm/percpu.h  |  8 +++
>  2 files changed, 105 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/include/asm/cmpxchg.h
> index 75b3a4478652..967e64bf2c37 100644
> --- a/arch/loongarch/include/asm/cmpxchg.h
> +++ b/arch/loongarch/include/asm/cmpxchg.h
> @@ -5,8 +5,9 @@
>  #ifndef __ASM_CMPXCHG_H
>  #define __ASM_CMPXCHG_H
>
> -#include <asm/barrier.h>
> +#include <linux/bits.h>
>  #include <linux/build_bug.h>
> +#include <asm/barrier.h>
>
>  #define __xchg_asm(amswap_db, m, val)          \
>  ({                                             \
> @@ -21,10 +22,53 @@
>                 __ret;                          \
>  })
>
> +static inline unsigned int __xchg_small(volatile void *ptr, unsigned int val,
> +                                       unsigned int size)
> +{
> +       unsigned int shift;
> +       u32 old32, mask, temp;
> +       volatile u32 *ptr32;
> +
> +       /* Mask value to the correct size. */
> +       mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> +       val &= mask;
> +
> +       /*
> +        * Calculate a shift & mask that correspond to the value we wish to
> +        * exchange within the naturally aligned 4 byte integerthat includes
> +        * it.
> +        */
> +       shift = (unsigned long)ptr & 0x3;
> +       shift *= BITS_PER_BYTE;
> +       mask <<= shift;
> +
> +       /*
> +        * Calculate a pointer to the naturally aligned 4 byte integer that
> +        * includes our byte of interest, and load its value.
> +        */
> +       ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> +
> +       asm volatile (
> +       "1:     ll.w            %0, %3          \n"
> +       "       andn            %1, %0, %z4     \n"
> +       "       or              %1, %1, %z5     \n"
> +       "       sc.w            %1, %2          \n"
> +       "       beqz            %1, 1b          \n"
> +       : "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
> +       : GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (mask), "Jr" (val << shift)
> +       : "memory");
> +
> +       return (old32 & mask) >> shift;
> +}
> +
>  static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
>                                    int size)
>  {
>         switch (size) {
> +       case 1:
> +       case 2:
> +               return __xchg_small(ptr, x, size);
> +
>         case 4:
>                 return __xchg_asm("amswap_db.w", (volatile u32 *)ptr, (u32)x);
>
> @@ -67,10 +111,62 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long x,
>         __ret;                                                          \
>  })
>
> +static inline unsigned int __cmpxchg_small(volatile void *ptr, unsigned int old,
> +                                          unsigned int new, unsigned int size)
> +{
> +       unsigned int shift;
> +       u32 old32, mask, temp;
> +       volatile u32 *ptr32;
> +
> +       /* Mask inputs to the correct size. */
> +       mask = GENMASK((size * BITS_PER_BYTE) - 1, 0);
> +       old &= mask;
> +       new &= mask;
> +
> +       /*
> +        * Calculate a shift & mask that correspond to the value we wish to
> +        * compare & exchange within the naturally aligned 4 byte integer
> +        * that includes it.
> +        */
> +       shift = (unsigned long)ptr & 0x3;
> +       shift *= BITS_PER_BYTE;
> +       old <<= shift;
> +       new <<= shift;
> +       mask <<= shift;
> +
> +       /*
> +        * Calculate a pointer to the naturally aligned 4 byte integer that
> +        * includes our byte of interest, and load its value.
> +        */
> +       ptr32 = (volatile u32 *)((unsigned long)ptr & ~0x3);
> +
> +       asm volatile (
> +       "1:     ll.w            %0, %3          \n"
> +       "       and             %1, %0, %z4     \n"
> +       "       bne             %1, %z5, 2f     \n"
> +       "       andn            %1, %0, %z4     \n"
> +       "       or              %1, %1, %z6     \n"
> +       "       sc.w            %1, %2          \n"
> +       "       beqz            %1, 1b          \n"
> +       "       b               3f              \n"
> +       "2:                                     \n"
> +       __WEAK_LLSC_MB
> +       "3:                                     \n"
> +       : "=&r" (old32), "=&r" (temp), "=" GCC_OFF_SMALL_ASM() (*ptr32)
> +       : GCC_OFF_SMALL_ASM() (*ptr32), "Jr" (mask), "Jr" (old), "Jr" (new)
> +       : "memory");
> +
> +       return (old32 & mask) >> shift;
> +}
> +
>  static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>                                       unsigned long new, unsigned int size)
>  {
>         switch (size) {
> +       case 1:
> +       case 2:
> +               return __cmpxchg_small(ptr, old, new, size);
> +
>         case 4:
>                 return __cmpxchg_asm("ll.w", "sc.w", (volatile u32 *)ptr,
>                                      (u32)old, new);
> diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
> index e6569f18c6dd..0bd6b0110198 100644
> --- a/arch/loongarch/include/asm/percpu.h
> +++ b/arch/loongarch/include/asm/percpu.h
> @@ -123,6 +123,10 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
>                                                 int size)
>  {
>         switch (size) {
> +       case 1:
> +       case 2:
> +               return __xchg_small((volatile void *)ptr, val, size);
> +
>         case 4:
>                 return __xchg_asm("amswap.w", (volatile u32 *)ptr, (u32)val);
The percpu operations are local and we shouldn't combine them with the
normal xchg/cmpxchg (They have different semantics one for local, one
for share.), please implement your own percpu ops here to fix the irq
disable/enable performance issue.

>
> @@ -204,9 +208,13 @@ do {                                                                       \
>  #define this_cpu_write_4(pcp, val) _percpu_write(pcp, val)
>  #define this_cpu_write_8(pcp, val) _percpu_write(pcp, val)
>
> +#define this_cpu_xchg_1(pcp, val) _percpu_xchg(pcp, val)
> +#define this_cpu_xchg_2(pcp, val) _percpu_xchg(pcp, val)
>  #define this_cpu_xchg_4(pcp, val) _percpu_xchg(pcp, val)
>  #define this_cpu_xchg_8(pcp, val) _percpu_xchg(pcp, val)
>
> +#define this_cpu_cmpxchg_1(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
> +#define this_cpu_cmpxchg_2(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
>  #define this_cpu_cmpxchg_4(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
>  #define this_cpu_cmpxchg_8(ptr, o, n) _protect_cmpxchg_local(ptr, o, n)
>
> --
> 2.27.0
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

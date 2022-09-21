Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6C95BFC5B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIUKcM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 06:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiIUKcK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 06:32:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813890822;
        Wed, 21 Sep 2022 03:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDA6FB81F05;
        Wed, 21 Sep 2022 10:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E428C43145;
        Wed, 21 Sep 2022 10:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663756326;
        bh=RO40wJv6C6r0uIN8oUy8Bnx6thZE549fS8XAeveAnzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RnMsd+m+liySDC4jM3W4ZgpYEBqlc92oTTnRVkuMj/FjPFASi7pij/KntxZUetnEg
         l2NgM57Iuw/L9OZv80Oz+A4gxoJEvgBBViJ6tyMkHYkzQSxNPgiSBKoj7cEOAmsk1f
         /Zg+fOAoFmE5VzN4C39BwlwDFY0mdaiq5Q0n8UkOOGS7Gb6rM1+5BPwKg5J6asyNy+
         YnplcSsgleIeAzZS3vXu9GJ8S3k+P4JvZYF6varP6oWXCOOGC/RHUKaGblVp9Y4owD
         wyPKQwqdunw8YRWydIsrd+Or4VRBLQgvNGAVaZ1BuiH48nfbVkE8DA0xkGjr8SU7wM
         ZA7oYf5ZzwUrw==
Received: by mail-oi1-f176.google.com with SMTP id c81so5293302oif.3;
        Wed, 21 Sep 2022 03:32:06 -0700 (PDT)
X-Gm-Message-State: ACrzQf0yhocn011Vfz7aw8W9g3i4ALBEzVkNmi3ynnspYMwEd0bFLIeu
        mKU5md/nbsvk5Ukmqt3llpb2+/8Pp0LwRDKv3tI=
X-Google-Smtp-Source: AMsMyM4I9eDtJF76P9tPl5czQg+bMIJuYsfIPbg4wB/spY5r7eg4gvt+hbea7dg77NFoOMkXpT5l3NN/NvbTNcENtxQ=
X-Received: by 2002:a05:6808:201f:b0:34f:9fdf:dbbf with SMTP id
 q31-20020a056808201f00b0034f9fdfdbbfmr3457106oiw.19.1663756325508; Wed, 21
 Sep 2022 03:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com> <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com> <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
 <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com>
 <7a2379cf-c1cf-46af-9172-334d2b9b88d5@www.fastmail.com> <CAJF2gTSvaNh_m_hrub5Z=kqLAYJfRbpYzB1Mc5aOgdN+Bm8bag@mail.gmail.com>
 <CAJF2gTQGB97kh=47dsZ8MFpTTpy7pxYyd=MoLOUzgF9kTm1wdA@mail.gmail.com>
In-Reply-To: <CAJF2gTQGB97kh=47dsZ8MFpTTpy7pxYyd=MoLOUzgF9kTm1wdA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 18:31:52 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSWHMfE-Tyn=cwJLDDsvFKXPyGXgxT9DCUT3Aqf6FTDgA@mail.gmail.com>
Message-ID: <CAJF2gTSWHMfE-Tyn=cwJLDDsvFKXPyGXgxT9DCUT3Aqf6FTDgA@mail.gmail.com>
Subject: Re: [PATCH V4 8/8] riscv: Add config of thread stack size
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>, lazyparser@gmail.com,
        falcon@tinylab.org, Huacai Chen <chenhuacai@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Andreas Schwab <schwab@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 21, 2022 at 4:23 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 2:13 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Tue, Sep 20, 2022 at 3:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > On Tue, Sep 20, 2022, at 2:46 AM, Guo Ren wrote:
> > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index dfe600f3526c..8def456f328c 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -442,6 +442,16 @@ config IRQ_STACKS
> > > >           Add independent irq & softirq stacks for percpu to prevent
> > > > kernel stack
> > > >           overflows. We may save some memory footprint by disabling IRQ_STACKS.
> > > >
> > > > +config THREAD_SIZE
> > > > +       int "Kernel stack size (in bytes)" if EXPERT
> > > > +       range 4096 65536
> > > > +       default 8192 if 32BIT && !KASAN
> > > > +       default 32768 if 64BIT && KASAN
> > > > +       default 16384
> > > > +       help
> > > > +         Specify the Pages of thread stack size (from 4KB to 64KB), which also
> > > > +         affects irq stack size, which is equal to thread stack size.
> > >
> > > I still think this should be guarded in a way that prevents
> > > setting the stack to smaller than default values unless VMAP_STACK
> > > is set as well.
> > Current VMAP_STACK would double THREAD_SIZE. Let me see how to reduce
> > the VMAP_STACK.
> Sorry, for my miss understanding. I have no idea to reduce the
> VMAP_STACK's THREAD_ALIGN, THREAD_SIZE*2 is fine. Here is my new
> patch:
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 76bde12d9f8c..669ae57356a2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -443,6 +443,16 @@ config IRQ_STACKS
>           Add independent irq & softirq stacks for percpu to prevent
> kernel stack
>           overflows. We may save some memory footprint by disabling IRQ_STACKS.
>
> +config THREAD_SIZE
> +       int "Kernel stack size (in bytes)" if VMAP_STACK && EXPERT
> +       range 4096 65536
> +       default 8192 if 32BIT && !KASAN
> +       default 32768 if 64BIT && KASAN
> +       default 16384
> +       help
> +         Specify the Pages of thread stack size (from 4KB to 64KB), which also
> +         affects irq stack size, which is equal to thread stack size.
> +
>  endmenu # "Platform type"
>
>  menu "Kernel features"
> diff --git a/arch/riscv/include/asm/thread_info.h
> b/arch/riscv/include/asm/thread_info.h
> index 043da8ccc7e6..e7ae3f13b879 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -11,32 +11,17 @@
>  #include <asm/page.h>
>  #include <linux/const.h>
>
> -#ifdef CONFIG_KASAN
> -#define KASAN_STACK_ORDER 1
> -#else
> -#define KASAN_STACK_ORDER 0
> -#endif
> -
>  /* thread information allocation */
> -#ifdef CONFIG_64BIT
> -#define THREAD_SIZE_ORDER      (2 + KASAN_STACK_ORDER)
> -#else
> -#define THREAD_SIZE_ORDER      (1 + KASAN_STACK_ORDER)
> -#endif
> -#define THREAD_SIZE            (PAGE_SIZE << THREAD_SIZE_ORDER)
> +#define THREAD_SIZE            CONFIG_THREAD_SIZE
>
>  /*
>   * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
> - * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
> - * assembly.
> + * checking sp & THREAD_SIZE, which we can do cheaply in the entry assembly.
>   */
>  #ifdef CONFIG_VMAP_STACK
>  #define THREAD_ALIGN            (2 * THREAD_SIZE)
> -#else
> -#define THREAD_ALIGN            THREAD_SIZE
>  #endif
>
> -#define THREAD_SHIFT            (PAGE_SHIFT + THREAD_SIZE_ORDER)
>  #define OVERFLOW_STACK_SIZE     SZ_4K
>  #define SHADOW_OVERFLOW_STACK_SIZE (1024)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 2207cf44a3bc..71ea850ff0db 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -29,8 +29,8 @@ _restore_kernel_tpsp:
>
>  #ifdef CONFIG_VMAP_STACK
>         addi sp, sp, -(PT_SIZE_ON_STACK)
> -       srli sp, sp, THREAD_SHIFT
> -       andi sp, sp, 0x1
> +       srli sp, sp, PAGE_SHIFT
> +       andi sp, sp, (THREAD_ALIGN >> PAGE_SHIFT >> 1)
>         bnez sp, handle_kernel_stack_overflow
>         REG_L sp, TASK_TI_KERNEL_SP(tp)
>  #endif
Sorry for the update again, fixup !VMAP_STACK compile error.

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 76bde12d9f8c..602e577c429c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -443,6 +443,16 @@ config IRQ_STACKS
          Add independent irq & softirq stacks for percpu to prevent
kernel stack
          overflows. We may save some memory footprint by disabling IRQ_STACKS.

+config THREAD_SIZE_ORDER
+       int "Kernel stack size (in power-of-two numbers of page size)"
if VMAP_STACK && EXPERT
+       range 0 4
+       default 1 if 32BIT && !KASAN
+       default 3 if 64BIT && KASAN
+       default 2
+       help
+         Specify the Pages of thread stack size (from 4KB to 64KB), which also
+         affects irq stack size, which is equal to thread stack size.
+
 endmenu # "Platform type"

 menu "Kernel features"
diff --git a/arch/riscv/include/asm/thread_info.h
b/arch/riscv/include/asm/thread_info.h
index 043da8ccc7e6..3f382490d8ed 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -11,24 +11,13 @@
 #include <asm/page.h>
 #include <linux/const.h>

-#ifdef CONFIG_KASAN
-#define KASAN_STACK_ORDER 1
-#else
-#define KASAN_STACK_ORDER 0
-#endif
-
 /* thread information allocation */
-#ifdef CONFIG_64BIT
-#define THREAD_SIZE_ORDER      (2 + KASAN_STACK_ORDER)
-#else
-#define THREAD_SIZE_ORDER      (1 + KASAN_STACK_ORDER)
-#endif
-#define THREAD_SIZE            (PAGE_SIZE << THREAD_SIZE_ORDER)
+#define THREAD_SIZE_ORDER      CONFIG_THREAD_SIZE_ORDER
+#define THREAD_SIZE            (1 << PAGE_SHIFT << THREAD_SIZE_ORDER)

 /*
  * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
- * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
- * assembly.
+ * checking sp & THREAD_SIZE, which we can do cheaply in the entry assembly.
  */
 #ifdef CONFIG_VMAP_STACK
 #define THREAD_ALIGN            (2 * THREAD_SIZE)
@@ -36,7 +25,6 @@
 #define THREAD_ALIGN            THREAD_SIZE
 #endif

-#define THREAD_SHIFT            (PAGE_SHIFT + THREAD_SIZE_ORDER)
 #define OVERFLOW_STACK_SIZE     SZ_4K
 #define SHADOW_OVERFLOW_STACK_SIZE (1024)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 5cbd6684ef52..62e8f3a3c942 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -29,8 +29,8 @@ _restore_kernel_tpsp:

 #ifdef CONFIG_VMAP_STACK
        addi sp, sp, -(PT_SIZE_ON_STACK)
-       srli sp, sp, THREAD_SHIFT
-       andi sp, sp, 0x1
+       srli sp, sp, PAGE_SHIFT
+       andi sp, sp, (THREAD_ALIGN >> PAGE_SHIFT >> 1)
        bnez sp, handle_kernel_stack_overflow
        REG_L sp, TASK_TI_KERNEL_SP(tp)
 #endif

>
>
> >
> > >
> > >     Arnd
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
>
>
>
> --
> Best Regards
>  Guo Ren



-- 
Best Regards
 Guo Ren

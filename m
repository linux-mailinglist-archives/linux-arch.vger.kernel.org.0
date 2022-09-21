Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B045A5BF91C
	for <lists+linux-arch@lfdr.de>; Wed, 21 Sep 2022 10:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIUIZQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Sep 2022 04:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiIUIZJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Sep 2022 04:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA06389830;
        Wed, 21 Sep 2022 01:24:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C866D62FCA;
        Wed, 21 Sep 2022 08:24:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29921C43141;
        Wed, 21 Sep 2022 08:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663748660;
        bh=1NzIghPEBpq8uMJRc47K9lfgrGEpRXTiw8izcxlL2xQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OKkCGAhnkRBD6nidQpKm62U9gGhDP7WgV8TW6Usene59SdBqik2nH7gw16qADXB6Q
         kGN59L+qRA7IlhnmvB0CjAY8ecmvGXDfM40+CS4p2ZDCyDOe+IdPd1Nbg+netY/gG3
         DaLsZaJASrsTVZuJcY9A8HtsGfTnIi6xg3laWFI7FW4CY9QONjoSY91XqpN5guqjNv
         NT0ailSc9zSbCHEc8hVikRtzGJRBea18pdRRQ2FZ9zRjFy2c1+NBqEmjb1Gf9kiz9T
         h4G5/Y4hjWOWf6RZm/TLBKPfj6oeI3iuTkivN18rfwB5A5srEd1XAQaZhmXiroHJxH
         AKvLfQkjQq9VA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11eab59db71so7958282fac.11;
        Wed, 21 Sep 2022 01:24:20 -0700 (PDT)
X-Gm-Message-State: ACrzQf2M2H3CnF9vMbKM5UDlxeg0yb92WM51h4Bh3rAjT60d2i7XDio2
        qGOHHvrRVevRkwEeYgVmqNt2G8f661pzDJuMICY=
X-Google-Smtp-Source: AMsMyM4V0nR6rYDAsi882MI6/ftf77j2yigATQcPA5I8IsYUbEUPObkhTn6sRCtBUuHkFuJRwBsb3fkrstWT3g/H0Qk=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr4387625oao.112.1663748659200; Wed, 21
 Sep 2022 01:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com> <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com> <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
 <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com>
 <7a2379cf-c1cf-46af-9172-334d2b9b88d5@www.fastmail.com> <CAJF2gTSvaNh_m_hrub5Z=kqLAYJfRbpYzB1Mc5aOgdN+Bm8bag@mail.gmail.com>
In-Reply-To: <CAJF2gTSvaNh_m_hrub5Z=kqLAYJfRbpYzB1Mc5aOgdN+Bm8bag@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 21 Sep 2022 16:23:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQGB97kh=47dsZ8MFpTTpy7pxYyd=MoLOUzgF9kTm1wdA@mail.gmail.com>
Message-ID: <CAJF2gTQGB97kh=47dsZ8MFpTTpy7pxYyd=MoLOUzgF9kTm1wdA@mail.gmail.com>
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

On Wed, Sep 21, 2022 at 2:13 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Sep 20, 2022 at 3:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Sep 20, 2022, at 2:46 AM, Guo Ren wrote:
> >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index dfe600f3526c..8def456f328c 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -442,6 +442,16 @@ config IRQ_STACKS
> > >           Add independent irq & softirq stacks for percpu to prevent
> > > kernel stack
> > >           overflows. We may save some memory footprint by disabling IRQ_STACKS.
> > >
> > > +config THREAD_SIZE
> > > +       int "Kernel stack size (in bytes)" if EXPERT
> > > +       range 4096 65536
> > > +       default 8192 if 32BIT && !KASAN
> > > +       default 32768 if 64BIT && KASAN
> > > +       default 16384
> > > +       help
> > > +         Specify the Pages of thread stack size (from 4KB to 64KB), which also
> > > +         affects irq stack size, which is equal to thread stack size.
> >
> > I still think this should be guarded in a way that prevents
> > setting the stack to smaller than default values unless VMAP_STACK
> > is set as well.
> Current VMAP_STACK would double THREAD_SIZE. Let me see how to reduce
> the VMAP_STACK.
Sorry, for my miss understanding. I have no idea to reduce the
VMAP_STACK's THREAD_ALIGN, THREAD_SIZE*2 is fine. Here is my new
patch:

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 76bde12d9f8c..669ae57356a2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -443,6 +443,16 @@ config IRQ_STACKS
          Add independent irq & softirq stacks for percpu to prevent
kernel stack
          overflows. We may save some memory footprint by disabling IRQ_STACKS.

+config THREAD_SIZE
+       int "Kernel stack size (in bytes)" if VMAP_STACK && EXPERT
+       range 4096 65536
+       default 8192 if 32BIT && !KASAN
+       default 32768 if 64BIT && KASAN
+       default 16384
+       help
+         Specify the Pages of thread stack size (from 4KB to 64KB), which also
+         affects irq stack size, which is equal to thread stack size.
+
 endmenu # "Platform type"

 menu "Kernel features"
diff --git a/arch/riscv/include/asm/thread_info.h
b/arch/riscv/include/asm/thread_info.h
index 043da8ccc7e6..e7ae3f13b879 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -11,32 +11,17 @@
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
+#define THREAD_SIZE            CONFIG_THREAD_SIZE

 /*
  * By aligning VMAP'd stacks to 2 * THREAD_SIZE, we can detect overflow by
- * checking sp & (1 << THREAD_SHIFT), which we can do cheaply in the entry
- * assembly.
+ * checking sp & THREAD_SIZE, which we can do cheaply in the entry assembly.
  */
 #ifdef CONFIG_VMAP_STACK
 #define THREAD_ALIGN            (2 * THREAD_SIZE)
-#else
-#define THREAD_ALIGN            THREAD_SIZE
 #endif

-#define THREAD_SHIFT            (PAGE_SHIFT + THREAD_SIZE_ORDER)
 #define OVERFLOW_STACK_SIZE     SZ_4K
 #define SHADOW_OVERFLOW_STACK_SIZE (1024)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 2207cf44a3bc..71ea850ff0db 100644
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
> >
> >     Arnd
>
>
>
> --
> Best Regards
>  Guo Ren



-- 
Best Regards
 Guo Ren

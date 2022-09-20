Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86AC5BD8E4
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 02:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiITArO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 20:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITArN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 20:47:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C793476DB;
        Mon, 19 Sep 2022 17:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 100FBB81D41;
        Tue, 20 Sep 2022 00:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3727C43142;
        Tue, 20 Sep 2022 00:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663634829;
        bh=xP/qeVjxP9D7WAylNWjp5M1UVyW3ePRF51jsVQNhb6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QQPHDA/rmZeGmg4vRVdL3NsKvKD3TaRcKVna3BdM9JeoVwJ6pke7eJjtIOObQLXBA
         dE5ROwWuXKUWG7GOnz04IIjOyMupp2IFSCY1Qan2zdiKbx2FGE9jerCSbvTDFu1xM8
         O1kHOBLOteHXQZUqVd+UVtNVlh7OPQ1/moZMl0j6u2oIX9zbuCmnPdBzr8u/ywNvC8
         85vzoTPsiDHQR1yy5Grq5sc9gXaMGfiQxx76yRqq4p/6QsRSFAA8K43CeYIpmdXQgN
         /pTP6BTHaYfm+DQjfDIFPgU6bOYKu37RyUbGQB1BueeYM1IuKOo17bnnCuocyvX5n9
         fEDuwptUghy0g==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-12803ac8113so1956277fac.8;
        Mon, 19 Sep 2022 17:47:09 -0700 (PDT)
X-Gm-Message-State: ACrzQf3L5i5enHOBUA3DhIELzM0JkVNSpfQa8zQH+LL+mbO2c4IKQR1O
        xvEt+KcGkOkHcQPAxBzWOS4ErKn2fBcRqzhXeh8=
X-Google-Smtp-Source: AMsMyM6SzMrhnEnurC88o5RK3FSySIO2geSRWmUq+5Zhq2V6q1TFt+qBpX29RTKP8TzwzNGJDD/k5Zn/L7dXo+SaQoU=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr557154oao.112.1663634828649; Mon, 19
 Sep 2022 17:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220908022506.1275799-1-guoren@kernel.org> <20220908022506.1275799-9-guoren@kernel.org>
 <4babce64-e96d-454c-aa35-243b3f2dc315@www.fastmail.com> <CAJF2gTQAMCjNyqrSOvqDAKR5Z-PZiTVxmoK9cvNAVQs+k2fZBg@mail.gmail.com>
 <8817af55-de0d-4e8f-a41b-25d01d5fa968@www.fastmail.com> <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
In-Reply-To: <CAJF2gTRoKfJ25brnA=_CqNw9DPt8XKhcyNzmCbD6wX1q-jiR1w@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 20 Sep 2022 08:46:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com>
Message-ID: <CAJF2gTRVH6pVqBn+n+wbccBcMWraRP3m4CbXz4g_y+=nPEU=Yw@mail.gmail.com>
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

On Mon, Sep 19, 2022 at 4:35 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Sun, Sep 11, 2022 at 12:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Sep 10, 2022, at 2:52 PM, Guo Ren wrote:
> > > On Thu, Sep 8, 2022 at 3:37 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >> On Thu, Sep 8, 2022, at 4:25 AM, guoren@kernel.org wrote:
> > >> > From: Guo Ren <guoren@linux.alibaba.com>
> > >> - When VMAP_STACK is set, make it possible to select non-power-of-two
> > >>   stack sizes. Most importantly, 12KB should be a really interesting
> > >>   choice as 8KB is probably still not enough for many 64-bit workloads,
> > >>   but 16KB is often more than what you need. You probably don't
> > >>   want to allow 64BIT/8KB without VMAP_STACK anyway since that just
> > >>   makes it really hard to debug, so hiding the option when VMAP_STACK
> > >>   is disabled may also be a good idea.
> > > I don't want this config to depend on VMAP_STACK. Some D1 chips would
> > > run with an 8K stack size and !VMAP_STACK.
> >
> > That sounds like a really bad idea, why would you want to risk
> > using such a small stack without CONFIG_VMAP_STACK?
> >
> > Are you worried about increased memory usage or something else?
> >
> > >  /* thread information allocation */
> > > -#ifdef CONFIG_64BIT
> > > -#define THREAD_SIZE_ORDER      (2 + KASAN_STACK_ORDER)
> > > -#else
> > > -#define THREAD_SIZE_ORDER      (1 + KASAN_STACK_ORDER)
> > > -#endif
> > > +#define THREAD_SIZE_ORDER      CONFIG_THREAD_SIZE_ORDER
> > >  #define THREAD_SIZE            (PAGE_SIZE << THREAD_SIZE_ORDER)
> >
> > This doesn't actually allow additional THREAD_SIZE values, as you
> > still round up to the nearest power of two.
> >
> > I think all the non-arch code can deal with non-power-of-2
> > sizes, so you'd just need
> >
> > #define THREAD_SIZE round_up(CONFIG_THREAD_SIZE, PAGE_SIZE)
> >
> > and fix up the risc-v specific code to do the right thing
> > as well. I now see that THREAD_SIZE_ORDER is not actually
> > used anywhere with CONFIG_VMAP_STACK, so I suppose that
> > definition can be skipped, but you still need a THREAD_ALIGN
> > definition that is a power of two and at least a page larger
> > than THREAD_SIZE.
> Sorry, I missed this part. I would RESEND v5

Hi Arnd,

How about this one: (only THREAD_SIZE, no THREAD_ORDER&SHIFT.)

commit 447cddede7898c35a9a3b8ab3d7bdb7b0de0714d (HEAD)
Author: Guo Ren <guoren@kernel.org>
Date:   Mon Sep 5 22:53:06 2022 -0400

    riscv: Add config of thread stack size

    0cac21b02ba5 ("riscv: use 16KB kernel stack on 64-bit") increase the
    thread size mandatory, but some scenarios, such as D1 with a small
    memory footprint, would suffer from that. After independent irq stack
    support, let's give users a choice to determine their custom stack size.

    Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
    Signed-off-by: Guo Ren <guoren@kernel.org>
    Cc: Andreas Schwab <schwab@suse.de>

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index dfe600f3526c..8def456f328c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -442,6 +442,16 @@ config IRQ_STACKS
          Add independent irq & softirq stacks for percpu to prevent
kernel stack
          overflows. We may save some memory footprint by disabling IRQ_STACKS.

+config THREAD_SIZE
+       int "Kernel stack size (in bytes)" if EXPERT
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
index 043da8ccc7e6..181fdfbd5e99 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -11,24 +11,12 @@
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
@@ -36,7 +24,6 @@
 #define THREAD_ALIGN            THREAD_SIZE
 #endif

-#define THREAD_SHIFT            (PAGE_SHIFT + THREAD_SIZE_ORDER)
 #define OVERFLOW_STACK_SIZE     SZ_4K
 #define SHADOW_OVERFLOW_STACK_SIZE (1024)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 426529b84db0..1e35fb3bdae5 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -29,8 +29,8 @@ _restore_kernel_tpsp:

 #ifdef CONFIG_VMAP_STACK
        addi sp, sp, -(PT_SIZE_ON_STACK)
-       srli sp, sp, THREAD_SHIFT
-       andi sp, sp, 0x1
+       srli sp, sp, PAGE_SHIFT
+       andi sp, sp, (THREAD_SIZE >> PAGE_SHIFT)
        bnez sp, handle_kernel_stack_overflow
        REG_L sp, TASK_TI_KERNEL_SP(tp)
 #endif


>
> >
> >      Arnd
>
>
>
> --
> Best Regards
>  Guo Ren



-- 
Best Regards
 Guo Ren

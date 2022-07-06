Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE97568AA1
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jul 2022 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiGFODH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 10:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGFODG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 10:03:06 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D718E13;
        Wed,  6 Jul 2022 07:03:04 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2ef5380669cso140859827b3.9;
        Wed, 06 Jul 2022 07:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBBLwGm3VvIAnm4uSuSyiWShri4w+bgQrIyP7HIMtP0=;
        b=BWYOrQ+sRmqafGTok0X9D3MjBgtmyg/jJ6UU/mGm95R2O4YIyU3LyRJLu85uPBtlO4
         nieCudb8Kc25IevUlq2fVk0h26HUxn9M9/XKbFL7dyFO5eOWW6pW+cgNiiH/ojMJHPUC
         RcHr8rvHrjLbGxIm8qTquOju9+xMDpcPWyHk3dY7fFwxUJHZZrx9XOL1wy3gCcCb6mrA
         /gdbXoz7eqddOdatE/209+U//88wG4J1eUpyJgFfl6tjBWgUy78K6h1KDvWdh8VDE1iA
         gnpVABcdDzDjuJyEN8Tr2lDwCz3hndD0mNiUVLfAuVUCNd6sEi426TQr4nZrMr0Mb1MI
         8j4g==
X-Gm-Message-State: AJIora97c7r7OlScDvg7zdGxAiQ758qsuSnSyiRZeFNJtr2ULfv8V4bW
        YZe/I6CydShxM7ImtybBFR8yIM5w+yUBlQam2lQ=
X-Google-Smtp-Source: AGRyM1shXjwii2Xu/qgQ1B1HadHYSMjqitGmbFlHxf4P7RndZwyBhPC2CaCRixiXqBuDMvjO7JXHYGnoD2iVhXDPhek=
X-Received: by 2002:a81:a184:0:b0:31c:b00e:b5c4 with SMTP id
 y126-20020a81a184000000b0031cb00eb5c4mr15058481ywg.149.1657116183677; Wed, 06
 Jul 2022 07:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org> <20220608144517.188449351@infradead.org>
In-Reply-To: <20220608144517.188449351@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Jul 2022 16:02:52 +0200
Message-ID: <CAJZ5v0i4xX75TK=Qg_PUk93aghJgpi0AR0gsa3Repw8G4XyDuw@mail.gmail.com>
Subject: Re: [PATCH 20/36] arch/idle: Change arch_cpu_idle() IRQ behaviour
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        ulli.kroll@googlemail.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        bcain@quicinc.com, Huacai Chen <chenhuacai@kernel.org>,
        kernel@xen0n.name, Geert Uytterhoeven <geert@linux-m68k.org>,
        sammy@sammy.net, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi,
        Stafford Horne <shorne@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, acme@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@kernel.org, namhyung@kernel.org,
        Juergen Gross <jgross@suse.com>, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Chris Zankel <chris@zankel.net>, jcmvbkbc@gmail.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, senozhatsky@chromium.org,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        quic_neeraju@quicinc.com, Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        openrisc@lists.librecores.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 8, 2022 at 4:46 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Current arch_cpu_idle() is called with IRQs disabled, but will return
> with IRQs enabled.
>
> However, the very first thing the generic code does after calling
> arch_cpu_idle() is raw_local_irq_disable(). This means that
> architectures that can idle with IRQs disabled end up doing a
> pointless 'enable-disable' dance.
>
> Therefore, push this IRQ disabling into the idle function, meaning
> that those architectures can avoid the pointless IRQ state flipping.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/alpha/kernel/process.c      |    1 -
>  arch/arc/kernel/process.c        |    3 +++
>  arch/arm/kernel/process.c        |    1 -
>  arch/arm/mach-gemini/board-dt.c  |    3 ++-
>  arch/arm64/kernel/idle.c         |    1 -
>  arch/csky/kernel/process.c       |    1 -
>  arch/csky/kernel/smp.c           |    2 +-
>  arch/hexagon/kernel/process.c    |    1 -
>  arch/ia64/kernel/process.c       |    1 +
>  arch/microblaze/kernel/process.c |    1 -
>  arch/mips/kernel/idle.c          |    8 +++-----
>  arch/nios2/kernel/process.c      |    1 -
>  arch/openrisc/kernel/process.c   |    1 +
>  arch/parisc/kernel/process.c     |    2 --
>  arch/powerpc/kernel/idle.c       |    5 ++---
>  arch/riscv/kernel/process.c      |    1 -
>  arch/s390/kernel/idle.c          |    1 -
>  arch/sh/kernel/idle.c            |    1 +
>  arch/sparc/kernel/leon_pmc.c     |    4 ++++
>  arch/sparc/kernel/process_32.c   |    1 -
>  arch/sparc/kernel/process_64.c   |    3 ++-
>  arch/um/kernel/process.c         |    1 -
>  arch/x86/coco/tdx/tdx.c          |    3 +++
>  arch/x86/kernel/process.c        |   15 ++++-----------
>  arch/xtensa/kernel/process.c     |    1 +
>  kernel/sched/idle.c              |    2 --
>  26 files changed, 28 insertions(+), 37 deletions(-)
>
> --- a/arch/alpha/kernel/process.c
> +++ b/arch/alpha/kernel/process.c
> @@ -57,7 +57,6 @@ EXPORT_SYMBOL(pm_power_off);
>  void arch_cpu_idle(void)
>  {
>         wtint(0);
> -       raw_local_irq_enable();
>  }
>
>  void arch_cpu_idle_dead(void)
> --- a/arch/arc/kernel/process.c
> +++ b/arch/arc/kernel/process.c
> @@ -114,6 +114,8 @@ void arch_cpu_idle(void)
>                 "sleep %0       \n"
>                 :
>                 :"I"(arg)); /* can't be "r" has to be embedded const */
> +
> +       raw_local_irq_disable();
>  }
>
>  #else  /* ARC700 */
> @@ -122,6 +124,7 @@ void arch_cpu_idle(void)
>  {
>         /* sleep, but enable both set E1/E2 (levels of interrupts) before committing */
>         __asm__ __volatile__("sleep 0x3 \n");
> +       raw_local_irq_disable();
>  }
>
>  #endif
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -78,7 +78,6 @@ void arch_cpu_idle(void)
>                 arm_pm_idle();
>         else
>                 cpu_do_idle();
> -       raw_local_irq_enable();
>  }
>
>  void arch_cpu_idle_prepare(void)
> --- a/arch/arm/mach-gemini/board-dt.c
> +++ b/arch/arm/mach-gemini/board-dt.c
> @@ -42,8 +42,9 @@ static void gemini_idle(void)
>          */
>
>         /* FIXME: Enabling interrupts here is racy! */
> -       local_irq_enable();
> +       raw_local_irq_enable();
>         cpu_do_idle();
> +       raw_local_irq_disable();
>  }
>
>  static void __init gemini_init_machine(void)
> --- a/arch/arm64/kernel/idle.c
> +++ b/arch/arm64/kernel/idle.c
> @@ -42,5 +42,4 @@ void noinstr arch_cpu_idle(void)
>          * tricks
>          */
>         cpu_do_idle();
> -       raw_local_irq_enable();
>  }
> --- a/arch/csky/kernel/process.c
> +++ b/arch/csky/kernel/process.c
> @@ -101,6 +101,5 @@ void arch_cpu_idle(void)
>  #ifdef CONFIG_CPU_PM_STOP
>         asm volatile("stop\n");
>  #endif
> -       raw_local_irq_enable();
>  }
>  #endif
> --- a/arch/csky/kernel/smp.c
> +++ b/arch/csky/kernel/smp.c
> @@ -314,7 +314,7 @@ void arch_cpu_idle_dead(void)
>         while (!secondary_stack)
>                 arch_cpu_idle();
>
> -       local_irq_disable();
> +       raw_local_irq_disable();
>
>         asm volatile(
>                 "mov    sp, %0\n"
> --- a/arch/hexagon/kernel/process.c
> +++ b/arch/hexagon/kernel/process.c
> @@ -44,7 +44,6 @@ void arch_cpu_idle(void)
>  {
>         __vmwait();
>         /*  interrupts wake us up, but irqs are still disabled */
> -       raw_local_irq_enable();
>  }
>
>  /*
> --- a/arch/ia64/kernel/process.c
> +++ b/arch/ia64/kernel/process.c
> @@ -241,6 +241,7 @@ void arch_cpu_idle(void)
>                 (*mark_idle)(1);
>
>         raw_safe_halt();
> +       raw_local_irq_disable();
>
>         if (mark_idle)
>                 (*mark_idle)(0);
> --- a/arch/microblaze/kernel/process.c
> +++ b/arch/microblaze/kernel/process.c
> @@ -138,5 +138,4 @@ int dump_fpu(struct pt_regs *regs, elf_f
>
>  void arch_cpu_idle(void)
>  {
> -       raw_local_irq_enable();
>  }
> --- a/arch/mips/kernel/idle.c
> +++ b/arch/mips/kernel/idle.c
> @@ -33,13 +33,13 @@ static void __cpuidle r3081_wait(void)
>  {
>         unsigned long cfg = read_c0_conf();
>         write_c0_conf(cfg | R30XX_CONF_HALT);
> -       raw_local_irq_enable();
>  }
>
>  void __cpuidle r4k_wait(void)
>  {
>         raw_local_irq_enable();
>         __r4k_wait();
> +       raw_local_irq_disable();
>  }
>
>  /*
> @@ -57,7 +57,6 @@ void __cpuidle r4k_wait_irqoff(void)
>                 "       .set    arch=r4000      \n"
>                 "       wait                    \n"
>                 "       .set    pop             \n");
> -       raw_local_irq_enable();
>  }
>
>  /*
> @@ -77,7 +76,6 @@ static void __cpuidle rm7k_wait_irqoff(v
>                 "       wait                                            \n"
>                 "       mtc0    $1, $12         # stalls until W stage  \n"
>                 "       .set    pop                                     \n");
> -       raw_local_irq_enable();
>  }
>
>  /*
> @@ -103,6 +101,8 @@ static void __cpuidle au1k_wait(void)
>         "       nop                             \n"
>         "       .set    pop                     \n"
>         : : "r" (au1k_wait), "r" (c0status));
> +
> +       raw_local_irq_disable();
>  }
>
>  static int __initdata nowait;
> @@ -245,8 +245,6 @@ void arch_cpu_idle(void)
>  {
>         if (cpu_wait)
>                 cpu_wait();
> -       else
> -               raw_local_irq_enable();
>  }
>
>  #ifdef CONFIG_CPU_IDLE
> --- a/arch/nios2/kernel/process.c
> +++ b/arch/nios2/kernel/process.c
> @@ -33,7 +33,6 @@ EXPORT_SYMBOL(pm_power_off);
>
>  void arch_cpu_idle(void)
>  {
> -       raw_local_irq_enable();
>  }
>
>  /*
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -102,6 +102,7 @@ void arch_cpu_idle(void)
>         raw_local_irq_enable();
>         if (mfspr(SPR_UPR) & SPR_UPR_PMP)
>                 mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
> +       raw_local_irq_disable();
>  }
>
>  void (*pm_power_off)(void) = NULL;
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -187,8 +187,6 @@ void arch_cpu_idle_dead(void)
>
>  void __cpuidle arch_cpu_idle(void)
>  {
> -       raw_local_irq_enable();
> -
>         /* nop on real hardware, qemu will idle sleep. */
>         asm volatile("or %%r10,%%r10,%%r10\n":::);
>  }
> --- a/arch/powerpc/kernel/idle.c
> +++ b/arch/powerpc/kernel/idle.c
> @@ -51,10 +51,9 @@ void arch_cpu_idle(void)
>                  * Some power_save functions return with
>                  * interrupts enabled, some don't.
>                  */
> -               if (irqs_disabled())
> -                       raw_local_irq_enable();
> +               if (!irqs_disabled())
> +                       raw_local_irq_disable();
>         } else {
> -               raw_local_irq_enable();
>                 /*
>                  * Go into low thread priority and possibly
>                  * low power mode.
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -39,7 +39,6 @@ extern asmlinkage void ret_from_kernel_t
>  void arch_cpu_idle(void)
>  {
>         cpu_do_idle();
> -       raw_local_irq_enable();
>  }
>
>  void __show_regs(struct pt_regs *regs)
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c
> @@ -66,7 +66,6 @@ void arch_cpu_idle(void)
>         idle->idle_count++;
>         account_idle_time(cputime_to_nsecs(idle_time));
>         raw_write_seqcount_end(&idle->seqcount);
> -       raw_local_irq_enable();
>  }
>
>  static ssize_t show_idle_count(struct device *dev,
> --- a/arch/sh/kernel/idle.c
> +++ b/arch/sh/kernel/idle.c
> @@ -25,6 +25,7 @@ void default_idle(void)
>         raw_local_irq_enable();
>         /* Isn't this racy ? */
>         cpu_sleep();
> +       raw_local_irq_disable();
>         clear_bl_bit();
>  }
>
> --- a/arch/sparc/kernel/leon_pmc.c
> +++ b/arch/sparc/kernel/leon_pmc.c
> @@ -57,6 +57,8 @@ static void pmc_leon_idle_fixup(void)
>                 "lda    [%0] %1, %%g0\n"
>                 :
>                 : "r"(address), "i"(ASI_LEON_BYPASS));
> +
> +       raw_local_irq_disable();
>  }
>
>  /*
> @@ -70,6 +72,8 @@ static void pmc_leon_idle(void)
>
>         /* For systems without power-down, this will be no-op */
>         __asm__ __volatile__ ("wr       %g0, %asr19\n\t");
> +
> +       raw_local_irq_disable();
>  }
>
>  /* Install LEON Power Down function */
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -71,7 +71,6 @@ void arch_cpu_idle(void)
>  {
>         if (sparc_idle)
>                 (*sparc_idle)();
> -       raw_local_irq_enable();
>  }
>
>  /* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -59,7 +59,6 @@ void arch_cpu_idle(void)
>  {
>         if (tlb_type != hypervisor) {
>                 touch_nmi_watchdog();
> -               raw_local_irq_enable();
>         } else {
>                 unsigned long pstate;
>
> @@ -90,6 +89,8 @@ void arch_cpu_idle(void)
>                         "wrpr %0, %%g0, %%pstate"
>                         : "=&r" (pstate)
>                         : "i" (PSTATE_IE));
> +
> +               raw_local_irq_disable();
>         }
>  }
>
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -216,7 +216,6 @@ void arch_cpu_idle(void)
>  {
>         cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
>         um_idle_sleep();
> -       raw_local_irq_enable();
>  }
>
>  int __cant_sleep(void) {
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -178,6 +178,9 @@ void __cpuidle tdx_safe_halt(void)
>          */
>         if (__halt(irq_disabled, do_sti))
>                 WARN_ONCE(1, "HLT instruction emulation failed\n");
> +
> +       /* XXX I can't make sense of what @do_sti actually does */
> +       raw_local_irq_disable();
>  }
>
>  static bool read_msr(struct pt_regs *regs)
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -699,6 +699,7 @@ EXPORT_SYMBOL(boot_option_idle_override)
>  void __cpuidle default_idle(void)
>  {
>         raw_safe_halt();
> +       raw_local_irq_disable();
>  }
>  #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
>  EXPORT_SYMBOL(default_idle);
> @@ -804,13 +805,7 @@ static void amd_e400_idle(void)
>
>         default_idle();
>
> -       /*
> -        * The switch back from broadcast mode needs to be called with
> -        * interrupts disabled.
> -        */
> -       raw_local_irq_disable();
>         tick_broadcast_exit();
> -       raw_local_irq_enable();
>  }
>
>  /*
> @@ -849,12 +844,10 @@ static __cpuidle void mwait_idle(void)
>                 }
>
>                 __monitor((void *)&current_thread_info()->flags, 0, 0);
> -               if (!need_resched())
> +               if (!need_resched()) {
>                         __sti_mwait(0, 0);
> -               else
> -                       raw_local_irq_enable();
> -       } else {
> -               raw_local_irq_enable();
> +                       raw_local_irq_disable();
> +               }
>         }
>         __current_clr_polling();
>  }
> --- a/arch/xtensa/kernel/process.c
> +++ b/arch/xtensa/kernel/process.c
> @@ -183,6 +183,7 @@ void coprocessor_flush_release_all(struc
>  void arch_cpu_idle(void)
>  {
>         platform_idle();
> +       raw_local_irq_disable();
>  }
>
>  /*
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -79,7 +79,6 @@ void __weak arch_cpu_idle_dead(void) { }
>  void __weak arch_cpu_idle(void)
>  {
>         cpu_idle_force_poll = 1;
> -       raw_local_irq_enable();
>  }
>
>  /**
> @@ -96,7 +95,6 @@ void __cpuidle default_idle_call(void)
>
>                 cpuidle_rcu_enter();
>                 arch_cpu_idle();
> -               raw_local_irq_disable();
>                 cpuidle_rcu_exit();
>
>                 start_critical_timings();
>
>

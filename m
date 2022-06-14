Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718B854B5DC
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 18:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238154AbiFNQW2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 12:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbiFNQW0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 12:22:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52BA4DF8;
        Tue, 14 Jun 2022 09:22:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E098B169E;
        Tue, 14 Jun 2022 09:22:23 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.41.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 113C43F66F;
        Tue, 14 Jun 2022 09:22:05 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:22:02 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, jgross@suse.com,
        srivatsa@csail.mit.edu, amakhalov@vmware.com,
        pv-drivers@vmware.com, boris.ostrovsky@oracle.com,
        chris@zankel.net, jcmvbkbc@gmail.com, rafael@kernel.org,
        lenb@kernel.org, pavel@ucw.cz, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org, pmladek@suse.com,
        senozhatsky@chromium.org, john.ogness@linutronix.de,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH 20/36] arch/idle: Change arch_cpu_idle() IRQ behaviour
Message-ID: <Yqi1qra2k0HIft9W@FVFF77S0Q05N>
References: <20220608142723.103523089@infradead.org>
 <20220608144517.188449351@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608144517.188449351@infradead.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 08, 2022 at 04:27:43PM +0200, Peter Zijlstra wrote:
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

Nice!

  Acked-by: Mark Rutland <mark.rutland@arm.com> [arm64]

Mark.

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
>  	wtint(0);
> -	raw_local_irq_enable();
>  }
>  
>  void arch_cpu_idle_dead(void)
> --- a/arch/arc/kernel/process.c
> +++ b/arch/arc/kernel/process.c
> @@ -114,6 +114,8 @@ void arch_cpu_idle(void)
>  		"sleep %0	\n"
>  		:
>  		:"I"(arg)); /* can't be "r" has to be embedded const */
> +
> +	raw_local_irq_disable();
>  }
>  
>  #else	/* ARC700 */
> @@ -122,6 +124,7 @@ void arch_cpu_idle(void)
>  {
>  	/* sleep, but enable both set E1/E2 (levels of interrupts) before committing */
>  	__asm__ __volatile__("sleep 0x3	\n");
> +	raw_local_irq_disable();
>  }
>  
>  #endif
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -78,7 +78,6 @@ void arch_cpu_idle(void)
>  		arm_pm_idle();
>  	else
>  		cpu_do_idle();
> -	raw_local_irq_enable();
>  }
>  
>  void arch_cpu_idle_prepare(void)
> --- a/arch/arm/mach-gemini/board-dt.c
> +++ b/arch/arm/mach-gemini/board-dt.c
> @@ -42,8 +42,9 @@ static void gemini_idle(void)
>  	 */
>  
>  	/* FIXME: Enabling interrupts here is racy! */
> -	local_irq_enable();
> +	raw_local_irq_enable();
>  	cpu_do_idle();
> +	raw_local_irq_disable();
>  }
>  
>  static void __init gemini_init_machine(void)
> --- a/arch/arm64/kernel/idle.c
> +++ b/arch/arm64/kernel/idle.c
> @@ -42,5 +42,4 @@ void noinstr arch_cpu_idle(void)
>  	 * tricks
>  	 */
>  	cpu_do_idle();
> -	raw_local_irq_enable();
>  }
> --- a/arch/csky/kernel/process.c
> +++ b/arch/csky/kernel/process.c
> @@ -101,6 +101,5 @@ void arch_cpu_idle(void)
>  #ifdef CONFIG_CPU_PM_STOP
>  	asm volatile("stop\n");
>  #endif
> -	raw_local_irq_enable();
>  }
>  #endif
> --- a/arch/csky/kernel/smp.c
> +++ b/arch/csky/kernel/smp.c
> @@ -314,7 +314,7 @@ void arch_cpu_idle_dead(void)
>  	while (!secondary_stack)
>  		arch_cpu_idle();
>  
> -	local_irq_disable();
> +	raw_local_irq_disable();
>  
>  	asm volatile(
>  		"mov	sp, %0\n"
> --- a/arch/hexagon/kernel/process.c
> +++ b/arch/hexagon/kernel/process.c
> @@ -44,7 +44,6 @@ void arch_cpu_idle(void)
>  {
>  	__vmwait();
>  	/*  interrupts wake us up, but irqs are still disabled */
> -	raw_local_irq_enable();
>  }
>  
>  /*
> --- a/arch/ia64/kernel/process.c
> +++ b/arch/ia64/kernel/process.c
> @@ -241,6 +241,7 @@ void arch_cpu_idle(void)
>  		(*mark_idle)(1);
>  
>  	raw_safe_halt();
> +	raw_local_irq_disable();
>  
>  	if (mark_idle)
>  		(*mark_idle)(0);
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
>  	unsigned long cfg = read_c0_conf();
>  	write_c0_conf(cfg | R30XX_CONF_HALT);
> -	raw_local_irq_enable();
>  }
>  
>  void __cpuidle r4k_wait(void)
>  {
>  	raw_local_irq_enable();
>  	__r4k_wait();
> +	raw_local_irq_disable();
>  }
>  
>  /*
> @@ -57,7 +57,6 @@ void __cpuidle r4k_wait_irqoff(void)
>  		"	.set	arch=r4000	\n"
>  		"	wait			\n"
>  		"	.set	pop		\n");
> -	raw_local_irq_enable();
>  }
>  
>  /*
> @@ -77,7 +76,6 @@ static void __cpuidle rm7k_wait_irqoff(v
>  		"	wait						\n"
>  		"	mtc0	$1, $12		# stalls until W stage	\n"
>  		"	.set	pop					\n");
> -	raw_local_irq_enable();
>  }
>  
>  /*
> @@ -103,6 +101,8 @@ static void __cpuidle au1k_wait(void)
>  	"	nop				\n"
>  	"	.set	pop			\n"
>  	: : "r" (au1k_wait), "r" (c0status));
> +
> +	raw_local_irq_disable();
>  }
>  
>  static int __initdata nowait;
> @@ -245,8 +245,6 @@ void arch_cpu_idle(void)
>  {
>  	if (cpu_wait)
>  		cpu_wait();
> -	else
> -		raw_local_irq_enable();
>  }
>  
>  #ifdef CONFIG_CPU_IDLE
> --- a/arch/nios2/kernel/process.c
> +++ b/arch/nios2/kernel/process.c
> @@ -33,7 +33,6 @@ EXPORT_SYMBOL(pm_power_off);
>  
>  void arch_cpu_idle(void)
>  {
> -	raw_local_irq_enable();
>  }
>  
>  /*
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -102,6 +102,7 @@ void arch_cpu_idle(void)
>  	raw_local_irq_enable();
>  	if (mfspr(SPR_UPR) & SPR_UPR_PMP)
>  		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
> +	raw_local_irq_disable();
>  }
>  
>  void (*pm_power_off)(void) = NULL;
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -187,8 +187,6 @@ void arch_cpu_idle_dead(void)
>  
>  void __cpuidle arch_cpu_idle(void)
>  {
> -	raw_local_irq_enable();
> -
>  	/* nop on real hardware, qemu will idle sleep. */
>  	asm volatile("or %%r10,%%r10,%%r10\n":::);
>  }
> --- a/arch/powerpc/kernel/idle.c
> +++ b/arch/powerpc/kernel/idle.c
> @@ -51,10 +51,9 @@ void arch_cpu_idle(void)
>  		 * Some power_save functions return with
>  		 * interrupts enabled, some don't.
>  		 */
> -		if (irqs_disabled())
> -			raw_local_irq_enable();
> +		if (!irqs_disabled())
> +			raw_local_irq_disable();
>  	} else {
> -		raw_local_irq_enable();
>  		/*
>  		 * Go into low thread priority and possibly
>  		 * low power mode.
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -39,7 +39,6 @@ extern asmlinkage void ret_from_kernel_t
>  void arch_cpu_idle(void)
>  {
>  	cpu_do_idle();
> -	raw_local_irq_enable();
>  }
>  
>  void __show_regs(struct pt_regs *regs)
> --- a/arch/s390/kernel/idle.c
> +++ b/arch/s390/kernel/idle.c
> @@ -66,7 +66,6 @@ void arch_cpu_idle(void)
>  	idle->idle_count++;
>  	account_idle_time(cputime_to_nsecs(idle_time));
>  	raw_write_seqcount_end(&idle->seqcount);
> -	raw_local_irq_enable();
>  }
>  
>  static ssize_t show_idle_count(struct device *dev,
> --- a/arch/sh/kernel/idle.c
> +++ b/arch/sh/kernel/idle.c
> @@ -25,6 +25,7 @@ void default_idle(void)
>  	raw_local_irq_enable();
>  	/* Isn't this racy ? */
>  	cpu_sleep();
> +	raw_local_irq_disable();
>  	clear_bl_bit();
>  }
>  
> --- a/arch/sparc/kernel/leon_pmc.c
> +++ b/arch/sparc/kernel/leon_pmc.c
> @@ -57,6 +57,8 @@ static void pmc_leon_idle_fixup(void)
>  		"lda	[%0] %1, %%g0\n"
>  		:
>  		: "r"(address), "i"(ASI_LEON_BYPASS));
> +
> +	raw_local_irq_disable();
>  }
>  
>  /*
> @@ -70,6 +72,8 @@ static void pmc_leon_idle(void)
>  
>  	/* For systems without power-down, this will be no-op */
>  	__asm__ __volatile__ ("wr	%g0, %asr19\n\t");
> +
> +	raw_local_irq_disable();
>  }
>  
>  /* Install LEON Power Down function */
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -71,7 +71,6 @@ void arch_cpu_idle(void)
>  {
>  	if (sparc_idle)
>  		(*sparc_idle)();
> -	raw_local_irq_enable();
>  }
>  
>  /* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -59,7 +59,6 @@ void arch_cpu_idle(void)
>  {
>  	if (tlb_type != hypervisor) {
>  		touch_nmi_watchdog();
> -		raw_local_irq_enable();
>  	} else {
>  		unsigned long pstate;
>  
> @@ -90,6 +89,8 @@ void arch_cpu_idle(void)
>  			"wrpr %0, %%g0, %%pstate"
>  			: "=&r" (pstate)
>  			: "i" (PSTATE_IE));
> +
> +		raw_local_irq_disable();
>  	}
>  }
>  
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -216,7 +216,6 @@ void arch_cpu_idle(void)
>  {
>  	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
>  	um_idle_sleep();
> -	raw_local_irq_enable();
>  }
>  
>  int __cant_sleep(void) {
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -178,6 +178,9 @@ void __cpuidle tdx_safe_halt(void)
>  	 */
>  	if (__halt(irq_disabled, do_sti))
>  		WARN_ONCE(1, "HLT instruction emulation failed\n");
> +
> +	/* XXX I can't make sense of what @do_sti actually does */
> +	raw_local_irq_disable();
>  }
>  
>  static bool read_msr(struct pt_regs *regs)
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -699,6 +699,7 @@ EXPORT_SYMBOL(boot_option_idle_override)
>  void __cpuidle default_idle(void)
>  {
>  	raw_safe_halt();
> +	raw_local_irq_disable();
>  }
>  #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
>  EXPORT_SYMBOL(default_idle);
> @@ -804,13 +805,7 @@ static void amd_e400_idle(void)
>  
>  	default_idle();
>  
> -	/*
> -	 * The switch back from broadcast mode needs to be called with
> -	 * interrupts disabled.
> -	 */
> -	raw_local_irq_disable();
>  	tick_broadcast_exit();
> -	raw_local_irq_enable();
>  }
>  
>  /*
> @@ -849,12 +844,10 @@ static __cpuidle void mwait_idle(void)
>  		}
>  
>  		__monitor((void *)&current_thread_info()->flags, 0, 0);
> -		if (!need_resched())
> +		if (!need_resched()) {
>  			__sti_mwait(0, 0);
> -		else
> -			raw_local_irq_enable();
> -	} else {
> -		raw_local_irq_enable();
> +			raw_local_irq_disable();
> +		}
>  	}
>  	__current_clr_polling();
>  }
> --- a/arch/xtensa/kernel/process.c
> +++ b/arch/xtensa/kernel/process.c
> @@ -183,6 +183,7 @@ void coprocessor_flush_release_all(struc
>  void arch_cpu_idle(void)
>  {
>  	platform_idle();
> +	raw_local_irq_disable();
>  }
>  
>  /*
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -79,7 +79,6 @@ void __weak arch_cpu_idle_dead(void) { }
>  void __weak arch_cpu_idle(void)
>  {
>  	cpu_idle_force_poll = 1;
> -	raw_local_irq_enable();
>  }
>  
>  /**
> @@ -96,7 +95,6 @@ void __cpuidle default_idle_call(void)
>  
>  		cpuidle_rcu_enter();
>  		arch_cpu_idle();
> -		raw_local_irq_disable();
>  		cpuidle_rcu_exit();
>  
>  		start_critical_timings();
> 
> 

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2695B437B75
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhJVRJC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 13:09:02 -0400
Received: from foss.arm.com ([217.140.110.172]:56842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233356AbhJVRJB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Oct 2021 13:09:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBDFC1063;
        Fri, 22 Oct 2021 10:06:43 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.73.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 280EE3F73D;
        Fri, 22 Oct 2021 10:06:40 -0700 (PDT)
Date:   Fri, 22 Oct 2021 18:06:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        zhengqi.arch@bytedance.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        paul.walmsley@sifive.com, palmer@dabbelt.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        broonie@kernel.org
Subject: Re: [PATCH 4/7] arch: Make ARCH_STACKWALK independent of STACKTRACE
Message-ID: <20211022170637.GH86184@C02TD0UTHF1T.local>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.356586621@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022152104.356586621@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 22, 2021 at 05:09:37PM +0200, Peter Zijlstra wrote:
> Make arch_stack_walk() available for ARCH_STACKWALK architectures
> without it being entangled in STACKTRACE.

Nice!

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This looks good to me.

I gave this a spin on arm64, which builds and boots fine with or without
CONFIG_STACKTRACE, and this doesn't seem to regress /proc/*/{wchan,
stack}, so:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Madhavan (Cc'd) has patches to clean up arm64's various unwinders to use
arch_stack_walk(), and it would be good if we could build atop this
rather than having to unconditionally enable STACKTRACE and expose
/proc/*/stack (which should really just be for debugging the unwinder,
and not something distros should ever have enabled).

Once this settles, would it be possible to place this (and the __sched
change to __switch_to) on a stable branch somewhere?

Thanks,
Mark.

> ---
>  arch/arm/kernel/stacktrace.c   |    2 --
>  arch/arm64/kernel/stacktrace.c |    4 ----
>  arch/powerpc/kernel/Makefile   |    3 +--
>  arch/riscv/kernel/stacktrace.c |    4 ----
>  arch/s390/kernel/Makefile      |    3 +--
>  arch/x86/kernel/Makefile       |    2 +-
>  include/linux/stacktrace.h     |   33 +++++++++++++++++----------------
>  7 files changed, 20 insertions(+), 31 deletions(-)
> 
> --- a/arch/arm/kernel/stacktrace.c
> +++ b/arch/arm/kernel/stacktrace.c
> @@ -87,7 +87,6 @@ void notrace walk_stackframe(struct stac
>  }
>  EXPORT_SYMBOL(walk_stackframe);
>  
> -#ifdef CONFIG_STACKTRACE
>  noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  				      void *cookie, struct task_struct *task,
>  				      struct pt_regs *regs)
> @@ -113,4 +112,3 @@ noinline notrace void arch_stack_walk(st
>  			break;
>  	}
>  }
> -#endif
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -216,8 +216,6 @@ void show_stack(struct task_struct *tsk,
>  	barrier();
>  }
>  
> -#ifdef CONFIG_STACKTRACE
> -
>  noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
>  			      void *cookie, struct task_struct *task,
>  			      struct pt_regs *regs)
> @@ -236,5 +234,3 @@ noinline notrace void arch_stack_walk(st
>  
>  	walk_stackframe(task, &frame, consume_entry, cookie);
>  }
> -
> -#endif
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -47,7 +47,7 @@ obj-y				:= cputable.o syscalls.o \
>  				   udbg.o misc.o io.o misc_$(BITS).o \
>  				   of_platform.o prom_parse.o firmware.o \
>  				   hw_breakpoint_constraints.o interrupt.o \
> -				   kdebugfs.o
> +				   kdebugfs.o stacktrace.o
>  obj-y				+= ptrace/
>  obj-$(CONFIG_PPC64)		+= setup_64.o \
>  				   paca.o nvram_64.o note.o
> @@ -116,7 +116,6 @@ obj-$(CONFIG_OPTPROBES)		+= optprobes.o
>  obj-$(CONFIG_KPROBES_ON_FTRACE)	+= kprobes-ftrace.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o
>  obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
> -obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
>  obj-$(CONFIG_ARCH_HAS_DMA_SET_MASK) += dma-mask.o
>  
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -139,12 +139,8 @@ unsigned long __get_wchan(struct task_st
>  	return pc;
>  }
>  
> -#ifdef CONFIG_STACKTRACE
> -
>  noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>  		     struct task_struct *task, struct pt_regs *regs)
>  {
>  	walk_stackframe(task, regs, consume_entry, cookie);
>  }
> -
> -#endif /* CONFIG_STACKTRACE */
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -40,7 +40,7 @@ obj-y	+= sysinfo.o lgr.o os_info.o machi
>  obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o guarded_storage.o sthyi.o
>  obj-y	+= entry.o reipl.o relocate_kernel.o kdebugfs.o alternative.o
>  obj-y	+= nospec-branch.o ipl_vmparm.o machine_kexec_reloc.o unwind_bc.o
> -obj-y	+= smp.o text_amode31.o
> +obj-y	+= smp.o text_amode31.o stacktrace.o
>  
>  extra-y				+= head64.o vmlinux.lds
>  
> @@ -55,7 +55,6 @@ compat-obj-$(CONFIG_AUDIT)	+= compat_aud
>  obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o
>  obj-$(CONFIG_COMPAT)		+= $(compat-obj-y)
>  obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
> -obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
>  obj-$(CONFIG_KPROBES)		+= kprobes.o
>  obj-$(CONFIG_KPROBES)		+= kprobes_insn_page.o
>  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -84,7 +84,7 @@ obj-$(CONFIG_IA32_EMULATION)	+= tls.o
>  obj-y				+= step.o
>  obj-$(CONFIG_INTEL_TXT)		+= tboot.o
>  obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
> -obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
> +obj-y				+= stacktrace.o
>  obj-y				+= cpu/
>  obj-y				+= acpi/
>  obj-y				+= reboot.o
> --- a/include/linux/stacktrace.h
> +++ b/include/linux/stacktrace.h
> @@ -8,21 +8,6 @@
>  struct task_struct;
>  struct pt_regs;
>  
> -#ifdef CONFIG_STACKTRACE
> -void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
> -		       int spaces);
> -int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
> -			unsigned int nr_entries, int spaces);
> -unsigned int stack_trace_save(unsigned long *store, unsigned int size,
> -			      unsigned int skipnr);
> -unsigned int stack_trace_save_tsk(struct task_struct *task,
> -				  unsigned long *store, unsigned int size,
> -				  unsigned int skipnr);
> -unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
> -				   unsigned int size, unsigned int skipnr);
> -unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
> -
> -/* Internal interfaces. Do not use in generic code */
>  #ifdef CONFIG_ARCH_STACKWALK
>  
>  /**
> @@ -75,8 +60,24 @@ int arch_stack_walk_reliable(stack_trace
>  
>  void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
>  			  const struct pt_regs *regs);
> +#endif /* CONFIG_ARCH_STACKWALK */
>  
> -#else /* CONFIG_ARCH_STACKWALK */
> +#ifdef CONFIG_STACKTRACE
> +void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
> +		       int spaces);
> +int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
> +			unsigned int nr_entries, int spaces);
> +unsigned int stack_trace_save(unsigned long *store, unsigned int size,
> +			      unsigned int skipnr);
> +unsigned int stack_trace_save_tsk(struct task_struct *task,
> +				  unsigned long *store, unsigned int size,
> +				  unsigned int skipnr);
> +unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
> +				   unsigned int size, unsigned int skipnr);
> +unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
> +
> +#ifndef CONFIG_ARCH_STACKWALK
> +/* Internal interfaces. Do not use in generic code */
>  struct stack_trace {
>  	unsigned int nr_entries, max_entries;
>  	unsigned long *entries;
> 
> 

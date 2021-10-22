Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8550B437ACB
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 18:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhJVQUZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbhJVQUY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 12:20:24 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84AEC061766
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:18:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id t184so4134066pfd.0
        for <linux-arch@vger.kernel.org>; Fri, 22 Oct 2021 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fbx5wBk0ywdJgKMfRyu0AvGdUuwzChVvTVOiPVCzFpE=;
        b=SFqDR1IxRpbMWyJCF0gBDfnvgPkF9PkV/diIN36EzDN+xGKcZYvy5Mcri8gtFny6Kg
         UdAnQkgpDkJQB79jK9qNfSjqIacF6DlRbFvA597UlcGzpn9ui0yJGCQi8AjX//ozHEk8
         G+Tye35UG9RH025Ii8mD/9/Q1OTP9XsT5Wszk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fbx5wBk0ywdJgKMfRyu0AvGdUuwzChVvTVOiPVCzFpE=;
        b=b5EOq5F8EL63xTuL/OEsgLLr4oSzPxktlctfucHQsWTRY1kAG75LT3jiLoHSxz8cbC
         6RCW6FH6FJYgC370LtX052L4zvBrrZ2AZhGy79zbnR1IW5eX1HVd8hJiwjnCHWQc49Rf
         UkDYieWKbfnr9yzatIwCjh3ZVNZ9V0nhhdqLeQKu9tARI9AHgowiqjOLIosMO1bIf9PZ
         88Y38BdJ+9bahWMH5GAwKgg2PDwKV0gXoJvIqKKy+N7VX6M3L5dbVcmEnbsW9LEs3fgU
         GCSUALCxrJZfifyCQzu3/uNmobOVx2y92SFsXpYcjpNSk2L/IlI4ENHVgeRhlxRaA4sv
         Nt5Q==
X-Gm-Message-State: AOAM530U77EHQybZ4K7fAF0FyIdCUtQnXxESECZnTUIstYzlemRMpF++
        ZZgNoMRFfapVm1RsWE3xca3hDg==
X-Google-Smtp-Source: ABdhPJza352nfmOUCElBpZmTynhIQ3OxvK5BXCjzYxUSdwJYLiDfQVgqqp70h63zMjHxrE+NqTJTIA==
X-Received: by 2002:a63:b909:: with SMTP id z9mr536393pge.140.1634919486387;
        Fri, 22 Oct 2021 09:18:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mq3sm12364212pjb.33.2021.10.22.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 09:18:06 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:18:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 4/7] arch: Make ARCH_STACKWALK independent of STACKTRACE
Message-ID: <202110220917.AACE11A@keescook>
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

Which CONFIG/arch combos did you build test with this? It looks good,
but I always expect things like this to end up landing in corner cases.
:)

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

-- 
Kees Cook

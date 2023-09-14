Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344957A0660
	for <lists+linux-arch@lfdr.de>; Thu, 14 Sep 2023 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbjINNsN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 09:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbjINNsM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 09:48:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2801BEA
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 06:48:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-404773f2501so120745e9.0
        for <linux-arch@vger.kernel.org>; Thu, 14 Sep 2023 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694699286; x=1695304086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0NpRZDPmcHDBEDq/PN5VoK+B/Io2/pklU+DrUKVj/Uk=;
        b=WFdrX/nmC3pAZx8nGdgY4DHxSy424LSJqU37nUa7W5HxpsXBY+pKkdzxwUjtrKPgZ8
         GRvHkeyg5LaA+uTM8dm1Q7Ys3Ggr1kFPqahLghMEHowrp3kwyZk92+1tXo+83Hjxpqiw
         NiXVukpxkNiROreKn2sgCW3pDBA4JpdANf244HkGANjb5142Lh0fmMUDxi/70dywpX2h
         uVZWi9hkbDlIE0mkQDx2QqMd1XgS/8Qf3EJg9ck+uIGccaJBOUdSqoRJOHvcMRzQnk2m
         GEEvWVCqvlS4p15dsu6tELeCgVJ905uo0JBmGieU4CCL05dOfLZ86z7s7PAVX7iztRYU
         SUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694699286; x=1695304086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NpRZDPmcHDBEDq/PN5VoK+B/Io2/pklU+DrUKVj/Uk=;
        b=Og5jyRIhhdKK7C3rL0zfs9EVRsEyNuxRUsCvTI3C/Eye9JEsVlEYg9SIVMc1cAZsHw
         EBQMnh38Hjem7JQihzjRcggCIcxg72gZiZomLh0IIfjx+IyDrABdEkGvUPj47Mq6dFsn
         2QXnOEM3GsKNupBQn99O9fdygCYKfgGK8DCBj+IautRBg03IqOB5+c+C5h2qvLBIhQyw
         FSUfnyTHGQjf0cVIMNWtSzINnrbeHZJ8UyHPPFT6mz1v0mXrLyiHbVrd/JmFz7RQ30I+
         8q5erEtSY8ZO2vIJW+1B3VwOsIs2JWuv3w2iSB2/U3GdbLFcUdkvQnVTmDtbv9h0uZ0+
         w24A==
X-Gm-Message-State: AOJu0Yw3hkQHueAfk0inW4cpCcQOCnMEP+rwbdNTGDo24IHqwFAPwNsv
        mkPpYN72/llj2/O42wEpMbuTPw==
X-Google-Smtp-Source: AGHT+IFwoMiGuvOYU6N8bNee+qhZal97C+SbTYI2CWIdEfiJfY+KPo0K14ss0u/3IPRnH7VdRnRmEg==
X-Received: by 2002:a1c:4b16:0:b0:402:ff8d:609b with SMTP id y22-20020a1c4b16000000b00402ff8d609bmr4491570wma.33.1694699285794;
        Thu, 14 Sep 2023 06:48:05 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id p14-20020a1c740e000000b003fe407ca05bsm4953494wmc.37.2023.09.14.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:48:05 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:47:59 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, jszhang@kernel.org, wefu@redhat.com,
        wuwei2016@iscas.ac.cn, leobras@redhat.com,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <20230914-1ce4f391a14e56b456d88188@orel>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-4-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Cache-block prefetch instructions are HINTs to the hardware to
> indicate that software intends to perform a particular type of
> memory access in the near future. Enable ARCH_HAS_PREFETCHW and
> improve the arch_xchg for qspinlock xchg_tail.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig                 | 15 +++++++++++++++
>  arch/riscv/include/asm/cmpxchg.h   |  4 +++-
>  arch/riscv/include/asm/hwcap.h     |  1 +
>  arch/riscv/include/asm/insn-def.h  |  5 +++++
>  arch/riscv/include/asm/processor.h | 13 +++++++++++++
>  arch/riscv/kernel/cpufeature.c     |  1 +
>  6 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e9ae6fa232c3..2c346fe169c1 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -617,6 +617,21 @@ config RISCV_ISA_ZICBOZ
>  
>  	   If you don't know what to do here, say Y.
>  
> +config RISCV_ISA_ZICBOP
> +	bool "Zicbop extension support for cache block prefetch"
> +	depends on MMU
> +	depends on RISCV_ALTERNATIVE
> +	default y
> +	help
> +	   Adds support to dynamically detect the presence of the ZICBOP
> +	   extension (Cache Block Prefetch Operations) and enable its
> +	   usage.
> +
> +	   The Zicbop extension can be used to prefetch cache block for
> +	   read/write/instruction fetch.
> +
> +	   If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_HAS_ZIHINTPAUSE
>  	bool
>  	default y
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 702725727671..56eff7a9d2d2 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -11,6 +11,7 @@
>  
>  #include <asm/barrier.h>
>  #include <asm/fence.h>
> +#include <asm/processor.h>
>  
>  #define __arch_xchg_masked(prepend, append, r, p, n)			\
>  ({									\
> @@ -25,6 +26,7 @@
>  									\
>  	__asm__ __volatile__ (						\
>  	       prepend							\
> +	       PREFETCHW_ASM(%5)					\
>  	       "0:	lr.w %0, %2\n"					\
>  	       "	and  %1, %0, %z4\n"				\
>  	       "	or   %1, %1, %z3\n"				\
> @@ -32,7 +34,7 @@
>  	       "	bnez %1, 0b\n"					\
>  	       append							\
>  	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
> -	       : "rJ" (__newx), "rJ" (~__mask)				\
> +	       : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)		\
>  	       : "memory");						\
>  									\
>  	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index b7b58258f6c7..78b7b8b53778 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -58,6 +58,7 @@
>  #define RISCV_ISA_EXT_ZICSR		40
>  #define RISCV_ISA_EXT_ZIFENCEI		41
>  #define RISCV_ISA_EXT_ZIHPM		42
> +#define RISCV_ISA_EXT_ZICBOP		43
>  
>  #define RISCV_ISA_EXT_MAX		64
>  
> diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> index 6960beb75f32..dc590d331894 100644
> --- a/arch/riscv/include/asm/insn-def.h
> +++ b/arch/riscv/include/asm/insn-def.h
> @@ -134,6 +134,7 @@
>  
>  #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
>  #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
> +#define RV_OPCODE_PREFETCH	RV_OPCODE(19)

This should be named RV_OPCODE_OP_IMM and be placed in
numerical order with the others, i.e. above SYSTEM.

>  
>  #define HFENCE_VVMA(vaddr, asid)				\
>  	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),		\
> @@ -196,4 +197,8 @@
>  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
>  	       RS1(base), SIMM12(4))
>  
> +#define CBO_prefetchw(base)					\

Please name this 'PREFETCH_w' and it should take an immediate parameter,
even if we intend to pass 0 for it.

> +	INSN_R(OPCODE_PREFETCH, FUNC3(6), FUNC7(0),		\
> +	       RD(x0), RS1(base), RS2(x0))

prefetch.w is not an R-type instruction, it's an S-type. While the bit
shifts are the same, the names are different. We need to add S-type
names while defining this instruction. Then, this define would be

 #define PREFETCH_w(base, imm) \
     INSN_S(OPCODE_OP_IMM, FUNC3(6), IMM_11_5(imm), __IMM_4_0(0), \
            RS1(base), __RS2(3))

When the assembler as insn_r I hope it will validate that
(imm & 0xfe0) == imm

> +
>  #endif /* __ASM_INSN_DEF_H */
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index de9da852f78d..7ad3a24212e8 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -12,6 +12,8 @@
>  #include <vdso/processor.h>
>  
>  #include <asm/ptrace.h>
> +#include <asm/insn-def.h>
> +#include <asm/hwcap.h>
>  
>  #ifdef CONFIG_64BIT
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> @@ -103,6 +105,17 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
>  #define KSTK_EIP(tsk)		(ulong)(task_pt_regs(tsk)->epc)
>  #define KSTK_ESP(tsk)		(ulong)(task_pt_regs(tsk)->sp)
>  
> +#define ARCH_HAS_PREFETCHW
> +#define PREFETCHW_ASM(base)	ALTERNATIVE(__nops(1), \
> +					    CBO_prefetchw(base), \
> +					    0, \
> +					    RISCV_ISA_EXT_ZICBOP, \
> +					    CONFIG_RISCV_ISA_ZICBOP)
> +static inline void prefetchw(const void *ptr)
> +{
> +	asm volatile(PREFETCHW_ASM(%0)
> +		: : "r" (ptr) : "memory");
> +}
>  
>  /* Do necessary setup to start up a newly executed thread. */
>  extern void start_thread(struct pt_regs *regs,
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index ef7b4fd9e876..e0b897db0b97 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -159,6 +159,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
>  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
>  	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> +	__RISCV_ISA_EXT_DATA(zicbop, RISCV_ISA_EXT_ZICBOP),

zicbop should be above zicboz (extensions alphabetical within their
category).

>  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
>  	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> -- 
> 2.36.1
>

Thanks,
drew

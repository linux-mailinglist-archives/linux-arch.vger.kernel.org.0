Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0A7A18AD
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 10:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjIOI0Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Sep 2023 04:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjIOI0U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Sep 2023 04:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88A543C00
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694766160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EX4Tss94LQ/rIrtA1dGhkDHsEmNjKI6XV7p1bhSUC6E=;
        b=N8fgPMQ1CS/m+86XE4/F9+1cTCTwG45vRwiHhtqXszML/0eMKZI+8l6WXnPT2QWqAVmFiR
        /Dk63knRaIp5bPYFeoxrpWgP+1VhjVZy+Dd+rmiSGgwP0cVb/V4NochnuCXh9ZlzvSIElC
        1EK49Z9snA4KpDqlPrAxXYyuc1KwL1U=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-OTCdfoV4MjyOCZusGGcUFA-1; Fri, 15 Sep 2023 04:22:38 -0400
X-MC-Unique: OTCdfoV4MjyOCZusGGcUFA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-576925c8921so2423210eaf.0
        for <linux-arch@vger.kernel.org>; Fri, 15 Sep 2023 01:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694766158; x=1695370958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX4Tss94LQ/rIrtA1dGhkDHsEmNjKI6XV7p1bhSUC6E=;
        b=FpvlA5pjdT+8ZbizqeFZRVOanscHpju+lXVu4yfIOMq6H8usWnDhv1Eu3ThLeKkYTD
         Sq1aFRH93xfPJ+6tysHbGSnFh7AkjLtgfz0yS0tYgTqcqzmA56yrSB+flnGsNtmL5/d5
         +X0Ww2SN/fdTMLxMfR5S9/vJ5ZMAYuCXzqAp5AXV/ywFZ37eTC5OK1QksJCFPWtb8g01
         ksuerHnsh8LHoB5dqS0ANwMDX+z8FRyH4gjW3NxYF1WfiOkure+8P99kTLcT9NwCpvYQ
         JGxYvlmd+GLaF27TTdgXioo7ZG2mScWiKRHoXNW1YvmRO3+QHkBAfUzZkMVTVtvMPCie
         ho+w==
X-Gm-Message-State: AOJu0YzXz6waipYY5pG+bghqB2i9EY0nmbZbfHXFRr585x3GlDbzIMZU
        Y6H7uGaEdsWmr+7Gq305Zx8itzSDYyDgZ5BXuruznNx8RR3vAY7e6lIfD+Abi9zWKRlMrHN7lhy
        Y65QbmB+IEHLksI7xe1XBlw==
X-Received: by 2002:a4a:2a05:0:b0:573:bf68:8dbc with SMTP id k5-20020a4a2a05000000b00573bf688dbcmr913057oof.7.1694766157927;
        Fri, 15 Sep 2023 01:22:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZRVa3tHzbVBpWYN0809AqN2jbKzoyT3PWcZldC1frQ5YeRmbIbyU7x5txQtTFP0VI4BE0lg==
X-Received: by 2002:a4a:2a05:0:b0:573:bf68:8dbc with SMTP id k5-20020a4a2a05000000b00573bf688dbcmr913029oof.7.1694766157618;
        Fri, 15 Sep 2023 01:22:37 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id d129-20020a4a5287000000b0057346742d82sm1529920oob.6.2023.09.15.01.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 01:22:37 -0700 (PDT)
Date:   Fri, 15 Sep 2023 05:22:26 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     guoren@kernel.org, paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, jszhang@kernel.org, wefu@redhat.com,
        wuwei2016@iscas.ac.cn, linux-arch@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <ZQQUQjOaAIc95GXP@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <20230914-1ce4f391a14e56b456d88188@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-1ce4f391a14e56b456d88188@orel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 14, 2023 at 03:47:59PM +0200, Andrew Jones wrote:
> On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > Cache-block prefetch instructions are HINTs to the hardware to
> > indicate that software intends to perform a particular type of
> > memory access in the near future. Enable ARCH_HAS_PREFETCHW and
> > improve the arch_xchg for qspinlock xchg_tail.
> > 
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig                 | 15 +++++++++++++++
> >  arch/riscv/include/asm/cmpxchg.h   |  4 +++-
> >  arch/riscv/include/asm/hwcap.h     |  1 +
> >  arch/riscv/include/asm/insn-def.h  |  5 +++++
> >  arch/riscv/include/asm/processor.h | 13 +++++++++++++
> >  arch/riscv/kernel/cpufeature.c     |  1 +
> >  6 files changed, 38 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e9ae6fa232c3..2c346fe169c1 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -617,6 +617,21 @@ config RISCV_ISA_ZICBOZ
> >  
> >  	   If you don't know what to do here, say Y.
> >  
> > +config RISCV_ISA_ZICBOP
> > +	bool "Zicbop extension support for cache block prefetch"
> > +	depends on MMU
> > +	depends on RISCV_ALTERNATIVE
> > +	default y
> > +	help
> > +	   Adds support to dynamically detect the presence of the ZICBOP
> > +	   extension (Cache Block Prefetch Operations) and enable its
> > +	   usage.
> > +
> > +	   The Zicbop extension can be used to prefetch cache block for
> > +	   read/write/instruction fetch.
> > +
> > +	   If you don't know what to do here, say Y.
> > +
> >  config TOOLCHAIN_HAS_ZIHINTPAUSE
> >  	bool
> >  	default y
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > index 702725727671..56eff7a9d2d2 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -11,6 +11,7 @@
> >  
> >  #include <asm/barrier.h>
> >  #include <asm/fence.h>
> > +#include <asm/processor.h>
> >  
> >  #define __arch_xchg_masked(prepend, append, r, p, n)			\
> >  ({									\
> > @@ -25,6 +26,7 @@
> >  									\
> >  	__asm__ __volatile__ (						\
> >  	       prepend							\
> > +	       PREFETCHW_ASM(%5)					\
> >  	       "0:	lr.w %0, %2\n"					\
> >  	       "	and  %1, %0, %z4\n"				\
> >  	       "	or   %1, %1, %z3\n"				\
> > @@ -32,7 +34,7 @@
> >  	       "	bnez %1, 0b\n"					\
> >  	       append							\
> >  	       : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
> > -	       : "rJ" (__newx), "rJ" (~__mask)				\
> > +	       : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)		\
> >  	       : "memory");						\
> >  									\
> >  	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
> > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > index b7b58258f6c7..78b7b8b53778 100644
> > --- a/arch/riscv/include/asm/hwcap.h
> > +++ b/arch/riscv/include/asm/hwcap.h
> > @@ -58,6 +58,7 @@
> >  #define RISCV_ISA_EXT_ZICSR		40
> >  #define RISCV_ISA_EXT_ZIFENCEI		41
> >  #define RISCV_ISA_EXT_ZIHPM		42
> > +#define RISCV_ISA_EXT_ZICBOP		43
> >  
> >  #define RISCV_ISA_EXT_MAX		64
> >  
> > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > index 6960beb75f32..dc590d331894 100644
> > --- a/arch/riscv/include/asm/insn-def.h
> > +++ b/arch/riscv/include/asm/insn-def.h
> > @@ -134,6 +134,7 @@
> >  
> >  #define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
> >  #define RV_OPCODE_SYSTEM	RV_OPCODE(115)
> > +#define RV_OPCODE_PREFETCH	RV_OPCODE(19)
> 
> This should be named RV_OPCODE_OP_IMM and be placed in
> numerical order with the others, i.e. above SYSTEM.
> 
> >  
> >  #define HFENCE_VVMA(vaddr, asid)				\
> >  	INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),		\
> > @@ -196,4 +197,8 @@
> >  	INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),		\
> >  	       RS1(base), SIMM12(4))
> >  
> > +#define CBO_prefetchw(base)					\
> 
> Please name this 'PREFETCH_w' and it should take an immediate parameter,
> even if we intend to pass 0 for it.

It makes sense.

The mnemonic in the previously mentioned documentation is:

prefetch.w offset(base)

So yeah, makes sense to have both offset and base as parameters for 
CBO_prefetchw (or PREFETCH_w, I have no strong preference).

> 
> > +	INSN_R(OPCODE_PREFETCH, FUNC3(6), FUNC7(0),		\
> > +	       RD(x0), RS1(base), RS2(x0))
> 
> prefetch.w is not an R-type instruction, it's an S-type. While the bit
> shifts are the same, the names are different. We need to add S-type
> names while defining this instruction. 

That is correct, it is supposed to look like a store instruction (S-type), 
even though documentation don't explicitly state that.

Even though it works fine with the R-type definition, code documentation 
would be wrong, and future changes could break it.

> Then, this define would be
> 
>  #define PREFETCH_w(base, imm) \
>      INSN_S(OPCODE_OP_IMM, FUNC3(6), IMM_11_5(imm), __IMM_4_0(0), \
>             RS1(base), __RS2(3))

s/OPCODE_OP_IMM/OPCODE_PREFETCH
0x4 vs 0x13

RS2 == 0x3 is correct (PREFETCH.W instead of PREFETCH.I)


So IIUC, it should be:

INSN_S(OPCODE_PREFETCH, FUNC3(6), IMM_11_5(imm), __IMM_4_0(0), \
       RS1(base), __RS2(3)

Thanks,
Leo


> 
> When the assembler as insn_r I hope it will validate that
> (imm & 0xfe0) == imm
> 
> > +
> >  #endif /* __ASM_INSN_DEF_H */
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > index de9da852f78d..7ad3a24212e8 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -12,6 +12,8 @@
> >  #include <vdso/processor.h>
> >  
> >  #include <asm/ptrace.h>
> > +#include <asm/insn-def.h>
> > +#include <asm/hwcap.h>
> >  
> >  #ifdef CONFIG_64BIT
> >  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> > @@ -103,6 +105,17 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
> >  #define KSTK_EIP(tsk)		(ulong)(task_pt_regs(tsk)->epc)
> >  #define KSTK_ESP(tsk)		(ulong)(task_pt_regs(tsk)->sp)
> >  
> > +#define ARCH_HAS_PREFETCHW
> > +#define PREFETCHW_ASM(base)	ALTERNATIVE(__nops(1), \
> > +					    CBO_prefetchw(base), \
> > +					    0, \
> > +					    RISCV_ISA_EXT_ZICBOP, \
> > +					    CONFIG_RISCV_ISA_ZICBOP)
> > +static inline void prefetchw(const void *ptr)
> > +{
> > +	asm volatile(PREFETCHW_ASM(%0)
> > +		: : "r" (ptr) : "memory");
> > +}
> >  
> >  /* Do necessary setup to start up a newly executed thread. */
> >  extern void start_thread(struct pt_regs *regs,
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index ef7b4fd9e876..e0b897db0b97 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -159,6 +159,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> >  	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> >  	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> >  	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> > +	__RISCV_ISA_EXT_DATA(zicbop, RISCV_ISA_EXT_ZICBOP),
> 
> zicbop should be above zicboz (extensions alphabetical within their
> category).
> 
> >  	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> >  	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> >  	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> > -- 
> > 2.36.1
> >
> 
> Thanks,
> drew
> 


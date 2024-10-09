Return-Path: <linux-arch+bounces-7916-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E02099702E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 18:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C6E28544D
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B411E1C09;
	Wed,  9 Oct 2024 15:31:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E287199FB4;
	Wed,  9 Oct 2024 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487873; cv=none; b=Fisl0RbntehJvCOc22bs8oFKTKVeCNj9NGE1zOeNTGm0HbCrNTpywRYu+DkOh7kn4vsQjs1uYhJJ6VEmab1PMZZMdujacjLdAF2ApK6wGoxqrwXwgQK1dedRMEg0aeApwvM4NCnsXi2ywP/veAlRZMjyCQ/Rd4dwAsSkIewZkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487873; c=relaxed/simple;
	bh=o17P+55KsrlNUzByYpVtjAhlHKstGPAq6g6HHrOJ/f4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3yX3PBXfVtn/mx0w1eUNRVUhryECoR7ulD3tV70BkgF1KByBqJ90HgfK+aSPaFqOfrradGVOxjuesRgCgD1uiq89k8KhFTTMs5dcuj8ssfoNmCo6tahvXp7tkeH87QLyMYyQrEyb5EZH93wXHRCDyd9g57Efu2Yg1VSnjqhbS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35537C4CEC3;
	Wed,  9 Oct 2024 15:31:09 +0000 (UTC)
Date: Wed, 9 Oct 2024 11:31:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul 
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas 
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav 
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ftrace: Consolidate ftrace_regs accessor
 functions for archs using pt_regs
Message-ID: <20241009113114.1da0d84d@gandalf.local.home>
In-Reply-To: <20241008230629.118325673@goodmis.org>
References: <20241008230527.674939311@goodmis.org>
	<20241008230629.118325673@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Loongarch maintainers, please note the below comments!


On Tue, 08 Oct 2024 19:05:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index bbb69c7751b9..5ccff4de7f09 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -54,6 +54,7 @@ extern void return_to_handler(void);
>  unsigned long ftrace_call_adjust(unsigned long addr);
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> +#define HAVE_ARCH_FTRACE_REGS
>  struct dyn_ftrace;
>  struct ftrace_ops;
>  struct ftrace_regs;
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
> index 0e15d36ce251..8f13eaeaa325 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -43,43 +43,20 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent);
>  
>  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  struct ftrace_ops;
> -struct ftrace_regs;
> -#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
>  
> -struct __arch_ftrace_regs {
> -	struct pt_regs regs;
> -};
> +#include <linux/ftrace_regs.h>
>  
>  static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
>  {
>  	return &arch_ftrace_regs(fregs)->regs;
>  }

The above function is incorrect. I know I just added the comment about how
it is to work below, but if pt_regs is not fully filled, then
arch_ftrace_get_regs() must return NULL.

This is because if a callback is registered with ftrace, and forgets to add
the FTRACE_OPS_FL_SAVE_REGS flag, then when it does:

	regs = ftrace_get_regs(fregs);

it should get NULL and not a partially filled pt_regs set. Because the API
is that ftrace_get_regs() will return either a full pt_regs (where the
caller can know that it has all the correct registers) or NULL where it
does not have any registers.

It's an all or nothing approach.

You can see x86 has:

static __always_inline struct pt_regs *
arch_ftrace_get_regs(struct ftrace_regs *fregs)
{
	/* Only when FL_SAVE_REGS is set, cs will be non zero */
	if (!arch_ftrace_regs(fregs)->regs.cs)
		return NULL;
	return &arch_ftrace_regs(fregs)->regs;
}

Where it checks if regs.cs is set to determine if it has all the regs or
not.

Please do something similar for your architecture.

>  
> -static __always_inline unsigned long
> -ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
> -{
> -	return instruction_pointer(&arch_ftrace_regs(fregs)->regs);
> -}
> -
>  static __always_inline void
>  ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs, unsigned long ip)
>  {
>  	instruction_pointer_set(&arch_ftrace_regs(fregs)->regs, ip);
>  }
>  
> 


> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index f7d4f152f84d..c96f9b0eb86e 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -113,6 +113,8 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
>  
>  #ifdef CONFIG_FUNCTION_TRACER
>  
> +#include <linux/ftrace_regs.h>
> +
>  extern int ftrace_enabled;
>  
>  /**
> @@ -150,14 +152,11 @@ struct ftrace_regs {
>  #define ftrace_regs_size()	sizeof(struct __arch_ftrace_regs)
>  
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> -
> -struct __arch_ftrace_regs {
> -	struct pt_regs		regs;
> -};
> -
> -struct ftrace_regs;
> -#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
> -
> +/*
> + * Architectures that define HAVE_DYNAMIC_FTRACE_WITH_ARGS must define their own
> + * arch_ftrace_get_regs() where it only returns pt_regs *if* it is fully
> + * populated. It should return NULL otherwise.
> + */

I'm adding the above comment to help other architectures know of this requirement.

>  static inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *fregs)
>  {
>  	return &arch_ftrace_regs(fregs)->regs;


-- Steve


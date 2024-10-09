Return-Path: <linux-arch+bounces-7908-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EABE1996C74
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 15:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95ADB1F23379
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093CA1990DC;
	Wed,  9 Oct 2024 13:43:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4B198E83;
	Wed,  9 Oct 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481400; cv=none; b=bflVi1I3sXQCRA9J5Xuq69/UhCSewrqT9j6/CyNmHx0GeU6I/Nye0lLX2v+orOhWjU6Ot2cmI8guJ56szBJ09gaHpmzczqIKH18d4yzIJWlu5BbDDRt4SO9sTiWGdd1QT2Fi2SOti4Px6B7xZ8psw0p5zlVGbBuDE0qSHu1izCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481400; c=relaxed/simple;
	bh=S/oj15sxPWHK5m6VWGXl6leJe6peXcKr2JHoaMiRrOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8O9ERMIM20wqlEFlzpeiIfFxDLaOz9UQBhhnHxHjs/DpO1IYseE4NBu+Lg0iBOTy9tYjG4z6P6WcnaY0TJ5sDcTN9LIAYi2jQVG6SO5Lm+WCcS0hS+JWOOZts9NesHAZAcT3+0f88tuIzc1z0WCinDrvwAFMX4h0av4TFaQgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62A7C4CECD;
	Wed,  9 Oct 2024 13:43:16 +0000 (UTC)
Date: Wed, 9 Oct 2024 09:43:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen
 N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul
  Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas 
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav 
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ftrace: Consolidate ftrace_regs accessor
 functions for archs using pt_regs
Message-ID: <20241009094321.3f41f8a4@gandalf.local.home>
In-Reply-To: <20241009134723.6b9eabfdc3cfee10f3757d85@kernel.org>
References: <20241008230527.674939311@goodmis.org>
	<20241008230629.118325673@goodmis.org>
	<20241009134723.6b9eabfdc3cfee10f3757d85@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 13:47:23 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > --- /dev/null
> > +++ b/include/linux/ftrace_regs.h
> > @@ -0,0 +1,36 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_FTRACE_TYPES_H
> > +#define _LINUX_FTRACE_TYPES_H  
>                ^^^^^^^^^^^^^^^^  Is this _LINUX_FTRACE_REGS_H?

Ah, I originally called it ftrace_types.h, but later decided that name
didn't really fit. I changed all references to it but this one.

Thanks for catching this.

> 
> 
> > +
> > +/*
> > + * For archs that just copy pt_regs in ftrace regs, it can use this default.
> > + * If an architecture does not use pt_regs, it must define all the below
> > + * accessor functions.
> > + */
> > +#ifndef HAVE_ARCH_FTRACE_REGS
> > +struct __arch_ftrace_regs {
> > +	struct pt_regs		regs;
> > +};
> > +
> > +#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
> > +
> > +struct ftrace_regs;
> > +
> > +#define ftrace_regs_get_instruction_pointer(fregs) \
> > +	instruction_pointer(arch_ftrace_get_regs(fregs))
> > +#define ftrace_regs_get_argument(fregs, n) \
> > +	regs_get_kernel_argument(arch_ftrace_get_regs(fregs), n)
> > +#define ftrace_regs_get_stack_pointer(fregs) \
> > +	kernel_stack_pointer(arch_ftrace_get_regs(fregs))
> > +#define ftrace_regs_return_value(fregs) \
> > +	regs_return_value(arch_ftrace_get_regs(fregs))
> > +#define ftrace_regs_set_return_value(fregs, ret) \
> > +	regs_set_return_value(arch_ftrace_get_regs(fregs), ret)
> > +#define ftrace_override_function_with_return(fregs) \
> > +	override_function_with_return(arch_ftrace_get_regs(fregs))
> > +#define ftrace_regs_query_register_offset(name) \
> > +	regs_query_register_offset(name)
> > +
> > +#endif /* HAVE_ARCH_FTRACE_REGS */
> > +
> > +#endif /* _LINUX_FTRACE_TYPES_H */  
> 
> Ditto.
> 
> Others looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

I'll send a v2 with this update.

-- Steve


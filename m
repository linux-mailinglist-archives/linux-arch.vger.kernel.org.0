Return-Path: <linux-arch+bounces-7884-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E3E995B3F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 00:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8691F24467
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1552621642E;
	Tue,  8 Oct 2024 22:58:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B6215003;
	Tue,  8 Oct 2024 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428332; cv=none; b=Zg5sC/ld6Nnch7LQbJVSDc4L2AvxVxoZ0zX1cVL102u75fmpYkt/8KTJ4jBRZ90fEaEPK/ysGpDZsCF5hmNgvzAbhRuXYE+To/xqeeCFgYTsVUsnrfZZHU9tzC6q/E5qoZX2kzKt74Pg88+kEAVlx3oRPOUVqsjMfcXeOTnz6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428332; c=relaxed/simple;
	bh=q3QHIirZM9sbs+qj//brUeZOmkTUKQEfSH/pXtSm+zA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOByeF0BEFPo/a/+0I2TMADuaAdrlE/8v9PqRrTOPidzpmTKYGgx7cRT2wCvPQUNClywNhW6l+r59VF/tqx7PH+BdKblqUH52DUZTaIi9nv1+H+z6gKBDe0uKRuq4N462A3qRdzXDMzhFoRqtcuqTTcKt8XR49seQSSNsch2T+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB329C4CEC7;
	Tue,  8 Oct 2024 22:58:47 +0000 (UTC)
Date: Tue, 8 Oct 2024 18:58:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark
 Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG
 Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] ftrace: Make ftrace_regs abstract from direct use
Message-ID: <20241008185851.274887ca@gandalf.local.home>
In-Reply-To: <20241009074140.b163eceb2f973227b400c962@kernel.org>
References: <20241007204743.41314f1d@gandalf.local.home>
	<20241009074140.b163eceb2f973227b400c962@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 07:41:40 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve, 
> 
> > diff --git a/include/asm-generic/ftrace.h b/include/asm-generic/ftrace.h
> > index 3a23028d69d2..ba7b7d6e55d6 100644
> > --- a/include/asm-generic/ftrace.h
> > +++ b/include/asm-generic/ftrace.h
> > @@ -10,4 +10,17 @@
> >   * common definitions are already in linux/ftrace.h.
> >   */
> >  
> > +#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > +struct __arch_ftrace_regs {
> > +	struct pt_regs		regs;
> > +};
> > +
> > +#define arch_ftrace_get_regs(fregs)					\
> > +	({ struct __arch_fregs_regs *__f = (struct __arch_ftrace_regs *)(fregs); \
> > +		&__f->regs;						\
> > +	})
> > +
> > +struct ftrace_regs;
> > +#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
> > +
> >  #endif /* __ASM_GENERIC_FTRACE_H__ */  
> 
> There seems no #endif for CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS.
> I wonder how it passed the build. (#ifdef block does not affect over
> the file boundary?
> 

Yeah I caught that. That's one way I found out that this file is not
compiled by most architectures. I'll be sending a v2 very shortly.

-- Steve



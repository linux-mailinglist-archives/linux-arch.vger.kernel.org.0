Return-Path: <linux-arch+bounces-7882-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5121995B03
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 00:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8924C28A846
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 22:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13149218D8D;
	Tue,  8 Oct 2024 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVKI9Crq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F2217338;
	Tue,  8 Oct 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427311; cv=none; b=ngtVrIMpq2VK8OtLCuR2WoeRq3cXcNb7UhuvvauscZvgBxEgpS1zBIxe/1hc6Wfno0R5IRr/aR0LvCDQKBFkZd/zaZAyI/ewLoieHywCmi1ZBzpR9QBAMNjdifk8g+eX+qNiBjz/jVekSTtQf/pkxPx6Zsq0jYmqVM6Z5I4OEDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427311; c=relaxed/simple;
	bh=dcyvt0dgAZszkRlVAvb5HjPFo8uYI0c0H8I8+ifT9Mc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ejQpcduJEg3Cg0K1e4GaivddGtXnUqtYAKSy4HLYH0cnapHE3h6qPGayN144PSw6BAKlDLkimAzaik8zp2zSFpEFDTbM05/v9lRzA3IuLaWVPeMrfOojyBW8yPE0MSUoP5bBuXmnQrtYucJm9XTwfFMDp17EnuduNyLKJHgbs9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVKI9Crq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821CEC4CEC7;
	Tue,  8 Oct 2024 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728427310;
	bh=dcyvt0dgAZszkRlVAvb5HjPFo8uYI0c0H8I8+ifT9Mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVKI9Crqoxb+kubNcOuiLkrNECGkggxSHQ7zCyU+C4i8uxiYSqLNhL0X/vyK4nbzv
	 ZTZhdx2QyfKE2LnLqpmbl5qupaMKqcPjo4pfP0XVVDT7jJ3Pi+yGLIFlAoyQ1zJ8f/
	 LRx6mNnFL/YEgXB3zZceNPZm3XxIxsg2PBPTbpBe46PAYpR81VHsD8MOEnS/HXOEZ2
	 Ap8/akyKsgqNs5Pe4svGt4x+EP0vBEWmNqIITelNqML0XZvg5lqB67aOG28+RNgkvt
	 wfDDeXaYNBD5I8SjevQEEAIRaEj2kZMlEcSfY0ZWuEXT4HdfIj190zY9PkfL3KNXYl
	 LDp5MEWE7lO/w==
Date: Wed, 9 Oct 2024 07:41:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
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
Subject: Re: [PATCH] ftrace: Make ftrace_regs abstract from direct use
Message-Id: <20241009074140.b163eceb2f973227b400c962@kernel.org>
In-Reply-To: <20241007204743.41314f1d@gandalf.local.home>
References: <20241007204743.41314f1d@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Steve, 

> diff --git a/include/asm-generic/ftrace.h b/include/asm-generic/ftrace.h
> index 3a23028d69d2..ba7b7d6e55d6 100644
> --- a/include/asm-generic/ftrace.h
> +++ b/include/asm-generic/ftrace.h
> @@ -10,4 +10,17 @@
>   * common definitions are already in linux/ftrace.h.
>   */
>  
> +#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +struct __arch_ftrace_regs {
> +	struct pt_regs		regs;
> +};
> +
> +#define arch_ftrace_get_regs(fregs)					\
> +	({ struct __arch_fregs_regs *__f = (struct __arch_ftrace_regs *)(fregs); \
> +		&__f->regs;						\
> +	})
> +
> +struct ftrace_regs;
> +#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
> +
>  #endif /* __ASM_GENERIC_FTRACE_H__ */

There seems no #endif for CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS.
I wonder how it passed the build. (#ifdef block does not affect over
the file boundary?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


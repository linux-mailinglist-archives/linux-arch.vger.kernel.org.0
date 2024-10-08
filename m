Return-Path: <linux-arch+bounces-7792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E920993BF7
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 02:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFD71F21A49
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 00:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B328B676;
	Tue,  8 Oct 2024 00:55:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E51A94A;
	Tue,  8 Oct 2024 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348901; cv=none; b=a0NLYdD8nKMVLvXWJiQE+NntqZq2DfV2G71EWPrAEipeOGs14aDR5i+5UlPYDruzySbAuRJjB5MRco4gl1nJNpOgLMnWOOkGnOyfLcBTU2UpbAHaGj3XO/RyEsu1qnOPUo2tZeJHXwB3P/oWiMbo8ElcvZwHDBgHP96OqeyAuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348901; c=relaxed/simple;
	bh=IF9IcN/hjsxI+NusJVLPD5QrFvM+aC9QoZxMyRrMCY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdNPX8OC2HiTrv7SKwQlm3c4gH5xZepJLPDm5kaPfBehzn9h8fOGfzSDXytOklXGOranB9qHWRVq5GT4nsi7bNTRvhV+pdQIprK+x2K+rVxGa+/eUgXncIJN+CMO6q+dxpPG+SS3Y1zRy4nj0oG/d8qaeDlALBUeDTB+lhE93Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36669C4CEC6;
	Tue,  8 Oct 2024 00:54:57 +0000 (UTC)
Date: Mon, 7 Oct 2024 20:54:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "x86@kernel.org"
 <x86@kernel.org>
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
Subject: Re: [PATCH] ftrace: Make ftrace_regs abstract from direct use
Message-ID: <20241007205458.2bbdf736@gandalf.local.home>
In-Reply-To: <20241007204743.41314f1d@gandalf.local.home>
References: <20241007204743.41314f1d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 20:47:43 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> +struct __arch_ftrace_regs {
> +	struct pt_regs		regs;
> +};
> +
> +#define arch_ftrace_get_regs(fregs)					\
> +	({ struct __arch_fregs_regs *__f = (struct __arch_ftrace_regs *)(fregs); \
> +		&__f->regs;						\
> +	})

I wrote the arch_ftrace_get_regs() at the start of creating this patch.

> +
> +struct ftrace_regs;
> +#define arch_ftrace_regs(fregs) ((struct __arch_ftrace_regs *)(fregs))
> +

I just realized I can simplify it with:

#define arch_ftrace_get_regs(fregs)	({ &arch_ftrace_regs(fregs)->regs; })

I may send a v2 (tomorrow).

-- Steve


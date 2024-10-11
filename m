Return-Path: <linux-arch+bounces-8040-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282C499A4FB
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 15:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46771F234E5
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0696F216A10;
	Fri, 11 Oct 2024 13:27:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CD920CCE6;
	Fri, 11 Oct 2024 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653228; cv=none; b=e3mzM2YXs3Mcajm0/GKIgGFT9AVi0KbBpJT7+fxsJx3Ynwd/AifyKJk2fK+oTEIYoQOXDd1Rm+nxDNeVUl4KmDRlp1VOfxln7IEOn+7nIV49lOEtzDpkKJFfh6eJoYQQiCgcIccaFgx5V2XNoC/ERn3+kr8FYl6j+70dyIXkwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653228; c=relaxed/simple;
	bh=mvvtwNbvKp4A1OTylp8dWmb0t1EgcxbEJKD/LzFMstA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnhJGGsHmT1LQImW9oTmEE5oKlfoomK7AQyNuTccTFPfHRXHmuGqLuYPxoBdFPIv3r3QDEx8YcX+tLV06FSQU9q4eH3UoU49jTG8oXJuvQKNzlCctb2ZzLzYeibQQHl5D0+aj5xV0/H8A+XwerrgdZXkuAZATuTHMTxv7jd92KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D23C4CEC7;
	Fri, 11 Oct 2024 13:27:04 +0000 (UTC)
Date: Fri, 11 Oct 2024 09:27:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>, Will
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
Subject: Re: [PATCH v3] ftrace: Consolidate ftrace_regs accessor functions
 for archs using pt_regs
Message-ID: <20241011092714.71074a2b@gandalf.local.home>
In-Reply-To: <Zwj9QocrEVtgraHp@arm.com>
References: <20241010202114.2289f6fd@gandalf.local.home>
	<Zwj9QocrEVtgraHp@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 11:26:10 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Thu, Oct 10, 2024 at 08:21:14PM -0400, Steven Rostedt wrote:
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index bbb69c7751b9..5ccff4de7f09 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -54,6 +54,7 @@ extern void return_to_handler(void);
> >  unsigned long ftrace_call_adjust(unsigned long addr);
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > +#define HAVE_ARCH_FTRACE_REGS
> >  struct dyn_ftrace;
> >  struct ftrace_ops;
> >  struct ftrace_regs;  
> 
> In case you need an ack for the arm64 change
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks, appreciate it.

-- Steve


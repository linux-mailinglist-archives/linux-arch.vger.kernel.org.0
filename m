Return-Path: <linux-arch+bounces-8432-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02049AB9B5
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 00:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC61EB22043
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 22:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE11CDFC2;
	Tue, 22 Oct 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASu6p/OD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8428518DF6B;
	Tue, 22 Oct 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637717; cv=none; b=lcVUASxtu7d6lMO2h2Zk2xG1qlCdk5QnLsCzbRBvsPn3jmX6f8iBvZX8UsL+t2DHnLToCtwLNVbFsCj7Nw+n2QHpN4NqLj69myTPmZt4CiiMWXHRVIwi5XYdabRyG34TYZ/Ok+sFdnhWUm131eTkMfLEnzz7ar6F9Wip3cjJKec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637717; c=relaxed/simple;
	bh=mmB0h7GP5OEtq5xYgYIchtjpiU0bUWfBh3QydfmbdMc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hF9w3dMAPahlhNWbIOMYpRLVPifsbLSXMz2uHsi/Di204S8cSqEhruZeOO4Z74Qu20sF8yMBhZ2zguC09X8we4N51m3euF5HTsxiMPUXdX3dj4bnss3mkIpaTY3+wKPUWAOWSjorJO9lSCFGau8ZW81j64S1b9EjqqTKggcEeBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASu6p/OD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C8CC4CEC3;
	Tue, 22 Oct 2024 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729637717;
	bh=mmB0h7GP5OEtq5xYgYIchtjpiU0bUWfBh3QydfmbdMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ASu6p/OD42ChIQmHFxFr9v3Uut7yuCh45MCO2hw++Lkjld6Jr/OQx9lqwZ+ZPNM10
	 oJq97rdJrwZ9XNlxjth4RPMSbnbpXgWWvWIRseRkBJEbPGoiLwYx6xyx2JAiKXZgZl
	 GH8dMoAlfClEytaexMXLu2QkP+8gHyHWzhuWLOxtOtxjlZjaX6WRvv4N2yfkwAM9Ja
	 Wfs0rJif2mmYcrLm+a3pHWwupTHdyiqFHPC+TiqNsWeyVwTGYJcO+bOjEHBlgaEh7b
	 CQSFWKNhj8tkhBXOE8CkoX+57ZsDAs699JxntIAfOvvpKcWSzFaXM+g7YvGyvyLPtd
	 8F3OmoK82QV+A==
Date: Wed, 23 Oct 2024 07:55:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v17 01/16] function_graph: Pass ftrace_regs to entryfunc
Message-Id: <20241023075507.ebeadc70579fc8a642213a55@kernel.org>
In-Reply-To: <20241021170340.GB26122@willie-the-truck>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904027515.36809.1961937054923520469.stgit@devnote2>
	<20241021170340.GB26122@willie-the-truck>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 18:03:40 +0100
Will Deacon <will@kernel.org> wrote:

> On Wed, Oct 16, 2024 at 09:57:55AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Pass ftrace_regs to the fgraph_ops::entryfunc(). If ftrace_regs is not
> > available, it passes a NULL instead. User callback function can access
> > some registers (including return address) via this ftrace_regs.
> > 
> > Note that the ftrace_regs can be NULL when the arch does NOT define:
> > HAVE_DYNAMIC_FTRACE_WITH_ARGS or HAVE_DYNAMIC_FTRACE_WITH_REGS.
> > More specifically, if HAVE_DYNAMIC_FTRACE_WITH_REGS is defined but
> > not the HAVE_DYNAMIC_FTRACE_WITH_ARGS, and the ftrace ops used to
> > register the function callback does not set FTRACE_OPS_FL_SAVE_REGS.
> > In this case, ftrace_regs can be NULL in user callback.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: WANG Xuerui <kernel@xen0n.name>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: Naveen N Rao <naveen@kernel.org>
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> > ---
> >  Changes in v16:
> >   - Add a note when the ftrace_regs can be NULL.
> >   - Update against for the latest kernel.
> >  Changes in v11:
> >   - Update for the latest for-next branch.
> >  Changes in v8:
> >   - Just pass ftrace_regs to the handler instead of adding a new
> >     entryregfunc.
> >   - Update riscv ftrace_graph_func().
> >  Changes in v3:
> >   - Update for new multiple fgraph.
> > ---
> >  arch/arm64/kernel/ftrace.c               |   20 +++++++++++-
> >  arch/loongarch/kernel/ftrace_dyn.c       |   10 +++++-
> >  arch/powerpc/kernel/trace/ftrace.c       |    2 +
> >  arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++--
> >  arch/riscv/kernel/ftrace.c               |   17 ++++++++++
> >  arch/x86/kernel/ftrace.c                 |   50 +++++++++++++++++++++---------
> >  include/linux/ftrace.h                   |   17 ++++++++--
> >  kernel/trace/fgraph.c                    |   25 +++++++++------
> >  kernel/trace/ftrace.c                    |    3 +-
> >  kernel/trace/trace.h                     |    3 +-
> >  kernel/trace/trace_functions_graph.c     |    3 +-
> >  kernel/trace/trace_irqsoff.c             |    3 +-
> >  kernel/trace/trace_sched_wakeup.c        |    3 +-
> >  kernel/trace/trace_selftest.c            |    8 +++--
> >  14 files changed, 129 insertions(+), 45 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index b2d947175cbe..a5a285f8a7ef 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -481,7 +481,25 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
> >  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> >  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> >  {
> > -	prepare_ftrace_return(ip, &arch_ftrace_regs(fregs)->lr, arch_ftrace_regs(fregs)->fp);
> > +	unsigned long return_hooker = (unsigned long)&return_to_handler;
> > +	unsigned long frame_pointer = arch_ftrace_regs(fregs)->fp;
> > +	unsigned long *parent = &arch_ftrace_regs(fregs)->lr;
> > +	unsigned long old;
> > +
> > +	if (unlikely(atomic_read(&current->tracing_graph_pause)))
> > +		return;
> > +
> > +	/*
> > +	 * Note:
> > +	 * No protection against faulting at *parent, which may be seen
> > +	 * on other archs. It's unlikely on AArch64.
> > +	 */
> > +	old = *parent;
> 
> Sorry to pick on this line again, but the comment is very non-committal]
> and I think this is something on which we need to be definitive.

Agreed. I think this does not happen because it is a part of
__arch_ftrace_regs, which is stored on kernel stack.

I copied it from prepare_ftrace_return(), so that also need to be
changed too.

Let me remove this comment.

Thank you,

> 
> Either the access can fault, and we should handle it, or it will never
> fault and we don't need to handle it. Saying it's unlikely means we
> need to handle it :)
> 
> Will
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


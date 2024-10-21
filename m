Return-Path: <linux-arch+bounces-8374-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B59A707F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 928381C21BE6
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D601CBE89;
	Mon, 21 Oct 2024 17:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LC8uPiyS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC85FEE4;
	Mon, 21 Oct 2024 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530229; cv=none; b=F6HgPG4CyZ87unCDIwqH/c/HiAO/U2yKxtQ+GKEVxNtAE9pQSmlcYC741t6/bWROLCTurZJPvBQSFTul8Bgw4zq1H2PTR27NtK7DuZIrWF+my1QUIYtD6+QjaVe4RUEfj/QZEmUk2GZv7O3TxEDyQR4MrlXfOZIGs6riFJQ1niU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530229; c=relaxed/simple;
	bh=qdcSsG7Nspv31rTgsMv20FyoyQtpL2Xr9wmtuOxBRN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6SMytHjEMSNi8Bk/J29lkORR1Hl4m7JcHEycBINakxSbS19M4VNaqIOVRbSVb7+qagi5t2XNbf3Lmqtjbg1X+odR11734P8zhqwHorFd9dp6ws6+5wAW/tjGd6Yyj2PzCoVHBbEaiAri1O0CXyexBjEz0WRuRwCSVFnZSSt8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC8uPiyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1C1C4CEC3;
	Mon, 21 Oct 2024 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729530229;
	bh=qdcSsG7Nspv31rTgsMv20FyoyQtpL2Xr9wmtuOxBRN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LC8uPiySrQaRFZJIDB2IOKCB4vuVK2UJIJkz3gPsFl3Hib2WR31pyl2vr0ko1qsYk
	 hq2fPYHmEl+U+1IG5STcsIjYdCZcPKybq10blz0FrKKjTb8fx6cimfH9wMe3g7peDs
	 lIY6KL2koKuX+o68+PkETwZe2LqAgsWiYPVnY2ibZ4c7sAyRp5273WNKVXmCtQ5FzQ
	 /ulnvd4++x273hj6xevQvr3GSEJLqHh9c17KZKkZRZEvtkdHMjhk+M4TolD1clkb/4
	 o2gDcmMNFORTcG17MN6CqUPybpiQoCDqewOEJ4tpQK8DYsAbmParKZi+7yfs9Yx0/y
	 IrA+1lDE0jGow==
Date: Mon, 21 Oct 2024 18:03:40 +0100
From: Will Deacon <will@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v17 01/16] function_graph: Pass ftrace_regs to entryfunc
Message-ID: <20241021170340.GB26122@willie-the-truck>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
 <172904027515.36809.1961937054923520469.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172904027515.36809.1961937054923520469.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 16, 2024 at 09:57:55AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Pass ftrace_regs to the fgraph_ops::entryfunc(). If ftrace_regs is not
> available, it passes a NULL instead. User callback function can access
> some registers (including return address) via this ftrace_regs.
> 
> Note that the ftrace_regs can be NULL when the arch does NOT define:
> HAVE_DYNAMIC_FTRACE_WITH_ARGS or HAVE_DYNAMIC_FTRACE_WITH_REGS.
> More specifically, if HAVE_DYNAMIC_FTRACE_WITH_REGS is defined but
> not the HAVE_DYNAMIC_FTRACE_WITH_ARGS, and the ftrace ops used to
> register the function callback does not set FTRACE_OPS_FL_SAVE_REGS.
> In this case, ftrace_regs can be NULL in user callback.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> ---
>  Changes in v16:
>   - Add a note when the ftrace_regs can be NULL.
>   - Update against for the latest kernel.
>  Changes in v11:
>   - Update for the latest for-next branch.
>  Changes in v8:
>   - Just pass ftrace_regs to the handler instead of adding a new
>     entryregfunc.
>   - Update riscv ftrace_graph_func().
>  Changes in v3:
>   - Update for new multiple fgraph.
> ---
>  arch/arm64/kernel/ftrace.c               |   20 +++++++++++-
>  arch/loongarch/kernel/ftrace_dyn.c       |   10 +++++-
>  arch/powerpc/kernel/trace/ftrace.c       |    2 +
>  arch/powerpc/kernel/trace/ftrace_64_pg.c |   10 ++++--
>  arch/riscv/kernel/ftrace.c               |   17 ++++++++++
>  arch/x86/kernel/ftrace.c                 |   50 +++++++++++++++++++++---------
>  include/linux/ftrace.h                   |   17 ++++++++--
>  kernel/trace/fgraph.c                    |   25 +++++++++------
>  kernel/trace/ftrace.c                    |    3 +-
>  kernel/trace/trace.h                     |    3 +-
>  kernel/trace/trace_functions_graph.c     |    3 +-
>  kernel/trace/trace_irqsoff.c             |    3 +-
>  kernel/trace/trace_sched_wakeup.c        |    3 +-
>  kernel/trace/trace_selftest.c            |    8 +++--
>  14 files changed, 129 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index b2d947175cbe..a5a285f8a7ef 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -481,7 +481,25 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  		       struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
> -	prepare_ftrace_return(ip, &arch_ftrace_regs(fregs)->lr, arch_ftrace_regs(fregs)->fp);
> +	unsigned long return_hooker = (unsigned long)&return_to_handler;
> +	unsigned long frame_pointer = arch_ftrace_regs(fregs)->fp;
> +	unsigned long *parent = &arch_ftrace_regs(fregs)->lr;
> +	unsigned long old;
> +
> +	if (unlikely(atomic_read(&current->tracing_graph_pause)))
> +		return;
> +
> +	/*
> +	 * Note:
> +	 * No protection against faulting at *parent, which may be seen
> +	 * on other archs. It's unlikely on AArch64.
> +	 */
> +	old = *parent;

Sorry to pick on this line again, but the comment is very non-committal]
and I think this is something on which we need to be definitive.

Either the access can fault, and we should handle it, or it will never
fault and we don't need to handle it. Saying it's unlikely means we
need to handle it :)

Will


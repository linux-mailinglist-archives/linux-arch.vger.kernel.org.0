Return-Path: <linux-arch+bounces-8735-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 436DA9B718D
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 02:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC9D1F21E6A
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 01:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6443EA71;
	Thu, 31 Oct 2024 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDg4PJzd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB3C4C80;
	Thu, 31 Oct 2024 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337542; cv=none; b=iT3QYgsAXdZXTen++41X50ID5RyavWYmhyzZXPKoiYWovLetck4fzAmKFhWHKX7Dm6BUJOwLWixy6QxyUYMxhW8CI49qzbRSNzIqwjHAz/ZupIVMKBY97Fzrd3VLtrYSFq6wmbNqCG2OoVElUopNly6UWTEnYuApKuZkxWZAF6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337542; c=relaxed/simple;
	bh=k6H+CiBEJWddN02hdN0mo06Ec/Er8fguVn5cPFWrTyE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fr5mLTcXvMgxTaDl4VuhtRW0t7ifCmyZdRY3S3LTBqIkdjoP8w2Ew5525eF9rJu8/J6nan8FeIde6cyLEM/IO8RZzFKAO0KL+jBqcjPILN2gz/fO2IiaFR3yEavXO6+aWxecCCDDdqOqPVE46V3c1W26sCuRct6wCWsLyvv9FpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDg4PJzd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3FEC4CECE;
	Thu, 31 Oct 2024 01:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730337541;
	bh=k6H+CiBEJWddN02hdN0mo06Ec/Er8fguVn5cPFWrTyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mDg4PJzdtOtjUR3WsftvwH4KB5eO0CKN6FDp6lq4Tj+Z0uwKUIlQ+WW3yy2drijwS
	 zTcebee4TmLSLhvTDeh1g0+O/xGWUtWMnI30LnwTuhbF6I+h3iA30h5ac2IjMPHNmp
	 425sD+fPKmTI04Kw2TKo9oolPguB6Wq2dzxNtupzXOxmZEOSyPc7qYIDYqaC0y0IwA
	 xX9EV8ShzI47iEOzNVw5nxt79FLrsCxxd8TVgbpaHnP7bkEgelxWNOQfdwM9oFz9JH
	 jI73jIUbbrMK9LpQhvrsAPKlPeROh7aBP8fdm9uwghY0q7MD/QWKGuQ6Ui0vMkaMD0
	 Dv1cC48tFrABQ==
Date: Thu, 31 Oct 2024 10:18:53 +0900
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
Subject: Re: [PATCH v18 01/17] fgraph: Pass ftrace_regs to entryfunc
Message-Id: <20241031101853.898b866a21732350b5f02614@kernel.org>
In-Reply-To: <20241028152512.GB2484@willie-the-truck>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991733069.443985.15154246733356205391.stgit@devnote2>
	<20241028152512.GB2484@willie-the-truck>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 15:25:13 +0000
Will Deacon <will@kernel.org> wrote:

> On Sat, Oct 26, 2024 at 01:35:30PM +0900, Masami Hiramatsu (Google) wrote:
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
> >  Changes in v18:
> >   - Remove unclear comment about `regs->fp` access on arm64.
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
> >  arch/arm64/kernel/ftrace.c               |   15 ++++++++-
> 
> For the arm64 bits:
> 
> Acked-by: Will Deacon <will@kernel.org>
> 

Thank you for ack for arm64!

> Will


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


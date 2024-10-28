Return-Path: <linux-arch+bounces-8657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41B9B34BB
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 16:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4241C21EA0
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B71DE3C3;
	Mon, 28 Oct 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnCDUrlv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51FE1D9324;
	Mon, 28 Oct 2024 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730129122; cv=none; b=E+xGvwCaSirv1ZIA2dF6a1FUmFdpgrRxYldD6Tq5hPaXbY5KD+nJCZ4WQ5GPaAipg4iV4FvaGVHWRoBxVkIJZQGJqEWglOoP9T0nBddHF7HqsWu1vwlP3tUOWTvoCoT+MuCTVV45Aoq8TSW6YpeckjOKx0QeR8ZXf99I9H8V0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730129122; c=relaxed/simple;
	bh=JoX429j4Zj7g7EFQnQUQiXELq1ar7frfVq2eJPtKDUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ie5Xl90rMDkdbsUmk1Eb8m8V8DQq6HgUqpkZN1GAQPwlllpfF20oO873LzVZz7/afO4456Asp4Nvn+fRzkMWT3H6UQFSU89cG/5HWm4qQVfSmzzp+X/0Nvq3A4dvFDyyE0EW5QEucd/iJeyDT0u38oC4ufOH7TL+48YNiXQXA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnCDUrlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11844C4CEC3;
	Mon, 28 Oct 2024 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730129122;
	bh=JoX429j4Zj7g7EFQnQUQiXELq1ar7frfVq2eJPtKDUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnCDUrlvKWOl4ui5qkrNelEEk6CP5hbi5EReMeY/fQBWS7hxQY6sjMmRtdyjeMXSG
	 7o3ZV2QyQ0dRQ4AO6h+zs2QOXnNtsMdMnbI1pGiZDNZgcv4MN9/BMflRiAa7QdgWaj
	 qzKxzGWGFv/KXOnjMKrO4KN+Q06FOQOjHZTiyHtfCQDNq+86O2RdRaQifs+BrE9Pti
	 MnBBrjav/s1BKmwXFqmjq9tVcfYwxoemSoKyYKQFhdZ87gXvD5yoBJyefQZFPDB4wb
	 +GUN8q16XfVYH2gpv+8cpeEhlk40VUeNiSS92NH3zfaon9ZyO/SQBWWErWRt/qNRz9
	 oAhmNGbC4uMJA==
Date: Mon, 28 Oct 2024 15:25:13 +0000
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
Subject: Re: [PATCH v18 01/17] fgraph: Pass ftrace_regs to entryfunc
Message-ID: <20241028152512.GB2484@willie-the-truck>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
 <172991733069.443985.15154246733356205391.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172991733069.443985.15154246733356205391.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Oct 26, 2024 at 01:35:30PM +0900, Masami Hiramatsu (Google) wrote:
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
>  Changes in v18:
>   - Remove unclear comment about `regs->fp` access on arm64.
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
>  arch/arm64/kernel/ftrace.c               |   15 ++++++++-

For the arm64 bits:

Acked-by: Will Deacon <will@kernel.org>

Will


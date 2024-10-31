Return-Path: <linux-arch+bounces-8738-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BA79B83B0
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 20:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB76DB21A15
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 19:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE31CB52E;
	Thu, 31 Oct 2024 19:52:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E782B1C1ACB;
	Thu, 31 Oct 2024 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730404352; cv=none; b=ucqC1u9QKlfNsF6EHt7UmdGI95m2D7BYFM+YlPR3wR/hFqxLd2btW7+ulG21kheQEKQoxoln2YWOq+KS2HXOqSaM5doB8tdJ4um6CB+bOzOoG5hpue/qnF8v8sMVxEtEDykkLPinobz+/BieTeuT1dPb1kcOXz1COWbJSPQubJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730404352; c=relaxed/simple;
	bh=cG9Og3G+txKUTnhb5mRAu1HCEYEecJi4IJLdo7xz4Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cF9i7nDzSzH9HJH/FBx0pw8nLPpZPnmWAaMPWXKXPlFgKN1Udz6mCETlWPgoJh5RpIbM5qQlrazUKSbQ/50zf1zXHRw2pGAQP32/BlS8emvD4oV+tw6MqrRteczl/j6wbZyBcorLjQuDupzKLY9D+LZG2vT/CJu2i25MnSHR8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1C2C4CEC3;
	Thu, 31 Oct 2024 19:52:27 +0000 (UTC)
Date: Thu, 31 Oct 2024 15:53:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v18 01/17] fgraph: Pass ftrace_regs to entryfunc
Message-ID: <20241031155324.108ed8ef@gandalf.local.home>
In-Reply-To: <172991733069.443985.15154246733356205391.stgit@devnote2>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991733069.443985.15154246733356205391.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 13:35:30 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

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

If HAVE_DYNAMIC_FTRACE_WITH_REGS is defined but not
HAVE_DYNAMIC_FTRACE_WITH_ARGS is not, then the callback will have regs defined.

> @@ -977,7 +980,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
>  
>  static struct ftrace_ops graph_ops = {
>  	.func			= ftrace_graph_func,
> -	.flags			= FTRACE_OPS_GRAPH_STUB,
> +	.flags			= FTRACE_OPS_GRAPH_STUB | FTRACE_OPS_FL_SAVE_ARGS,

Enabling FTRACE_OPS_FL_SAVE_ARGS will pass full regs in that case. Are you
just saying in the change log that this is what you did? As it currently
reads, it sounds like a fgraph user needs to add FTRACE_OPS_FL_SAVE_REGS??

-- Steve


>  #ifdef FTRACE_GRAPH_TRAMP_ADDR
>  	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
>  	/* trampoline_size is only needed for dynamically allocated tramps */
> @@ -987,7 +990,8 @@ static struct ftrace_ops graph_ops = {
>  void fgraph_init_ops(struct ftrace_ops *dst_ops,
>  		     struct ftrace_ops *src_ops)
>  {
> -	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
> +	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB |
> +			 FTRACE_OPS_FL_SAVE_ARGS;
>  
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  	if (src_ops) {


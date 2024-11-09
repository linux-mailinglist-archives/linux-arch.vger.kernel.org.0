Return-Path: <linux-arch+bounces-8935-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF79C2DDB
	for <lists+linux-arch@lfdr.de>; Sat,  9 Nov 2024 15:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098002820BB
	for <lists+linux-arch@lfdr.de>; Sat,  9 Nov 2024 14:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9E51957F8;
	Sat,  9 Nov 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdGst02j"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE6D147C96;
	Sat,  9 Nov 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731163640; cv=none; b=dPajFZdcWOlOfC6xcCHmfCxZ0Ol1CC5GAoBCenK4igoiswBXqBhLnN8IquvybB/G/gzT8gek3/N0QxQioP/0K/jUMprw4G1kZ36+iZU2O1twuZmbVqXIMH8PI79YJBzWVoBiWBP4XUZKS7esS4mOIZm8OQ5xK3Yg2iEwSuJYpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731163640; c=relaxed/simple;
	bh=+pZ2o9F/kEox+nG25F5hXiP9+RbiboOoMx9pvyt77RM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gENMVIjTbvx9dbtWy+kF3cMfJgKt3uRFinai2w2dYyK35VlNyrAEwwYWxrk1VuoahwTvHS31OjXpKcfP8abXmp/ouNRBQPgAwXi29QcnQE2JStj4i5dCOyS9d4R5DFDS4eSdNOplkIutKSPwupdlBhdiLZttELUa6/VG8LbtT94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdGst02j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71F2C4CECE;
	Sat,  9 Nov 2024 14:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731163639;
	bh=+pZ2o9F/kEox+nG25F5hXiP9+RbiboOoMx9pvyt77RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QdGst02jdoLM4SbtJixk8xBb8nzTPyiDboxAMaA2mzvgO1w1Sk/tsCf4i//W/2M95
	 2RJy495QcUMoQa8pxRvP2wJcZ/k4iDt9FZ+i5bmcMBzEJhqAOVodcdcZJ2cBw9jZ6O
	 Okv6JS7vJZfNvLrWNEBj3Hlcnpvlr+qPXU2xbIngw4AjGzI0Wql8liXZUDVwvPLa5J
	 YrXC1Id7fGoEJAZZO4S2j67qlT3xtI3OkOwPPdw0jv9aq/IcZq2H2xys3q0kBe/8a5
	 jwMOI3yR547Wm+xbSAdV4Per4L6A5DCBe1G4hahYePhkLxKocF8UB2OM88RWnzDtcf
	 dFBFjKK6M+6hg==
Date: Sat, 9 Nov 2024 23:47:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20241109234710.818778fa74ca2ea5b883e0d1@kernel.org>
In-Reply-To: <20241031155324.108ed8ef@gandalf.local.home>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991733069.443985.15154246733356205391.stgit@devnote2>
	<20241031155324.108ed8ef@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 15:53:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 26 Oct 2024 13:35:30 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
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
> 
> If HAVE_DYNAMIC_FTRACE_WITH_REGS is defined but not
> HAVE_DYNAMIC_FTRACE_WITH_ARGS is not, then the callback will have regs defined.
> 
> > @@ -977,7 +980,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
> >  
> >  static struct ftrace_ops graph_ops = {
> >  	.func			= ftrace_graph_func,
> > -	.flags			= FTRACE_OPS_GRAPH_STUB,
> > +	.flags			= FTRACE_OPS_GRAPH_STUB | FTRACE_OPS_FL_SAVE_ARGS,
> 
> Enabling FTRACE_OPS_FL_SAVE_ARGS will pass full regs in that case. Are you
> just saying in the change log that this is what you did? As it currently
> reads, it sounds like a fgraph user needs to add FTRACE_OPS_FL_SAVE_REGS??

OK, I got it. I thought FTRACE_OPS_FL_SAVE_ARGS means it ensures to
save ARGS(means ftrace_regs) so that ftrace_graph_func can access it.
But anyway ftrace_regs is saved by *default*.

OK, I'll remove it.

Thanks,

> 
> -- Steve
> 
> 
> >  #ifdef FTRACE_GRAPH_TRAMP_ADDR
> >  	.trampoline		= FTRACE_GRAPH_TRAMP_ADDR,
> >  	/* trampoline_size is only needed for dynamically allocated tramps */
> > @@ -987,7 +990,8 @@ static struct ftrace_ops graph_ops = {
> >  void fgraph_init_ops(struct ftrace_ops *dst_ops,
> >  		     struct ftrace_ops *src_ops)
> >  {
> > -	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB;
> > +	dst_ops->flags = FTRACE_OPS_FL_PID | FTRACE_OPS_GRAPH_STUB |
> > +			 FTRACE_OPS_FL_SAVE_ARGS;
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >  	if (src_ops) {


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


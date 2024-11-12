Return-Path: <linux-arch+bounces-9046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7F9C6577
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2024 00:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AED6E2824C5
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FEA21A6F1;
	Tue, 12 Nov 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuFVYI1+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C2620ADC6;
	Tue, 12 Nov 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731455341; cv=none; b=sW3sp4w1zRDFUwHgSksZx/xsvv6cgpYeuiJi0Ii2ZRyAdOuB27VP+i+kyY529nObPG75LsCmxCCXdxQJL/UgnTDMhMz2lTKLGyhEgCJiS3F+OSeXX9Q2gPsZ/k8/7PqPdBw0tuVunz0Fioec7EAg4motpa05Rf7jVsrkDyK6Si0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731455341; c=relaxed/simple;
	bh=cDlrFqORAmp5emql+69NznXzQgn4UDJSwI2wrBQJcFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bPCra+PvJMIBKXpwJSsqf8jCLBQfax0ow75+xl8EGvHE/yq8j5SOVT8H66+nlfIcpnJ3RJVhnJf7rGG7UQ7GU90k28Id+/uEH++e8AR3KO93T/Rt4f+xMv6KqMnN1/kTedmA1xybX/Iw92JmopBNfk7xezOCm8E5Hl5gLwQWgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuFVYI1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C33C4CECD;
	Tue, 12 Nov 2024 23:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731455340;
	bh=cDlrFqORAmp5emql+69NznXzQgn4UDJSwI2wrBQJcFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WuFVYI1+IKCTbvtt0oi5mmbx/JgG2Q5My3qVWGqXPgigrZ90ssTNhFrFXGGpoXcwK
	 9VF7f4pN8D6Fu53tVAa781dvqB9b3hBqmf1xFnPh+HdUlZKTWWDa6VFgirtFYcvrVV
	 ceVSBA2Irj3jEJX5Lw/a8T6HLcM4ILPWjcWQpNWwUJLSpUPf2XKUT+eyBtA7r53H/A
	 gaNN7fNjo4/lMrMG4SGphYw3Btd4hYXejlKg03u49nbDSd9wxhV4em0m+yl4EV8e0d
	 S44VLS0bRxzs1dMCkLrKvuNfVZg/Lu9hqynl+372WdpcSHsyU9ipsKw0rffGP4QnZV
	 H+wsTFnES1aiQ==
Date: Wed, 13 Nov 2024 08:48:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v18 16/17] Documentation: probes: Update fprobe on
 function-graph tracer
Message-Id: <20241113084857.962b4af542fe700542ace929@kernel.org>
In-Reply-To: <20241101101448.10a3a0a9@gandalf.local.home>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991752671.443985.17111177875574390269.stgit@devnote2>
	<20241101101448.10a3a0a9@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 10:14:48 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 26 Oct 2024 13:38:46 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Update fprobe documentation for the new fprobe on function-graph
> > tracer. This includes some bahvior changes and pt_regs to
> > ftrace_regs interface change.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Update @fregs parameter explanation.
> > ---
> >  Documentation/trace/fprobe.rst |   42 ++++++++++++++++++++++++++--------------
> >  1 file changed, 27 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
> > index 196f52386aaa..f58bdc64504f 100644
> > --- a/Documentation/trace/fprobe.rst
> > +++ b/Documentation/trace/fprobe.rst
> > @@ -9,9 +9,10 @@ Fprobe - Function entry/exit probe
> >  Introduction
> >  ============
> >  
> > -Fprobe is a function entry/exit probe mechanism based on ftrace.
> > -Instead of using ftrace full feature, if you only want to attach callbacks
> > -on function entry and exit, similar to the kprobes and kretprobes, you can
> > +Fprobe is a function entry/exit probe mechanism based on the function-graph
> > +tracer.
> 
> You could still say "ftrace" as function-graph is part of the "ftrace"
> infrastructure. But I don't care either way.
> 
> > +Instead of tracing all functions, if you want to attach callbacks on specific
> > +function entry and exit, similar to the kprobes and kretprobes, you can
> >  use fprobe. Compared with kprobes and kretprobes, fprobe gives faster
> >  instrumentation for multiple functions with single handler. This document
> >  describes how to use fprobe.
> > @@ -91,12 +92,14 @@ The prototype of the entry/exit callback function are as follows:
> >  
> >  .. code-block:: c
> >  
> > - int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
> > + int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
> >  
> > - void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
> > + void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
> >  
> > -Note that the @entry_ip is saved at function entry and passed to exit handler.
> > -If the entry callback function returns !0, the corresponding exit callback will be cancelled.
> > +Note that the @entry_ip is saved at function entry and passed to exit
> > +handler.
> > +If the entry callback function returns !0, the corresponding exit callback
> > +will be cancelled.
> >  
> >  @fp
> >          This is the address of `fprobe` data structure related to this handler.
> > @@ -112,12 +115,10 @@ If the entry callback function returns !0, the corresponding exit callback will
> >          This is the return address that the traced function will return to,
> >          somewhere in the caller. This can be used at both entry and exit.
> >  
> > -@regs
> > -        This is the `pt_regs` data structure at the entry and exit. Note that
> > -        the instruction pointer of @regs may be different from the @entry_ip
> > -        in the entry_handler. If you need traced instruction pointer, you need
> > -        to use @entry_ip. On the other hand, in the exit_handler, the instruction
> > -        pointer of @regs is set to the current return address.
> > +@fregs
> > +        This is the `ftrace_regs` data structure at the entry and exit. This
> > +        includes the function parameters, or the return values. So user can
> > +        access thos values via appropriate `ftrace_regs_*` APIs.
> >  
> >  @entry_data
> >          This is a local storage to share the data between entry and exit handlers.
> > @@ -125,6 +126,17 @@ If the entry callback function returns !0, the corresponding exit callback will
> >          and `entry_data_size` field when registering the fprobe, the storage is
> >          allocated and passed to both `entry_handler` and `exit_handler`.
> >  
> > +Entry data size and exit handlers on the same function
> > +======================================================
> > +
> > +Since the entry data is passed via per-task stack and it is has limited size,
> 
> 						"and it has limited size"

Ah, I missed updating this document patch in v19. Need to fix that.

Thank you!


> 
> > +the entry data size per probe is limited to `15 * sizeof(long)`. You also need
> > +to take care that the different fprobes are probing on the same function, this
> > +limit becomes smaller. The entry data size is aligned to `sizeof(long)` and
> > +each fprobe which has exit handler uses a `sizeof(long)` space on the stack,
> > +you should keep the number of fprobes on the same function as small as
> > +possible.
> 
> -- Steve
> 
> > +
> >  Share the callbacks with kprobes
> >  ================================
> >  
> > @@ -165,8 +177,8 @@ This counter counts up when;
> >   - fprobe fails to take ftrace_recursion lock. This usually means that a function
> >     which is traced by other ftrace users is called from the entry_handler.
> >  
> > - - fprobe fails to setup the function exit because of the shortage of rethook
> > -   (the shadow stack for hooking the function return.)
> > + - fprobe fails to setup the function exit because of failing to allocate the
> > +   data buffer from the per-task shadow stack.
> >  
> >  The `fprobe::nmissed` field counts up in both cases. Therefore, the former
> >  skips both of entry and exit callback and the latter skips the exit
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


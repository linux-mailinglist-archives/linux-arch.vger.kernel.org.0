Return-Path: <linux-arch+bounces-9262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0301B9E6121
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 00:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAA0169229
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 23:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730761D0E27;
	Thu,  5 Dec 2024 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR/K3+LD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBC17E019;
	Thu,  5 Dec 2024 23:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733440202; cv=none; b=SMSBcYYz+heNMBSpc9zbdX6dfgVBe5CTKnvNs/yvmJL55Xm61+zolzzzsXDmgi5yE60oVk9pYUlTtxpPRTdPBYVBBWfWaBd9x/dkOAqxXxb+uqoEu5GfJABahpbSTeLDCb0bqy/HOOwuU5tSwaHzmCDMUHy4wTLngCIDw0MpKi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733440202; c=relaxed/simple;
	bh=dGnhSK+zDFaU2lVKZqg8PEYg0zwbuIjVMB9kwXCMYso=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MvgybfYN2JlOi78TZW93xalQhGD9uPmmF9tQFk+Dhmfuw9eR+YHLDjX1W4dC494y8JKbS//aR3KUw64Ze0G19tTXBCwU3izqrE/cHAZ5KjuSv7WfEvPjxMjUbZoxff1igPP+sI2jk0yjY8cBNtjWfS393dFAumHsYEFiKIyO7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR/K3+LD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C55C4CED1;
	Thu,  5 Dec 2024 23:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733440201;
	bh=dGnhSK+zDFaU2lVKZqg8PEYg0zwbuIjVMB9kwXCMYso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hR/K3+LDTUnt989YnYjo+x9MtFA48tfWWuh14KcFjFQO2X4X4exo4QGXotC2DF664
	 QD7Qc003PVClPKGUqzg0igEB3b5XmEflenpir776gxVRXHXJ+Ikip3dquIk8MSc+Am
	 Yzwus1Ma2ruy8v40uTpqvRDftBo1OdzhlX8pOoKX3N2fPx1s2L4LUOnWu6MPvr7lVo
	 tjJEsUE0AIO+V3fKMGrAgV7gts932KymfXE+j0Kdy6gWVT9aj/5UkR48LHhKvpoGta
	 2GG9coYrJKXQEJxeVNS4jitAamvDwOQvQPx+Oou3OYWjgLA3HJfQnuFbxqTHz8R/hz
	 3efTBjY3PKOHg==
Date: Fri, 6 Dec 2024 08:09:52 +0900
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
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v19 12/19] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20241206080952.512c59cc5ddbf45ef145b5ce@kernel.org>
In-Reply-To: <20241205133424.37877ad5@gandalf.local.home>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
	<173125386944.172790.10278368602020246931.stgit@devnote2>
	<20241205133424.37877ad5@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Dec 2024 13:34:24 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 11 Nov 2024 00:51:09 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index 2fc55a1a88aa..91a6382c04bd 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -307,12 +307,10 @@ config DYNAMIC_FTRACE_WITH_ARGS
> >  
> >  config FPROBE
> >  	bool "Kernel Function Probe (fprobe)"
> > -	depends on FUNCTION_TRACER
> > -	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
> > -	depends on HAVE_FTRACE_REGS_HAVING_PT_REGS || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > -	depends on HAVE_RETHOOK
> > -	select RETHOOK
> > -	default n
> > +	depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
> > +	depends on DYNAMIC_FTRACE_WITH_ARGS
> > +	select FUNCTION_GRAPH_TRACER
> > +	default y
> 
> Please remove the "default y". This will select function graph tracer and
> will not let you to disable it without disabling this.

Good catch! I forgot about the combination's side effect.

> 
> If you really want to tick off Linus, then make an option that selects other
> options "default y" ;-)

Oh, no, I don't want it.

> 
> Can you rebase the series off of v6.13-rc1? There's a minor conflict with
> the riscv Kconfig.

OK, let me update.

Thank you!

> 
> -- Steve
> 
> 
> >  	help
> >  	  This option enables kernel function probe (fprobe) based on ftrace.
> >  	  The fprobe is similar to kprobes, but probes only for kernel function


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <linux-arch+bounces-8194-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4465C99FC7C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9351C24586
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B96B1C07F7;
	Tue, 15 Oct 2024 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2cTIaN5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9721E3CA;
	Tue, 15 Oct 2024 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729035203; cv=none; b=MsaREQzTMa33wCQgMvfjrov5c3dhVHJKVqDrLAoALAfX9H8k2TXYBamIWNxqa/1wGQl5YoTkysX71eEUckc3d8O9juBmXKLs+OT/qbQmQ3Q6XvEdWBMVTR3HDJJf3dIMPzIPX0jBfVU8MwR7l1SOjLusXBDsnELiU0I+7sCg0tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729035203; c=relaxed/simple;
	bh=pb1LrK5LVSejDLEENkQ1SqMi84EwNgD9qtouXy5b7Z8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OOHko+hIZUQdLdhLaP9VvZOdGs1+J8NAwIbd9UlX5CVD4xYStZF5PEmOVUOIDwV1SzmbembTCkkehDtBmRhL+KnqgykViO7oqhU7wc7tDvpwfdvfCuVpiINTFtMO6p0+Y0SQTprozb/Ve2Qi6efe+tGbXd4m5k4Fj8gHNFe/WAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2cTIaN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A05C4CEC6;
	Tue, 15 Oct 2024 23:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729035202;
	bh=pb1LrK5LVSejDLEENkQ1SqMi84EwNgD9qtouXy5b7Z8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q2cTIaN5ot66UVgfOzGaLyp44X6PuFb8ClxeeqwsNp9SIs6DrmnhTxw86R+Rbdfgz
	 sJ7OzE1zlMdkkJaPc6LQBwbT8/5tGO8QX0GdBl53+F5+kdZXkQ79Sq4OitGQXLfWTu
	 H+wenRZT+6OzUV/ZWC5fUUuzUcO9CeY9aBL8ryPMF0Aw7nWdaW06Vb7qFXa8DEunwq
	 PD1ytlBNZQZBjkZL4BVCpSyA11V8jY6M7egVYgdEJrYvHxo6pwESHwi6vIqmtXGJo7
	 HkGoERfpzVK31kJ1uuHvz1fB4q/nGrozvAt2qmDJ4IxjTTpHchITbpxMrit2q5Rvvr
	 A09EPGFluXpgg==
Date: Wed, 16 Oct 2024 08:33:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v16 04/18] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-Id: <20241016083313.7198a3abf87e45ddb3dbb671@kernel.org>
In-Reply-To: <20241015183906.19678-B-hca@linux.ibm.com>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
	<172895575716.107311.6784997045170009035.stgit@devnote2>
	<20241015183906.19678-B-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 20:39:06 +0200
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Tue, Oct 15, 2024 at 10:29:17AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use ftrace_regs instead of fgraph_ret_regs for tracing return value
> > on function_graph tracer because of simplifying the callback interface.
> > 
> > The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
> > CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> ...
> 
> > diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
> > index 7e267ef63a7f..a9ca56ea0858 100644
> > --- a/arch/s390/kernel/mcount.S
> > +++ b/arch/s390/kernel/mcount.S
> > @@ -134,14 +134,15 @@ SYM_CODE_END(ftrace_common)
> >  SYM_FUNC_START(return_to_handler)
> >  	stmg	%r2,%r5,32(%r15)
> >  	lgr	%r1,%r15
> > -	aghi	%r15,-(STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE)
> > +	aghi	%r15,-(STACK_FRAME_OVERHEAD+STACK_FRAME_SIZE_FREGS)
> >  	stg	%r1,__SF_BACKCHAIN(%r15)
> > -	la	%r3,STACK_FRAME_OVERHEAD(%r15)
> > -	stg	%r1,__FGRAPH_RET_FP(%r3)
> > -	stg	%r2,__FGRAPH_RET_GPR2(%r3)
> > -	lgr	%r2,%r3
> > +	la	%r4,STACK_FRAME_OVERHEAD(%r15)
> > +	stg	%r2,__PT_R2(%r4)
> > +	stg	%r3,__PT_R3(%r4)
> > +	stg	%r1,__PT_R15(%r4)
> > +	lgr	%r2,%r4
> >  	brasl	%r14,ftrace_return_to_handler
> > -	aghi	%r15,STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE
> > +	aghi	%r15,STACK_FRAME_SIZE_FREGS
> >  	lgr	%r14,%r2
> >  	lmg	%r2,%r5,32(%r15)
> >  	BR_EX	%r14
> 
> Why didn't you simply merge the addon patch which I provided, and
> which I tested?
> https://lore.kernel.org/all/20240916121656.20933-B-hca@linux.ibm.com
> 
> That would make things much simpler... e.g. your new patch is also
> writing r3 to fregs, why? The stackframe allocation is also wrong.
> I didn't try, but I guess the above code would crash instantly.

I thought it is better to focus on replacing fgraph_ret_regs with
ftrace_regs in this patch, but if it is wrong and I should remove
stack_frame, let me fix that.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


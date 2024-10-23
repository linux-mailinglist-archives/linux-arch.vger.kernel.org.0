Return-Path: <linux-arch+bounces-8451-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267F19AC269
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 10:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F112B257D2
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B1166F16;
	Wed, 23 Oct 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp1KvIgv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A0C16130B;
	Wed, 23 Oct 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673881; cv=none; b=oInmV/zSfwJxGLusnETdVSGs56dcsgfmuboDpk7UkKKd0v1sPWfn7XlJa5J12v3WgBa10IskqL1Lq1gN3SlT90SzwRdYSFrcLx2Lx0SN7XVIoFRewARtvYpUrgH8szZVmDAP5+ZB6YfmC5vDXxgTRPQgLnbye1zHN1cm15DBN/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673881; c=relaxed/simple;
	bh=VXUL0OcM4+MvIg0hKX2tHVp6D78yAed1n0F8G8f0kVM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T/YmL8AxJzH9L47Uddkb83tjIbS3pMBOnIaVcOX3lcoDRqCVCKrcDCf6z4Mr5uPPnRK5sy67TWGcX59xNzriLaAbBlMzWjmU2KPKW4EKGWVXNiwzBhG/i5aEP4tylvVow6f3Q0COG7hGjw9MSaBtWK5Z0b/wvcTzofPqV+w0qLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp1KvIgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAE4C4CEE7;
	Wed, 23 Oct 2024 08:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729673880;
	bh=VXUL0OcM4+MvIg0hKX2tHVp6D78yAed1n0F8G8f0kVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lp1KvIgv+7tN1FxJbtK7i0ZSIUA2XcKaVtNO/BmohJaZnUQFcL2d9YslaGbpHtVYn
	 XqW8UiQkA53mkDL1mwVcU5B0RTrmVRbqOFspUmgKo/C3BaZeY2itBnvL3Dk+mIv+tJ
	 eguh734eX+gqKslZLUCqH8rjE/AdkpFEnD1rfASCWr6VocAaI6Uz0c3sWonRGjuUf/
	 TUeLZeA95Xox5QH/VVHCrkytBc9W+hvXA22wGCJSwPfasQc92QB54edb8hbrOF3mzS
	 AsZjGzN2BSioUXkbZjC6LdgJYwsDJubVUfCaozWYlTR4cBHI7H/loR6wE2iSvHRiWN
	 c5QxzmirSOzXw==
Date: Wed, 23 Oct 2024 17:57:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v17 06/16] tracing: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-Id: <20241023175756.eb42bcec858f6ac1c852de0c@kernel.org>
In-Reply-To: <20241021164619.GA26073@willie-the-truck>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904034052.36809.10990962223606196850.stgit@devnote2>
	<20241021164619.GA26073@willie-the-truck>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 17:46:19 +0100
Will Deacon <will@kernel.org> wrote:

> On Wed, Oct 16, 2024 at 09:59:00AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add ftrace_partial_regs() which converts the ftrace_regs to pt_regs.
> > This is for the eBPF which needs this to keep the same pt_regs interface
> > to access registers.
> > Thus when replacing the pt_regs with ftrace_regs in fprobes (which is
> > used by kprobe_multi eBPF event), this will be used.
> > 
> > If the architecture defines its own ftrace_regs, this copies partial
> > registers to pt_regs and returns it. If not, ftrace_regs is the same as
> > pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Florent Revest <revest@chromium.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > 
> > ---
> >  Changes in v14:
> >   - Add riscv change.
> >  Changes in v8:
> >   - Add the reason why this required in changelog.
> >  Changes from previous series: NOTHING, just forward ported.
> > ---
> >  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
> >  arch/riscv/include/asm/ftrace.h |   14 ++++++++++++++
> >  include/linux/ftrace.h          |   17 +++++++++++++++++
> >  3 files changed, 42 insertions(+)
> > 
> > diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> > index b5fa57b61378..d344c69eb01e 100644
> > --- a/arch/arm64/include/asm/ftrace.h
> > +++ b/arch/arm64/include/asm/ftrace.h
> > @@ -135,6 +135,17 @@ ftrace_regs_get_frame_pointer(const struct ftrace_regs *fregs)
> >  	return arch_ftrace_regs(fregs)->fp;
> >  }
> >  
> > +static __always_inline struct pt_regs *
> > +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> > +{
> > +	memcpy(regs->regs, arch_ftrace_regs(fregs)->regs, sizeof(u64) * 9);
> 
> Since ftrace_regs::regs is an 'unsigned long regs[9]' can we just use
> sizeof() on that instead of hard-coding the length of the array here?

Good catch! I will update it.

Thank you!

> 
> Will


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <linux-arch+bounces-8453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1519AC270
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 10:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA1D284551
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397D16F0F0;
	Wed, 23 Oct 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1UE5WdM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A5B15C15F;
	Wed, 23 Oct 2024 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673929; cv=none; b=Tyi8/6HZUXG6cuwqEeqLxIx3sxT8VxZ6pBQAZ1qXn+7ml5mHYXVGuypBC70nESxKH58Mt8Vghdi2Gb/Mq5poHMfoQfKBlARJE7pgc6zw2fnbOQ1FhYlhFZ94Q6Cd9Rc0wMmD3noPDFV8QNa5Zq9g1GgAlqIlrv6QQwUK0ro0AsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673929; c=relaxed/simple;
	bh=3ohT1rTcrcAg928IYFQmdlYqJAvLX7jh6yLC37ict58=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WPynIBZ3fYJzt0rxLcWIrg2ufBGk7ppbO7iYUob1iLbiprKULj89mqEQBj0Jx5oxH+NA4Yw2jr86uFcfibXjyeiHikW8CwMU1igEb0mAFqcFQbbozmrFPBItQmc45EA7ErO0NW7Z4iIJEKrAQNXlCxMo+Vv0T8R5+C+YEaa+qhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1UE5WdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA56C4CEC6;
	Wed, 23 Oct 2024 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729673929;
	bh=3ohT1rTcrcAg928IYFQmdlYqJAvLX7jh6yLC37ict58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1UE5WdMGvk8miZhYlOlaAXT29njINa1OJiFJwyxJUvlkvrnFGT047wxTDvEZbzjy
	 vC6WNCi69yTMx2BmCgGSmUogqYZoXe7qHNas5FaEswNqPpMbTbc69acxaz2pAiMwQz
	 tpcwU6qT/tTm1DHVXy+J3Dhx+UA6VRm8JlqAM8jielAtqKyV6KWDjDzJJ+NG0rKpXS
	 n86PQ2ZmjtkMrQVAJr0nbswK0JyvF16Ho7uVPDBhISJMJB7p1k9zHNouZ+vI+bDwLu
	 1fmofMiIPITPLr3QvZCg0JtFqGcbBuC31EnKcEZE0rrsr5RqV7/jz6fZXdnW5smrLT
	 ucIOXeTwjXEZQ==
Date: Wed, 23 Oct 2024 17:58:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v17 02/16] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-Id: <20241023175843.e1f92bb25e9f65a4e3ff2861@kernel.org>
In-Reply-To: <20241021164658.GB26073@willie-the-truck>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904028952.36809.12123402713602405457.stgit@devnote2>
	<20241021164658.GB26073@willie-the-truck>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 17:46:58 +0100
Will Deacon <will@kernel.org> wrote:

> On Wed, Oct 16, 2024 at 09:58:09AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use ftrace_regs instead of fgraph_ret_regs for tracing return value
> > on function_graph tracer because of simplifying the callback interface.
> > 
> > The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
> > CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Huacai Chen <chenhuacai@kernel.org>
> > Cc: WANG Xuerui <kernel@xen0n.name>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> > ---
> >  Changes in v17:
> >   - Fixes s390 return_to_handler according to Heiko's advice.
> >  Changes in v16:
> >   - According to the recent ftrace_regs.h change, override
> >     ftrace_regs_get_frame_pointer() if needed.
> >   - s390: keep stack_frame on stack, just replace fgraph_ret_regs
> >     with ftrace_regs.
> >  Changes in v8:
> >   - Newly added.
> > ---
> >  arch/arm64/Kconfig                  |    1 +
> >  arch/arm64/include/asm/ftrace.h     |   23 ++++++-----------------
> >  arch/arm64/kernel/asm-offsets.c     |   12 ------------
> >  arch/arm64/kernel/entry-ftrace.S    |   32 ++++++++++++++++++--------------
> 
> For the arm64 parts:
> 
> Acked-by: Will Deacon <will@kernel.org>

Thank you!

> 
> Will


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


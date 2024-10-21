Return-Path: <linux-arch+bounces-8370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAC59A6FFE
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6DA1F21114
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7001E1C22;
	Mon, 21 Oct 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7th4ogl"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B7D1CCB48;
	Mon, 21 Oct 2024 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529227; cv=none; b=tOrnE5SqfjMARsGDoNyqypGgd2I657JB71mm2DC7McqticMP66rTmr6DsfbeTX3kua94qPnxLil6INlT90bl3kaOT5d/zvXeG4mvrh8CkeBYXjSjtd8+pfrxhQDj6Wf/Gf9z1ATRhYY32rUlIJq2A1sjaaUltTk61nfEEqqcr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529227; c=relaxed/simple;
	bh=Q5GFFFYJnSN8U7ugPStwUdZA5rYx/3dERlYxotuRH2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgOauHZQQMy3CNhxbVHnNvKa8PkLt9+P89RObJ9eTN7pea6hnxeXqEXcRQKMv8miIrrsNeCzWbHFTPcDXkXNEuLDmV4LX6L61gIYZGdEf5CVonpJwmpmxAkmYlAnby5r5qSj0gUa93qSW2sOiLUJNjqn9QtM5TdhSe+Md0N2rcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7th4ogl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DD1C4CECD;
	Mon, 21 Oct 2024 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729529227;
	bh=Q5GFFFYJnSN8U7ugPStwUdZA5rYx/3dERlYxotuRH2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7th4oglQ8Q1elW4XxPsfqZTNgK7HI07k07I67fRzn62e5cBKpNzxpJQ6LSrbm7ES
	 nKMvcVTMSO0nZiornBNsMdWLKgEtLksUiBGt6JJUfIejqDz+Usl7zRt8sD+LoJFJGT
	 8OuqfWPv8yY7dDy4mtooPG5D3X1EavFnWNxRXZEbgGMMe5JoXjhjBdGyI7qJ+koKiQ
	 +RMOBEW9MM/MzIPWilEMAFWFOVOQr2JmbfUCiW/D6qYLxbD7d+JTRLj4pDV342f5aC
	 b+0jZ502dykLCXB4y6LRvLWdIqA3UFct8QksTtnLjbyY+7y1ks+ASo5k43RBPoo6X1
	 SeuqT/0ckfFJw==
Date: Mon, 21 Oct 2024 17:46:58 +0100
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
	Heiko Carstens <hca@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v17 02/16] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20241021164658.GB26073@willie-the-truck>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
 <172904028952.36809.12123402713602405457.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172904028952.36809.12123402713602405457.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 16, 2024 at 09:58:09AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use ftrace_regs instead of fgraph_ret_regs for tracing return value
> on function_graph tracer because of simplifying the callback interface.
> 
> The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
> CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> ---
>  Changes in v17:
>   - Fixes s390 return_to_handler according to Heiko's advice.
>  Changes in v16:
>   - According to the recent ftrace_regs.h change, override
>     ftrace_regs_get_frame_pointer() if needed.
>   - s390: keep stack_frame on stack, just replace fgraph_ret_regs
>     with ftrace_regs.
>  Changes in v8:
>   - Newly added.
> ---
>  arch/arm64/Kconfig                  |    1 +
>  arch/arm64/include/asm/ftrace.h     |   23 ++++++-----------------
>  arch/arm64/kernel/asm-offsets.c     |   12 ------------
>  arch/arm64/kernel/entry-ftrace.S    |   32 ++++++++++++++++++--------------

For the arm64 parts:

Acked-by: Will Deacon <will@kernel.org>

Will


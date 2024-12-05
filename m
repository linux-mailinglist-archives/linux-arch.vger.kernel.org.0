Return-Path: <linux-arch+bounces-9261-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7199E5E54
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 19:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 465A0168A6E
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2570822B8CC;
	Thu,  5 Dec 2024 18:34:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF81E225797;
	Thu,  5 Dec 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733423664; cv=none; b=mAtaohFU6j1PA7UubjtaDJHcjrA5Y8gH9VlGJ5X9Vgz06/5f25vk6b0LtRIXvlarBPFm1xtX5CRRb1qHkuptLzSCClILQ7SWTzIEtufFmnPRQxZId8phFQIUbhS1j9rJ7GLNGIbgfJPy/m9maszFTMfhqjoWBh09r5lhpaWPTks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733423664; c=relaxed/simple;
	bh=OUcxjilhRSUSD0E/yADisJZ2/8AfJns0Sv0memb8dWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGJcHzzr5xQQl1dIDxNE6KF7YvS6ctsLOmB6Wkm9v4NB5y3A8qRYUbb1ivYnsSSIOeYIE1FgKN7sM4Ino5PzWcGtNrx1qET0ELEtTXZ6q0Mm1vNfZDMpR0n3rvpaeXFJJSASp9JryZtYLkzZLTWC/wFP5YIQhuHw7TN0Sgw//iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73FB1C4CED1;
	Thu,  5 Dec 2024 18:34:19 +0000 (UTC)
Date: Thu, 5 Dec 2024 13:34:24 -0500
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
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v19 12/19] fprobe: Rewrite fprobe on function-graph
 tracer
Message-ID: <20241205133424.37877ad5@gandalf.local.home>
In-Reply-To: <173125386944.172790.10278368602020246931.stgit@devnote2>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
	<173125386944.172790.10278368602020246931.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 00:51:09 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 2fc55a1a88aa..91a6382c04bd 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -307,12 +307,10 @@ config DYNAMIC_FTRACE_WITH_ARGS
>  
>  config FPROBE
>  	bool "Kernel Function Probe (fprobe)"
> -	depends on FUNCTION_TRACER
> -	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
> -	depends on HAVE_FTRACE_REGS_HAVING_PT_REGS || !HAVE_DYNAMIC_FTRACE_WITH_ARGS
> -	depends on HAVE_RETHOOK
> -	select RETHOOK
> -	default n
> +	depends on HAVE_FUNCTION_GRAPH_FREGS && HAVE_FTRACE_GRAPH_FUNC
> +	depends on DYNAMIC_FTRACE_WITH_ARGS
> +	select FUNCTION_GRAPH_TRACER
> +	default y

Please remove the "default y". This will select function graph tracer and
will not let you to disable it without disabling this.

If you really want to tick off Linus, then make an option that selects other
options "default y" ;-)

Can you rebase the series off of v6.13-rc1? There's a minor conflict with
the riscv Kconfig.

-- Steve


>  	help
>  	  This option enables kernel function probe (fprobe) based on ftrace.
>  	  The fprobe is similar to kprobes, but probes only for kernel function


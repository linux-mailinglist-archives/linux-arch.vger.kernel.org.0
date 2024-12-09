Return-Path: <linux-arch+bounces-9316-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A39E8D02
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 09:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE911881777
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 08:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1273421516B;
	Mon,  9 Dec 2024 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wrzrwvrs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CEB21507B;
	Mon,  9 Dec 2024 08:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731511; cv=none; b=CT1WtT8uPYUUHHJiVLpqA1yyr0W6bxq6RNil0vNUyz1XalYOvcbrvyPUZgBYKULrZ+n2aXL/fn6jOJ2S6nMON2Rt1PniOOBv4YYlnQsV2VhAGUvB38e2qH53lFYxYq4jjVVMvlgm4A602WFqdvqSZUJkEXZCvYTrbiJrovcHv4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731511; c=relaxed/simple;
	bh=2LZ3wsSpA8YzRW7n+6GiEfPgfijojETpmsFsSU29S1E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Lqo4ccPombcigHr1lpmVnCa6Zy5Gfeb+BMItEjA4ALtdHRjSfYNULBZ+ayXTRj0QuFWmSKG5DE/Do2A4gINzlxnMkbCcE7wXGQTXM5twMVOArmjuWjb2z48X+tir9jnHgoOOAClvHAsEJ1cJnHkwIDUsS1eCzAHJbXoVMNA4vQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wrzrwvrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E83C4CED1;
	Mon,  9 Dec 2024 08:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733731510;
	bh=2LZ3wsSpA8YzRW7n+6GiEfPgfijojETpmsFsSU29S1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WrzrwvrsXRofRczT48p4XsnPaaqWJIU4DNPhXuxGVoOutuZzmaNUxRhUnxBqpM5T9
	 abTn0XZBEfhH+odjXB2kMd2aG5gNxcDEx73elHJTNAK7/zfEVIRJkFJ0a2i164V4/b
	 PHbfiCxq17J5FdBzvPXuBx2ea8bFyFPIgQwwYOie2pUt91qgJJtXK1FDq3viKGO93U
	 oE4AGQzyi50zoXSEfuD50R0w3CQB2rpIe/+vzbOQykU3xtekRRadWkIiC846XXmo1V
	 LRqcYpcCmonJ7E0hf1vPXDl7PUya+6xbUlVgpUnE4sQBMKvQZR+1WSWCPCr92qujrB
	 tdMGgDhW4PU4A==
Date: Mon, 9 Dec 2024 17:05:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v19 18/19] ftrace: Add ftrace_get_symaddr to convert
 fentry_ip to symaddr
Message-Id: <20241209170505.61d4a585c2b0282190f29954@kernel.org>
In-Reply-To: <173125394102.172790.7669548166614384865.stgit@devnote2>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
	<173125394102.172790.7669548166614384865.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 00:52:21 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> This introduces ftrace_get_symaddr() which tries to convert fentry_ip
> passed by ftrace or fgraph callback to symaddr without calling
> kallsyms API. It returns the symbol address or 0 if it fails to
> convert it.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v19:
>   - Newly added.
> ---
>  arch/arm64/include/asm/ftrace.h |    2 +
>  arch/arm64/kernel/ftrace.c      |   63 +++++++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/ftrace.h   |   21 +++++++++++++
>  include/linux/ftrace.h          |   13 ++++++++
>  4 files changed, 99 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 876e88ad4119..f08e70bf09ea 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -52,6 +52,8 @@ extern unsigned long ftrace_graph_call;
>  extern void return_to_handler(void);
>  
>  unsigned long ftrace_call_adjust(unsigned long addr);
> +unsigned long arch_ftrace_call_adjust(unsigned long fentry_ip);
> +#define ftrace_call_adjust(fentry_ip) arch_ftrace_call_adjust(fentry_ip)

Oops, this is arch_ftrace_get_symaddr()!

It needs to be fixed.

Thanks,

>  
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
>  #define HAVE_ARCH_FTRACE_REGS
> diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> index 606fd6994578..de1223669758 100644
> --- a/arch/arm64/kernel/ftrace.c
> +++ b/arch/arm64/kernel/ftrace.c
> @@ -143,6 +143,69 @@ unsigned long ftrace_call_adjust(unsigned long addr)
>  	return addr;
>  }
>  
> +/* Convert fentry_ip to the symbol address without kallsyms */
> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> +{
> +	u32 insn;
> +
> +	/*
> +	 * When using patchable-function-entry without pre-function NOPS, ftrace
> +	 * entry is the address of the first NOP after the function entry point.
> +	 *
> +	 * The compiler has either generated:
> +	 *
> +	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
> +	 * func+04:		NOP		// To be patched to BL <caller>
> +	 *
> +	 * Or:
> +	 *
> +	 * func-04:		BTI	C
> +	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
> +	 * func+04:		NOP		// To be patched to BL <caller>
> +	 *
> +	 * The fentry_ip is the address of `BL <caller>` which is at `func + 4`
> +	 * bytes in either case.
> +	 */
> +	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
> +		return fentry_ip - AARCH64_INSN_SIZE;
> +
> +	/*
> +	 * When using patchable-function-entry with pre-function NOPs, BTI is
> +	 * a bit different.
> +	 *
> +	 * func+00:	func:	NOP		// To be patched to MOV X9, LR
> +	 * func+04:		NOP		// To be patched to BL <caller>
> +	 *
> +	 * Or:
> +	 *
> +	 * func+00:	func:	BTI	C
> +	 * func+04:		NOP		// To be patched to MOV X9, LR
> +	 * func+08:		NOP		// To be patched to BL <caller>
> +	 *
> +	 * The fentry_ip is the address of `BL <caller>` which is at either
> +	 * `func + 4` or `func + 8` depends on whether there is a BTI.
> +	 */
> +
> +	/* If there is no BTI, the func address should be one instruction before. */
> +	if (!IS_ENABLED(CONFIG_ARM64_BTI_KERNEL))
> +		return fentry_ip - AARCH64_INSN_SIZE;
> +
> +	/* We want to be extra safe in case entry ip is on the page edge,
> +	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> +	 */
> +	if ((fentry_ip & ~PAGE_MASK) < AARCH64_INSN_SIZE * 2) {
> +		if (get_kernel_nofault(insn, (u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2)))
> +			return 0;
> +	} else {
> +		insn = *(u32 *)(fentry_ip - AARCH64_INSN_SIZE * 2);
> +	}
> +
> +	if (aarch64_insn_is_bti(le32_to_cpu((__le32)insn)))
> +		return fentry_ip - AARCH64_INSN_SIZE * 2;
> +
> +	return fentry_ip - AARCH64_INSN_SIZE;
> +}
> +
>  /*
>   * Replace a single instruction, which may be a branch or NOP.
>   * If @validate == true, a replaced instruction is checked against 'old'.
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index cc92c99ef276..f9cb4d07df58 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -34,6 +34,27 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
>  	return addr;
>  }
>  
> +static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> +{
> +#ifdef CONFIG_X86_KERNEL_IBT
> +	u32 instr;
> +
> +	/* We want to be extra safe in case entry ip is on the page edge,
> +	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> +	 */
> +	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> +		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> +			return fentry_ip;
> +	} else {
> +		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> +	}
> +	if (is_endbr(instr))
> +		fentry_ip -= ENDBR_INSN_SIZE;
> +#endif
> +	return fentry_ip;
> +}
> +#define ftrace_get_symaddr(fentry_ip)	arch_ftrace_get_symaddr(fentry_ip)
> +
>  #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  
>  #include <linux/ftrace_regs.h>
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 4c553fe9c026..9659bb2cd76c 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -652,6 +652,19 @@ struct ftrace_ops *ftrace_ops_trampoline(unsigned long addr);
>  
>  bool is_ftrace_trampoline(unsigned long addr);
>  
> +/* Arches can override ftrace_get_symaddr() to convert fentry_ip to symaddr. */
> +#ifndef ftrace_get_symaddr
> +/**
> + * ftrace_get_symaddr - return the symbol address from fentry_ip
> + * @fentry_ip: the address of ftrace location
> + *
> + * Get the symbol address from @fentry_ip (fast path). If there is no fast
> + * search path, this returns 0.
> + * User may need to use kallsyms API to find the symbol address.
> + */
> +#define ftrace_get_symaddr(fentry_ip) (0)
> +#endif
> +
>  /*
>   * The dyn_ftrace record's flags field is split into two parts.
>   * the first part which is '0-FTRACE_REF_MAX' is a counter of
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


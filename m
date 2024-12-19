Return-Path: <linux-arch+bounces-9446-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC679F86F4
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 22:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E5F16CD15
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 21:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F97919D08F;
	Thu, 19 Dec 2024 21:34:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08375111A8;
	Thu, 19 Dec 2024 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644051; cv=none; b=QGHJfP4jAvhe7VkAlleSFdmYZYCAGsbWXIU6utLVqhSGgcTbQ8BgvDh8ypU9Mw2i5c3ib0FRzLtonXAKGiMMuhYzZXT+l1KG4pPDBcjpokC1CTqzfnwjPi/ADfAhZ8q9RwYfl2PLe6XSi6IMaLRejsqIDScJqMdvQr1Ir2SOhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644051; c=relaxed/simple;
	bh=Kq6smtrgRdj3MN98txXPJcQ/g6nzmxGtADA9GDLfkmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pH8gEnz06NgkAiJH38jfdnOA3frHbPneOLSV894RiGhtn1W+DiPnOxjhsf5BuCOd4uX128zal+uGajjErGaq442y+R+hNar5M56IlUPMt4aLI2PWJ9IoJkZsRValC5t03q+kBe7AJGZ30BVJf1568d5+u8dNyPhHWRk1wUtPHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98489C4CECE;
	Thu, 19 Dec 2024 21:34:07 +0000 (UTC)
Date: Thu, 19 Dec 2024 16:34:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>, Will Deacon <will@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v21 03/20] fgraph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20241219163448.7fe08f79@gandalf.local.home>
In-Reply-To: <173379656618.973433.13429645373226409113.stgit@devnote2>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
	<173379656618.973433.13429645373226409113.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 11:09:26 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

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

Did Heiko ack this? I don't see it in my inbox.

> ---
>  Changes in v18:
>   - Use PTREGS_SIZE instead of redefining FRAME_SIZE on i386.
>  Changes in v17:
>   - Fixes s390 return_to_handler according to Heiko's advice.

I see the comments, but I want to make sure Heiko is happy with this.


> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 0077969170e8..102029e56cf0 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -192,7 +192,7 @@ config S390
>  	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_FUNCTION_ARG_ACCESS_API
>  	select HAVE_FUNCTION_ERROR_INJECTION
> -	select HAVE_FUNCTION_GRAPH_RETVAL
> +	select HAVE_FUNCTION_GRAPH_FREGS
>  	select HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER
>  	select HAVE_GCC_PLUGINS
> diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
> index fc97d75dc752..5c94c1fc1bc1 100644
> --- a/arch/s390/include/asm/ftrace.h
> +++ b/arch/s390/include/asm/ftrace.h
> @@ -62,23 +62,6 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
>  	return NULL;
>  }
>  
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -struct fgraph_ret_regs {
> -	unsigned long gpr2;
> -	unsigned long fp;
> -};
> -
> -static __always_inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
> -{
> -	return ret_regs->gpr2;
> -}
> -
> -static __always_inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
> -{
> -	return ret_regs->fp;
> -}
> -#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> -
>  static __always_inline void
>  ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
>  				    unsigned long ip)
> @@ -86,6 +69,13 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
>  	arch_ftrace_regs(fregs)->regs.psw.addr = ip;
>  }
>  
> +#undef ftrace_regs_get_frame_pointer
> +static __always_inline unsigned long
> +ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
> +{
> +	return ftrace_regs_get_stack_pointer(fregs);
> +}
> +
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>  /*
>   * When an ftrace registered caller is tracing a function that is
> diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
> index 862a9140528e..36709112ae7a 100644
> --- a/arch/s390/kernel/asm-offsets.c
> +++ b/arch/s390/kernel/asm-offsets.c
> @@ -175,12 +175,6 @@ int main(void)
>  	DEFINE(OLDMEM_SIZE, PARMAREA + offsetof(struct parmarea, oldmem_size));
>  	DEFINE(COMMAND_LINE, PARMAREA + offsetof(struct parmarea, command_line));
>  	DEFINE(MAX_COMMAND_LINE_SIZE, PARMAREA + offsetof(struct parmarea, max_command_line_size));
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -	/* function graph return value tracing */
> -	OFFSET(__FGRAPH_RET_GPR2, fgraph_ret_regs, gpr2);
> -	OFFSET(__FGRAPH_RET_FP, fgraph_ret_regs, fp);
> -	DEFINE(__FGRAPH_RET_SIZE, sizeof(struct fgraph_ret_regs));
> -#endif
>  	OFFSET(__FTRACE_REGS_PT_REGS, __arch_ftrace_regs, regs);
>  	DEFINE(__FTRACE_REGS_SIZE, sizeof(struct __arch_ftrace_regs));
>  
> diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
> index 7e267ef63a7f..2b628aa3d809 100644
> --- a/arch/s390/kernel/mcount.S
> +++ b/arch/s390/kernel/mcount.S
> @@ -134,14 +134,14 @@ SYM_CODE_END(ftrace_common)
>  SYM_FUNC_START(return_to_handler)
>  	stmg	%r2,%r5,32(%r15)
>  	lgr	%r1,%r15
> -	aghi	%r15,-(STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE)
> +	# allocate ftrace_regs and stack frame for ftrace_return_to_handler
> +	aghi	%r15,-STACK_FRAME_SIZE_FREGS
>  	stg	%r1,__SF_BACKCHAIN(%r15)
> -	la	%r3,STACK_FRAME_OVERHEAD(%r15)
> -	stg	%r1,__FGRAPH_RET_FP(%r3)
> -	stg	%r2,__FGRAPH_RET_GPR2(%r3)
> -	lgr	%r2,%r3
> +	stg	%r2,(STACK_FREGS_PTREGS_GPRS+2*8)(%r15)
> +	stg	%r1,(STACK_FREGS_PTREGS_GPRS+15*8)(%r15)
> +	la	%r2,STACK_FRAME_OVERHEAD(%r15)
>  	brasl	%r14,ftrace_return_to_handler
> -	aghi	%r15,STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE
> +	aghi	%r15,STACK_FRAME_SIZE_FREGS
>  	lgr	%r14,%r2
>  	lmg	%r2,%r5,32(%r15)
>  	BR_EX	%r14


Heiko,

Does the above look OK to you?

Thanks,

-- Steve



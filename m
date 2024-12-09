Return-Path: <linux-arch+bounces-9318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3132F9E8EC4
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 10:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E892845BC
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 09:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F575216391;
	Mon,  9 Dec 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4CzFrdY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BE216388;
	Mon,  9 Dec 2024 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736603; cv=none; b=e0CODS4mDT2WHLaOx37ZUSngFlWl+Um1L1bcfK/z4zYWdlcIfknID2N4NQulWX29WQs46elt+kz5hhOpfuIWI9tXI0QGnNwEfg+YI880J8lxosYUzCHd4K6+rMihA2AHyCZ+8rIcIH9rC+d+xWQl0wlif7jHvqowwibWgc4D+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736603; c=relaxed/simple;
	bh=yv+BSltKp4b7A7hq39KJPxFz5WT9p6xbBqie83T2ieY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RZAOVWYUc4ni+xpZ4J4D9kal5KE8RXQx3GR5VchGLOS4aRzPzJ5j8F5eEOf2x8520Bg1DgUsiZeQ2eW2vN/WUcd1SjVGA+AHvlgLkz22esQ+T+Imb4BDUoWODhRFYhNWycaC99ai45AQhP9bgIqwDoPhg2Qq3C587KuS7bZnlo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4CzFrdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910B1C4CED1;
	Mon,  9 Dec 2024 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733736602;
	bh=yv+BSltKp4b7A7hq39KJPxFz5WT9p6xbBqie83T2ieY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L4CzFrdYneCq3dkDXjc2V6Gs5DYTie8l/t+bAoyHktrPazWKH4i0yCt+IjFxOvoV6
	 QyY1xl/05OM+ALdiO2G474Ld3dwOMIFeR65lIwu0Q+NDQCFq6Jpy2A7PCfWY+kvls2
	 Q3AhPAD3hQokITEPSkyU0LNrtftyWud9wX9G45X229DydbeIH+F8EDbr4QhKusvyZt
	 hSguNZeg/EhGBJEZ7X/QsyA3FSu5KwRrNCBH/IA/QhP+Bw9t6e19X8Ll20/Xj4hfMv
	 ANa9JxuxARej/+JkVWgtSjbYVwEo8wjkgCLXNIj0MdrHzOO/m/nFtmVIcy3zUDEUHG
	 BE7mh+H7N73yw==
Date: Mon, 9 Dec 2024 18:29:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v19 19/19] bpf: Use ftrace_get_symaddr() in
 get_entry_ip()
Message-Id: <20241209182957.2d5933b7db40647822b45273@kernel.org>
In-Reply-To: <173125395146.172790.15945895464150788842.stgit@devnote2>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
	<173125395146.172790.15945895464150788842.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 00:52:31 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Rewrite get_entry_ip() to use ftrace_get_symaddr() macro.

I found a root problem of this patch. This get_entry_ip() is used not
only for fprobe (kprobe_multi) but also kprobes, but that is wrong.
On x86, both kprobes and ftrace (fentry) have the same restriction,
it should avoid ENDBR. But on arm64, ftrace_get_symaddr() is only for
fprobe, and kp->addr should point the symbol address.

So what I should do is to use `ftrace_get_symaddr()` version for
fprobe (kprobe_multi) and keep this original function for kprobe.

Let me fix that.

Thanks,

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v19:
>   - Use ftrace_get_symaddr() instead of introducing new arch dependent code.
>   - Also, replace x86 code with ftrace_get_symaddr(), which does the same
>    thing.
> ---
>  kernel/trace/bpf_trace.c |   19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 1532e9172bf9..e848a782bc8d 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1024,27 +1024,12 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
>  	.arg1_type	= ARG_PTR_TO_CTX,
>  };
>  
> -#ifdef CONFIG_X86_KERNEL_IBT
>  static unsigned long get_entry_ip(unsigned long fentry_ip)
>  {
> -	u32 instr;
> +	unsigned long ret = ftrace_get_symaddr(fentry_ip);
>  
> -	/* We want to be extra safe in case entry ip is on the page edge,
> -	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
> -	 */
> -	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
> -		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
> -			return fentry_ip;
> -	} else {
> -		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
> -	}
> -	if (is_endbr(instr))
> -		fentry_ip -= ENDBR_INSN_SIZE;
> -	return fentry_ip;
> +	return ret ? : fentry_ip;
>  }
> -#else
> -#define get_entry_ip(fentry_ip) fentry_ip
> -#endif
>  
>  BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
>  {
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <linux-arch+bounces-8759-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 991389B92EA
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 15:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A98B20CC3
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 14:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A711A2642;
	Fri,  1 Nov 2024 14:13:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EA43398A;
	Fri,  1 Nov 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470432; cv=none; b=dxCleZtlJMRB3tuMLyGnVNCuBmQ0pVurCaMLp+i0XAduBUTlto6Syn0wN9gX0mTiZrwCXxbNZfQVUELcLxSG+Ni+p2Ke7UhGQ8e//9SLU+PGA/j0gmUGL4d6o3X2Rv3YapVGXrfgSjivjG2FjwJ1aFma4WHewNF3SxHpxhiGQFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470432; c=relaxed/simple;
	bh=7gHYPhKB1HrIr4BHeRbqcX+ShRrQvykm0Rgcgp6icFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8zNZPIaEXrx1tAGzzzJVu8MGi7InFQ6gkFzBHZnyPfybWehlW1Uii8zlzgsp0GFpE9EmX4hxGSfQANKl04X3SGTfr2qqwHynTYmyJ6h0dj6PswXMT/2lF/6NvafF5XEWtA696fYLXJoh7wxZ6vbhHLy4cUZcCta7a+1i2he9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F585C4CECD;
	Fri,  1 Nov 2024 14:13:50 +0000 (UTC)
Date: Fri, 1 Nov 2024 10:14:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v18 16/17] Documentation: probes: Update fprobe on
 function-graph tracer
Message-ID: <20241101101448.10a3a0a9@gandalf.local.home>
In-Reply-To: <172991752671.443985.17111177875574390269.stgit@devnote2>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991752671.443985.17111177875574390269.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 13:38:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Update fprobe documentation for the new fprobe on function-graph
> tracer. This includes some bahvior changes and pt_regs to
> ftrace_regs interface change.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Update @fregs parameter explanation.
> ---
>  Documentation/trace/fprobe.rst |   42 ++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
> index 196f52386aaa..f58bdc64504f 100644
> --- a/Documentation/trace/fprobe.rst
> +++ b/Documentation/trace/fprobe.rst
> @@ -9,9 +9,10 @@ Fprobe - Function entry/exit probe
>  Introduction
>  ============
>  
> -Fprobe is a function entry/exit probe mechanism based on ftrace.
> -Instead of using ftrace full feature, if you only want to attach callbacks
> -on function entry and exit, similar to the kprobes and kretprobes, you can
> +Fprobe is a function entry/exit probe mechanism based on the function-graph
> +tracer.

You could still say "ftrace" as function-graph is part of the "ftrace"
infrastructure. But I don't care either way.

> +Instead of tracing all functions, if you want to attach callbacks on specific
> +function entry and exit, similar to the kprobes and kretprobes, you can
>  use fprobe. Compared with kprobes and kretprobes, fprobe gives faster
>  instrumentation for multiple functions with single handler. This document
>  describes how to use fprobe.
> @@ -91,12 +92,14 @@ The prototype of the entry/exit callback function are as follows:
>  
>  .. code-block:: c
>  
> - int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
> + int entry_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
>  
> - void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct pt_regs *regs, void *entry_data);
> + void exit_callback(struct fprobe *fp, unsigned long entry_ip, unsigned long ret_ip, struct ftrace_regs *fregs, void *entry_data);
>  
> -Note that the @entry_ip is saved at function entry and passed to exit handler.
> -If the entry callback function returns !0, the corresponding exit callback will be cancelled.
> +Note that the @entry_ip is saved at function entry and passed to exit
> +handler.
> +If the entry callback function returns !0, the corresponding exit callback
> +will be cancelled.
>  
>  @fp
>          This is the address of `fprobe` data structure related to this handler.
> @@ -112,12 +115,10 @@ If the entry callback function returns !0, the corresponding exit callback will
>          This is the return address that the traced function will return to,
>          somewhere in the caller. This can be used at both entry and exit.
>  
> -@regs
> -        This is the `pt_regs` data structure at the entry and exit. Note that
> -        the instruction pointer of @regs may be different from the @entry_ip
> -        in the entry_handler. If you need traced instruction pointer, you need
> -        to use @entry_ip. On the other hand, in the exit_handler, the instruction
> -        pointer of @regs is set to the current return address.
> +@fregs
> +        This is the `ftrace_regs` data structure at the entry and exit. This
> +        includes the function parameters, or the return values. So user can
> +        access thos values via appropriate `ftrace_regs_*` APIs.
>  
>  @entry_data
>          This is a local storage to share the data between entry and exit handlers.
> @@ -125,6 +126,17 @@ If the entry callback function returns !0, the corresponding exit callback will
>          and `entry_data_size` field when registering the fprobe, the storage is
>          allocated and passed to both `entry_handler` and `exit_handler`.
>  
> +Entry data size and exit handlers on the same function
> +======================================================
> +
> +Since the entry data is passed via per-task stack and it is has limited size,

						"and it has limited size"

> +the entry data size per probe is limited to `15 * sizeof(long)`. You also need
> +to take care that the different fprobes are probing on the same function, this
> +limit becomes smaller. The entry data size is aligned to `sizeof(long)` and
> +each fprobe which has exit handler uses a `sizeof(long)` space on the stack,
> +you should keep the number of fprobes on the same function as small as
> +possible.

-- Steve

> +
>  Share the callbacks with kprobes
>  ================================
>  
> @@ -165,8 +177,8 @@ This counter counts up when;
>   - fprobe fails to take ftrace_recursion lock. This usually means that a function
>     which is traced by other ftrace users is called from the entry_handler.
>  
> - - fprobe fails to setup the function exit because of the shortage of rethook
> -   (the shadow stack for hooking the function return.)
> + - fprobe fails to setup the function exit because of failing to allocate the
> +   data buffer from the per-task shadow stack.
>  
>  The `fprobe::nmissed` field counts up in both cases. Therefore, the former
>  skips both of entry and exit callback and the latter skips the exit



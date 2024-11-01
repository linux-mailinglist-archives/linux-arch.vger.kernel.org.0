Return-Path: <linux-arch+bounces-8765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 342AB9B9890
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 20:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D259E1F23AF4
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 19:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0421D1500;
	Fri,  1 Nov 2024 19:27:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4A1D0175;
	Fri,  1 Nov 2024 19:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489270; cv=none; b=fX1Jveqi+TkCknVesfuMz4WR5wh5XHtitelSLDYIkSCW9RgP1j6NOpQqZ1CjwoaO0gPCOgWYxpBjI0UAHJOP3ZVqM56vbK1ZdeneWtVj0k1DiqMwr8TSGxnBWMcrthwYjXWgz6V7IuKSkI5oopPZ/BrmisA1yCDrHlTpz/e7a2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489270; c=relaxed/simple;
	bh=qUoDfrWZtTXA73EqDAfTKWfPD+zXz7pQ7pVwV8DMHsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+ni3qHy+9wuYDtoLc8BdjjukfQfJVDWITLdY5r5vz/9w3jq7cStONrIwzFWI38TMcQyNfaz6S+9nwOeB3+runHf991G8gNtPcrqosAebTUxS5XiQSwH+FOdT8z0/bTVKTn1rzndRdxZKWcJ6x2pRLR4zKyK9vmPOwhNOJKJk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD00C4CECE;
	Fri,  1 Nov 2024 19:27:45 +0000 (UTC)
Date: Fri, 1 Nov 2024 15:28:44 -0400
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
Subject: Re: [PATCH v18 11/17] fprobe: Rewrite fprobe on function-graph
 tracer
Message-ID: <20241101152844.3a589594@gandalf.local.home>
In-Reply-To: <172991746318.443985.12713087979890519872.stgit@devnote2>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991746318.443985.12713087979890519872.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 13:37:43 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> index ef609bcca0f9..686b30ce48b4 100644
> --- a/include/linux/fprobe.h
> +++ b/include/linux/fprobe.h
> @@ -5,10 +5,11 @@
>  
>  #include <linux/compiler.h>
>  #include <linux/ftrace.h>
> -#include <linux/rethook.h>
> +#include <linux/rcupdate.h>
> +#include <linux/refcount.h>
> +#include <linux/slab.h>
>  
>  struct fprobe;
> -
>  typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
>  			       unsigned long ret_ip, struct ftrace_regs *regs,
>  			       void *entry_data);
> @@ -17,35 +18,57 @@ typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
>  			       unsigned long ret_ip, struct ftrace_regs *regs,
>  			       void *entry_data);
>  
> +/**
> + * strcut fprobe_hlist_node - address based hash list node for fprobe.

      struct

> + *
> + * @hlist: The hlist node for address search hash table.
> + * @addr: The address represented by this.

  What is "this" in the above?

> + * @fp: The fprobe which owns this.
> + */
> +struct fprobe_hlist_node {
> +	struct hlist_node	hlist;
> +	unsigned long		addr;
> +	struct fprobe		*fp;
> +};
> +
> +/**
> + * struct fprobe_hlist - hash list nodes for fprobe.
> + *
> + * @hlist: The hlist node for existence checking hash table.
> + * @rcu: rcu_head for RCU deferred release.
> + * @fp: The fprobe which owns this fprobe_hlist.
> + * @size: The size of @array.
> + * @array: The fprobe_hlist_node for each address to probe.
> + */
> +struct fprobe_hlist {
> +	struct hlist_node		hlist;
> +	struct rcu_head			rcu;
> +	struct fprobe			*fp;
> +	int				size;
> +	struct fprobe_hlist_node	array[];

Should the above have __counted_by(size) ?

-- Steve

> +};
> +
>  /**
>   * struct fprobe - ftrace based probe.
> - * @ops: The ftrace_ops.
> + *
>   * @nmissed: The counter for missing events.
>   * @flags: The status flag.
> - * @rethook: The rethook data structure. (internal data)
>   * @entry_data_size: The private data storage size.
> - * @nr_maxactive: The max number of active functions.
> + * @nr_maxactive: The max number of active functions. (*deprecated)
>   * @entry_handler: The callback function for function entry.
>   * @exit_handler: The callback function for function exit.
> + * @hlist_array: The fprobe_hlist for fprobe search from IP hash table.
>   */
>  struct fprobe {
> -#ifdef CONFIG_FUNCTION_TRACER
> -	/*
> -	 * If CONFIG_FUNCTION_TRACER is not set, CONFIG_FPROBE is disabled too.
> -	 * But user of fprobe may keep embedding the struct fprobe on their own
> -	 * code. To avoid build error, this will keep the fprobe data structure
> -	 * defined here, but remove ftrace_ops data structure.
> -	 */
> -	struct ftrace_ops	ops;
> -#endif
>  	unsigned long		nmissed;
>  	unsigned int		flags;
> -	struct rethook		*rethook;
>  	size_t			entry_data_size;
>  	int			nr_maxactive;
>  
>  	fprobe_entry_cb entry_handler;
>  	fprobe_exit_cb  exit_handler;
> +
> +	struct fprobe_hlist	*hlist_array;
>  };
>  


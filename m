Return-Path: <linux-arch+bounces-8936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8019C2DEB
	for <lists+linux-arch@lfdr.de>; Sat,  9 Nov 2024 15:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374BC282841
	for <lists+linux-arch@lfdr.de>; Sat,  9 Nov 2024 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBF5197A9A;
	Sat,  9 Nov 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkECfv34"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B9613DB99;
	Sat,  9 Nov 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731164157; cv=none; b=AKZgl958wG7PtIpum93dlDKGtWv+mFr3fDv3gcJnzA6M2wRLkISRHUk2EEW5he0etThqp/KnpmoV7oquEy3ynS3s+SweOhtnkRbWpWktukvQO/NEWtN+d7K5nzW7rn3lsFbEISufM6OZgPHWgVYDGaTYXFYuHwps4f2DnosoATY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731164157; c=relaxed/simple;
	bh=eUwvcN8zGzUKSnVGrOb7jRjjOHokBZqw7qBdYJmmLB8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f+1Qif4cSRSkgS5+0g0OAQ7RWpEpu1FWATWsdd9bo2ZeP37Yo1JeuOIqme6yWxBbcbPCuEhceGnFUwmP2o3aImstXRoI39y3G6nU7GxAQNomXOH4i5Wcw8hGHJV4HhCx30EDOmGqoJD2Ng5d+E3MwUrucg6J+UQ5olrgEQEcfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkECfv34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43C5C4CECE;
	Sat,  9 Nov 2024 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731164157;
	bh=eUwvcN8zGzUKSnVGrOb7jRjjOHokBZqw7qBdYJmmLB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NkECfv34cAC1JfcvfsKqsV/+G68HoaUfvbAWEE498nRm0Ly+YcByenX80hWlOWUe0
	 R4Go9gA6mUsjSjja3jN3WRxbquwdwatwz0qujGya2BUYBfhO9B6OtpQmNx/JvSi57S
	 ac3c6rrbpAtFzT3HQHWitWPp+4joGRsPnjlB1PThFmTEH2nbAm0Qx+ECY4xPWj76QM
	 30DU6z3lSkB6scmBTIKWDA9qaD9xylxhvUAVueo55N6YEJH6SnH84visYQiWGkpgI7
	 tzvEJDXkK077Wd/1ZfcEHpWSHlP4sSpJ1GOMEjEpj1LwSVI68638QTQLBpPsIuoWk8
	 Z9KcelmJDH97A==
Date: Sat, 9 Nov 2024 23:55:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20241109235547.238b54e4f13a4706532b39a4@kernel.org>
In-Reply-To: <20241101152844.3a589594@gandalf.local.home>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991746318.443985.12713087979890519872.stgit@devnote2>
	<20241101152844.3a589594@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 15:28:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 26 Oct 2024 13:37:43 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> > index ef609bcca0f9..686b30ce48b4 100644
> > --- a/include/linux/fprobe.h
> > +++ b/include/linux/fprobe.h
> > @@ -5,10 +5,11 @@
> >  
> >  #include <linux/compiler.h>
> >  #include <linux/ftrace.h>
> > -#include <linux/rethook.h>
> > +#include <linux/rcupdate.h>
> > +#include <linux/refcount.h>
> > +#include <linux/slab.h>
> >  
> >  struct fprobe;
> > -
> >  typedef int (*fprobe_entry_cb)(struct fprobe *fp, unsigned long entry_ip,
> >  			       unsigned long ret_ip, struct ftrace_regs *regs,
> >  			       void *entry_data);
> > @@ -17,35 +18,57 @@ typedef void (*fprobe_exit_cb)(struct fprobe *fp, unsigned long entry_ip,
> >  			       unsigned long ret_ip, struct ftrace_regs *regs,
> >  			       void *entry_data);
> >  
> > +/**
> > + * strcut fprobe_hlist_node - address based hash list node for fprobe.
> 
>       struct
> 

oops, thanks.

> > + *
> > + * @hlist: The hlist node for address search hash table.
> > + * @addr: The address represented by this.
> 
>   What is "this" in the above?

it should be `by this node.`

> 
> > + * @fp: The fprobe which owns this.
> > + */
> > +struct fprobe_hlist_node {
> > +	struct hlist_node	hlist;
> > +	unsigned long		addr;
> > +	struct fprobe		*fp;
> > +};
> > +
> > +/**
> > + * struct fprobe_hlist - hash list nodes for fprobe.
> > + *
> > + * @hlist: The hlist node for existence checking hash table.
> > + * @rcu: rcu_head for RCU deferred release.
> > + * @fp: The fprobe which owns this fprobe_hlist.
> > + * @size: The size of @array.
> > + * @array: The fprobe_hlist_node for each address to probe.
> > + */
> > +struct fprobe_hlist {
> > +	struct hlist_node		hlist;
> > +	struct rcu_head			rcu;
> > +	struct fprobe			*fp;
> > +	int				size;
> > +	struct fprobe_hlist_node	array[];
> 
> Should the above have __counted_by(size) ?

Yes. Thanks!


> 
> -- Steve
> 
> > +};
> > +
> >  /**
> >   * struct fprobe - ftrace based probe.
> > - * @ops: The ftrace_ops.
> > + *
> >   * @nmissed: The counter for missing events.
> >   * @flags: The status flag.
> > - * @rethook: The rethook data structure. (internal data)
> >   * @entry_data_size: The private data storage size.
> > - * @nr_maxactive: The max number of active functions.
> > + * @nr_maxactive: The max number of active functions. (*deprecated)
> >   * @entry_handler: The callback function for function entry.
> >   * @exit_handler: The callback function for function exit.
> > + * @hlist_array: The fprobe_hlist for fprobe search from IP hash table.
> >   */
> >  struct fprobe {
> > -#ifdef CONFIG_FUNCTION_TRACER
> > -	/*
> > -	 * If CONFIG_FUNCTION_TRACER is not set, CONFIG_FPROBE is disabled too.
> > -	 * But user of fprobe may keep embedding the struct fprobe on their own
> > -	 * code. To avoid build error, this will keep the fprobe data structure
> > -	 * defined here, but remove ftrace_ops data structure.
> > -	 */
> > -	struct ftrace_ops	ops;
> > -#endif
> >  	unsigned long		nmissed;
> >  	unsigned int		flags;
> > -	struct rethook		*rethook;
> >  	size_t			entry_data_size;
> >  	int			nr_maxactive;
> >  
> >  	fprobe_entry_cb entry_handler;
> >  	fprobe_exit_cb  exit_handler;
> > +
> > +	struct fprobe_hlist	*hlist_array;
> >  };
> >  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


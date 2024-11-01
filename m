Return-Path: <linux-arch+bounces-8758-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42C39B8FB2
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 11:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA92281010
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 10:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78A158558;
	Fri,  1 Nov 2024 10:49:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03D9839F4;
	Fri,  1 Nov 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458170; cv=none; b=tOdtguStt605VYlZn+hv0Gc+auL8mqUgyffGDqmE0jUo8CZIGc3maa9UONh5sVUXAcPAe0aErf3pzysF+x0rIN4R7pzb453xf/2k0Le5uLNFALgpfKARfvakLuThFIXLL+DC8H8m5ubUEGwpGwUcNpC8jxFCgq4aRyGRcftq74o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458170; c=relaxed/simple;
	bh=xJs8HTHdkHjCwS4Ii21qZMY4KqXpGLVAUr9L4bmLR6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmIYkRZcrv6VpqWmsGVgfl5mDjC4U4g9LxWpXebYuM+zbiI0S/Zrr0JXK65ae/5/UkX53lBR0XjwdDfWEFHPBVO8Q0k/Gm3iqYcIYkO/rOcCpp5JRhxxdLEbu9O7OWixTUpQOX4s0X4VimqHMHSWcXo/D0dIT44LQ9W6YSUeYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEE0C4CECD;
	Fri,  1 Nov 2024 10:49:26 +0000 (UTC)
Date: Fri, 1 Nov 2024 06:50:23 -0400
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
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v18 01/17] fgraph: Pass ftrace_regs to entryfunc
Message-ID: <20241101065023.72933d1b@gandalf.local.home>
In-Reply-To: <20241101105102.eb308ab85b2b13d03444d4bf@kernel.org>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991733069.443985.15154246733356205391.stgit@devnote2>
	<20241031155324.108ed8ef@gandalf.local.home>
	<20241101105102.eb308ab85b2b13d03444d4bf@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 10:51:02 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Ah, good catch! It should put the flag only when HAVE_DYNAMIC_FTRACE_WITH_ARGS
> is enabled.
> 
> static struct ftrace_ops graph_ops = {
> 	.func			= ftrace_graph_func,
> #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> 	.flags			= FTRACE_OPS_GRAPH_STUB | FTRACE_OPS_FL_SAVE_ARGS,
> #elif defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS)
> 	.flags			= FTRACE_OPS_GRAPH_STUB | FTRACE_OPS_FL_SAVE_REGS,
> #else
> 	.flags			= FTRACE_OPS_GRAPH_STUB,
> #endif
> 
> This will save fregs or regs or NULL according to the configuration.
> 

Please do not add that to the C code. It's really ugly. Just correct the
comment. Note, FTRACE_OPS_FL_SAVE_ARGS is already dynamic by configuration:

#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
#define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_REGS
#else
#define FTRACE_OPS_FL_SAVE_ARGS                        0
#endif

I'm a bit confused at what you are trying to achieve here.

-- Steve


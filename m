Return-Path: <linux-arch+bounces-8934-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE959C2DBD
	for <lists+linux-arch@lfdr.de>; Sat,  9 Nov 2024 15:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DC81C20C1C
	for <lists+linux-arch@lfdr.de>; Sat,  9 Nov 2024 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC3D1946A1;
	Sat,  9 Nov 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4sl1PyA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699231E4BE;
	Sat,  9 Nov 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731162298; cv=none; b=MkBA3T4Juv4KfbnhvZadE5MjTN1i6nXqlnJWUgOy/gHxwBJH/vU8ChhjacK+pOdHboSsAzD3UGMUY/BGDOMaVYaZGjQBH4Fh2ygr9HYvDz2aBjqeocfn3KCnCvq2fArFhHRm9UrxCMeqg4Gj6wQinVOpn5jKGwZWAKm4/8yteVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731162298; c=relaxed/simple;
	bh=v9l5l8b91vxON4bj2aWHj1KqPysotO/V5/B7MgXRpkg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iYXQ6WGNmYDceWLk7kLjkdaAQvIQudmvxnbNC9JauF3YfpN/JP3sBxcLX19+9xH8O6hA1F3/Rw36IzYENvmFZARqo5QV+dnxKWxQ8QKyHQSTgXmWQFs9177iHzZaaOFOYqhiNv95B/x4/GQOx4OP8wdalRA2rIK2mNYEJj3USWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4sl1PyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA46C4CECE;
	Sat,  9 Nov 2024 14:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731162297;
	bh=v9l5l8b91vxON4bj2aWHj1KqPysotO/V5/B7MgXRpkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D4sl1PyAPw5ZC6cLLsXQDv+MOSOamLLaxOVvt4VrYfx6IgcRlbMJhnffk1A1Pc20a
	 O8uza36K7i0TtCaepvX7gNMwLQq8912Mm+kYzzsSkR0CrGIU5oOz8hIoIoie3y2KZP
	 zCtsTjGeS45sgKjYfL4lvE2hKvmAa/UnCqpceyJEMJkGbk5fxDkX8qMO4MMs6pot0U
	 JEsjainnAeAmplxEbKIcCfECjocBbCPFEyD2fCw2Nxw1gOQSPpcq+cSW5Qbz15qkG5
	 9jM4rh29L96GccbknSIsJw9MFFa33KBPf0S7hKPhzkB6yMHWJTH2Dzsu0JRJ1nmIms
	 z48dPXNONT+/Q==
Date: Sat, 9 Nov 2024 23:24:48 +0900
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
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v18 01/17] fgraph: Pass ftrace_regs to entryfunc
Message-Id: <20241109232448.f1c3e174da2b1c4276530894@kernel.org>
In-Reply-To: <20241101065023.72933d1b@gandalf.local.home>
References: <172991731968.443985.4558065903004844780.stgit@devnote2>
	<172991733069.443985.15154246733356205391.stgit@devnote2>
	<20241031155324.108ed8ef@gandalf.local.home>
	<20241101105102.eb308ab85b2b13d03444d4bf@kernel.org>
	<20241101065023.72933d1b@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Nov 2024 06:50:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 1 Nov 2024 10:51:02 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > Ah, good catch! It should put the flag only when HAVE_DYNAMIC_FTRACE_WITH_ARGS
> > is enabled.
> > 
> > static struct ftrace_ops graph_ops = {
> > 	.func			= ftrace_graph_func,
> > #ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > 	.flags			= FTRACE_OPS_GRAPH_STUB | FTRACE_OPS_FL_SAVE_ARGS,
> > #elif defined(CONFIG_DYNAMIC_FTRACE_WITH_ARGS)
> > 	.flags			= FTRACE_OPS_GRAPH_STUB | FTRACE_OPS_FL_SAVE_REGS,
> > #else
> > 	.flags			= FTRACE_OPS_GRAPH_STUB,
> > #endif
> > 
> > This will save fregs or regs or NULL according to the configuration.
> > 
> 
> Please do not add that to the C code. It's really ugly. Just correct the
> comment. Note, FTRACE_OPS_FL_SAVE_ARGS is already dynamic by configuration:
> 
> #ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> #define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_REGS
> #else
> #define FTRACE_OPS_FL_SAVE_ARGS                        0
> #endif
> 
> I'm a bit confused at what you are trying to achieve here.

So it may need FTRACE_OPS_FL_SAVE_REGS instead of FTRACE_OPS_FL_SAVE_ARGS,
right?
OK, I'll do that.

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


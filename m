Return-Path: <linux-arch+bounces-9315-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7596C9E8B90
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 07:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DA4161014
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 06:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B331C2DA2;
	Mon,  9 Dec 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brtgIYGR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059D1E4A4;
	Mon,  9 Dec 2024 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726217; cv=none; b=dhOUlLQa1YqwV+ou8BV2VwW5aFngta6PJuGl8bIDnmUYfcwIBb8/2tWoW/gjRFcpeyur7AK3vvYaG13NWaH1ebaEqLs5XZGlcVirTrnOfjiumumQIdbyS2gYREyWYKb8IaEi0mYQBgAkSkurJHPSW1Jh2DlzoISBERpgfhVl7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726217; c=relaxed/simple;
	bh=SYyIX6eA60eKqyZW7rdqkdSCaHJa4XapYTOvdomFIfs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=I+Bi7IgymWezmos3myyWF8nk+YbOO5qhXh6suDqilyuptMUOgXhpLg6QjsCy+MIOl0aWat+dQawjWfyC5SDAfOsDJndm9c+pzOBGe5954IY1Xjjjgyo8fRXZ8oVQTGRlJhC52tHbVz9RNjz0gT/ElIVTXbP1OOVgflsNqe3Zvik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brtgIYGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197ABC4CED1;
	Mon,  9 Dec 2024 06:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733726216;
	bh=SYyIX6eA60eKqyZW7rdqkdSCaHJa4XapYTOvdomFIfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=brtgIYGRJlhbiTK4WXsZwVjCivRBUknX+E7lOIhWPu4ITfqEDnuGiANKJ0stgvAgR
	 e39J5KempFvX7NlCtDJ4BqFwUNQ/CYr0u9wvQmsHnYjMio6nKLVvJ+PU5ZSpCdX35E
	 nLtmOfoBFZp3DtApZaJCpuddjyVusf9Xy88LSQ48IUTfWPSc/BzrO3V9Cqi77Jjq7T
	 QMtpITcKE9+cwnKd6SI4Klipc07yyP1ooGJZ6LqaWMqMJrkgskU2Mnf6DzVU4hmHwh
	 AEWr1cXLVUuPmceXqRJJV0AraCBGsRZpOeL34D+qxX7pfldH9Nzzp+cMhaAvod5KXm
	 mJiFo+Q0WfujQ==
Date: Mon, 9 Dec 2024 15:36:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v20 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20241209153651.c622af218b5d4b2c2da76158@kernel.org>
In-Reply-To: <20241207094710.21cdaceb@rorschach.local.home>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
	<20241206172003.21af8b50ceed0b5e93a7771c@kernel.org>
	<20241207155136.dd69fbace1ae248c38b27d4b@kernel.org>
	<20241207094710.21cdaceb@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Dec 2024 09:47:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 7 Dec 2024 15:51:36 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > This checks the handler is called with preempt off.
> > 
> > On x86_64, the ftrace_graph_func calls function_graph_enter_regs() with
> > ftrace_test_recursion_trylock() as below;
> > 
> > void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> > 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> > {
> > 	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
> > 	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
> > 	unsigned long return_hooker = (unsigned long)&return_to_handler;
> > 	unsigned long *parent = (unsigned long *)stack;
> > 	int bit;
> > 
> > 	if (unlikely(skip_ftrace_return()))
> > 		return;
> > 
> > 	bit = ftrace_test_recursion_trylock(ip, *parent);
> > 	if (bit < 0)
> > 		return;
> > 
> > 	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
> > 		*parent = return_hooker;
> > 
> > 	ftrace_test_recursion_unlock(bit);
> > }
> > 
> > However, arm64 version does not;
> 
> Hmm, I think we can move that recursion check out of the arch/x86 code
> and into ftrace_graph_enter_regs().

OK, that's reasonable.

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


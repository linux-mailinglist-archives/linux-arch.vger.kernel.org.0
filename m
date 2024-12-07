Return-Path: <linux-arch+bounces-9300-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E829E8050
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 15:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34662820C7
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335BC146596;
	Sat,  7 Dec 2024 14:47:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096ED2CA6;
	Sat,  7 Dec 2024 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733582834; cv=none; b=YlvEOEL/LYa5L0s3O2A8TYzdbtwsIQ07DquBYNfcO+VfzVtvDS0Ry9x65R0ArVDP495fUrwsq4ultjofuc/Ndw+JBlknhddDL5fq+ssS9kFQ0UkzEHC0bgyc2mCOf7W9f36b/S437TbpNk0jBFiqSXJV8kw6VX7+siuRTHPG5PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733582834; c=relaxed/simple;
	bh=3wd4+gXuTLZE8SpMlj3+qphVLMObdDz6MedcOny20Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r32Sc+856P8RT9v/EWEKH9nBcpsCluTGhZ/LVD6b7vtD1vG6TyeJuny7yRGgbGGEqfET9qjQw6ib0iSP/vcFMBOOr3Cb/+QSgDYDnnEil68hPL73+dJsoYlzQukbEg1VpoYm5GRI4cIVEggUhAeLE5HEMBirDVTxOsQ73CMXFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36A3C4CECD;
	Sat,  7 Dec 2024 14:47:11 +0000 (UTC)
Date: Sat, 7 Dec 2024 09:47:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v20 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-ID: <20241207094710.21cdaceb@rorschach.local.home>
In-Reply-To: <20241207155136.dd69fbace1ae248c38b27d4b@kernel.org>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
	<20241206172003.21af8b50ceed0b5e93a7771c@kernel.org>
	<20241207155136.dd69fbace1ae248c38b27d4b@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Dec 2024 15:51:36 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> This checks the handler is called with preempt off.
> 
> On x86_64, the ftrace_graph_func calls function_graph_enter_regs() with
> ftrace_test_recursion_trylock() as below;
> 
> void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
> 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
> {
> 	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
> 	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
> 	unsigned long return_hooker = (unsigned long)&return_to_handler;
> 	unsigned long *parent = (unsigned long *)stack;
> 	int bit;
> 
> 	if (unlikely(skip_ftrace_return()))
> 		return;
> 
> 	bit = ftrace_test_recursion_trylock(ip, *parent);
> 	if (bit < 0)
> 		return;
> 
> 	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
> 		*parent = return_hooker;
> 
> 	ftrace_test_recursion_unlock(bit);
> }
> 
> However, arm64 version does not;

Hmm, I think we can move that recursion check out of the arch/x86 code
and into ftrace_graph_enter_regs().

-- Steve


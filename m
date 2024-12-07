Return-Path: <linux-arch+bounces-9295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D739E7E96
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 07:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D1D166200
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 06:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D77680BFF;
	Sat,  7 Dec 2024 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRx5tH8Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E4137742;
	Sat,  7 Dec 2024 06:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733554302; cv=none; b=ElYovQsLpwAZeoKKW/dNMN2pz9vj5Co0axUMMlTVL+MyFt6srDpmkPjpCE0vlE8xJrh7OyzhO5+fZEchE59I9LCKP6n1V4STHRGRCz4WPRZP+Hrve+L/647vbzI8+n0btW50f5OYpWOzo2SXexOkeI1P1904MIr89C7b8EyyOfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733554302; c=relaxed/simple;
	bh=uVcyYlEo+aVEflvwSPE8gGd/NeFheVCCOd+rbfBKnk0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f2RprX/uCJ7BnQFw5UOSrfMt1wo+o+dnAyiL7FAErtKImdNRW9y3MInRIKKzhrhtnrQZdHQH07XZy4nWRJ3o3qMsCEybh1CM5uKqRT2DTA+8T9tfeAWyuLP2N9n77Rl3iOcI4plTy1C7kIQF+Inih7EQticFxfq8k4IHLruxxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRx5tH8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8395BC4CECD;
	Sat,  7 Dec 2024 06:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733554301;
	bh=uVcyYlEo+aVEflvwSPE8gGd/NeFheVCCOd+rbfBKnk0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DRx5tH8Y9zM32SDXlEYViKnr8vRulr8P8Fgeu+8gY9BBn9I+9ZrXtiRRsSjK29kAj
	 gNajk3L/qRjQ3mDQIIxsPMOo+4N8TkYfqdp+ivwpzrMXFd4hI9CyBoTWolVbqYW+WW
	 7wBSYRApFNNhKoKD+ANhluaqphviC42/l8ljGY8ntAHgTFYQ9sewpb2iaZB7Rx6gpb
	 S+ujoucY48Ao0Nblma7yVjLHSwp8CAWudA5jpsbAcC1A/4S4iq9o4/V7sKtXRvDnIL
	 7e6FsnDksDw7fVRrqonD1b4X6mpZlTW8hude/5BVCnaUKrZtbSEdLksg0OdmX86QyU
	 dQjlcvlg6WI5w==
Date: Sat, 7 Dec 2024 15:51:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v20 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20241207155136.dd69fbace1ae248c38b27d4b@kernel.org>
In-Reply-To: <20241206172003.21af8b50ceed0b5e93a7771c@kernel.org>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
	<20241206172003.21af8b50ceed0b5e93a7771c@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 17:20:03 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi,
> 
> Sorry, I found a problem on arm64 on qemu. Let me recheck it.
> 
> [  592.422044]     # test_fprobe_entry: EXPECTATION FAILED at lib/test_fprobe.c:38
> [  592.422044]     Expected (preempt_count() == 0 && !({ unsigned long _flags; do { ({ unsigned long __dummy; typeof(_flags) __dummy2; (void)(&__dummy == &__dummy2); 1; }); _flags = arch_local_save_flags(); } while (0); ({ ({ unsigned long __dummy; typeof(_flags) __dummy2; (void)(&__dummy == &__dummy2); 1; }); arch_irqs_disabled_flags(_flags); }); })) to be false, but is true

This checks the handler is called with preempt off.

On x86_64, the ftrace_graph_func calls function_graph_enter_regs() with
ftrace_test_recursion_trylock() as below;

void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
		       struct ftrace_ops *op, struct ftrace_regs *fregs)
{
	struct pt_regs *regs = &arch_ftrace_regs(fregs)->regs;
	unsigned long *stack = (unsigned long *)kernel_stack_pointer(regs);
	unsigned long return_hooker = (unsigned long)&return_to_handler;
	unsigned long *parent = (unsigned long *)stack;
	int bit;

	if (unlikely(skip_ftrace_return()))
		return;

	bit = ftrace_test_recursion_trylock(ip, *parent);
	if (bit < 0)
		return;

	if (!function_graph_enter_regs(*parent, ip, 0, parent, fregs))
		*parent = return_hooker;

	ftrace_test_recursion_unlock(bit);
}

However, arm64 version does not;

void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
		       struct ftrace_ops *op, struct ftrace_regs *fregs)
{
	unsigned long return_hooker = (unsigned long)&return_to_handler;
	unsigned long frame_pointer = arch_ftrace_regs(fregs)->fp;
	unsigned long *parent = &arch_ftrace_regs(fregs)->lr;
	unsigned long old;

	if (unlikely(atomic_read(&current->tracing_graph_pause)))
		return;

	old = *parent;

	if (!function_graph_enter_regs(old, ip, frame_pointer,
				       (void *)frame_pointer, fregs)) {
		*parent = return_hooker;
	}
}

Is it a bug or intended?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


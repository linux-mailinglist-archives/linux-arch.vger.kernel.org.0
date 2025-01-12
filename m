Return-Path: <linux-arch+bounces-9712-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7696CA0A739
	for <lists+linux-arch@lfdr.de>; Sun, 12 Jan 2025 05:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188FE7A2C37
	for <lists+linux-arch@lfdr.de>; Sun, 12 Jan 2025 04:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13634086A;
	Sun, 12 Jan 2025 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdjCNzd6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730AF224F0;
	Sun, 12 Jan 2025 04:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736657117; cv=none; b=MR0tyRxtQUVTAsDSq+bncIFgkltnKxZtcKXkHJQ7pdvREkc2rt+bk5UxRU5qLI5tHnmKTsf6l46z+2qnTo4yZtpYgLyIxRE62Ls1Mkjn5jvD0RUfc51A0+eaO6pjn6sZ9Po++rJlB8TgXKnKYjtK8Sd0fyhTwjaDYchSWzyIEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736657117; c=relaxed/simple;
	bh=3mt1fMhxTQcZStMQGE5kw/EWPgjpITjPcDdR+fzPTNo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GZc2mwcxWrazL9ZaPKUqLzOCqAnTASN8EqUGkHzwfhxHMTghvoyl9ChwtHvIM60YgvrbwvrHnRWM8kilAvMwsJpRmjwCsPOhGcNogXgsQHMnKvcX36dc2vY0XoI+4hBWKBqxj3gJABP6gFw5A4Wnk8PR+BbsGH3f3RbTx/a1SMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdjCNzd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B97C4CEE0;
	Sun, 12 Jan 2025 04:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736657115;
	bh=3mt1fMhxTQcZStMQGE5kw/EWPgjpITjPcDdR+fzPTNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XdjCNzd6Kh/zKuGUEYk6mkPB9d/rKZZA3enQlltYrner52nzahhC98IhwrjkIP0p5
	 ZlCx8IjAO60lHQ0mnkhg3RmOvfQIqm6ki9wgBRN0gt+aHZra32KeP41ji5NOLN2iZI
	 GI4afrX53BLGeFYzx5JDZuDMwQcyciejXy53FymTyRKW1Z3FUQQrmVuHy9hyFCNtdC
	 nBNZcik+cVzfKqFvR0pSIRxmkY/RAFbJ1VlUAK7JOGxRvDweetlPWSWTSSAf5qKMxV
	 99Ba4V0rH0x5Z4P9mpscx3kicoYFxYbEv3VSxtxcBP4D475Q5eiI7g7VQ57iXCVlqx
	 oe79VX5kmqbnQ==
Date: Sun, 12 Jan 2025 13:45:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v22 00/20] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20250112134510.eb9be6b8d9ec70693e4a9aa5@kernel.org>
In-Reply-To: <Z3aSuql3fnXMVMoM@krava>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
	<Z3aSuql3fnXMVMoM@krava>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 2 Jan 2025 14:20:58 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Thu, Dec 26, 2024 at 02:11:16PM +0900, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > Here is the 22nd version of the series to re-implement the fprobe on
> > function-graph tracer. The previous version is;
> > 
> > https://lore.kernel.org/all/173379652547.973433.2311391879173461183.stgit@devnote2/
> > 
> > This version is rebased on v6.13-rc4 with fixes on [3/20] for x86-32 and
> > [5/20] for build error.
> 
> 
> hi,
> I ran the bench and I'm seeing native_sched_clock being used
> again kretprobe_multi bench:
> 
>      5.85%  bench            [kernel.kallsyms]                                        [k] native_sched_clock
>             |
>             ---native_sched_clock
>                sched_clock
>                |
>                 --5.83%--trace_clock_local
>                           ftrace_return_to_handler
>                           return_to_handler
>                           syscall
>                           bpf_prog_test_run_opts
>                           trigger_producer_batch
>                           start_thread
>                           __GI___clone3
> 
> I recall we tried to fix that before with [1] change, but that replaced
> later with [2] changes
> 
> When I remove the trace_clock_local call in __ftrace_return_to_handler
> than the kretprobe-multi gets much faster (see last block below), so it
> seems worth to make it optional
> 
> there's some decrease in kprobe_multi benchmark compared to base numbers,
> which I'm not sure yet why, but other than that it seems ok
> 
> base:
>         kprobe         :   12.873 ± 0.011M/s
>         kprobe-multi   :   13.088 ± 0.052M/s
>         kretprobe      :    6.339 ± 0.003M/s
>         kretprobe-multi:    7.240 ± 0.002M/s
> 
> fprobe_on_fgraph:
>         kprobe         :   12.816 ± 0.002M/s
>         kprobe-multi   :   12.126 ± 0.004M/s
>         kretprobe      :    6.305 ± 0.018M/s
>         kretprobe-multi:    7.740 ± 0.003M/s
> 
> removed native_sched_clock call:
>         kprobe         :   12.850 ± 0.006M/s
>         kprobe-multi   :   12.115 ± 0.006M/s
>         kretprobe      :    6.270 ± 0.017M/s
>         kretprobe-multi:    9.190 ± 0.005M/s

Hmm, this still look good. Ok, let me move the trace_clock_local() to
the function_graph.

Thanks!

> 
> 
> happy new year ;-) thanks,
> 
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/172615389864.133222.14452329708227900626.stgit@devnote2/
> [2] https://lore.kernel.org/all/20240914214805.779822616@goodmis.org/
> 
> > 
> > Overview
> > --------
> > This series rewrites the fprobe on this function-graph.
> > The purposes of this change are;
> > 
> >  1) Remove dependency of the rethook from fprobe so that we can reduce
> >    the return hook code and shadow stack.
> > 
> >  2) Make 'ftrace_regs' the common trace interface for the function
> >    boundary.
> > 
> > 1) Currently we have 2(or 3) different function return hook codes,
> >  the function-graph tracer and rethook (and legacy kretprobe).
> >  But since this  is redundant and needs double maintenance cost,
> >  I would like to unify those. From the user's viewpoint, function-
> >  graph tracer is very useful to grasp the execution path. For this
> >  purpose, it is hard to use the rethook in the function-graph
> >  tracer, but the opposite is possible. (Strictly speaking, kretprobe
> >  can not use it because it requires 'pt_regs' for historical reasons.)
> > 
> > 2) Now the fprobe provides the 'pt_regs' for its handler, but that is
> >  wrong for the function entry and exit. Moreover, depending on the
> >  architecture, there is no way to accurately reproduce 'pt_regs'
> >  outside of interrupt or exception handlers. This means fprobe should
> >  not use 'pt_regs' because it does not use such exceptions.
> >  (Conversely, kprobe should use 'pt_regs' because it is an abstract
> >   interface of the software breakpoint exception.)
> > 
> > This series changes fprobe to use function-graph tracer for tracing
> > function entry and exit, instead of mixture of ftrace and rethook.
> > Unlike the rethook which is a per-task list of system-wide allocated
> > nodes, the function graph's ret_stack is a per-task shadow stack.
> > Thus it does not need to set 'nr_maxactive' (which is the number of
> > pre-allocated nodes).
> > Also the handlers will get the 'ftrace_regs' instead of 'pt_regs'.
> > Since eBPF mulit_kprobe/multi_kretprobe events still use 'pt_regs' as
> > their register interface, this changes it to convert 'ftrace_regs' to
> > 'pt_regs'. Of course this conversion makes an incomplete 'pt_regs',
> > so users must access only registers for function parameters or
> > return value. 
> > 
> > Design
> > ------
> > Instead of using ftrace's function entry hook directly, the new fprobe
> > is built on top of the function-graph's entry and return callbacks
> > with 'ftrace_regs'.
> > 
> > Since the fprobe requires access to 'ftrace_regs', the architecture
> > must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS and
> > CONFIG_HAVE_FTRACE_GRAPH_FUNC, which enables to call function-graph
> > entry callback with 'ftrace_regs', and also
> > CONFIG_HAVE_FUNCTION_GRAPH_FREGS, which passes the ftrace_regs to
> > return_to_handler.
> > 
> > All fprobes share a single function-graph ops (means shares a common
> > ftrace filter) similar to the kprobe-on-ftrace. This needs another
> > layer to find corresponding fprobe in the common function-graph
> > callbacks, but has much better scalability, since the number of
> > registered function-graph ops is limited.
> > 
> > In the entry callback, the fprobe runs its entry_handler and saves the
> > address of 'fprobe' on the function-graph's shadow stack as data. The
> > return callback decodes the data to get the 'fprobe' address, and runs
> > the exit_handler.
> > 
> > The fprobe introduces two hash-tables, one is for entry callback which
> > searches fprobes related to the given function address passed by entry
> > callback. The other is for a return callback which checks if the given
> > 'fprobe' data structure pointer is still valid. Note that it is
> > possible to unregister fprobe before the return callback runs. Thus
> > the address validation must be done before using it in the return
> > callback.
> > 
> > Download
> > --------
> > This series can be applied against the v6.13-rc2 kernel.
> > 
> > This series can also be found below branch.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (Google) (19):
> >       fgraph: Get ftrace recursion lock in function_graph_enter
> >       fgraph: Pass ftrace_regs to entryfunc
> >       fgraph: Replace fgraph_ret_regs with ftrace_regs
> >       fgraph: Pass ftrace_regs to retfunc
> >       fprobe: Use ftrace_regs in fprobe entry handler
> >       fprobe: Use ftrace_regs in fprobe exit handler
> >       tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
> >       tracing: Add ftrace_fill_perf_regs() for perf event
> >       tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> >       bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
> >       ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
> >       fprobe: Rewrite fprobe on function-graph tracer
> >       fprobe: Add fprobe_header encoding feature
> >       tracing/fprobe: Remove nr_maxactive from fprobe
> >       selftests: ftrace: Remove obsolate maxactive syntax check
> >       selftests/ftrace: Add a test case for repeating register/unregister fprobe
> >       Documentation: probes: Update fprobe on function-graph tracer
> >       ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr
> >       bpf: Use ftrace_get_symaddr() for kprobe_multi probes
> > 
> > Sven Schnelle (1):
> >       s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
> > 
> > 
> >  Documentation/trace/fprobe.rst                     |   42 +
> >  arch/arm64/Kconfig                                 |    2 
> >  arch/arm64/include/asm/Kbuild                      |    1 
> >  arch/arm64/include/asm/ftrace.h                    |   51 +-
> >  arch/arm64/kernel/asm-offsets.c                    |   12 
> >  arch/arm64/kernel/entry-ftrace.S                   |   32 +
> >  arch/arm64/kernel/ftrace.c                         |   78 ++
> >  arch/loongarch/Kconfig                             |    4 
> >  arch/loongarch/include/asm/fprobe.h                |   12 
> >  arch/loongarch/include/asm/ftrace.h                |   32 -
> >  arch/loongarch/kernel/asm-offsets.c                |   12 
> >  arch/loongarch/kernel/ftrace_dyn.c                 |   10 
> >  arch/loongarch/kernel/mcount.S                     |   17 -
> >  arch/loongarch/kernel/mcount_dyn.S                 |   14 
> >  arch/powerpc/Kconfig                               |    1 
> >  arch/powerpc/include/asm/ftrace.h                  |   13 
> >  arch/powerpc/kernel/trace/ftrace.c                 |    8 
> >  arch/powerpc/kernel/trace/ftrace_64_pg.c           |   16 
> >  arch/riscv/Kconfig                                 |    3 
> >  arch/riscv/include/asm/Kbuild                      |    1 
> >  arch/riscv/include/asm/ftrace.h                    |   45 +
> >  arch/riscv/kernel/ftrace.c                         |   17 -
> >  arch/riscv/kernel/mcount.S                         |   24 -
> >  arch/s390/Kconfig                                  |    4 
> >  arch/s390/include/asm/fprobe.h                     |   10 
> >  arch/s390/include/asm/ftrace.h                     |   37 +
> >  arch/s390/kernel/asm-offsets.c                     |    6 
> >  arch/s390/kernel/entry.h                           |    1 
> >  arch/s390/kernel/ftrace.c                          |   48 -
> >  arch/s390/kernel/mcount.S                          |   23 -
> >  arch/x86/Kconfig                                   |    4 
> >  arch/x86/include/asm/Kbuild                        |    1 
> >  arch/x86/include/asm/ftrace.h                      |   54 +-
> >  arch/x86/kernel/ftrace.c                           |   47 +
> >  arch/x86/kernel/ftrace_32.S                        |   13 
> >  arch/x86/kernel/ftrace_64.S                        |   17 -
> >  include/asm-generic/fprobe.h                       |   46 +
> >  include/linux/fprobe.h                             |   62 +-
> >  include/linux/ftrace.h                             |  116 +++
> >  include/linux/ftrace_regs.h                        |    2 
> >  kernel/trace/Kconfig                               |   22 -
> >  kernel/trace/bpf_trace.c                           |   28 +
> >  kernel/trace/fgraph.c                              |   65 +-
> >  kernel/trace/fprobe.c                              |  664 +++++++++++++++-----
> >  kernel/trace/ftrace.c                              |    6 
> >  kernel/trace/trace.h                               |    6 
> >  kernel/trace/trace_fprobe.c                        |  146 ++--
> >  kernel/trace/trace_functions_graph.c               |   10 
> >  kernel/trace/trace_irqsoff.c                       |    6 
> >  kernel/trace/trace_probe_tmpl.h                    |    2 
> >  kernel/trace/trace_sched_wakeup.c                  |    6 
> >  kernel/trace/trace_selftest.c                      |   11 
> >  lib/test_fprobe.c                                  |   51 --
> >  samples/fprobe/fprobe_example.c                    |    4 
> >  .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19 +
> >  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
> >  56 files changed, 1318 insertions(+), 670 deletions(-)
> >  create mode 100644 arch/loongarch/include/asm/fprobe.h
> >  create mode 100644 arch/s390/include/asm/fprobe.h
> >  create mode 100644 include/asm-generic/fprobe.h
> >  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc
> > 
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


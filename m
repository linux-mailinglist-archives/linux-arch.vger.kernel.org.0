Return-Path: <linux-arch+bounces-8939-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 691339C3357
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 16:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8599B1C208ED
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A663E49D;
	Sun, 10 Nov 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZiC0Hsu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B78E45C1C;
	Sun, 10 Nov 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253727; cv=none; b=DElqs/bFK97Z7cKK77qHOGKhV2Gqgqy38PzSYEHC4CfckzV1OY1n+RlUQYtl3itiwQyPvfla7j3uf5oG6tftvdzn1xWs2Jn4vQgFSLY5JRwAGp4/xcl6a7CfuDILDt3toIXn6w9FbmKrepyRxPNnhQVlPfZYY8H6rQ4NsS4J5RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253727; c=relaxed/simple;
	bh=WAqFyU58s84VUKNJf9vMXPUf2dYQeDXhjucavy0h+Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fyb+ICa7RU0r4rED2Itlt2QfR/uwnlWMkOK5Ruv6oLY5TcHdNSj65bqJakW8sxyxj6Oo+/me3N7Oll8zFTEythey64ojqiOtBTMK1rWqHfwYQXOMByjMCT+Pp6exA7TUm99h/xbJOL99KVX4gUG4yZTJfJb35+/WC3YPIOkqLXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZiC0Hsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D4EC4CECD;
	Sun, 10 Nov 2024 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731253726;
	bh=WAqFyU58s84VUKNJf9vMXPUf2dYQeDXhjucavy0h+Ck=;
	h=From:To:Cc:Subject:Date:From;
	b=gZiC0Hsu7oZMEKrXtsuYKXKA4Ys/NKbv1nvC53lXmdQvLl8VGkebdirM1OSP0gsVX
	 wlmJyYR71J4lsYqdv64IOiGA47quD7B/wT2xQ93gFibP0uzd+8bhQ7mFcmUMf0OzK3
	 vp4MMW6xzn//Q7slI7uJIi59d8pLCCKzh9pJquvkf8K8aiDxdVK72cNrDQH6V0E7pg
	 7zHivV2wZZvesXQw519vEJ3sPQ/NpTBtdQEXL5xJqoBz2Jr97Z/wuggXImo+SafaqV
	 bsLLaY+fJx8JD29XUvsc23MCuxb8nQu+1HdEY6N1jBZqvJ5JmONfivUUCrd65QovkO
	 TDPtpLukxgFSQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arch@vger.kernel.org
Subject: [PATCH v19 00/19] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Mon, 11 Nov 2024 00:48:42 +0900
Message-ID: <173125372214.172790.6929368952404083802.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 19th version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/172991731968.443985.4558065903004844780.stgit@devnote2/

This version fixes to remove unneeded FTRACE_OPS_FL_SAVE_ARGS[1/19],
add HAVE_FTRACE_GRAPH_FUNC support for s390(from Sven)[], fix some
comments and add __counted_by()[12/19], use Kbuild for asm-generic
headers [13/19], add ftrace_get_symaddr() [18/19] and use the
ftrace_get_symaddr() in bpf[19/19].

Overview
--------
This series rewrites the fprobe on this function-graph.
The purposes of this change are;

 1) Remove dependency of the rethook from fprobe so that we can reduce
   the return hook code and shadow stack.

 2) Make 'ftrace_regs' the common trace interface for the function
   boundary.

1) Currently we have 2(or 3) different function return hook codes,
 the function-graph tracer and rethook (and legacy kretprobe).
 But since this  is redundant and needs double maintenance cost,
 I would like to unify those. From the user's viewpoint, function-
 graph tracer is very useful to grasp the execution path. For this
 purpose, it is hard to use the rethook in the function-graph
 tracer, but the opposite is possible. (Strictly speaking, kretprobe
 can not use it because it requires 'pt_regs' for historical reasons.)

2) Now the fprobe provides the 'pt_regs' for its handler, but that is
 wrong for the function entry and exit. Moreover, depending on the
 architecture, there is no way to accurately reproduce 'pt_regs'
 outside of interrupt or exception handlers. This means fprobe should
 not use 'pt_regs' because it does not use such exceptions.
 (Conversely, kprobe should use 'pt_regs' because it is an abstract
  interface of the software breakpoint exception.)

This series changes fprobe to use function-graph tracer for tracing
function entry and exit, instead of mixture of ftrace and rethook.
Unlike the rethook which is a per-task list of system-wide allocated
nodes, the function graph's ret_stack is a per-task shadow stack.
Thus it does not need to set 'nr_maxactive' (which is the number of
pre-allocated nodes).
Also the handlers will get the 'ftrace_regs' instead of 'pt_regs'.
Since eBPF mulit_kprobe/multi_kretprobe events still use 'pt_regs' as
their register interface, this changes it to convert 'ftrace_regs' to
'pt_regs'. Of course this conversion makes an incomplete 'pt_regs',
so users must access only registers for function parameters or
return value. 

Design
------
Instead of using ftrace's function entry hook directly, the new fprobe
is built on top of the function-graph's entry and return callbacks
with 'ftrace_regs'.

Since the fprobe requires access to 'ftrace_regs', the architecture
must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS and
CONFIG_HAVE_FTRACE_GRAPH_FUNC, which enables to call function-graph
entry callback with 'ftrace_regs', and also
CONFIG_HAVE_FUNCTION_GRAPH_FREGS, which passes the ftrace_regs to
return_to_handler.

All fprobes share a single function-graph ops (means shares a common
ftrace filter) similar to the kprobe-on-ftrace. This needs another
layer to find corresponding fprobe in the common function-graph
callbacks, but has much better scalability, since the number of
registered function-graph ops is limited.

In the entry callback, the fprobe runs its entry_handler and saves the
address of 'fprobe' on the function-graph's shadow stack as data. The
return callback decodes the data to get the 'fprobe' address, and runs
the exit_handler.

The fprobe introduces two hash-tables, one is for entry callback which
searches fprobes related to the given function address passed by entry
callback. The other is for a return callback which checks if the given
'fprobe' data structure pointer is still valid. Note that it is
possible to unregister fprobe before the return callback runs. Thus
the address validation must be done before using it in the return
callback.

Download
--------
This series can be applied against the ftrace/for-next branch in
linux-trace tree.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Masami Hiramatsu (Google) (18):
      fgraph: Pass ftrace_regs to entryfunc
      fgraph: Replace fgraph_ret_regs with ftrace_regs
      fgraph: Pass ftrace_regs to retfunc
      fprobe: Use ftrace_regs in fprobe entry handler
      fprobe: Use ftrace_regs in fprobe exit handler
      tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      tracing: Add ftrace_fill_perf_regs() for perf event
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
      ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
      fprobe: Rewrite fprobe on function-graph tracer
      fprobe: Add fprobe_header encoding feature
      tracing/fprobe: Remove nr_maxactive from fprobe
      selftests: ftrace: Remove obsolate maxactive syntax check
      selftests/ftrace: Add a test case for repeating register/unregister fprobe
      Documentation: probes: Update fprobe on function-graph tracer
      ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr
      bpf: Use ftrace_get_symaddr() in get_entry_ip()

Sven Schnelle (1):
      s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC


 Documentation/trace/fprobe.rst                     |   42 +
 arch/arm64/Kconfig                                 |    2 
 arch/arm64/include/asm/Kbuild                      |    1 
 arch/arm64/include/asm/ftrace.h                    |   51 +-
 arch/arm64/kernel/asm-offsets.c                    |   12 
 arch/arm64/kernel/entry-ftrace.S                   |   32 +
 arch/arm64/kernel/ftrace.c                         |   78 ++
 arch/loongarch/Kconfig                             |    4 
 arch/loongarch/include/asm/fprobe.h                |   12 
 arch/loongarch/include/asm/ftrace.h                |   32 -
 arch/loongarch/kernel/asm-offsets.c                |   12 
 arch/loongarch/kernel/ftrace_dyn.c                 |   10 
 arch/loongarch/kernel/mcount.S                     |   17 -
 arch/loongarch/kernel/mcount_dyn.S                 |   14 
 arch/powerpc/Kconfig                               |    1 
 arch/powerpc/include/asm/ftrace.h                  |   13 
 arch/powerpc/kernel/trace/ftrace.c                 |    2 
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10 
 arch/riscv/Kconfig                                 |    3 
 arch/riscv/include/asm/Kbuild                      |    1 
 arch/riscv/include/asm/ftrace.h                    |   45 +
 arch/riscv/kernel/ftrace.c                         |   17 -
 arch/riscv/kernel/mcount.S                         |   24 -
 arch/s390/Kconfig                                  |    4 
 arch/s390/include/asm/fprobe.h                     |   10 
 arch/s390/include/asm/ftrace.h                     |   37 +
 arch/s390/kernel/asm-offsets.c                     |    6 
 arch/s390/kernel/entry.h                           |    1 
 arch/s390/kernel/ftrace.c                          |   48 -
 arch/s390/kernel/mcount.S                          |   23 -
 arch/x86/Kconfig                                   |    4 
 arch/x86/include/asm/Kbuild                        |    1 
 arch/x86/include/asm/ftrace.h                      |   54 +-
 arch/x86/kernel/ftrace.c                           |   50 +-
 arch/x86/kernel/ftrace_32.S                        |   13 
 arch/x86/kernel/ftrace_64.S                        |   17 -
 include/asm-generic/fprobe.h                       |   46 +
 include/linux/fprobe.h                             |   62 +-
 include/linux/ftrace.h                             |  116 +++
 include/linux/ftrace_regs.h                        |    2 
 kernel/trace/Kconfig                               |   24 +
 kernel/trace/bpf_trace.c                           |   38 -
 kernel/trace/fgraph.c                              |   57 +-
 kernel/trace/fprobe.c                              |  664 +++++++++++++++-----
 kernel/trace/ftrace.c                              |    6 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_fprobe.c                        |  146 ++--
 kernel/trace/trace_functions_graph.c               |   10 
 kernel/trace/trace_irqsoff.c                       |    6 
 kernel/trace/trace_probe_tmpl.h                    |    2 
 kernel/trace/trace_sched_wakeup.c                  |    6 
 kernel/trace/trace_selftest.c                      |   11 
 lib/test_fprobe.c                                  |   51 --
 samples/fprobe/fprobe_example.c                    |    4 
 .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 56 files changed, 1313 insertions(+), 670 deletions(-)
 create mode 100644 arch/loongarch/include/asm/fprobe.h
 create mode 100644 arch/s390/include/asm/fprobe.h
 create mode 100644 include/asm-generic/fprobe.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>


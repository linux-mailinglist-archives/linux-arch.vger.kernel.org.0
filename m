Return-Path: <linux-arch+bounces-7309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D13D9795DB
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573D01C20DDC
	for <lists+linux-arch@lfdr.de>; Sun, 15 Sep 2024 09:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED61C3305;
	Sun, 15 Sep 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMGT1Ck7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AAF2232A;
	Sun, 15 Sep 2024 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391377; cv=none; b=IfyxbujA5Bap8c+1rXn4ENU7q63gw9Gjl0yUU6Ckbjet6jL4yrHp/vYvcYXT6thIqZ2iZtc4pPZ15SctcIARZYXYY903m+9d8BVq3j2NY1FpWQDTQrtYndmAVqQfuFybUgmD0HX3SppbEBUkhnl11pVw7LMReUZ5ruotc+bhdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391377; c=relaxed/simple;
	bh=PfG93IMfGk/tJFUBVfpKGNKl+KLnekwfT46OFqQ47a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dRxnIRKLc0Brse5RejvnnJEpepusk8ybiFObn0Qo9yb+0lMpOhuEsRHhUEVSp0k6EopmePWHu567g9z8/07X7X6SzYPiQ9a2t96bZvncNp7yQqPRhqrI+aGc90C60UrNYOEaQAp5o6H05MG8+PykJ50siH0OcZ83RDfoW0nRnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMGT1Ck7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C47C4CEC3;
	Sun, 15 Sep 2024 09:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726391377;
	bh=PfG93IMfGk/tJFUBVfpKGNKl+KLnekwfT46OFqQ47a4=;
	h=From:To:Cc:Subject:Date:From;
	b=YMGT1Ck77inNk/C6Ps9aU23pSkZeeVPUfuhGObhKeKHSUx67/nneFBnHTzRVpFyIH
	 m32hwAG50t4hsgJ/Zzj6zUaLoRzFazE0y+wVIZTlC5EtUObqSLSPua5EORIsQwItvD
	 uHuhma2YfTvJwgCCwBjdTfEGYATMPO2P1YxGE7ZgxZPH7CqYQNkueEwqI27A4NyLXg
	 +v14+6B/gAV4a7xaAYI8p7sHFneDhH77HkqAwf5bLquXFQxHONVZwXAfucGf7JuC8u
	 Zw8prnVG+bG5/1udh6e0qZrn3UQDRoBohX0qA8QIwSsQg69TmkrjO+WB6n4vBRwBQc
	 uxmidhIsAkVTQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guo Ren <guoren@kernel.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH v15 00/19] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Sun, 15 Sep 2024 18:09:30 +0900
Message-Id: <172639136989.366111.11359590127009702129.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Here is the 15th version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/172615368656.133222.2336770908714920670.stgit@devnote2/

This version rebased on Steve's calltime change[1] instead of the last
patch in the previous series, and adds a bpf patch to add get_entry_ip()
for arm64. Note that [1] is not included in this series, so please use
the git branch[2].

[1] https://lore.kernel.org/all/20240914214805.779822616@goodmis.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

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

Masami Hiramatsu (Google) (19):
      tracing: Add a comment about ftrace_regs definition
      tracing: Rename ftrace_regs_return_value to ftrace_regs_get_return_value
      function_graph: Pass ftrace_regs to entryfunc
      function_graph: Replace fgraph_ret_regs with ftrace_regs
      function_graph: Pass ftrace_regs to retfunc
      fprobe: Use ftrace_regs in fprobe entry handler
      fprobe: Use ftrace_regs in fprobe exit handler
      tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
      tracing: Add ftrace_fill_perf_regs() for perf event
      tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
      bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
      ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
      fprobe: Rewrite fprobe on function-graph tracer
      tracing: Fix function timing profiler to initialize hashtable
      tracing/fprobe: Remove nr_maxactive from fprobe
      selftests: ftrace: Remove obsolate maxactive syntax check
      selftests/ftrace: Add a test case for repeating register/unregister fprobe
      Documentation: probes: Update fprobe on function-graph tracer
      bpf: Add get_entry_ip() for arm64


 Documentation/trace/fprobe.rst                     |   42 +
 arch/arm64/Kconfig                                 |    2 
 arch/arm64/include/asm/ftrace.h                    |   47 +
 arch/arm64/kernel/asm-offsets.c                    |   12 
 arch/arm64/kernel/entry-ftrace.S                   |   32 +
 arch/arm64/kernel/ftrace.c                         |   20 +
 arch/loongarch/Kconfig                             |    4 
 arch/loongarch/include/asm/ftrace.h                |   32 -
 arch/loongarch/kernel/asm-offsets.c                |   12 
 arch/loongarch/kernel/ftrace_dyn.c                 |   10 
 arch/loongarch/kernel/mcount.S                     |   17 -
 arch/loongarch/kernel/mcount_dyn.S                 |   14 
 arch/powerpc/Kconfig                               |    1 
 arch/powerpc/include/asm/ftrace.h                  |   15 
 arch/powerpc/kernel/trace/ftrace.c                 |    2 
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   10 
 arch/riscv/Kconfig                                 |    3 
 arch/riscv/include/asm/ftrace.h                    |   43 +
 arch/riscv/kernel/ftrace.c                         |   17 +
 arch/riscv/kernel/mcount.S                         |   24 -
 arch/s390/Kconfig                                  |    3 
 arch/s390/include/asm/ftrace.h                     |   39 +
 arch/s390/kernel/asm-offsets.c                     |    6 
 arch/s390/kernel/mcount.S                          |    9 
 arch/x86/Kconfig                                   |    4 
 arch/x86/include/asm/ftrace.h                      |   37 +
 arch/x86/kernel/ftrace.c                           |   50 +-
 arch/x86/kernel/ftrace_32.S                        |   15 
 arch/x86/kernel/ftrace_64.S                        |   17 -
 include/linux/fprobe.h                             |   57 +-
 include/linux/ftrace.h                             |  134 ++++
 kernel/trace/Kconfig                               |   23 +
 kernel/trace/bpf_trace.c                           |   83 ++-
 kernel/trace/fgraph.c                              |   60 +-
 kernel/trace/fprobe.c                              |  637 ++++++++++++++------
 kernel/trace/ftrace.c                              |   10 
 kernel/trace/trace.h                               |    6 
 kernel/trace/trace_fprobe.c                        |  147 ++---
 kernel/trace/trace_functions_graph.c               |   10 
 kernel/trace/trace_irqsoff.c                       |    6 
 kernel/trace/trace_probe_tmpl.h                    |    2 
 kernel/trace/trace_sched_wakeup.c                  |    6 
 kernel/trace/trace_selftest.c                      |   11 
 lib/test_fprobe.c                                  |   51 --
 samples/fprobe/fprobe_example.c                    |    4 
 .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19 +
 .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
 47 files changed, 1195 insertions(+), 614 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>


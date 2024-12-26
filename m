Return-Path: <linux-arch+bounces-9490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD96E9FC835
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 06:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2487D7A03D3
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 05:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091C0154BE0;
	Thu, 26 Dec 2024 05:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGzTm/vs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CD14A4E1;
	Thu, 26 Dec 2024 05:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735189882; cv=none; b=gDAuDMoo5cswKMMz5SczMYKhLrCYrNWWeYambNFgijbpgzyswm48IPli99w0xPz42hzwAwphiYWHU9nm+awd3FKsyFOP+JMeAPM/ThhdMyNQTU63fdAgagkTnP206ZJpN/53KXR6pXV6A92v9XS3Q3F3n+2blZTF7eHSxAhLUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735189882; c=relaxed/simple;
	bh=Y1N4hyf+/Nbu1dxNDzeQTpy8V65S4ayMn7uwhqsuwdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rTbZih2TCX732emKNDB9Pe7B4vwJKJZUCsG6zWm7/4CIflQmcWRf7TcM2Kok1H6Y2jDqIiaIkRoSok2l4MW5tO1E7byO6DNU6Om1SnxsXLeYWELdx29zm53GYQQvPgp7c/G8drRsionlvbTDP0yUG9h0VbwMxl5MvLLFSVO8nPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGzTm/vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8975CC4CED1;
	Thu, 26 Dec 2024 05:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735189882;
	bh=Y1N4hyf+/Nbu1dxNDzeQTpy8V65S4ayMn7uwhqsuwdk=;
	h=From:To:Cc:Subject:Date:From;
	b=tGzTm/vsxwOgMEAdxfNfbUoXQlWeBp2J2g+QLaX5NVBRA9TD7zfXIBOUqalFZcqlr
	 i9yL+Zra8rWh5kT+yGxoy2bP4PbHWll2Tti5KofH5XT8GSZegvQTIB/zq4NnnOZIqq
	 HlVWAR8zBI9jhx+ZAiqlfDUv2wJHEzqJzJodEmmBoB2PKcrYH1TC4+1Izqf5NNcmiX
	 wFfx4FdCSkIWuhq4LDQiHqpJLBk/Ab2x/EgKN6ZnKeuI1pEnO+JYPsWMQgyRKOvgLi
	 vy4fiHvLZ0vMYVswm4mdsRu/uTmi5FIco9aOnnl6lnmAZoJyIANqN0UEdEVqa0exx4
	 l6Go8yLu+fPeg==
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
Subject: [PATCH v22 00/20] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
Date: Thu, 26 Dec 2024 14:11:16 +0900
Message-ID: <173518987627.391279.3307342580035322889.stgit@devnote2>
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

Here is the 22nd version of the series to re-implement the fprobe on
function-graph tracer. The previous version is;

https://lore.kernel.org/all/173379652547.973433.2311391879173461183.stgit@devnote2/

This version is rebased on v6.13-rc4 with fixes on [3/20] for x86-32 and
[5/20] for build error.

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
This series can be applied against the v6.13-rc2 kernel.

This series can also be found below branch.

https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph

Thank you,

---

Masami Hiramatsu (Google) (19):
      fgraph: Get ftrace recursion lock in function_graph_enter
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
      bpf: Use ftrace_get_symaddr() for kprobe_multi probes

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
 arch/powerpc/kernel/trace/ftrace.c                 |    8 
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   16 
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
 arch/x86/kernel/ftrace.c                           |   47 +
 arch/x86/kernel/ftrace_32.S                        |   13 
 arch/x86/kernel/ftrace_64.S                        |   17 -
 include/asm-generic/fprobe.h                       |   46 +
 include/linux/fprobe.h                             |   62 +-
 include/linux/ftrace.h                             |  116 +++
 include/linux/ftrace_regs.h                        |    2 
 kernel/trace/Kconfig                               |   22 -
 kernel/trace/bpf_trace.c                           |   28 +
 kernel/trace/fgraph.c                              |   65 +-
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
 56 files changed, 1318 insertions(+), 670 deletions(-)
 create mode 100644 arch/loongarch/include/asm/fprobe.h
 create mode 100644 arch/s390/include/asm/fprobe.h
 create mode 100644 include/asm-generic/fprobe.h
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <linux-arch+bounces-9551-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B4E9FF9BB
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 14:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AEB3A1C32
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jan 2025 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189251AA1D5;
	Thu,  2 Jan 2025 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoDKQBBW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEACA1DFFC;
	Thu,  2 Jan 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735824065; cv=none; b=t5Kp23SY2Ry1oyEdp2GaJkiqirJrTyTVeXVUo+0AA0iTDbLj/ZanVfw9Q/opIALkv1GW7CCXRuRAUXkrgbUdT4hxldsaygI6hNBQFSNt4y1h+q7W2+TA559jUtaTyLn0tSqzssGgRv7r+WP0tedABxAQPFwVZ6g7EbkyA2p6oQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735824065; c=relaxed/simple;
	bh=IVgrMGWRaRGhIDH9SwJ4sZF0eOuYJugYU8eXv6Ma8dw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYMTjvtHL+WMMhTUvGyhe/NixX00nciizZjfHNdiJzACo6a31SvVHA9PKoL89I+AjTErbmslWmSGX0FjE2E/S0fXA8FF4UtocMDKmRywsmhVRT260AtycTCXbauOYVvMf7hrxXX70P8np1/pCZjhmbOxe8Ek50JW9BlIL+cScZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoDKQBBW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaeec07b705so1071665566b.2;
        Thu, 02 Jan 2025 05:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735824061; x=1736428861; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0liLAtiEYsIZqKIlu8a0gcT0XcyuhhnfRnOfIp3Z9yg=;
        b=eoDKQBBWZI9AHyxspfz73nkY5YcKRrRu+quM1/jAzek18hLWgnOPrAjgsT3spfspAz
         9oqBv9lKCOqXLGKBKhUcjp4q1mlFQIJBCdeQm/5lG3Yia6OJgN02ijASwJnI9/H96sJY
         c9DRzTQhT+zSSB7ozc6X74SCU23KJUiKAVOhcnRiezhR+U4q+RoWLwj1Aj0L1TlYYoZU
         702ZIAxrhpZtUDIJxLBEhvadUO6xR+e9qqeE955+K6ThI5KVimm5gae/01/CWEKO56sb
         //QswfBoPwGxWhCt5VyEMO7fritkjNvahy/PIwvxwQ6fEZeLM77fZtJYtPZYx67NX1Mk
         +ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735824061; x=1736428861;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0liLAtiEYsIZqKIlu8a0gcT0XcyuhhnfRnOfIp3Z9yg=;
        b=qckJ/CGr1D18QrYm7pWjLGusZQqlHycQIxrPrXWC+JzWp6JdmmgrNHjd8dPqzuAMj/
         UEVAj6+iY3B44NrcxZxzs1QiimwZxlvqJD6bP8lvBcW8xycs84uL2Z75glCujn3n4l9o
         y3yJyS9zV8iSnR0L57OjQboqLJt27vImyYugI+YN03uBUWBwzmUUCM8fcIiFqPMXg0JQ
         lsYcst+XIrJJrcRgFR4xv2YRy1koik0H+TaxHqSZoDl8ZffyA7fVBSt8PLNO/04VUZaG
         m2J+HXYEEXEXpLYQIz0FD4I3gM0N9hseGCn5Z/Z/xfoVKLRyuaKNaDD1PXzre+zg8LWd
         yg2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJpudCDORI9mOnCXKPT29ugxM5gBWEP0Qe9PtN3x5QaqTBPDRYtoh0Ffu3LKIj1L2A6SGjmsoHU2HfXrOY@vger.kernel.org, AJvYcCW/fLZC+F3IVhpnJGXuY3CwEHlT3g4riseg1Sm3OM6XxaDaOrpBg9Hn8YLv0MkJq6UmnrwJPFpNo22t+g==@vger.kernel.org, AJvYcCWVMf800iAeTyuzvx3ckaadqPcMRJ1MKtEVOxN4xNObPenEXh9B2sPLJGgjPLUF9hfRF0E=@vger.kernel.org, AJvYcCWroYuFChIKllxrpTB/3oHlPLRHetfpU1od9yq2ww8wqHoikv251TkMo5bci+2Lwv1wXvgCMfILu2cEwW65Ji4UR1nR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6KQ6hj5yats8TL8eKmln8g23v3f600HqS3ccpGFTJAIQ+YqRL
	7mPfcR73dNuD/rCOs5fvtrs3SYjq4EdsnIaLCZzf922TNff5u4VDwSUC5w==
X-Gm-Gg: ASbGnctqLNGB7BJMFQnWVW1T6Fgb7wCACh6C8sBpZNvQUoDGFPWHTOWNc/Gj5OMm2mr
	3xOn6C96LRBMsWL3cAlVOEfGkkJe98qYaPEtFmvEFR4tnIdy4Md7nn4yN2EwbbouTKD+EIodY+7
	hfVXUyc23z06p4GCWXbvcdaMgar7M4vK90gX7I6WSzBpnjcPYj5PHsNqjOY53eILR9OlLgK6ZFv
	hsvOQQb3QBARvc5dzE1fzSE/1e+nFApqY5+FZ0on+0=
X-Google-Smtp-Source: AGHT+IFpq1PNNJw2abbAI4O/nvF7Q2rzVVDP4Gf/hTdkQmdQ/lYZEgAi+HTyMhZWtIviN1+dn7f/sw==
X-Received: by 2002:a17:907:3e8f:b0:aab:d4f0:c598 with SMTP id a640c23a62f3a-aac2d0479bamr4251087466b.27.1735824060781;
        Thu, 02 Jan 2025 05:21:00 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae4338sm1763861666b.86.2025.01.02.05.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 05:21:00 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Jan 2025 14:20:58 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v22 00/20] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-ID: <Z3aSuql3fnXMVMoM@krava>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173518987627.391279.3307342580035322889.stgit@devnote2>

On Thu, Dec 26, 2024 at 02:11:16PM +0900, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here is the 22nd version of the series to re-implement the fprobe on
> function-graph tracer. The previous version is;
> 
> https://lore.kernel.org/all/173379652547.973433.2311391879173461183.stgit@devnote2/
> 
> This version is rebased on v6.13-rc4 with fixes on [3/20] for x86-32 and
> [5/20] for build error.


hi,
I ran the bench and I'm seeing native_sched_clock being used
again kretprobe_multi bench:

     5.85%  bench            [kernel.kallsyms]                                        [k] native_sched_clock
            |
            ---native_sched_clock
               sched_clock
               |
                --5.83%--trace_clock_local
                          ftrace_return_to_handler
                          return_to_handler
                          syscall
                          bpf_prog_test_run_opts
                          trigger_producer_batch
                          start_thread
                          __GI___clone3

I recall we tried to fix that before with [1] change, but that replaced
later with [2] changes

When I remove the trace_clock_local call in __ftrace_return_to_handler
than the kretprobe-multi gets much faster (see last block below), so it
seems worth to make it optional

there's some decrease in kprobe_multi benchmark compared to base numbers,
which I'm not sure yet why, but other than that it seems ok

base:
        kprobe         :   12.873 ± 0.011M/s
        kprobe-multi   :   13.088 ± 0.052M/s
        kretprobe      :    6.339 ± 0.003M/s
        kretprobe-multi:    7.240 ± 0.002M/s

fprobe_on_fgraph:
        kprobe         :   12.816 ± 0.002M/s
        kprobe-multi   :   12.126 ± 0.004M/s
        kretprobe      :    6.305 ± 0.018M/s
        kretprobe-multi:    7.740 ± 0.003M/s

removed native_sched_clock call:
        kprobe         :   12.850 ± 0.006M/s
        kprobe-multi   :   12.115 ± 0.006M/s
        kretprobe      :    6.270 ± 0.017M/s
        kretprobe-multi:    9.190 ± 0.005M/s


happy new year ;-) thanks,

jirka


[1] https://lore.kernel.org/bpf/172615389864.133222.14452329708227900626.stgit@devnote2/
[2] https://lore.kernel.org/all/20240914214805.779822616@goodmis.org/

> 
> Overview
> --------
> This series rewrites the fprobe on this function-graph.
> The purposes of this change are;
> 
>  1) Remove dependency of the rethook from fprobe so that we can reduce
>    the return hook code and shadow stack.
> 
>  2) Make 'ftrace_regs' the common trace interface for the function
>    boundary.
> 
> 1) Currently we have 2(or 3) different function return hook codes,
>  the function-graph tracer and rethook (and legacy kretprobe).
>  But since this  is redundant and needs double maintenance cost,
>  I would like to unify those. From the user's viewpoint, function-
>  graph tracer is very useful to grasp the execution path. For this
>  purpose, it is hard to use the rethook in the function-graph
>  tracer, but the opposite is possible. (Strictly speaking, kretprobe
>  can not use it because it requires 'pt_regs' for historical reasons.)
> 
> 2) Now the fprobe provides the 'pt_regs' for its handler, but that is
>  wrong for the function entry and exit. Moreover, depending on the
>  architecture, there is no way to accurately reproduce 'pt_regs'
>  outside of interrupt or exception handlers. This means fprobe should
>  not use 'pt_regs' because it does not use such exceptions.
>  (Conversely, kprobe should use 'pt_regs' because it is an abstract
>   interface of the software breakpoint exception.)
> 
> This series changes fprobe to use function-graph tracer for tracing
> function entry and exit, instead of mixture of ftrace and rethook.
> Unlike the rethook which is a per-task list of system-wide allocated
> nodes, the function graph's ret_stack is a per-task shadow stack.
> Thus it does not need to set 'nr_maxactive' (which is the number of
> pre-allocated nodes).
> Also the handlers will get the 'ftrace_regs' instead of 'pt_regs'.
> Since eBPF mulit_kprobe/multi_kretprobe events still use 'pt_regs' as
> their register interface, this changes it to convert 'ftrace_regs' to
> 'pt_regs'. Of course this conversion makes an incomplete 'pt_regs',
> so users must access only registers for function parameters or
> return value. 
> 
> Design
> ------
> Instead of using ftrace's function entry hook directly, the new fprobe
> is built on top of the function-graph's entry and return callbacks
> with 'ftrace_regs'.
> 
> Since the fprobe requires access to 'ftrace_regs', the architecture
> must support CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS and
> CONFIG_HAVE_FTRACE_GRAPH_FUNC, which enables to call function-graph
> entry callback with 'ftrace_regs', and also
> CONFIG_HAVE_FUNCTION_GRAPH_FREGS, which passes the ftrace_regs to
> return_to_handler.
> 
> All fprobes share a single function-graph ops (means shares a common
> ftrace filter) similar to the kprobe-on-ftrace. This needs another
> layer to find corresponding fprobe in the common function-graph
> callbacks, but has much better scalability, since the number of
> registered function-graph ops is limited.
> 
> In the entry callback, the fprobe runs its entry_handler and saves the
> address of 'fprobe' on the function-graph's shadow stack as data. The
> return callback decodes the data to get the 'fprobe' address, and runs
> the exit_handler.
> 
> The fprobe introduces two hash-tables, one is for entry callback which
> searches fprobes related to the given function address passed by entry
> callback. The other is for a return callback which checks if the given
> 'fprobe' data structure pointer is still valid. Note that it is
> possible to unregister fprobe before the return callback runs. Thus
> the address validation must be done before using it in the return
> callback.
> 
> Download
> --------
> This series can be applied against the v6.13-rc2 kernel.
> 
> This series can also be found below branch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (Google) (19):
>       fgraph: Get ftrace recursion lock in function_graph_enter
>       fgraph: Pass ftrace_regs to entryfunc
>       fgraph: Replace fgraph_ret_regs with ftrace_regs
>       fgraph: Pass ftrace_regs to retfunc
>       fprobe: Use ftrace_regs in fprobe entry handler
>       fprobe: Use ftrace_regs in fprobe exit handler
>       tracing: Add ftrace_partial_regs() for converting ftrace_regs to pt_regs
>       tracing: Add ftrace_fill_perf_regs() for perf event
>       tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
>       bpf: Enable kprobe_multi feature if CONFIG_FPROBE is enabled
>       ftrace: Add CONFIG_HAVE_FTRACE_GRAPH_FUNC
>       fprobe: Rewrite fprobe on function-graph tracer
>       fprobe: Add fprobe_header encoding feature
>       tracing/fprobe: Remove nr_maxactive from fprobe
>       selftests: ftrace: Remove obsolate maxactive syntax check
>       selftests/ftrace: Add a test case for repeating register/unregister fprobe
>       Documentation: probes: Update fprobe on function-graph tracer
>       ftrace: Add ftrace_get_symaddr to convert fentry_ip to symaddr
>       bpf: Use ftrace_get_symaddr() for kprobe_multi probes
> 
> Sven Schnelle (1):
>       s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC
> 
> 
>  Documentation/trace/fprobe.rst                     |   42 +
>  arch/arm64/Kconfig                                 |    2 
>  arch/arm64/include/asm/Kbuild                      |    1 
>  arch/arm64/include/asm/ftrace.h                    |   51 +-
>  arch/arm64/kernel/asm-offsets.c                    |   12 
>  arch/arm64/kernel/entry-ftrace.S                   |   32 +
>  arch/arm64/kernel/ftrace.c                         |   78 ++
>  arch/loongarch/Kconfig                             |    4 
>  arch/loongarch/include/asm/fprobe.h                |   12 
>  arch/loongarch/include/asm/ftrace.h                |   32 -
>  arch/loongarch/kernel/asm-offsets.c                |   12 
>  arch/loongarch/kernel/ftrace_dyn.c                 |   10 
>  arch/loongarch/kernel/mcount.S                     |   17 -
>  arch/loongarch/kernel/mcount_dyn.S                 |   14 
>  arch/powerpc/Kconfig                               |    1 
>  arch/powerpc/include/asm/ftrace.h                  |   13 
>  arch/powerpc/kernel/trace/ftrace.c                 |    8 
>  arch/powerpc/kernel/trace/ftrace_64_pg.c           |   16 
>  arch/riscv/Kconfig                                 |    3 
>  arch/riscv/include/asm/Kbuild                      |    1 
>  arch/riscv/include/asm/ftrace.h                    |   45 +
>  arch/riscv/kernel/ftrace.c                         |   17 -
>  arch/riscv/kernel/mcount.S                         |   24 -
>  arch/s390/Kconfig                                  |    4 
>  arch/s390/include/asm/fprobe.h                     |   10 
>  arch/s390/include/asm/ftrace.h                     |   37 +
>  arch/s390/kernel/asm-offsets.c                     |    6 
>  arch/s390/kernel/entry.h                           |    1 
>  arch/s390/kernel/ftrace.c                          |   48 -
>  arch/s390/kernel/mcount.S                          |   23 -
>  arch/x86/Kconfig                                   |    4 
>  arch/x86/include/asm/Kbuild                        |    1 
>  arch/x86/include/asm/ftrace.h                      |   54 +-
>  arch/x86/kernel/ftrace.c                           |   47 +
>  arch/x86/kernel/ftrace_32.S                        |   13 
>  arch/x86/kernel/ftrace_64.S                        |   17 -
>  include/asm-generic/fprobe.h                       |   46 +
>  include/linux/fprobe.h                             |   62 +-
>  include/linux/ftrace.h                             |  116 +++
>  include/linux/ftrace_regs.h                        |    2 
>  kernel/trace/Kconfig                               |   22 -
>  kernel/trace/bpf_trace.c                           |   28 +
>  kernel/trace/fgraph.c                              |   65 +-
>  kernel/trace/fprobe.c                              |  664 +++++++++++++++-----
>  kernel/trace/ftrace.c                              |    6 
>  kernel/trace/trace.h                               |    6 
>  kernel/trace/trace_fprobe.c                        |  146 ++--
>  kernel/trace/trace_functions_graph.c               |   10 
>  kernel/trace/trace_irqsoff.c                       |    6 
>  kernel/trace/trace_probe_tmpl.h                    |    2 
>  kernel/trace/trace_sched_wakeup.c                  |    6 
>  kernel/trace/trace_selftest.c                      |   11 
>  lib/test_fprobe.c                                  |   51 --
>  samples/fprobe/fprobe_example.c                    |    4 
>  .../test.d/dynevent/add_remove_fprobe_repeat.tc    |   19 +
>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    4 
>  56 files changed, 1318 insertions(+), 670 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/fprobe.h
>  create mode 100644 arch/s390/include/asm/fprobe.h
>  create mode 100644 include/asm-generic/fprobe.h
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/add_remove_fprobe_repeat.tc
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


Return-Path: <linux-arch+bounces-9489-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4189FC786
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 03:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77120160B74
	for <lists+linux-arch@lfdr.de>; Thu, 26 Dec 2024 02:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D621C6B4;
	Thu, 26 Dec 2024 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRQ+KqvG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91981876;
	Thu, 26 Dec 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735178935; cv=none; b=mE+FDIvX8ppj4JQ/6vNVBMMb1QXMYawJzna8X+I6fM0Sat45xQAKXQqVBGvYyGuEKgr4X6+ILNXmuA8RqFA62SP+F2ttfOr4xnkAGZVY5N3/SyVE8uO0KRQsrP4RMNMOxOdrTDIxIiLfOp/rI/Po7cjFj98y8SucPkuK2ISuKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735178935; c=relaxed/simple;
	bh=PRuTsFJRADKSM13AwD8rEHVpYPpipqUot0rJtU+snww=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XlrjvHljjPUmOk53MW1VVFhtJO2ZZyyGmkvvw6CgYYfuntuz71g6tNQY6noiCxQczJx4Uqu7mJdvof9y29u58LFAmlsjLeZLD19Xr++095J+ptfvZEBN2D+zk53ugtqXpTAZW11hhg2UntASG8KaaREY5TcWPqxXC9d6tbSt36M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRQ+KqvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F25DC4CECD;
	Thu, 26 Dec 2024 02:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735178934;
	bh=PRuTsFJRADKSM13AwD8rEHVpYPpipqUot0rJtU+snww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IRQ+KqvG8o2ztbt7BRryBYnPaAZxhLGTaZExBcXDh7k8LGqnOdQj7JfBy11Sk8+LC
	 kGVeriw34HkpUU41g1uvqx0bMjo90Nuajul6AI2X43zLt/kEAt5+RD3ykkbc07WjVQ
	 5mfH6Q4+W/iL/mGitEGKh2aveyyFXVeXNJELDZPYcXGG7vSYt7ohLqzNges7ShI9CT
	 lB2fS2LK0UY2CwGVDt0hmMR8RHKZNIGj0snNMKMwlnN24wiffQC70xsZPmDaDr+ov5
	 js0lc/N2Yc7t30W7/fE9JuFkysdJNQuyhLtU3p42RaFrcnAxxUFQsAH8pxgKCkpgqx
	 Hk6+KKUORcO8Q==
Date: Thu, 26 Dec 2024 11:08:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v21 05/20] fprobe: Use ftrace_regs in fprobe entry
 handler
Message-Id: <20241226110848.3d95040586e4f5c71ec65a3d@kernel.org>
In-Reply-To: <20241223164238.4d2b9a50@gandalf.local.home>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
	<173379659280.973433.14242629573844824837.stgit@devnote2>
	<20241223164238.4d2b9a50@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 23 Dec 2024 16:42:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 10 Dec 2024 11:09:52 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > This allows fprobes to be available with CONFIG_DYNAMIC_FTRACE_WITH_ARGS
> > instead of CONFIG_DYNAMIC_FTRACE_WITH_REGS, then we can enable fprobe
> > on arm64.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Hmm, my build failed on this patch. Perhaps I screwed up the rebase to v6.13-rc4?

Oops, no. That is a bug, which is fixed in [9/20]. Let me fix it.

Thanks!

> 
> Config attached:
> 
> [3 seconds] SUCCESS
> make O=/work/build/nobackup/tracetest -j50 ... make[1]: Entering directory '/work/build/nobackup/tracetest'
>   SYNC    include/config/auto.conf.cmd
>   GEN     Makefile
>   GEN     Makefile
> mkdir -p /work/build/nobackup/tracetest/tools/objtool && make O=/work/build/nobackup/tracetest subdir=tools/objtool --no-print-directory -C objtool
>   UPD     include/config/kernel.release
>   UPD     include/generated/utsrelease.h
>   INSTALL libsubcmd_headers
>   CALL    /work/build/trace/nobackup/linux-test.git/scripts/checksyscalls.sh
>   CC      init/version.o
>   CC      net/sched/sch_generic.o
>   CC      drivers/base/firmware_loader/main.o
>   CC      security/integrity/ima/ima_init.o
>   CC      kernel/sys.o
>   CC      kernel/module/main.o
>   CC      drivers/gpu/drm/drm_vblank.o
>   CC      kernel/time/time.o
>   AR      init/built-in.a
>   CC      drivers/gpu/drm/ttm/ttm_bo.o
>   CC      drivers/gpu/drm/ttm/ttm_bo_util.o
>   CC      drivers/gpu/drm/qxl/qxl_ttm.o
>   CC      kernel/trace/bpf_trace.o
>   CC      kernel/trace/fprobe.o
>   CC      kernel/trace/trace_fprobe.o
>   AR      security/integrity/ima/built-in.a
>   AR      security/integrity/built-in.a
>   AR      security/built-in.a
> /work/build/trace/nobackup/linux-test.git/kernel/trace/trace_fprobe.c: In function ‘__trace_fprobe_create’:
> /work/build/trace/nobackup/linux-test.git/kernel/trace/trace_fprobe.c:1223:38: error: assignment to ‘fprobe_entry_cb’ {aka ‘int (*)(struct fprobe *, long unsigned int,  long unsigned int,  struct ftrace_regs *, void *)’} from incompatible pointer type ‘int (*)(struct fpro
> be *, long unsigned int,  long unsigned int,  struct pt_regs *, void *)’ [-Wincompatible-pointer-types]
>  1223 |                 tf->fp.entry_handler = trace_fprobe_entry_handler;
>       |                                      ^
> make[5]: *** [/work/build/trace/nobackup/linux-test.git/scripts/Makefile.build:194: kernel/trace/trace_fprobe.o] Error 1
> make[5]: *** Waiting for unfinished jobs....
>   AR      drivers/gpu/drm/qxl/built-in.a
>   AR      drivers/base/firmware_loader/built-in.a
>   AR      drivers/base/built-in.a
>   AR      kernel/time/built-in.a
>   AR      drivers/gpu/drm/ttm/built-in.a
>   AR      drivers/gpu/drm/built-in.a
>   AR      drivers/gpu/built-in.a
>   AR      drivers/built-in.a
>   AR      net/sched/built-in.a
>   AR      net/built-in.a
>   AR      kernel/module/built-in.a
> make[4]: *** [/work/build/trace/nobackup/linux-test.git/scripts/Makefile.build:440: kernel/trace] Error 2
> make[3]: *** [/work/build/trace/nobackup/linux-test.git/scripts/Makefile.build:440: kernel] Error 2
> make[2]: *** [/work/build/trace/nobackup/linux-test.git/Makefile:1989: .] Error 2
> make[1]: *** [/work/build/trace/nobackup/linux-test.git/Makefile:251: __sub-make] Error 2
> make[1]: Leaving directory '/work/build/nobackup/tracetest'
> make: *** [Makefile:251: __sub-make] Error 2
> [10 seconds] FAILED!
> make O=/work/build/nobackup/tracetest kernelrelease ... 6.13.0-rc4-test-00005-g21a983830d78-dirty
> ssh -t root@tracetest 'rm -rf /lib/modules/*-test*'; git reset --hard ... HEAD is now at 21a983830d78 fprobe: Use ftrace_regs in fprobe entry handler
> [1 second] SUCCESS
> CRITICAL FAILURE... [TEST 3] failed build
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


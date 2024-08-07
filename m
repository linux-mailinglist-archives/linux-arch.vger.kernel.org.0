Return-Path: <linux-arch+bounces-6101-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 281B094AF3B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 19:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6931C20B28
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AFA13DBBE;
	Wed,  7 Aug 2024 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/o+bFLz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0779DC5;
	Wed,  7 Aug 2024 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723053421; cv=none; b=V4ttQPVZKvqhFh3e1Wntja6uvtQAENIDD6M64GqbnvOYgSLNxGj/pZixP2ohyNr0ZDjhYWmsMG/AOrjxWyRi5YsAH5xCp+DG2hNJ2md3a/MqgSx9oN2jkcLmAqki65y15MLnLZfEL43tV6OgxIuw7sI/w3ae92k5386TS1LJawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723053421; c=relaxed/simple;
	bh=d6FviukTHiKvwlSWQr9NXWxc5Auyu7tuMFl3vBaAdjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl9uD0FdpZ8tbIeS96tWSKR9gc5VewghaLOQDk2Tmz4lus/MLK4xtFhAXVbzcrzKH875499XTxQdJcyk4tCFOrV71sGGnJcaCMH/SFLCYNP7V2MbiMcUiA3qS+evCfgCJR9JtW5D3g/sVMYlxwO2+ke5mgqS3h50ohmZ4I9LCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/o+bFLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF6EC32781;
	Wed,  7 Aug 2024 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723053420;
	bh=d6FviukTHiKvwlSWQr9NXWxc5Auyu7tuMFl3vBaAdjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/o+bFLzRpX/kG9wl/VqVnEVMAq7bUZ5UhKhMZ49mLwKAkyx0xZ0RqtLhvFnievQQ
	 HVCxtRwHYw1K5w7ssuZzwNsgtbjRS7Sjh0xZpDQitYR37EVCSNjgEawF/OyTgrij0K
	 VQEDIo3TygCrHK/OJxXz98yN25Pm99nAkpH2Leln5mgzwDlpUCB+5QnzY62eTLOPVB
	 vMnm2vauNABOlfNrpwWm0ywybRE/YlfOCE60rXlPHqrp9aATnpvsnjFR2eep6aoVdz
	 /uYogGIxldjN8+QLHSb7YHYWZ26bkMVFR8OzABK9PxY2cq6D1F3Y045KA8Nd5bskU9
	 WyVgbr691yDZQ==
Date: Wed, 7 Aug 2024 10:56:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 06/10] tools/include: Sync uapi/asm-generic/unistd.h with
 the kernel sources
Message-ID: <ZrO1aqysu-jtYbtC@google.com>
References: <20240806225013.126130-1-namhyung@kernel.org>
 <20240806225013.126130-7-namhyung@kernel.org>
 <10a643ba-cafe-411e-855e-d93d8144f470@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10a643ba-cafe-411e-855e-d93d8144f470@app.fastmail.com>

Hello,

On Wed, Aug 07, 2024 at 09:11:01AM +0200, Arnd Bergmann wrote:
> On Wed, Aug 7, 2024, at 00:50, Namhyung Kim wrote:
> > And arch syscall tables to pick up changes from:
> >
> >   b1e31c134a8a powerpc: restore some missing spu syscalls
> >   d3882564a77c syscalls: fix compat_sys_io_pgetevents_time64 usage
> >   54233a425403 uretprobe: change syscall number, again
> >   63ded110979b uprobe: Change uretprobe syscall scope and number
> >   9142be9e6443 x86/syscall: Mark exit[_group] syscall handlers __noreturn
> >   9aae1baa1c5d x86, arm: Add missing license tag to syscall tables files
> >   5c28424e9a34 syscalls: Fix to add sys_uretprobe to syscall.tbl
> >   190fec72df4a uprobe: Wire up uretprobe system call
> >
> > This should be used to beautify syscall arguments and it addresses
> > these tools/perf build warnings:
> >
> >   Warning: Kernel ABI header differences:
> >   diff -u tools/arch/arm64/include/uapi/asm/unistd.h 
> > arch/arm64/include/uapi/asm/unistd.h
> >   diff -u tools/include/uapi/asm-generic/unistd.h 
> > include/uapi/asm-generic/unistd.h
> >   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl 
> > arch/x86/entry/syscalls/syscall_64.tbl
> >   diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl 
> > arch/powerpc/kernel/syscalls/syscall.tbl
> >   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl 
> > arch/s390/kernel/syscalls/syscall.tbl
> >
> > Please see tools/include/uapi/README for details (it's in the first patch
> > of this series).
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/arch/arm64/include/uapi/asm/unistd.h    | 24 +------------------
> >  tools/include/uapi/asm-generic/unistd.h       |  2 +-
> >  .../arch/powerpc/entry/syscalls/syscall.tbl   |  6 ++++-
> >  .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +-
> >  .../arch/x86/entry/syscalls/syscall_64.tbl    |  8 ++++---
> >  5 files changed, 13 insertions(+), 29 deletions(-)
> >
> > diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h 
> > b/tools/arch/arm64/include/uapi/asm/unistd.h
> > index 9306726337fe..df36f23876e8 100644
> > --- a/tools/arch/arm64/include/uapi/asm/unistd.h
> > +++ b/tools/arch/arm64/include/uapi/asm/unistd.h
> > -
> > -#define __ARCH_WANT_RENAMEAT
> > -#define __ARCH_WANT_NEW_STAT
> > -#define __ARCH_WANT_SET_GET_RLIMIT
> > -#define __ARCH_WANT_TIME32_SYSCALLS
> > -#define __ARCH_WANT_MEMFD_SECRET
> > -
> > -#include <asm-generic/unistd.h>
> > +#include <asm/unistd_64.h>
> 
> This part won't work by itself, since you don't pick up
> the generated asm/unistd_64.h header but keep the old
> asm-generic/unistd.h header. Both have the same contents,
> so the easy way to do this is to just keep the existing
> version of the arm64 header for 6.11 and add a script to
> generate it in 6.12 the way we do for x86, using an
> architecture-independent script.

Thanks for the review, I'll drop the arm64 parts for now.

> 
> > @@ -68,7 +69,7 @@
> >  57	common	fork			sys_fork
> >  58	common	vfork			sys_vfork
> >  59	64	execve			sys_execve
> > -60	common	exit			sys_exit
> > +60	common	exit			sys_exit			-			noreturn
> >  61	common	wait4			sys_wait4
> >  62	common	kill			sys_kill
> >  63	common	uname			sys_newuname
> 
> Have you checked if this works correctly with the
> existing tools/perf/arch/x86/entry/syscalls/syscalltbl.sh?

Yep, the script only cares about the number and the name.

  # the params are: nr abi name entry compat
  # use _ for intentionally unused variables according to SC2034
  while read nr _ name _ _; do
      if [ $nr -ge 512 ] ; then # discard compat sycalls
          break
      fi
  
      emit "$nr" "$name"
      max_nr=$nr
  done < $sorted_table

The only difference I see was the added uretprobe syscall.

  $ tools/arch/x86/entry/syscalls/syscalltbl.sh tools/arch/x86/entry/syscalls/syscall_64.tbl x86_64 > b
  (apply this series...)
  $ tools/arch/x86/entry/syscalls/syscalltbl.sh tools/arch/x86/entry/syscalls/syscall_64.tbl x86_64 > a
  
  $ diff -u b a
  --- b	2024-08-07 10:28:04.267738574 -0700
  +++ a	2024-08-07 10:28:18.543965369 -0700
  @@ -334,6 +334,7 @@
   	[332] = "statx",
   	[333] = "io_pgetevents",
   	[334] = "rseq",
  +	[335] = "uretprobe",
   	[424] = "pidfd_send_signal",
   	[425] = "io_uring_setup",
   	[426] = "io_uring_enter",

Thanks,
Namhyung

> 
> Since not just table file contents but also the file format
> changed here, there is a good chance that the output
> is no longer what we need.
> 
> Unfortunately, the format on x86 is now incompatible with
> the one on s390. I have a patch to change s390 in the future
> so we can use a single script for all of them.
> 
>       Arnd


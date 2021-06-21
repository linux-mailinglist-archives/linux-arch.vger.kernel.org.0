Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10AB3AE1ED
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 05:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFUDq4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Jun 2021 23:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhFUDq4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Jun 2021 23:46:56 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02863C061574;
        Sun, 20 Jun 2021 20:44:42 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvArR-00AhLi-66; Mon, 21 Jun 2021 03:44:33 +0000
Date:   Mon, 21 Jun 2021 03:44:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of
 switch_stack
Message-ID: <YNALIY2vhvzKi+Sy@zeniv-ca.linux.org.uk>
References: <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <87zgvqor7d.fsf_-_@disp2133>
 <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133>
 <87pmwlek8d.fsf_-_@disp2133>
 <87k0mtek4n.fsf_-_@disp2133>
 <393c37de-5edf-effc-3d06-d7e63f34a317@gmail.com>
 <CAHk-=wip8KgrNUcU68wsLZqbWV+3NWg9kqqQwygHGAA8-xOwMA@mail.gmail.com>
 <60c0fe00-b966-6385-d348-f6dd45277113@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c0fe00-b966-6385-d348-f6dd45277113@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 21, 2021 at 03:18:35PM +1200, Michael Schmitz wrote:

> This is what I get from WARN_ONCE:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1177 at arch/m68k/kernel/ptrace.c:91 get_reg+0x90/0xb8
> Modules linked in:
> CPU: 0 PID: 1177 Comm: strace Not tainted 5.13.0-rc1-atari-fpuemu-exitfix+
> #1146
> Stack from 014b7f04:
>         014b7f04 00336401 00336401 000278f0 0032c015 0000005b 00000005
> 0002795a
>         0032c015 0000005b 0000338c 00000009 00000000 00000000 ffffffe4
> 00000005
>         00000003 00000014 00000003 00000014 efc2b90c 0000338c 0032c015
> 0000005b
>         00000009 00000000 efc2b908 00912540 efc2b908 000034cc 00912540
> 00000005
>         00000000 efc2b908 00000003 00912540 8000110c c010b0a4 efc2b90c
> 0002d1d8
>         00912540 00000003 00000014 efc2b908 0000049a 00000014 efc2b908
> 800acaa8
> Call Trace: [<000278f0>] __warn+0x9e/0xb4
>  [<0002795a>] warn_slowpath_fmt+0x54/0x62
>  [<0000338c>] get_reg+0x90/0xb8
>  [<0000338c>] get_reg+0x90/0xb8
>  [<000034cc>] arch_ptrace+0x7e/0x250
>  [<0002d1d8>] sys_ptrace+0x232/0x2f8
>  [<00002ab6>] syscall+0x8/0xc
>  [<0000c00b>] lower+0x7/0x20
> 
> ---[ end trace ee4be53b94695793 ]---
> 
> Syscall numbers are actually 90 and 192 - sys_old_mmap and sys_mmap2 on
> m68k. Used the calculator on my Ubuntu desktop, that appears to be a little
> confused about hex to decimal conversions.
> 
> I hope that makes more sense?

Not really; what is the condition you are checking?  The interesting trace
is not that with get_reg() - it's that of the process being traced.  You
are not accessing the stack of caller of ptrace(2) here, so you want to
know that SAVE_SWITCH_STACK had been done by the tracee, not tracer.

And if that had been strace ls, you have TIF_SYSCALL_TRACE set for ls, so
	* ls hits system_call
	* notices TIF_SYSCALL_TRACE and goes to do_trace_entry
	* does SAVE_SWITCH_STACK there
	* calls syscall_trace(), which calls ptrace_notify()
	* ptrace_notify() calls ptrace_do_notify(), which calls ptrace_stop()
	* ptrace_stop() arranges for tracer to be woken up and gives CPU up,
with TASK_TRACED as process state.

That's the callchain in ls, and switch_stack accessed by get_reg() from
strace is the one on ls(1) stack created by SAVE_SWITCH_STACK.

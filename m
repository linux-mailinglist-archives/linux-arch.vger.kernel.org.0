Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E343AF8ED
	for <lists+linux-arch@lfdr.de>; Tue, 22 Jun 2021 01:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFUXIR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 19:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFUXIR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 19:08:17 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEF6C061574;
        Mon, 21 Jun 2021 16:06:02 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvSyp-00AzNi-P9; Mon, 21 Jun 2021 23:05:23 +0000
Date:   Mon, 21 Jun 2021 23:05:23 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
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
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
Message-ID: <YNEbM+B8Su7GDCSo@zeniv-ca.linux.org.uk>
References: <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
 <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
 <87fsxjorgs.fsf@disp2133>
 <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNCfNWC1UMvuE5d5@zeniv-ca.linux.org.uk>
 <87czsfi2kv.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czsfi2kv.fsf@disp2133>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 21, 2021 at 11:50:56AM -0500, Eric W. Biederman wrote:
> Al Viro <viro@zeniv.linux.org.uk> writes:
> 
> > On Mon, Jun 21, 2021 at 01:54:56PM +0000, Al Viro wrote:
> >> On Tue, Jun 15, 2021 at 02:58:12PM -0700, Linus Torvalds wrote:
> >> 
> >> > And I think our horrible "kernel threads return to user space when
> >> > done" is absolutely horrifically nasty. Maybe of the clever sort, but
> >> > mostly of the historical horror sort.
> >> 
> >> How would you prefer to handle that, then?  Separate magical path from
> >> kernel_execve() to switch to userland?  We used to have something of
> >> that sort, and that had been a real horror...
> >> 
> >> As it is, it's "kernel thread is spawned at the point similar to
> >> ret_from_fork(), runs the payload (which almost never returns) and
> >> then proceeds out to userland, same way fork(2) would've done."
> >> That way kernel_execve() doesn't have to do anything magical.
> >> 
> >> Al, digging through the old notes and current call graph...
> >
> > 	FWIW, the major assumption back then had been that get_signal(),
> > signal_delivered() and all associated machinery (including coredumps)
> > runs *only* from SIGPENDING/NOTIFY_SIGNAL handling.
> >
> > 	And "has complete registers on stack" is only a part of that;
> > there was other fun stuff in the area ;-/  Do we want coredumps for
> > those, and if we do, will the de_thread stuff work there?
> 
> Do we want coredumps from processes that use io_uring? yes
> Exactly what we want from io_uring threads is less clear.  We can't
> really give much that is meaningful beyond the thread ids of the
> io_uring threads.
> 
> What problems do are you seeing beyond the missing registers on the
> stack for kernel threads?
> 
> I don't immediately see the connection between coredumps and de_thread.
> 
> The function de_thread arranges for the fatal_signal_pending to be true,
> and that should work just fine for io_uring threads.  The io_uring
> threads process the fatal_signal with get_signal and then proceed to
> exit eventually calling do_exit.

I would like to see the testing in cases when the io-uring thread is
the one getting hit by initial signal and when it's the normal one
with associated io-uring ones.  The thread-collecting logics at least
used to depend upon fairly subtle assumptions, and "kernel threads
obviously can't show up as candidates" used to narrow the analysis
down...

In any case, WTF would we allow reads or writes to *any* registers of
such threads?  It's not as simple as "just return zeroes", BTW - the
values allowed in special registers might have non-trivial constraints
on them.  The same goes for coredump - we don't _have_ registers to
dump for those, period.

Looks like the first things to do would be
	* prohibit ptrace accessing any regsets of worker threads
	* make coredump skip all register notes for those

Note, BTW, that kernel_thread() and kernel_execve() do *NOT* step into
ptrace_notify() - explicit CLONE_UNTRACED for the former and zero
current->ptrace in the caller of the latter.  So fork and exec side
has ptrace_event() crap limited to real syscalls.

It's seccomp[1] and exit-related stuff that are messy...

[1] "never trust somebody who introduces himself as Honest Joe and keeps
carping on that all the time"; c.f. __secure_computing(), CONFIG_INTEGRITY,
etc.

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4593B3960
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jun 2021 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhFXWsO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Jun 2021 18:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXWsN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jun 2021 18:48:13 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0809C061574;
        Thu, 24 Jun 2021 15:45:53 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwY67-00BwuB-I0; Thu, 24 Jun 2021 22:45:23 +0000
Date:   Thu, 24 Jun 2021 22:45:23 +0000
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
Subject: Re: [PATCH 0/9] Refactoring exit
Message-ID: <YNULA+Ff+eB66bcP@zeniv-ca.linux.org.uk>
References: <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
 <YNCaMDQVYB04bk3j@zeniv-ca.linux.org.uk>
 <YNDhdb7XNQE6zQzL@zeniv-ca.linux.org.uk>
 <CAHk-=whAsWXcJkpMM8ji77DkYkeJAT4Cj98WBX-S6=GnMQwhzg@mail.gmail.com>
 <87a6njf0ia.fsf@disp2133>
 <CAHk-=wh4_iMRmWcao6a8kCvR0Hhdrz+M9L+q4Bfcwx9E9D0huw@mail.gmail.com>
 <87tulpbp19.fsf@disp2133>
 <CAHk-=wi_kQAff1yx2ufGRo2zApkvqU8VGn7kgPT-Kv71FTs=AA@mail.gmail.com>
 <87zgvgabw1.fsf@disp2133>
 <875yy3850g.fsf_-_@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yy3850g.fsf_-_@disp2133>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 24, 2021 at 01:57:35PM -0500, Eric W. Biederman wrote:

> So far the code has been lightly tested, and the descriptions of some
> of the patches are a bit light, but I think this shows the direction
> I am aiming to travel for sorting out exit(2) and exit_group(2).

FWIW, here's the current picture for do_exit(), aside of exit(2) and do_exit_group():

1) stuff that is clearly oops-like -
        alpha:die_if_kernel() alpha:do_entUna() alpha:do_page_fault() arm:oops_end()
        arm:__do_kernel_fault() arm64:die() arm64:die_kernel_fault() csky:alignment()
        csky:die() csky:no_context() h8300:die() h8300:do_page_fault() hexagon:die()
        ia64:die() i64:ia64_do_page_fault() m68k:die_if_kernel() m68k:send_fault_sig()
        microblaze:die() mips:die() nds32:handle_fpu_exception() nds32:die()
        nds32:unhandled_interruption() nds32:unhandled_exceptions() nds32:do_revinsn()
        nds32:do_page_fault() nios:die() openrisc:die() openrisc:do_page_fault()
        parisc:die_if_kernel() ppc:oops_end() riscv:die() riscv:die_kernel_fault()
        s390:die() s390:do_no_context() s390:do_low_address() sh:die()
        sparc32:die_if_kernel() sparc32:do_sparc_fault() sparc64:die_if_kernel()
        x86:rewind_stack_do_exit() xtensa:die() xtensa:bad_page_fault()
We really do not want ptrace anywhere near any of those and we do not want
any of that to return; this shit would better be handled right there and
there - no "post a fatal signal" would do.

2) sparc32 playing silly buggers with SIGILL in case when signal delivery
can't get a valid sigframe.  The regular variant for that kind of stuff
is forced SIGSEGV from failure case of signal_setup_done().  We could force
that SIGILL instead of do_exit() there (and report failure from sigframe
setup), but I suspect that we'll get SIGSEGV override that SIGILL, with
user-visible behaviour change.  Triggered by altstack overflow on sparc32;
sparc64 gets SIGSEGV in the same situation, just like everybody else.

3) ppc swapcontext(2).  Normal syscall, on failure results in exit(SIGSEGV).
Not sure if we want to post signal here - exposing the caller to results
of failure might be... interesting.  And I really don't know if we want
to allow ptrace() to poke around in the results of such failure.  That's
a question for ppc maintainers.

4) sparc32:try_to_clear_window_buffer().  Probably could force SIGSEGV
instead of do_exit() there, but that might need a bit of massage in
asm glue - it's called on the way out of kernel, right before handling
signals.  I'd like comments from davem on that one, though.

5) in xtensa fast_syscall_spill_registers() stuff.  Might or might not
be similar to the above.

6) sparc64 in tsb_grow() - looks like "impossible case, kill the sucker
dead if that ever happens".  Not sure if it's reachable at all.

7) s390 copy_thread() is doing something interesting in kernel thread
case - frame->childregs.gprs[11] = (unsigned long)do_exit;
AFAICS, had been unused since 30dcb0996e40, when s390 switched to new
kernel_execve() semantics and kernel_thread_starter stopped using r11
(or proceeding to do_exit() in the first place).  Ought to be removed,
if s390 folks ACK that.

8) x86:emulate_vsyscall(), x86:save_v86_state(), m68k:fpsp040_die(),
mips:bad_stack(), s390:__s390_handle_mcck(), ia64:mca_handler_bh(),
s390:default_trap_handler() - fuck knows.

9) seccomp stuff - this one should *NOT* be switched to posting signals;
it's on syscall_trace_enter() paths and we'd better have signal-equivalent
environment there.  We sure as hell do have regular "stop and let tracer
poke around" in the same area - that's where strace is poking around.

10) there's a (moderate) bunch of places all over the tree where we
have kthread() payload hit do_exit(), with or without complete() or
module_put().  No ptrace stuff is going to be hit there and I see no
point in switching those to posting anything.  In particular,
module_put_and_exit() sure as hell does *NOT* want to return to caller -
it might've been unmapped by the point we are done.  This do_exit()
should really be noreturn.

11) abuses in kernel/kthread.c; AFAICS, it's misused as a mechanism
to return an error value to parent.  No ptrace possible (parent
definitely not traced) and I don't see any point in delaying the
handling of that do_exit() either (same as with the execve failure
in call_usermodehelper_exec_async()).

12) io-uring threads hitting do_exit().  These, apparently, can be
ptraced...

13) there's bdflush(1, whatever), which is equivalent to exit(0).
IMO it's long past the time to simply remove the sucker.

14) reboot(2) stuff.  No idea.

15) syscall_user_dispatch().  Didn't have time to look through that
stuff in details yet, so no idea at the moment.

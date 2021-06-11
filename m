Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD7D3A4AB3
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 23:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFKVmC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 17:42:02 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41284 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhFKVmB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jun 2021 17:42:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrosf-008XOJ-U8; Fri, 11 Jun 2021 15:39:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lrose-004obf-NP; Fri, 11 Jun 2021 15:39:57 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Daniel Jacobowitz <drow@nevyn.them.org>,
        Kees Cook <keescook@chromium.org>
In-Reply-To: <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 10 Jun 2021 15:04:33 -0700")
References: <87sg1p30a1.fsf@disp2133>
        <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Fri, 11 Jun 2021 16:39:44 -0500
Message-ID: <87pmwsytb3.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lrose-004obf-NP;;;mid=<87pmwsytb3.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+IuZawwTz1YFyhvc3cnGga/n99E1fmVx0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 537 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.7%), b_tie_ro: 2.5 (0.5%), parse: 0.77
        (0.1%), extract_message_metadata: 11 (2.1%), get_uri_detail_list: 1.79
        (0.3%), tests_pri_-1000: 19 (3.5%), tests_pri_-950: 1.01 (0.2%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 88 (16.4%), check_bayes:
        87 (16.1%), b_tokenize: 8 (1.5%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.0 (0.4%), b_tok_touch_all: 64 (11.9%), b_finish: 0.79
        (0.1%), tests_pri_0: 400 (74.4%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 1.24 (0.2%), tests_pri_10:
        2.9 (0.5%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Jun 10, 2021 at 1:58 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The problem is sometimes we read all of the registers from
>> a context where they are not all saved.
>
> Ouch. Yes. And this is really painful because none of the *normal*
> architectures do this, so it gets absolutely no coverage.
>
>> I think at this point we need to say that the architectures that have a
>> do this need to be fixed to at least call do_exit and the kernel
>> function in create_io_thread with the deeper stack.
>
> Yeah. We traditionally have that requirement for fork() and friends
> too (vfork/clone), so adding exit and io_uring to do so seems like the
> most straightforward thing.

Interesting.  I am starting with Al's analysis and reading the code
to see if I can understand what is going on.  So I am still glossing
over a few details as I dig into this.  Kernel threads not having
all of their registers saved is one of those details.

Looking at copy_thread it looks like at least on alpha we are dealing
with a structure that defines all of the registers in copy_thread.  So
perhaps all of the registers are there in kernel_threads already.  I
don't read alpha assembly very well and fork is a bit subtle.  I don't
know which piece of code is calling
ret_from_fork/ret_from_kernel_thread.

I really suspect that all of those registers are popped so at least for
IO_THREADS we need to push them again, in a way that signal_pt_regs()
can find them.

It looks like we just need something like this to cover the userspace
side of exit.

diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index e227f3a29a43..ab0dcb545bd1 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -812,6 +812,22 @@ fork_like fork
 fork_like vfork
 fork_like clone
 
+.macro exit_like name
+	.align	4
+	.globl	alpha_\name
+	.ent	alpha_\name
+alpha_\name:
+	.prologue 0
+	DO_SWITCH_STACK
+	jsr	$26, sys_\name
+	UNDO_SWITCH_STACK
+	ret
+.end	alpha_\name
+.endm
+
+exit_like exit
+exit_like exit_group
+
 .macro	sigreturn_like name
 	.align	4
 	.globl	sys_\name
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 3000a2e8ee21..b9d6449d6caa 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -8,7 +8,7 @@
 # The <abi> is always "common" for this file
 #
 0	common	osf_syscall			alpha_syscall_zero
-1	common	exit				sys_exit
+1	common	exit				alpha_exit
 2	common	fork				alpha_fork
 3	common	read				sys_read
 4	common	write				sys_write
@@ -333,7 +333,7 @@
 400	common	io_getevents			sys_io_getevents
 401	common	io_submit			sys_io_submit
 402	common	io_cancel			sys_io_cancel
-405	common	exit_group			sys_exit_group
+405	common	exit_group			alpha_exit_group
 406	common	lookup_dcookie			sys_lookup_dcookie
 407	common	epoll_create			sys_epoll_create
 408	common	epoll_ctl			sys_epoll_ctl


> But I really wish we had some way to test and trigger this so that we
> wouldn't get caught on this before. Something in task_pt_regs() that
> catches "this doesn't actually work" and does a WARN_ON_ONCE() on the
> affected architectures?

I think that would require pushing an extra magic value in SWITCH_STACK
and not just popping it but deliberately changing that value in
UNDO_SWITCH_STACK.  Basically stack canaries.

I don't see how we could do it in an arch independent way though.
Which means it will require auditing all of the architectures to get
there. Volunteers?

This is looking straight forward enough that I can probably pull
something together, just don't count on me to have it done in anything
resembling a timely manner.

Eric

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0E93A5AB6
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jun 2021 23:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhFMV53 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Jun 2021 17:57:29 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41562 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbhFMV50 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jun 2021 17:57:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lsY4e-00BfB2-O9; Sun, 13 Jun 2021 15:55:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lsY4d-008LUl-KS; Sun, 13 Jun 2021 15:55:20 -0600
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
References: <87sg1p30a1.fsf@disp2133>
        <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
        <87pmwsytb3.fsf@disp2133>
        <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
Date:   Sun, 13 Jun 2021 16:54:05 -0500
In-Reply-To: <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 11 Jun 2021 16:26:21 -0700")
Message-ID: <87sg1lwhvm.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lsY4d-008LUl-KS;;;mid=<87sg1lwhvm.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19b5C0aF+plb+/5FAhTXq2CXegUQeVKyl0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 544 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 3.4 (0.6%), b_tie_ro: 2.3 (0.4%), parse: 1.26
        (0.2%), extract_message_metadata: 18 (3.2%), get_uri_detail_list: 3.3
        (0.6%), tests_pri_-1000: 17 (3.1%), tests_pri_-950: 1.06 (0.2%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 103 (18.9%), check_bayes:
        95 (17.4%), b_tokenize: 8 (1.4%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 73 (13.4%), b_finish: 0.63
        (0.1%), tests_pri_0: 390 (71.6%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 1.74 (0.3%), poll_dns_idle: 0.19 (0.0%),
        tests_pri_10: 1.74 (0.3%), tests_pri_500: 5 (1.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 11, 2021 at 2:40 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Looking at copy_thread it looks like at least on alpha we are dealing
>> with a structure that defines all of the registers in copy_thread.
>
> On the target side, yes.
>
> On the _source_ side, the code does
>
>         struct pt_regs *regs = current_pt_regs();
>
> and that's the part that means that fork() and related functions need
> to have done that DO_SWITCH_STACK(), so that they have the full
> register set to be copied.
>
> Otherwise it would copy random contents from the source stack.
>
> But that
>
>         if (unlikely(p->flags & (PF_KTHREAD | PF_IO_WORKER))) {
>
> ends up protecting us, and the code never uses that set of source
> registers for the io worker threads.

The test in copy_thread.  That isn't the case I am worried about.

> So io_uring looks fine on alpha. I didn't check m68k and friends, but
> I think they have the same thing going.

As I have read through the code more I don't think so.

The code paths I am worried about are:

	ret_from_kernel_thread
        	io_wqe_worker
                	get_signal
                        	do_coredump
                        	ptrace_stop

	ret_from_kernel_thread
        	io_sq_thread
                	get_signal
                        	do_coredump
                        	ptrace_stop


As I understand the code the new thread created by create_thread
initially has a full complement of registers, and then is started
by alpha_switch_to:

	.align	4
	.globl	alpha_switch_to
	.type	alpha_switch_to, @function
	.cfi_startproc
alpha_switch_to:
	DO_SWITCH_STACK
	call_pal PAL_swpctx
	lda	$8, 0x3fff
	UNDO_SWITCH_STACK
	bic	$sp, $8, $8
	mov	$17, $0
	ret
	.cfi_endproc
	.size	alpha_switch_to, .-alpha_switch_to


The alpha_switch_to will remove the extra registers from the stack and
then call ret which if I understand alpha assembly correctly is
equivalent to jumping to where $26 points.  Which is
ret_from_kernel_thread (as setup by copy_thread).

Which leaves ret_from_kernel_thread and everything it calls without
the extra context saved on the stack.

I am still trying to understand how we get registers populated at a
fixed offset on the stack during schedule.  As it looks like switch_to
assumes the stack pointer is in the proper location.

>> It looks like we just need something like this to cover the userspace
>> side of exit.
>
> Looks correct to me. Except I think you could just use "fork_like()"
> instead of creating a new (and identical) "exit_like()" macro.
>
>> > But I really wish we had some way to test and trigger this so that we
>> > wouldn't get caught on this before. Something in task_pt_regs() that
>> > catches "this doesn't actually work" and does a WARN_ON_ONCE() on the
>> > affected architectures?
>>
>> I think that would require pushing an extra magic value in SWITCH_STACK
>> and not just popping it but deliberately changing that value in
>> UNDO_SWITCH_STACK.  Basically stack canaries.
>>
>> I don't see how we could do it in an arch independent way though.
>
> No, I think you're right. There's no obvious generic solution to it,
> and once we look at arch-specific ones we're vback to "just alpha,
> m68k and nios needs this or cares" and tonce you're there you might as
> well just fix it.
>
> ia64 has soem "fast system call" model with limited registers too, but
> I think that's limited to just a few very special system calls (ie it
> does the reverse of what alpha does: alpha does the fast case by
> default, and then marks fork/vfork/clone as special).

I wonder if the arch specific solution should be to move the registers
to a fixed location in task_struct (perhaps thread_struct ) so that the
same patterns can apply across all architectures and we don't get
surprises at all.

What appears to be unique about alpha, m68k, and nios is that
space is not always reserved for all of the registers, so we can't
always count on them being saved after a task switch.

Eric

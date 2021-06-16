Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74A3A9E9B
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbhFPPJv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 11:09:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49108 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhFPPJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 11:09:51 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltX8i-0011K6-L6; Wed, 16 Jun 2021 09:07:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltX8g-00FrFA-Ab; Wed, 16 Jun 2021 09:07:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
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
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
References: <87sg1p30a1.fsf@disp2133>
        <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
        <87pmwsytb3.fsf@disp2133>
        <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
        <87eed4v2dc.fsf@disp2133>
        <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com>
        <87fsxjorgs.fsf@disp2133>
        <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
Date:   Wed, 16 Jun 2021 10:06:56 -0500
In-Reply-To: <CAHk-=wj5cJjpjAmDptmP9u4__6p3Y93SCQHG8Ef4+h=cnLiCsA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 15 Jun 2021 14:58:12 -0700")
Message-ID: <87mtrplugf.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltX8g-00FrFA-Ab;;;mid=<87mtrplugf.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18nS3lgdCF5xGbxXWl1AqbEgD3hNQUW+UQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1133 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (0.9%), b_tie_ro: 9 (0.8%), parse: 0.96 (0.1%),
         extract_message_metadata: 14 (1.3%), get_uri_detail_list: 1.87 (0.2%),
         tests_pri_-1000: 25 (2.2%), tests_pri_-950: 1.22 (0.1%),
        tests_pri_-900: 1.01 (0.1%), tests_pri_-90: 724 (63.9%), check_bayes:
        722 (63.7%), b_tokenize: 9 (0.8%), b_tok_get_all: 600 (52.9%),
        b_comp_prob: 6 (0.5%), b_tok_touch_all: 103 (9.1%), b_finish: 1.02
        (0.1%), tests_pri_0: 343 (30.3%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 0.83 (0.1%), tests_pri_10:
        2.0 (0.2%), tests_pri_500: 8 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jun 15, 2021 at 12:32 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> I had to update ret_from_kernel_thread to pop that state to get Linus's
>> change to boot.  Apparently kernel_threads exiting needs to be handled.
>
> You are very right.
>
> That, btw, seems to be a horrible design mistake, but I think it's how
> "kernel_execve()" works - both for the initial "init", but also for
> user-mode helper processes.
>
> Both of those cases do "kernel_thread()" to create a new thread, and
> then that new kernel thread does kernel_execve() to create the user
> space image for that thread. And that act of "execve()" clears
> PF_KTHREAD from the thread, and then the final return from the kernel
> thread function returns to that new user space.
>
> Or something like that. It's been ages since I looked at that code,
> and your patch initially confused the heck out of me because I went
> "that can't _possibly_ be needed".
>
> But yes, I think your patch is right.
>
> And I think our horrible "kernel threads return to user space when
> done" is absolutely horrifically nasty. Maybe of the clever sort, but
> mostly of the historical horror sort.
>
> Or am I mis-rememberting how this ends up working? Did you look at
> exactly what it was that returned from kernel threads?
>
> This might be worth commenting on somewhere. But your patch for alpha
> looks correct to me. Did you have some test-case to verify ptrace() on
> io worker threads?

At this point I just booted an alpha image and on qemu-system-alpha.

I do have gdb in my kernel image so I can test that.  I haven't yet but
I can and should.

Sleeping on it I came up with a plan to add TF_SWITCH_STACK_SAVED to
indicate if the registers have been saved.  The DO_SWITCH_STACK and
UNDO_SWITCH_STACK helpers (except in alpha_switch_to) can test that.
The ptrace helpers can test that and turn an access of random kernel
stack contents into something well behaved that does WARN_ON_ONCE
because we should not get there.

I suspect adding TF_SWITCH_STACK_SAVED should come first so it
is easy to verify the problem behavior, before I fix it.

My real goal is to find a pattern that architectures whose register
saves are structured like alphas can emulate, to minimize problems in
the future.

Plus I would really like to get the last handful of architectures
updated so we can remove CONFIG_HAVE_ARCH_TRACEHOOK.  I think we can
do that on alpha because we save all of the system call arguments
in pt_regs and that is all the other non-ptrace code paths care about.

AKA I am trying to move the old architectures forward so we can get rid
of unnecessary complications in the core code.

Eric

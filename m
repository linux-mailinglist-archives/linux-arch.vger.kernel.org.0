Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E693AA163
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jun 2021 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFPQf7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Jun 2021 12:35:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57454 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhFPQfH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jun 2021 12:35:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltYTI-009tP8-2t; Wed, 16 Jun 2021 10:32:56 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltYTG-000dup-Mk; Wed, 16 Jun 2021 10:32:55 -0600
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
        <87fsxjorgs.fsf@disp2133> <87zgvqor7d.fsf_-_@disp2133>
        <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
Date:   Wed, 16 Jun 2021 11:32:47 -0500
In-Reply-To: <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 15 Jun 2021 15:02:57 -0700")
Message-ID: <87mtrpg47k.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltYTG-000dup-Mk;;;mid=<87mtrpg47k.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ZfUcio+ODyoVKmYfw3++qcF8Edd+YSDo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 459 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.4 (1.0%), b_tie_ro: 3.0 (0.6%), parse: 1.20
        (0.3%), extract_message_metadata: 14 (3.0%), get_uri_detail_list: 2.3
        (0.5%), tests_pri_-1000: 19 (4.1%), tests_pri_-950: 1.00 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 118 (25.8%), check_bayes:
        117 (25.5%), b_tokenize: 7 (1.5%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 2.4 (0.5%), b_tok_touch_all: 96 (20.8%), b_finish: 0.79
        (0.2%), tests_pri_0: 288 (62.6%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.49 (0.1%), tests_pri_10:
        2.7 (0.6%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] alpha: Add extra switch_stack frames in exit, exec, and kernel threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Jun 15, 2021 at 12:36 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> I looked and there nothing I can do that is not arch specific, so
>> whack the moles with a minimal backportable fix.
>>
>> This change survives boot testing on qemu-system-alpha.
>
> So as mentioned in the other thread, I think this patch is exactly right.
>
> However, the need for this part
>
>> @@ -785,6 +785,7 @@ ret_from_kernel_thread:
>>         mov     $9, $27
>>         mov     $10, $16
>>         jsr     $26, ($9)
>> +       lda     $sp, SWITCH_STACK_SIZE($sp)
>>         br      $31, ret_to_user
>>  .end ret_from_kernel_thread
>
> obviously eluded me in my "how about something like this", and I had
> to really try to figure out why we'd ever return.
>
> Which is why I came to that "oooh - kernel_execve()" realization.
>
> It might be good to comment on that somewhere. And if you can think of
> some other case, that should be mentioned too.
>
> Anyway, thanks for looking into this odd case. And if you have a
> test-case for this all, it really would be a good thing. Yes, it
> should only affect a couple of odd-ball architectures, but still... It
> would also be good to hear that you actually did verify the behavior
> of this patch wrt that ptrace-of-io-worker-threads case..

*Grumble*

So just going through and looking to see what it takes to instrument
and put in warnings when things go wrong I have found another issue.

Today there exists:
PTRACE_EVENT_FORK
PTRACE_EVENT_VFORK
PTRACE_EVENT_CLONE

Which happens after the actual fork operation in the kernel.

The following code wraps those operations in arch/alpha/kernel/entry.S

.macro	fork_like name
	.align	4
	.globl	alpha_\name
	.ent	alpha_\name
alpha_\name:
	.prologue 0
	bsr	$1, do_switch_stack
	jsr	$26, sys_\name
	ldq	$26, 56($sp)
	lda	$sp, SWITCH_STACK_SIZE($sp)
	ret
.end	alpha_\name
.endm

The code in the kernel when calls in fork.c calls ptrace_event_pid
which ultimately calls ptrace_stop.  So userspace can reasonably expect
to stop the process and change it's registers.

With unconditionally popping the switch stack any of those registers
that are modified are lost.

So I will update my changes to handle that case as well.


Eric

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8903A6BB0
	for <lists+linux-arch@lfdr.de>; Mon, 14 Jun 2021 18:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbhFNQ3B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Jun 2021 12:29:01 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51962 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbhFNQ3A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jun 2021 12:29:00 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lspQM-00E1Ph-7M; Mon, 14 Jun 2021 10:26:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lspQL-00Bgki-8b; Mon, 14 Jun 2021 10:26:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
In-Reply-To: <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com> (Michael
        Schmitz's message of "Mon, 14 Jun 2021 17:03:32 +1200")
References: <87sg1p30a1.fsf@disp2133>
        <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
        <87pmwsytb3.fsf@disp2133>
        <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
        <87sg1lwhvm.fsf@disp2133>
        <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
        <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
        <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 14 Jun 2021 11:26:39 -0500
Message-ID: <87eed4v2dc.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lspQL-00Bgki-8b;;;mid=<87eed4v2dc.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+p8M0GsrdXS5+5TC221baY4cqTIjSrQBA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Michael Schmitz <schmitzmic@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 411 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 9 (2.3%), parse: 0.90 (0.2%),
         extract_message_metadata: 3.1 (0.7%), get_uri_detail_list: 1.28
        (0.3%), tests_pri_-1000: 4.4 (1.1%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 105 (25.5%), check_bayes:
        103 (25.1%), b_tokenize: 8 (1.9%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 81 (19.7%), b_finish: 1.07
        (0.3%), tests_pri_0: 267 (64.8%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 3.0 (0.7%), poll_dns_idle: 1.20 (0.3%), tests_pri_10:
        3.0 (0.7%), tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michael Schmitz <schmitzmic@gmail.com> writes:

> On second thought, I'm not certain what adding another empty stack frame would
> achieve here.
>
> On m68k, 'frame' already is a new stack frame, for running the new thread
> in. This new frame does not have any user context at all, and it's explicitly
> wiped anyway.
>
> Unless we save all user context on the stack, then push that context to a new
> save frame, and somehow point get_signal to look there for IO threads
> (essentially what Eric suggested), I don't see how this could work?
>
> I must be missing something.

It is only designed to work well enough so that ptrace will access
something well defined when ptrace accesses io_uring tasks.

The io_uring tasks are special in that they are user process
threads that never run in userspace.  So as long as everything
ptrace can read is accessible on that process all is well.

Having stared a bit longer at the code I think the short term
fix for both of PTRACE_EVENT_EXIT and io_uring is to guard
them both with CONFIG_HAVE_ARCH_TRACEHOOK.

Today CONFIG_HAVE_ARCH_TRACEHOOK guards access to /proc/self/syscall.
Which out of necessity ensures that user context is always readable.
Which seems to solve both the PTRACE_EVENT_EXIT and the io_uring
problems.

What I especially like about that is there are a lot of other reasons
to encourage architectures in a CONFIG_HAVE_ARCH_TRACEHOOK direction.
I think the biggies are getting architectures to store the extra
saved state on context switch into some place in task_struct
and to implement the regset view of registers.

Hmm. This is odd. CONFIG_HAVE_ARCH_TRACEHOOK is supposed to imply
CORE_DUMP_USE_REGSET.  But alpha, csky, h8300, m68k, microblaze, nds32
don't implement CORE_DUMP_USE_REGSET but nds32 implements
CONFIG_ARCH_HAVE_TRACEHOOK.

I will keep digging and see what clean code I can come up with.

Eric

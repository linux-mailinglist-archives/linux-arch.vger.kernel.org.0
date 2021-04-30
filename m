Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4CE43701ED
	for <lists+linux-arch@lfdr.de>; Fri, 30 Apr 2021 22:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbhD3UQY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 16:16:24 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60950 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbhD3UQY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Apr 2021 16:16:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcZXv-00CEwB-EO; Fri, 30 Apr 2021 14:15:31 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcZXp-0000S1-Nv; Fri, 30 Apr 2021 14:15:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
Date:   Fri, 30 Apr 2021 15:15:20 -0500
In-Reply-To: <YIxVWkT03TqcJLY3@elver.google.com> (Marco Elver's message of
        "Fri, 30 Apr 2021 21:07:06 +0200")
Message-ID: <m17dkjttpj.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lcZXp-0000S1-Nv;;;mid=<m17dkjttpj.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+N6RHdIHHOmi2pb7aC1y1Z6j2yxh0sqxg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3510]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 5048 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 10 (0.2%), b_tie_ro: 9 (0.2%), parse: 1.11 (0.0%),
         extract_message_metadata: 15 (0.3%), get_uri_detail_list: 3.5 (0.1%),
        tests_pri_-1000: 6 (0.1%), tests_pri_-950: 1.15 (0.0%),
        tests_pri_-900: 0.93 (0.0%), tests_pri_-90: 127 (2.5%), check_bayes:
        125 (2.5%), b_tokenize: 12 (0.2%), b_tok_get_all: 13 (0.3%),
        b_comp_prob: 3.5 (0.1%), b_tok_touch_all: 92 (1.8%), b_finish: 0.90
        (0.0%), tests_pri_0: 1445 (28.6%), check_dkim_signature: 0.63 (0.0%),
        check_dkim_adsp: 2.5 (0.0%), poll_dns_idle: 3410 (67.5%),
        tests_pri_10: 4.6 (0.1%), tests_pri_500: 3434 (68.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: siginfo_t ABI break on sparc64 from si_addr_lsb move 3y ago
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Fri, Apr 30, 2021 at 12:08PM -0500, Eric W. Biederman wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
> [...] 
>> >> I did a quick search and the architectures that define __ARCH_SI_TRAPNO
>> >> are sparc, mips, and alpha.  All have 64bit implementations.  A further
>> >> quick search shows that none of those architectures have faults that
>> >> use BUS_MCEERR_AR, BUS_MCEERR_AO, SEGV_BNDERR, SEGV_PKUERR, nor do
>> >> they appear to use mm/memory-failure.c
>> >>
>> >> So it doesn't look like we have an ABI regression to fix.
>> >
>> > Even better!
>> >
>> > So if sparc is the only user of _trapno and it uses none of the later
>> > fields in _sigfault, I wonder if we could take even more liberty at
>> > trying to have a slightly saner definition. Can you think of anything that
>> > might break if we put _trapno inside of the union along with _perf
>> > and _addr_lsb?
>> 
>> On sparc si_trapno is only set when SIGILL ILL_TRP is set.  So we can
>> limit si_trapno to that combination, and it should not be a problem for
>> a new signal/si_code pair to use that storage.  Precisely because it is
>> new.
>> 
>> Similarly on alpha si_trapno is only set for:
>> 
>> SIGFPE {FPE_INTOVF, FPE_INTDIV, FPE_FLTOVF, FPE_FLTDIV, FPE_FLTUND,
>> FPE_FLTINV, FPE_FLTRES, FPE_FLTUNK} and SIGTRAP {TRAP_UNK}.
>> 
>> Placing si_trapno into the union would also make the problem that the
>> union is pointer aligned a non-problem as then the union immediate
>> follows a pointer.
>> 
>> I hadn't had a chance to look before but we must deal with this.  The
>> definition of perf_sigtrap in 42dec9a936e7696bea1f27d3c5a0068cd9aa95fd
>> is broken on sparc, alpha, and ia64 as it bypasses the code in
>> kernel/signal.c that ensures the si_trapno or the ia64 special fields
>> are set.
>> 
>> Not to mention that perf_sigtrap appears to abuse si_errno.
>
> There are a few other places in the kernel that repurpose si_errno
> similarly, e.g. arch/arm64/kernel/ptrace.c, kernel/seccomp.c -- it was
> either that or introduce another field or not have it. It is likely we
> could do without, but if there are different event types the user would
> have to sacrifice a few bits of si_perf to encode the event type, and
> I'd rather keep those bits for something else. Thus the decision fell to
> use si_errno.

arm64 only abuses si_errno in compat code for bug compatibility with
arm32.

> Given it'd be wasted space otherwise, and we define the semantics of
> whatever is stored in siginfo on the new signal, it'd be good to keep.

Except you don't completely.  You are not defining a new signal.  You
are extending the definition of SIGTRAP.  Anything generic that
responds to all SIGTRAPs can reasonably be looking at si_errno.

Further you are already adding a field with si_perf you can just as
easily add a second field with well defined semantics for that data.

>> The code is only safe if the analysis that says we can move si_trapno
>> and perhaps the ia64 fields into the union is correct.  It looks like
>> ia64 much more actively uses it's signal extension fields including for
>> SIGTRAP, so I am not at all certain the generic definition of
>> perf_sigtrap is safe on ia64.
>
> Trying to understand the requirements of si_trapno myself: safe here
> would mean that si_trapno is not required if we fire our SIGTRAP /
> TRAP_PERF.
>
> As far as I can tell that is the case -- see below.
>
>> > I suppose in theory sparc64 or alpha might start using the other
>> > fields in the future, and an application might be compiled against
>> > mismatched headers, but that is unlikely and is already broken
>> > with the current headers.
>> 
>> If we localize the use of si_trapno to just a few special cases on alpha
>> and sparc I think we don't even need to worry about breaking userspace
>> on any architecture.  It will complicate siginfo_layout, but it is a
>> complication that reflects reality.
>> 
>> I don't have a clue how any of this affects ia64.  Does perf work on
>> ia64?  Does perf work on sparc, and alpha?
>> 
>> If perf works on ia64 we need to take a hard look at what is going on
>> there as well.
>
> No perf on ia64, but it seems alpha and sparc have perf:
>
> 	$ git grep 'select.*HAVE_PERF_EVENTS$' -- arch/
> 	arch/alpha/Kconfig:	select HAVE_PERF_EVENTS    <--
> 	arch/arc/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/arm/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/arm64/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/csky/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/hexagon/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/mips/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/nds32/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/parisc/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/powerpc/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/riscv/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/s390/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/sh/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/sparc/Kconfig:	select HAVE_PERF_EVENTS    <--
> 	arch/x86/Kconfig:	select HAVE_PERF_EVENTS
> 	arch/xtensa/Kconfig:	select HAVE_PERF_EVENTS
>
> Now, given ia64 is not an issue, I wanted to understand the semantics of
> si_trapno. Per https://man7.org/linux/man-pages/man2/sigaction.2.html, I
> see:
>
> 	int si_trapno;    /* Trap number that caused
> 			     hardware-generated signal
> 			     (unused on most architectures) */
>
> ... its intended semantics seem to suggest it would only be used by some
> architecture-specific signal like you identified above. So if the
> semantics is some code of a hardware trap/fault, then we're fine and do
> not need to set it.
>
> Also bearing in mind we define the semantics any new signal, and given
> most architectures do not have si_trapno, definitions of new generic
> signals should probably not include odd architecture specific details
> related to old architectures.
>
> From all this, my understanding now is that we can move si_trapno into
> the union, correct? What else did you have in mind?

Yes.  Let's move si_trapno into the union.

That implies a few things like siginfo_layout needs to change.

The helpers in kernel/signal.c can change to not imply that
if you define __ARCH_SI_TRAPNO you must always define and
pass in si_trapno.  A force_sig_trapno could be defined instead
to handle the cases that alpha and sparc use si_trapno.

It would be nice if a force_sig_perf_trap could be factored
out of perf_trap and placed in kernel/signal.c.

My experience (especially this round) is that it becomes much easier to
audit the users of siginfo if there is a dedicated function in
kernel/signal.c that is simply passed the parameters that need
to be placed in siginfo.

So I would very much like to see if I can make force_sig_info static.

Eric


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B6736EED3
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhD2RYx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 13:24:53 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43086 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbhD2RYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Apr 2021 13:24:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcAOP-00A9RZ-9c; Thu, 29 Apr 2021 11:24:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcAON-003grI-4Z; Thu, 29 Apr 2021 11:24:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        kasan-dev@googlegroups.com
References: <YIpkvGrBFGlB5vNj@elver.google.com>
Date:   Thu, 29 Apr 2021 12:23:54 -0500
In-Reply-To: <YIpkvGrBFGlB5vNj@elver.google.com> (Marco Elver's message of
        "Thu, 29 Apr 2021 09:48:12 +0200")
Message-ID: <m11rat9f85.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lcAON-003grI-4Z;;;mid=<m11rat9f85.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/NeTTsYSLfDWkTV21ICkdFJSQGTcmp1BQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0855]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1595 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.3 (0.3%), b_tie_ro: 3.0 (0.2%), parse: 1.23
        (0.1%), extract_message_metadata: 6 (0.4%), get_uri_detail_list: 3.9
        (0.2%), tests_pri_-1000: 3.4 (0.2%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.88 (0.1%), tests_pri_-90: 67 (4.2%), check_bayes: 65
        (4.1%), b_tokenize: 10 (0.6%), b_tok_get_all: 11 (0.7%), b_comp_prob:
        3.1 (0.2%), b_tok_touch_all: 38 (2.4%), b_finish: 0.68 (0.0%),
        tests_pri_0: 1497 (93.9%), check_dkim_signature: 0.43 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 0.97 (0.1%), tests_pri_10:
        1.81 (0.1%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: siginfo_t ABI break on sparc64 from si_addr_lsb move 3y ago
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Marco Elver <elver@google.com> writes:

> Hello,  Eric,
>
> By inspecting the logs I've seen that about 3 years ago there had been a
> number of siginfo_t cleanups. This included moving si_addr_lsb:
>
> 	b68a68d3dcc1 ("signal: Move addr_lsb into the _sigfault union for clarity")
> 	859d880cf544 ("signal: Correct the offset of si_pkey in struct siginfo")
>  	8420f71943ae ("signal: Correct the offset of si_pkey and si_lower in struct siginfo on m68k")
>
> In an ideal world, we could just have si_addr + the union in _sigfault,
> but it seems there are more corner cases. :-/
>
> The reason I've stumbled upon this is that I wanted to add the just
> merged si_perf [1] field to glibc. But what I noticed is that glibc's
> definition and ours are vastly different around si_addr_lsb, si_lower,
> si_upper, and si_pkey.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=42dec9a936e7696bea1f27d3c5a0068cd9aa95fd
>
> In our current definition of siginfo_t, si_addr_lsb is placed into the
> same union as si_lower, si_upper, and si_pkey (and now si_perf). From
> the logs I see that si_lower, si_upper, and si_pkey are padded because
> si_addr_lsb used to be outside the union, which goes back to
> "signal: Move addr_lsb into the _sigfault union for clarity".
>
> Since then, si_addr_lsb must also be pointer-aligned, because the union
> containing it must be pointer-aligned (because si_upper, si_lower). On
> all architectures where si_addr_lsb is right after si_addr, this is
> perfectly fine, because si_addr itself is a pointer...
>
> ... except for the anomaly that are 64-bit architectures that define
> __ARCH_SI_TRAPNO and want that 'int si_trapno'. Like, for example
> sparc64, which means siginfo_t's ABI has been subtly broken on sparc64
> since v4.16.
>
> The following static asserts illustrate this:
>
> --- a/arch/sparc/kernel/signal_64.c
> +++ b/arch/sparc/kernel/signal_64.c
> @@ -556,3 +556,37 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
>  	user_enter();
>  }
>  
> +static_assert(offsetof(siginfo_t, si_signo)	== 0);
> +static_assert(offsetof(siginfo_t, si_errno)	== 4);
> +static_assert(offsetof(siginfo_t, si_code)	== 8);
> +static_assert(offsetof(siginfo_t, si_pid)	== 16);
> +static_assert(offsetof(siginfo_t, si_uid)	== 20);
> +static_assert(offsetof(siginfo_t, si_tid)	== 16);
> +static_assert(offsetof(siginfo_t, si_overrun)	== 20);
> +static_assert(offsetof(siginfo_t, si_status)	== 24);
> +static_assert(offsetof(siginfo_t, si_utime)	== 32);
> +static_assert(offsetof(siginfo_t, si_stime)	== 40);
> +static_assert(offsetof(siginfo_t, si_value)	== 24);
> +static_assert(offsetof(siginfo_t, si_int)	== 24);
> +static_assert(offsetof(siginfo_t, si_ptr)	== 24);
> +static_assert(offsetof(siginfo_t, si_addr)	== 16);
> +static_assert(offsetof(siginfo_t, si_trapno)	== 24);
> +#if 1 /* Correct offsets, obtained from v4.14 */
> +static_assert(offsetof(siginfo_t, si_addr_lsb)	== 28);
> +static_assert(offsetof(siginfo_t, si_lower)	== 32);
> +static_assert(offsetof(siginfo_t, si_upper)	== 40);
> +static_assert(offsetof(siginfo_t, si_pkey)	== 32);
> +#else /* Current offsets, as of v4.16 */
> +static_assert(offsetof(siginfo_t, si_addr_lsb)	== 32);
> +static_assert(offsetof(siginfo_t, si_lower)	== 40);
> +static_assert(offsetof(siginfo_t, si_upper)	== 48);
> +static_assert(offsetof(siginfo_t, si_pkey)	== 40);
> +#endif
> +static_assert(offsetof(siginfo_t, si_band)	== 16);
> +static_assert(offsetof(siginfo_t, si_fd)	== 20);
>
> ---
>
> Granted, nobody seems to have noticed because I don't even know if these
> fields have use on sparc64. But I don't yet see this as justification to
> leave things as-is...
>
> The collateral damage of this, and the acute problem that I'm having is
> defining si_perf in a sort-of readable and portable way in siginfo_t
> definitions that live outside the kernel, where sparc64 does not yet
> have broken si_addr_lsb. And the same difficulty applies to the kernel
> if we want to unbreak sparc64, while not wanting to move si_perf for
> other architectures.
>
> There are 2 options I see to solve this:
>
> 1. Make things simple again. We could just revert the change moving
>    si_addr_lsb into the union, and sadly accept we'll have to live with
>    that legacy "design" mistake. (si_perf stays in the union, but will
>    unfortunately change its offset for all architectures... this one-off
>    move might be ok because it's new.)
>
> 2. Add special cases to retain si_addr_lsb in the union on architectures
>    that do not have __ARCH_SI_TRAPNO (the majority). I have added a
>    draft patch that would do this below (with some refactoring so that
>    it remains sort-of readable), as an experiment to see how complicated
>    this gets.
>
> Which option do you prefer? Are there better options?

Personally the most important thing to have is a single definition
shared by all architectures so that we consolidate testing.

A little piece of me cries a little whenever I see how badly we
implemented the POSIX design.  As specified by POSIX the fields can be
place in siginfo such that 32bit and 64bit share a common definition.
Unfortunately we did not addpadding after si_addr on 32bit to
accommodate a 64bit si_addr.

I find it unfortunate that we are adding yet another definition that
requires translation between 32bit and 64bit, but I am glad
that at least the translation is not architecture specific.  That common
definition is what has allowed this potential issue to be caught
and that makes me very happy to see.

Let's go with Option 3.

Confirm BUS_MCEERR_AR, BUS_MCEERR_AO, SEGV_BNDERR, SEGV_PKUERR are not
in use on any architecture that defines __ARCH_SI_TRAPNO, and then fixup
the userspace definitions of these fields.

To the kernel I would add some BUILD_BUG_ON's to whatever the best
maintained architecture (sparc64?) that implements __ARCH_SI_TRAPNO just
to confirm we don't create future regressions by accident.

I did a quick search and the architectures that define __ARCH_SI_TRAPNO
are sparc, mips, and alpha.  All have 64bit implementations.  A further
quick search shows that none of those architectures have faults that
use BUS_MCEERR_AR, BUS_MCEERR_AO, SEGV_BNDERR, SEGV_PKUERR, nor do
they appear to use mm/memory-failure.c

So it doesn't look like we have an ABI regression to fix.

Eric

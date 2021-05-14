Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC93812B4
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 23:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhENVQ7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 17:16:59 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53034 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhENVQ6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 May 2021 17:16:58 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lhf9s-004lat-Tn; Fri, 14 May 2021 15:15:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lhf9p-0041DZ-M9; Fri, 14 May 2021 15:15:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
        kasan-dev <kasan-dev@googlegroups.com>,
        Marco Elver <elver@google.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
        <m1r1irpc5v.fsf@fess.ebiederm.org>
        <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
        <m1czuapjpx.fsf@fess.ebiederm.org>
        <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
        <m14kfjh8et.fsf_-_@fess.ebiederm.org>
        <m1tuni8ano.fsf_-_@fess.ebiederm.org>
        <m1a6oxewym.fsf_-_@fess.ebiederm.org>
        <CAHk-=wikDD+gCUECg9NZAVSV6W_FUdyZFHzK4isfrwES_+sH-w@mail.gmail.com>
Date:   Fri, 14 May 2021 16:15:36 -0500
In-Reply-To: <CAHk-=wikDD+gCUECg9NZAVSV6W_FUdyZFHzK4isfrwES_+sH-w@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 14 May 2021 12:14:02 -0700")
Message-ID: <m14kf5aufb.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lhf9p-0041DZ-M9;;;mid=<m14kf5aufb.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+VgmiCnNh7t6EwWQgeO8qAQbN162o8ghc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1421]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 563 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.7%), parse: 1.15 (0.2%),
         extract_message_metadata: 16 (2.9%), get_uri_detail_list: 2.2 (0.4%),
        tests_pri_-1000: 23 (4.0%), tests_pri_-950: 1.33 (0.2%),
        tests_pri_-900: 1.14 (0.2%), tests_pri_-90: 67 (11.9%), check_bayes:
        66 (11.6%), b_tokenize: 10 (1.7%), b_tok_get_all: 11 (1.9%),
        b_comp_prob: 3.1 (0.5%), b_tok_touch_all: 38 (6.8%), b_finish: 0.90
        (0.2%), tests_pri_0: 425 (75.6%), check_dkim_signature: 0.93 (0.2%),
        check_dkim_adsp: 2.1 (0.4%), poll_dns_idle: 0.54 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 11 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] siginfo: ABI fixes for v5.13-rc2
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, May 13, 2021 at 9:55 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Please pull the for-v5.13-rc2 branch from the git tree:
>
> I really don't like this tree.
>
> The immediate cause for "no" is the silly
>
>  #if IS_ENABLED(CONFIG_SPARC)
>
> and
>
>  #if IS_ENABLED(CONFIG_ALPHA)
>
> code in kernel/signal.c. It has absolutely zero business being there,
> when those architectures have a perfectly fine arch/*/kernel/signal.c
> file where that code would make much more sense *WITHOUT* any odd
> preprocessor games.

The code is generic it just happens those functions are only used on
sparc and alpha.  Further I really want to make filling out siginfo_t
happen in dedicated functions as much as possible in kernel/signal.c.
The probably of getting it wrong without a helper functions is very
strong.  As the code I am fixing demonstrates.

The IS_ENABLED(arch) is mostly there so we can delete the code if/when
the architectures are retired in another decade or so.

> But there are other oddities too, like the new
>
>     send_sig_fault_trapno(SIGFPE, si_code, (void __user *) regs->pc,
> 0, current);
>
> in the alpha code, which fundamentally seems bogus: using
> send_sig_fault_trapno() with a '0' for trapno seems entirely
> incorrect, since the *ONLY* point of that function is to set si_trapno
> to something non-zero.
>
> So it would seem that a plain send_sig_fault() without that 0 would be
> the right thing to do.

As it happens the floating point emulation code on alpha is inconsistent
with the non floating point emulation code.  When using real floating
point hardware SIGFPE on alpha always set si_trapno.  The floating point
emulation code does not look like it has ever set si_trapno.

I continued to used send_sig_fault_trapno to point out that
inconsistency.

If alpha floating point emulation was in active use I expect we would
care enough to put something other than 0 in there.

> This also mixes in a lot of other stuff than just the fixes. Which
> would have been ok during the merge window, but I'm definitely not
> happy about it now.

If the breakage that came with SIGTRAP TRAP_PERF had not been discovered
during the merge window I would not be sending this now.  It took a
little time to dig to the bottom, then the code needed just a little
extra time to sit, so there were not surprises.

As for mixing things, I am not quite certain what you are referring to.
All of the changes relate to keeping people from shooting themselves
in the foot with when using siginfo.

The most noise comes from send_sig_fault vs send_sig_fault_trapno, and
force_sig_fault vs force_sig_fault_trapno.  That is fundamental to the
siginfo fix as it is there to ensure that is safe to treat si_trapno
as an ordinary _sigfault union member.  Which in turns makes alpha
and sparc no longer special with respect to _sigfault, just a little
eccentric.

I will concede that renaming SIL_PERF_EVENT to SIL_FAULT_PERF_EVENT is
unnecessary, but it certainly makes it clear that we are dealing
with _sigfault and not some other part of siginfo_t.

Eric

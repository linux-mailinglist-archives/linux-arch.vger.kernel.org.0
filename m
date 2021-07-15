Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FD03CA501
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 20:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhGOSN2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 14:13:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59026 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237256AbhGOSN1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 14:13:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:32868)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m45oe-0027Qn-3X; Thu, 15 Jul 2021 12:10:32 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:56964 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m45od-00CSsZ-3J; Thu, 15 Jul 2021 12:10:31 -0600
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
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
Date:   Thu, 15 Jul 2021 13:09:45 -0500
In-Reply-To: <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 30 Apr 2021 17:49:45 -0500")
Message-ID: <87a6mnzbx2.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m45od-00CSsZ-3J;;;mid=<87a6mnzbx2.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19QOntclRPIA/u9ynQgdmZ9S2p6E+o6EFA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_05,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0415]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 428 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.9%), b_tie_ro: 2.5 (0.6%), parse: 0.71
        (0.2%), extract_message_metadata: 2.6 (0.6%), get_uri_detail_list:
        1.07 (0.3%), tests_pri_-1000: 2.6 (0.6%), tests_pri_-950: 1.03 (0.2%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 88 (20.6%), check_bayes:
        87 (20.2%), b_tokenize: 7 (1.6%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 1.62 (0.4%), b_tok_touch_all: 68 (15.9%), b_finish: 0.82
        (0.2%), tests_pri_0: 312 (72.9%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 4.6 (1.1%), poll_dns_idle: 1.21 (0.3%), tests_pri_10:
        2.9 (0.7%), tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/6] Final si_trapno bits
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


As a part of a fix for the ABI of the newly added SIGTRAP TRAP_PERF a
si_trapno was reduced to an ordinary extention of the _sigfault case
of struct siginfo.

When Linus saw the complete set of changes come in as a fix he requested
that the set of changes be trimmed down to just what was necessary to
fix the SIGTRAP TRAP_PERF ABI.

I had intended to get the rest of the changes into the merge window for
v5.14 but I dropped the ball.

I have made the changes to stop using __ARCH_SI_TRAPNO be per
architecture so they are easier to review.  In doing so I found one
place on alpha where I used send_sig_fault instead of
send_sig_fault_trapno(... si_trapno = 0).  That would not have changed
the userspace behavior but it did make the kernel code less clear.

My rule in these patches is everywhere that siginfo layout calls
for SIL_FAULT_TRAPNO the code uses either force_sig_fault_trapno
or send_sig_fault_trapno.

And of course I have rebased and compile tested Marco's compile time
assert patches.

Eric


Eric W. Biederman (3):
      signal/sparc: si_trapno is only used with SIGILL ILL_ILLTRP
      signal/alpha: si_trapno is only used with SIGFPE and SIGTRAP TRAP_UNK
      signal: Remove the generic __ARCH_SI_TRAPNO support

Marco Elver (3):
      sparc64: Add compile-time asserts for siginfo_t offsets
      arm: Add compile-time asserts for siginfo_t offsets
      arm64: Add compile-time asserts for siginfo_t offsets

 arch/alpha/include/uapi/asm/siginfo.h |  2 --
 arch/alpha/kernel/osf_sys.c           |  2 +-
 arch/alpha/kernel/signal.c            |  4 +--
 arch/alpha/kernel/traps.c             | 26 +++++++++---------
 arch/alpha/mm/fault.c                 |  4 +--
 arch/arm/kernel/signal.c              | 37 +++++++++++++++++++++++++
 arch/arm64/kernel/signal.c            | 37 +++++++++++++++++++++++++
 arch/arm64/kernel/signal32.c          | 37 +++++++++++++++++++++++++
 arch/mips/include/uapi/asm/siginfo.h  |  2 --
 arch/sparc/include/uapi/asm/siginfo.h |  3 --
 arch/sparc/kernel/process_64.c        |  2 +-
 arch/sparc/kernel/signal32.c          | 35 +++++++++++++++++++++++
 arch/sparc/kernel/signal_64.c         | 34 +++++++++++++++++++++++
 arch/sparc/kernel/sys_sparc_32.c      |  2 +-
 arch/sparc/kernel/sys_sparc_64.c      |  2 +-
 arch/sparc/kernel/traps_32.c          | 22 +++++++--------
 arch/sparc/kernel/traps_64.c          | 44 +++++++++++++----------------
 arch/sparc/kernel/unaligned_32.c      |  2 +-
 arch/sparc/mm/fault_32.c              |  2 +-
 arch/sparc/mm/fault_64.c              |  2 +-
 include/linux/sched/signal.h          | 11 ++------
 kernel/signal.c                       | 52 ++++++++++++++++++++++++++---------
 22 files changed, 276 insertions(+), 88 deletions(-)


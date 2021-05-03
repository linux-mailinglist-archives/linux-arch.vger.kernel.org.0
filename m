Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F2F37213D
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 22:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhECU0Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 16:26:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53206 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhECU0P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 16:26:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldf84-00HHMf-1u; Mon, 03 May 2021 14:25:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldf82-00E4Fb-WD; Mon, 03 May 2021 14:25:19 -0600
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
        <m1r1irpc5v.fsf@fess.ebiederm.org>
        <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
        <m1czuapjpx.fsf@fess.ebiederm.org>
        <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
Date:   Mon, 03 May 2021 15:25:14 -0500
In-Reply-To: <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
        (Marco Elver's message of "Sat, 1 May 2021 18:24:24 +0200")
Message-ID: <m14kfjh8et.fsf_-_@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ldf82-00E4Fb-WD;;;mid=<m14kfjh8et.fsf_-_@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18lnlSrS5P8asB0qraFg/G+UpSTOXbUemI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2685]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 537 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.7%), b_tie_ro: 2.8 (0.5%), parse: 0.71
        (0.1%), extract_message_metadata: 2.9 (0.5%), get_uri_detail_list:
        1.47 (0.3%), tests_pri_-1000: 3.2 (0.6%), tests_pri_-950: 1.04 (0.2%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 210 (39.1%), check_bayes:
        209 (38.9%), b_tokenize: 7 (1.4%), b_tok_get_all: 6 (1.1%),
        b_comp_prob: 1.62 (0.3%), b_tok_touch_all: 191 (35.6%), b_finish: 0.64
        (0.1%), tests_pri_0: 301 (56.1%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.85 (0.2%), tests_pri_10:
        1.71 (0.3%), tests_pri_500: 6 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 00/12] signal: sort out si_trapno and si_perf
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


This is my attempt to sort out the ABI issues with SIGTRAP TRAP_PERF
before any userspace code starts using the new ABI.

The big ideas are:
- Placing the asserts first to prevent unexpected ABI changes
- si_trapno can become an ordinary fault subfield.
- Reworking siginfo so that si_perf_data can be a 64bit field.
- struct signalfd_siginfo is almost full

Marco I have incorporated your static_assert changes and built
on them to prevent having unexpected ABI changes.

The field si_trapno is changed to become an ordinary extension of the
_sigfault member of siginfo.

The code is refactored a bit and then si_perf_data is made a 64bit,
and si_perf_type is made distinct from si_errno.

Finally the signalfd_siginfo fields are removed as they appear to be
filling up the structure without userspace actually being able to use
them.

v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org

Eric W. Biederman (9):
      siginfo: Move si_trapno inside the union inside _si_fault
      signal: Implement SIL_FAULT_TRAPNO
      signal: Use dedicated helpers to send signals with si_trapno set
      signal: Remove __ARCH_SI_TRAPNO
      signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
      signal: Factor force_sig_perf out of perf_sigtrap
      signal: Redefine signinfo so 64bit fields are possible
      signal: Deliver all of the siginfo perf data in _perf
      signalfd: Remove SIL_FAULT_PERF_EVENT fields from signalfd_siginfo

Marco Elver (3):
      sparc64: Add compile-time asserts for siginfo_t offsets
      arm: Add compile-time asserts for siginfo_t offsets
      arm64: Add compile-time asserts for siginfo_t offsets

 arch/alpha/include/uapi/asm/siginfo.h              |   2 -
 arch/alpha/kernel/osf_sys.c                        |   2 +-
 arch/alpha/kernel/signal.c                         |   4 +-
 arch/alpha/kernel/traps.c                          |  24 ++---
 arch/alpha/mm/fault.c                              |   4 +-
 arch/arm/kernel/signal.c                           |  37 +++++++
 arch/arm64/kernel/signal.c                         |  37 +++++++
 arch/arm64/kernel/signal32.c                       |  37 +++++++
 arch/mips/include/uapi/asm/siginfo.h               |   2 -
 arch/sparc/include/uapi/asm/siginfo.h              |   3 -
 arch/sparc/kernel/process_64.c                     |   2 +-
 arch/sparc/kernel/signal32.c                       |  35 +++++++
 arch/sparc/kernel/signal_64.c                      |  34 +++++++
 arch/sparc/kernel/sys_sparc_32.c                   |   2 +-
 arch/sparc/kernel/sys_sparc_64.c                   |   2 +-
 arch/sparc/kernel/traps_32.c                       |  22 ++--
 arch/sparc/kernel/traps_64.c                       |  44 ++++----
 arch/sparc/kernel/unaligned_32.c                   |   2 +-
 arch/sparc/mm/fault_32.c                           |   2 +-
 arch/sparc/mm/fault_64.c                           |   2 +-
 arch/x86/kernel/signal_compat.c                    |  20 ++--
 fs/signalfd.c                                      |  23 ++---
 include/linux/compat.h                             |  38 ++++---
 include/linux/sched/signal.h                       |  13 +--
 include/linux/signal.h                             |   3 +-
 include/uapi/asm-generic/siginfo.h                 |  57 +++++++----
 include/uapi/linux/signalfd.h                      |   4 +-
 kernel/events/core.c                               |  11 +-
 kernel/signal.c                                    | 113 +++++++++++++--------
 .../selftests/perf_events/sigtrap_threads.c        |  12 +--
 30 files changed, 402 insertions(+), 191 deletions(-)

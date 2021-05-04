Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82473731CA
	for <lists+linux-arch@lfdr.de>; Tue,  4 May 2021 23:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhEDVOv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 May 2021 17:14:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40958 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhEDVOv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2021 17:14:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1le2Ma-001fqZ-FW; Tue, 04 May 2021 15:13:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1le2MZ-00HGan-CR; Tue, 04 May 2021 15:13:52 -0600
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
        <m14kfjh8et.fsf_-_@fess.ebiederm.org>
Date:   Tue, 04 May 2021 16:13:47 -0500
In-Reply-To: <m14kfjh8et.fsf_-_@fess.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 03 May 2021 15:25:14 -0500")
Message-ID: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1le2MZ-00HGan-CR;;;mid=<m1tuni8ano.fsf_-_@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18t2On/7dJt0RgDhiKTS9M48FC5+jx0m4U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1758]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 470 ms - load_scoreonly_sql: 0.16 (0.0%),
        signal_user_changed: 15 (3.2%), b_tie_ro: 12 (2.6%), parse: 2.2 (0.5%),
         extract_message_metadata: 8 (1.8%), get_uri_detail_list: 3.8 (0.8%),
        tests_pri_-1000: 7 (1.6%), tests_pri_-950: 2.1 (0.4%), tests_pri_-900:
        1.70 (0.4%), tests_pri_-90: 72 (15.3%), check_bayes: 69 (14.7%),
        b_tokenize: 14 (3.1%), b_tok_get_all: 10 (2.2%), b_comp_prob: 3.8
        (0.8%), b_tok_touch_all: 37 (7.8%), b_finish: 1.32 (0.3%),
        tests_pri_0: 333 (70.7%), check_dkim_signature: 1.09 (0.2%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.84 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 12 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 00/12] signal: sort out si_trapno and si_perf
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


This set of changes sorts out the ABI issues with SIGTRAP TRAP_PERF, and
hopefully will can get merged before any userspace code starts using the
new ABI.

The big ideas are:
- Placing the asserts first to prevent unexpected ABI changes
- si_trapno becomming ordinary fault subfield.
- struct signalfd_siginfo is almost full

This set of changes starts out with Marco's static_assert changes and
additional one of my own that enforces the fact that the alignment of
siginfo_t is also part of the ABI.  Together these build time
checks verify there are no unexpected ABI changes in the changes
that follow.

The field si_trapno is changed to become an ordinary extension of the
_sigfault member of siginfo.

The code is refactored a bit and then si_perf_type is added along side
si_perf_data in the _perf subfield of _sigfault of siginfo_t.

Finally the signalfd_siginfo fields are removed as they appear to be
filling up the structure without userspace actually being able to use
them.

v2: https://lkml.kernel.org/r/m14kfjh8et.fsf_-_@fess.ebiederm.org
v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org

Eric W. Biederman (9):
      signal: Verify the alignment and size of siginfo_t
      siginfo: Move si_trapno inside the union inside _si_fault
      signal: Implement SIL_FAULT_TRAPNO
      signal: Use dedicated helpers to send signals with si_trapno set
      signal: Remove __ARCH_SI_TRAPNO
      signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
      signal: Factor force_sig_perf out of perf_sigtrap
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
 arch/arm/kernel/signal.c                           |  39 +++++++
 arch/arm64/kernel/signal.c                         |  39 +++++++
 arch/arm64/kernel/signal32.c                       |  39 +++++++
 arch/mips/include/uapi/asm/siginfo.h               |   2 -
 arch/sparc/include/uapi/asm/siginfo.h              |   3 -
 arch/sparc/kernel/process_64.c                     |   2 +-
 arch/sparc/kernel/signal32.c                       |  37 +++++++
 arch/sparc/kernel/signal_64.c                      |  36 +++++++
 arch/sparc/kernel/sys_sparc_32.c                   |   2 +-
 arch/sparc/kernel/sys_sparc_64.c                   |   2 +-
 arch/sparc/kernel/traps_32.c                       |  22 ++--
 arch/sparc/kernel/traps_64.c                       |  44 ++++----
 arch/sparc/kernel/unaligned_32.c                   |   2 +-
 arch/sparc/mm/fault_32.c                           |   2 +-
 arch/sparc/mm/fault_64.c                           |   2 +-
 arch/x86/kernel/signal_compat.c                    |  15 ++-
 fs/signalfd.c                                      |  23 ++---
 include/linux/compat.h                             |  10 +-
 include/linux/sched/signal.h                       |  13 +--
 include/linux/signal.h                             |   3 +-
 include/uapi/asm-generic/siginfo.h                 |  20 ++--
 include/uapi/linux/signalfd.h                      |   4 +-
 kernel/events/core.c                               |  11 +-
 kernel/signal.c                                    | 113 +++++++++++++--------
 .../selftests/perf_events/sigtrap_threads.c        |  12 +--
 30 files changed, 373 insertions(+), 160 deletions(-)

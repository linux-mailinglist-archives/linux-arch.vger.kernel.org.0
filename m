Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D899383DED
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 21:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhEQT7T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 15:59:19 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55158 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbhEQT7S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 May 2021 15:59:18 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lijNH-009gqy-Gb; Mon, 17 May 2021 13:57:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lijMX-0001ch-UG; Mon, 17 May 2021 13:57:16 -0600
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
        <m1tuni8ano.fsf_-_@fess.ebiederm.org>
Date:   Mon, 17 May 2021 14:56:54 -0500
In-Reply-To: <m1tuni8ano.fsf_-_@fess.ebiederm.org> (Eric W. Biederman's
        message of "Tue, 04 May 2021 16:13:47 -0500")
Message-ID: <m1a6ot5e2h.fsf_-_@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lijMX-0001ch-UG;;;mid=<m1a6ot5e2h.fsf_-_@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19wgF5urIEeuZov1TyNkbEl+ZRf8d7DJfI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4155]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 379 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.6 (1.2%), b_tie_ro: 3.1 (0.8%), parse: 1.13
        (0.3%), extract_message_metadata: 4.9 (1.3%), get_uri_detail_list: 2.6
        (0.7%), tests_pri_-1000: 3.5 (0.9%), tests_pri_-950: 1.07 (0.3%),
        tests_pri_-900: 0.89 (0.2%), tests_pri_-90: 53 (14.1%), check_bayes:
        52 (13.7%), b_tokenize: 7 (1.7%), b_tok_get_all: 9 (2.4%),
        b_comp_prob: 1.89 (0.5%), b_tok_touch_all: 32 (8.3%), b_finish: 0.72
        (0.2%), tests_pri_0: 293 (77.5%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.5 (0.7%), poll_dns_idle: 1.16 (0.3%), tests_pri_10:
        2.7 (0.7%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 0/5] siginfo: ABI fixes for TRAP_PERF
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


During the merge window an issue with si_perf and the siginfo ABI came
up.  The alpha and sparc siginfo structure layout had changed with the
addition of SIGTRAP TRAP_PERF and the new field si_perf.

The reason only alpha and sparc were affected is that they are the
only architectures that use si_trapno.

Looking deeper it was discovered that si_trapno is used for only
a few select signals on alpha and sparc, and that none of the
other _sigfault fields past si_addr are used at all.  Which means
technically no regression on alpha and sparc.

While the alignment concerns might be dismissed the abuse of
si_errno by SIGTRAP TRAP_PERF does have the potential to cause
regressions in existing userspace.

While we still have time before userspace starts using and depending on
the new definition siginfo for SIGTRAP TRAP_PERF this set of changes
cleans up siginfo_t.

- The si_trapno field is demoted from magic alpha and sparc status and
  made an ordinary union member of the _sigfault member of siginfo_t.
  Without moving it of course.

- si_perf is replaced with si_perf_data and si_perf_type ending the
  abuse of si_errno.

- Unnecessary additions to signalfd_siginfo are removed.

v3: https://lkml.kernel.org/r/m1tuni8ano.fsf_-_@fess.ebiederm.org
v2: https://lkml.kernel.org/r/m14kfjh8et.fsf_-_@fess.ebiederm.org
v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org

This version drops the tests and fine grained handling of si_trapno
on alpha and sparc (replaced assuming si_trapno is valid for
all but the faults that defined different data).

Eric W. Biederman (5):
      siginfo: Move si_trapno inside the union inside _si_fault
      signal: Implement SIL_FAULT_TRAPNO
      signal: Factor force_sig_perf out of perf_sigtrap
      signal: Deliver all of the siginfo perf data in _perf
      signalfd: Remove SIL_PERF_EVENT fields from signalfd_siginfo


 arch/m68k/kernel/signal.c                          |  3 +-
 arch/x86/kernel/signal_compat.c                    |  9 +++-
 fs/signalfd.c                                      | 23 ++++-----
 include/linux/compat.h                             | 10 ++--
 include/linux/sched/signal.h                       |  1 +
 include/linux/signal.h                             |  1 +
 include/uapi/asm-generic/siginfo.h                 | 15 +++---
 include/uapi/linux/perf_event.h                    |  2 +-
 include/uapi/linux/signalfd.h                      |  4 +-
 kernel/events/core.c                               | 11 +---
 kernel/signal.c                                    | 59 +++++++++++++---------
 .../selftests/perf_events/sigtrap_threads.c        | 14 ++---
 12 files changed, 79 insertions(+), 73 deletions(-)

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2B38C9A0
	for <lists+linux-arch@lfdr.de>; Fri, 21 May 2021 17:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhEUPBr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 11:01:47 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53054 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhEUPBq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 May 2021 11:01:46 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lk6dE-000nKQ-1q; Fri, 21 May 2021 09:00:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lk6dC-0003f1-Vb; Fri, 21 May 2021 09:00:07 -0600
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
Date:   Fri, 21 May 2021 09:59:53 -0500
In-Reply-To: <m1a6oxewym.fsf_-_@fess.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 13 May 2021 23:54:57 -0500")
Message-ID: <m1cztkyvx2.fsf_-_@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lk6dC-0003f1-Vb;;;mid=<m1cztkyvx2.fsf_-_@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19vlB2vASomz6xcEqWSw3QLQjrCqAtSYto=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4356]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 460 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (2.0%), parse: 0.98 (0.2%),
         extract_message_metadata: 4.7 (1.0%), get_uri_detail_list: 2.6 (0.6%),
         tests_pri_-1000: 4.3 (0.9%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 62 (13.4%), check_bayes:
        60 (13.1%), b_tokenize: 10 (2.2%), b_tok_get_all: 11 (2.3%),
        b_comp_prob: 2.7 (0.6%), b_tok_touch_all: 33 (7.2%), b_finish: 0.92
        (0.2%), tests_pri_0: 357 (77.7%), check_dkim_signature: 0.97 (0.2%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.64 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] siginfo: ABI fixes for v5.13-rc3
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Linus,

Please pull the for-v5.13-rc3 branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.13-rc3

  HEAD: 922e3013046b79b444c87eda5baf43afae1326a8 signalfd: Remove SIL_FAULT_PERF_EVENT fields from signalfd_siginfo


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

v4: https://lkml.kernel.org/r/m1a6ot5e2h.fsf_-_@fess.ebiederm.org
v3: https://lkml.kernel.org/r/m1tuni8ano.fsf_-_@fess.ebiederm.org
v2: https://lkml.kernel.org/r/m14kfjh8et.fsf_-_@fess.ebiederm.org
v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org

This version drops the tests and fine grained handling of si_trapno
on alpha and sparc (replaced assuming si_trapno is valid for
all but the faults that defined different data).

Hopefully this is enough to not be scary as a fix for the ABI issues.

Tested-by: Marco Elver <elver@google.com>

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

Eric

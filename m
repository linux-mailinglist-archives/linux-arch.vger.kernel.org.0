Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BC6370439
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 01:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhD3XtK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 19:49:10 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:36550 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhD3XtK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Apr 2021 19:49:10 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lccra-004FDQ-6Q; Fri, 30 Apr 2021 17:48:02 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lccrY-007K7B-6o; Fri, 30 Apr 2021 17:48:01 -0600
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
Date:   Fri, 30 Apr 2021 18:47:56 -0500
In-Reply-To: <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 30 Apr 2021 17:49:45 -0500")
Message-ID: <m1r1irpc5v.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lccrY-007K7B-6o;;;mid=<m1r1irpc5v.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ymAofLNxA6qk5cQWTdhMdZa83kQdvOUU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.7 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_XMDrugObfuBody_08,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0820]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1371 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 9 (0.7%), parse: 1.07 (0.1%),
         extract_message_metadata: 3.6 (0.3%), get_uri_detail_list: 1.30
        (0.1%), tests_pri_-1000: 4.5 (0.3%), tests_pri_-950: 1.21 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 93 (6.8%), check_bayes: 91
        (6.6%), b_tokenize: 8 (0.6%), b_tok_get_all: 8 (0.6%), b_comp_prob:
        2.1 (0.2%), b_tok_touch_all: 71 (5.2%), b_finish: 0.81 (0.1%),
        tests_pri_0: 1234 (90.0%), check_dkim_signature: 0.50 (0.0%),
        check_dkim_adsp: 2.2 (0.2%), poll_dns_idle: 0.58 (0.0%), tests_pri_10:
        3.1 (0.2%), tests_pri_500: 9 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH 0/3] signal: Move si_trapno into the _si_fault union
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Well with 7 patches instead of 3 that was a little more than I thought
I was going to send.

However that does demonstrate what I am thinking, and I think most of
the changes are reasonable at this point.

I am very curious how synchronous this all is, because if this code
is truly synchronous updating signalfd to handle this class of signal
doesn't really make sense.

If the code is not synchronous using force_sig is questionable.

Eric W. Biederman (7):
      siginfo: Move si_trapno inside the union inside _si_fault
      signal: Implement SIL_FAULT_TRAPNO
      signal: Use dedicated helpers to send signals with si_trapno set
      signal: Remove __ARCH_SI_TRAPNO
      signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
      signal: Factor force_sig_perf out of perf_sigtrap
      signal: Deliver all of the perf_data in si_perf

 arch/alpha/include/uapi/asm/siginfo.h |   2 -
 arch/alpha/kernel/osf_sys.c           |   2 +-
 arch/alpha/kernel/signal.c            |   4 +-
 arch/alpha/kernel/traps.c             |  24 ++++----
 arch/alpha/mm/fault.c                 |   4 +-
 arch/mips/include/uapi/asm/siginfo.h  |   2 -
 arch/sparc/include/uapi/asm/siginfo.h |   3 -
 arch/sparc/kernel/process_64.c        |   2 +-
 arch/sparc/kernel/sys_sparc_32.c      |   2 +-
 arch/sparc/kernel/sys_sparc_64.c      |   2 +-
 arch/sparc/kernel/traps_32.c          |  22 +++----
 arch/sparc/kernel/traps_64.c          |  44 ++++++--------
 arch/sparc/kernel/unaligned_32.c      |   2 +-
 arch/sparc/mm/fault_32.c              |   2 +-
 arch/sparc/mm/fault_64.c              |   2 +-
 fs/signalfd.c                         |  13 ++--
 include/linux/compat.h                |   9 +--
 include/linux/sched/signal.h          |  13 ++--
 include/linux/signal.h                |   3 +-
 include/uapi/asm-generic/siginfo.h    |  11 ++--
 include/uapi/linux/signalfd.h         |   4 +-
 kernel/events/core.c                  |  11 +---
 kernel/signal.c                       | 108 ++++++++++++++++++++++------------
 23 files changed, 149 insertions(+), 142 deletions(-)

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1EF3703B4
	for <lists+linux-arch@lfdr.de>; Sat,  1 May 2021 00:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhD3Wul (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 18:50:41 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:56124 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhD3Wul (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Apr 2021 18:50:41 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcbxF-004Atp-LD; Fri, 30 Apr 2021 16:49:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lcbxF-00038q-0D; Fri, 30 Apr 2021 16:49:49 -0600
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
Date:   Fri, 30 Apr 2021 17:49:45 -0500
In-Reply-To: <YIxVWkT03TqcJLY3@elver.google.com> (Marco Elver's message of
        "Fri, 30 Apr 2021 21:07:06 +0200")
Message-ID: <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lcbxF-00038q-0D;;;mid=<m1zgxfs7zq.fsf_-_@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194HKcbJ3hzROboO3aXmacGQftTa4VgQr0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2038]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 317 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (3.3%), b_tie_ro: 9 (2.9%), parse: 0.77 (0.2%),
         extract_message_metadata: 2.4 (0.8%), get_uri_detail_list: 0.60
        (0.2%), tests_pri_-1000: 4.2 (1.3%), tests_pri_-950: 1.24 (0.4%),
        tests_pri_-900: 1.01 (0.3%), tests_pri_-90: 84 (26.5%), check_bayes:
        83 (26.0%), b_tokenize: 6 (2.0%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 1.54 (0.5%), b_tok_touch_all: 65 (20.5%), b_finish: 0.96
        (0.3%), tests_pri_0: 183 (57.8%), check_dkim_signature: 0.53 (0.2%),
        check_dkim_adsp: 2.6 (0.8%), poll_dns_idle: 0.48 (0.2%), tests_pri_10:
        7 (2.3%), tests_pri_500: 14 (4.5%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH 0/3] signal: Move si_trapno into the _si_fault union
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Eric W. Biederman (3):
      siginfo: Move si_trapno inside the union inside _si_fault
      signal: Implement SIL_FAULT_TRAPNO
      signal: Use dedicated helpers to send signals with si_trapno set

 arch/alpha/kernel/osf_sys.c        |  2 +-
 arch/alpha/kernel/signal.c         |  4 +-
 arch/alpha/kernel/traps.c          | 24 ++++++------
 arch/alpha/mm/fault.c              |  4 +-
 arch/sparc/kernel/process_64.c     |  2 +-
 arch/sparc/kernel/sys_sparc_32.c   |  2 +-
 arch/sparc/kernel/sys_sparc_64.c   |  2 +-
 arch/sparc/kernel/traps_32.c       | 22 +++++------
 arch/sparc/kernel/traps_64.c       | 44 ++++++++++------------
 arch/sparc/kernel/unaligned_32.c   |  2 +-
 arch/sparc/mm/fault_32.c           |  2 +-
 arch/sparc/mm/fault_64.c           |  2 +-
 fs/signalfd.c                      |  7 +---
 include/linux/compat.h             |  4 +-
 include/linux/sched/signal.h       | 12 ++----
 include/linux/signal.h             |  1 +
 include/uapi/asm-generic/siginfo.h |  6 +--
 kernel/signal.c                    | 77 ++++++++++++++++++++++----------------
 18 files changed, 107 insertions(+), 112 deletions(-)


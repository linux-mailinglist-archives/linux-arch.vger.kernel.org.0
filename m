Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BC53CA506
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbhGOSOK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 14:14:10 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:46070 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237419AbhGOSOJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 14:14:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m45pJ-009SpU-G8; Thu, 15 Jul 2021 12:11:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57000 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m45pI-00CT5W-8X; Thu, 15 Jul 2021 12:11:13 -0600
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
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <87a6mnzbx2.fsf_-_@disp2133>
Date:   Thu, 15 Jul 2021 13:11:05 -0500
In-Reply-To: <87a6mnzbx2.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 15 Jul 2021 13:09:45 -0500")
Message-ID: <874kcvzbuu.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m45pI-00CT5W-8X;;;mid=<874kcvzbuu.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18a4jAe8ApXzxWke88h7F8ue9rCS+qLdbk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 
X-Spam-Combo: **;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 556 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (0.7%), b_tie_ro: 2.9 (0.5%), parse: 1.21
        (0.2%), extract_message_metadata: 15 (2.7%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-1000: 13 (2.4%), tests_pri_-950: 1.05 (0.2%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 102 (18.3%), check_bayes:
        95 (17.2%), b_tokenize: 10 (1.8%), b_tok_get_all: 8 (1.4%),
        b_comp_prob: 1.54 (0.3%), b_tok_touch_all: 73 (13.2%), b_finish: 0.68
        (0.1%), tests_pri_0: 408 (73.4%), check_dkim_signature: 0.42 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        1.74 (0.3%), tests_pri_500: 6 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/6] sparc64: Add compile-time asserts for siginfo_t offsets
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marco Elver <elver@google.com>

To help catch ABI breaks at compile-time, add compile-time assertions to
verify the siginfo_t layout. Unlike other architectures, sparc64 is
special, because it is one of few architectures requiring si_trapno.
ABI breaks around that field would only be caught here.

Link: https://lkml.kernel.org/r/m11rat9f85.fsf@fess.ebiederm.org
Link: https://lkml.kernel.org/r/20210429190734.624918-1-elver@google.com
Link: https://lkml.kernel.org/r/20210505141101.11519-1-ebiederm@xmission.com
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/sparc/kernel/signal32.c  | 35 +++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/signal_64.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index e9695a06492f..65fd26ae9d25 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -745,3 +745,38 @@ asmlinkage int do_sys32_sigstack(u32 u_ssptr, u32 u_ossptr, unsigned long sp)
 out:
 	return ret;
 }
+
+/*
+ * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
+ * changes likely come with new fields that should be added below.
+ */
+static_assert(NSIGILL	== 11);
+static_assert(NSIGFPE	== 15);
+static_assert(NSIGSEGV	== 9);
+static_assert(NSIGBUS	== 5);
+static_assert(NSIGTRAP	== 6);
+static_assert(NSIGCHLD	== 6);
+static_assert(NSIGSYS	== 2);
+static_assert(offsetof(compat_siginfo_t, si_signo)	== 0x00);
+static_assert(offsetof(compat_siginfo_t, si_errno)	== 0x04);
+static_assert(offsetof(compat_siginfo_t, si_code)	== 0x08);
+static_assert(offsetof(compat_siginfo_t, si_pid)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_uid)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_tid)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_overrun)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_status)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_utime)	== 0x18);
+static_assert(offsetof(compat_siginfo_t, si_stime)	== 0x1c);
+static_assert(offsetof(compat_siginfo_t, si_value)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_int)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_ptr)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_addr)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_trapno)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_addr_lsb)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_lower)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x18);
+static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_perf_data)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_perf_type)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
+static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index a0eec62c825d..a58e0cc45d24 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -556,3 +556,37 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
 	user_enter();
 }
 
+/*
+ * Compile-time assertions for siginfo_t offsets. Check NSIG* as well, as
+ * changes likely come with new fields that should be added below.
+ */
+static_assert(NSIGILL	== 11);
+static_assert(NSIGFPE	== 15);
+static_assert(NSIGSEGV	== 9);
+static_assert(NSIGBUS	== 5);
+static_assert(NSIGTRAP	== 6);
+static_assert(NSIGCHLD	== 6);
+static_assert(NSIGSYS	== 2);
+static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
+static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
+static_assert(offsetof(siginfo_t, si_code)	== 0x08);
+static_assert(offsetof(siginfo_t, si_pid)	== 0x10);
+static_assert(offsetof(siginfo_t, si_uid)	== 0x14);
+static_assert(offsetof(siginfo_t, si_tid)	== 0x10);
+static_assert(offsetof(siginfo_t, si_overrun)	== 0x14);
+static_assert(offsetof(siginfo_t, si_status)	== 0x18);
+static_assert(offsetof(siginfo_t, si_utime)	== 0x20);
+static_assert(offsetof(siginfo_t, si_stime)	== 0x28);
+static_assert(offsetof(siginfo_t, si_value)	== 0x18);
+static_assert(offsetof(siginfo_t, si_int)	== 0x18);
+static_assert(offsetof(siginfo_t, si_ptr)	== 0x18);
+static_assert(offsetof(siginfo_t, si_addr)	== 0x10);
+static_assert(offsetof(siginfo_t, si_trapno)	== 0x18);
+static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x18);
+static_assert(offsetof(siginfo_t, si_lower)	== 0x20);
+static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
+static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
+static_assert(offsetof(siginfo_t, si_perf_data)	== 0x18);
+static_assert(offsetof(siginfo_t, si_perf_type)	== 0x20);
+static_assert(offsetof(siginfo_t, si_band)	== 0x10);
+static_assert(offsetof(siginfo_t, si_fd)	== 0x14);
-- 
2.20.1


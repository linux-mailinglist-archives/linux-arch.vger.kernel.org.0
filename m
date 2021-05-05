Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37821373D21
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhEEOML (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 10:12:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:57900 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbhEEOMK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 10:12:10 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIF7-002t67-5Z; Wed, 05 May 2021 08:11:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIF5-00007y-UW; Wed, 05 May 2021 08:11:12 -0600
From:   "Eric W. Beiderman" <ebiederm@xmission.com>
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
        kasan-dev <kasan-dev@googlegroups.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Date:   Wed,  5 May 2021 09:10:51 -0500
Message-Id: <20210505141101.11519-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210505141101.11519-1-ebiederm@xmission.com>
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <20210505141101.11519-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1leIF5-00007y-UW;;;mid=<20210505141101.11519-2-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18/u+QRnS8C937fZUCkilLDlSg2BWeDY0E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 565 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (1.7%), b_tie_ro: 8 (1.5%), parse: 1.59 (0.3%),
         extract_message_metadata: 20 (3.6%), get_uri_detail_list: 3.1 (0.5%),
        tests_pri_-1000: 22 (3.9%), tests_pri_-950: 2.2 (0.4%),
        tests_pri_-900: 1.79 (0.3%), tests_pri_-90: 74 (13.1%), check_bayes:
        72 (12.7%), b_tokenize: 16 (2.8%), b_tok_get_all: 8 (1.4%),
        b_comp_prob: 3.3 (0.6%), b_tok_touch_all: 41 (7.3%), b_finish: 0.98
        (0.2%), tests_pri_0: 414 (73.3%), check_dkim_signature: 0.93 (0.2%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.33 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 12 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 02/12] arm: Add compile-time asserts for siginfo_t offsets
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Marco Elver <elver@google.com>

To help catch ABI breaks at compile-time, add compile-time assertions to
verify the siginfo_t layout.

This could have caught that we cannot portably add 64-bit integers to
siginfo_t on 32-bit architectures like Arm before reaching -next:
https://lkml.kernel.org/r/20210422191823.79012-1-elver@google.com

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/arm/kernel/signal.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a3a38d0a4c85..2dac5d2c5cf6 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -725,3 +725,39 @@ asmlinkage void do_rseq_syscall(struct pt_regs *regs)
 	rseq_syscall(regs);
 }
 #endif
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
+static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
+static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
+static_assert(offsetof(siginfo_t, si_code)	== 0x08);
+static_assert(offsetof(siginfo_t, si_pid)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_uid)	== 0x10);
+static_assert(offsetof(siginfo_t, si_tid)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_overrun)	== 0x10);
+static_assert(offsetof(siginfo_t, si_status)	== 0x14);
+static_assert(offsetof(siginfo_t, si_utime)	== 0x18);
+static_assert(offsetof(siginfo_t, si_stime)	== 0x1c);
+static_assert(offsetof(siginfo_t, si_value)	== 0x14);
+static_assert(offsetof(siginfo_t, si_int)	== 0x14);
+static_assert(offsetof(siginfo_t, si_ptr)	== 0x14);
+static_assert(offsetof(siginfo_t, si_addr)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x10);
+static_assert(offsetof(siginfo_t, si_lower)	== 0x14);
+static_assert(offsetof(siginfo_t, si_upper)	== 0x18);
+static_assert(offsetof(siginfo_t, si_pkey)	== 0x14);
+static_assert(offsetof(siginfo_t, si_perf)	== 0x10);
+static_assert(offsetof(siginfo_t, si_band)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_fd)	== 0x10);
+static_assert(offsetof(siginfo_t, si_call_addr)	== 0x0c);
+static_assert(offsetof(siginfo_t, si_syscall)	== 0x10);
+static_assert(offsetof(siginfo_t, si_arch)	== 0x14);
-- 
2.30.1


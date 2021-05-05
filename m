Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C173373D39
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhEEOMf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 10:12:35 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58218 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhEEOM2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 10:12:28 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFO-002tHS-CH; Wed, 05 May 2021 08:11:30 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFM-00007y-Tz; Wed, 05 May 2021 08:11:30 -0600
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
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  5 May 2021 09:10:55 -0500
Message-Id: <20210505141101.11519-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210505141101.11519-1-ebiederm@xmission.com>
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <20210505141101.11519-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1leIFM-00007y-Tz;;;mid=<20210505141101.11519-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Mk27Kgz50v/zFuZyqEhqupLhPfPDtogg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 484 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.8%), b_tie_ro: 2.8 (0.6%), parse: 0.84
        (0.2%), extract_message_metadata: 9 (1.9%), get_uri_detail_list: 2.1
        (0.4%), tests_pri_-1000: 11 (2.3%), tests_pri_-950: 1.10 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 82 (16.9%), check_bayes:
        81 (16.7%), b_tokenize: 9 (1.9%), b_tok_get_all: 7 (1.5%),
        b_comp_prob: 1.47 (0.3%), b_tok_touch_all: 61 (12.5%), b_finish: 0.65
        (0.1%), tests_pri_0: 365 (75.5%), check_dkim_signature: 0.45 (0.1%),
        check_dkim_adsp: 2.0 (0.4%), poll_dns_idle: 0.72 (0.1%), tests_pri_10:
        1.76 (0.4%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 06/12] signal: Implement SIL_FAULT_TRAPNO
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Now that si_trapno is part of the union in _si_fault and available on
all architectures, add SIL_FAULT_TRAPNO and update siginfo_layout to
return SIL_FAULT_TRAPNO when si_trapno is actually used.

Update the code that uses siginfo_layout to deal with SIL_FAULT_TRAPNO
and have the same code ignore si_trapno in in all other cases.

v1: https://lkml.kernel.org/r/m1o8dvs7s7.fsf_-_@fess.ebiederm.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/signalfd.c          |  8 +++-----
 include/linux/signal.h |  1 +
 kernel/signal.c        | 37 +++++++++++++++----------------------
 3 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 040a1142915f..e87e59581653 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -123,15 +123,13 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		 */
 	case SIL_FAULT:
 		new.ssi_addr = (long) kinfo->si_addr;
-#ifdef __ARCH_SI_TRAPNO
+		break;
+	case SIL_FAULT_TRAPNO:
+		new.ssi_addr = (long) kinfo->si_addr;
 		new.ssi_trapno = kinfo->si_trapno;
-#endif
 		break;
 	case SIL_FAULT_MCEERR:
 		new.ssi_addr = (long) kinfo->si_addr;
-#ifdef __ARCH_SI_TRAPNO
-		new.ssi_trapno = kinfo->si_trapno;
-#endif
 		new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
 		break;
 	case SIL_PERF_EVENT:
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 1e98548d7cf6..5160fd45e5ca 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -40,6 +40,7 @@ enum siginfo_layout {
 	SIL_TIMER,
 	SIL_POLL,
 	SIL_FAULT,
+	SIL_FAULT_TRAPNO,
 	SIL_FAULT_MCEERR,
 	SIL_FAULT_BNDERR,
 	SIL_FAULT_PKUERR,
diff --git a/kernel/signal.c b/kernel/signal.c
index 65888aec65a0..3d3ba7949788 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1194,6 +1194,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 	case SIL_TIMER:
 	case SIL_POLL:
 	case SIL_FAULT:
+	case SIL_FAULT_TRAPNO:
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
@@ -2527,6 +2528,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
 {
 	switch (siginfo_layout(ksig->sig, ksig->info.si_code)) {
 	case SIL_FAULT:
+	case SIL_FAULT_TRAPNO:
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
@@ -3206,6 +3208,13 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 			if ((sig == SIGBUS) &&
 			    (si_code >= BUS_MCEERR_AR) && (si_code <= BUS_MCEERR_AO))
 				layout = SIL_FAULT_MCEERR;
+			else if (IS_ENABLED(CONFIG_ALPHA) &&
+				 ((sig == SIGFPE) ||
+				  ((sig == SIGTRAP) && (si_code == TRAP_UNK))))
+				layout = SIL_FAULT_TRAPNO;
+			else if (IS_ENABLED(CONFIG_SPARC) &&
+				 (sig == SIGILL) && (si_code == ILL_ILLTRP))
+				layout = SIL_FAULT_TRAPNO;
 			else if ((sig == SIGSEGV) && (si_code == SEGV_BNDERR))
 				layout = SIL_FAULT_BNDERR;
 #ifdef SEGV_PKUERR
@@ -3317,30 +3326,22 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 		break;
 	case SIL_FAULT:
 		to->si_addr = ptr_to_compat(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
+		break;
+	case SIL_FAULT_TRAPNO:
+		to->si_addr = ptr_to_compat(from->si_addr);
 		to->si_trapno = from->si_trapno;
-#endif
 		break;
 	case SIL_FAULT_MCEERR:
 		to->si_addr = ptr_to_compat(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_addr_lsb = from->si_addr_lsb;
 		break;
 	case SIL_FAULT_BNDERR:
 		to->si_addr = ptr_to_compat(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_lower = ptr_to_compat(from->si_lower);
 		to->si_upper = ptr_to_compat(from->si_upper);
 		break;
 	case SIL_FAULT_PKUERR:
 		to->si_addr = ptr_to_compat(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_pkey = from->si_pkey;
 		break;
 	case SIL_PERF_EVENT:
@@ -3401,30 +3402,22 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 		break;
 	case SIL_FAULT:
 		to->si_addr = compat_ptr(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
+		break;
+	case SIL_FAULT_TRAPNO:
+		to->si_addr = compat_ptr(from->si_addr);
 		to->si_trapno = from->si_trapno;
-#endif
 		break;
 	case SIL_FAULT_MCEERR:
 		to->si_addr = compat_ptr(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_addr_lsb = from->si_addr_lsb;
 		break;
 	case SIL_FAULT_BNDERR:
 		to->si_addr = compat_ptr(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_lower = compat_ptr(from->si_lower);
 		to->si_upper = compat_ptr(from->si_upper);
 		break;
 	case SIL_FAULT_PKUERR:
 		to->si_addr = compat_ptr(from->si_addr);
-#ifdef __ARCH_SI_TRAPNO
-		to->si_trapno = from->si_trapno;
-#endif
 		to->si_pkey = from->si_pkey;
 		break;
 	case SIL_PERF_EVENT:
-- 
2.30.1


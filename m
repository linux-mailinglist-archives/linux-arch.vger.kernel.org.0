Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CED737219A
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhECUkU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 16:40:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58952 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhECUkJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 16:40:09 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldfLW-00Gyj0-Lw; Mon, 03 May 2021 14:39:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldfLU-00E76Y-3p; Mon, 03 May 2021 14:39:14 -0600
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
Date:   Mon,  3 May 2021 15:38:10 -0500
Message-Id: <20210503203814.25487-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210503203814.25487-1-ebiederm@xmission.com>
References: <m14kfjh8et.fsf_-_@fess.ebiederm.org>
 <20210503203814.25487-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ldfLU-00E76Y-3p;;;mid=<20210503203814.25487-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/sil7XAjMfE6caN/d/T+dcJfVbuHF1QAo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1918 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (0.5%), b_tie_ro: 8 (0.4%), parse: 1.44 (0.1%),
         extract_message_metadata: 14 (0.7%), get_uri_detail_list: 2.3 (0.1%),
        tests_pri_-1000: 17 (0.9%), tests_pri_-950: 1.26 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 1527 (79.6%), check_bayes:
        1525 (79.5%), b_tokenize: 13 (0.7%), b_tok_get_all: 6 (0.3%),
        b_comp_prob: 1.96 (0.1%), b_tok_touch_all: 1499 (78.2%), b_finish:
        1.06 (0.1%), tests_pri_0: 326 (17.0%), check_dkim_signature: 0.56
        (0.0%), check_dkim_adsp: 2.5 (0.1%), poll_dns_idle: 0.69 (0.0%),
        tests_pri_10: 3.1 (0.2%), tests_pri_500: 15 (0.8%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 08/12] signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

It helps to know which part of the siginfo structure the siginfo_layout
value is talking about.

v1: https://lkml.kernel.org/r/m18s4zs7nu.fsf_-_@fess.ebiederm.org
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/signalfd.c          |  2 +-
 include/linux/signal.h |  2 +-
 kernel/signal.c        | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index e87e59581653..83130244f653 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -132,7 +132,7 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		new.ssi_addr = (long) kinfo->si_addr;
 		new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
 		break;
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 		new.ssi_addr = (long) kinfo->si_addr;
 		new.ssi_perf = kinfo->si_perf;
 		break;
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 5160fd45e5ca..ed896d790e46 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -44,7 +44,7 @@ enum siginfo_layout {
 	SIL_FAULT_MCEERR,
 	SIL_FAULT_BNDERR,
 	SIL_FAULT_PKUERR,
-	SIL_PERF_EVENT,
+	SIL_FAULT_PERF_EVENT,
 	SIL_CHLD,
 	SIL_RT,
 	SIL_SYS,
diff --git a/kernel/signal.c b/kernel/signal.c
index 7eaa8d84db4c..697c5fe58db8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1198,7 +1198,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 	case SIL_SYS:
 		ret = false;
 		break;
@@ -2553,7 +2553,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 		ksig->info.si_addr = arch_untagged_si_addr(
 			ksig->info.si_addr, ksig->sig, ksig->info.si_code);
 		break;
@@ -3243,7 +3243,7 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 				layout = SIL_FAULT_PKUERR;
 #endif
 			else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
-				layout = SIL_PERF_EVENT;
+				layout = SIL_FAULT_PERF_EVENT;
 		}
 		else if (si_code <= NSIGPOLL)
 			layout = SIL_POLL;
@@ -3365,7 +3365,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 		to->si_addr = ptr_to_compat(from->si_addr);
 		to->si_pkey = from->si_pkey;
 		break;
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 		to->si_addr = ptr_to_compat(from->si_addr);
 		to->si_perf = from->si_perf;
 		break;
@@ -3441,7 +3441,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 		to->si_addr = compat_ptr(from->si_addr);
 		to->si_pkey = from->si_pkey;
 		break;
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 		to->si_addr = compat_ptr(from->si_addr);
 		to->si_perf = from->si_perf;
 		break;
-- 
2.30.1


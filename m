Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872813CBA53
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhGPQKh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jul 2021 12:10:37 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:34550 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhGPQKg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2021 12:10:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m4QNH-00EEks-IT; Fri, 16 Jul 2021 10:07:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:59864 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m4QNG-00DJ88-HV; Fri, 16 Jul 2021 10:07:39 -0600
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
Date:   Fri, 16 Jul 2021 11:07:31 -0500
In-Reply-To: <87a6mnzbx2.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 15 Jul 2021 13:09:45 -0500")
Message-ID: <87zgumw8cc.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m4QNG-00DJ88-HV;;;mid=<87zgumw8cc.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18CKNIyNviV1k7gAbzUP2/IleOeAtTE1RM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4972]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 482 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.2%), b_tie_ro: 9 (1.9%), parse: 0.91 (0.2%),
         extract_message_metadata: 13 (2.6%), get_uri_detail_list: 2.2 (0.5%),
        tests_pri_-1000: 14 (3.0%), tests_pri_-950: 1.28 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 117 (24.3%), check_bayes:
        116 (24.0%), b_tokenize: 10 (2.1%), b_tok_get_all: 8 (1.6%),
        b_comp_prob: 2.0 (0.4%), b_tok_touch_all: 92 (19.1%), b_finish: 0.94
        (0.2%), tests_pri_0: 313 (64.8%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 0.71 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 8/6] signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


It helps to know which part of the siginfo structure the siginfo_layout
value is talking about.

v1: https://lkml.kernel.org/r/m18s4zs7nu.fsf_-_@fess.ebiederm.org
v2: https://lkml.kernel.org/r/20210505141101.11519-9-ebiederm@xmission.com
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/signalfd.c          |  4 ++--
 include/linux/signal.h |  2 +-
 kernel/signal.c        | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 167b5889db4b..040e1cf90528 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -114,10 +114,10 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		break;
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 		/*
 		 * Fall through to the SIL_FAULT case.  SIL_FAULT_BNDERR,
-		 * SIL_FAULT_PKUERR, and SIL_PERF_EVENT are only
+		 * SIL_FAULT_PKUERR, and SIL_FAULT_PERF_EVENT are only
 		 * generated by faults that deliver them synchronously to
 		 * userspace.  In case someone injects one of these signals
 		 * and signalfd catches it treat it as SIL_FAULT.
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3454c7ff0778..3f96a6374e4f 100644
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
index 2181423e562a..332b21f2fe72 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1213,7 +1213,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 	case SIL_SYS:
 		ret = false;
 		break;
@@ -2580,7 +2580,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
 	case SIL_FAULT_MCEERR:
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 		ksig->info.si_addr = arch_untagged_si_addr(
 			ksig->info.si_addr, ksig->sig, ksig->info.si_code);
 		break;
@@ -3265,7 +3265,7 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 				layout = SIL_FAULT_PKUERR;
 #endif
 			else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
-				layout = SIL_PERF_EVENT;
+				layout = SIL_FAULT_PERF_EVENT;
 			else if (IS_ENABLED(CONFIG_SPARC) &&
 				 (sig == SIGILL) && (si_code == ILL_ILLTRP))
 				layout = SIL_FAULT_TRAPNO;
@@ -3394,7 +3394,7 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 		to->si_addr = ptr_to_compat(from->si_addr);
 		to->si_pkey = from->si_pkey;
 		break;
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 		to->si_addr = ptr_to_compat(from->si_addr);
 		to->si_perf_data = from->si_perf_data;
 		to->si_perf_type = from->si_perf_type;
@@ -3471,7 +3471,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 		to->si_addr = compat_ptr(from->si_addr);
 		to->si_pkey = from->si_pkey;
 		break;
-	case SIL_PERF_EVENT:
+	case SIL_FAULT_PERF_EVENT:
 		to->si_addr = compat_ptr(from->si_addr);
 		to->si_perf_data = from->si_perf_data;
 		to->si_perf_type = from->si_perf_type;
-- 
2.20.1


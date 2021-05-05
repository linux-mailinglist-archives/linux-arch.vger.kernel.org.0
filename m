Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B8B373D52
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 16:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhEEONC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 10:13:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57952 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbhEEOMo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 10:12:44 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFf-003DOB-9a; Wed, 05 May 2021 08:11:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFe-00007y-Cl; Wed, 05 May 2021 08:11:47 -0600
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
Date:   Wed,  5 May 2021 09:10:59 -0500
Message-Id: <20210505141101.11519-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210505141101.11519-1-ebiederm@xmission.com>
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <20210505141101.11519-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1leIFe-00007y-Cl;;;mid=<20210505141101.11519-10-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18/BcOddtsgsGDN6U/7RxhaSYKdZmJUfIA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 526 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 8 (1.6%), parse: 0.94 (0.2%),
         extract_message_metadata: 12 (2.2%), get_uri_detail_list: 1.83 (0.3%),
         tests_pri_-1000: 13 (2.4%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 136 (25.8%), check_bayes:
        134 (25.5%), b_tokenize: 9 (1.8%), b_tok_get_all: 7 (1.4%),
        b_comp_prob: 1.87 (0.4%), b_tok_touch_all: 112 (21.3%), b_finish: 0.89
        (0.2%), tests_pri_0: 339 (64.5%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 1.94 (0.4%), poll_dns_idle: 0.35 (0.1%),
        tests_pri_10: 2.3 (0.4%), tests_pri_500: 9 (1.7%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH v3 10/12] signal: Factor force_sig_perf out of perf_sigtrap
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Separate generating the signal from deciding it needs to be sent.

v1: https://lkml.kernel.org/r/m17dkjqqxz.fsf_-_@fess.ebiederm.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  1 +
 kernel/events/core.c         | 11 ++---------
 kernel/signal.c              | 13 +++++++++++++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7daa425f3055..1e2f61a1a512 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -318,6 +318,7 @@ int send_sig_mceerr(int code, void __user *, short, struct task_struct *);
 
 int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper);
 int force_sig_pkuerr(void __user *addr, u32 pkey);
+int force_sig_perf(void __user *addr, u32 type, u64 sig_data);
 
 int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno);
 int send_sig_fault_trapno(int sig, int code, void __user *addr, int trapno,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 928b166d888e..48ea8863183b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6394,8 +6394,6 @@ void perf_event_wakeup(struct perf_event *event)
 
 static void perf_sigtrap(struct perf_event *event)
 {
-	struct kernel_siginfo info;
-
 	/*
 	 * We'd expect this to only occur if the irq_work is delayed and either
 	 * ctx->task or current has changed in the meantime. This can be the
@@ -6410,13 +6408,8 @@ static void perf_sigtrap(struct perf_event *event)
 	if (current->flags & PF_EXITING)
 		return;
 
-	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_code = TRAP_PERF;
-	info.si_errno = event->attr.type;
-	info.si_perf = event->attr.sig_data;
-	info.si_addr = (void __user *)event->pending_addr;
-	force_sig_info(&info);
+	force_sig_perf((void __user *)event->pending_addr,
+		       event->attr.type, event->attr.sig_data);
 }
 
 static void perf_pending_event_disable(struct perf_event *event)
diff --git a/kernel/signal.c b/kernel/signal.c
index 697c5fe58db8..49560ceac048 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1753,6 +1753,19 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 }
 #endif
 
+int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGTRAP;
+	info.si_errno = type;
+	info.si_code  = TRAP_PERF;
+	info.si_addr  = addr;
+	info.si_perf  = sig_data;
+	return force_sig_info(&info);
+}
+
 #if IS_ENABLED(CONFIG_SPARC)
 int force_sig_fault_trapno(int sig, int code, void __user *addr, int trapno)
 {
-- 
2.30.1


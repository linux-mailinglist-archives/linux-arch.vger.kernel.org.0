Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63C4351BD
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbhJTRrz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:55 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43460 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhJTRrf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:35 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50546)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeL-00EwLs-CW; Wed, 20 Oct 2021 11:45:13 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeK-001NdN-BG; Wed, 20 Oct 2021 11:45:12 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 20 Oct 2021 12:43:59 -0500
Message-Id: <20211020174406.17889-13-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeK-001NdN-BG;;;mid=<20211020174406.17889-13-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/LrFZ5WNu6xf41vTwYm9k00qKFq3OyObA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 434 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (1.1%), b_tie_ro: 3.3 (0.8%), parse: 0.69
        (0.2%), extract_message_metadata: 8 (1.9%), get_uri_detail_list: 1.30
        (0.3%), tests_pri_-1000: 11 (2.5%), tests_pri_-950: 1.06 (0.2%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 96 (22.1%), check_bayes:
        94 (21.7%), b_tokenize: 6 (1.3%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 1.58 (0.4%), b_tok_touch_all: 77 (17.6%), b_finish: 0.83
        (0.2%), tests_pri_0: 301 (69.4%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.76 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 13/20] signal: Implement force_fatal_sig
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a simple helper force_fatal_sig that causes a signal to be
delivered to a process as if the signal handler was set to SIG_DFL.

Reimplement force_sigsegv based upon this new helper.  This fixes
force_sigsegv so that when it forces the default signal handler
to be used the code now forces the signal to be unblocked as well.

Reusing the tested logic in force_sig_info_to_task that was built for
force_sig_seccomp this makes the implementation trivial.

This is interesting both because it makes force_sigsegv simpler and
because there are a couple of buggy places in the kernel that call
do_exit(SIGILL) or do_exit(SIGSYS) because there is no straight
forward way today for those places to simply force the exit of a
process with the chosen signal.  Creating force_fatal_sig allows
those places to be implemented with normal signal exits.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h |  1 +
 kernel/signal.c              | 26 +++++++++++++++++---------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e5f4ce622ee6..e2dc9f119ada 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -338,6 +338,7 @@ extern int kill_pid(struct pid *pid, int sig, int priv);
 extern __must_check bool do_notify_parent(struct task_struct *, int);
 extern void __wake_up_parent(struct task_struct *p, struct task_struct *parent);
 extern void force_sig(int);
+extern void force_fatal_sig(int);
 extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f6d0f9..6a5e1802b9a2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1662,6 +1662,19 @@ void force_sig(int sig)
 }
 EXPORT_SYMBOL(force_sig);
 
+void force_fatal_sig(int sig)
+{
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code = SI_KERNEL;
+	info.si_pid = 0;
+	info.si_uid = 0;
+	force_sig_info_to_task(&info, current, true);
+}
+
 /*
  * When things go south during signal handling, we
  * will force a SIGSEGV. And if the signal that caused
@@ -1670,15 +1683,10 @@ EXPORT_SYMBOL(force_sig);
  */
 void force_sigsegv(int sig)
 {
-	struct task_struct *p = current;
-
-	if (sig == SIGSEGV) {
-		unsigned long flags;
-		spin_lock_irqsave(&p->sighand->siglock, flags);
-		p->sighand->action[sig - 1].sa.sa_handler = SIG_DFL;
-		spin_unlock_irqrestore(&p->sighand->siglock, flags);
-	}
-	force_sig(SIGSEGV);
+	if (sig == SIGSEGV)
+		force_fatal_sig(SIGSEGV);
+	else
+		force_sig(SIGSEGV);
 }
 
 int force_sig_fault_to_task(int sig, int code, void __user *addr
-- 
2.20.1


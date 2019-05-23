Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA83273CB
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfEWBGx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:06:53 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51354 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbfEWBGx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:06:53 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp8-0002L9-0G; Wed, 22 May 2019 18:43:10 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTboG-0005Z3-Oo; Wed, 22 May 2019 18:42:18 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:13 -0500
Message-Id: <20190523003916.20726-24-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTboG-0005Z3-Oo;;;mid=<20190523003916.20726-24-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/XSmEdBp3G/DfkJAV+7Yk3a+X2rFZTN9Y=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,T_TooManySym_02,
        XMNoVowels,XMSubLong,XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1510 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.9 (0.3%), b_tie_ro: 2.9 (0.2%), parse: 1.06
        (0.1%), extract_message_metadata: 13 (0.8%), get_uri_detail_list: 2.3
        (0.2%), tests_pri_-1000: 13 (0.8%), tests_pri_-950: 1.36 (0.1%),
        tests_pri_-900: 1.16 (0.1%), tests_pri_-90: 27 (1.8%), check_bayes: 25
        (1.6%), b_tokenize: 9 (0.6%), b_tok_get_all: 7 (0.5%), b_comp_prob:
        2.5 (0.2%), b_tok_touch_all: 3.0 (0.2%), b_finish: 0.96 (0.1%),
        tests_pri_0: 1432 (94.8%), check_dkim_signature: 0.64 (0.0%),
        check_dkim_adsp: 2.6 (0.2%), poll_dns_idle: 0.65 (0.0%), tests_pri_10:
        2.8 (0.2%), tests_pri_500: 12 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 23/26] signal: Move the computation of force into send_signal and correct it.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Forcing a signal or not allowing a pid namespace init to ignore
SIGKILL or SIGSTOP is more cleanly computed in send_signal.

There are two cases where we don't allow a pid namespace init
to ignore SIGKILL or SIGSTOP.  If the sending process is
from an ancestor pid namespace and as such is effectively
the god to the target process, and if the it is the kernel
that is sending the signal, not another application.

It is known that a process is from an ancestor pid namespace if
it can see it's target but it's target does not have a pid for
the sender in it's pid namespace.

It is know that a signal is sent from the kernel if si_code is set to
SI_KERNEL or info is SEND_SIG_PRIV (which ultimately generates
a signal with si_code == SI_KERNEL).

The only signals that matter are SIGKILL and SIGSTOP neither of
which can really be caught, and both of which always have a siginfo
layout that includes si_uid and si_pid.  Therefore we never need
to worry about forcing a signal when si_pid and si_uid are absent.

So handle the two special cases of info and the case when si_pid and
si_uid are present.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b2f0cf3a68aa..0da35880261e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1057,7 +1057,7 @@ static inline bool legacy_queue(struct sigpending *signals, int sig)
 }
 
 static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
-			enum pid_type type, int from_ancestor_ns)
+			enum pid_type type, bool force)
 {
 	struct sigpending *pending;
 	struct sigqueue *q;
@@ -1067,8 +1067,7 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	assert_spin_locked(&t->sighand->siglock);
 
 	result = TRACE_SIGNAL_IGNORED;
-	if (!prepare_signal(sig, t,
-			from_ancestor_ns || (info == SEND_SIG_PRIV)))
+	if (!prepare_signal(sig, t, force))
 		goto ret;
 
 	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
@@ -1198,13 +1197,17 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
 			enum pid_type type)
 {
-	int from_ancestor_ns = 0;
-
-#ifdef CONFIG_PID_NS
-	from_ancestor_ns = si_fromuser(info) &&
-			   !task_pid_nr_ns(current, task_active_pid_ns(t));
-#endif
-	if (!is_si_special(info) && has_si_pid_and_uid(info)) {
+	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
+	bool force = false;
+
+	if (info == SEND_SIG_NOINFO) {
+		/* Force if sent from an ancestor pid namespace */
+		force = !task_pid_nr_ns(current, task_active_pid_ns(t));
+	} else if (info == SEND_SIG_PRIV) {
+		/* Don't ignore kernel generated signals */
+		force = true;
+	} else if (has_si_pid_and_uid(info)) {
+		/* SIGKILL and SIGSTOP is special or has ids */
 		struct user_namespace *t_user_ns;
 
 		rcu_read_lock();
@@ -1215,10 +1218,16 @@ static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct
 		}
 		rcu_read_unlock();
 
-		if (!task_pid_nr_ns(current, task_active_pid_ns(t)))
+		/* A kernel generated signal? */
+		force = (info->si_code == SI_KERNEL);
+
+		/* From an ancestor pid namespace? */
+		if (!task_pid_nr_ns(current, task_active_pid_ns(t))) {
 			info->si_pid = 0;
+			force = true;
+		}
 	}
-	return __send_signal(sig, info, t, type, from_ancestor_ns);
+	return __send_signal(sig, info, t, type, force);
 }
 
 static void print_fatal_signal(int signr)
@@ -1509,7 +1518,7 @@ int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr,
 
 	if (sig) {
 		if (lock_task_sighand(p, &flags)) {
-			ret = __send_signal(sig, &info, p, PIDTYPE_TGID, 0);
+			ret = __send_signal(sig, &info, p, PIDTYPE_TGID, false);
 			unlock_task_sighand(p, &flags);
 		} else
 			ret = -ESRCH;
-- 
2.21.0


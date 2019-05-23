Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23ED27406
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfEWBdn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:33:43 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60467 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWBdn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:33:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp9-0008S8-4u; Wed, 22 May 2019 18:43:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTboQ-0005Z3-G8; Wed, 22 May 2019 18:42:28 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:16 -0500
Message-Id: <20190523003916.20726-27-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTboQ-0005Z3-G8;;;mid=<20190523003916.20726-27-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19OJ9Ce0yIQjk/2QJzZRWILlIU/+n3OUBA=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1414 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.8 (0.2%), b_tie_ro: 1.94 (0.1%), parse: 0.92
        (0.1%), extract_message_metadata: 12 (0.8%), get_uri_detail_list: 2.3
        (0.2%), tests_pri_-1000: 12 (0.8%), tests_pri_-950: 1.29 (0.1%),
        tests_pri_-900: 1.06 (0.1%), tests_pri_-90: 24 (1.7%), check_bayes: 23
        (1.6%), b_tokenize: 9 (0.7%), b_tok_get_all: 7 (0.5%), b_comp_prob:
        1.93 (0.1%), b_tok_touch_all: 3.3 (0.2%), b_finish: 0.59 (0.0%),
        tests_pri_0: 1348 (95.4%), check_dkim_signature: 0.60 (0.0%),
        check_dkim_adsp: 2.1 (0.2%), poll_dns_idle: 0.66 (0.0%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 26/26] signal: Remove the signal number and task parameters from force_sig_info
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

force_sig_info always delivers to the current task and the signal
parameter always matches info.si_signo.  So remove those parameters to
make it a simpler less error prone interface, and to make it clear
that none of the callers are doing anything clever.

This guarantees that force_sig_info will not grow any new buggy
callers that attempt to call force_sig on a non-current task, or that
pass an signal number that does not match info.si_signo.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ptrace.h       |  2 +-
 include/linux/sched/signal.h |  2 +-
 kernel/seccomp.c             |  2 +-
 kernel/signal.c              | 14 +++++++-------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index d5084ebd9f03..2a9df80ea887 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -355,7 +355,7 @@ static inline void user_single_step_report(struct pt_regs *regs)
 	info.si_code = SI_USER;
 	info.si_pid = 0;
 	info.si_uid = 0;
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_info(&info);
 }
 #endif
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7f872506e1de..532458698bde 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -329,7 +329,7 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr);
 
 extern int send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern void force_sigsegv(int sig);
-extern int force_sig_info(int, struct kernel_siginfo *, struct task_struct *);
+extern int force_sig_info(struct kernel_siginfo *);
 extern int __kill_pgrp_info(int sig, struct kernel_siginfo *info, struct pid *pgrp);
 extern int kill_pid_info(int sig, struct kernel_siginfo *info, struct pid *pid);
 extern int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr, struct pid *,
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 811b4a86cdf6..dba52a7db5e8 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -609,7 +609,7 @@ static void seccomp_send_sigsys(int syscall, int reason)
 {
 	struct kernel_siginfo info;
 	seccomp_init_siginfo(&info, syscall, reason);
-	force_sig_info(SIGSYS, &info, current);
+	force_sig_info(&info);
 }
 #endif	/* CONFIG_SECCOMP_FILTER */
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 0984158cd41a..ff6944e4964e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1325,9 +1325,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t)
 	return ret;
 }
 
-int force_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *t)
+int force_sig_info(struct kernel_siginfo *info)
 {
-	return force_sig_info_to_task(info, t);
+	return force_sig_info_to_task(info, current);
 }
 
 /*
@@ -1619,7 +1619,7 @@ void force_sig(int sig)
 	info.si_code = SI_KERNEL;
 	info.si_pid = 0;
 	info.si_uid = 0;
-	force_sig_info(info.si_signo, &info, current);
+	force_sig_info(&info);
 }
 EXPORT_SYMBOL(force_sig);
 
@@ -1708,7 +1708,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
 	info.si_code = code;
 	info.si_addr = addr;
 	info.si_addr_lsb = lsb;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 
 int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
@@ -1737,7 +1737,7 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
 	info.si_addr  = addr;
 	info.si_lower = lower;
 	info.si_upper = upper;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 
 #ifdef SEGV_PKUERR
@@ -1751,7 +1751,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
 	info.si_code  = SEGV_PKUERR;
 	info.si_addr  = addr;
 	info.si_pkey  = pkey;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 #endif
 
@@ -1767,7 +1767,7 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
 	info.si_errno = errno;
 	info.si_code  = TRAP_HWBKPT;
 	info.si_addr  = addr;
-	return force_sig_info(info.si_signo, &info, current);
+	return force_sig_info(&info);
 }
 
 int kill_pgrp(struct pid *pid, int sig, int priv)
-- 
2.21.0


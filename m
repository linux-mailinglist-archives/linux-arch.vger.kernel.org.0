Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA32735E
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 02:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfEWAkZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 20:40:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59646 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfEWAkZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:40:25 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbmS-0003tK-0U; Wed, 22 May 2019 18:40:24 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbmI-0005Z3-9s; Wed, 22 May 2019 18:40:23 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:38:52 -0500
Message-Id: <20190523003916.20726-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbmI-0005Z3-9s;;;mid=<20190523003916.20726-3-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18mO8Rc/7f0T4DKzMUa/Kguy9u1MYr3Uqk=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMBrknScrpt_02,XMNoVowels,XMSubLong,XM_H_QuotedFrom
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 XMBrknScrpt_02 Possible Broken Spam Script
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 9056 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.5 (0.0%), b_tie_ro: 2.4 (0.0%), parse: 1.14
        (0.0%), extract_message_metadata: 13 (0.1%), get_uri_detail_list: 3.7
        (0.0%), tests_pri_-1000: 9 (0.1%), tests_pri_-950: 1.10 (0.0%),
        tests_pri_-900: 0.84 (0.0%), tests_pri_-90: 24 (0.3%), check_bayes: 23
        (0.2%), b_tokenize: 8 (0.1%), b_tok_get_all: 7 (0.1%), b_comp_prob:
        2.2 (0.0%), b_tok_touch_all: 3.6 (0.0%), b_finish: 0.65 (0.0%),
        tests_pri_0: 1387 (15.3%), check_dkim_signature: 0.43 (0.0%),
        check_dkim_adsp: 3.2 (0.0%), poll_dns_idle: 7603 (84.0%),
        tests_pri_10: 2.7 (0.0%), tests_pri_500: 7611 (84.0%), rewrite_mail:
        0.00 (0.0%)
Subject: [REVIEW][PATCH 02/26] signal/ptrace: Simplify and fix PTRACE_KILL
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since PTRACE_KILL was introduced in 1.1.78 it has only worked if the
process is stopped in do_signal.  On a ptraced but non-stopped process
PTRACE_KILL has always returned success and done nothing.

Separate the noop case of PTRACE_KILL from the case where it does
nothing.  This fixes the fact that taking sighand lock in
ptrace_resume is not safe if the process could be in the middle of
exec or do_exit.  The current test for child->state is insufficient to
prevent that race.

With the code explicitly implementing the noop people maintaining
ptrace no longer need to worry what happens in PTRACE_KILL if the
process is not stopped.

The alternative fix is to change the implementation of PTRACE_KILL
to just be send_sig(SIGKILL, child, 1);  But I don't know if anything
depends on the current documented behavior.

Cc: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Fixes: b72c186999e6 ("ptrace: fix race between ptrace_resume() and wait_task_stopped()")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6f357f4fc859..5d6ff7040863 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -212,15 +212,18 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
  *
  * Check whether @child is being ptraced by %current and ready for further
  * ptrace operations.  If @ignore_state is %false, @child also should be in
- * %TASK_TRACED state and on return the child is guaranteed to be traced
- * and not executing.  If @ignore_state is %true, @child can be in any
- * state.
+ * %TASK_TRACED state and on succesful return the child is guaranteed to be
+ * traced and not executing.  If @ignore_state is %true, @child can be in
+ * any state on succesful return.
  *
  * CONTEXT:
  * Grabs and releases tasklist_lock and @child->sighand->siglock.
  *
  * RETURNS:
- * 0 on success, -ESRCH if %child is not ready.
+ * 0 on success,
+ * -ESRCH if %child is not traced
+ * -EAGAIN if %child can not be frozen
+ * -EBUSY if the wait for %child fails
  */
 static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
@@ -240,6 +243,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 		 * child->sighand can't be NULL, release_task()
 		 * does ptrace_unlink() before __exit_signal().
 		 */
+		ret = -EAGAIN;
 		if (ignore_state || ptrace_freeze_traced(child))
 			ret = 0;
 	}
@@ -253,7 +257,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 			 * so we should not worry about leaking __TASK_TRACED.
 			 */
 			WARN_ON(child->state == __TASK_TRACED);
-			ret = -ESRCH;
+			ret = -EBUSY;
 		}
 	}
 
@@ -1074,8 +1078,6 @@ int ptrace_request(struct task_struct *child, long request,
 		return ptrace_resume(child, request, data);
 
 	case PTRACE_KILL:
-		if (child->exit_state)	/* already dead */
-			return 0;
 		return ptrace_resume(child, request, SIGKILL);
 
 #ifdef CONFIG_HAVE_ARCH_TRACEHOOK
@@ -1147,14 +1149,17 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
 		goto out_put_task_struct;
 	}
 
-	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
-				  request == PTRACE_INTERRUPT);
-	if (ret < 0)
-		goto out_put_task_struct;
-
-	ret = arch_ptrace(child, request, addr, data);
-	if (ret || request != PTRACE_DETACH)
-		ptrace_unfreeze_traced(child);
+	ret = ptrace_check_attach(child, request == PTRACE_INTERRUPT);
+	if (!ret) {
+		ret = arch_ptrace(child, request, addr, data);
+		if (ret || request != PTRACE_DETACH)
+			ptrace_unfreeze_traced(child);
+	}
+	/* PTRACE_KILL is a noop when not attached */
+	else if ((request == PTRACE_KILL) && (ret != -ESRCH))
+		ret = 0;
+	else
+		ret = -ESRCH;
 
  out_put_task_struct:
 	put_task_struct(child);
@@ -1292,13 +1297,17 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_long_t, request, compat_long_t, pid,
 		goto out_put_task_struct;
 	}
 
-	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
-				  request == PTRACE_INTERRUPT);
+	ret = ptrace_check_attach(child, request == PTRACE_INTERRUPT);
 	if (!ret) {
 		ret = compat_arch_ptrace(child, request, addr, data);
 		if (ret || request != PTRACE_DETACH)
 			ptrace_unfreeze_traced(child);
 	}
+	/* PTRACE_KILL is a noop when not attached */
+	else if ((request == PTRACE_KILL) && (ret != -ESRCH))
+		ret = 0;
+	else
+		ret = -ESRCH;
 
  out_put_task_struct:
 	put_task_struct(child);
-- 
2.21.0


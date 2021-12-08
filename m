Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8846DCF8
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240270AbhLHUaE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:30:04 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36914 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240268AbhLHUaE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:30:04 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:44574)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WJ-004DBq-4D; Wed, 08 Dec 2021 13:26:31 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WH-00CjR6-CY; Wed, 08 Dec 2021 13:26:30 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  8 Dec 2021 14:25:28 -0600
Message-Id: <20211208202532.16409-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WH-00CjR6-CY;;;mid=<20211208202532.16409-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19fPqOMa5QVsjU3osyQefs3B3Wwj6X8s2g=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMBrknScrpt_02,XMNoVowels,
        XM_B_Investor autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_B_Investor BODY: Commonly used business phishing phrases
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 XMBrknScrpt_02 Possible Broken Spam Script
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 936 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (1.3%), b_tie_ro: 10 (1.1%), parse: 1.32
        (0.1%), extract_message_metadata: 14 (1.5%), get_uri_detail_list: 2.3
        (0.2%), tests_pri_-1000: 14 (1.5%), tests_pri_-950: 1.26 (0.1%),
        tests_pri_-900: 1.03 (0.1%), tests_pri_-90: 158 (16.8%), check_bayes:
        156 (16.7%), b_tokenize: 10 (1.0%), b_tok_get_all: 8 (0.9%),
        b_comp_prob: 2.5 (0.3%), b_tok_touch_all: 132 (14.1%), b_finish: 0.96
        (0.1%), tests_pri_0: 723 (77.2%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.7 (0.3%), poll_dns_idle: 0.87 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 8 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 06/10] exit: Implement kthread_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The way the per task_struct exit_code is used by kernel threads is not
quite compatible how it is used by userspace applications.  The low
byte of the userspace exit_code value encodes the exit signal.  While
kthreads just use the value as an int holding ordinary kernel function
exit status like -EPERM.

Add kthread_exit to clearly separate the two kinds of uses.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/kthread.h |  1 +
 kernel/kthread.c        | 23 +++++++++++++++++++----
 tools/objtool/check.c   |  1 +
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 346b0f269161..22c43d419687 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -70,6 +70,7 @@ void *kthread_probe_data(struct task_struct *k);
 int kthread_park(struct task_struct *k);
 void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
+void kthread_exit(long result) __noreturn;
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 7113003fab63..77b7c3f23f18 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -268,6 +268,21 @@ void kthread_parkme(void)
 }
 EXPORT_SYMBOL_GPL(kthread_parkme);
 
+/**
+ * kthread_exit - Cause the current kthread return @result to kthread_stop().
+ * @result: The integer value to return to kthread_stop().
+ *
+ * While kthread_exit can be called directly, it exists so that
+ * functions which do some additional work in non-modular code such as
+ * module_put_and_kthread_exit can be implemented.
+ *
+ * Does not return.
+ */
+void __noreturn kthread_exit(long result)
+{
+	do_exit(result);
+}
+
 static int kthread(void *_create)
 {
 	static const struct sched_param param = { .sched_priority = 0 };
@@ -286,13 +301,13 @@ static int kthread(void *_create)
 	done = xchg(&create->done, NULL);
 	if (!done) {
 		kfree(create);
-		do_exit(-EINTR);
+		kthread_exit(-EINTR);
 	}
 
 	if (!self) {
 		create->result = ERR_PTR(-ENOMEM);
 		complete(done);
-		do_exit(-ENOMEM);
+		kthread_exit(-ENOMEM);
 	}
 
 	self->threadfn = threadfn;
@@ -326,7 +341,7 @@ static int kthread(void *_create)
 		__kthread_parkme(self);
 		ret = threadfn(data);
 	}
-	do_exit(ret);
+	kthread_exit(ret);
 }
 
 /* called from kernel_clone() to get node information for about to be created task */
@@ -627,7 +642,7 @@ EXPORT_SYMBOL_GPL(kthread_park);
  * instead of calling wake_up_process(): the thread will exit without
  * calling threadfn().
  *
- * If threadfn() may call do_exit() itself, the caller must ensure
+ * If threadfn() may call kthread_exit() itself, the caller must ensure
  * task_struct can't go away.
  *
  * Returns the result of threadfn(), or %-EINTR if wake_up_process()
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e6ab5687770b..90108fe5610d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -168,6 +168,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"panic",
 		"do_exit",
 		"do_task_dead",
+		"kthread_exit",
 		"make_task_dead",
 		"__module_put_and_exit",
 		"complete_and_exit",
-- 
2.29.2


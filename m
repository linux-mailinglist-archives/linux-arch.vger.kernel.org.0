Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C441646DCFE
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbhLHUaS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:30:18 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:36988 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240290AbhLHUaR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:30:17 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:44904)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WW-004DD5-97; Wed, 08 Dec 2021 13:26:44 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WU-00CjR6-Sr; Wed, 08 Dec 2021 13:26:43 -0700
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
Date:   Wed,  8 Dec 2021 14:25:32 -0600
Message-Id: <20211208202532.16409-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WU-00CjR6-Sr;;;mid=<20211208202532.16409-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19UJIRM3fakm3QCfFZtxnTkDumBrYlYS6s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5014]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 813 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.2%), b_tie_ro: 8 (1.0%), parse: 0.85 (0.1%),
         extract_message_metadata: 11 (1.3%), get_uri_detail_list: 0.86 (0.1%),
         tests_pri_-1000: 14 (1.7%), tests_pri_-950: 1.27 (0.2%),
        tests_pri_-900: 1.02 (0.1%), tests_pri_-90: 143 (17.6%), check_bayes:
        141 (17.3%), b_tokenize: 6 (0.7%), b_tok_get_all: 5 (0.7%),
        b_comp_prob: 1.82 (0.2%), b_tok_touch_all: 124 (15.2%), b_finish: 1.13
        (0.1%), tests_pri_0: 620 (76.3%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.5 (0.3%), poll_dns_idle: 0.77 (0.1%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 10/10] exit/kthread: Move the exit code for kernel threads into struct kthread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The exit code of kernel threads has different semantics than the
exit_code of userspace tasks.  To avoid confusion and allow
the userspace implementation to change as needed move
the kernel thread exit code into struct kthread.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/kthread.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 8e5f44bed027..9c6c532047c4 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -52,6 +52,7 @@ struct kthread_create_info
 struct kthread {
 	unsigned long flags;
 	unsigned int cpu;
+	int result;
 	int (*threadfn)(void *);
 	void *data;
 	mm_segment_t oldfs;
@@ -287,7 +288,9 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
  */
 void __noreturn kthread_exit(long result)
 {
-	do_exit(result);
+	struct kthread *kthread = to_kthread(current);
+	kthread->result = result;
+	do_exit(0);
 }
 
 /**
@@ -679,7 +682,7 @@ int kthread_stop(struct task_struct *k)
 	kthread_unpark(k);
 	wake_up_process(k);
 	wait_for_completion(&kthread->exited);
-	ret = k->exit_code;
+	ret = kthread->result;
 	put_task_struct(k);
 
 	trace_sched_kthread_stop_ret(ret);
-- 
2.29.2


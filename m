Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BE351DA5A
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbiEFOTh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 10:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442213AbiEFOTf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:19:35 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923086929A;
        Fri,  6 May 2022 07:15:50 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56240)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmykH-007CHd-A4; Fri, 06 May 2022 08:15:49 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37210 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmykG-007Cxx-5y; Fri, 06 May 2022 08:15:48 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-arch@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Fri,  6 May 2022 09:15:12 -0500
Message-Id: <20220506141512.516114-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
References: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmykG-007Cxx-5y;;;mid=<20220506141512.516114-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19K/oVZiCW2l9YdNNLzHZzyn9V7eD5myBs=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 523 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 9 (1.7%), parse: 1.11 (0.2%),
         extract_message_metadata: 11 (2.1%), get_uri_detail_list: 0.90 (0.2%),
         tests_pri_-1000: 14 (2.6%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 220 (42.1%), check_bayes:
        217 (41.5%), b_tokenize: 6 (1.1%), b_tok_get_all: 5 (1.0%),
        b_comp_prob: 1.98 (0.4%), b_tok_touch_all: 192 (36.8%), b_finish: 1.05
        (0.2%), tests_pri_0: 236 (45.1%), check_dkim_signature: 1.35 (0.3%),
        check_dkim_adsp: 3.6 (0.7%), poll_dns_idle: 0.65 (0.1%), tests_pri_10:
        3.4 (0.7%), tests_pri_500: 23 (4.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 7/7] fork: Stop allowing kthreads to call execve
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that kernel_execve is no longer called from kernel threads stop
supporting kernel threads calling kernel_execve.

Remove the code for converting a kthread to a normal thread in execve.

Document the restriction that kthreads may not call kernel_execve by
having kernel_execve fail if called by a kthread.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 75eb6e0ee7b2..9c5260e74517 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1308,7 +1308,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out_unlock;
 
-	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
+	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC |
 					PF_NOFREEZE | PF_NO_SETAFFINITY);
 	flush_thread();
 	me->personality &= ~bprm->per_clear;
@@ -1953,8 +1953,8 @@ int kernel_execve(const char *kernel_filename,
 	int fd = AT_FDCWD;
 	int retval;
 
-	if (WARN_ON_ONCE((current->flags & PF_KTHREAD) &&
-			(current->worker_private)))
+	/* It is non-sense for kernel threads to call execve */
+	if (WARN_ON_ONCE(current->flags & PF_KTHREAD))
 		return -EINVAL;
 
 	filename = getname_kernel(kernel_filename);
-- 
2.35.3


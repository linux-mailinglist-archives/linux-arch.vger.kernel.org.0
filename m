Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9451DA5C
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 16:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442152AbiEFOTg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 10:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442207AbiEFOTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:19:34 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD566928D;
        Fri,  6 May 2022 07:15:47 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56172)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmykE-007CH6-TV; Fri, 06 May 2022 08:15:46 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37210 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmykD-007Cxx-P8; Fri, 06 May 2022 08:15:46 -0600
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
Date:   Fri,  6 May 2022 09:15:11 -0500
Message-Id: <20220506141512.516114-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
References: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmykD-007Cxx-P8;;;mid=<20220506141512.516114-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+i6APYhR/pOCN3BklB4+V7ylUJfo+qYO8=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 319 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 13 (4.1%), b_tie_ro: 11 (3.5%), parse: 1.41
        (0.4%), extract_message_metadata: 16 (5.0%), get_uri_detail_list: 1.25
        (0.4%), tests_pri_-1000: 18 (5.7%), tests_pri_-950: 1.71 (0.5%),
        tests_pri_-900: 1.44 (0.5%), tests_pri_-90: 72 (22.6%), check_bayes:
        70 (21.9%), b_tokenize: 7 (2.1%), b_tok_get_all: 5 (1.7%),
        b_comp_prob: 2.1 (0.7%), b_tok_touch_all: 52 (16.3%), b_finish: 1.18
        (0.4%), tests_pri_0: 175 (54.6%), check_dkim_signature: 0.64 (0.2%),
        check_dkim_adsp: 3.2 (1.0%), poll_dns_idle: 1.00 (0.3%), tests_pri_10:
        3.9 (1.2%), tests_pri_500: 12 (3.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 6/7] fork: Explicitly set PF_KTHREAD
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of implicitly inheriting PF_KTHREAD from the parent process
examine arguments in kernel_clone_args to see if PF_KTHREAD should be
set.  This makes knowledge of which new threads are kernel threads
explicit.

This also makes it so that init and the user mode helper processes
no longer have PF_KTHREAD set.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/fork.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 8e17c3fbce42..35645f57bd2f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2068,6 +2068,9 @@ static __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
+	p->flags &= ~PF_KTHREAD;
+	if (args->kthread)
+		p->flags |= PF_KTHREAD;
 	if (args->io_thread) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
-- 
2.35.3


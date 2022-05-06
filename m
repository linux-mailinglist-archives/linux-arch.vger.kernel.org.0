Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1813851DA58
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 16:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442166AbiEFOTh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 10:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442190AbiEFOTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 10:19:34 -0400
X-Greylist: delayed 210 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 07:15:46 PDT
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A10022BC4;
        Fri,  6 May 2022 07:15:45 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56272)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmykC-009n4e-Hs; Fri, 06 May 2022 08:15:44 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37210 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmykB-007Cxx-Eb; Fri, 06 May 2022 08:15:44 -0600
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
Date:   Fri,  6 May 2022 09:15:10 -0500
Message-Id: <20220506141512.516114-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
References: <87mtfu4up3.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmykB-007Cxx-Eb;;;mid=<20220506141512.516114-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+YtAybj6KSom4BKXaqhR+tPpLicoHoVIw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-arch@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 501 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.8%), b_tie_ro: 2.6 (0.5%), parse: 1.19
        (0.2%), extract_message_metadata: 13 (2.5%), get_uri_detail_list: 1.37
        (0.3%), tests_pri_-1000: 14 (2.9%), tests_pri_-950: 0.96 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 242 (48.3%), check_bayes:
        240 (47.9%), b_tokenize: 4.5 (0.9%), b_tok_get_all: 154 (30.6%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 76 (15.2%), b_finish: 0.91
        (0.2%), tests_pri_0: 215 (42.8%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.78 (0.2%), tests_pri_10:
        1.71 (0.3%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 5/7] init: Deal with the init process being a user mode process
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It is silly for user_mode_thread to leave PF_KTHREAD set
on the resulting task.  Update the init process so that
it does not care if PF_KTHREAD is set or not.

Ensure do_populate_rootfs flushes all delayed fput work by calling
task_work_run.  In the rare instance that async_schedule_domain calls
do_populate_rootfs synchronously it is possible do_populate_rootfs
will be called directly from the init process.  At which point fput
will call "task_work_add(current, ..., TWA_RESUME)".  The files on the
initramfs need to be completely put before we attempt to exec them
(which is before the code enters userspace).  So call task_work_run
just in case there are any pending fput operations.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 init/initramfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index 2f3d96dc3db6..41e7857d510d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/namei.h>
 #include <linux/init_syscalls.h>
+#include <linux/task_work.h>
 #include <linux/umh.h>
 
 static ssize_t __init xwrite(struct file *file, const char *p, size_t count,
@@ -703,6 +704,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	initrd_end = 0;
 
 	flush_delayed_fput();
+	task_work_run();
 }
 
 static ASYNC_DOMAIN_EXCLUSIVE(initramfs_domain);
-- 
2.35.3


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57A46DCEE
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbhLHU3s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:29:48 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39890 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbhLHU3r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:29:47 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:46500)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3W2-00GaMX-A6; Wed, 08 Dec 2021 13:26:14 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3W0-00CjR6-LV; Wed, 08 Dec 2021 13:26:13 -0700
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
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed,  8 Dec 2021 14:25:23 -0600
Message-Id: <20211208202532.16409-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3W0-00CjR6-LV;;;mid=<20211208202532.16409-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19W0IDucdFn82HV8+my8Z69nJsberZ8OwM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5036]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1021 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (1.1%), b_tie_ro: 10 (1.0%), parse: 1.25
        (0.1%), extract_message_metadata: 19 (1.8%), get_uri_detail_list: 3.6
        (0.3%), tests_pri_-1000: 21 (2.1%), tests_pri_-950: 1.34 (0.1%),
        tests_pri_-900: 1.14 (0.1%), tests_pri_-90: 182 (17.8%), check_bayes:
        179 (17.5%), b_tokenize: 10 (1.0%), b_tok_get_all: 10 (1.0%),
        b_comp_prob: 3.2 (0.3%), b_tok_touch_all: 152 (14.8%), b_finish: 0.97
        (0.1%), tests_pri_0: 760 (74.4%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 3.2 (0.3%), poll_dns_idle: 0.52 (0.1%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 19 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 01/10] exit/s390: Remove dead reference to do_exit from copy_thread
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

My s390 assembly is not particularly good so I have read the history
of the reference to do_exit copy_thread and have been able to
verify that do_exit is not used.

The general argument is that s390 has been changed to use the generic
kernel_thread and kernel_execve and the generic versions do not call
do_exit.  So it is strange to see a do_exit reference sitting there.

The history of the do_exit reference in s390's version of copy_thread
seems conclusive that the do_exit reference is something that lingers
and should have been removed several years ago.

Up through 8d19f15a60be ("[PATCH] s390 update (1/27): arch.")  the
s390 code made a call to the exit(2) system call when a kernel thread
finished.  Then kernel_thread_starter was added which branched
directly to the value in register 11 when the kernel thread finshed.
The value in register 11 was set in kernel_thread to
"regs.gprs[11] = (unsigned long) do_exit"

In commit 37fe5d41f640 ("s390: fold kernel_thread_helper() into
ret_from_fork()") kernel_thread_starter was moved into entry.S and
entry64.S unchanged (except for the syntax differences between inline
assemly and in the assembly file).

In commit f9a7e025dfc2 ("s390: switch to generic kernel_thread()") the
assignment to "gprs[11]" was moved into copy_thread from the old
kernel_thread.  The helper kernel_thread_starter was still being used
and was still branching to "%r11" at the end.

In commit 30dcb0996e40 ("s390: switch to saner kernel_execve()
semantics") kernel_thread_starter was changed to unconditionally
branch to sysc_tracenogo instead to %r11 which held the value of
do_exit.  Unfortunately copy_thread was not updated to stop passing
do_exit in "gprs[11]".

In commit 56e62a737028 ("s390: convert to generic entry")
kernel_thread_starter was replaced by __ret_from_fork.  And the code
still continued to pass do_exit in "gprs[11]" despite __ret_from_fork
not caring in the slightest.

Remove this dead reference to do_exit to make it clear that s390 is
not doing anything with do_exit in copy_thread.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: 30dcb0996e40 ("s390: switch to saner kernel_execve() semantics")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/s390/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index e8858b2de24b..71d86f73b02c 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -139,7 +139,6 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 				(unsigned long)__ret_from_fork;
 		frame->childregs.gprs[9] = new_stackp; /* function */
 		frame->childregs.gprs[10] = arg;
-		frame->childregs.gprs[11] = (unsigned long)do_exit;
 		frame->childregs.orig_gpr2 = -1;
 		frame->childregs.last_break = 1;
 		return 0;
-- 
2.29.2


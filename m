Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A587B48386F
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiACVds (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:33:48 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:45880 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiACVdq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:46 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:56440)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxd-00ET0p-J6; Mon, 03 Jan 2022 14:33:45 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxc-006zvm-Lm; Mon, 03 Jan 2022 14:33:45 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:33:02 -0600
Message-Id: <20220103213312.9144-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uxc-006zvm-Lm;;;mid=<20220103213312.9144-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18jgqYxlIKA82Fl1bV6Gg+kb1TtzswAvHE=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5108]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 289 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (3.5%), b_tie_ro: 9 (3.1%), parse: 1.09 (0.4%),
         extract_message_metadata: 13 (4.4%), get_uri_detail_list: 1.04 (0.4%),
         tests_pri_-1000: 13 (4.7%), tests_pri_-950: 1.18 (0.4%),
        tests_pri_-900: 1.00 (0.3%), tests_pri_-90: 59 (20.3%), check_bayes:
        57 (19.7%), b_tokenize: 5.0 (1.7%), b_tok_get_all: 3.8 (1.3%),
        b_comp_prob: 1.52 (0.5%), b_tok_touch_all: 44 (15.2%), b_finish: 0.86
        (0.3%), tests_pri_0: 175 (60.4%), check_dkim_signature: 0.46 (0.2%),
        check_dkim_adsp: 2.9 (1.0%), poll_dns_idle: 1.12 (0.4%), tests_pri_10:
        3.2 (1.1%), tests_pri_500: 10 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 07/17] ptrace: Remove unused regs argument from ptrace_report_syscall
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/tracehook.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 2564b7434b4d..88c007ab5ebc 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -54,8 +54,7 @@ struct linux_binprm;
 /*
  * ptrace report for syscall entry and exit looks identical.
  */
-static inline int ptrace_report_syscall(struct pt_regs *regs,
-					unsigned long message)
+static inline int ptrace_report_syscall(unsigned long message)
 {
 	int ptrace = current->ptrace;
 
@@ -102,7 +101,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs,
 static inline __must_check int tracehook_report_syscall_entry(
 	struct pt_regs *regs)
 {
-	return ptrace_report_syscall(regs, PTRACE_EVENTMSG_SYSCALL_ENTRY);
+	return ptrace_report_syscall(PTRACE_EVENTMSG_SYSCALL_ENTRY);
 }
 
 /**
@@ -127,7 +126,7 @@ static inline void tracehook_report_syscall_exit(struct pt_regs *regs, int step)
 	if (step)
 		user_single_step_report(regs);
 	else
-		ptrace_report_syscall(regs, PTRACE_EVENTMSG_SYSCALL_EXIT);
+		ptrace_report_syscall(PTRACE_EVENTMSG_SYSCALL_EXIT);
 }
 
 /**
-- 
2.29.2


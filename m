Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81D04351B5
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhJTRrn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:43 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40584 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhJTRrX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:23 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:55312)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeG-00GD0R-Q5; Wed, 20 Oct 2021 11:45:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeE-001NdN-Oo; Wed, 20 Oct 2021 11:45:07 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:43:57 -0500
Message-Id: <20211020174406.17889-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeE-001NdN-Oo;;;mid=<20211020174406.17889-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18e0W1fPCKIpQXaYALvcoXNgExLbZDy/gk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 306 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (1.3%), b_tie_ro: 2.7 (0.9%), parse: 0.65
        (0.2%), extract_message_metadata: 8 (2.7%), get_uri_detail_list: 1.29
        (0.4%), tests_pri_-1000: 10 (3.4%), tests_pri_-950: 0.98 (0.3%),
        tests_pri_-900: 0.85 (0.3%), tests_pri_-90: 60 (19.7%), check_bayes:
        59 (19.4%), b_tokenize: 5 (1.7%), b_tok_get_all: 6 (2.0%),
        b_comp_prob: 1.53 (0.5%), b_tok_touch_all: 44 (14.3%), b_finish: 0.67
        (0.2%), tests_pri_0: 211 (68.9%), check_dkim_signature: 0.57 (0.2%),
        check_dkim_adsp: 1.72 (0.6%), poll_dns_idle: 0.33 (0.1%),
        tests_pri_10: 1.73 (0.6%), tests_pri_500: 6 (1.9%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 11/20] signal/s390: Use force_sigsegv in default_trap_handler
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reading the history it is unclear why default_trap_handler calls
do_exit.  It is not even menthioned in the commit where the change
happened.  My best guess is that because it is unknown why the
exception happened it was desired to guarantee the process never
returned to userspace.

Using do_exit(SIGSEGV) has the problem that it will only terminate one
thread of a process, leaving the process in an undefined state.

Use force_sigsegv(SIGSEGV) instead which effectively has the same
behavior except that is uses the ordinary signal mechanism and
terminates all threads of a process and is generally well defined.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Fixes: ca2ab03237ec ("[PATCH] s390: core changes")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/s390/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index bcefc2173de4..51729ea2cf8e 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -84,7 +84,7 @@ static void default_trap_handler(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		report_user_fault(regs, SIGSEGV, 0);
-		do_exit(SIGSEGV);
+		force_sigsegv(SIGSEGV);
 	} else
 		die(regs, "Unknown program exception");
 }
-- 
2.20.1


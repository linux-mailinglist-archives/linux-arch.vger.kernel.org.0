Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E024351C7
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhJTRsM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:48:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43586 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhJTRrm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:42 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50678)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeZ-00EwPY-Ca; Wed, 20 Oct 2021 11:45:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeY-001NdN-Fz; Wed, 20 Oct 2021 11:45:26 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 Oct 2021 12:44:03 -0500
Message-Id: <20211020174406.17889-17-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeY-001NdN-Fz;;;mid=<20211020174406.17889-17-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19fydN7oNe1dHznpe496AKybDHaM5BFIbE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSlimDrugH,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5118]
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 252 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.3 (1.3%), b_tie_ro: 2.3 (0.9%), parse: 0.62
        (0.2%), extract_message_metadata: 7 (2.9%), get_uri_detail_list: 0.77
        (0.3%), tests_pri_-1000: 10 (4.0%), tests_pri_-950: 1.03 (0.4%),
        tests_pri_-900: 0.79 (0.3%), tests_pri_-90: 57 (22.6%), check_bayes:
        56 (22.2%), b_tokenize: 4.0 (1.6%), b_tok_get_all: 5.0 (2.0%),
        b_comp_prob: 1.20 (0.5%), b_tok_touch_all: 43 (17.0%), b_finish: 0.75
        (0.3%), tests_pri_0: 162 (64.4%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 2.6 (1.0%), poll_dns_idle: 1.25 (0.5%), tests_pri_10:
        1.77 (0.7%), tests_pri_500: 6 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 17/20] signal/x86: In emulate_vsyscall force a signal instead of calling do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Directly calling do_exit with a signal number has the problem that
all of the side effects of the signal don't happen, such as
killing all of the threads of a process instead of just the
calling thread.

So replace do_exit(SIGSYS) with force_fatal_sig(SIGSYS) which
causes the signal handling to take it's normal path and work
as expected.

Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/entry/vsyscall/vsyscall_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 1b40b9297083..0b6b277ee050 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -226,7 +226,8 @@ bool emulate_vsyscall(unsigned long error_code,
 	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
 		warn_bad_vsyscall(KERN_DEBUG, regs,
 				  "seccomp tried to change syscall nr or ip");
-		do_exit(SIGSYS);
+		force_fatal_sig(SIGSYS);
+		return true;
 	}
 	regs->orig_ax = -1;
 	if (tmp)
-- 
2.20.1


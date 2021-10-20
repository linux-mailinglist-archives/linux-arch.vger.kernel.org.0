Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457A94351AF
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhJTRrf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:35 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57116 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbhJTRrS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:18 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:52836)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeB-002tMs-4D; Wed, 20 Oct 2021 11:45:03 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFe9-001NdN-QI; Wed, 20 Oct 2021 11:45:02 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, H Peter Anvin <hpa@zytor.com>
Date:   Wed, 20 Oct 2021 12:43:55 -0500
Message-Id: <20211020174406.17889-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFe9-001NdN-QI;;;mid=<20211020174406.17889-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/qfGNFitbP+rEt0PIwwOv9c/FOp0ylaw4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5121]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 595 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.8%), b_tie_ro: 9 (1.5%), parse: 1.02 (0.2%),
         extract_message_metadata: 22 (3.7%), get_uri_detail_list: 1.46 (0.2%),
         tests_pri_-1000: 31 (5.2%), tests_pri_-950: 1.36 (0.2%),
        tests_pri_-900: 1.09 (0.2%), tests_pri_-90: 80 (13.4%), check_bayes:
        78 (13.1%), b_tokenize: 6 (1.1%), b_tok_get_all: 6 (1.0%),
        b_comp_prob: 2.1 (0.3%), b_tok_touch_all: 61 (10.2%), b_finish: 0.78
        (0.1%), tests_pri_0: 210 (35.3%), check_dkim_signature: 0.64 (0.1%),
        check_dkim_adsp: 4.8 (0.8%), poll_dns_idle: 221 (37.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 233 (39.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 09/20] signal/vm86_32: Replace open coded BUG_ON with an actual BUG_ON
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The function save_v86_state is only called when userspace was
operating in vm86 mode before entering the kernel.  Not having vm86
state in the task_struct should never happen.  So transform the hand
rolled BUG_ON into an actual BUG_ON to make it clear what is
happening.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: H Peter Anvin <hpa@zytor.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/vm86_32.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index e5a7a10a0164..63486da77272 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -106,10 +106,8 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	 */
 	local_irq_enable();
 
-	if (!vm86 || !vm86->user_vm86) {
-		pr_alert("no user_vm86: BAD\n");
-		do_exit(SIGSEGV);
-	}
+	BUG_ON(!vm86 || !vm86->user_vm86);
+
 	set_flags(regs->pt.flags, VEFLAGS, X86_EFLAGS_VIF | vm86->veflags_mask);
 	user = vm86->user_vm86;
 
-- 
2.20.1


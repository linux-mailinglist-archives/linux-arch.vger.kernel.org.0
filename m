Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC09D4351B0
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJTRrg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:36 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43380 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbhJTRrU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:20 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50330)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeD-00EwJl-HB; Wed, 20 Oct 2021 11:45:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeC-001NdN-DZ; Wed, 20 Oct 2021 11:45:05 -0600
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
Date:   Wed, 20 Oct 2021 12:43:56 -0500
Message-Id: <20211020174406.17889-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeC-001NdN-DZ;;;mid=<20211020174406.17889-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18G2X3GZ31STtzoSfrRYAGF07hVRtRDSxY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,XMNoVowels,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5098]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 404 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.6 (1.1%), b_tie_ro: 3.2 (0.8%), parse: 1.11
        (0.3%), extract_message_metadata: 21 (5.1%), get_uri_detail_list: 2.4
        (0.6%), tests_pri_-1000: 27 (6.7%), tests_pri_-950: 1.05 (0.3%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 88 (21.9%), check_bayes:
        87 (21.5%), b_tokenize: 6 (1.5%), b_tok_get_all: 7 (1.9%),
        b_comp_prob: 1.75 (0.4%), b_tok_touch_all: 68 (16.9%), b_finish: 0.79
        (0.2%), tests_pri_0: 246 (61.1%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 1.87 (0.5%), poll_dns_idle: 0.49 (0.1%),
        tests_pri_10: 2.6 (0.7%), tests_pri_500: 8 (2.0%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 10/20] signal/vm86_32: Properly send SIGSEGV when the vm86 state cannot be saved.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of pretending to send SIGSEGV by calling do_exit(SIGSEGV)
call force_sigsegv(SIGSEGV) to force the process to take a SIGSEGV
and terminate.

Update handle_signal to return immediately when save_v86_state fails
and kills the process.  Returning immediately without doing anything
except killing the process with SIGSEGV is also what signal_setup_done
does when setup_rt_frame fails.  Plus it is always ok to return
immediately without delivering a signal to a userspace handler when a
fatal signal has killed the current process.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: H Peter Anvin <hpa@zytor.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/signal.c  | 6 +++++-
 arch/x86/kernel/vm86_32.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index f4d21e470083..25a230f705c1 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -785,8 +785,12 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	bool stepping, failed;
 	struct fpu *fpu = &current->thread.fpu;
 
-	if (v8086_mode(regs))
+	if (v8086_mode(regs)) {
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
+		/* Has save_v86_state failed and killed the process? */
+		if (fatal_signal_pending(current))
+			return;
+	}
 
 	/* Are we from a system call? */
 	if (syscall_get_nr(current, regs) != -1) {
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index 63486da77272..040fd01be8b3 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -159,7 +159,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 	user_access_end();
 Efault:
 	pr_alert("could not access userspace vm86 info\n");
-	do_exit(SIGSEGV);
+	force_sigsegv(SIGSEGV);
 }
 
 static int do_vm86_irq_handling(int subfunction, int irqnumber);
-- 
2.20.1


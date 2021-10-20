Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B224351A9
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhJTRrO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57072 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhJTRrN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:52780)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFe6-002tLR-A8; Wed, 20 Oct 2021 11:44:58 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFe3-001NdN-Te; Wed, 20 Oct 2021 11:44:57 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Oct 2021 12:43:53 -0500
Message-Id: <20211020174406.17889-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFe3-001NdN-Te;;;mid=<20211020174406.17889-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Emo7IPRF0mj2xClpddKvdhPaEtu2o4MA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1674 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (0.8%), b_tie_ro: 12 (0.7%), parse: 0.88
        (0.1%), extract_message_metadata: 25 (1.5%), get_uri_detail_list: 2.2
        (0.1%), tests_pri_-1000: 24 (1.4%), tests_pri_-950: 1.31 (0.1%),
        tests_pri_-900: 1.04 (0.1%), tests_pri_-90: 83 (4.9%), check_bayes: 78
        (4.7%), b_tokenize: 8 (0.5%), b_tok_get_all: 8 (0.5%), b_comp_prob:
        2.3 (0.1%), b_tok_touch_all: 57 (3.4%), b_finish: 1.02 (0.1%),
        tests_pri_0: 286 (17.1%), check_dkim_signature: 0.54 (0.0%),
        check_dkim_adsp: 14 (0.9%), poll_dns_idle: 1222 (73.0%), tests_pri_10:
        2.3 (0.1%), tests_pri_500: 1234 (73.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 07/20] signal/powerpc: On swapcontext failure force SIGSEGV
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If the register state may be partial and corrupted instead of calling
do_exit, call force_sigsegv(SIGSEGV).  Which properly kills the
process with SIGSEGV and does not let any more userspace code execute,
instead of just killing one thread of the process and potentially
confusing everything.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
History-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Fixes: 756f1ae8a44e ("PPC32: Rework signal code and add a swapcontext system call.")
Fixes: 04879b04bf50 ("[PATCH] ppc64: VMX (Altivec) support & signal32 rework, from Ben Herrenschmidt")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/kernel/signal_32.c | 6 ++++--
 arch/powerpc/kernel/signal_64.c | 9 ++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 0608581967f0..666f3da41232 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1062,8 +1062,10 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 * or if another thread unmaps the region containing the context.
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
-	if (do_setcontext(new_ctx, regs, 0))
-		do_exit(SIGSEGV);
+	if (do_setcontext(new_ctx, regs, 0)) {
+		force_sigsegv(SIGSEGV);
+		return -EFAULT;
+	}
 
 	set_thread_flag(TIF_RESTOREALL);
 	return 0;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 1831bba0582e..d8de622c9e4a 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -703,15 +703,18 @@ SYSCALL_DEFINE3(swapcontext, struct ucontext __user *, old_ctx,
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
 
-	if (__get_user_sigset(&set, &new_ctx->uc_sigmask))
-		do_exit(SIGSEGV);
+	if (__get_user_sigset(&set, &new_ctx->uc_sigmask)) {
+		force_sigsegv(SIGSEGV);
+		return -EFAULT;
+	}
 	set_current_blocked(&set);
 
 	if (!user_read_access_begin(new_ctx, ctx_size))
 		return -EFAULT;
 	if (__unsafe_restore_sigcontext(current, NULL, 0, &new_ctx->uc_mcontext)) {
 		user_read_access_end();
-		do_exit(SIGSEGV);
+		force_sigsegv(SIGSEGV);
+		return -EFAULT;
 	}
 	user_read_access_end();
 
-- 
2.20.1


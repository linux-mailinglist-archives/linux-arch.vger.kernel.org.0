Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93D4351A5
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJTRrL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:11 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40460 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhJTRrH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:07 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:55052)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFe0-00GCwM-DG; Wed, 20 Oct 2021 11:44:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdz-001NdN-4w; Wed, 20 Oct 2021 11:44:51 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Maciej Rozycki <macro@orcam.me.uk>, linux-mips@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:43:51 -0500
Message-Id: <20211020174406.17889-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFdz-001NdN-4w;;;mid=<20211020174406.17889-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18vAFcVjANIu4vDNha2bth++KrviZjJJPY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *****
X-Spam-Status: No, score=5.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TR_XM_SB_Phish,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,
        T_TooManySym_05,XMNoVowels,XMSubLong,XMSubPhish11,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_05 8+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  1.5 XMSubPhish11 Phishy Language Subject
        *  0.0 TR_XM_SB_Phish Phishing flag in subject of message
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 645 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 14 (2.1%), b_tie_ro: 12 (1.9%), parse: 1.09
        (0.2%), extract_message_metadata: 21 (3.2%), get_uri_detail_list: 2.7
        (0.4%), tests_pri_-1000: 26 (4.1%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 187 (29.0%), check_bayes:
        183 (28.4%), b_tokenize: 8 (1.2%), b_tok_get_all: 6 (1.0%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 163 (25.3%), b_finish: 0.93
        (0.1%), tests_pri_0: 300 (46.5%), check_dkim_signature: 0.81 (0.1%),
        check_dkim_adsp: 3.3 (0.5%), poll_dns_idle: 70 (10.8%), tests_pri_10:
        3.0 (0.5%), tests_pri_500: 88 (13.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 05/20] signal/mips: Update (_save|_restore)_fp_context to fail with -EFAULT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When an instruction to save or restore a register from the stack fails
in _save_fp_context or _restore_fp_context return with -EFAULT.  This
change was made to r2300_fpu.S[1] but it looks like it got lost with
the introduction of EX2[2].  This is also what the other implementation
of _save_fp_context and _restore_fp_context in r4k_fpu.S does, and
what is needed for the callers to be able to handle the error.

Furthermore calling do_exit(SIGSEGV) from bad_stack is wrong because
it does not terminate the entire process it just terminates a single
thread.

As the changed code was the only caller of arch/mips/kernel/syscall.c:bad_stack
remove the problematic and now unused helper function.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Maciej Rozycki <macro@orcam.me.uk>
Cc: linux-mips@vger.kernel.org
[1] 35938a00ba86 ("MIPS: Fix ISA I FP sigcontext access violation handling")
[2] f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
Fixes: f92722dc4545 ("MIPS: Correct MIPS I FP sigcontext layout")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/mips/kernel/r2300_fpu.S | 4 ++--
 arch/mips/kernel/syscall.c   | 9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/mips/kernel/r2300_fpu.S b/arch/mips/kernel/r2300_fpu.S
index 12e58053544f..cbf6db98cfb3 100644
--- a/arch/mips/kernel/r2300_fpu.S
+++ b/arch/mips/kernel/r2300_fpu.S
@@ -29,8 +29,8 @@
 #define EX2(a,b)						\
 9:	a,##b;							\
 	.section __ex_table,"a";				\
-	PTR	9b,bad_stack;					\
-	PTR	9b+4,bad_stack;					\
+	PTR	9b,fault;					\
+	PTR	9b+4,fault;					\
 	.previous
 
 	.set	mips1
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 2afa3eef486a..5512cd586e6e 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -240,12 +240,3 @@ SYSCALL_DEFINE3(cachectl, char *, addr, int, nbytes, int, op)
 {
 	return -ENOSYS;
 }
-
-/*
- * If we ever come here the user sp is bad.  Zap the process right away.
- * Due to the bad stack signaling wouldn't work.
- */
-asmlinkage void bad_stack(void)
-{
-	do_exit(SIGSEGV);
-}
-- 
2.20.1


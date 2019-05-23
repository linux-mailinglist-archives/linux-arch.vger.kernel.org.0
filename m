Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7340E27377
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 02:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbfEWAnm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 20:43:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60234 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729652AbfEWAnO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp9-0004H4-Nx; Wed, 22 May 2019 18:43:11 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnE-0005Z3-1Y; Wed, 22 May 2019 18:41:13 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:00 -0500
Message-Id: <20190523003916.20726-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnE-0005Z3-1Y;;;mid=<20190523003916.20726-11-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Xjn+dxOYgmsgfqBLZxUpgORMsqZ3VRfE=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1458 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.0 (0.2%), b_tie_ro: 2.1 (0.1%), parse: 1.06
        (0.1%), extract_message_metadata: 14 (0.9%), get_uri_detail_list: 3.0
        (0.2%), tests_pri_-1000: 12 (0.8%), tests_pri_-950: 1.28 (0.1%),
        tests_pri_-900: 1.05 (0.1%), tests_pri_-90: 26 (1.8%), check_bayes: 24
        (1.7%), b_tokenize: 10 (0.7%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        1.96 (0.1%), b_tok_touch_all: 3.6 (0.3%), b_finish: 0.66 (0.0%),
        tests_pri_0: 1390 (95.3%), check_dkim_signature: 0.58 (0.0%),
        check_dkim_adsp: 2.3 (0.2%), poll_dns_idle: 0.81 (0.1%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 6 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 10/26] signal: Remove task parameter from force_sig_mceerr
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

All of the callers pass current into force_sig_mceer so remove the
task parameter to make this obvious.

This also makes it clear that force_sig_mceerr passes current
into force_sig_info.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/traps.c    | 2 +-
 arch/parisc/mm/fault.c       | 2 +-
 arch/powerpc/mm/fault.c      | 3 +--
 arch/x86/mm/fault.c          | 2 +-
 include/linux/sched/signal.h | 2 +-
 kernel/signal.c              | 4 ++--
 mm/memory-failure.c          | 2 +-
 7 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 39a391adf222..65ca953abc53 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -263,7 +263,7 @@ void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
 			    const char *str)
 {
 	arm64_show_signal(SIGBUS, str);
-	force_sig_mceerr(code, addr, lsb, current);
+	force_sig_mceerr(code, addr, lsb);
 }
 
 void arm64_force_sig_ptrace_errno_trap(int errno, void __user *addr,
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index c8e8b7c05558..56ceacb3401d 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -403,7 +403,7 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 				lsb = PAGE_SHIFT;
 
 			force_sig_mceerr(BUS_MCEERR_AR, (void __user *) address,
-					 lsb, current);
+					 lsb);
 			return;
 		}
 #endif
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index b5d3578d9f65..6ed6c341c670 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -182,8 +182,7 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		if (fault & VM_FAULT_HWPOISON)
 			lsb = PAGE_SHIFT;
 
-		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb,
-				 current);
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
 		return 0;
 	}
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 46df4c6aae46..c431326ee3fa 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1040,7 +1040,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 		if (fault & VM_FAULT_HWPOISON)
 			lsb = PAGE_SHIFT;
-		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb, tsk);
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb);
 		return;
 	}
 #endif
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e9df3f0cce48..4178bb1f7709 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -316,7 +316,7 @@ int send_sig_fault(int sig, int code, void __user *addr
 	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
 	, struct task_struct *t);
 
-int force_sig_mceerr(int code, void __user *, short, struct task_struct *);
+int force_sig_mceerr(int code, void __user *, short);
 int send_sig_mceerr(int code, void __user *, short, struct task_struct *);
 
 int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper);
diff --git a/kernel/signal.c b/kernel/signal.c
index 20878c4c28c2..398489facf9f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1666,7 +1666,7 @@ int send_sig_fault(int sig, int code, void __user *addr
 	return send_sig_info(info.si_signo, &info, t);
 }
 
-int force_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
+int force_sig_mceerr(int code, void __user *addr, short lsb)
 {
 	struct kernel_siginfo info;
 
@@ -1677,7 +1677,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct
 	info.si_code = code;
 	info.si_addr = addr;
 	info.si_addr_lsb = lsb;
-	return force_sig_info(info.si_signo, &info, t);
+	return force_sig_info(info.si_signo, &info, current);
 }
 
 int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *t)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fc8b51744579..bc749265a8f3 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -221,7 +221,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 
 	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
 		ret = force_sig_mceerr(BUS_MCEERR_AR, (void __user *)tk->addr,
-				       addr_lsb, current);
+				       addr_lsb);
 	} else {
 		/*
 		 * Don't use force here, it's convenient if the signal
-- 
2.21.0


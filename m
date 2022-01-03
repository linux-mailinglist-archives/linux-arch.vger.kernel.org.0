Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB7483873
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiACVdv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:33:51 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:45890 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiACVdt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:49 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:56496)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxf-00ET10-VJ; Mon, 03 Jan 2022 14:33:48 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxe-006zvm-Oo; Mon, 03 Jan 2022 14:33:47 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon,  3 Jan 2022 15:33:03 -0600
Message-Id: <20220103213312.9144-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uxe-006zvm-Oo;;;mid=<20220103213312.9144-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19v1FHwGXBXGWLQ9gxNwRHnNBkfOqEsAZQ=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_08,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 384 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 8 (2.1%), b_tie_ro: 7 (1.8%), parse: 0.87 (0.2%),
        extract_message_metadata: 14 (3.5%), get_uri_detail_list: 1.28 (0.3%),
        tests_pri_-1000: 15 (3.9%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 0.98 (0.3%), tests_pri_-90: 146 (37.9%), check_bayes:
        137 (35.6%), b_tokenize: 6 (1.5%), b_tok_get_all: 5 (1.4%),
        b_comp_prob: 1.97 (0.5%), b_tok_touch_all: 121 (31.4%), b_finish: 0.76
        (0.2%), tests_pri_0: 186 (48.5%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 0.66 (0.2%), tests_pri_10:
        1.77 (0.5%), tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 08/17] ptrace/m68k: Stop open coding ptrace_report_syscall
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The generic function ptrace_report_syscall does a little more
than syscall_trace on m68k.  The function ptrace_report_syscall
stops early if PT_TRACED is not set, it sets ptrace_message,
and returns the result of fatal_signal_pending.

Setting ptrace_message to a passed in value of 0 is effectively not
setting ptrace_message, making that additional work a noop.

Returning the result of fatal_signal_pending and letting the caller
ignore the result becomes a noop in this change.

When a process is ptraced, the flag PT_PTRACED is always set in
current->ptrace.  Testing for PT_PTRACED in ptrace_report_syscall is
just an optimization to fail early if the process is not ptraced.
Later on in ptrace_notify, ptrace_stop will test current->ptrace under
tasklist_lock and skip performing any work if the task is not ptraced.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/m68k/kernel/ptrace.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
index 94b3b274186d..aa3a0b8d07e9 100644
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -273,17 +273,7 @@ long arch_ptrace(struct task_struct *child, long request,
 
 asmlinkage void syscall_trace(void)
 {
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-				 ? 0x80 : 0));
-	/*
-	 * this isn't the same as continuing with a signal, but it will do
-	 * for normal use.  strace only continues with a signal if the
-	 * stopping signal is not SIGTRAP.  -brl
-	 */
-	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
-		current->exit_code = 0;
-	}
+	ptrace_report_syscall(0);
 }
 
 #if defined(CONFIG_COLDFIRE) || !defined(CONFIG_MMU)
-- 
2.29.2


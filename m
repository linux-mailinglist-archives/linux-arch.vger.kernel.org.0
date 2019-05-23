Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A16727369
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 02:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfEWAnK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 20:43:10 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60226 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWAnJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:09 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp7-0004Gq-3j; Wed, 22 May 2019 18:43:09 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbnV-0005Z3-9w; Wed, 22 May 2019 18:41:30 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:05 -0500
Message-Id: <20190523003916.20726-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbnV-0005Z3-9w;;;mid=<20190523003916.20726-16-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18sTB6impB1nh3xbRKCo6dWXfzxv3Kzgz8=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1257 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.6 (0.3%), b_tie_ro: 2.4 (0.2%), parse: 1.55
        (0.1%), extract_message_metadata: 18 (1.4%), get_uri_detail_list: 1.70
        (0.1%), tests_pri_-1000: 19 (1.5%), tests_pri_-950: 1.78 (0.1%),
        tests_pri_-900: 1.44 (0.1%), tests_pri_-90: 20 (1.6%), check_bayes: 18
        (1.5%), b_tokenize: 7 (0.5%), b_tok_get_all: 5 (0.4%), b_comp_prob:
        1.94 (0.2%), b_tok_touch_all: 2.6 (0.2%), b_finish: 0.66 (0.1%),
        tests_pri_0: 1171 (93.1%), check_dkim_signature: 0.53 (0.0%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 0.78 (0.1%), tests_pri_10:
        4.0 (0.3%), tests_pri_500: 12 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 15/26] signal/nds32: Remove tsk parameter from send_sigtrap
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The send_sigtrap function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This also makes it clear that send_sigtrap always calls
force_sig_fault on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/nds32/kernel/traps.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 8d84b8b30eb6..66f197efcec9 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -255,9 +255,10 @@ void __init early_trap_init(void)
 	cpu_cache_wbinval_page(base, true);
 }
 
-void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
-		  int error_code, int si_code)
+static void send_sigtrap(struct pt_regs *regs, int error_code, int si_code)
 {
+	struct task_struct *tsk = current;
+
 	tsk->thread.trap_no = ENTRY_DEBUG_RELATED;
 	tsk->thread.error_code = error_code;
 
@@ -274,7 +275,7 @@ void do_debug_trap(unsigned long entry, unsigned long addr,
 
 	if (user_mode(regs)) {
 		/* trap_signal */
-		send_sigtrap(current, regs, 0, TRAP_BRKPT);
+		send_sigtrap(regs, 0, TRAP_BRKPT);
 	} else {
 		/* kernel_trap */
 		if (!fixup_exception(regs))
-- 
2.21.0


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA2B3D678D
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 21:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhGZS4X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 14:56:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39582 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhGZS4X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 14:56:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:37180)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m86PB-00C1hw-W6; Mon, 26 Jul 2021 13:36:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:41932 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m86PA-003pQK-Ik; Mon, 26 Jul 2021 13:36:49 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Brad Boyer <flar@allandria.com>,
        Andreas Schwab <schwab@linux-m68k.org>, geert@linux-m68k.org,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        torvalds@linux-foundation.org
References: <e9009e13-cfec-c494-0b3b-f334f75cd1e4@gmail.com>
        <af434994-5c61-0e3a-c7bc-3ed966ccb44f@gmail.com>
        <87h7gopvz2.fsf@disp2133>
        <328e59fb-3e8c-e4cd-06b4-1975ce98614a@gmail.com>
        <877dhio13t.fsf@disp2133>
        <12992a3c-0740-f90e-aa4e-1ec1d8ea38f6@gmail.com>
        <87tukkk6h3.fsf@disp2133>
        <df6618bf-d1bc-4759-2d14-934c22d54a83@gmail.com>
        <87eebn7w7y.fsf@igel.home>
        <db43bef1-7938-4fc1-853d-c20d66521329@gmail.com>
        <20210725101253.GA6096@allandria.com>
        <be3ddf9a-745e-4798-17a7-a9d0ddd7eef7@gmail.com>
Date:   Mon, 26 Jul 2021 14:36:42 -0500
In-Reply-To: <be3ddf9a-745e-4798-17a7-a9d0ddd7eef7@gmail.com> (Michael
        Schmitz's message of "Mon, 26 Jul 2021 14:00:01 +1200")
Message-ID: <87a6m8kgtx.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m86PA-003pQK-Ik;;;mid=<87a6m8kgtx.fsf_-_@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18N0N9bnXIRvhcVoadJMHU7sFIvwUtGVxc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,TR_Symld_Words,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4952]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michael Schmitz <schmitzmic@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 475 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 14 (2.9%), b_tie_ro: 11 (2.4%), parse: 1.94
        (0.4%), extract_message_metadata: 20 (4.1%), get_uri_detail_list: 2.4
        (0.5%), tests_pri_-1000: 21 (4.4%), tests_pri_-950: 1.89 (0.4%),
        tests_pri_-900: 1.36 (0.3%), tests_pri_-90: 118 (24.8%), check_bayes:
        115 (24.3%), b_tokenize: 9 (1.9%), b_tok_get_all: 33 (7.0%),
        b_comp_prob: 3.5 (0.7%), b_tok_touch_all: 66 (13.9%), b_finish: 1.10
        (0.2%), tests_pri_0: 278 (58.5%), check_dkim_signature: 0.89 (0.2%),
        check_dkim_adsp: 3.4 (0.7%), poll_dns_idle: 0.98 (0.2%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 12 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


In the fpsp040 code when copyin or copyout fails call
force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).

This solves a couple of problems.  Because do_exit embeds the ptrace
stop PTRACE_EVENT_EXIT a complete stack frame needs to be present for
that to work correctly.  There is always the information needed for a
ptrace stop where get_signal is called.  So exiting with a signal
solves the ptrace issue.

Further exiting with a signal ensures that all of the threads in a
process are killed not just the thread that malfunctioned.  Which
avoids confusing userspace.

To make force_sigsegv(SIGSEGV) work in fpsp040_die modify the code to
save all of the registers and jump to ret_from_exception (which
ultimately calls get_signal) after fpsp040_die returns.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Can someone please check my m68k assembly changes?

I think I have them correct, and the code assembles but I don't
understand the fine points of when the different branch instructions
should be used.

 arch/m68k/fpsp040/skeleton.S | 3 ++-
 arch/m68k/kernel/traps.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index a8f41615d94a..ec767523c012 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -502,7 +502,8 @@ in_ea:
 	.section .fixup,#alloc,#execinstr
 	.even
 1:
-	jbra	fpsp040_die
+	bsrl	fpsp040_die
+	jmp	.Lnotkern
 
 	.section __ex_table,#alloc
 	.align	4
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 9e1261462bcc..5b19fcdcd69e 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1150,7 +1150,7 @@ asmlinkage void set_esp0(unsigned long ssp)
  */
 asmlinkage void fpsp040_die(void)
 {
-	do_exit(SIGSEGV);
+	force_sigsegv(SIGSEGV);
 }
 
 #ifdef CONFIG_M68KFPU_EMU
-- 
2.20.1


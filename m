Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C7F28239
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 18:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfEWQL3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 12:11:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40765 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfEWQL3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 May 2019 12:11:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTqJT-0007EP-Fv; Thu, 23 May 2019 10:11:27 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTqJS-0001D2-BB; Thu, 23 May 2019 10:11:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
        <20190523003916.20726-4-ebiederm@xmission.com>
        <20190523101702.GG26646@fuggles.cambridge.arm.com>
Date:   Thu, 23 May 2019 11:11:19 -0500
In-Reply-To: <20190523101702.GG26646@fuggles.cambridge.arm.com> (Will Deacon's
        message of "Thu, 23 May 2019 11:17:02 +0100")
Message-ID: <875zq1gnh4.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hTqJS-0001D2-BB;;;mid=<875zq1gnh4.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18uM7KSAne4UR9ryYOSFz6/61hVMF9pJiQ=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4820]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Will Deacon <will.deacon@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 784 ms - load_scoreonly_sql: 0.33 (0.0%),
        signal_user_changed: 4.6 (0.6%), b_tie_ro: 2.9 (0.4%), parse: 2.0
        (0.3%), extract_message_metadata: 16 (2.0%), get_uri_detail_list: 1.74
        (0.2%), tests_pri_-1000: 9 (1.1%), tests_pri_-950: 1.33 (0.2%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 32 (4.0%), check_bayes: 30
        (3.8%), b_tokenize: 13 (1.6%), b_tok_get_all: 7 (0.9%), b_comp_prob:
        3.8 (0.5%), b_tok_touch_all: 2.8 (0.4%), b_finish: 0.73 (0.1%),
        tests_pri_0: 412 (52.6%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 7 (0.9%), poll_dns_idle: 282 (35.9%), tests_pri_10:
        3.9 (0.5%), tests_pri_500: 298 (38.1%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCHv2 03/26] signal/arm64: Use force_sig not force_sig_fault for SIGKILL
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


I don't think this is userspace visible but SIGKILL does not have
any si_codes that use the fault member of the siginfo union.  Correct
this the simple way and call force_sig instead of force_sig_fault when
the signal is SIGKILL.

The two know places where synchronous SIGKILL are generated are
do_bad_area and fpsimd_save.  The call paths to force_sig_fault are:
do_bad_area
  arm64_force_sig_fault
    force_sig_fault
force_signal_inject
  arm64_notify_die
    arm64_force_sig_fault
       force_sig_fault

Which means correcting this in arm64_force_sig_fault is enough
to ensure the arm64 code is not misusing the generic code, which
could lead to maintenance problems later.

Cc: stable@vger.kernel.org
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Fixes: af40ff687bc9 ("arm64: signal: Ensure si_code is valid for all fault signals")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I have also made the corresponding changes to:
09/26 signal: Remove task parameter from force_sig
21/26 signal: Remove the task parameter from force_sig_fault
But I will leave off reposting those as for now as the changes
are obvious.

arch/arm64/kernel/traps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index ade32046f3fe..e45d5b440fb1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -256,7 +256,10 @@ void arm64_force_sig_fault(int signo, int code, void __user *addr,
 			   const char *str)
 {
 	arm64_show_signal(signo, str);
-	force_sig_fault(signo, code, addr, current);
+	if (signo == SIGKILL)
+		force_sig(SIGKILL, current);
+	else
+		force_sig_fault(signo, code, addr, current);
 }
 
 void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
-- 
2.21.0.dirty


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2FB4351C2
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJTRsG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:48:06 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57266 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhJTRrh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:37 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:53180)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeU-002tQl-C2; Wed, 20 Oct 2021 11:45:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeT-001NdN-BO; Wed, 20 Oct 2021 11:45:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:44:01 -0500
Message-Id: <20211020174406.17889-15-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeT-001NdN-BO;;;mid=<20211020174406.17889-15-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/AOAfq9OrbTsAKGIOxrYpXtjiyRsjzJi8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMGappySubj_02,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5008]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.0 XMGappySubj_02 Gappier still
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 419 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 14 (3.4%), b_tie_ro: 13 (3.0%), parse: 1.23
        (0.3%), extract_message_metadata: 17 (4.1%), get_uri_detail_list: 1.87
        (0.4%), tests_pri_-1000: 21 (5.1%), tests_pri_-950: 1.30 (0.3%),
        tests_pri_-900: 1.08 (0.3%), tests_pri_-90: 109 (25.9%), check_bayes:
        106 (25.3%), b_tokenize: 6 (1.5%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 87 (20.7%), b_finish: 1.12
        (0.3%), tests_pri_0: 239 (57.0%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 3.1 (0.8%), poll_dns_idle: 1.32 (0.3%), tests_pri_10:
        3.2 (0.8%), tests_pri_500: 9 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 15/20] signal/sparc32: Exit with a fatal signal when try_to_clear_window_buffer fails
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The function try_to_clear_window_buffer is only called from
rtrap_32.c.  After it is called the signal pending state is retested,
and signals are handled if TIF_SIGPENDING is set.  This allows
try_to_clear_window_buffer to call force_fatal_signal and then rely on
the signal being delivered to kill the process, without any danger of
returning to userspace, or otherwise using possible corrupt state on
failure.

The functional difference between force_fatal_sig and do_exit is that
do_exit will only terminate a single thread, and will never trigger a
core-dump.  A multi-threaded program for which a single thread
terminates unexpectedly is hard to reason about.  Calling force_fatal_sig
does not give userspace a chance to catch the signal, but otherwise
is an ordinary fatal signal exit, and it will trigger a coredump
of the offending process if core dumps are enabled.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/kernel/windows.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/windows.c b/arch/sparc/kernel/windows.c
index 69a6ba6e9293..bbbd40cc6b28 100644
--- a/arch/sparc/kernel/windows.c
+++ b/arch/sparc/kernel/windows.c
@@ -121,8 +121,10 @@ void try_to_clear_window_buffer(struct pt_regs *regs, int who)
 
 		if ((sp & 7) ||
 		    copy_to_user((char __user *) sp, &tp->reg_window[window],
-				 sizeof(struct reg_window32)))
-			do_exit(SIGILL);
+				 sizeof(struct reg_window32))) {
+			force_fatal_sig(SIGILL);
+			return;
+		}
 	}
 	tp->w_saved = 0;
 }
-- 
2.20.1


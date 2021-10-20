Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2824351A2
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhJTRrJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:09 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40448 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhJTRrF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:05 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:55038)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdx-00GCw3-UI; Wed, 20 Oct 2021 11:44:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdw-001NdN-DC; Wed, 20 Oct 2021 11:44:49 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:43:50 -0500
Message-Id: <20211020174406.17889-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFdw-001NdN-DC;;;mid=<20211020174406.17889-4-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+5xPDePglvOJbR0eiAg965Omb5l3uiL9A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5107]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 358 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (3.2%), b_tie_ro: 10 (2.8%), parse: 0.95
        (0.3%), extract_message_metadata: 15 (4.3%), get_uri_detail_list: 1.04
        (0.3%), tests_pri_-1000: 16 (4.6%), tests_pri_-950: 1.39 (0.4%),
        tests_pri_-900: 1.13 (0.3%), tests_pri_-90: 119 (33.4%), check_bayes:
        112 (31.4%), b_tokenize: 6 (1.6%), b_tok_get_all: 5 (1.5%),
        b_comp_prob: 1.99 (0.6%), b_tok_touch_all: 96 (26.7%), b_finish: 0.96
        (0.3%), tests_pri_0: 179 (50.2%), check_dkim_signature: 0.62 (0.2%),
        check_dkim_adsp: 2.8 (0.8%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 04/20] signal/sparc32: Remove unreachable do_exit in do_sparc_fault
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The call to do_exit in do_sparc_fault immediately follows a call to
unhandled_fault.  The function unhandled_fault never returns.  This
means the call to do_exit can never be reached.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Fixes: 2.3.41
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/mm/fault_32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index fa858626b85b..90dc4ae315c8 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -248,7 +248,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	}
 
 	unhandled_fault(address, tsk, regs);
-	do_exit(SIGKILL);
 
 /*
  * We ran out of memory, or some other thing happened to us that made
-- 
2.20.1


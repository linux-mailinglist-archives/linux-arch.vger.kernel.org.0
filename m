Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B267435198
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhJTRq5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:46:57 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40414 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhJTRq5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:46:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:54948)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdp-00GCv6-SX; Wed, 20 Oct 2021 11:44:41 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdo-001NdN-VK; Wed, 20 Oct 2021 11:44:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>
Date:   Wed, 20 Oct 2021 12:43:47 -0500
Message-Id: <20211020174406.17889-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFdo-001NdN-VK;;;mid=<20211020174406.17889-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/vH9BzxZMJil3hyUi3PHXKmsFqUHXgmG4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5043]
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 321 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (3.4%), b_tie_ro: 9 (2.9%), parse: 0.89 (0.3%),
         extract_message_metadata: 12 (3.6%), get_uri_detail_list: 1.05 (0.3%),
         tests_pri_-1000: 15 (4.7%), tests_pri_-950: 1.87 (0.6%),
        tests_pri_-900: 1.51 (0.5%), tests_pri_-90: 85 (26.4%), check_bayes:
        83 (25.8%), b_tokenize: 5 (1.7%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 2.1 (0.7%), b_tok_touch_all: 66 (20.4%), b_finish: 0.86
        (0.3%), tests_pri_0: 183 (56.9%), check_dkim_signature: 1.30 (0.4%),
        check_dkim_adsp: 3.3 (1.0%), poll_dns_idle: 1.09 (0.3%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 01/20] exit/doublefault: Remove apparently bogus comment about rewind_stack_do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I do not see panic calling rewind_stack_do_exit anywhere, nor can I
find anywhere in the history where doublefault_shim has called
rewind_stack_do_exit.  So I don't think this comment was ever actually
correct.

Cc: Andy Lutomirski <luto@kernel.org>
Fixes: 7d8d8cfdee9a ("x86/doublefault/32: Rewrite the x86_32 #DF handler and unify with 64-bit")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/doublefault_32.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/doublefault_32.c b/arch/x86/kernel/doublefault_32.c
index d1d49e3d536b..3b58d8703094 100644
--- a/arch/x86/kernel/doublefault_32.c
+++ b/arch/x86/kernel/doublefault_32.c
@@ -77,9 +77,6 @@ asmlinkage noinstr void __noreturn doublefault_shim(void)
 	 * some way to reconstruct CR3.  We could make a credible guess based
 	 * on cpu_tlbstate, but that would be racy and would not account for
 	 * PTI.
-	 *
-	 * Instead, don't bother.  We can return through
-	 * rewind_stack_do_exit() instead.
 	 */
 	panic("cannot return from double fault\n");
 }
-- 
2.20.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16DF4351AD
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhJTRrU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43342 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhJTRrP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50228)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFe8-00EwIU-Fz; Wed, 20 Oct 2021 11:45:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFe7-001NdN-FW; Wed, 20 Oct 2021 11:45:00 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Date:   Wed, 20 Oct 2021 12:43:54 -0500
Message-Id: <20211020174406.17889-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFe7-001NdN-FW;;;mid=<20211020174406.17889-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+m7zFDieSDYP9ie4oAgZCOoskjv4SbOX8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 376 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 12 (3.1%), b_tie_ro: 10 (2.6%), parse: 1.09
        (0.3%), extract_message_metadata: 16 (4.1%), get_uri_detail_list: 1.36
        (0.4%), tests_pri_-1000: 22 (5.7%), tests_pri_-950: 1.44 (0.4%),
        tests_pri_-900: 1.13 (0.3%), tests_pri_-90: 92 (24.5%), check_bayes:
        91 (24.1%), b_tokenize: 6 (1.7%), b_tok_get_all: 7 (1.7%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 72 (19.2%), b_finish: 0.86
        (0.2%), tests_pri_0: 213 (56.6%), check_dkim_signature: 0.68 (0.2%),
        check_dkim_adsp: 3.1 (0.8%), poll_dns_idle: 0.82 (0.2%), tests_pri_10:
        2.4 (0.6%), tests_pri_500: 13 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 08/20] signal/sparc: In setup_tsb_params convert open coded BUG into BUG
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The function setup_tsb_params has exactly one caller tsb_grow.  The
function tsb_grow passes in a tsb_bytes value that is between 8192 and
1048576 inclusive, and is guaranteed to be a power of 2.  The function
setup_tsb_params verifies this property with a switch statement and
then prints an error and causes the task to exit if this is not true.

In practice that print statement can never be reached because tsb_grow
never passes in a bad tsb_size.  So if tsb_size ever gets a bad value
that is a kernel bug.

So replace the do_exit which is effectively an open coded version of
BUG() with an actuall call to BUG().  Making it clearer that this
is a case that can never, and should never happen.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/mm/tsb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 0dce4b7ff73e..912205787161 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -266,7 +266,7 @@ static void setup_tsb_params(struct mm_struct *mm, unsigned long tsb_idx, unsign
 	default:
 		printk(KERN_ERR "TSB[%s:%d]: Impossible TSB size %lu, killing process.\n",
 		       current->comm, current->pid, tsb_bytes);
-		do_exit(SIGSEGV);
+		BUG();
 	}
 	tte |= pte_sz_bits(page_sz);
 
-- 
2.20.1


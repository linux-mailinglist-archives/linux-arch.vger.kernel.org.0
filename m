Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F67273D7
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfEWBLF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:11:05 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:59216 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfEWBLE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:11:04 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbp8-0008Ru-Cx; Wed, 22 May 2019 18:43:10 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTboK-0005Z3-3d; Wed, 22 May 2019 18:42:21 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Date:   Wed, 22 May 2019 19:39:14 -0500
Message-Id: <20190523003916.20726-25-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTboK-0005Z3-3d;;;mid=<20190523003916.20726-25-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18fKKFbpRjA8nGr7nPs40NohsWoIEbT+s8=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels,XMSubLong,
        XM_H_QuotedFrom autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
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
X-Spam-Timing: total 1243 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 3.1 (0.2%), b_tie_ro: 2.1 (0.2%), parse: 0.82
        (0.1%), extract_message_metadata: 13 (1.0%), get_uri_detail_list: 0.93
        (0.1%), tests_pri_-1000: 20 (1.6%), tests_pri_-950: 2.1 (0.2%),
        tests_pri_-900: 1.73 (0.1%), tests_pri_-90: 22 (1.8%), check_bayes: 20
        (1.6%), b_tokenize: 8 (0.7%), b_tok_get_all: 4.5 (0.4%), b_comp_prob:
        2.6 (0.2%), b_tok_touch_all: 2.1 (0.2%), b_finish: 0.71 (0.1%),
        tests_pri_0: 1169 (94.1%), check_dkim_signature: 0.88 (0.1%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 0.39 (0.0%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 6 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 24/26] signal: Generate the siginfo in force_sig
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for removing the special case in force_sig_info for
only having a signal number generate an appropriate siginfo in
force_sig the last caller of force_sig_info that does not
pass a filled out siginfo.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 0da35880261e..d5f9ed5da9c5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1605,7 +1605,15 @@ EXPORT_SYMBOL(send_sig);
 
 void force_sig(int sig)
 {
-	force_sig_info(sig, SEND_SIG_PRIV, current);
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code = SI_KERNEL;
+	info.si_pid = 0;
+	info.si_uid = 0;
+	force_sig_info(info.si_signo, &info, current);
 }
 EXPORT_SYMBOL(force_sig);
 
-- 
2.21.0


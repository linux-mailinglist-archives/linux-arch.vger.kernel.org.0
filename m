Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3946DCF6
	for <lists+linux-arch@lfdr.de>; Wed,  8 Dec 2021 21:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240252AbhLHUaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Dec 2021 15:30:03 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:40000 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhLHUaB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2021 15:30:01 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:46806)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WF-00GaOY-VE; Wed, 08 Dec 2021 13:26:28 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:39446 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mv3WD-00CjR6-Qq; Wed, 08 Dec 2021 13:26:26 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>
Date:   Wed,  8 Dec 2021 14:25:27 -0600
Message-Id: <20211208202532.16409-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mv3WD-00CjR6-Qq;;;mid=<20211208202532.16409-5-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+T5TpTrz/xRzfXCv+8TR5YFQSmRN3xN30=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5399]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 783 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.5%), b_tie_ro: 10 (1.2%), parse: 1.01
        (0.1%), extract_message_metadata: 15 (1.9%), get_uri_detail_list: 0.75
        (0.1%), tests_pri_-1000: 26 (3.4%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 94 (12.0%), check_bayes:
        93 (11.8%), b_tokenize: 6 (0.8%), b_tok_get_all: 6 (0.8%),
        b_comp_prob: 1.82 (0.2%), b_tok_touch_all: 75 (9.6%), b_finish: 0.95
        (0.1%), tests_pri_0: 616 (78.7%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 3.3 (0.4%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        2.4 (0.3%), tests_pri_500: 11 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 05/10] exit: Stop exporting do_exit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Now that there are no more modular uses of do_exit remove the EXPORT_SYMBOL.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/exit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index f975cd8a2ed8..57afac845a0a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -843,7 +843,6 @@ void __noreturn do_exit(long code)
 	lockdep_free_task(tsk);
 	do_task_dead();
 }
-EXPORT_SYMBOL_GPL(do_exit);
 
 void __noreturn make_task_dead(int signr)
 {
-- 
2.29.2


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629CA48386B
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 22:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiACVdr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 16:33:47 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:55670 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiACVdo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 16:33:44 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:53832)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxb-008wAq-Hp; Mon, 03 Jan 2022 14:33:43 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:54408 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4Uxa-006zvm-2s; Mon, 03 Jan 2022 14:33:43 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Jan 2022 15:33:01 -0600
Message-Id: <20220103213312.9144-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1n4Uxa-006zvm-2s;;;mid=<20220103213312.9144-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/AooRDxSBy7IO0iwcfMe3FQDLmY0Bv32g=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5077]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 843 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.4%), b_tie_ro: 10 (1.2%), parse: 1.05
        (0.1%), extract_message_metadata: 13 (1.6%), get_uri_detail_list: 0.73
        (0.1%), tests_pri_-1000: 14 (1.7%), tests_pri_-950: 1.52 (0.2%),
        tests_pri_-900: 1.20 (0.1%), tests_pri_-90: 74 (8.8%), check_bayes: 72
        (8.6%), b_tokenize: 4.4 (0.5%), b_tok_get_all: 3.9 (0.5%),
        b_comp_prob: 1.49 (0.2%), b_tok_touch_all: 60 (7.1%), b_finish: 0.89
        (0.1%), tests_pri_0: 710 (84.3%), check_dkim_signature: 0.45 (0.1%),
        check_dkim_adsp: 2.9 (0.3%), poll_dns_idle: 1.09 (0.1%), tests_pri_10:
        3.0 (0.4%), tests_pri_500: 10 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 06/17] ptrace: Remove second setting of PT_SEIZED in ptrace_attach
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The code is totally redundant remove it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index f8589bf8d7dc..eea265082e97 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -419,8 +419,6 @@ static int ptrace_attach(struct task_struct *task, long request,
 	if (task->ptrace)
 		goto unlock_tasklist;
 
-	if (seize)
-		flags |= PT_SEIZED;
 	task->ptrace = flags;
 
 	ptrace_link(task, current);
-- 
2.29.2


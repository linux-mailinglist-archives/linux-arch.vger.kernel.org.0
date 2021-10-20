Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA4A43519D
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhJTRrE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:47:04 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:40438 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhJTRrC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:55008)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdv-00GCvf-7k; Wed, 20 Oct 2021 11:44:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFdu-001NdN-8o; Wed, 20 Oct 2021 11:44:46 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 20 Oct 2021 12:43:49 -0500
Message-Id: <20211020174406.17889-3-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFdu-001NdN-8o;;;mid=<20211020174406.17889-3-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+cnMK/O9zxMcDIYdS5AUdACdBErr8alkM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,T_TooManySym_02,
        T_TooManySym_03,XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5050]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 313 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (3.5%), b_tie_ro: 10 (3.1%), parse: 1.29
        (0.4%), extract_message_metadata: 17 (5.4%), get_uri_detail_list: 0.91
        (0.3%), tests_pri_-1000: 22 (7.2%), tests_pri_-950: 1.91 (0.6%),
        tests_pri_-900: 1.60 (0.5%), tests_pri_-90: 89 (28.5%), check_bayes:
        87 (28.0%), b_tokenize: 8 (2.5%), b_tok_get_all: 5.0 (1.6%),
        b_comp_prob: 2.7 (0.9%), b_tok_touch_all: 69 (21.9%), b_finish: 0.90
        (0.3%), tests_pri_0: 154 (49.3%), check_dkim_signature: 0.49 (0.2%),
        check_dkim_adsp: 3.2 (1.0%), poll_dns_idle: 1.13 (0.4%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 8 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 03/20] reboot: Remove the unreachable panic after do_exit in reboot(2)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/reboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index f7440c0c7e43..d6e0f9fb7f04 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -359,7 +359,6 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsigned int, cmd,
 	case LINUX_REBOOT_CMD_HALT:
 		kernel_halt();
 		do_exit(0);
-		panic("cannot halt");
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		kernel_power_off();
-- 
2.20.1


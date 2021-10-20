Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5C4351CB
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhJTRsZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:48:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43678 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhJTRrs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50770)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFef-00EwRf-3j; Wed, 20 Oct 2021 11:45:33 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFec-001NdN-Ug; Wed, 20 Oct 2021 11:45:32 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 20 Oct 2021 12:44:05 -0500
Message-Id: <20211020174406.17889-19-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFec-001NdN-Ug;;;mid=<20211020174406.17889-19-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18lHLRrKyCVQ7AL97xlaRrOt/26tWMvpTQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5018]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1564 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.2 (0.3%), b_tie_ro: 2.9 (0.2%), parse: 0.66
        (0.0%), extract_message_metadata: 8 (0.5%), get_uri_detail_list: 0.81
        (0.1%), tests_pri_-1000: 10 (0.6%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 69 (4.4%), check_bayes: 67
        (4.3%), b_tokenize: 4.4 (0.3%), b_tok_get_all: 5 (0.3%), b_comp_prob:
        1.35 (0.1%), b_tok_touch_all: 54 (3.4%), b_finish: 0.72 (0.0%),
        tests_pri_0: 197 (12.6%), check_dkim_signature: 0.61 (0.0%),
        check_dkim_adsp: 1.83 (0.1%), poll_dns_idle: 1256 (80.3%),
        tests_pri_10: 2.5 (0.2%), tests_pri_500: 1269 (81.1%), rewrite_mail:
        0.00 (0.0%)
Subject: [PATCH 19/20] exit/rtl8712: Replace the macro thread_exit with a simple return 0
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The macro thread_exit is called is at the end of a function started
with kthread_run.  The code in kthread_run has arranged things so a
kernel thread can just return and do_exit will be called.

So just have the cmd_thread return instead of calling complete_and_exit.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/staging/rtl8712/osdep_service.h | 1 -
 drivers/staging/rtl8712/rtl8712_cmd.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/osdep_service.h b/drivers/staging/rtl8712/osdep_service.h
index d33ddffb7ad9..0d9bb42cbc58 100644
--- a/drivers/staging/rtl8712/osdep_service.h
+++ b/drivers/staging/rtl8712/osdep_service.h
@@ -37,7 +37,6 @@ struct	__queue	{
 
 #define _pkt struct sk_buff
 #define _buffer unsigned char
-#define thread_exit() complete_and_exit(NULL, 0)
 
 #define _init_queue(pqueue)				\
 	do {						\
diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index e9294e1ed06e..2326aae6709e 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -393,7 +393,7 @@ int r8712_cmd_thread(void *context)
 		r8712_free_cmd_obj(pcmd);
 	} while (1);
 	complete(&pcmdpriv->terminate_cmdthread_comp);
-	thread_exit();
+	return 0;
 }
 
 void r8712_event_handle(struct _adapter *padapter, __le32 *peventbuf)
-- 
2.20.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C424351CC
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 19:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhJTRs2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 13:48:28 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43702 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhJTRrv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Oct 2021 13:47:51 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:50792)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeh-00EwSF-Ig; Wed, 20 Oct 2021 11:45:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:47894 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mdFeg-001NdN-5S; Wed, 20 Oct 2021 11:45:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 20 Oct 2021 12:44:06 -0500
Message-Id: <20211020174406.17889-20-ebiederm@xmission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y26nmwkb.fsf@disp2133>
References: <87y26nmwkb.fsf@disp2133>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1mdFeg-001NdN-5S;;;mid=<20211020174406.17889-20-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19D89HivmTg1v5eRhQNtIU+qPtwQAWtO8o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5028]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 458 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (1.9%), b_tie_ro: 7 (1.6%), parse: 0.92 (0.2%),
        extract_message_metadata: 11 (2.5%), get_uri_detail_list: 1.29 (0.3%),
        tests_pri_-1000: 13 (2.9%), tests_pri_-950: 1.32 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 160 (35.0%), check_bayes:
        159 (34.7%), b_tokenize: 7 (1.5%), b_tok_get_all: 4.8 (1.1%),
        b_comp_prob: 1.83 (0.4%), b_tok_touch_all: 142 (30.9%), b_finish: 0.99
        (0.2%), tests_pri_0: 245 (53.4%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 3.1 (0.7%), poll_dns_idle: 0.39 (0.1%), tests_pri_10:
        3.5 (0.8%), tests_pri_500: 10 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 20/20] exit/r8188eu: Replace the macro thread_exit with a simple return 0
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The macro thread_exit is called is at the end of functions started
with kthread_run.  The code in kthread_run has arranged things so a
kernel thread can just return and do_exit will be called.

So just have rtw_cmd_thread and mp_xmit_packet_thread return instead
of calling complete_and_exit.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c          | 2 +-
 drivers/staging/r8188eu/core/rtw_mp.c           | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ce73ac7cf973..d37c9463eecc 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -347,7 +347,7 @@ int rtw_cmd_thread(void *context)
 
 	up(&pcmdpriv->terminate_cmdthread_sema);
 
-	thread_exit();
+	return 0;
 }
 
 u8 rtw_setstandby_cmd(struct adapter *padapter, uint action)
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index dabdd0406f30..3945c4efe45a 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -580,7 +580,7 @@ static int mp_xmit_packet_thread(void *context)
 	pmptx->pallocated_buf = NULL;
 	pmptx->stop = 1;
 
-	thread_exit();
+	return 0;
 }
 
 void fill_txdesc_for_mp(struct adapter *padapter, struct tx_desc *ptxdesc)
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 029aa4e92c9b..afbffb551f9b 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -49,8 +49,6 @@ struct	__queue	{
 	spinlock_t lock;
 };
 
-#define thread_exit() complete_and_exit(NULL, 0)
-
 static inline struct list_head *get_list_head(struct __queue *queue)
 {
 	return (&(queue->queue));
-- 
2.20.1


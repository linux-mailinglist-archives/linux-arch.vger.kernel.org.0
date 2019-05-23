Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F31EC273CF
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 03:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfEWBIw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 21:08:52 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:51618 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfEWBIw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:08:52 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbn1-0002CZ-KQ; Wed, 22 May 2019 18:40:59 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbmz-0005Z3-RJ; Wed, 22 May 2019 18:40:59 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Jeff Layton <jlayton@primarydata.com>,
        Steve French <smfrench@gmail.com>
Date:   Wed, 22 May 2019 19:38:57 -0500
Message-Id: <20190523003916.20726-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbmz-0005Z3-RJ;;;mid=<20190523003916.20726-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//zQ7CJekG5SW/vQ+Tj7WmvEFfZeaRGZI=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *****
X-Spam-Status: No, score=5.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMGappySubj_01,XMNoVowels,XMSubLong,XM_H_QuotedFrom
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1432 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 2.5 (0.2%), b_tie_ro: 1.68 (0.1%), parse: 0.86
        (0.1%), extract_message_metadata: 18 (1.2%), get_uri_detail_list: 1.59
        (0.1%), tests_pri_-1000: 22 (1.5%), tests_pri_-950: 1.42 (0.1%),
        tests_pri_-900: 1.18 (0.1%), tests_pri_-90: 22 (1.5%), check_bayes: 20
        (1.4%), b_tokenize: 7 (0.5%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        2.3 (0.2%), b_tok_touch_all: 2.8 (0.2%), b_finish: 0.71 (0.0%),
        tests_pri_0: 1351 (94.3%), check_dkim_signature: 0.61 (0.0%),
        check_dkim_adsp: 2.6 (0.2%), poll_dns_idle: 0.83 (0.1%), tests_pri_10:
        3.2 (0.2%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 07/26] signal/cifs: Fix cifs_put_tcp_session to call send_sig instead of force_sig
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The locking in force_sig_info is not prepared to deal with a task that
exits or execs (as sighand may change).  The is not a locking problem
in force_sig as force_sig is only built to handle synchronous
exceptions.

Further the function force_sig_info changes the signal state if the
signal is ignored, or blocked or if SIGNAL_UNKILLABLE will prevent the
delivery of the signal.  The signal SIGKILL can not be ignored and can
not be blocked and SIGNAL_UNKILLABLE won't prevent it from being
delivered.

So using force_sig rather than send_sig for SIGKILL is confusing
and pointless.

Because it won't impact the sending of the signal and and because
using force_sig is wrong, replace force_sig with send_sig.

Cc: Namjae Jeon <namjae.jeon@samsung.com>
Cc: Jeff Layton <jlayton@primarydata.com>
Cc: Steve French <smfrench@gmail.com>
Fixes: a5c3e1c725af ("Revert "cifs: No need to send SIGKILL to demux_thread during umount"")
Fixes: e7ddee9037e7 ("cifs: disable sharing session and tcon and add new TCP sharing code")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/cifs/connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 8c4121da624e..ed22bffb3fcc 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2629,7 +2629,7 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
 
 	task = xchg(&server->tsk, NULL);
 	if (task)
-		force_sig(SIGKILL, task);
+		send_sig(SIGKILL, task, 1);
 }
 
 static struct TCP_Server_Info *
-- 
2.21.0


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 433E7273A1
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 02:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfEWA7U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 May 2019 20:59:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58557 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWA7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:59:20 -0400
X-Greylist: delayed 1147 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 May 2019 20:59:19 EDT
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbmm-0008In-Es; Wed, 22 May 2019 18:40:44 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbmk-0005Z3-Mi; Wed, 22 May 2019 18:40:44 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Date:   Wed, 22 May 2019 19:38:55 -0500
Message-Id: <20190523003916.20726-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1hTbmk-0005Z3-Mi;;;mid=<20190523003916.20726-6-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18NntcM0FKWTNmxwMnNgUDb57C06mdVwk0=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong,XM_H_QuotedFrom
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_H_QuotedFrom Sender address is in double quotes
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1269 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.5 (0.2%), b_tie_ro: 1.73 (0.1%), parse: 0.81
        (0.1%), extract_message_metadata: 14 (1.1%), get_uri_detail_list: 1.23
        (0.1%), tests_pri_-1000: 18 (1.4%), tests_pri_-950: 1.21 (0.1%),
        tests_pri_-900: 1.02 (0.1%), tests_pri_-90: 18 (1.4%), check_bayes: 17
        (1.3%), b_tokenize: 5 (0.4%), b_tok_get_all: 5 (0.4%), b_comp_prob:
        1.85 (0.1%), b_tok_touch_all: 2.7 (0.2%), b_finish: 0.58 (0.0%),
        tests_pri_0: 1197 (94.3%), check_dkim_signature: 0.51 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 0.81 (0.1%), tests_pri_10:
        4.1 (0.3%), tests_pri_500: 10 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 05/26] signal/bpfilter: Fix bpfilter_kernl to use send_sig not force_sig
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The locking in force_sig_info is not prepared to deal with
a task that exits or execs (as sighand may change).  As force_sig
is only built to handle synchronous exceptions.

Further the function force_sig_info changes the signal state if the
signal is ignored, or blocked or if SIGNAL_UNKILLABLE will prevent the
delivery of the signal.  The signal SIGKILL can not be ignored and can
not be blocked and SIGNAL_UNKILLABLE won't prevent it from being
delivered.

So using force_sig rather than send_sig for SIGKILL is pointless.

Because it won't impact the sending of the signal and and because
using force_sig is wrong, replace force_sig with send_sig.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Fixes: d2ba09c17a06 ("net: add skeleton of bpfilter kernel module")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 net/bpfilter/bpfilter_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 7ee4fea93637..c0f0990f30b6 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -22,7 +22,7 @@ static void shutdown_umh(void)
 
 	tsk = get_pid_task(find_vpid(bpfilter_ops.info.pid), PIDTYPE_PID);
 	if (tsk) {
-		force_sig(SIGKILL, tsk);
+		send_sig(SIGKILL, tsk, 1);
 		put_task_struct(tsk);
 	}
 }
-- 
2.21.0


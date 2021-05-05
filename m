Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98390373D5D
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 16:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhEEONQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 10:13:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57986 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbhEEOMu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 10:12:50 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFl-003DPE-6X; Wed, 05 May 2021 08:11:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFk-00007y-9b; Wed, 05 May 2021 08:11:52 -0600
From:   "Eric W. Beiderman" <ebiederm@xmission.com>
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  5 May 2021 09:11:01 -0500
Message-Id: <20210505141101.11519-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210505141101.11519-1-ebiederm@xmission.com>
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <20210505141101.11519-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1leIFk-00007y-9b;;;mid=<20210505141101.11519-12-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ZMXXVL6ruQ7cgP0DEKoYUOz/jMeRC+JY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 510 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 8 (1.6%), b_tie_ro: 7 (1.3%), parse: 1.38 (0.3%),
        extract_message_metadata: 17 (3.4%), get_uri_detail_list: 3.1 (0.6%),
        tests_pri_-1000: 15 (3.0%), tests_pri_-950: 1.16 (0.2%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 132 (25.9%), check_bayes:
        130 (25.5%), b_tokenize: 15 (2.8%), b_tok_get_all: 6 (1.2%),
        b_comp_prob: 3.4 (0.7%), b_tok_touch_all: 102 (20.1%), b_finish: 1.01
        (0.2%), tests_pri_0: 320 (62.7%), check_dkim_signature: 0.77 (0.2%),
        check_dkim_adsp: 2.4 (0.5%), poll_dns_idle: 0.44 (0.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 12/12] signalfd: Remove SIL_FAULT_PERF_EVENT fields from signalfd_siginfo
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

With the addition of ssi_perf_data and ssi_perf_type struct signalfd_siginfo
is dangerously close to running out of space.  All that remains is just
enough space for two additional 64bit fields.  A practice of adding all
possible siginfo_t fields into struct singalfd_siginfo can not be supported
as adding the missing fields ssi_lower, ssi_upper, and ssi_pkey would
require two 64bit fields and one 32bit fields.  In practice the fields
ssi_perf_data and ssi_perf_type can never be used by signalfd as the signal
that generates them always delivers them synchronously to the thread that
triggers them.

Therefore until someone actually needs the fields ssi_perf_data and
ssi_perf_type in signalfd_siginfo remove them.  This leaves a bit more room
for future expansion.

v1: https://lkml.kernel.org/r/20210503203814.25487-12-ebiederm@xmission.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/signalfd.c                 | 16 ++++++----------
 include/uapi/linux/signalfd.h |  4 +---
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 335ad39f3900..040e1cf90528 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -114,12 +114,13 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		break;
 	case SIL_FAULT_BNDERR:
 	case SIL_FAULT_PKUERR:
+	case SIL_FAULT_PERF_EVENT:
 		/*
-		 * Fall through to the SIL_FAULT case.  Both SIL_FAULT_BNDERR
-		 * and SIL_FAULT_PKUERR are only generated by faults that
-		 * deliver them synchronously to userspace.  In case someone
-		 * injects one of these signals and signalfd catches it treat
-		 * it as SIL_FAULT.
+		 * Fall through to the SIL_FAULT case.  SIL_FAULT_BNDERR,
+		 * SIL_FAULT_PKUERR, and SIL_FAULT_PERF_EVENT are only
+		 * generated by faults that deliver them synchronously to
+		 * userspace.  In case someone injects one of these signals
+		 * and signalfd catches it treat it as SIL_FAULT.
 		 */
 	case SIL_FAULT:
 		new.ssi_addr = (long) kinfo->si_addr;
@@ -132,11 +133,6 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		new.ssi_addr = (long) kinfo->si_addr;
 		new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
 		break;
-	case SIL_FAULT_PERF_EVENT:
-		new.ssi_addr = (long) kinfo->si_addr;
-		new.ssi_perf_type = kinfo->si_perf_type;
-		new.ssi_perf_data = kinfo->si_perf_data;
-		break;
 	case SIL_CHLD:
 		new.ssi_pid    = kinfo->si_pid;
 		new.ssi_uid    = kinfo->si_uid;
diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
index e78dddf433fc..83429a05b698 100644
--- a/include/uapi/linux/signalfd.h
+++ b/include/uapi/linux/signalfd.h
@@ -39,8 +39,6 @@ struct signalfd_siginfo {
 	__s32 ssi_syscall;
 	__u64 ssi_call_addr;
 	__u32 ssi_arch;
-	__u32 ssi_perf_type;
-	__u64 ssi_perf_data;
 
 	/*
 	 * Pad strcture to 128 bytes. Remember to update the
@@ -51,7 +49,7 @@ struct signalfd_siginfo {
 	 * comes out of a read(2) and we really don't want to have
 	 * a compat on read(2).
 	 */
-	__u8 __pad[16];
+	__u8 __pad[28];
 };
 
 
-- 
2.30.1


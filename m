Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12115375722
	for <lists+linux-arch@lfdr.de>; Thu,  6 May 2021 17:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhEFPaM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 May 2021 11:30:12 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:54040 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhEFP3s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 May 2021 11:29:48 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lefvf-005iqR-MM; Thu, 06 May 2021 09:28:43 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lefvd-006sGN-K7; Thu, 06 May 2021 09:28:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Weimer <fweimer@redhat.com>,
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
        kasan-dev <kasan-dev@googlegroups.com>
References: <m15z031z0a.fsf@fess.ebiederm.org>
        <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
        <m1r1irpc5v.fsf@fess.ebiederm.org>
        <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
        <m1czuapjpx.fsf@fess.ebiederm.org>
        <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
        <m14kfjh8et.fsf_-_@fess.ebiederm.org>
        <m1tuni8ano.fsf_-_@fess.ebiederm.org>
        <CAMuHMdUXh45iNmzrqqQc1kwD_OELHpujpst1BTMXDYTe7vKSCg@mail.gmail.com>
        <YJPIO7r2uLXsW9uK@elver.google.com>
Date:   Thu, 06 May 2021 10:28:37 -0500
In-Reply-To: <YJPIO7r2uLXsW9uK@elver.google.com> (Marco Elver's message of
        "Thu, 6 May 2021 12:43:07 +0200")
Message-ID: <m14kff6fve.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lefvd-006sGN-K7;;;mid=<m14kff6fve.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18VBUwGkvjVT/EuvDccLGPbA1rUG9welZ4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1433 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.1 (0.3%), b_tie_ro: 2.8 (0.2%), parse: 1.17
        (0.1%), extract_message_metadata: 11 (0.7%), get_uri_detail_list: 2.4
        (0.2%), tests_pri_-1000: 11 (0.8%), tests_pri_-950: 0.96 (0.1%),
        tests_pri_-900: 0.81 (0.1%), tests_pri_-90: 78 (5.5%), check_bayes: 77
        (5.4%), b_tokenize: 7 (0.5%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        1.88 (0.1%), b_tok_touch_all: 58 (4.1%), b_finish: 0.68 (0.0%),
        tests_pri_0: 1313 (91.6%), check_dkim_signature: 0.39 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 1.07 (0.1%), tests_pri_10:
        2.9 (0.2%), tests_pri_500: 8 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 00/12] signal: sort out si_trapno and si_perf
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


For the moment I am adding this to my for-next branch.  I plan to
respin and fold this in but I am not certain what my schedule looks like
today.  So I figure making certain I have a fix out (so I stop breaking
m68k) is more important than having a perfect patch.

Eric

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Thu, 6 May 2021 10:17:10 -0500
Subject: [PATCH] signal: Remove the last few si_perf references

I accidentially overlooked a few references to si_perf when sorting
out the ABI update those references now.

Fixes: f6a2c711f1e3 ("signal: Deliver all of the siginfo perf data in _perf")
Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/m68k/kernel/signal.c                             | 3 ++-
 include/uapi/linux/perf_event.h                       | 2 +-
 tools/testing/selftests/perf_events/sigtrap_threads.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index a4b7ee1df211..8f215e79e70e 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -623,7 +623,8 @@ static inline void siginfo_build_tests(void)
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x12);
 
 	/* _sigfault._perf */
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x10);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x10);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x14);
 
 	/* _sigpoll */
 	BUILD_BUG_ON(offsetof(siginfo_t, si_band)   != 0x0c);
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index e54e639248c8..7b14753b3d38 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -464,7 +464,7 @@ struct perf_event_attr {
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
-	 * siginfo_t::si_perf, e.g. to permit user to identify the event.
+	 * siginfo_t::si_perf_data, e.g. to permit user to identify the event.
 	 */
 	__u64	sig_data;
 };
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index fde123066a8c..8e83cf91513a 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -43,7 +43,7 @@ static struct {
 	siginfo_t first_siginfo;	/* First observed siginfo_t. */
 } ctx;
 
-/* Unique value to check si_perf is correctly set from perf_event_attr::sig_data. */
+/* Unique value to check si_perf_data is correctly set from perf_event_attr::sig_data. */
 #define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
 
 static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
-- 
2.30.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514363CBA46
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jul 2021 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhGPQKE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jul 2021 12:10:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33744 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhGPQKD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jul 2021 12:10:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:60690)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m4QMl-004cav-3N; Fri, 16 Jul 2021 10:07:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:59832 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1m4QMj-00DIze-Nq; Fri, 16 Jul 2021 10:07:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
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
        kasan-dev <kasan-dev@googlegroups.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <87a6mnzbx2.fsf_-_@disp2133>
Date:   Fri, 16 Jul 2021 11:06:26 -0500
In-Reply-To: <87a6mnzbx2.fsf_-_@disp2133> (Eric W. Biederman's message of
        "Thu, 15 Jul 2021 13:09:45 -0500")
Message-ID: <875yxaxmyl.fsf_-_@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1m4QMj-00DIze-Nq;;;mid=<875yxaxmyl.fsf_-_@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/qXW5a3TFDnSO7his2S9IbRRvEYot9giY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *****
X-Spam-Status: No, score=5.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,T_TooManySym_01,
        T_XMDrugObfuBody_08,XMNoVowels,XMSubLong,XM_B_SpammyTLD
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 766 ms - load_scoreonly_sql: 0.16 (0.0%),
        signal_user_changed: 10 (1.3%), b_tie_ro: 9 (1.1%), parse: 1.71 (0.2%),
         extract_message_metadata: 20 (2.6%), get_uri_detail_list: 5 (0.7%),
        tests_pri_-1000: 15 (1.9%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.11 (0.1%), tests_pri_-90: 235 (30.7%), check_bayes:
        233 (30.4%), b_tokenize: 14 (1.8%), b_tok_get_all: 7 (0.9%),
        b_comp_prob: 3.4 (0.4%), b_tok_touch_all: 205 (26.7%), b_finish: 0.90
        (0.1%), tests_pri_0: 469 (61.2%), check_dkim_signature: 0.71 (0.1%),
        check_dkim_adsp: 2.6 (0.3%), poll_dns_idle: 0.64 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 7/7] signal: Verify the alignment and size of siginfo_t
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Update the static assertions about siginfo_t to also describe
it's alignment and size.

While investigating if it was possible to add a 64bit field into
siginfo_t[1] it became apparent that the alignment of siginfo_t
is as much a part of the ABI as the size of the structure.

If the alignment changes siginfo_t when embedded in another structure
can move to a different offset.  Which is not acceptable from an ABI
structure.

So document that fact and add static assertions to notify developers
if they change change the alignment by accident.

[1] https://lkml.kernel.org/r/YJEZdhe6JGFNYlum@elver.google.com
Acked-by: Marco Elver <elver@google.com>
v1: https://lkml.kernel.org/r/20210505141101.11519-4-ebiederm@xmission.co
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/kernel/signal.c           | 2 ++
 arch/arm64/kernel/signal.c         | 2 ++
 arch/arm64/kernel/signal32.c       | 2 ++
 arch/sparc/kernel/signal32.c       | 2 ++
 arch/sparc/kernel/signal_64.c      | 2 ++
 arch/x86/kernel/signal_compat.c    | 6 ++++++
 include/uapi/asm-generic/siginfo.h | 5 +++++
 7 files changed, 21 insertions(+)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 7ef453e8a96f..f3800c0f428b 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -737,6 +737,8 @@ static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
 static_assert(NSIGSYS	== 2);
+static_assert(sizeof(siginfo_t) == 128);
+static_assert(__alignof__(siginfo_t) == 4);
 static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
 static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
 static_assert(offsetof(siginfo_t, si_code)	== 0x08);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 4413b6a4e32a..d3721e01441b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1011,6 +1011,8 @@ static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
 static_assert(NSIGSYS	== 2);
+static_assert(sizeof(siginfo_t) == 128);
+static_assert(__alignof__(siginfo_t) == 8);
 static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
 static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
 static_assert(offsetof(siginfo_t, si_code)	== 0x08);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index ab1775216712..d3be01c46bec 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -469,6 +469,8 @@ static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
 static_assert(NSIGSYS	== 2);
+static_assert(sizeof(compat_siginfo_t) == 128);
+static_assert(__alignof__(compat_siginfo_t) == 4);
 static_assert(offsetof(compat_siginfo_t, si_signo)	== 0x00);
 static_assert(offsetof(compat_siginfo_t, si_errno)	== 0x04);
 static_assert(offsetof(compat_siginfo_t, si_code)	== 0x08);
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 65fd26ae9d25..4276b9e003ca 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -757,6 +757,8 @@ static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
 static_assert(NSIGSYS	== 2);
+static_assert(sizeof(compat_siginfo_t) == 128);
+static_assert(__alignof__(compat_siginfo_t) == 4);
 static_assert(offsetof(compat_siginfo_t, si_signo)	== 0x00);
 static_assert(offsetof(compat_siginfo_t, si_errno)	== 0x04);
 static_assert(offsetof(compat_siginfo_t, si_code)	== 0x08);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index a58e0cc45d24..cea23cf95600 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -567,6 +567,8 @@ static_assert(NSIGBUS	== 5);
 static_assert(NSIGTRAP	== 6);
 static_assert(NSIGCHLD	== 6);
 static_assert(NSIGSYS	== 2);
+static_assert(sizeof(siginfo_t) == 128);
+static_assert(__alignof__(siginfo_t) == 8);
 static_assert(offsetof(siginfo_t, si_signo)	== 0x00);
 static_assert(offsetof(siginfo_t, si_errno)	== 0x04);
 static_assert(offsetof(siginfo_t, si_code)	== 0x08);
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 06743ec054d2..b52407c56000 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -34,7 +34,13 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGSYS  != 2);
 
 	/* This is part of the ABI and can never change in size: */
+	BUILD_BUG_ON(sizeof(siginfo_t) != 128);
 	BUILD_BUG_ON(sizeof(compat_siginfo_t) != 128);
+
+	/* This is a part of the ABI and can never change in alignment */
+	BUILD_BUG_ON(__alignof__(siginfo_t) != 8);
+	BUILD_BUG_ON(__alignof__(compat_siginfo_t) != 4);
+
 	/*
 	 * The offsets of all the (unioned) si_fields are fixed
 	 * in the ABI, of course.  Make sure none of them ever
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 5a3c221f4c9d..3ba180f550d7 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -29,6 +29,11 @@ typedef union sigval {
 #define __ARCH_SI_ATTRIBUTES
 #endif
 
+/*
+ * Be careful when extending this union.  On 32bit siginfo_t is 32bit
+ * aligned.  Which means that a 64bit field or any other field that
+ * would increase the alignment of siginfo_t will break the ABI.
+ */
 union __sifields {
 	/* kill() */
 	struct {
-- 
2.20.1


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED300373D32
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbhEEOMZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 May 2021 10:12:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57674 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhEEOMY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 May 2021 10:12:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFL-003DB2-5n; Wed, 05 May 2021 08:11:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIFJ-00007y-Dn; Wed, 05 May 2021 08:11:26 -0600
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
Date:   Wed,  5 May 2021 09:10:54 -0500
Message-Id: <20210505141101.11519-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210505141101.11519-1-ebiederm@xmission.com>
References: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
 <20210505141101.11519-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1leIFJ-00007y-Dn;;;mid=<20210505141101.11519-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX193/sNNsEzFeClA7fw6ofCtHebW1VKeDf4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_XMDrugObfuBody_08,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 892 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.2%), b_tie_ro: 9 (1.0%), parse: 1.04 (0.1%),
         extract_message_metadata: 13 (1.5%), get_uri_detail_list: 3.8 (0.4%),
        tests_pri_-1000: 12 (1.4%), tests_pri_-950: 1.17 (0.1%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 122 (13.7%), check_bayes:
        120 (13.5%), b_tokenize: 14 (1.6%), b_tok_get_all: 10 (1.2%),
        b_comp_prob: 2.5 (0.3%), b_tok_touch_all: 90 (10.1%), b_finish: 0.99
        (0.1%), tests_pri_0: 638 (71.5%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 0.64 (0.1%), tests_pri_10:
        3.7 (0.4%), tests_pri_500: 86 (9.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 05/12] siginfo: Move si_trapno inside the union inside _si_fault
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

It turns out that linux uses si_trapno very sparingly, and as such it
can be considered extra information for a very narrow selection of
signals, rather than information that is present with every fault
reported in siginfo.

As such move si_trapno inside the union inside of _si_fault.  This
results in no change in placement, and makes it eaiser
to extend _si_fault in the future as this reduces the number of
special cases.  In particular with si_trapno included in the union it
is no longer a concern that the union must be pointer alligned on most
architectures because the union followes immediately after si_addr
which is a pointer.

This change results in a difference in siginfo field placement on
sparc and alpha for the fields si_addr_lsb, si_lower, si_upper,
si_pkey, and si_perf.  These architectures do not implement the
signals that would use si_addr_lsb, si_lower, si_upper, si_pkey, and
si_perf.  Further these architecture have not yet implemented the
userspace that would use si_perf.

The point of this change is in fact to correct these placement issues
before sparc or alpha grow userspace that cares.  This change was
discussed[1] and the agreement is that this change is currently safe.

[1]: https://lkml.kernel.org/r/CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com
Acked-by: Marco Elver <elver@google.com>
v1: https://lkml.kernel.org/r/m1tunns7yf.fsf_-_@fess.ebiederm.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/sparc/kernel/signal32.c       | 10 +++++-----
 arch/sparc/kernel/signal_64.c      | 10 +++++-----
 arch/x86/kernel/signal_compat.c    |  3 +++
 include/linux/compat.h             |  5 ++---
 include/uapi/asm-generic/siginfo.h |  7 ++-----
 kernel/signal.c                    |  1 +
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 32b977f253e3..5573722e34ad 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -774,10 +774,10 @@ static_assert(offsetof(compat_siginfo_t, si_int)	== 0x14);
 static_assert(offsetof(compat_siginfo_t, si_ptr)	== 0x14);
 static_assert(offsetof(compat_siginfo_t, si_addr)	== 0x0c);
 static_assert(offsetof(compat_siginfo_t, si_trapno)	== 0x10);
-static_assert(offsetof(compat_siginfo_t, si_addr_lsb)	== 0x14);
-static_assert(offsetof(compat_siginfo_t, si_lower)	== 0x18);
-static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x1c);
-static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x18);
-static_assert(offsetof(compat_siginfo_t, si_perf)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_addr_lsb)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_lower)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x18);
+static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x14);
+static_assert(offsetof(compat_siginfo_t, si_perf)	== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index e9dda9db156c..a69a78984c36 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -584,10 +584,10 @@ static_assert(offsetof(siginfo_t, si_int)	== 0x18);
 static_assert(offsetof(siginfo_t, si_ptr)	== 0x18);
 static_assert(offsetof(siginfo_t, si_addr)	== 0x10);
 static_assert(offsetof(siginfo_t, si_trapno)	== 0x18);
-static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x20);
-static_assert(offsetof(siginfo_t, si_lower)	== 0x28);
-static_assert(offsetof(siginfo_t, si_upper)	== 0x30);
-static_assert(offsetof(siginfo_t, si_pkey)	== 0x28);
-static_assert(offsetof(siginfo_t, si_perf)	== 0x20);
+static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x18);
+static_assert(offsetof(siginfo_t, si_lower)	== 0x20);
+static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
+static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
+static_assert(offsetof(siginfo_t, si_perf)	== 0x18);
 static_assert(offsetof(siginfo_t, si_band)	== 0x10);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x14);
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index e735bc129331..c9601f092a1e 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -133,6 +133,9 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(offsetof(siginfo_t, si_addr) != 0x10);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_addr) != 0x0C);
 
+	BUILD_BUG_ON(offsetof(siginfo_t, si_trapno) != 0x18);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_trapno) != 0x10);
+
 	BUILD_BUG_ON(offsetof(siginfo_t, si_addr_lsb) != 0x18);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_addr_lsb) != 0x10);
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index f0d2dd35d408..6af7bef15e94 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -214,12 +214,11 @@ typedef struct compat_siginfo {
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
 		struct {
 			compat_uptr_t _addr;	/* faulting insn/memory ref. */
-#ifdef __ARCH_SI_TRAPNO
-			int _trapno;	/* TRAP # which caused the signal */
-#endif
 #define __COMPAT_ADDR_BND_PKEY_PAD  (__alignof__(compat_uptr_t) < sizeof(short) ? \
 				     sizeof(short) : __alignof__(compat_uptr_t))
 			union {
+				/* used on alpha and sparc */
+				int _trapno;	/* TRAP # which caused the signal */
 				/*
 				 * used when si_code=BUS_MCEERR_AR or
 				 * used when si_code=BUS_MCEERR_AO
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 91c80d0c10c5..3503282021aa 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -68,9 +68,6 @@ union __sifields {
 	/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
 	struct {
 		void __user *_addr; /* faulting insn/memory ref. */
-#ifdef __ARCH_SI_TRAPNO
-		int _trapno;	/* TRAP # which caused the signal */
-#endif
 #ifdef __ia64__
 		int _imm;		/* immediate value for "break" */
 		unsigned int _flags;	/* see ia64 si_flags */
@@ -80,6 +77,8 @@ union __sifields {
 #define __ADDR_BND_PKEY_PAD  (__alignof__(void *) < sizeof(short) ? \
 			      sizeof(short) : __alignof__(void *))
 		union {
+			/* used on alpha and sparc */
+			int _trapno;	/* TRAP # which caused the signal */
 			/*
 			 * used when si_code=BUS_MCEERR_AR or
 			 * used when si_code=BUS_MCEERR_AO
@@ -155,9 +154,7 @@ typedef struct siginfo {
 #define si_int		_sifields._rt._sigval.sival_int
 #define si_ptr		_sifields._rt._sigval.sival_ptr
 #define si_addr		_sifields._sigfault._addr
-#ifdef __ARCH_SI_TRAPNO
 #define si_trapno	_sifields._sigfault._trapno
-#endif
 #define si_addr_lsb	_sifields._sigfault._addr_lsb
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
diff --git a/kernel/signal.c b/kernel/signal.c
index c3017aa8024a..65888aec65a0 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4607,6 +4607,7 @@ static inline void siginfo_buildtime_checks(void)
 
 	/* sigfault */
 	CHECK_OFFSET(si_addr);
+	CHECK_OFFSET(si_trapno);
 	CHECK_OFFSET(si_addr_lsb);
 	CHECK_OFFSET(si_lower);
 	CHECK_OFFSET(si_upper);
-- 
2.30.1


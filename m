Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA6B3721A2
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhECUkX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 16:40:23 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51124 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhECUkO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 16:40:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldfLc-008idE-C8; Mon, 03 May 2021 14:39:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldfLa-00E76Y-W2; Mon, 03 May 2021 14:39:19 -0600
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
Date:   Mon,  3 May 2021 15:38:12 -0500
Message-Id: <20210503203814.25487-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210503203814.25487-1-ebiederm@xmission.com>
References: <m14kfjh8et.fsf_-_@fess.ebiederm.org>
 <20210503203814.25487-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ldfLa-00E76Y-W2;;;mid=<20210503203814.25487-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/b9rhYWU75jryiJcDUuXS48JL3MxtXE3c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 622 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (2.4%), b_tie_ro: 13 (2.1%), parse: 1.79
        (0.3%), extract_message_metadata: 15 (2.4%), get_uri_detail_list: 4.1
        (0.7%), tests_pri_-1000: 12 (1.9%), tests_pri_-950: 1.44 (0.2%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 145 (23.4%), check_bayes:
        143 (23.0%), b_tokenize: 14 (2.2%), b_tok_get_all: 10 (1.6%),
        b_comp_prob: 3.1 (0.5%), b_tok_touch_all: 111 (17.8%), b_finish: 1.28
        (0.2%), tests_pri_0: 416 (67.0%), check_dkim_signature: 0.60 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 0.98 (0.2%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 10/12] signal: Redefine signinfo so 64bit fields are possible
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

The si_perf code really wants to add a u64 field.  This change enables
that by reorganizing the definition of siginfo_t, so that a 64bit
field can be added without increasing the alignment of other fields.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/signal_compat.c    |  9 +++----
 include/linux/compat.h             | 28 +++++++++++++-------
 include/uapi/asm-generic/siginfo.h | 42 ++++++++++++++++++++----------
 3 files changed, 49 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index a9fcabd8a5e5..a5cd01c52dfb 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -17,8 +17,6 @@
  */
 static inline void signal_compat_build_tests(void)
 {
-	int _sifields_offset = offsetof(compat_siginfo_t, _sifields);
-
 	/*
 	 * If adding a new si_code, there is probably new data in
 	 * the siginfo.  Make sure folks bumping the si_code
@@ -40,8 +38,7 @@ static inline void signal_compat_build_tests(void)
 	 * in the ABI, of course.  Make sure none of them ever
 	 * move and are always at the beginning:
 	 */
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, _sifields) != 3 * sizeof(int));
-#define CHECK_CSI_OFFSET(name)	  BUILD_BUG_ON(_sifields_offset != offsetof(compat_siginfo_t, _sifields.name))
+#define CHECK_CSI_OFFSET(name)	  BUILD_BUG_ON(0 != offsetof(compat_siginfo_t, _sifields.name))
 
 	BUILD_BUG_ON(offsetof(siginfo_t, si_signo) != 0);
 	BUILD_BUG_ON(offsetof(siginfo_t, si_errno) != 4);
@@ -63,8 +60,8 @@ static inline void signal_compat_build_tests(void)
 	 * structure stays within the padding size (checked
 	 * above).
 	 */
-#define CHECK_CSI_SIZE(name, size) BUILD_BUG_ON(size != sizeof(((compat_siginfo_t *)0)->_sifields.name))
-#define CHECK_SI_SIZE(name, size) BUILD_BUG_ON(size != sizeof(((siginfo_t *)0)->_sifields.name))
+#define CHECK_CSI_SIZE(name, size) BUILD_BUG_ON(((3*sizeof(int))+(size)) != sizeof(((compat_siginfo_t *)0)->_sifields.name))
+#define CHECK_SI_SIZE(name, size) BUILD_BUG_ON(((4*sizeof(int))+(size)) != sizeof(((siginfo_t *)0)->_sifields.name))
 
 	CHECK_CSI_OFFSET(_kill);
 	CHECK_CSI_SIZE  (_kill, 2*sizeof(int));
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6af7bef15e94..d81493248bf3 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -158,27 +158,28 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
-typedef struct compat_siginfo {
-	int si_signo;
-#ifndef __ARCH_HAS_SWAPPED_SIGINFO
-	int si_errno;
-	int si_code;
-#else
-	int si_code;
-	int si_errno;
-#endif
+#define __COMPAT_SIGINFO_COMMON	\
+	___SIGINFO_COMMON;	\
+	int	_common_pad[__alignof__(compat_uptr_t) != __alignof__(int)]
 
+typedef struct compat_siginfo {
+	union {
+		struct {
+			__COMPAT_SIGINFO_COMMON;
+		};
 	union {
-		int _pad[128/sizeof(int) - 3];
+		int _pad[128/sizeof(int)];
 
 		/* kill() */
 		struct {
+			__COMPAT_SIGINFO_COMMON;
 			compat_pid_t _pid;	/* sender's pid */
 			__compat_uid32_t _uid;	/* sender's uid */
 		} _kill;
 
 		/* POSIX.1b timers */
 		struct {
+			__COMPAT_SIGINFO_COMMON;
 			compat_timer_t _tid;	/* timer id */
 			int _overrun;		/* overrun count */
 			compat_sigval_t _sigval;	/* same as below */
@@ -186,6 +187,7 @@ typedef struct compat_siginfo {
 
 		/* POSIX.1b signals */
 		struct {
+			__COMPAT_SIGINFO_COMMON;
 			compat_pid_t _pid;	/* sender's pid */
 			__compat_uid32_t _uid;	/* sender's uid */
 			compat_sigval_t _sigval;
@@ -193,6 +195,7 @@ typedef struct compat_siginfo {
 
 		/* SIGCHLD */
 		struct {
+			__COMPAT_SIGINFO_COMMON;
 			compat_pid_t _pid;	/* which child */
 			__compat_uid32_t _uid;	/* sender's uid */
 			int _status;		/* exit code */
@@ -203,6 +206,7 @@ typedef struct compat_siginfo {
 #ifdef CONFIG_X86_X32_ABI
 		/* SIGCHLD (x32 version) */
 		struct {
+			__COMPAT_SIGINFO_COMMON;
 			compat_pid_t _pid;	/* which child */
 			__compat_uid32_t _uid;	/* sender's uid */
 			int _status;		/* exit code */
@@ -213,6 +217,7 @@ typedef struct compat_siginfo {
 
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
 		struct {
+			__COMPAT_SIGINFO_COMMON;
 			compat_uptr_t _addr;	/* faulting insn/memory ref. */
 #define __COMPAT_ADDR_BND_PKEY_PAD  (__alignof__(compat_uptr_t) < sizeof(short) ? \
 				     sizeof(short) : __alignof__(compat_uptr_t))
@@ -242,16 +247,19 @@ typedef struct compat_siginfo {
 
 		/* SIGPOLL */
 		struct {
+			__COMPAT_SIGINFO_COMMON;
 			compat_long_t _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
 			int _fd;
 		} _sigpoll;
 
 		struct {
+			__COMPAT_SIGINFO_COMMON;
 			compat_uptr_t _call_addr; /* calling user insn */
 			int _syscall;	/* triggering system call number */
 			unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
 		} _sigsys;
 	} _sifields;
+	};
 } compat_siginfo_t;
 
 struct compat_rlimit {
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index e663bf117b46..1fcede623a73 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -29,15 +29,33 @@ typedef union sigval {
 #define __ARCH_SI_ATTRIBUTES
 #endif
 
+#ifndef __ARCH_HAS_SWAPPED_SIGINFO
+#define ___SIGINFO_COMMON	\
+	int	si_signo;	\
+	int	si_errno;	\
+	int	si_code
+#else
+#define ___SIGINFO_COMMON	\
+	int	si_signo;	\
+	int	si_code;	\
+	int	si_errno
+#endif /* __ARCH_HAS_SWAPPED_SIGINFO */
+
+#define __SIGINFO_COMMON	\
+	___SIGINFO_COMMON;	\
+	int	_common_pad[__alignof__(void *) != __alignof(int)]
+
 union __sifields {
 	/* kill() */
 	struct {
+		__SIGINFO_COMMON;
 		__kernel_pid_t _pid;	/* sender's pid */
 		__kernel_uid32_t _uid;	/* sender's uid */
 	} _kill;
 
 	/* POSIX.1b timers */
 	struct {
+		__SIGINFO_COMMON;
 		__kernel_timer_t _tid;	/* timer id */
 		int _overrun;		/* overrun count */
 		sigval_t _sigval;	/* same as below */
@@ -46,6 +64,7 @@ union __sifields {
 
 	/* POSIX.1b signals */
 	struct {
+		__SIGINFO_COMMON;
 		__kernel_pid_t _pid;	/* sender's pid */
 		__kernel_uid32_t _uid;	/* sender's uid */
 		sigval_t _sigval;
@@ -53,6 +72,7 @@ union __sifields {
 
 	/* SIGCHLD */
 	struct {
+		__SIGINFO_COMMON;
 		__kernel_pid_t _pid;	/* which child */
 		__kernel_uid32_t _uid;	/* sender's uid */
 		int _status;		/* exit code */
@@ -62,6 +82,7 @@ union __sifields {
 
 	/* SIGILL, SIGFPE, SIGSEGV, SIGBUS, SIGTRAP, SIGEMT */
 	struct {
+		__SIGINFO_COMMON;
 		void __user *_addr; /* faulting insn/memory ref. */
 #ifdef __ia64__
 		int _imm;		/* immediate value for "break" */
@@ -97,35 +118,28 @@ union __sifields {
 
 	/* SIGPOLL */
 	struct {
+		__SIGINFO_COMMON;
 		__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
 		int _fd;
 	} _sigpoll;
 
 	/* SIGSYS */
 	struct {
+		__SIGINFO_COMMON;
 		void __user *_call_addr; /* calling user insn */
 		int _syscall;	/* triggering system call number */
 		unsigned int _arch;	/* AUDIT_ARCH_* of syscall */
 	} _sigsys;
 };
 
-#ifndef __ARCH_HAS_SWAPPED_SIGINFO
-#define __SIGINFO 			\
-struct {				\
-	int si_signo;			\
-	int si_errno;			\
-	int si_code;			\
-	union __sifields _sifields;	\
-}
-#else
+
 #define __SIGINFO 			\
-struct {				\
-	int si_signo;			\
-	int si_code;			\
-	int si_errno;			\
+union {					\
+	struct {			\
+		__SIGINFO_COMMON;	\
+	};				\
 	union __sifields _sifields;	\
 }
-#endif /* __ARCH_HAS_SWAPPED_SIGINFO */
 
 typedef struct siginfo {
 	union {
-- 
2.30.1


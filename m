Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52063721AB
	for <lists+linux-arch@lfdr.de>; Mon,  3 May 2021 22:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhECUkh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 May 2021 16:40:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51148 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhECUkR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2021 16:40:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldfLf-008idX-IM; Mon, 03 May 2021 14:39:23 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldfLd-00E76Y-VQ; Mon, 03 May 2021 14:39:23 -0600
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
Date:   Mon,  3 May 2021 15:38:13 -0500
Message-Id: <20210503203814.25487-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210503203814.25487-1-ebiederm@xmission.com>
References: <m14kfjh8et.fsf_-_@fess.ebiederm.org>
 <20210503203814.25487-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ldfLd-00E76Y-VQ;;;mid=<20210503203814.25487-11-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+bzPYRYibdy0R+G587IrUT/EYzKb62WUI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,T_XMDrugObfuBody_08,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 
X-Spam-Combo: ****;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 996 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 11 (1.1%), b_tie_ro: 9 (0.9%), parse: 1.87 (0.2%),
         extract_message_metadata: 23 (2.3%), get_uri_detail_list: 6 (0.6%),
        tests_pri_-1000: 15 (1.6%), tests_pri_-950: 1.53 (0.2%),
        tests_pri_-900: 1.19 (0.1%), tests_pri_-90: 184 (18.4%), check_bayes:
        181 (18.2%), b_tokenize: 24 (2.4%), b_tok_get_all: 11 (1.1%),
        b_comp_prob: 3.3 (0.3%), b_tok_touch_all: 138 (13.8%), b_finish: 1.22
        (0.1%), tests_pri_0: 734 (73.7%), check_dkim_signature: 0.90 (0.1%),
        check_dkim_adsp: 2.8 (0.3%), poll_dns_idle: 0.74 (0.1%), tests_pri_10:
        2.7 (0.3%), tests_pri_500: 15 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 11/12] signal: Deliver all of the siginfo perf data in _perf
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Don't abuse si_errno and deliver all of the perf data in _perf member
of siginfo_t.

Because it is possible increase the size of perf_data to 64bits.

v1: https://lkml.kernel.org/r/m11rarqqx2.fsf_-_@fess.ebiederm.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm/kernel/signal.c                      |  3 ++-
 arch/arm64/kernel/signal.c                    |  3 ++-
 arch/arm64/kernel/signal32.c                  |  3 ++-
 arch/sparc/kernel/signal32.c                  |  3 ++-
 arch/sparc/kernel/signal_64.c                 |  3 ++-
 arch/x86/kernel/signal_compat.c               |  8 ++++---
 fs/signalfd.c                                 |  3 ++-
 include/linux/compat.h                        |  5 ++++-
 include/uapi/asm-generic/siginfo.h            |  8 +++++--
 include/uapi/linux/signalfd.h                 |  4 ++--
 kernel/signal.c                               | 21 ++++++++++++-------
 .../selftests/perf_events/sigtrap_threads.c   | 12 +++++------
 12 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 2dac5d2c5cf6..ffd3cb8dadea 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -755,7 +755,8 @@ static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x10);
 static_assert(offsetof(siginfo_t, si_lower)	== 0x14);
 static_assert(offsetof(siginfo_t, si_upper)	== 0x18);
 static_assert(offsetof(siginfo_t, si_pkey)	== 0x14);
-static_assert(offsetof(siginfo_t, si_perf)	== 0x10);
+static_assert(offsetof(siginfo_t, si_perf_data)	== 0x10);
+static_assert(offsetof(siginfo_t, si_perf_type)	== 0x18);
 static_assert(offsetof(siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x10);
 static_assert(offsetof(siginfo_t, si_call_addr)	== 0x0c);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index af8bd2af1298..f6cbbc54861e 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -1003,7 +1003,8 @@ static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x18);
 static_assert(offsetof(siginfo_t, si_lower)	== 0x20);
 static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
 static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
-static_assert(offsetof(siginfo_t, si_perf)	== 0x18);
+static_assert(offsetof(siginfo_t, si_perf_data)	== 0x18);
+static_assert(offsetof(siginfo_t, si_perf_type)	== 0x20);
 static_assert(offsetof(siginfo_t, si_band)	== 0x10);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x18);
 static_assert(offsetof(siginfo_t, si_call_addr)	== 0x10);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index b6afb646515f..8241dcc43d7f 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -487,7 +487,8 @@ static_assert(offsetof(compat_siginfo_t, si_addr_lsb)	== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_lower)	== 0x14);
 static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x14);
-static_assert(offsetof(compat_siginfo_t, si_perf)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_perf_data)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_perf_type)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_call_addr)	== 0x0c);
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 73fd8700df3e..1c8b60dd27d8 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -776,6 +776,7 @@ static_assert(offsetof(compat_siginfo_t, si_addr_lsb)	== 0x10);
 static_assert(offsetof(compat_siginfo_t, si_lower)	== 0x14);
 static_assert(offsetof(compat_siginfo_t, si_upper)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_pkey)	== 0x14);
-static_assert(offsetof(compat_siginfo_t, si_perf)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_perf_data)	== 0x10);
+static_assert(offsetof(compat_siginfo_t, si_perf_type)	== 0x18);
 static_assert(offsetof(compat_siginfo_t, si_band)	== 0x0c);
 static_assert(offsetof(compat_siginfo_t, si_fd)		== 0x10);
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 17913daa66c6..a58e0cc45d24 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -586,6 +586,7 @@ static_assert(offsetof(siginfo_t, si_addr_lsb)	== 0x18);
 static_assert(offsetof(siginfo_t, si_lower)	== 0x20);
 static_assert(offsetof(siginfo_t, si_upper)	== 0x28);
 static_assert(offsetof(siginfo_t, si_pkey)	== 0x20);
-static_assert(offsetof(siginfo_t, si_perf)	== 0x18);
+static_assert(offsetof(siginfo_t, si_perf_data)	== 0x18);
+static_assert(offsetof(siginfo_t, si_perf_type)	== 0x20);
 static_assert(offsetof(siginfo_t, si_band)	== 0x10);
 static_assert(offsetof(siginfo_t, si_fd)	== 0x14);
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index a5cd01c52dfb..a81310fe9e8a 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -118,7 +118,7 @@ static inline void signal_compat_build_tests(void)
 #endif
 
 	CHECK_CSI_OFFSET(_sigfault);
-	CHECK_CSI_SIZE  (_sigfault, 4*sizeof(int));
+	CHECK_CSI_SIZE  (_sigfault, 5*sizeof(int));
 	CHECK_SI_SIZE   (_sigfault, 8*sizeof(int));
 
 	BUILD_BUG_ON(offsetof(siginfo_t, si_addr) != 0x10);
@@ -138,8 +138,10 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x20);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pkey) != 0x14);
 
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf) != 0x10);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x18);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x20);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_data) != 0x10);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_type) != 0x18);
 
 	CHECK_CSI_OFFSET(_sigpoll);
 	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
diff --git a/fs/signalfd.c b/fs/signalfd.c
index 83130244f653..335ad39f3900 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -134,7 +134,8 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		break;
 	case SIL_FAULT_PERF_EVENT:
 		new.ssi_addr = (long) kinfo->si_addr;
-		new.ssi_perf = kinfo->si_perf;
+		new.ssi_perf_type = kinfo->si_perf_type;
+		new.ssi_perf_data = kinfo->si_perf_data;
 		break;
 	case SIL_CHLD:
 		new.ssi_pid    = kinfo->si_pid;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index d81493248bf3..9190a1c2aac7 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -241,7 +241,10 @@ typedef struct compat_siginfo {
 					u32 _pkey;
 				} _addr_pkey;
 				/* used when si_code=TRAP_PERF */
-				compat_ulong_t _perf;
+				struct {
+					u64 _data;
+					u32 _type;
+				} _perf;
 			};
 		} _sigfault;
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 1fcede623a73..dbe3dd90876f 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -112,7 +112,10 @@ union __sifields {
 				__u32 _pkey;
 			} _addr_pkey;
 			/* used when si_code=TRAP_PERF */
-			unsigned long _perf;
+			struct {
+				__u64 _data;
+				__u32 _type;
+			} _perf;
 		};
 	} _sigfault;
 
@@ -168,7 +171,8 @@ typedef struct siginfo {
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
 #define si_pkey		_sifields._sigfault._addr_pkey._pkey
-#define si_perf		_sifields._sigfault._perf
+#define si_perf_data	_sifields._sigfault._perf._data
+#define si_perf_type	_sifields._sigfault._perf._type
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 #define si_call_addr	_sifields._sigsys._call_addr
diff --git a/include/uapi/linux/signalfd.h b/include/uapi/linux/signalfd.h
index 7e333042c7e3..e78dddf433fc 100644
--- a/include/uapi/linux/signalfd.h
+++ b/include/uapi/linux/signalfd.h
@@ -39,8 +39,8 @@ struct signalfd_siginfo {
 	__s32 ssi_syscall;
 	__u64 ssi_call_addr;
 	__u32 ssi_arch;
-	__u32 __pad3;
-	__u64 ssi_perf;
+	__u32 ssi_perf_type;
+	__u64 ssi_perf_data;
 
 	/*
 	 * Pad strcture to 128 bytes. Remember to update the
diff --git a/kernel/signal.c b/kernel/signal.c
index 49560ceac048..7fec9d1c5b11 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1758,11 +1758,13 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
 	struct kernel_siginfo info;
 
 	clear_siginfo(&info);
-	info.si_signo = SIGTRAP;
-	info.si_errno = type;
-	info.si_code  = TRAP_PERF;
-	info.si_addr  = addr;
-	info.si_perf  = sig_data;
+	info.si_signo     = SIGTRAP;
+	info.si_errno     = 0;
+	info.si_code      = TRAP_PERF;
+	info.si_addr      = addr;
+	info.si_perf_data = sig_data;
+	info.si_perf_type = type;
+
 	return force_sig_info(&info);
 }
 
@@ -3380,7 +3382,8 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 		break;
 	case SIL_FAULT_PERF_EVENT:
 		to->si_addr = ptr_to_compat(from->si_addr);
-		to->si_perf = from->si_perf;
+		to->si_perf_data = from->si_perf_data;
+		to->si_perf_type = from->si_perf_type;
 		break;
 	case SIL_CHLD:
 		to->si_pid = from->si_pid;
@@ -3456,7 +3459,8 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 		break;
 	case SIL_FAULT_PERF_EVENT:
 		to->si_addr = compat_ptr(from->si_addr);
-		to->si_perf = from->si_perf;
+		to->si_perf_data = from->si_perf_data;
+		to->si_perf_type = from->si_perf_type;
 		break;
 	case SIL_CHLD:
 		to->si_pid    = from->si_pid;
@@ -4639,7 +4643,8 @@ static inline void siginfo_buildtime_checks(void)
 	CHECK_OFFSET(si_lower);
 	CHECK_OFFSET(si_upper);
 	CHECK_OFFSET(si_pkey);
-	CHECK_OFFSET(si_perf);
+	CHECK_OFFSET(si_perf_data);
+	CHECK_OFFSET(si_perf_type);
 
 	/* sigpoll */
 	CHECK_OFFSET(si_band);
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 78ddf5e11625..fde123066a8c 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -164,8 +164,8 @@ TEST_F(sigtrap_threads, enable_event)
 	EXPECT_EQ(ctx.signal_count, NUM_THREADS);
 	EXPECT_EQ(ctx.tids_want_signal, 0);
 	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
-	EXPECT_EQ(ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
-	EXPECT_EQ(ctx.first_siginfo.si_perf, TEST_SIG_DATA(&ctx.iterate_on));
+	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
 
 	/* Check enabled for parent. */
 	ctx.iterate_on = 0;
@@ -183,8 +183,8 @@ TEST_F(sigtrap_threads, modify_and_enable_event)
 	EXPECT_EQ(ctx.signal_count, NUM_THREADS);
 	EXPECT_EQ(ctx.tids_want_signal, 0);
 	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
-	EXPECT_EQ(ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
-	EXPECT_EQ(ctx.first_siginfo.si_perf, TEST_SIG_DATA(&ctx.iterate_on));
+	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
 
 	/* Check enabled for parent. */
 	ctx.iterate_on = 0;
@@ -203,8 +203,8 @@ TEST_F(sigtrap_threads, signal_stress)
 	EXPECT_EQ(ctx.signal_count, NUM_THREADS * ctx.iterate_on);
 	EXPECT_EQ(ctx.tids_want_signal, 0);
 	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
-	EXPECT_EQ(ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
-	EXPECT_EQ(ctx.first_siginfo.si_perf, TEST_SIG_DATA(&ctx.iterate_on));
+	EXPECT_EQ(ctx.first_siginfo.si_perf_type, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf_data, TEST_SIG_DATA(&ctx.iterate_on));
 }
 
 TEST_HARNESS_MAIN
-- 
2.30.1


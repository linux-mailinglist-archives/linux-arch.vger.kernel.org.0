Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CCC38650F
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 22:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbhEQUEO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 16:04:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:56038 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237388AbhEQUEN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 May 2021 16:04:13 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lijS4-009hGa-2N; Mon, 17 May 2021 14:02:56 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lijO1-0001rb-Po; Mon, 17 May 2021 13:58:46 -0600
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
Date:   Mon, 17 May 2021 14:57:47 -0500
Message-Id: <20210517195748.8880-4-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210517195748.8880-1-ebiederm@xmission.com>
References: <m1a6ot5e2h.fsf_-_@fess.ebiederm.org>
 <20210517195748.8880-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1lijO1-0001rb-Po;;;mid=<20210517195748.8880-4-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/DTzlZhLgPy+VrMbQUitsA4Tl+AiJY2OY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
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
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 774 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (1.6%), b_tie_ro: 11 (1.4%), parse: 2.4 (0.3%),
         extract_message_metadata: 25 (3.2%), get_uri_detail_list: 9 (1.2%),
        tests_pri_-1000: 19 (2.5%), tests_pri_-950: 1.61 (0.2%),
        tests_pri_-900: 1.32 (0.2%), tests_pri_-90: 148 (19.1%), check_bayes:
        146 (18.9%), b_tokenize: 24 (3.1%), b_tok_get_all: 12 (1.6%),
        b_comp_prob: 3.3 (0.4%), b_tok_touch_all: 102 (13.2%), b_finish: 0.89
        (0.1%), tests_pri_0: 552 (71.3%), check_dkim_signature: 0.71 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 0.66 (0.1%), tests_pri_10:
        1.80 (0.2%), tests_pri_500: 6 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 4/5] signal: Deliver all of the siginfo perf data in _perf
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

Don't abuse si_errno and deliver all of the perf data in _perf member
of siginfo_t.

Note: The data field in the perf data structures in a u64 to allow a
pointer to be encoded without needed to implement a 32bit and 64bit
version of the same structure.  There already exists a 32bit and 64bit
versions siginfo_t, and the 32bit version can not include a 64bit
member as it only has 32bit alignment.  So unsigned long is used in
siginfo_t instead of a u64 as unsigned long can encode a pointer on
all architectures linux supports.

v1: https://lkml.kernel.org/r/m11rarqqx2.fsf_-_@fess.ebiederm.org
v2: https://lkml.kernel.org/r/20210503203814.25487-10-ebiederm@xmission.com
v3: https://lkml.kernel.org/r/20210505141101.11519-11-ebiederm@xmission.com
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/m68k/kernel/signal.c                     |  3 ++-
 arch/x86/kernel/signal_compat.c               |  6 ++++--
 fs/signalfd.c                                 |  3 ++-
 include/linux/compat.h                        |  5 ++++-
 include/uapi/asm-generic/siginfo.h            |  8 +++++--
 include/uapi/linux/perf_event.h               |  2 +-
 include/uapi/linux/signalfd.h                 |  4 ++--
 kernel/signal.c                               | 21 ++++++++++++-------
 .../selftests/perf_events/sigtrap_threads.c   | 14 ++++++-------
 9 files changed, 41 insertions(+), 25 deletions(-)

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
diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index a9fcabd8a5e5..06743ec054d2 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -141,8 +141,10 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(offsetof(siginfo_t, si_pkey) != 0x20);
 	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_pkey) != 0x14);
 
-	BUILD_BUG_ON(offsetof(siginfo_t, si_perf) != 0x18);
-	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf) != 0x10);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_data) != 0x18);
+	BUILD_BUG_ON(offsetof(siginfo_t, si_perf_type) != 0x20);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_data) != 0x10);
+	BUILD_BUG_ON(offsetof(compat_siginfo_t, si_perf_type) != 0x14);
 
 	CHECK_CSI_OFFSET(_sigpoll);
 	CHECK_CSI_SIZE  (_sigpoll, 2*sizeof(int));
diff --git a/fs/signalfd.c b/fs/signalfd.c
index e87e59581653..373df2f12415 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -134,7 +134,8 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		break;
 	case SIL_PERF_EVENT:
 		new.ssi_addr = (long) kinfo->si_addr;
-		new.ssi_perf = kinfo->si_perf;
+		new.ssi_perf_type = kinfo->si_perf_type;
+		new.ssi_perf_data = kinfo->si_perf_data;
 		break;
 	case SIL_CHLD:
 		new.ssi_pid    = kinfo->si_pid;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6af7bef15e94..a27fffaae121 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -236,7 +236,10 @@ typedef struct compat_siginfo {
 					u32 _pkey;
 				} _addr_pkey;
 				/* used when si_code=TRAP_PERF */
-				compat_ulong_t _perf;
+				struct {
+					compat_ulong_t _data;
+					u32 _type;
+				} _perf;
 			};
 		} _sigfault;
 
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index e663bf117b46..5a3c221f4c9d 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -91,7 +91,10 @@ union __sifields {
 				__u32 _pkey;
 			} _addr_pkey;
 			/* used when si_code=TRAP_PERF */
-			unsigned long _perf;
+			struct {
+				unsigned long _data;
+				__u32 _type;
+			} _perf;
 		};
 	} _sigfault;
 
@@ -154,7 +157,8 @@ typedef struct siginfo {
 #define si_lower	_sifields._sigfault._addr_bnd._lower
 #define si_upper	_sifields._sigfault._addr_bnd._upper
 #define si_pkey		_sifields._sigfault._addr_pkey._pkey
-#define si_perf		_sifields._sigfault._perf
+#define si_perf_data	_sifields._sigfault._perf._data
+#define si_perf_type	_sifields._sigfault._perf._type
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 #define si_call_addr	_sifields._sigsys._call_addr
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
index 3a18d13c39b2..dca53515ae3f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1768,11 +1768,13 @@ int force_sig_perf(void __user *addr, u32 type, u64 sig_data)
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
 
@@ -3356,7 +3358,8 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
 		break;
 	case SIL_PERF_EVENT:
 		to->si_addr = ptr_to_compat(from->si_addr);
-		to->si_perf = from->si_perf;
+		to->si_perf_data = from->si_perf_data;
+		to->si_perf_type = from->si_perf_type;
 		break;
 	case SIL_CHLD:
 		to->si_pid = from->si_pid;
@@ -3432,7 +3435,8 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 		break;
 	case SIL_PERF_EVENT:
 		to->si_addr = compat_ptr(from->si_addr);
-		to->si_perf = from->si_perf;
+		to->si_perf_data = from->si_perf_data;
+		to->si_perf_type = from->si_perf_type;
 		break;
 	case SIL_CHLD:
 		to->si_pid    = from->si_pid;
@@ -4615,7 +4619,8 @@ static inline void siginfo_buildtime_checks(void)
 	CHECK_OFFSET(si_lower);
 	CHECK_OFFSET(si_upper);
 	CHECK_OFFSET(si_pkey);
-	CHECK_OFFSET(si_perf);
+	CHECK_OFFSET(si_perf_data);
+	CHECK_OFFSET(si_perf_type);
 
 	/* sigpoll */
 	CHECK_OFFSET(si_band);
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
index 78ddf5e11625..8e83cf91513a 100644
--- a/tools/testing/selftests/perf_events/sigtrap_threads.c
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -43,7 +43,7 @@ static struct {
 	siginfo_t first_siginfo;	/* First observed siginfo_t. */
 } ctx;
 
-/* Unique value to check si_perf is correctly set from perf_event_attr::sig_data. */
+/* Unique value to check si_perf_data is correctly set from perf_event_attr::sig_data. */
 #define TEST_SIG_DATA(addr) (~(unsigned long)(addr))
 
 static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
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


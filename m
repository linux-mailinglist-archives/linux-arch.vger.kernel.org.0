Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039CF298C43
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 12:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774028AbgJZLuS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 07:50:18 -0400
Received: from foss.arm.com ([217.140.110.172]:36528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1774018AbgJZLuO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 07:50:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E77E5142F;
        Mon, 26 Oct 2020 04:50:13 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B31B63F719;
        Mon, 26 Oct 2020 04:50:12 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 4/5] kselftest: Move test_vdso to the vDSO test suite
Date:   Mon, 26 Oct 2020 11:49:44 +0000
Message-Id: <20201026114945.48532-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026114945.48532-1-vincenzo.frascino@arm.com>
References: <20201026114945.48532-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move test_vdso from x86 to the vDSO test suite.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 tools/testing/selftests/vDSO/Makefile                  | 10 ++++++++--
 .../{x86/test_vdso.c => vDSO/vdso_test_correctness.c}  |  0
 tools/testing/selftests/x86/Makefile                   |  2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)
 rename tools/testing/selftests/{x86/test_vdso.c => vDSO/vdso_test_correctness.c} (100%)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 375d80c2bff5..d53a4d8008f9 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -7,12 +7,14 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
 TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
-ifeq ($(ARCH),x86)
+ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
 endif
+TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
 
 CFLAGS := -std=gnu99
 CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
+LDFLAGS_vdso_test_correctness := -ldl
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
 endif
@@ -26,4 +28,8 @@ $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
 	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
 		vdso_standalone_test_x86.c parse_vdso.c \
 		-o $@
-
+$(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
+	$(CC) $(CFLAGS) \
+		vdso_test_correctness.c \
+		-o $@ \
+		$(LDFLAGS_vdso_test_correctness)
diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
similarity index 100%
rename from tools/testing/selftests/x86/test_vdso.c
rename to tools/testing/selftests/vDSO/vdso_test_correctness.c
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 6703c7906b71..333980375bc7 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
-			test_vdso test_vsyscall mov_ss_trap \
+			test_vsyscall mov_ss_trap \
 			syscall_arg_fault fsgsbase_restore
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
-- 
2.28.0


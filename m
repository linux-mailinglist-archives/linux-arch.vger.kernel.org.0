Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B237409DCD
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 22:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348045AbhIMUGL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 16:06:11 -0400
Received: from mga03.intel.com ([134.134.136.65]:19216 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347866AbhIMUFx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221830808"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="221830808"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643943"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:33 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 13/13] selftests/x86: Add basic tests for User IPI
Date:   Mon, 13 Sep 2021 13:01:32 -0700
Message-Id: <20210913200132.3396598-14-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Include 2 basic tests for receiving a User IPI:
1. Receiver is spinning in userspace.
2. Receiver is blocked in the kernel.

The selftests need gcc with 'muintr' support to compile.

GCC 11 (recently released) has support for this.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 tools/testing/selftests/x86/Makefile |  10 ++
 tools/testing/selftests/x86/uintr.c  | 147 +++++++++++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/x86/uintr.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index b4142cd1c5c2..38588221b09e 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -9,6 +9,7 @@ UNAME_M := $(shell uname -m)
 CAN_BUILD_I386 := $(shell ./check_cc.sh $(CC) trivial_32bit_program.c -m32)
 CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
+CAN_BUILD_UINTR := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c -muintr)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
@@ -19,6 +20,11 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
 			corrupt_xstate_header
+
+ifeq ($(CAN_BUILD_UINTR),1)
+TARGETS_C_64BIT_ONLY := $(TARGETS_C_64BIT_ONLY) uintr
+endif
+
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
@@ -41,6 +47,10 @@ ifeq ($(CAN_BUILD_WITH_NOPIE),1)
 CFLAGS += -no-pie
 endif
 
+ifeq ($(CAN_BUILD_UINTR),1)
+CFLAGS += -muintr
+endif
+
 define gen-target-rule-32
 $(1) $(1)_32: $(OUTPUT)/$(1)_32
 .PHONY: $(1) $(1)_32
diff --git a/tools/testing/selftests/x86/uintr.c b/tools/testing/selftests/x86/uintr.c
new file mode 100644
index 000000000000..61a53526f2fa
--- /dev/null
+++ b/tools/testing/selftests/x86/uintr.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, Intel Corporation.
+ *
+ * Sohil Mehta <sohil.mehta@intel.com>
+ */
+#define _GNU_SOURCE
+#include <syscall.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <x86gprintrin.h>
+#include <pthread.h>
+#include <stdlib.h>
+
+#ifndef __x86_64__
+# error This test is 64-bit only
+#endif
+
+#ifndef __NR_uintr_register_handler
+#define __NR_uintr_register_handler	449
+#define __NR_uintr_unregister_handler	450
+#define __NR_uintr_create_fd		451
+#define __NR_uintr_register_sender	452
+#define __NR_uintr_unregister_sender	453
+#define __NR_uintr_wait			454
+#endif
+
+#define uintr_register_handler(handler, flags)	syscall(__NR_uintr_register_handler, handler, flags)
+#define uintr_unregister_handler(flags)		syscall(__NR_uintr_unregister_handler, flags)
+#define uintr_create_fd(vector, flags)		syscall(__NR_uintr_create_fd, vector, flags)
+#define uintr_register_sender(fd, flags)	syscall(__NR_uintr_register_sender, fd, flags)
+#define uintr_unregister_sender(fd, flags)	syscall(__NR_uintr_unregister_sender, fd, flags)
+#define uintr_wait(flags)			syscall(__NR_uintr_wait, flags)
+
+unsigned long uintr_received;
+unsigned int uintr_fd;
+
+void __attribute__((interrupt))__attribute__((target("general-regs-only", "inline-all-stringops")))
+uintr_handler(struct __uintr_frame *ui_frame,
+	      unsigned long long vector)
+{
+	uintr_received = 1;
+}
+
+void receiver_setup_interrupt(void)
+{
+	int vector = 0;
+	int ret;
+
+	/* Register interrupt handler */
+	if (uintr_register_handler(uintr_handler, 0)) {
+		printf("[FAIL]\tInterrupt handler register error\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Create uintr_fd */
+	ret = uintr_create_fd(vector, 0);
+	if (ret < 0) {
+		printf("[FAIL]\tInterrupt vector registration error\n");
+		exit(EXIT_FAILURE);
+	}
+
+	uintr_fd = ret;
+}
+
+void *sender_thread(void *arg)
+{
+	long sleep_usec = (long)arg;
+	int uipi_index;
+
+	uipi_index = uintr_register_sender(uintr_fd, 0);
+	if (uipi_index < 0) {
+		printf("[FAIL]\tSender register error\n");
+		return NULL;
+	}
+
+	/* Sleep before sending IPI to allow the receiver to block in the kernel */
+	if (sleep_usec)
+		usleep(sleep_usec);
+
+	printf("\tother thread: sending IPI\n");
+	_senduipi(uipi_index);
+
+	uintr_unregister_sender(uintr_fd, 0);
+
+	return NULL;
+}
+
+static inline void cpu_relax(void)
+{
+	asm volatile("rep; nop" ::: "memory");
+}
+
+void test_base_ipi(void)
+{
+	pthread_t pt;
+
+	uintr_received = 0;
+	if (pthread_create(&pt, NULL, &sender_thread, NULL)) {
+		printf("[FAIL]\tError creating sender thread\n");
+		return;
+	}
+
+	printf("[RUN]\tSpin in userspace (waiting for interrupts)\n");
+	// Keep spinning until interrupt received
+	while (!uintr_received)
+		cpu_relax();
+
+	printf("[OK]\tUser interrupt received\n");
+}
+
+void test_blocking_ipi(void)
+{
+	pthread_t pt;
+	long sleep_usec;
+
+	uintr_received = 0;
+	sleep_usec = 1000;
+	if (pthread_create(&pt, NULL, &sender_thread, (void *)sleep_usec)) {
+		printf("[FAIL]\tError creating sender thread\n");
+		return;
+	}
+
+	printf("[RUN]\tBlock in the kernel (waiting for interrupts)\n");
+	uintr_wait(0);
+	if (uintr_received)
+		printf("[OK]\tUser interrupt received\n");
+	else
+		printf("[FAIL]\tUser interrupt not received\n");
+}
+
+int main(int argc, char *argv[])
+{
+	receiver_setup_interrupt();
+
+	/* Enable interrupts */
+	_stui();
+
+	test_base_ipi();
+
+	test_blocking_ipi();
+
+	close(uintr_fd);
+	uintr_unregister_handler(0);
+
+	exit(EXIT_SUCCESS);
+}
-- 
2.33.0


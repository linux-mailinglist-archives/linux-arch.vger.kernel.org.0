Return-Path: <linux-arch+bounces-1557-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457CC83BA1A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B98F1C21F37
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 06:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D2A1BC26;
	Thu, 25 Jan 2024 06:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SPXJdAKX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BA11CA96
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 06:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706164242; cv=none; b=m7ZWLiz9eG/LTQXJ6lXItvDS9BdcRwrCP2SNc+PEdTEfBij2D5q0Mey2yirx4+R066vq6X/euMwWEvdX8B9qjINXXhLujRAFsTZ8P856f0Rk4LBPqLbElQC/uXkqqtMKgMhEfKAKfepN4HZmhf6lTLVtOIT4i8fYHLxEkeF7Obs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706164242; c=relaxed/simple;
	bh=DjfqDTddf+3ke89A4GPKk4U5WzZ5kAt5r3gG2sX7YzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDyFp8yjtQGzf2XefMsRRU1AuKD1NHkptOP/vCQ3eCsERUV82VQqTE+qENi+dbGGI+UC20zIpcL6CKbPuOeKbB87maT9uGXxtpdFe816AjLmuuPaH/JJo53OedGZLPAt41OgCUsr4po68g6lrGo1YMceP6Momc5kUquKv5eOV3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SPXJdAKX; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce74ea4bf2so300538a12.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 22:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706164240; x=1706769040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7qF2ux/z3bZUzHUpWVLBPHatGr2T7HdgXLVBLlMyVI=;
        b=SPXJdAKXUyiCHsrFgm5wmqTRzWmfGtumkhdb/byqw0AcfPUBL2Gh6wEwwOXfCnfhrt
         Pr6Ffx5bkNNZQHFHeRk08CzLwJn7dConjiFWyX3pIAStce3qLp2VRBqd3BAgiHSsimUb
         /VEePEOPq5s+Ahmf2j2PBZiMoU2X3nw4wtHBbi1qai+V7VQRRU5UlsvVpk2jI7Ca6XTQ
         oSGP/XXB5EW+UEXlKSs0xpA3JgTQBhnbCC6JiRKqS+acrHM0omdAbCQ7AiSlMOhV+ojV
         bVOyT0WUvZd9ky8KxaaTOrQ1lEGoiXoRNxiR8MtDo0KlPmff3DTn3MIFElAmfozCzIoe
         za0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706164240; x=1706769040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7qF2ux/z3bZUzHUpWVLBPHatGr2T7HdgXLVBLlMyVI=;
        b=DWJa+ePX+Pn+0P8VZ1lTmrAf13jetjJgUwenOfuMBRhwVPCQGHDe4Wx8sr+JHthw/3
         xpK4Dt29Rw3SDTS4esFslFeOhlN5siYQLjKjLOcnTTXEo634lrINpBuGMy702cVzjRvy
         aafHbevbzXsJ/h3Pbf7pvVHqdV+MftZVvY40hwhdBm74WCbm1jrUDlePtuqeCCSkktN7
         R/oC2vRGUoZNW8gyxpuGWLO/+rFRUD8KNqnm59lefbGrwe6kXC3FYwvn5MtRNTryU7sG
         ebukMcBRsZ2PhsCC6sFnf7sovLWtbw6kbAKAUCefx7X9wB49KrgDYGIZnM3KtZTFBvA0
         9wfA==
X-Gm-Message-State: AOJu0YwWWSAOZ7+MGpyUbOPqF1CjdjvW7gLWMluNl0LswZ/JqV5bVSgM
	rasS6NZhxeZBGrO4bleAgo1OMEeIWSXqNTtydtaFh6UUOJ5jwzAq1uCwfELRpq0=
X-Google-Smtp-Source: AGHT+IGtFCuAS2jacdNLOQqSegNmk0e7hQgsOogCowyAm8TQfWIjDD/7nLFP+R2B4EfEEhW2CKrN6Q==
X-Received: by 2002:a05:6a20:a929:b0:19b:5b08:1f4b with SMTP id cd41-20020a056a20a92900b0019b5b081f4bmr578106pzb.15.1706164239760;
        Wed, 24 Jan 2024 22:30:39 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a00139300b006dd870b51b8sm3201139pfg.126.2024.01.24.22.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 22:30:39 -0800 (PST)
From: debug@rivosinc.com
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org,
	Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com,
	keescook@chromium.org,
	ajones@ventanamicro.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	conor.dooley@microchip.com,
	cleger@rivosinc.com,
	atishp@atishpatra.org,
	alex@ghiti.fr,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com
Cc: corbet@lwn.net,
	aou@eecs.berkeley.edu,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	shuah@kernel.org,
	brauner@kernel.org,
	debug@rivosinc.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	evan@rivosinc.com,
	xiao.w.wang@intel.com,
	apatel@ventanamicro.com,
	mchitale@ventanamicro.com,
	waylingii@gmail.com,
	greentime.hu@sifive.com,
	heiko@sntech.de,
	jszhang@kernel.org,
	shikemeng@huaweicloud.com,
	david@redhat.com,
	charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn,
	willy@infradead.org,
	vincent.chen@sifive.com,
	andy.chiu@sifive.com,
	gerg@kernel.org,
	jeeheng.sia@starfivetech.com,
	mason.huo@starfivetech.com,
	ancientmodern4@gmail.com,
	mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	ruscur@russell.cc,
	bgray@linux.ibm.com,
	alx@kernel.org,
	baruch@tkos.co.il,
	zhangqing@loongson.cn,
	catalin.marinas@arm.com,
	revest@chromium.org,
	josh@joshtriplett.org,
	joey.gouly@arm.com,
	shr@devkernel.io,
	omosnace@redhat.com,
	ojeda@kernel.org,
	jhubbard@nvidia.com,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v1 28/28] kselftest/riscv: kselftest for user mode cfi
Date: Wed, 24 Jan 2024 22:21:53 -0800
Message-ID: <20240125062739.1339782-29-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125062739.1339782-1-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepak Gupta <debug@rivosinc.com>

Adds kselftest for RISC-V control flow integrity implementation for user
mode. There is not a lot going on in kernel for enabling landing pad for
user mode. Thus kselftest simply enables landing pad for the binary and
a signal handler is registered for SIGSEGV. Any control flow violation are
reported as SIGSEGV with si_code = SEGV_CPERR. Test will fail on recieving
any SEGV_CPERR. Shadow stack part has more changes in kernel and thus there
are separate tests for that
	- enable and disable
	- Exercise `map_shadow_stack` syscall
	- `fork` test to make sure COW works for shadow stack pages
	- gup tests
	  As of today kernel uses FOLL_FORCE when access happens to memory via
	  /proc/<pid>/mem. Not breaking that for shadow stack
	- signal test. Make sure signal delivery results in token creation on
      shadow stack and consumes (and verifies) token on sigreturn
    - shadow stack protection test. attempts to write using regular store
	  instruction on shadow stack memory must result in access faults

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/cfi/Makefile    |  10 +
 .../testing/selftests/riscv/cfi/cfi_rv_test.h |  85 ++++
 .../selftests/riscv/cfi/riscv_cfi_test.c      |  91 +++++
 .../testing/selftests/riscv/cfi/shadowstack.c | 376 ++++++++++++++++++
 .../testing/selftests/riscv/cfi/shadowstack.h |  39 ++
 6 files changed, 602 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/cfi/Makefile
 create mode 100644 tools/testing/selftests/riscv/cfi/cfi_rv_test.h
 create mode 100644 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
 create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.c
 create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.h

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 4a9ff515a3a0..867e5875b7ce 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= hwprobe vector mm
+RISCV_SUBTARGETS ?= hwprobe vector mm cfi
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/cfi/Makefile b/tools/testing/selftests/riscv/cfi/Makefile
new file mode 100644
index 000000000000..77f12157fa29
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/Makefile
@@ -0,0 +1,10 @@
+CFLAGS += -I$(top_srcdir)/tools/include
+
+CFLAGS += -march=rv64gc_zicfilp_zicfiss
+
+TEST_GEN_PROGS := cfitests
+
+include ../../lib.mk
+
+$(OUTPUT)/cfitests: riscv_cfi_test.c shadowstack.c
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/cfi/cfi_rv_test.h b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
new file mode 100644
index 000000000000..27267a2e1008
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/cfi_rv_test.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef SELFTEST_RISCV_CFI_H
+#define SELFTEST_RISCV_CFI_H
+#include <stddef.h>
+#include <sys/types.h>
+#include "shadowstack.h"
+
+#define RISCV_CFI_SELFTEST_COUNT RISCV_SHADOW_STACK_TESTS
+
+#define CHILD_EXIT_CODE_SSWRITE		10
+#define CHILD_EXIT_CODE_SIG_TEST	11
+
+#define BAD_POINTER	(NULL)
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)		\
+({															\
+	register long _num  __asm__ ("a7") = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);		\
+	register long _arg5 __asm__ ("a4") = (long)(arg5);		\
+															\
+	__asm__ volatile (										\
+		"ecall\n"											\
+		: "+r"(_arg1)										\
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "r"(_num)											\
+		: "memory", "cc"									\
+	);														\
+	_arg1;													\
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({															\
+	register long _num  __asm__ ("a7") = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);		\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);		\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);		\
+															\
+	__asm__ volatile (										\
+		"ecall\n"											\
+		: "+r"(_arg1)										\
+		: "r"(_arg2), "r"(_arg3),							\
+		  "r"(_num)											\
+		: "memory", "cc"									\
+	);														\
+	_arg1;													\
+})
+
+#ifndef __NR_prctl
+#define __NR_prctl 167
+#endif
+
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack 453
+#endif
+
+#define CSR_SSP 0x011
+
+#ifdef __ASSEMBLY__
+#define __ASM_STR(x)    x
+#else
+#define __ASM_STR(x)    #x
+#endif
+
+#define csr_read(csr)									\
+({														\
+	register unsigned long __v;							\
+	__asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)	\
+						  : "=r" (__v) :				\
+						  : "memory");					\
+	__v;												\
+})
+
+#define csr_write(csr, val)								\
+({														\
+	unsigned long __v = (unsigned long) (val);			\
+	__asm__ __volatile__ ("csrw " __ASM_STR(csr) ", %0"	\
+						  : : "rK" (__v)				\
+						  : "memory");					\
+})
+
+#endif
diff --git a/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
new file mode 100644
index 000000000000..c116ae4bb358
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../../kselftest.h"
+#include <signal.h>
+#include <asm/ucontext.h>
+#include <linux/prctl.h>
+#include "cfi_rv_test.h"
+
+/* do not optimize cfi related test functions */
+#pragma GCC push_options
+#pragma GCC optimize("O0")
+
+#define SEGV_CPERR 10 /* control protection fault */
+
+void sigsegv_handler(int signum, siginfo_t *si, void *uc)
+{
+	struct ucontext *ctx = (struct ucontext *) uc;
+
+	if (si->si_code == SEGV_CPERR) {
+		printf("Control flow violation happened somewhere\n");
+		printf("pc where violation happened %lx\n", ctx->uc_mcontext.gregs[0]);
+		exit(-1);
+	}
+
+	/* null pointer deref */
+	if (si->si_addr == BAD_POINTER)
+		exit(CHILD_EXIT_CODE_NULL_PTR_DEREF);
+
+	/* shadow stack write case */
+	exit(CHILD_EXIT_CODE_SSWRITE);
+}
+
+int lpad_enable(void)
+{
+	int ret = 0;
+
+	ret = my_syscall5(__NR_prctl, PR_SET_INDIR_BR_LP_STATUS, PR_INDIR_BR_LP_ENABLE, 0, 0, 0);
+
+	return ret;
+}
+
+bool register_signal_handler(void)
+{
+	struct sigaction sa = {};
+
+	sa.sa_sigaction = sigsegv_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL)) {
+		printf("registering signal handler for landing pad violation failed\n");
+		return false;
+	}
+
+	return true;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+	unsigned long lpad_status = 0;
+
+	ksft_print_header();
+
+	ksft_set_plan(RISCV_CFI_SELFTEST_COUNT);
+
+	ksft_print_msg("starting risc-v tests\n");
+
+	/*
+	 * Landing pad test. Not a lot of kernel changes to support landing
+	 * pad for user mode except lighting up a bit in senvcfg via a prctl
+	 * Enable landing pad through out the execution of test binary
+	 */
+	ret = my_syscall5(__NR_prctl, PR_GET_INDIR_BR_LP_STATUS, &lpad_status, 0, 0, 0);
+	if (ret)
+		ksft_exit_skip("Get landing pad status failed with %d\n", ret);
+
+	ret = lpad_enable();
+
+	if (ret)
+		ksft_exit_skip("Enabling landing pad failed with %d\n", ret);
+
+	if (!register_signal_handler())
+		ksft_exit_skip("registering signal handler for SIGSEGV failed\n");
+
+	ksft_print_msg("landing pad enabled for binary\n");
+	ksft_print_msg("starting risc-v shadow stack tests\n");
+	execute_shadow_stack_tests();
+
+	ksft_finished();
+}
+
+#pragma GCC pop_options
diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.c b/tools/testing/selftests/riscv/cfi/shadowstack.c
new file mode 100644
index 000000000000..126654801bed
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/shadowstack.c
@@ -0,0 +1,376 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "../../kselftest.h"
+#include <sys/wait.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include "shadowstack.h"
+#include "cfi_rv_test.h"
+
+/* do not optimize shadow stack related test functions */
+#pragma GCC push_options
+#pragma GCC optimize("O0")
+
+void zar(void)
+{
+	unsigned long ssp = 0, swaped_val = 0;
+
+	ssp = csr_read(CSR_SSP);
+	printf("inside %s and shadow stack ptr is %lx\n", __func__, ssp);
+}
+
+void bar(void)
+{
+	printf("inside %s\n", __func__);
+	zar();
+}
+
+void foo(void)
+{
+	printf("inside %s\n", __func__);
+	bar();
+}
+
+void zar_child(void)
+{
+	unsigned long ssp = 0;
+
+	ssp = csr_read(CSR_SSP);
+	printf("inside %s and shadow stack ptr is %lx\n", __func__, ssp);
+}
+
+void bar_child(void)
+{
+	printf("inside %s\n", __func__);
+	zar_child();
+}
+
+void foo_child(void)
+{
+	printf("inside %s\n", __func__);
+	bar_child();
+}
+
+typedef void (call_func_ptr)(void);
+/*
+ * call couple of functions to test push pop.
+ */
+int shadow_stack_call_tests(call_func_ptr fn_ptr, bool parent)
+{
+	if (parent)
+		printf("call test for parent\n");
+	else
+		printf("call test for child\n");
+
+	(fn_ptr)();
+
+	return 0;
+}
+
+bool enable_disable_check(unsigned long test_num, void *ctx)
+{
+	int ret = 0;
+
+	if (!my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, PR_SHADOW_STACK_ENABLE, 0, 0, 0)) {
+		printf("Shadow stack was enabled\n");
+		shadow_stack_call_tests(&foo, true);
+
+		ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
+		if (ret)
+			ksft_test_result_fail("shadow stack disable failed\n");
+	} else {
+		ksft_test_result_fail("shadow stack enable failed\n");
+		ret = -EINVAL;
+	}
+
+	return ret ? false : true;
+}
+
+/* forks a thread, and ensure shadow stacks fork out */
+bool shadow_stack_fork_test(unsigned long test_num, void *ctx)
+{
+	int pid = 0, child_status = 0, parent_pid = 0;
+
+	printf("exercising shadow stack fork test\n");
+
+	if (my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, PR_SHADOW_STACK_ENABLE, 0, 0, 0)) {
+		printf("shadow stack enable prctl failed\n");
+		return false;
+	}
+
+	parent_pid = getpid();
+	pid = fork();
+
+	if (pid) {
+		printf("Parent pid %d and child pid %d\n", parent_pid, pid);
+		shadow_stack_call_tests(&foo, true);
+	} else
+		shadow_stack_call_tests(&foo_child, false);
+
+	if (pid) {
+		printf("waiting on child to finish\n");
+		wait(&child_status);
+	} else {
+		/* exit child gracefully */
+		exit(0);
+	}
+
+	if (pid && WIFSIGNALED(child_status)) {
+		printf("child faulted");
+		return false;
+	}
+
+	/* disable shadow stack again */
+	if (my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0)) {
+		printf("shadow stack disable prctl failed\n");
+		return false;
+	}
+
+	return true;
+}
+
+/* exercise `map_shadow_stack`, pivot to it and call some functions to ensure it works */
+#define SHADOW_STACK_ALLOC_SIZE 4096
+bool shadow_stack_map_test(unsigned long test_num, void *ctx)
+{
+	unsigned long shdw_addr;
+	int ret = 0;
+
+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
+
+	if (((long) shdw_addr) <= 0) {
+		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
+		return false;
+	}
+
+	ret = munmap((void *) shdw_addr, SHADOW_STACK_ALLOC_SIZE);
+
+	if (ret) {
+		printf("munmap failed with error code %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * shadow stack protection tests. map a shadow stack and
+ * validate all memory protections work on it
+ */
+bool shadow_stack_protection_test(unsigned long test_num, void *ctx)
+{
+	unsigned long shdw_addr;
+	unsigned long *write_addr = NULL;
+	int ret = 0, pid = 0, child_status = 0;
+
+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
+
+	if (((long) shdw_addr) <= 0) {
+		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
+		return false;
+	}
+
+	write_addr = (unsigned long *) shdw_addr;
+	pid = fork();
+
+	/* no child was created, return false */
+	if (pid == -1)
+		return false;
+
+	/*
+	 * try to perform a store from child on shadow stack memory
+	 * it should result in SIGSEGV
+	 */
+	if (!pid) {
+		/* below write must lead to SIGSEGV */
+		*write_addr = 0xdeadbeef;
+	} else {
+		wait(&child_status);
+	}
+
+	/* test fail, if 0xdeadbeef present on shadow stack address */
+	if (*write_addr == 0xdeadbeef) {
+		printf("write suceeded\n");
+		return false;
+	}
+
+	/* if child reached here, then fail */
+	if (!pid) {
+		printf("child reached unreachable state\n");
+		return false;
+	}
+
+	/* if child exited via signal handler but not for write on ss */
+	if (WIFEXITED(child_status) &&
+		WEXITSTATUS(child_status) != CHILD_EXIT_CODE_SSWRITE) {
+		printf("child wasn't signaled for write on shadow stack\n");
+		return false;
+	}
+
+	ret = munmap(write_addr, SHADOW_STACK_ALLOC_SIZE);
+	if (ret) {
+		printf("munmap failed with error code %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+#define SS_MAGIC_WRITE_VAL 0xbeefdead
+
+int gup_tests(int mem_fd, unsigned long *shdw_addr)
+{
+	unsigned long val = 0;
+
+	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
+	if (read(mem_fd, &val, sizeof(val)) < 0) {
+		printf("reading shadow stack mem via gup failed\n");
+		return 1;
+	}
+
+	val = SS_MAGIC_WRITE_VAL;
+	lseek(mem_fd, (unsigned long)shdw_addr, SEEK_SET);
+	if (write(mem_fd, &val, sizeof(val)) < 0) {
+		printf("writing shadow stack mem via gup failed\n");
+		return 1;
+	}
+
+	if (*shdw_addr != SS_MAGIC_WRITE_VAL) {
+		printf("GUP write to shadow stack memory didn't happen\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+bool shadow_stack_gup_tests(unsigned long test_num, void *ctx)
+{
+	unsigned long shdw_addr = 0;
+	unsigned long *write_addr = NULL;
+	int fd = 0;
+	bool ret = false;
+
+	shdw_addr = my_syscall3(__NR_map_shadow_stack, NULL, SHADOW_STACK_ALLOC_SIZE, 0);
+
+	if (((long) shdw_addr) <= 0) {
+		printf("map_shadow_stack failed with error code %d\n", (int) shdw_addr);
+		return false;
+	}
+
+	write_addr = (unsigned long *) shdw_addr;
+
+	fd = open("/proc/self/mem", O_RDWR);
+	if (fd == -1)
+		return false;
+
+	if (gup_tests(fd, write_addr)) {
+		printf("gup tests failed\n");
+		goto out;
+	}
+
+	ret = true;
+out:
+	if (shdw_addr && munmap(write_addr, SHADOW_STACK_ALLOC_SIZE)) {
+		printf("munmap failed with error code %d\n", ret);
+		ret = false;
+	}
+
+	return ret;
+}
+
+volatile bool break_loop;
+
+void sigusr1_handler(int signo)
+{
+	printf("In sigusr1 handler\n");
+	break_loop = true;
+}
+
+bool sigusr1_signal_test(void)
+{
+	if (signal(SIGUSR1, sigusr1_handler) == SIG_ERR) {
+		printf("registerting sigusr1 handler failed\n");
+		return false;
+	}
+
+	return true;
+}
+/*
+ * shadow stack signal test. shadow stack must be enabled.
+ * register a signal, fork another thread which is waiting
+ * on signal. Send a signal from parent to child, verify
+ * that signal was received by child. If not test fails
+ */
+bool shadow_stack_signal_test(unsigned long test_num, void *ctx)
+{
+	int pid = 0, child_status = 0;
+	unsigned long ssp = 0;
+
+	if (my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, PR_SHADOW_STACK_ENABLE, 0, 0, 0)) {
+		printf("shadow stack enable prctl failed\n");
+		return false;
+	}
+
+	pid = fork();
+
+	if (pid == -1) {
+		printf("signal test: fork failed\n");
+		goto out;
+	}
+
+	if (pid == 0) {
+		/* this should be caught by signal handler and do an exit */
+		if (!sigusr1_signal_test()) {
+			printf("sigusr1_signal_test failed\n");
+			exit(-1);
+		}
+
+		while (!break_loop)
+			sleep(1);
+
+		exit(11);
+		/* child shouldn't go beyond here */
+	}
+	/* send SIGUSR1 to child */
+	kill(pid, SIGUSR1);
+	wait(&child_status);
+
+out:
+	if (my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0)) {
+		printf("shadow stack disable prctl failed\n");
+		return false;
+	}
+
+	return (WIFEXITED(child_status) &&
+			WEXITSTATUS(child_status) == 11);
+}
+
+int execute_shadow_stack_tests(void)
+{
+	int ret = 0;
+	unsigned long test_count = 0;
+	unsigned long shstk_status = 0;
+
+	printf("Executing RISC-V shadow stack self tests\n");
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &shstk_status, 0, 0, 0);
+
+	if (ret != 0)
+		ksft_exit_skip("Get shadow stack status failed with %d\n", ret);
+
+	/*
+	 * If we are here that means get shadow stack status succeeded and
+	 * thus shadow stack support is baked in the kernel.
+	 */
+	while (test_count < ARRAY_SIZE(shstk_tests)) {
+		ksft_test_result((*shstk_tests[test_count].t_func)(test_count, NULL),
+						 shstk_tests[test_count].name);
+		test_count++;
+	}
+
+	return 0;
+}
+
+#pragma GCC pop_options
diff --git a/tools/testing/selftests/riscv/cfi/shadowstack.h b/tools/testing/selftests/riscv/cfi/shadowstack.h
new file mode 100644
index 000000000000..92cb0752238d
--- /dev/null
+++ b/tools/testing/selftests/riscv/cfi/shadowstack.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef SELFTEST_SHADOWSTACK_TEST_H
+#define SELFTEST_SHADOWSTACK_TEST_H
+#include <stddef.h>
+#include <linux/prctl.h>
+
+/*
+ * a cfi test returns true for success or false for fail
+ * takes a number for test number to index into array and void pointer.
+ */
+typedef bool (*shstk_test_func)(unsigned long test_num, void *);
+
+struct shadow_stack_tests {
+	char *name;
+	shstk_test_func t_func;
+};
+
+bool enable_disable_check(unsigned long test_num, void *ctx);
+bool shadow_stack_fork_test(unsigned long test_num, void *ctx);
+bool shadow_stack_map_test(unsigned long test_num, void *ctx);
+bool shadow_stack_protection_test(unsigned long test_num, void *ctx);
+bool shadow_stack_gup_tests(unsigned long test_num, void *ctx);
+bool shadow_stack_signal_test(unsigned long test_num, void *ctx);
+
+static struct shadow_stack_tests shstk_tests[] = {
+	{ "enable disable\n", enable_disable_check },
+	{ "shstk fork test\n", shadow_stack_fork_test },
+	{ "map shadow stack syscall\n", shadow_stack_map_test },
+	{ "shadow stack gup tests\n", shadow_stack_gup_tests },
+	{ "shadow stack signal tests\n", shadow_stack_signal_test},
+	{ "memory protections of shadow stack memory\n", shadow_stack_protection_test }
+};
+
+#define RISCV_SHADOW_STACK_TESTS ARRAY_SIZE(shstk_tests)
+
+int execute_shadow_stack_tests(void);
+
+#endif
-- 
2.43.0



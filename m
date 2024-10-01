Return-Path: <linux-arch+bounces-7604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E51E98C932
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 01:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFF4F288EF5
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 23:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5151CF7DB;
	Tue,  1 Oct 2024 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkFNSpYQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E51CF7D6;
	Tue,  1 Oct 2024 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823976; cv=none; b=RJRiEf0/U9StnPdn5vK8a/ZVJAm1KJEUPlnOrZkbKHIwd5HLdYqGZFgU9c4SoyiqQZ/PnvezAFX2kEq2y9IeE6UWmwLrs9WHJ7kByriD73HmLCOgVeuYCXnleWx3/XtiwefVr6Q8LeiSpGWDOM35lzBjfHx4X/OU/ferLJkLLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823976; c=relaxed/simple;
	bh=Q17T+yWBmbeXt5IFTELe5+0SvI5sZQYMONrJzT8GYVk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRMPHcbSYbo13MKcx8vx+zugg/2M2HgHBpTulziLTqydAtOVPCE2NZPlj6t+hNY9wM5SqzrkSr6Oz0e1v9D4+WKT5iPPIi6IUHydv+lFFSQNCKWqjSXwi2tY9SP6rfICvXpq+fN4W1/8yNfJnsWeSEtn3VydsgjTQb3HIt+ntXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkFNSpYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A025C4CECD;
	Tue,  1 Oct 2024 23:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727823976;
	bh=Q17T+yWBmbeXt5IFTELe5+0SvI5sZQYMONrJzT8GYVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YkFNSpYQeheyRp/N67f4dTfhLKXJEhHMycTSTF3CBcydocntNO5yVgSUbG6pLZ+Bd
	 UP6P1YxDY8UwOkkUGwW50AE7NFURvXzc18llA6fzDVXVWyVWwKGHLM9WJ1kMvYpSuQ
	 gkXl0fmwFUcKMOUpXgrv+V+NxK2JIq4AHuSmFclAK5KNUzPWM0gq/YxzuV/3yZduz/
	 3DFKwVMmet18n6cmZgNhsxsgSX/8cRxRCW4bJilPl2Ct4NyBQIXO8+jvk7ocEhknD8
	 mG6mbBtO+UH79ssG9U0or9su377IpqyXyKOfFNH74ErV0EovWRZ+Krfg/7S1EGmZ6Y
	 yJ5ELXtWGMlEw==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 01 Oct 2024 23:59:13 +0100
Subject: [PATCH v13 34/40] kselftest/arm64: Add very basic GCS test program
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-arm64-gcs-v13-34-222b78d87eee@kernel.org>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
In-Reply-To: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, David Spickett <david.spickett@arm.com>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=13394; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Q17T+yWBmbeXt5IFTELe5+0SvI5sZQYMONrJzT8GYVk=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhrQ/dfcMi/V2LnBafPKHKOvyryFTisX4bRS/ibrkx1o1WL34
 9uRUJ6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwkTIt9v/u+579nS1+778BW7KLqA
 JPXkqboN8Eva89r0KsDSfr6t/REfu7fp+n/daPAs2d5wxE1XY1FAdnPlpStmTJoZteSt83/NvAyPi1
 vbHi6APphWo5iX0HLuuXnnE56BfjXF8vaJRq75uYPuFLoUr35cPbK1plrV1eJCqmMPx3WbKz8NWzPx
 PkBX87GC6sqV2Qpb1a5pXh+sKkC/fSfm8pVM2tKS/iLXo4z0vllj+P3KtNWkp7RZlz+F2f6li0u6w6
 9jgn6+M0l30VPRvl8+4z5f4v3iAtraVcdSPCcZZAfvJtuSk+L5xLaueterlG/HHRddOuAo/qAxxOrL
 k/p5+68DGoxadPsiU0xFSjniEPAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This test program just covers the basic GCS ABI, covering aspects of the
ABI as standalone features without attempting to integrate things.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Tested-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/gcs/.gitignore  |   1 +
 tools/testing/selftests/arm64/gcs/Makefile    |  18 ++
 tools/testing/selftests/arm64/gcs/basic-gcs.c | 357 ++++++++++++++++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-util.h  |  90 +++++++
 5 files changed, 467 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
index 28b93cab8c0d..22029e60eff3 100644
--- a/tools/testing/selftests/arm64/Makefile
+++ b/tools/testing/selftests/arm64/Makefile
@@ -4,7 +4,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),aarch64 arm64))
-ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi
+ARM64_SUBTARGETS ?= tags signal pauth fp mte bti abi gcs
 else
 ARM64_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/arm64/gcs/.gitignore b/tools/testing/selftests/arm64/gcs/.gitignore
new file mode 100644
index 000000000000..0e5e695ecba5
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/.gitignore
@@ -0,0 +1 @@
+basic-gcs
diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
new file mode 100644
index 000000000000..61a30f483429
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 ARM Limited
+#
+# In order to avoid interaction with the toolchain and dynamic linker the
+# portions of these tests that interact with the GCS are implemented using
+# nolibc.
+#
+
+TEST_GEN_PROGS := basic-gcs
+
+include ../../lib.mk
+
+$(OUTPUT)/basic-gcs: basic-gcs.c
+	$(CC) -g -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
+		-static -include ../../../../include/nolibc/nolibc.h \
+		-I../../../../../usr/include \
+		-std=gnu99 -I../.. -g \
+		-ffreestanding -Wall $^ -o $@ -lgcc
diff --git a/tools/testing/selftests/arm64/gcs/basic-gcs.c b/tools/testing/selftests/arm64/gcs/basic-gcs.c
new file mode 100644
index 000000000000..3fb9742342a3
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/basic-gcs.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 ARM Limited.
+ */
+
+#include <limits.h>
+#include <stdbool.h>
+
+#include <linux/prctl.h>
+
+#include <sys/mman.h>
+#include <asm/mman.h>
+#include <linux/sched.h>
+
+#include "kselftest.h"
+#include "gcs-util.h"
+
+/* nolibc doesn't have sysconf(), just hard code the maximum */
+static size_t page_size = 65536;
+
+static  __attribute__((noinline)) void valid_gcs_function(void)
+{
+	/* Do something the compiler can't optimise out */
+	my_syscall1(__NR_prctl, PR_SVE_GET_VL);
+}
+
+static inline int gcs_set_status(unsigned long mode)
+{
+	bool enabling = mode & PR_SHADOW_STACK_ENABLE;
+	int ret;
+	unsigned long new_mode;
+
+	/*
+	 * The prctl takes 1 argument but we need to ensure that the
+	 * other 3 values passed in registers to the syscall are zero
+	 * since the kernel validates them.
+	 */
+	ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, mode,
+			  0, 0, 0);
+
+	if (ret == 0) {
+		ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
+				  &new_mode, 0, 0, 0);
+		if (ret == 0) {
+			if (new_mode != mode) {
+				ksft_print_msg("Mode set to %lx not %lx\n",
+					       new_mode, mode);
+				ret = -EINVAL;
+			}
+		} else {
+			ksft_print_msg("Failed to validate mode: %d\n", ret);
+		}
+
+		if (enabling != chkfeat_gcs()) {
+			ksft_print_msg("%senabled by prctl but %senabled in CHKFEAT\n",
+				       enabling ? "" : "not ",
+				       chkfeat_gcs() ? "" : "not ");
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+/* Try to read the status */
+static bool read_status(void)
+{
+	unsigned long state;
+	int ret;
+
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
+			  &state, 0, 0, 0);
+	if (ret != 0) {
+		ksft_print_msg("Failed to read state: %d\n", ret);
+		return false;
+	}
+
+	return state & PR_SHADOW_STACK_ENABLE;
+}
+
+/* Just a straight enable */
+static bool base_enable(void)
+{
+	int ret;
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE);
+	if (ret) {
+		ksft_print_msg("PR_SHADOW_STACK_ENABLE failed %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+/* Check we can read GCSPR_EL0 when GCS is enabled */
+static bool read_gcspr_el0(void)
+{
+	unsigned long *gcspr_el0;
+
+	ksft_print_msg("GET GCSPR\n");
+	gcspr_el0 = get_gcspr();
+	ksft_print_msg("GCSPR_EL0 is %p\n", gcspr_el0);
+
+	return true;
+}
+
+/* Also allow writes to stack */
+static bool enable_writeable(void)
+{
+	int ret;
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE);
+	if (ret) {
+		ksft_print_msg("PR_SHADOW_STACK_ENABLE writeable failed: %d\n", ret);
+		return false;
+	}
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE);
+	if (ret) {
+		ksft_print_msg("failed to restore plain enable %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+/* Also allow writes to stack */
+static bool enable_push_pop(void)
+{
+	int ret;
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_PUSH);
+	if (ret) {
+		ksft_print_msg("PR_SHADOW_STACK_ENABLE with push failed: %d\n",
+			       ret);
+		return false;
+	}
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE);
+	if (ret) {
+		ksft_print_msg("failed to restore plain enable %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+/* Enable GCS and allow everything */
+static bool enable_all(void)
+{
+	int ret;
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_PUSH |
+			     PR_SHADOW_STACK_WRITE);
+	if (ret) {
+		ksft_print_msg("PR_SHADOW_STACK_ENABLE with everything failed: %d\n",
+			       ret);
+		return false;
+	}
+
+	ret = gcs_set_status(PR_SHADOW_STACK_ENABLE);
+	if (ret) {
+		ksft_print_msg("failed to restore plain enable %d\n", ret);
+		return false;
+	}
+
+	return true;
+}
+
+static bool enable_invalid(void)
+{
+	int ret = gcs_set_status(ULONG_MAX);
+	if (ret == 0) {
+		ksft_print_msg("GCS_SET_STATUS %lx succeeded\n", ULONG_MAX);
+		return false;
+	}
+
+	return true;
+}
+
+/* Map a GCS */
+static bool map_guarded_stack(void)
+{
+	int ret;
+	uint64_t *buf;
+	uint64_t expected_cap;
+	int elem;
+	bool pass = true;
+
+	buf = (void *)my_syscall3(__NR_map_shadow_stack, 0, page_size,
+				  SHADOW_STACK_SET_MARKER |
+				  SHADOW_STACK_SET_TOKEN);
+	if (buf == MAP_FAILED) {
+		ksft_print_msg("Failed to map %lu byte GCS: %d\n",
+			       page_size, errno);
+		return false;
+	}
+	ksft_print_msg("Mapped GCS at %p-%p\n", buf,
+		       (void *)((uint64_t)buf + page_size));
+
+	/* The top of the newly allocated region should be 0 */
+	elem = (page_size / sizeof(uint64_t)) - 1;
+	if (buf[elem]) {
+		ksft_print_msg("Last entry is 0x%llx not 0x0\n", buf[elem]);
+		pass = false;
+	}
+
+	/* Then a valid cap token */
+	elem--;
+	expected_cap = ((uint64_t)buf + page_size - 16);
+	expected_cap &= GCS_CAP_ADDR_MASK;
+	expected_cap |= GCS_CAP_VALID_TOKEN;
+	if (buf[elem] != expected_cap) {
+		ksft_print_msg("Cap entry is 0x%llx not 0x%llx\n",
+			       buf[elem], expected_cap);
+		pass = false;
+	}
+	ksft_print_msg("cap token is 0x%llx\n", buf[elem]);
+
+	/* The rest should be zeros */
+	for (elem = 0; elem < page_size / sizeof(uint64_t) - 2; elem++) {
+		if (!buf[elem])
+			continue;
+		ksft_print_msg("GCS slot %d is 0x%llx not 0x0\n",
+			       elem, buf[elem]);
+		pass = false;
+	}
+
+	ret = munmap(buf, page_size);
+	if (ret != 0) {
+		ksft_print_msg("Failed to unmap %ld byte GCS: %d\n",
+			       page_size, errno);
+		pass = false;
+	}
+
+	return pass;
+}
+
+/* A fork()ed process can run */
+static bool test_fork(void)
+{
+	unsigned long child_mode;
+	int ret, status;
+	pid_t pid;
+	bool pass = true;
+
+	pid = fork();
+	if (pid == -1) {
+		ksft_print_msg("fork() failed: %d\n", errno);
+		pass = false;
+		goto out;
+	}
+	if (pid == 0) {
+		/* In child, make sure we can call a function, read
+		 * the GCS pointer and status and then exit */
+		valid_gcs_function();
+		get_gcspr();
+
+		ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
+				  &child_mode, 0, 0, 0);
+		if (ret == 0 && !(child_mode & PR_SHADOW_STACK_ENABLE)) {
+			ksft_print_msg("GCS not enabled in child\n");
+			ret = -EINVAL;
+		}
+
+		exit(ret);
+	}
+
+	/*
+	 * In parent, check we can still do function calls then block
+	 * for the child.
+	 */
+	valid_gcs_function();
+
+	ksft_print_msg("Waiting for child %d\n", pid);
+
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		ksft_print_msg("Failed to wait for child: %d\n",
+			       errno);
+		return false;
+	}
+
+	if (!WIFEXITED(status)) {
+		ksft_print_msg("Child exited due to signal %d\n",
+			       WTERMSIG(status));
+		pass = false;
+	} else {
+		if (WEXITSTATUS(status)) {
+			ksft_print_msg("Child exited with status %d\n",
+				       WEXITSTATUS(status));
+			pass = false;
+		}
+	}
+
+out:
+
+	return pass;
+}
+
+typedef bool (*gcs_test)(void);
+
+static struct {
+	char *name;
+	gcs_test test;
+	bool needs_enable;
+} tests[] = {
+	{ "read_status", read_status },
+	{ "base_enable", base_enable, true },
+	{ "read_gcspr_el0", read_gcspr_el0 },
+	{ "enable_writeable", enable_writeable, true },
+	{ "enable_push_pop", enable_push_pop, true },
+	{ "enable_all", enable_all, true },
+	{ "enable_invalid", enable_invalid, true },
+	{ "map_guarded_stack", map_guarded_stack },
+	{ "fork", test_fork },
+};
+
+int main(void)
+{
+	int i, ret;
+	unsigned long gcs_mode;
+
+	ksft_print_header();
+
+	/*
+	 * We don't have getauxval() with nolibc so treat a failure to
+	 * read GCS state as a lack of support and skip.
+	 */
+	ret = my_syscall5(__NR_prctl, PR_GET_SHADOW_STACK_STATUS,
+			  &gcs_mode, 0, 0, 0);
+	if (ret != 0)
+		ksft_exit_skip("Failed to read GCS state: %d\n", ret);
+
+	if (!(gcs_mode & PR_SHADOW_STACK_ENABLE)) {
+		gcs_mode = PR_SHADOW_STACK_ENABLE;
+		ret = my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+				  gcs_mode, 0, 0, 0);
+		if (ret != 0)
+			ksft_exit_fail_msg("Failed to enable GCS: %d\n", ret);
+	}
+
+	ksft_set_plan(ARRAY_SIZE(tests));
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		ksft_test_result((*tests[i].test)(), "%s\n", tests[i].name);
+	}
+
+	/* One last test: disable GCS, we can do this one time */
+	my_syscall5(__NR_prctl, PR_SET_SHADOW_STACK_STATUS, 0, 0, 0, 0);
+	if (ret != 0)
+		ksft_print_msg("Failed to disable GCS: %d\n", ret);
+
+	ksft_finished();
+
+	return 0;
+}
diff --git a/tools/testing/selftests/arm64/gcs/gcs-util.h b/tools/testing/selftests/arm64/gcs/gcs-util.h
new file mode 100644
index 000000000000..1ae6864d3f86
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 ARM Limited.
+ */
+
+#ifndef GCS_UTIL_H
+#define GCS_UTIL_H
+
+#include <stdbool.h>
+
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack 453
+#endif
+
+#ifndef __NR_prctl
+#define __NR_prctl 167
+#endif
+
+/* Shadow Stack/Guarded Control Stack interface */
+#define PR_GET_SHADOW_STACK_STATUS	74
+#define PR_SET_SHADOW_STACK_STATUS      75
+#define PR_LOCK_SHADOW_STACK_STATUS     76
+
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE		(1UL << 1)
+# define PR_SHADOW_STACK_PUSH		(1UL << 2)
+
+#define PR_SHADOW_STACK_ALL_MODES \
+	PR_SHADOW_STACK_ENABLE | PR_SHADOW_STACK_WRITE | PR_SHADOW_STACK_PUSH
+
+#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
+#define SHADOW_STACK_SET_MARKER (1ULL << 1)     /* Set up a top of stack merker in the shadow stack */
+
+#define GCS_CAP_ADDR_MASK		(0xfffffffffffff000UL)
+#define GCS_CAP_TOKEN_MASK		(0x0000000000000fffUL)
+#define GCS_CAP_VALID_TOKEN		1
+#define GCS_CAP_IN_PROGRESS_TOKEN	5
+
+#define GCS_CAP(x) (((unsigned long)(x) & GCS_CAP_ADDR_MASK) | \
+		    GCS_CAP_VALID_TOKEN)
+
+static inline unsigned long *get_gcspr(void)
+{
+	unsigned long *gcspr;
+
+	asm volatile(
+		"mrs	%0, S3_3_C2_C5_1"
+	: "=r" (gcspr)
+	:
+	: "cc");
+
+	return gcspr;
+}
+
+static inline void __attribute__((always_inline)) gcsss1(unsigned long *Xt)
+{
+	asm volatile (
+		"sys #3, C7, C7, #2, %0\n"
+		:
+		: "rZ" (Xt)
+		: "memory");
+}
+
+static inline unsigned long __attribute__((always_inline)) *gcsss2(void)
+{
+	unsigned long *Xt;
+
+	asm volatile(
+		"SYSL %0, #3, C7, C7, #3\n"
+		: "=r" (Xt)
+		:
+		: "memory");
+
+	return Xt;
+}
+
+static inline bool chkfeat_gcs(void)
+{
+	register long val __asm__ ("x16") = 1;
+
+	/* CHKFEAT x16 */
+	asm volatile(
+		"hint #0x28\n"
+		: "=r" (val)
+		: "r" (val));
+
+	return val != 1;
+}
+
+#endif

-- 
2.39.2



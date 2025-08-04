Return-Path: <linux-arch+bounces-13054-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA18AB1A803
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E0D623633
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD692288CB4;
	Mon,  4 Aug 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eht0h6wa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000A288523;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325860; cv=none; b=u8F9ZA383w5jWTeaHw2V6N8hxnOwBbenk6LqnF784CeCbrYf+tjA1z6Dl9dkRlW1kwmNkABS3ZcP2BiQmFZmJEjDv8U7JRnqguK1GqiqOMO8AXqheuNjwP6+PP4fXMB8exK8ntkrLHn6O25z7JbLmiHyhBT8g3j7TLm4XMZUssI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325860; c=relaxed/simple;
	bh=HdxC+YrG0RYotBTATCCMvdXpeJF/VSAnm1GW7teMP8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=say5jevvhtfS/PHaf396trgil0kicMj9ELicGq4KH5KGOYIQ83nnBaA7wLDB8Up4Hl5DUYw1rfaX7avB45/4qQHl5yoCEXZrbXmm5v/8d8NLfZpRAwe//Ts53syDOUytU5uXj0b2J5sc7P/Q8DPIwMfFDQxQrJ8VvJuwQPNJSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eht0h6wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4D0C19425;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=HdxC+YrG0RYotBTATCCMvdXpeJF/VSAnm1GW7teMP8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eht0h6wavbG5fQnbmTMV1LmgGtMtTND4AiQx88qlrbrKMG7q+I2KV9TG5su1TUwJl
	 9JdYbIVDZVFNRpe+KxrQj3yYkr4jIKgX9AM48OY/X2HUTDt/yQMqghpZgo8dI+lUiY
	 sPFgdBPotx0O5vmB6rNUrXXCO7pIkGlxNLrZo/VrhZoavzwFsJfvHQQ5GRxGNORwYq
	 ll8Z8hIgRcmL2pG5t8gqltpIuUcpQJARO85MAZKd2YSKMLDdNiWDCDoVxzSQxjvD/J
	 I98kgiMNwgfmoVibR8Ga7ysDFMZhTXmoCPMBAlSUtMbpOVSZMmG3i0SdT9ZJxpw6vZ
	 nJ6HuuSPbsIvw==
From: Kees Cook <kees@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 17/17] KUnit: ffs: Validate all the __attribute_const__ annotations
Date: Mon,  4 Aug 2025 09:44:13 -0700
Message-Id: <20250804164417.1612371-17-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3872; i=kees@kernel.org; h=from:subject; bh=HdxC+YrG0RYotBTATCCMvdXpeJF/VSAnm1GW7teMP8Q=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHsc45wRtnf/oYkjVF1ejQumtl0UPxWm1daQdPSSrw bs5K8W2o5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCKRWxgZOjz/P/l/pMCzl0Hu 27r4n4VL9jtHtEl/uSCclF54euLlvwz/qxb+jO8s3m0ks3bJu3DRTzNP+l7bENDeHCloJ86woVy TAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While tracking down a problem where constant expressions used by
BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
initializer was convincing the compiler that it couldn't track the state
of the prior statically initialized value. Tracing this down found that
ffs() was used in the initializer macro, but since it wasn't marked with
__attribute_const__, the compiler had to assume the function might
change variable states as a side-effect (which is not true for ffs(),
which provides deterministic math results).

Validate all the __attibute_const__ annotations were found for all
architectures by reproducing the specific problem encountered in the
original bug report.

Build and run tested with everything I could reach with KUnit:

$ ./tools/testing/kunit/kunit.py run --arch=x86_64 ffs
$ ./tools/testing/kunit/kunit.py run --arch=i386 ffs
$ ./tools/testing/kunit/kunit.py run --arch=arm64 --make_options "CROSS_COMPILE=aarch64-linux-gnu-" ffs
$ ./tools/testing/kunit/kunit.py run --arch=arm --make_options "CROSS_COMPILE=arm-linux-gnueabi-" ffs
$ ./tools/testing/kunit/kunit.py run --arch=powerpc ffs
$ ./tools/testing/kunit/kunit.py run --arch=powerpc32 ffs
$ ./tools/testing/kunit/kunit.py run --arch=powerpcle ffs
$ ./tools/testing/kunit/kunit.py run --arch=m68k ffs
$ ./tools/testing/kunit/kunit.py run --arch=loongarch ffs
$ ./tools/testing/kunit/kunit.py run --arch=s390 --make_options "CROSS_COMPILE=s390x-linux-gnu-" ffs
$ ./tools/testing/kunit/kunit.py run --arch=riscv --make_options "CROSS_COMPILE=riscv64-linux-gnu-" ffs
$ ./tools/testing/kunit/kunit.py run --arch=riscv32 --make_options "CROSS_COMPILE=riscv64-linux-gnu-" ffs
$ ./tools/testing/kunit/kunit.py run --arch=sparc --make_options "CROSS_COMPILE=sparc64-linux-gnu-" ffs
$ ./tools/testing/kunit/kunit.py run --arch=sparc64 --make_options "CROSS_COMPILE=sparc64-linux-gnu-" ffs
$ ./tools/testing/kunit/kunit.py run --arch=alpha --make_options "CROSS_COMPILE=alpha-linux-gnu-" ffs
$ ./tools/testing/kunit/kunit.py run --arch=sh --make_options "CROSS_COMPILE=sh4-linux-gnu-" ffs

Closes: https://github.com/KSPP/linux/issues/364
Signed-off-by: Kees Cook <kees@kernel.org>
---
 lib/tests/ffs_kunit.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/lib/tests/ffs_kunit.c b/lib/tests/ffs_kunit.c
index ed11456b116e..9a329cdc09c2 100644
--- a/lib/tests/ffs_kunit.c
+++ b/lib/tests/ffs_kunit.c
@@ -496,6 +496,46 @@ static void ffz_edge_cases_test(struct kunit *test)
 	}
 }
 
+/*
+ * To have useful build error output, split the tests into separate
+ * functions so it's clear which are missing __attribute_const__.
+ */
+#define CREATE_WRAPPER(func)						\
+static noinline bool build_test_##func(void)				\
+{									\
+	int init_##func = 32;						\
+	int result_##func = func(6);					\
+									\
+	/* Does the static initializer vanish after calling func? */	\
+	BUILD_BUG_ON(init_##func < 32);					\
+									\
+	/* "Consume" the results so optimizer doesn't drop them. */	\
+	barrier_data(&init_##func);					\
+	barrier_data(&result_##func);					\
+									\
+	return true;							\
+}
+CREATE_WRAPPER(ffs)
+CREATE_WRAPPER(fls)
+CREATE_WRAPPER(__ffs)
+CREATE_WRAPPER(__fls)
+CREATE_WRAPPER(ffz)
+#undef CREATE_WRAPPER
+
+/*
+ * Make sure that __attribute_const__ has be applied to all the
+ * functions. This is a regression test for:
+ * https://github.com/KSPP/linux/issues/364
+ */
+static void ffs_attribute_const_test(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, build_test_ffs());
+	KUNIT_EXPECT_TRUE(test, build_test_fls());
+	KUNIT_EXPECT_TRUE(test, build_test___ffs());
+	KUNIT_EXPECT_TRUE(test, build_test___fls());
+	KUNIT_EXPECT_TRUE(test, build_test_ffz());
+}
+
 /*
  * KUnit test case definitions
  */
-- 
2.34.1



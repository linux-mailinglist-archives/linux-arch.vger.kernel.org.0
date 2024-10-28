Return-Path: <linux-arch+bounces-8638-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9B9B2AFB
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 10:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B9F1C21AB5
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 09:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FBC192B94;
	Mon, 28 Oct 2024 09:07:56 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8277192D64
	for <linux-arch@vger.kernel.org>; Mon, 28 Oct 2024 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106476; cv=none; b=T6BrXHH1x9uHenpxxNMcVDifteFyjRIQWi7s/K+k/ZAXoFeECcY74dY/lAB8IN3pjEiWy/T8KKGlukSDTPeDPqKduLFKWLhpNY0+sRnG99DA3OpfokRunQOJskAdpdL0ugXkoJwoJtINxHWxhcHbG2f8xImJ8YxQ7/ovJJJgvqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106476; c=relaxed/simple;
	bh=TguW/OCmiUmjsNh4l84nqJV62HOZH/MdExxGEtlyRs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESkLYQP3D6BxLfF/tSu7cRdopScucQa8++Bvat5N/0r0YdjwPPnaP/VgFI3OtVd3nzK855J3YH0Hmi0vyVxVtdHEfzNvnErXzF+1SUQVaVfJCdjCG083LBZ0N6VpDF1OMdQ2AOe1Sso/9hnbm6murQl4571hrFCONT4DW3qnK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7AA51691;
	Mon, 28 Oct 2024 02:08:22 -0700 (PDT)
Received: from udebian.localdomain (unknown [10.57.58.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F63D3F66E;
	Mon, 28 Oct 2024 02:07:51 -0700 (PDT)
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org,
	nd@arm.com,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: [PATCH v3 2/3] selftests/mm: Use PKEY_UNRESTRICTED macro
Date: Mon, 28 Oct 2024 09:07:14 +0000
Message-Id: <20241028090715.509527-3-yury.khrustalev@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028090715.509527-1-yury.khrustalev@arm.com>
References: <20241028090715.509527-1-yury.khrustalev@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace literal 0 with macro PKEY_UNRESTRICTED where pkey_*() functions
are used in mm selftests for memory protection keys.

Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
Suggested-by: Joey Gouly <joey.gouly@arm.com>
---
 tools/testing/selftests/mm/mseal_test.c            | 6 +++---
 tools/testing/selftests/mm/pkey-helpers.h          | 3 ++-
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 4 ++--
 tools/testing/selftests/mm/protection_keys.c       | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 01675c412b2a..30ea37e8ecf8 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -218,7 +218,7 @@ bool seal_support(void)
 bool pkey_supported(void)
 {
 #if defined(__i386__) || defined(__x86_64__) /* arch */
-	int pkey = sys_pkey_alloc(0, 0);
+	int pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 
 	if (pkey > 0)
 		return true;
@@ -1671,7 +1671,7 @@ static void test_seal_discard_ro_anon_on_pkey(bool seal)
 	setup_single_address_rw(size, &ptr);
 	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
 
-	pkey = sys_pkey_alloc(0, 0);
+	pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 	FAIL_TEST_IF_FALSE(pkey > 0);
 
 	ret = sys_mprotect_pkey((void *)ptr, size, PROT_READ | PROT_WRITE, pkey);
@@ -1683,7 +1683,7 @@ static void test_seal_discard_ro_anon_on_pkey(bool seal)
 	}
 
 	/* sealing doesn't take effect if PKRU allow write. */
-	set_pkey(pkey, 0);
+	set_pkey(pkey, PKEY_UNRESTRICTED);
 	ret = sys_madvise(ptr, size, MADV_DONTNEED);
 	FAIL_TEST_IF_FALSE(!ret);
 
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 9ab6a3ee153b..e7fb0fcfcb05 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <ucontext.h>
 #include <sys/mman.h>
+#include <linux/mman.h>
 
 #include "../kselftest.h"
 
@@ -217,7 +218,7 @@ static inline u32 *siginfo_get_pkey_ptr(siginfo_t *si)
 static inline int kernel_has_pkeys(void)
 {
 	/* try allocating a key and see if it succeeds */
-	int ret = sys_pkey_alloc(0, 0);
+	int ret = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 	if (ret <= 0) {
 		return 0;
 	}
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index a8088b645ad6..76e85d2cf698 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -260,7 +260,7 @@ static void test_sigsegv_handler_with_different_pkey_for_stack(void)
 	__write_pkey_reg(0x55555550);
 
 	/* Protect the new stack with MPK 1 */
-	pkey = pkey_alloc(0, 0);
+	pkey = pkey_alloc(0, PKEY_UNRESTRICTED);
 	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
 
 	/* Set up alternate signal stack that will use the default MPK */
@@ -421,7 +421,7 @@ static void test_pkru_sigreturn(void)
 	__write_pkey_reg(0x55555544);
 
 	/* Protect the stack with MPK 2 */
-	pkey = pkey_alloc(0, 0);
+	pkey = pkey_alloc(0, PKEY_UNRESTRICTED);
 	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
 
 	/* Set up alternate signal stack that will use the default MPK */
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 4990f7ab4cb7..cca7435a7bc5 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -491,7 +491,7 @@ int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
 int alloc_pkey(void)
 {
 	int ret;
-	unsigned long init_val = 0x0;
+	unsigned long init_val = PKEY_UNRESTRICTED;
 
 	dprintf1("%s()::%d, pkey_reg: 0x%016llx shadow: %016llx\n",
 			__func__, __LINE__, __read_pkey_reg(), shadow_pkey_reg);
-- 
2.39.5



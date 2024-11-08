Return-Path: <linux-arch+bounces-8925-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1319C1880
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701FF1C20A5C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 08:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE881DFE3F;
	Fri,  8 Nov 2024 08:54:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92F047F69
	for <linux-arch@vger.kernel.org>; Fri,  8 Nov 2024 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056091; cv=none; b=qtj5PJ2EMWDSlKfdeik6ZnnjeK60Y2UTlStYoxJuySG3RFEsNS073XvHxoI4ejLSngMjnTG4Qaw2fkF+tawSR/WNWKIhDpOLQqjuc994zsDA2PkXQMhCJpOvli8H9aHZdokhI7A1lp1/OhHHEyENmdnHS/ixq0EYO6RplpgGDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056091; c=relaxed/simple;
	bh=TguW/OCmiUmjsNh4l84nqJV62HOZH/MdExxGEtlyRs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IK8cDTe+6SCnNIwcZMIL1N/B35esp4YXymZO5Ly/7p3+9iHT09dIc+P/sFtrRSmH2v2PzgwOBtGdLjeP8hWZowimQ6iE8EE9SLzDJ+TU3tOc4EblnJMZ+OwxNcYbns1Eo8yBUfeVnW3q/xkCRGMoqIu1JfLb10pwH8JASy1c6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF5DC1063;
	Fri,  8 Nov 2024 00:55:17 -0800 (PST)
Received: from udebian.localdomain (unknown [10.57.26.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1BC93F66E;
	Fri,  8 Nov 2024 00:54:45 -0800 (PST)
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
Subject: [PATCH v4 2/3] selftests/mm: Use PKEY_UNRESTRICTED macro
Date: Fri,  8 Nov 2024 08:53:57 +0000
Message-Id: <20241108085358.777687-3-yury.khrustalev@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241108085358.777687-1-yury.khrustalev@arm.com>
References: <20241108085358.777687-1-yury.khrustalev@arm.com>
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



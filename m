Return-Path: <linux-arch+bounces-9729-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 566F2A0BE4E
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 18:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7359C160F2D
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2025 17:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D151BC061;
	Mon, 13 Jan 2025 17:07:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AE01B4238;
	Mon, 13 Jan 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788020; cv=none; b=F2dTj1jKznSgRTFlBDfQiavX88mwSA3qY3UKAImAtwS2917elps+C0fMSXn/m+nBQ39zc8MI7/kp+/k+7/LySwUqxQ1fG/LQPc9nqFs4FMBFgxYuYfiIZ/qPOqwJnb4IGaIGiKT6YMD+doh1p3z8RjHB4rWZm0mtoaoNO1845l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788020; c=relaxed/simple;
	bh=cD0Vf44zr3UOAOE4zgF1nw22M7rJdbsowP9tcc1Jdi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AiPmVF3J8QoJYt6KRXzDOu4Cz8+otsRQhfJIo+cvawwr8FY1FKdIbq5VVLHaeEYcHv0O4MHQrzj9KaSyDImdByG/Kjzpg/JRRUZ6hz6KdwwsLNk+9wdcDK77yCcHNayxmRTBy1oIAPwULcqze6HgW42gE+3n8/9qiFRGCMoZzRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A2391BB0;
	Mon, 13 Jan 2025 09:07:26 -0800 (PST)
Received: from udebian.localdomain (unknown [10.1.25.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B00D83F673;
	Mon, 13 Jan 2025 09:06:55 -0800 (PST)
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sandipan Das <sandipan@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	nd@arm.com,
	Yury Khrustalev <yury.khrustalev@arm.com>
Subject: [RESEND v4 3/3] selftests/powerpc: Use PKEY_UNRESTRICTED macro
Date: Mon, 13 Jan 2025 17:06:19 +0000
Message-Id: <20250113170619.484698-4-yury.khrustalev@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113170619.484698-1-yury.khrustalev@arm.com>
References: <20250113170619.484698-1-yury.khrustalev@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace literal 0 with macro PKEY_UNRESTRICTED where pkey_*() functions
are used in mm selftests for memory protection keys for ppc target.

Signed-off-by: Yury Khrustalev <yury.khrustalev@arm.com>
Suggested-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

---
Note that I couldn't build these tests so I would appreciate if someone
could check this patch. Thank you!
---
 tools/testing/selftests/powerpc/include/pkeys.h      | 2 +-
 tools/testing/selftests/powerpc/mm/pkey_exec_prot.c  | 2 +-
 tools/testing/selftests/powerpc/mm/pkey_siginfo.c    | 2 +-
 tools/testing/selftests/powerpc/ptrace/core-pkey.c   | 6 +++---
 tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/powerpc/include/pkeys.h b/tools/testing/selftests/powerpc/include/pkeys.h
index 51729d9a7111..430cb4bd7472 100644
--- a/tools/testing/selftests/powerpc/include/pkeys.h
+++ b/tools/testing/selftests/powerpc/include/pkeys.h
@@ -85,7 +85,7 @@ int pkeys_unsupported(void)
 	SKIP_IF(!hash_mmu);
 
 	/* Check if the system call is supported */
-	pkey = sys_pkey_alloc(0, 0);
+	pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 	SKIP_IF(pkey < 0);
 	sys_pkey_free(pkey);
 
diff --git a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
index 0af4f02669a1..29b91b7456eb 100644
--- a/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
+++ b/tools/testing/selftests/powerpc/mm/pkey_exec_prot.c
@@ -72,7 +72,7 @@ static void segv_handler(int signum, siginfo_t *sinfo, void *ctx)
 
 		switch (fault_type) {
 		case PKEY_DISABLE_ACCESS:
-			pkey_set_rights(fault_pkey, 0);
+			pkey_set_rights(fault_pkey, PKEY_UNRESTRICTED);
 			break;
 		case PKEY_DISABLE_EXECUTE:
 			/*
diff --git a/tools/testing/selftests/powerpc/mm/pkey_siginfo.c b/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
index 2db76e56d4cb..e89a164c686b 100644
--- a/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
+++ b/tools/testing/selftests/powerpc/mm/pkey_siginfo.c
@@ -83,7 +83,7 @@ static void segv_handler(int signum, siginfo_t *sinfo, void *ctx)
 	    mprotect(pgstart, pgsize, PROT_EXEC))
 		_exit(1);
 	else
-		pkey_set_rights(pkey, 0);
+		pkey_set_rights(pkey, PKEY_UNRESTRICTED);
 
 	fault_count++;
 }
diff --git a/tools/testing/selftests/powerpc/ptrace/core-pkey.c b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
index f6da4cb30cd6..64c985445cb7 100644
--- a/tools/testing/selftests/powerpc/ptrace/core-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/core-pkey.c
@@ -124,16 +124,16 @@ static int child(struct shared_info *info)
 	/* Get some pkeys so that we can change their bits in the AMR. */
 	pkey1 = sys_pkey_alloc(0, PKEY_DISABLE_EXECUTE);
 	if (pkey1 < 0) {
-		pkey1 = sys_pkey_alloc(0, 0);
+		pkey1 = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 		FAIL_IF(pkey1 < 0);
 
 		disable_execute = false;
 	}
 
-	pkey2 = sys_pkey_alloc(0, 0);
+	pkey2 = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 	FAIL_IF(pkey2 < 0);
 
-	pkey3 = sys_pkey_alloc(0, 0);
+	pkey3 = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 	FAIL_IF(pkey3 < 0);
 
 	info->amr |= 3ul << pkeyshift(pkey1) | 2ul << pkeyshift(pkey2);
diff --git a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
index d89474377f11..37794f82ed66 100644
--- a/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
+++ b/tools/testing/selftests/powerpc/ptrace/ptrace-pkey.c
@@ -81,16 +81,16 @@ static int child(struct shared_info *info)
 	/* Get some pkeys so that we can change their bits in the AMR. */
 	pkey1 = sys_pkey_alloc(0, PKEY_DISABLE_EXECUTE);
 	if (pkey1 < 0) {
-		pkey1 = sys_pkey_alloc(0, 0);
+		pkey1 = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 		CHILD_FAIL_IF(pkey1 < 0, &info->child_sync);
 
 		disable_execute = false;
 	}
 
-	pkey2 = sys_pkey_alloc(0, 0);
+	pkey2 = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 	CHILD_FAIL_IF(pkey2 < 0, &info->child_sync);
 
-	pkey3 = sys_pkey_alloc(0, 0);
+	pkey3 = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
 	CHILD_FAIL_IF(pkey3 < 0, &info->child_sync);
 
 	info->amr1 |= 3ul << pkeyshift(pkey1);
-- 
2.39.5



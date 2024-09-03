Return-Path: <linux-arch+bounces-6959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 947C396A1E5
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3A2B2702A
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2F318890E;
	Tue,  3 Sep 2024 15:15:25 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB77018BC14;
	Tue,  3 Sep 2024 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376525; cv=none; b=lbParbbY2vsSnNq7XcomT6mRTazsdc1GJyEpWMPamV4Y/uGCky/RwmZjyU/YtWIZAXt62TzsaVQGB4iRVxP+fEJp+ahbU/8g/fgj793DfGf+Iau3TmkdMCXDwCd7PAiNM8wDxvcOls4K+ANjKVlNp+25Z4kc2qC1+ZmAefjeSwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376525; c=relaxed/simple;
	bh=Z2SjnnuFLUbGFrOkJX97jNx8oE+Q+KPvIs2ohp5FEVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=akbjU31edikXsSNphynn4MieieXT7b703xKYjNoQkzXDBXEir599gmq9kj2DhJuPWm2bi9EawiSdJ8Bp/soxJuAB+E6XVIwYvJ0tA6MmTXRrIGRcE6Gtj271cw9oewYnxC1Q63735L7c7DXypKsCmws5CRnWtQMNfMyb7hVS7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99AED1424;
	Tue,  3 Sep 2024 08:15:49 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 439333F66E;
	Tue,  3 Sep 2024 08:15:20 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 9/9] vdso: Modify getrandom to include the correct namespace
Date: Tue,  3 Sep 2024 16:14:37 +0100
Message-Id: <20240903151437.1002990-10-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VDSO implementation includes headers from outside of the
vdso/ namespace.

Modify getrandom to take advantage of the refactoring done in the
previous patches and to include only the vdso/ namespace.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/vdso/getrandom.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 938ca539aaa6..9c26b738e4a1 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -3,19 +3,13 @@
  * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
-#include <linux/array_size.h>
-#include <linux/minmax.h>
 #include <vdso/datapage.h>
 #include <vdso/getrandom.h>
 #include <vdso/unaligned.h>
-#include <asm/vdso/getrandom.h>
-#include <uapi/linux/mman.h>
-#include <uapi/linux/random.h>
-
-#undef PAGE_SIZE
-#undef PAGE_MASK
-#define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
-#define PAGE_MASK (~(PAGE_SIZE - 1))
+#include <vdso/mman.h>
+#include <vdso/page.h>
+#include <vdso/array_size.h>
+#include <vdso/minmax.h>
 
 #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
 	while (len >= sizeof(type)) {						\
@@ -68,7 +62,7 @@ static __always_inline ssize_t
 __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_t len,
 		       unsigned int flags, void *opaque_state, size_t opaque_len)
 {
-	ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
+	ssize_t ret = min_t(size_t, INT_MAX & VDSO_PAGE_MASK /* = MAX_RW_COUNT */, len);
 	struct vgetrandom_state *state = opaque_state;
 	size_t batch_len, nblocks, orig_len = len;
 	bool in_use, have_retried = false;
@@ -79,15 +73,15 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
 	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags)) {
 		struct vgetrandom_opaque_params *params = opaque_state;
 		params->size_of_opaque_state = sizeof(*state);
-		params->mmap_prot = PROT_READ | PROT_WRITE;
-		params->mmap_flags = MAP_DROPPABLE | MAP_ANONYMOUS;
+		params->mmap_prot = VDSO_MMAP_PROT;
+		params->mmap_flags = VDSO_MMAP_FLAGS;
 		for (size_t i = 0; i < ARRAY_SIZE(params->reserved); ++i)
 			params->reserved[i] = 0;
 		return 0;
 	}
 
 	/* The state must not straddle a page, since pages can be zeroed at any time. */
-	if (unlikely(((unsigned long)opaque_state & ~PAGE_MASK) + sizeof(*state) > PAGE_SIZE))
+	if (unlikely(((unsigned long)opaque_state & ~VDSO_PAGE_MASK) + sizeof(*state) > VDSO_PAGE_SIZE))
 		return -EFAULT;
 
 	/* Handle unexpected flags by falling back to the kernel. */
-- 
2.34.1



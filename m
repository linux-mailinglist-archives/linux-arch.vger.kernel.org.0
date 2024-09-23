Return-Path: <linux-arch+bounces-7373-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AE297ED1F
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 16:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6532EB215BA
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD21A08AF;
	Mon, 23 Sep 2024 14:20:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119701A01A9;
	Mon, 23 Sep 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101214; cv=none; b=TY2zD4nh2Hko06TKXsZQOdypsEA44fK39jGBMid/c4thzF4Q2hAUp6OFh50YDxOvI1v5JGcyXxoN2cSdrz9nSxBN4BJv3JqoftOx8GVnovRffn74w8xa7Z/8TlMmhl40+6nPXZBq5ldJu+feuXt3D8nu6QQJiIatbmSg+Xu5s8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101214; c=relaxed/simple;
	bh=aAQIVvNH9jCkIm53CyHltIZPAkPGuz3UkFczGsiESu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DLxZtPSpezFFHxzwPS7PFPqyKmCtAAWGsM4HqkE5NlkuzMgo6wUN7+JXzfP0TZEGD/Fkj72gvC7AaDc7b9HBZmx14LJs7wQ+9IkTbIk4NrBIQVASv/pP4iOCV+cAh0Z3U5XXwuM36eKL3io9xnUAn3Sq2R5vv4xyGV09Sbl2I+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21AD6FEC;
	Mon, 23 Sep 2024 07:20:41 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37AEC3F64C;
	Mon, 23 Sep 2024 07:20:09 -0700 (PDT)
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
Subject: [PATCH v2 8/8] vdso: Modify getrandom to include the correct namespace.
Date: Mon, 23 Sep 2024 15:19:43 +0100
Message-Id: <20240923141943.133551-9-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923141943.133551-1-vincenzo.frascino@arm.com>
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
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
 include/vdso/datapage.h |  1 +
 lib/vdso/getrandom.c    | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index b7d6c71f20c1..127f0c51bf01 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -5,6 +5,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler.h>
+#include <linux/build_bug.h>
 #include <uapi/linux/time.h>
 #include <uapi/linux/types.h>
 #include <uapi/asm-generic/errno-base.h>
diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 938ca539aaa6..e15d3cf768c9 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -3,19 +3,19 @@
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
+#include <vdso/mman.h>
+#include <vdso/page.h>
 
-#undef PAGE_SIZE
-#undef PAGE_MASK
-#define PAGE_SIZE (1UL << CONFIG_PAGE_SHIFT)
-#define PAGE_MASK (~(PAGE_SIZE - 1))
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(x)	(sizeof(x) / sizeof(*x))
+#endif
+
+#ifndef min_t
+#define min_t(type,a,b)	((type)(a) < (type)(b) ? (type)(a) : (type)(b))
+#endif
 
 #define MEMCPY_AND_ZERO_SRC(type, dst, src, len) do {				\
 	while (len >= sizeof(type)) {						\
@@ -79,8 +79,8 @@ __cvdso_getrandom_data(const struct vdso_rng_data *rng_info, void *buffer, size_
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
-- 
2.34.1



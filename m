Return-Path: <linux-arch+bounces-7372-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C15897ED19
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 16:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC3A1C21B1E
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 14:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C71A01BD;
	Mon, 23 Sep 2024 14:20:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92AB19F405;
	Mon, 23 Sep 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101212; cv=none; b=adFdZeAYEEXXzHY0sPrTMqqL8bps9xnD+W2Lu+m9wlYQlJWE3cySBYA8RHwAmDHeH2469IIdY7y816mB1ZdDIsil6QmQAxp37zkYIaYcbX8cdDf1WHUKGf0fdKKWHmDNOQEklkPVXBX/WuPzcu23Zkal3N/cbm3GJsbhtaIgwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101212; c=relaxed/simple;
	bh=T2oISrvxXehn0HeStUX3ERGD6DuD25HXys//54NTnu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jlwubd67oqDKhw9I1tzT6tzBFUEXkj5jqFQtsRYq7nRWH+oefu0rL3ohhjtuijk6B5REUZ9i8DkoXPRcGShHVxFM5DuFP4cuS9nAUfzTz8M77q+w/uWivEgjBmDtS3GRWMDD2XdoVa/XsT66Kswzb5+qUqHRuMFOkCBN+fKY92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BCCB11FB;
	Mon, 23 Sep 2024 07:20:38 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82CB13F64C;
	Mon, 23 Sep 2024 07:20:06 -0700 (PDT)
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
Subject: [PATCH v2 7/8] vdso: Introduce uapi/vdso/random.h
Date: Mon, 23 Sep 2024 15:19:42 +0100
Message-Id: <20240923141943.133551-8-vincenzo.frascino@arm.com>
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

Introduce uapi/vdso/random.h to make sure that the generic
library uses only the allowed namespace.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/uapi/linux/random.h | 26 +------------------------
 include/uapi/vdso/random.h  | 38 +++++++++++++++++++++++++++++++++++++
 include/vdso/datapage.h     |  1 +
 3 files changed, 40 insertions(+), 25 deletions(-)
 create mode 100644 include/uapi/vdso/random.h

diff --git a/include/uapi/linux/random.h b/include/uapi/linux/random.h
index 1dd047ec98a1..dc43ed800212 100644
--- a/include/uapi/linux/random.h
+++ b/include/uapi/linux/random.h
@@ -44,30 +44,6 @@ struct rand_pool_info {
 	__u32	buf[];
 };
 
-/*
- * Flags for getrandom(2)
- *
- * GRND_NONBLOCK	Don't block and return EAGAIN instead
- * GRND_RANDOM		No effect
- * GRND_INSECURE	Return non-cryptographic random bytes
- */
-#define GRND_NONBLOCK	0x0001
-#define GRND_RANDOM	0x0002
-#define GRND_INSECURE	0x0004
-
-/**
- * struct vgetrandom_opaque_params - arguments for allocating memory for vgetrandom
- *
- * @size_per_opaque_state:	Size of each state that is to be passed to vgetrandom().
- * @mmap_prot:			Value of the prot argument in mmap(2).
- * @mmap_flags:			Value of the flags argument in mmap(2).
- * @reserved:			Reserved for future use.
- */
-struct vgetrandom_opaque_params {
-	__u32 size_of_opaque_state;
-	__u32 mmap_prot;
-	__u32 mmap_flags;
-	__u32 reserved[13];
-};
+#include <vdso/random.h>
 
 #endif /* _UAPI_LINUX_RANDOM_H */
diff --git a/include/uapi/vdso/random.h b/include/uapi/vdso/random.h
new file mode 100644
index 000000000000..5c80995129c2
--- /dev/null
+++ b/include/uapi/vdso/random.h
@@ -0,0 +1,38 @@
+
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * include/vdso/random.h
+ *
+ * Include file for the random number generator.
+ */
+
+#ifndef _UAPI_VDSO_RANDOM_H
+#define _UAPI_VDSO_RANDOM_H
+
+/*
+ * Flags for getrandom(2)
+ *
+ * GRND_NONBLOCK	Don't block and return EAGAIN instead
+ * GRND_RANDOM		No effect
+ * GRND_INSECURE	Return non-cryptographic random bytes
+ */
+#define GRND_NONBLOCK	0x0001
+#define GRND_RANDOM	0x0002
+#define GRND_INSECURE	0x0004
+
+/**
+ * struct vgetrandom_opaque_params - arguments for allocating memory for vgetrandom
+ *
+ * @size_per_opaque_state:	Size of each state that is to be passed to vgetrandom().
+ * @mmap_prot:			Value of the prot argument in mmap(2).
+ * @mmap_flags:			Value of the flags argument in mmap(2).
+ * @reserved:			Reserved for future use.
+ */
+struct vgetrandom_opaque_params {
+	__u32 size_of_opaque_state;
+	__u32 mmap_prot;
+	__u32 mmap_flags;
+	__u32 reserved[13];
+};
+
+#endif /* _UAPI_VDSO_RANDOM_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index b85f24cac3f5..b7d6c71f20c1 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -8,6 +8,7 @@
 #include <uapi/linux/time.h>
 #include <uapi/linux/types.h>
 #include <uapi/asm-generic/errno-base.h>
+#include <uapi/vdso/random.h>
 
 #include <vdso/bits.h>
 #include <vdso/clocksource.h>
-- 
2.34.1



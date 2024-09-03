Return-Path: <linux-arch+bounces-6955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504D396A1DA
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8328A1C20D46
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001118B47C;
	Tue,  3 Sep 2024 15:15:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298E188592;
	Tue,  3 Sep 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376512; cv=none; b=jBQjw61dNDWfn/7mdQ/pawgVy032R4wUMX+eU6mpwg9Ssm9h0PcbV5VYj4usgVP60PAUsj3Tb6tdEsqOYCNR+yoxnjrYbEb2ku9M+ZhGkfEPRl7Mo2A8YEHt+gSYh6uQgw/xcJOwLJl9inPY5Lq07TQyQDNXSSsL9dg4Cd9rado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376512; c=relaxed/simple;
	bh=Xxvmw4fx2BextUfcqa7AgtyaDEXu6xgVDZiwpuwkJBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgPwl7GhHO1jBmNnxiP/wHj8+ra9/Srh85Nxuc1Jo72CoeDF/VfRijsQ9xN8MyYkFz38Lxv7R0q3IAadKKBe2GhTz4EMKqo8ftA02TvI8oe39lSjv2m1wBV9/iCeds+H73SN0By7FcBYPDnz9QbfJMuTt8lU3GtZWJcEJQeebU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D484B1063;
	Tue,  3 Sep 2024 08:15:36 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E6113F66E;
	Tue,  3 Sep 2024 08:15:07 -0700 (PDT)
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
Subject: [PATCH 5/9] vdso: Split linux/minmax.h
Date: Tue,  3 Sep 2024 16:14:33 +0100
Message-Id: <20240903151437.1002990-6-vincenzo.frascino@arm.com>
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

Split linux/minmax.h to make sure that the generic library
uses only the allowed namespace.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/minmax.h | 28 +---------------------------
 include/vdso/minmax.h  | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 27 deletions(-)
 create mode 100644 include/vdso/minmax.h

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 98008dd92153..846e3fa65c96 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>
 #include <linux/const.h>
 #include <linux/types.h>
+#include <vdso/minmax.h>
 
 /*
  * min()/max()/clamp() macros must accomplish three things:
@@ -84,17 +85,6 @@
 #define __types_ok3(x,y,z,ux,uy,uz) \
 	(__sign_use(x,ux) & __sign_use(y,uy) & __sign_use(z,uz))
 
-#define __cmp_op_min <
-#define __cmp_op_max >
-
-#define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
-
-#define __cmp_once_unique(op, type, x, y, ux, uy) \
-	({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
-
-#define __cmp_once(op, type, x, y) \
-	__cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
-
 #define __careful_cmp_once(op, x, y, ux, uy) ({		\
 	__auto_type ux = (x); __auto_type uy = (y);	\
 	BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),	\
@@ -204,22 +194,6 @@
  * Or not use min/max/clamp at all, of course.
  */
 
-/**
- * min_t - return minimum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
- */
-#define min_t(type, x, y) __cmp_once(min, type, x, y)
-
-/**
- * max_t - return maximum of two values, using the specified type
- * @type: data type to use
- * @x: first value
- * @y: second value
- */
-#define max_t(type, x, y) __cmp_once(max, type, x, y)
-
 /*
  * Do not check the array parameter using __must_be_array().
  * In the following legit use-case where the "array" passed is a simple pointer,
diff --git a/include/vdso/minmax.h b/include/vdso/minmax.h
new file mode 100644
index 000000000000..26724f34c513
--- /dev/null
+++ b/include/vdso/minmax.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_MINMAX_H
+#define __VDSO_MINMAX_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler.h>
+
+#define __cmp_op_min <
+#define __cmp_op_max >
+
+#define __cmp(op, x, y)	((x) __cmp_op_##op (y) ? (x) : (y))
+
+#define __cmp_once_unique(op, type, x, y, ux, uy) \
+	({ type ux = (x); type uy = (y); __cmp(op, ux, uy); })
+
+#define __cmp_once(op, type, x, y) \
+	__cmp_once_unique(op, type, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
+
+/**
+ * min_t - return minimum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define min_t(type, x, y) __cmp_once(min, type, x, y)
+
+/**
+ * max_t - return maximum of two values, using the specified type
+ * @type: data type to use
+ * @x: first value
+ * @y: second value
+ */
+#define max_t(type, x, y) __cmp_once(max, type, x, y)
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __VDSO_MINMAX_H */
-- 
2.34.1



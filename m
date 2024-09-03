Return-Path: <linux-arch+bounces-6956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3386D96A1DC
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4FB1288F48
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BDC187340;
	Tue,  3 Sep 2024 15:15:15 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF92D18732D;
	Tue,  3 Sep 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376515; cv=none; b=W1CoP2L6K7cErU8jpg6HgeGo+kuWuqkyyghlKM0urXyFYrc8Apm9joiuhD6bfmR4pbj3/k/rxZ5hILZgYIlLEmhCtwt3EOx5pb8Pq6sSJILxtqTkkieortYJOyaGqPMrik6/8GUfy4JN+J0bzJPWYJkUNkjn1yrHP402G2wsI7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376515; c=relaxed/simple;
	bh=fxatXbimRwhegXeLQFCycbGwkziUK7b6e3mc0zIAjlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gNUBI5x6EeVWXag1eGmWjfcPCHdkgdcI82Tc1No/7DCPPyobJEQ455G8jKf3cKzZdkL5eV2fjm80XSUHuZ3IKuEI5MPt7BR8wQ4TJ7MLUutHTaflfGkMAYJfGuPK+2e12Zlatadqbjqy4kbDPlVhETqgY7E0AtcLxZ1Ck2AHin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F1961424;
	Tue,  3 Sep 2024 08:15:40 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD1443F66E;
	Tue,  3 Sep 2024 08:15:10 -0700 (PDT)
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
Subject: [PATCH 6/9] vdso: Split linux/array_size.h
Date: Tue,  3 Sep 2024 16:14:34 +0100
Message-Id: <20240903151437.1002990-7-vincenzo.frascino@arm.com>
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

Split linux/array_size.h to make sure that the generic library
uses only the allowed namespace.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/array_size.h |  8 +-------
 include/vdso/array_size.h  | 13 +++++++++++++
 2 files changed, 14 insertions(+), 7 deletions(-)
 create mode 100644 include/vdso/array_size.h

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
index 06d7d83196ca..ca9e63b419c4 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -2,12 +2,6 @@
 #ifndef _LINUX_ARRAY_SIZE_H
 #define _LINUX_ARRAY_SIZE_H
 
-#include <linux/compiler.h>
-
-/**
- * ARRAY_SIZE - get the number of elements in array @arr
- * @arr: array to be sized
- */
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+#include <vdso/array_size.h>
 
 #endif  /* _LINUX_ARRAY_SIZE_H */
diff --git a/include/vdso/array_size.h b/include/vdso/array_size.h
new file mode 100644
index 000000000000..4079f7a5f86e
--- /dev/null
+++ b/include/vdso/array_size.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _VDSO_ARRAY_SIZE_H
+#define _VDSO_ARRAY_SIZE_H
+
+#include <linux/compiler.h>
+
+/**
+ * ARRAY_SIZE - get the number of elements in array @arr
+ * @arr: array to be sized
+ */
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+
+#endif  /* _VDSO_ARRAY_SIZE_H */
-- 
2.34.1



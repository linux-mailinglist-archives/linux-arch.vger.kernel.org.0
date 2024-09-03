Return-Path: <linux-arch+bounces-6953-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCAE96A1D7
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3DFB26AF2
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBD61891D6;
	Tue,  3 Sep 2024 15:15:06 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2022301;
	Tue,  3 Sep 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376506; cv=none; b=qbAYftUqg6740cp/3YlFPvI6JM5mgGJY4ZqDYJzcSzRAZjylL2XQXFbQ5Tt0Jb21wHA2i1/IC7gQVxFkob31+ETgNnZTXH6Du/uz9SNuC4ikfjBE88dXJFcQwIvrMeaOxH8KG5reJzxloMYng1nMOnwygf9+3UYG68PNYXCV1iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376506; c=relaxed/simple;
	bh=nsmh4geF98am874ryh9Py797zRx/es9hw+xk/gW4siM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blP/9U9vahpQpFznYvjljPucMApSazsxXkkgHEqw5ktQU/Tf8IR/ovNIWPgHn5iIzBTs23AZDp8rZXgLx3nJ6UnwaSV4l55ePaKA1Ncis81PWDxymKMIyj6Xmr6mfiOaOzju7znx2TW4jVClNUon0DIugM1nAaYlmJpL5HnBuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 805B91474;
	Tue,  3 Sep 2024 08:15:30 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2218F3F66E;
	Tue,  3 Sep 2024 08:15:01 -0700 (PDT)
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
Subject: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
Date: Tue,  3 Sep 2024 16:14:31 +0100
Message-Id: <20240903151437.1002990-4-vincenzo.frascino@arm.com>
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

Introduce asm/vdso/page.h to make sure that the generic library
uses only the allowed namespace.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/x86/include/asm/vdso/page.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/x86/include/asm/vdso/page.h

diff --git a/arch/x86/include/asm/vdso/page.h b/arch/x86/include/asm/vdso/page.h
new file mode 100644
index 000000000000..b0af8fbef27c
--- /dev/null
+++ b/arch/x86/include/asm/vdso/page.h
@@ -0,0 +1,15 @@
+
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_PAGE_H
+#define __ASM_VDSO_PAGE_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/page_types.h>
+
+#define VDSO_PAGE_MASK	PAGE_MASK
+#define VDSO_PAGE_SIZE	PAGE_SIZE
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_PAGE_H */
-- 
2.34.1



Return-Path: <linux-arch+bounces-7367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB497ED07
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 16:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F109F28224A
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C7319E838;
	Mon, 23 Sep 2024 14:19:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0853319E826;
	Mon, 23 Sep 2024 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101197; cv=none; b=XJbc9/pWW5epY7+JyA0TkvF4k0zrSAi67RJnIJmAz2SU+l3RBYeKBw/PFCRAKuaoyN8sMKhAAgYxVPQ/0F+UCFPQ492wW6ApYRyvFnsMUZqBJVgtR5+qFbaN9BY79KizTFNxw+0BedX6CIKaqeXGQIOH/LhB0O7bkcjUFs3HwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101197; c=relaxed/simple;
	bh=RG/cfpXH/muOmJVkgTisiDMbLDgDLywHXvGg2kVl3YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nn7IgD+rv5dPqr+6l4CsqSK0SNoz2+fQoC+WRXoayzszTVbUX5OMiI7P0klRTtYp0lTvwvT2Akp9/tqtILXYGNtFQYk1bo4VQW1eoujlumMLz39RMte8+ap3qRZYYtb28Cl8X5BzagmpCT9vFEPyGjQwQ7MjTSSYtpFRKunuR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D48CA11FB;
	Mon, 23 Sep 2024 07:20:24 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB8593F64C;
	Mon, 23 Sep 2024 07:19:52 -0700 (PDT)
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
Subject: [PATCH v2 2/8] arm64: vdso: Introduce asm/vdso/mman.h
Date: Mon, 23 Sep 2024 15:19:37 +0100
Message-Id: <20240923141943.133551-3-vincenzo.frascino@arm.com>
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

Introduce asm/vdso/mman.h to make sure that the generic library
uses only the allowed namespace.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso/mman.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm64/include/asm/vdso/mman.h

diff --git a/arch/arm64/include/asm/vdso/mman.h b/arch/arm64/include/asm/vdso/mman.h
new file mode 100644
index 000000000000..4c936c9d11ab
--- /dev/null
+++ b/arch/arm64/include/asm/vdso/mman.h
@@ -0,0 +1,15 @@
+
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_MMAN_H
+#define __ASM_VDSO_MMAN_H
+
+#ifndef __ASSEMBLY__
+
+#include <uapi/linux/mman.h>
+
+#define VDSO_MMAP_PROT	PROT_READ | PROT_WRITE
+#define VDSO_MMAP_FLAGS	MAP_DROPPABLE | MAP_ANONYMOUS
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_MMAN_H */
-- 
2.34.1



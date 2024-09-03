Return-Path: <linux-arch+bounces-6951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7A596A1D2
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1231C24092
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6AA184554;
	Tue,  3 Sep 2024 15:14:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E01885A2;
	Tue,  3 Sep 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376499; cv=none; b=SEGtMBrBGHve2oQIZdpDpG3rY2osx0cu/QmwDQg9DSY+LVI1+RJelOC9SDqnhG+GFIrBB6SsI/iRnDkXYSJYRYmlUOfnX78LAWSWy06y47uDayB56AL5ouwXcuitXnIcHX6VIbh3aYYYOpj1EhJSX75V2IkVcWRq3uqx1sBc3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376499; c=relaxed/simple;
	bh=Q+uEKjljLMMbWJRJJ0llywrdLPKoWQ9iKTwHByqxue8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YubepL5W7UQGgh8Hvg/xL7eYQdNJ2aQb1cVEstHKmJtdxw4/Lv58g2ztc/hq+NnKBHOMlLWFES1UZkJ+ItJLpsd3dkvM8Hgo7Cz/8EMi6XRzVtHfvjkAvTEyCoNb5V2InM/cQwT8JE61Gst1XjORxbwG3GlbS3DvlDBqKrqcnwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C42A1063;
	Tue,  3 Sep 2024 08:15:24 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAAB13F66E;
	Tue,  3 Sep 2024 08:14:54 -0700 (PDT)
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
Subject: [PATCH 1/9] x86: vdso: Introduce asm/vdso/mman.h
Date: Tue,  3 Sep 2024 16:14:29 +0100
Message-Id: <20240903151437.1002990-2-vincenzo.frascino@arm.com>
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

Introduce asm/vdso/mman.h to make sure that the generic library
uses only the allowed namespace.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/x86/include/asm/vdso/mman.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/x86/include/asm/vdso/mman.h

diff --git a/arch/x86/include/asm/vdso/mman.h b/arch/x86/include/asm/vdso/mman.h
new file mode 100644
index 000000000000..4c936c9d11ab
--- /dev/null
+++ b/arch/x86/include/asm/vdso/mman.h
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



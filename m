Return-Path: <linux-arch+bounces-6954-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4586896A1D8
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781DA1C240E2
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E018189BB0;
	Tue,  3 Sep 2024 15:15:09 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B261898E6;
	Tue,  3 Sep 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376509; cv=none; b=pL5bHjfVT0UB5A+019KZNF2L7C8WH55MQbEiKttN6JOmvzbXItbWVh0uxM0JSiqEL40QpbLqwi0oS35l7jZfrF7xutbE2hxqxFwTUBjE/E8PZq9Ptaa+2iJ+9E8C4AdnvHZnULjDeBKsmp+7DYzzI+nW8w0Dj995rDGA0pqYuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376509; c=relaxed/simple;
	bh=k7lpsuqWWibXoV3RJuYS86+W8S6wzKWBURChHvIVijU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rw2f0q+2Jim95pK1TqvGl4FIV8c03z7HpayKYAlyPvOgOyR2Yv+w2tkF3u8U8baKpNeRm7PChOwRmxKuce0xuz9KntyaMjBY+cBN3fyCW6z/feYPa0xYBIjE4qIuStrl4m9AbMoErUEEUeIUvxvdZ8RUFaY9sVzWNDfxDUUUBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A63EEFEC;
	Tue,  3 Sep 2024 08:15:33 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504DF3F66E;
	Tue,  3 Sep 2024 08:15:04 -0700 (PDT)
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
Subject: [PATCH 4/9] vdso: Introduce vdso/page.h
Date: Tue,  3 Sep 2024 16:14:32 +0100
Message-Id: <20240903151437.1002990-5-vincenzo.frascino@arm.com>
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

Introduce vdso/page.h to make sure that the generic library
uses only the allowed namespace.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/page.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 include/vdso/page.h

diff --git a/include/vdso/page.h b/include/vdso/page.h
new file mode 100644
index 000000000000..f18e304941cb
--- /dev/null
+++ b/include/vdso/page.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_PAGE_H
+#define __VDSO_PAGE_H
+
+#include <asm/vdso/page.h>
+
+#endif	/* __VDSO_PAGE_H */
-- 
2.34.1



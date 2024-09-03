Return-Path: <linux-arch+bounces-6952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D796A1D4
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 17:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3346D1C238F9
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01904188A3E;
	Tue,  3 Sep 2024 15:15:03 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CA7188938;
	Tue,  3 Sep 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376502; cv=none; b=MQtMdxeTq6SyLnT7Kc0d61/Y7N/l8QR/aDCJDrz9LBheKehHVn90NVb9IFHsV0vvMy9X+0AUWDxCKfPDUwPqSBsNHlIGDMw5IZAVVlO9O/Gtgo2C5ocEXEN9QMtCT65V3vtGmNjaqZUbivUyrVIP1gD5osGOzMjBUc0tZHDLh4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376502; c=relaxed/simple;
	bh=bBzISRReGVBxfhmbyVzs2I5ENYJmBXaF4IKTHC+ss/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utR4zNTWwr+ZQv5NeWvkhQjhZ12NrXVLrAj4XELJYXcKMFf2XXLy8pfawdgNMmqzqHa0+2+qKJSRLdoH0L7FvY5Nmgd7qd5Unydj48rHQtHpBA3M5piLOcBvgQKHV+sGApteCber2rElzGzHqe+6jm5aWLlRD5ZB035WRLPkGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 496971424;
	Tue,  3 Sep 2024 08:15:27 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8CFF3F66E;
	Tue,  3 Sep 2024 08:14:57 -0700 (PDT)
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
Subject: [PATCH 2/9] vdso: Introduce vdso/mman.h
Date: Tue,  3 Sep 2024 16:14:30 +0100
Message-Id: <20240903151437.1002990-3-vincenzo.frascino@arm.com>
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

Introduce vdso/mman.h to make sure that the generic library
uses only the allowed namespace.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/vdso/mman.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 include/vdso/mman.h

diff --git a/include/vdso/mman.h b/include/vdso/mman.h
new file mode 100644
index 000000000000..95e3da714c64
--- /dev/null
+++ b/include/vdso/mman.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_MMAN_H
+#define __VDSO_MMAN_H
+
+#include <asm/vdso/mman.h>
+
+#endif	/* __VDSO_MMAN_H */
-- 
2.34.1



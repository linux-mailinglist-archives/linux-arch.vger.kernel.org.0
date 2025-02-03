Return-Path: <linux-arch+bounces-9962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4C9A252FD
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 08:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6AD1629A8
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5821E260C;
	Mon,  3 Feb 2025 07:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eiXyn5H9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d4PQcDGa"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021F2AE99;
	Mon,  3 Feb 2025 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738567598; cv=none; b=a+ViKcmsa3CdJf6hhgeAYsdThEbYW9rDEZ5etIjh/LO2fWEufIWEUhcdPJU6wf6ijuFiRy3rURafBBj9OmMue0DxwxbiRZm9VtQOV4U05m69W9zB7zxIVog4ldSX5gzYdlOT4gSt+I3oT41hXalSEyWGNJMx7L5bynrHHz6rlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738567598; c=relaxed/simple;
	bh=EsY9mv3Ft9PmhX/XvueUEsGFS8g7TsjkC+vY8EhZl/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HBpcYXfuHZY9gnzCd8Enq817qd/EiTYtB4ktBmnQTgGeCw/MmLJ9KRw5yiT/dSjc1hmEA7rzU8AcOsQXds4fRXVdAVZYRx9WnD2BvKeXZAk1dsZfmc4zihGl00ZD/Phw69zU1UIcpNRwKVx1JNLKmSsHkjs4efrMHtpETZ8kyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eiXyn5H9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d4PQcDGa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738567588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eoaKnCKJmvXrDrdAtKF1Z2hUqlDG8isSz3qg8Dq/520=;
	b=eiXyn5H9ROUyZGxFJu30+mPxwFPrKGl32gpnrHZ0Rx5hR8BvoaPxMufkZxWoLfQt/oVHpI
	xrZKfbGEJWqrDqMZyAXgW0SlLEa4T2MKOfJl5/LqceaBJwNkGQvS0E+cidDZiOGPwO0hwg
	hh9qgkY8tqtrgYJVDE1EeZ0FMgUsT9IrfXAQls25RhMkVehkZCGgBp8DTruUkoloe9YxYo
	p3t0frl5Mu5wF1xXbAMQWIovYvoUYO8UtjiI0h+Bla9EIoj4rte0cK90uZV30aN6dqoNmH
	6sxYu4Cqfk8Si8phAbYjktryMDQh7ddbgCLZyR6+ASpx2bkvXJAwCqqNM1GA/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738567588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eoaKnCKJmvXrDrdAtKF1Z2hUqlDG8isSz3qg8Dq/520=;
	b=d4PQcDGan0h1MbBeRFanmWc858IWIMqjtDiAfjyQ9wcceJR8jlqxyohxVLJ+sS0KdcLFQ3
	vcf3/jC/WbBJIuBg==
Date: Mon, 03 Feb 2025 08:26:22 +0100
Subject: [PATCH] iomap: Fix -Wmissing-prototypes on UM
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJ1voGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyNL3dJc3cx8XbO0tJQ0Q0szc3OTZCWg2oKi1LTMCrA50bG1tQCNLY0
 LVwAAAA==
X-Change-ID: 20250129-um-io-6ffdf196774c
To: Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738567587; l=3395;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=EsY9mv3Ft9PmhX/XvueUEsGFS8g7TsjkC+vY8EhZl/w=;
 b=kKbo6LD1ZXtwmDNrQdWmzvqMl1QObLTFzhsw3my4nhRNE1JfOgSUsOck+4eKAb960/5TyklOh
 P0A+VvNW8AXAXl6PRGIx7RpBcyhfjRblM2dXI8QlEBCEwHBqsHmbFBE
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Building lib/iomap.o on UM triggers warnings about missing prototypes.
These prototypes should be defined by asm-generic/iomap.h, depending on
other symbols. For example "ioread64_lo_hi" is based on "readq".
However the generic variants of those tested symbols are defined in
asm-generic/io.h, only after asm-generic/iomap.h has already been
included, breaking the ifdef logic.

Move the inclusion of asm-generic/iomap.h in asm-generic/io.h after the
generic symbols have been defined, so the checks can work.

Triggered warnings:

$ make ARCH=um allyesconfig lib/iomap.o
make[1]: Entering directory '/tmp/um'
  GEN     Makefile
  GEN     Makefile
  CALL    scripts/checksyscalls.sh
  CC      lib/iomap.o
lib/iomap.c:156:5: error: no previous prototype for ‘ioread64_lo_hi’ [-Werror=missing-prototypes]
  156 | u64 ioread64_lo_hi(const void __iomem *addr)
      |     ^~~~~~~~~~~~~~
lib/iomap.c:163:5: error: no previous prototype for ‘ioread64_hi_lo’ [-Werror=missing-prototypes]
  163 | u64 ioread64_hi_lo(const void __iomem *addr)
      |     ^~~~~~~~~~~~~~
lib/iomap.c:170:5: error: no previous prototype for ‘ioread64be_lo_hi’ [-Werror=missing-prototypes]
  170 | u64 ioread64be_lo_hi(const void __iomem *addr)
      |     ^~~~~~~~~~~~~~~~
lib/iomap.c:178:5: error: no previous prototype for ‘ioread64be_hi_lo’ [-Werror=missing-prototypes]
  178 | u64 ioread64be_hi_lo(const void __iomem *addr)
      |     ^~~~~~~~~~~~~~~~
lib/iomap.c:264:6: error: no previous prototype for ‘iowrite64_lo_hi’ [-Werror=missing-prototypes]
  264 | void iowrite64_lo_hi(u64 val, void __iomem *addr)
      |      ^~~~~~~~~~~~~~~
lib/iomap.c:272:6: error: no previous prototype for ‘iowrite64_hi_lo’ [-Werror=missing-prototypes]
  272 | void iowrite64_hi_lo(u64 val, void __iomem *addr)
      |      ^~~~~~~~~~~~~~~
lib/iomap.c:280:6: error: no previous prototype for ‘iowrite64be_lo_hi’ [-Werror=missing-prototypes]
  280 | void iowrite64be_lo_hi(u64 val, void __iomem *addr)
      |      ^~~~~~~~~~~~~~~~~
iomap.c:288:6: error: no previous prototype for ‘iowrite64be_hi_lo’ [-Werror=missing-prototypes]
  288 | void iowrite64be_hi_lo(u64 val, void __iomem *addr)
      |      ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Fixes: 0fcb70851fbf ("Makefile.extrawarn: turn on missing-prototypes globally")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/asm-generic/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a5cbbf3e26ec7d06f7e67ee9731021031b39aa13..1bfdc4d5643054701c27073c146a6d8cc3903384 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -13,10 +13,6 @@
 #include <linux/types.h>
 #include <linux/instruction_pointer.h>
 
-#ifdef CONFIG_GENERIC_IOMAP
-#include <asm-generic/iomap.h>
-#endif
-
 #include <asm/mmiowb.h>
 #include <asm-generic/pci_iomap.h>
 
@@ -1250,4 +1246,8 @@ extern int devmem_is_allowed(unsigned long pfn);
 
 #endif /* __KERNEL__ */
 
+#ifdef CONFIG_GENERIC_IOMAP
+#include <asm-generic/iomap.h>
+#endif
+
 #endif /* __ASM_GENERIC_IO_H */

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250129-um-io-6ffdf196774c

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>



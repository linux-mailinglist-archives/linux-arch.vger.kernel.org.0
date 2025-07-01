Return-Path: <linux-arch+bounces-12541-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F82FAEF241
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96C13B1396
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1789B273811;
	Tue,  1 Jul 2025 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K9BaqrOY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ld+FVHv"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB926E6F1;
	Tue,  1 Jul 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360295; cv=none; b=PMX427KOXUSsQbaQllHtf3+Th8cFW8HF40PfkNGIOYEGU92IJY7LcJTSNl1N8S4KGjFn7mzyD/x37/C32iiVybiK12Aru2avISs4zkKuPVw27c2w+jHpXlUqi7IAlz05wF8E5OT6j5O9wYHVoKnUMemduj7W/M0qUEzu+A+NdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360295; c=relaxed/simple;
	bh=bpk3KAQY5N8I4k57sZludGnIuWomX8iO/06DkAxXS9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urrf3lBa6HJO7Pc59HBF3UDw4MeWUUQ7OZj+CTgwqRDT7xoMvYRqtJFFwnYF4cbQo1OMrklEInDxRvJ6YLv1YnIDpdJPG6r2VC2Poq3XeJld9ivlmx69/A3h/PukcyStPiHifBaxDebMc5nz/8hxE3mShrASFx60ql1M0rToN7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K9BaqrOY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ld+FVHv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HKU/uJy0IuunrWhxLM2EASE6yRF5K6bEQO5QIgY2ek=;
	b=K9BaqrOYFqnofn5P2Mt2X6g2ua5GThBRPRyNjGUZC4scdamlJpMYD5gNN573zW/J2bL+31
	wrLYKUQpeAfHswC7nPzAEKWEd6XAVCW3kVbu1T6D+uYTW7WgYNtPK4NtQpSkbFVCWJqpMy
	ygVkULpruELUspdcQEvyIkXrAnToczefld2yN7H0pLbwgtp4nnbtEMOQMc3QZGaurqw3bQ
	qO0ZyF9ZSvMxNQeF0XVc7Di9v3BFriVSCNqStPIV1b2RsYJWpnldRVtrPYyKk+vinObRtd
	twC+cM+VJqsIInUsqht9j/u5wZ85mC4SuS5B0eTP5RxHC9bJIYPVTDAbhztbNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1HKU/uJy0IuunrWhxLM2EASE6yRF5K6bEQO5QIgY2ek=;
	b=0ld+FVHvitgzjdEPmJc5YG8pha2EOVxZLZQXEFjdJHO/97hXtm+rM1dRcF9PN9MjtFmFHP
	psvwp2Ok0d2zy6DA==
Date: Tue, 01 Jul 2025 10:58:07 +0200
Subject: [PATCH 13/14] Revert "selftests: vDSO: parse_vdso: Use UAPI
 headers instead of libc headers"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-13-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
In-Reply-To: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
 Richard Cochran <richardcochran@gmail.com>, 
 Christopher Hall <christopher.s.hall@intel.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Miroslav Lichvar <mlichvar@redhat.com>, 
 Werner Abt <werner.abt@meinberg-usa.com>, 
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, 
 Antoine Tenart <atenart@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=1843;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=bpk3KAQY5N8I4k57sZludGnIuWomX8iO/06DkAxXS9U=;
 b=hKaFZYN5LZWjWFdnd5ob07pCwqSWQ1FiB4gHtjSVxkxW6JM6TYu4NjNH4o5Qpcii7niW8wMfN
 4gEk5rzDT8rBZPxvq/KqzJIjggVPd3ZFDJYgqFRkH1+mkuMlafKiRVY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This reverts commit c9fbaa879508 ("selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers")

The kernel headers were used to make parse_vdso.c compatible with nolibc.
Unfortunately linux/elf.h is incompatible with glibc's sys/auxv.h.
When using glibc it is therefore not possible build parse_vdso.c as part of the
same compilation unit as its caller as sys/auxv.h is needed for getauxval().

In the meantime nolibc gained its own elf.h, providing compatibility with the
documented libc interfaces.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/vDSO/Makefile     | 2 --
 tools/testing/selftests/vDSO/parse_vdso.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 12a0614b9fd4983deffe5d6a7cfa06ba8d92a516..67ead1ba6cb9c6d6088680a9c4d24a9d19f7231f 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -20,8 +20,6 @@ endif
 
 include ../lib.mk
 
-CFLAGS += $(TOOLS_INCLUDES)
-
 CFLAGS_NOLIBC := -nostdlib -nostdinc -ffreestanding -fno-asynchronous-unwind-tables \
 		 -fno-stack-protector -include $(top_srcdir)/tools/include/nolibc/nolibc.h \
 		 -I$(top_srcdir)/tools/include/nolibc/ $(KHDR_INCLUDES)
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 3ff00fb624a44b964cc54954f1f088cabe11a901..c6ff4413ea367ae57bc6a60073314b29f938c99d 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -19,8 +19,7 @@
 #include <stdint.h>
 #include <string.h>
 #include <limits.h>
-#include <linux/auxvec.h>
-#include <linux/elf.h>
+#include <elf.h>
 
 #include "parse_vdso.h"
 

-- 
2.50.0



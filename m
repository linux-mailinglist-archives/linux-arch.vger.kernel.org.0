Return-Path: <linux-arch+bounces-12537-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F189BAEF23A
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2F2444BA7
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9652727FF;
	Tue,  1 Jul 2025 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OU0d6ovJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+OMgzfx8"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920C270EC8;
	Tue,  1 Jul 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360294; cv=none; b=aaco+A6DDZue1PGrAUCtja42Ighu5nLowswydKhNXKkIf+/bvdUCvHVJT5KVEjqcaU2Hb+H2QWr92lVFwuGIfxcQDxOqa9O8OGASVL47yBOteA03+Gih/sd25+1neqE7/1xvOTQ7R23cUDpVPHo4OQU8vkZJSCb6HXE8t0qBf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360294; c=relaxed/simple;
	bh=QLkkveUI/cyGTLTyApgh10OSDNXJ3sXYct42yO3P5B0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBjSgUIUCYtdMbKgIb9+tNXSHZrJQlqkS904XRHrNTpUOn1eFanhXIIsBG6t6JzLpuhxgCjMrhk710YggIBFEF/U5Rq31lQgMRMwK9P8Rev+wrdXq4iFUp0knKqJPuo1kwu6SK31hGuX4m0yHfyUFposqzGfaLaXlqo6burvXvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OU0d6ovJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+OMgzfx8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j01uzCoLVpnyze/ne4qVPEjweSMhaL+T/SfXMybPgVw=;
	b=OU0d6ovJHnj+NG7timt9a2g47DdM/l6V8vNHRRCHU0tb2nmj/mxJLvc2WYicLFE0dYHx7E
	hwPYnSCtm/lV/4RiGCJHaWu6Cvb2TR9CqYkIzIH4m+vQlgJl2BSB0nbKOCIVejdj8KCGzT
	da+KlCNMsDAnY4ewAstftHZm7IeEIcHicbgF9R82bzPFPI5w4TxW1CAp4Vtt8m3JQZr+yg
	m4LvZUNysPiTG4yFHMkx2hmmbKPygkdOQWpw8UkDPJJ2MetJ4TAJFWGIPqPtaQ0Y5YDc4j
	blyqDuE3T54WX9MieaB2vFTe+3n+dyNIgYzbdEV6Q/y/teG8kXStt47xlurMOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j01uzCoLVpnyze/ne4qVPEjweSMhaL+T/SfXMybPgVw=;
	b=+OMgzfx8O8M8wqez+hCXg6yGhzfqiC+uJQrKAjMfTNDAfi78MoMpEL6m55UMJRKP2MKUdH
	9mEWAnKVmsqUGUBA==
Date: Tue, 01 Jul 2025 10:58:04 +0200
Subject: [PATCH 10/14] vdso: Introduce aux_clock_resolution_ns()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-10-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=1617;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QLkkveUI/cyGTLTyApgh10OSDNXJ3sXYct42yO3P5B0=;
 b=R8Ek6dz1meGMCadr7lA0G0xaOobq5oTQx63iTTSrhy6xilDGAYn7vlT45j/KMLSiBBuaePOs8
 f+1StZD0FpkDR8PTXaqwnWJ5w40lEfFP0WlKydEOKc/miaPfb697wmm
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Move the constant resolution to a shared header,
so the vDSO can use it and return it without going through a syscall.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/auxclock.h   | 13 +++++++++++++
 kernel/time/timekeeping.c |  6 ++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/vdso/auxclock.h b/include/vdso/auxclock.h
new file mode 100644
index 0000000000000000000000000000000000000000..6d6e74cbc400e7f5cd7194280759f5e5f3059900
--- /dev/null
+++ b/include/vdso/auxclock.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _VDSO_AUXCLOCK_H
+#define _VDSO_AUXCLOCK_H
+
+#include <uapi/linux/time.h>
+#include <uapi/linux/types.h>
+
+static __always_inline u64 aux_clock_resolution_ns(void)
+{
+	return 1;
+}
+
+#endif /* _VDSO_AUXCLOCK_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6a61887eb87e364b3ef170939919a8d4046c0508..6a088378df54d561ecfeafb45a8b54333e11a9a7 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -26,6 +26,8 @@
 #include <linux/audit.h>
 #include <linux/random.h>
 
+#include <vdso/auxclock.h>
+
 #include "tick-internal.h"
 #include "ntp_internal.h"
 #include "timekeeping_internal.h"
@@ -2842,8 +2844,8 @@ static int aux_get_res(clockid_t id, struct timespec64 *tp)
 	if (!clockid_aux_valid(id))
 		return -ENODEV;
 
-	tp->tv_sec = 0;
-	tp->tv_nsec = 1;
+	tp->tv_sec = aux_clock_resolution_ns() / NSEC_PER_SEC;
+	tp->tv_nsec = aux_clock_resolution_ns() % NSEC_PER_SEC;
 	return 0;
 }
 

-- 
2.50.0



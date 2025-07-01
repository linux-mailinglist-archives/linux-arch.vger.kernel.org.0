Return-Path: <linux-arch+bounces-12530-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8CCAEF218
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 10:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2D418935DE
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 08:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B75526C395;
	Tue,  1 Jul 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yHKwD2Q5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AuFZMdoz"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695D26A08C;
	Tue,  1 Jul 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360290; cv=none; b=sCFkIyBzxNLRIcY7Sq3hxu3ix5ydQGpm0Ujw5S7CREXUqpUMbHgl/h2Uqv8Ru5znGQmfdbl1J1IgEjfQrfO5LwIIxuOU/eoQxQs3aNgbiSoXYqUVLr9qerdVXG0Zl3CJWnDZgq2/ruDgyw9JIdLhpPkdVgLlZyAKpIGWJsPKfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360290; c=relaxed/simple;
	bh=7aTgq0KSjM6EGaXtNhSs9nQlKXik5A0X/dUKdIChsT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qBpcUNKvwP8mZFbiUFMOfqrNjJPJm6Q1H9tfDLj5+lp5LojLWq/JTzBeHZqvTkPi3MusiBNh1vQeplwIGrkkS+SEbJCl+GFHd0wGJBFjeECHpxEeYVutqBe0GQVBBN/Ra1Qk1Kd0dFHE1vJGhYHD6V8D35mwG1Dz6bDq0hVFZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yHKwD2Q5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AuFZMdoz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+04s1T3yXqZrrf3aK3nXtq7h92lG6xtvLkzD/OirFg=;
	b=yHKwD2Q5pHM3DAgZXj244Xh5OLAiiOnolD2S6MvXgxek2cL49J3kEGXFMBeYnVwMjx2sqS
	33DUSS9tBcITt0bjfFYgqmKnhlNrnwH1m5oQAtDE9JLICsHFsRdJXnsAhzaLXdUVA9e7ho
	/Af4JFo4ZfqQBpfnBjBdXJk5CzetI9Mi9rJomFbdbBjucV5OObAQC3DGQJMI8YoMr6xKRs
	6gV71fi7QVahC5ZFwPhf8vhMooaJMDfhBdG2V2rAPLurOX6x0VqAeOUbe68V6YqifvzBom
	irSv4Rt84flYLCHMQWsQc0ZKkVOJrcfFZ/GjVfNqcaDe/X2/Vj6NdNtrarukqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+04s1T3yXqZrrf3aK3nXtq7h92lG6xtvLkzD/OirFg=;
	b=AuFZMdozwhxxl4czhHsrAJjfJ6FrL8qsqQQWXGRVIwh1aHSCVfgD9N2IxH9pBDeor0f1os
	H3cU/qtRD96lhRAQ==
Date: Tue, 01 Jul 2025 10:57:57 +0200
Subject: [PATCH 03/14] vdso/vsyscall: Split up __arch_update_vsyscall()
 into __arch_update_vdso_clock()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-3-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=2862;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=7aTgq0KSjM6EGaXtNhSs9nQlKXik5A0X/dUKdIChsT0=;
 b=5+hqp1gTVgnk3Y+ZA8yf+WT55NlfCoI2CtKaCxxJB92agsCM4gnSJpWL0J1ICnFCSb6eFEGuc
 CTULiQ+9dTBBGkm84WQcYFGeX83ew8QQHoSPXfu1uq4UoUqki8d8Peh
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The upcoming auxiliary clocks need this hook, too.
To separate the architecture hooks from the timekeeper internals, refactor
the hook to only operate on a single vDSO clock.

While at it, use a more robust #define for the hook override.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/asm/vdso/vsyscall.h | 7 +++----
 include/asm-generic/vdso/vsyscall.h    | 6 +++---
 kernel/time/vsyscall.c                 | 3 ++-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
index de58951b8df6a4bb9afd411878793c79c30adbf2..417aae5763a86f39acffe1e6f96cb0e57212d04b 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -13,12 +13,11 @@
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
 static __always_inline
-void __arm64_update_vsyscall(struct vdso_time_data *vdata)
+void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
-	vdata->clock_data[CS_HRES_COARSE].mask	= VDSO_PRECISION_MASK;
-	vdata->clock_data[CS_RAW].mask		= VDSO_PRECISION_MASK;
+	vc->mask	= VDSO_PRECISION_MASK;
 }
-#define __arch_update_vsyscall __arm64_update_vsyscall
+#define __arch_update_vdso_clock __arch_update_vdso_clock
 
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index b550afa15ecd101d821f51ce9105903978dced40..7fc0b560007dd8f09a2f24ace76ce68579ad17c1 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -22,11 +22,11 @@ static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_data(vo
 
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
 
-#ifndef __arch_update_vsyscall
-static __always_inline void __arch_update_vsyscall(struct vdso_time_data *vdata)
+#ifndef __arch_update_vdso_clock
+static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
 }
-#endif /* __arch_update_vsyscall */
+#endif /* __arch_update_vdso_clock */
 
 #ifndef __arch_sync_vdso_time_data
 static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index d655df2597336f7305bfc74e2a87c651f314267b..df6bada2d58ed9a03e5dd3cb4b218983089a2877 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -118,7 +118,8 @@ void update_vsyscall(struct timekeeper *tk)
 	if (clock_mode != VDSO_CLOCKMODE_NONE)
 		update_vdso_time_data(vdata, tk);
 
-	__arch_update_vsyscall(vdata);
+	__arch_update_vdso_clock(&vc[CS_HRES_COARSE]);
+	__arch_update_vdso_clock(&vc[CS_RAW]);
 
 	vdso_write_end(vdata);
 

-- 
2.50.0



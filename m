Return-Path: <linux-arch+bounces-12536-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E00AEF227
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55BD1BC542F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 09:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A918B271A7C;
	Tue,  1 Jul 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wB37phIU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZgZmCR6h"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B529D26B09A;
	Tue,  1 Jul 2025 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360293; cv=none; b=K1tlUSGldgTxZpSYQezJmH9ImcUO8tQ569ZJz+CUuEY12heee+R71EgBu8kcnKT6yUDSZOVpFcdX0jXO2edXi0Q8OK3QUbTxyyCbgEFlLj0gnICxmMkXzwQ+oKq8SpbOwcUKLyWH9THNqPtg6z4AvJzi04Kqn1SzK/swSqJ697Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360293; c=relaxed/simple;
	bh=CC5cQSfSGmKdKkeZa7p5tvupyfG2CLNGehREDf1mFcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OHTF7f41mTwowO9YT0QktMOdR1R4Qc2iEd+ZugYFMeDh6hPSm13WDoyOOBtYuWA2mNa0pNCxhEHeT/Ysbp1rZKMv7qQtWEmnu2b5GBCqH0OCkYB/D/WGXX9Fci1idZXLsYGagL7XHgfVGeNWuzOYqs8KXAz+iFbTDrN15gNij5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wB37phIU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZgZmCR6h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUv1tHn4Gb15SCtBOdwANRio4D/S8/QmhpZlRN18zW8=;
	b=wB37phIU1cgHL9oe4WYfMGliy5jbaoTzF0DhUFJs/rOu6Z9k1d3vYlAoN9EKggIwQUdu7l
	+TljAEBva1iFEhXtwj719UDDhlB7E7ALl8cwsgv8F+HUkIarv/qpDzLbPy7v4o/GeFoOFd
	2R4a1ZFq2m8qwljdwSfFlnkniHuUtcqgGxU+sUvfvGw1lpcFjL8gkz81eCl3e1b7Pk8VKb
	10dcpeqesAIzny9jyLb46PnxK5K9QIJu7XVW1XaC7Hw+NAvENeYfSx+DUhGLnd9jyQJXPU
	ot0rpxGS270Y+z4vxiKynztpNbEmcLdOyJkwgdvYSvWmLEQ/LGbCnC4ntsmYTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUv1tHn4Gb15SCtBOdwANRio4D/S8/QmhpZlRN18zW8=;
	b=ZgZmCR6hsNO6h+aAy42Sjmgm6zIioVVD4G5orMl9SniBw8do+p9kwhp5Mrhd+6o7spFRYw
	zppOqtmG7rk7GaCA==
Date: Tue, 01 Jul 2025 10:58:02 +0200
Subject: [PATCH 08/14] vdso/gettimeofday: Introduce vdso_set_timespec()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-8-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=2428;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CC5cQSfSGmKdKkeZa7p5tvupyfG2CLNGehREDf1mFcc=;
 b=7doTRp//wkLzPlGHPeeVXsRB2rVPSQaX9szW5pOx13TUBMCDQh6Ba5Lm0uy/yEitK/NoNivtP
 C/e1SD9At+pB4f04mSGvpQui1WuaofZ+BHAxek5oRzMozDtD+tqbaLD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

This code is duplicated and with the introduction of auxiliary clocks will
be duplicated even more.

Introduce a helper.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 215151bd5a1320ee6edda8f334d47c739577f696..50611ba28abfcfc7841616e8787101ea1ffcb7d8 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -77,6 +77,16 @@ static __always_inline bool vdso_clockid_valid(clockid_t clock)
 	return likely((u32) clock < MAX_CLOCKS);
 }
 
+/*
+ * Must not be invoked within the sequence read section as a race inside
+ * that loop could result in __iter_div_u64_rem() being extremely slow.
+ */
+static __always_inline void vdso_set_timespec(struct __kernel_timespec *ts, u64 sec, u64 ns)
+{
+	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec = ns;
+}
+
 #ifdef CONFIG_TIME_NS
 
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
@@ -122,12 +132,7 @@ bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *
 	sec += offs->sec;
 	ns += offs->nsec;
 
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
+	vdso_set_timespec(ts, sec, ns);
 
 	return true;
 }
@@ -188,12 +193,7 @@ bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
 
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec = ns;
+	vdso_set_timespec(ts, sec, ns);
 
 	return true;
 }
@@ -223,12 +223,8 @@ bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock
 	sec += offs->sec;
 	nsec += offs->nsec;
 
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
-	ts->tv_nsec = nsec;
+	vdso_set_timespec(ts, sec, nsec);
+
 	return true;
 }
 #else

-- 
2.50.0



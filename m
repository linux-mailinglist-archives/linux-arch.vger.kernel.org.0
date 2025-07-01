Return-Path: <linux-arch+bounces-12534-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45762AEF232
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999F7445071
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D36271453;
	Tue,  1 Jul 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOuClH5z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JUWHL11Y"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD526D4D5;
	Tue,  1 Jul 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360293; cv=none; b=R/CQf1z4wvm/rAIDVzDdm7Qbj3gK1z3uDs6EYz8ThC/hxI8/K/+MP7X2EMebRXuMybt20jK2wiNNQ1TS/5YGjqV3LK5CT9r4TVaYhYhuhRQPMnIDJkz4v9M9EQwLOucpxlnw1MwqD9KIgczGUowSrRQA3ki61NW9mFXgNYsIS8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360293; c=relaxed/simple;
	bh=hXHsnYDcoK6vZrSu6iAfWgcpr0RtJi0oTjs+lySQy+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDHFGaV6UUGKjh2SeavuWeUFPe7sL4Jdvhj9NaJHn5eR81m2MQxGqauF9CX4Ap0PsD/wgRa5BCV2+7ZzT2xSkhOrzwy5xanVmgVABjZD7DqCM9mmd9h9KEFkpYp+6OSIoIQ3gA5ZdGZb7+wzIBQrdPIGLXkRLXisHptB8YWpPfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JOuClH5z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JUWHL11Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cikZxWQJUp10v41R0BNtsJYkeVVYRn1u1TYcRTLvcoQ=;
	b=JOuClH5zQfirMyVQzHci+YfWykFkJQAT07wxXn8bnSfP4v2Mtf+khZO8PSEMtF5vyKm2kz
	r9Sikskh2A//wDpioSHNcdhBU907OkSp6RxyCqpFzG8qB/Y0Gnpyju4ax0/BBFlQIn7iV9
	azZNnRv7uHbwqAQ/uzD8ey9XSnndaMTkvoPtMwxEJxmxnYJLXsfA5gLdbVNMaUJSdPldIZ
	wjjgeBdVsnfqK8THDT6DDv0sBNshupWmWDV+pchmGkAbCgjGLE4tDXdD1N5OYnFQEg4btp
	+DHxqtWX5GHGrBp6V60Y/Pdj4EitHMpYXPS1TM0+AuTM0vn2bZf2nTS/ZDR/9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cikZxWQJUp10v41R0BNtsJYkeVVYRn1u1TYcRTLvcoQ=;
	b=JUWHL11Y6dNQ7/wHtW7b8xlh7JM5awfSucplCUe0MFlcjzaQ9+fKPqu+fLeoBv4h/ZcJVx
	+HsBDFUhjK1wERAA==
Date: Tue, 01 Jul 2025 10:58:00 +0200
Subject: [PATCH 06/14] vdso/gettimeofday: Return bool from clock_gettime()
 helpers
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=6489;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=hXHsnYDcoK6vZrSu6iAfWgcpr0RtJi0oTjs+lySQy+A=;
 b=HQ6guH4xKYzDLrGcPir6sQ0D8ksrjbFgWflXvOxV/zrvFpJHB21lBA59Vudl9gKnpFZ5XRa3n
 qIsPlaEK4LvA65HlAXaFwZAVlN+fBWsOzWip/2yX8Py+WUG7TeVh+S7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The internal helpers are effectively using boolean results,
while pretending to use error numbers.

Switch the return type to bool for more clarity.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 58 +++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9b77f23566f6a35887d4c9aaefc61a971131b499..c5266532a097c06f33d12e345c695357d75abf42 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -82,8 +82,8 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_tim
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
 
 static __always_inline
-int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
-		   clockid_t clk, struct __kernel_timespec *ts)
+bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
+		    clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs = &vcns->offset[clk];
@@ -103,11 +103,11 @@ int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *v
 		seq = vdso_read_begin(vc);
 
 		if (unlikely(!vdso_clocksource_ok(vc)))
-			return -1;
+			return false;
 
 		cycles = __arch_get_hw_counter(vc->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
-			return -1;
+			return false;
 		ns = vdso_calc_ns(vc, cycles, vdso_ts->nsec);
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
@@ -123,7 +123,7 @@ int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *v
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	return 0;
+	return true;
 }
 #else
 static __always_inline
@@ -133,16 +133,16 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_tim
 }
 
 static __always_inline
-int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
-		   clockid_t clk, struct __kernel_timespec *ts)
+bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
+		    clockid_t clk, struct __kernel_timespec *ts)
 {
-	return -EINVAL;
+	return false;
 }
 #endif
 
 static __always_inline
-int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
-	    clockid_t clk, struct __kernel_timespec *ts)
+bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	     clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vc->basetime[clk];
 	u64 cycles, sec, ns;
@@ -150,7 +150,7 @@ int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 
 	/* Allows to compile the high resolution parts out */
 	if (!__arch_vdso_hres_capable())
-		return -1;
+		return false;
 
 	do {
 		/*
@@ -173,11 +173,11 @@ int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 		smp_rmb();
 
 		if (unlikely(!vdso_clocksource_ok(vc)))
-			return -1;
+			return false;
 
 		cycles = __arch_get_hw_counter(vc->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
-			return -1;
+			return false;
 		ns = vdso_calc_ns(vc, cycles, vdso_ts->nsec);
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
@@ -189,13 +189,13 @@ int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	return 0;
+	return true;
 }
 
 #ifdef CONFIG_TIME_NS
 static __always_inline
-int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
-		     clockid_t clk, struct __kernel_timespec *ts)
+bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
+		      clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs = &vcns->offset[clk];
@@ -223,20 +223,20 @@ int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock
 	 */
 	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
 	ts->tv_nsec = nsec;
-	return 0;
+	return true;
 }
 #else
 static __always_inline
-int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
-		     clockid_t clk, struct __kernel_timespec *ts)
+bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
+		      clockid_t clk, struct __kernel_timespec *ts)
 {
-	return -1;
+	return false;
 }
 #endif
 
 static __always_inline
-int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
-	      clockid_t clk, struct __kernel_timespec *ts)
+bool do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	       clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vc->basetime[clk];
 	u32 seq;
@@ -258,10 +258,10 @@ int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
 
-	return 0;
+	return true;
 }
 
-static __always_inline int
+static __always_inline bool
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 			     struct __kernel_timespec *ts)
 {
@@ -270,7 +270,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 
 	/* Check for negative values or invalid clocks */
 	if (unlikely((u32) clock >= MAX_CLOCKS))
-		return -1;
+		return false;
 
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
@@ -284,7 +284,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 	else if (msk & VDSO_RAW)
 		vc = &vc[CS_RAW];
 	else
-		return -1;
+		return false;
 
 	return do_hres(vd, vc, clock, ts);
 }
@@ -293,9 +293,11 @@ static __maybe_unused int
 __cvdso_clock_gettime_data(const struct vdso_time_data *vd, clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
-	int ret = __cvdso_clock_gettime_common(vd, clock, ts);
+	bool ok;
 
-	if (unlikely(ret))
+	ok = __cvdso_clock_gettime_common(vd, clock, ts);
+
+	if (unlikely(!ok))
 		return clock_gettime_fallback(clock, ts);
 	return 0;
 }

-- 
2.50.0



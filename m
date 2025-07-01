Return-Path: <linux-arch+bounces-12533-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454D6AEF230
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 11:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBBE44301C
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 08:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D6C271449;
	Tue,  1 Jul 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3Bq7jJD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5bleG6OH"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F0C26D4D4;
	Tue,  1 Jul 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360292; cv=none; b=XVzs1ZkrC3KbHsYewYyiZ1TV/C/waw4Ev8ry4Drce9EfpFhGG/hEyn692rt4Gla12q7Jgo0WbN38bw1AfE+X/Uk0iXyjy+3vQ9u1P0INEVokIqp+sztPribZrHhOpSJugY8obCz8y9ACOxqhjQmSUHDONK6Hy3xgM9+zzH0hUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360292; c=relaxed/simple;
	bh=WrNmDq00XPL9/kcKPoWaUE05zyuMZ1wASlKqJKUZvV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FwY+XhfXMMIj9/wV8RL88hbAg+OYdR8I0gvYVFfFLXzkuTkQJAON0tQxpdZWe6ttYRc3yt7iRSwaHoKJBemQwLzsHo+vCCZC6peReLlBK1aFj4qKB3LsQr42el7fOce/3o7WSRxNpkNE4OJM58BPOOLw58xlTxdOf+6+bSLDpOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3Bq7jJD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5bleG6OH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjeWk9zqwweIgociDbPCS45o0KwQTUtlv3dSFR85Uf8=;
	b=Q3Bq7jJDuyJYZZNBtxqwLQORnk+1VWGdxJ5VZ/5n8JC/Mp6Fh3IvRjPoe8G8c0J+O4T5VE
	KiXJoAnvbFFP+I9owauyAUuofSNFbRFmNmAAlI/WXPdFRPZDl53qNiW6E27P3L/ZMBI16s
	qBqoY0bkaLg4ux9pXGa3+j+8s4HtxsXK9Ucwf07oYqOx4pM5NJCPGma7zvJHD6T7NV5kWU
	6snc5AaEYoCE6BEb9WUvw6WQ0iJAii/iN7RA+ekjlYTBxiU0cDl0XejtXF5qlD5RCkEFHF
	mZoDHsqrvQPWbssyF7Qg4Y4QJvS9uLooQRwRkXv/zzc6th7h3hgqCnLvgMYu7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EjeWk9zqwweIgociDbPCS45o0KwQTUtlv3dSFR85Uf8=;
	b=5bleG6OHL3bnoymfUdalPRYi3NtkgJM/zEM5og7glKoX+JQWYLzWp5LXRyJEIBHoy0aVuP
	xxQtI3Ds9lIF9eCg==
Date: Tue, 01 Jul 2025 10:57:59 +0200
Subject: [PATCH 05/14] vdso/gettimeofday: Return bool from clock_getres()
 helpers
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-5-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=2609;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=WrNmDq00XPL9/kcKPoWaUE05zyuMZ1wASlKqJKUZvV4=;
 b=tN3l3TzL2aN33IdNstQl9X9W45CCH/yMvg2ndeJaAOtYqHqBFxk+zMlSkxDO3EBvMH4sMt5em
 LTTGotpyffNDjM9h5UsfpqDXNLO0vxPFLzrx5nuppVM50KXpkxEBIh0
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The internal helpers are effectively using boolean results,
while pretending to use error numbers.

Switch the return type to bool for more clarity.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 93ef801a97ef25f66195490d14e41bebcd41982b..9b77f23566f6a35887d4c9aaefc61a971131b499 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -396,8 +396,8 @@ static __maybe_unused __kernel_old_time_t __cvdso_time(__kernel_old_time_t *time
 
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t clock,
-				struct __kernel_timespec *res)
+bool __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t clock,
+				 struct __kernel_timespec *res)
 {
 	const struct vdso_clock *vc = vd->clock_data;
 	u32 msk;
@@ -405,7 +405,7 @@ int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t clock
 
 	/* Check for negative values or invalid clocks */
 	if (unlikely((u32) clock >= MAX_CLOCKS))
-		return -1;
+		return false;
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vc->clock_mode == VDSO_CLOCKMODE_TIMENS)
@@ -427,23 +427,25 @@ int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t clock
 		 */
 		ns = LOW_RES_NSEC;
 	} else {
-		return -1;
+		return false;
 	}
 
 	if (likely(res)) {
 		res->tv_sec = 0;
 		res->tv_nsec = ns;
 	}
-	return 0;
+	return true;
 }
 
 static __maybe_unused
 int __cvdso_clock_getres_data(const struct vdso_time_data *vd, clockid_t clock,
 			      struct __kernel_timespec *res)
 {
-	int ret = __cvdso_clock_getres_common(vd, clock, res);
+	bool ok;
 
-	if (unlikely(ret))
+	ok =  __cvdso_clock_getres_common(vd, clock, res);
+
+	if (unlikely(!ok))
 		return clock_getres_fallback(clock, res);
 	return 0;
 }
@@ -460,18 +462,18 @@ __cvdso_clock_getres_time32_data(const struct vdso_time_data *vd, clockid_t cloc
 				 struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
-	int ret;
+	bool ok;
 
-	ret = __cvdso_clock_getres_common(vd, clock, &ts);
+	ok = __cvdso_clock_getres_common(vd, clock, &ts);
 
-	if (unlikely(ret))
+	if (unlikely(!ok))
 		return clock_getres32_fallback(clock, res);
 
 	if (likely(res)) {
 		res->tv_sec = ts.tv_sec;
 		res->tv_nsec = ts.tv_nsec;
 	}
-	return ret;
+	return 0;
 }
 
 static __maybe_unused int

-- 
2.50.0



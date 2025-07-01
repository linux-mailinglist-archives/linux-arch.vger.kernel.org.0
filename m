Return-Path: <linux-arch+bounces-12529-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F4AEF213
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 10:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7DB917947F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 08:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40426B2D8;
	Tue,  1 Jul 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cvfq+ShZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sgmfuKLl"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3364E269CE5;
	Tue,  1 Jul 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751360289; cv=none; b=pqhchpC/Hnuidc9FTle4bCGgLiAJUyurHy6A3oRzIceBxh+x27RzGu5A7LhcxEZzs3waesG2ujtxClzSsUF80fKa67pD0KTl897yIJZ9bOJLXN9siaWyvvhyw6wyDgDdjDvqNK46st8+IJBFVgkqW/gcK+X0lJrabKcjZ1ADpdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751360289; c=relaxed/simple;
	bh=O+pdqhovJ5sCWr6cbVQYxtHMRmPHnT/rOYl0Ec66rdg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ag5fVhsu+aVFOHA1oYpyLDuoIEkgFpDSwOLYflO8N2HN0OROgn09BYkYbibARkODwCUktEbHX703HPc6zBf2wNBlsLKprlAOvr1wH9XOggt9GWFST6CoxJkrcVwC5xz5KS3MuRkeuM2YhOqs8Og70ve++rpXMe3Rxy9wIXGvyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cvfq+ShZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sgmfuKLl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751360286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zypL7Z/iJT9pt/jkPKsLbW/urAL7A4U3k+sv3E7jTg=;
	b=Cvfq+ShZBlRpqLEBOnn8FpMD0gK9w7CyXjIFIZyjrEoM5IoNGvRbep0gq3pyn8BIui/Kxk
	A2ViNmKpkZH3NAdGzCMMSnEmMhFfJ7Duypk+z7Ll3zCgk+TAscf2ipjjyetPBEQXzSBbC+
	080IcZD8bWfUkplxeUn94zbQD8NxbmiybQ5LND26COt6UwpdzUostFo8qh30YjPMwhRgKz
	5V3+YoJ5WGXZnEhhocJjZ7gokZtoaqaU9m0iwvEHUGkqKJ2qY99XWY0Wdjb+Bhml8q+g9J
	GhWElpAyu+wNRJ40rjxUxuo2hMiFJ4JDrZ8bg7wScZFxRqtQnamLnOpobO9X0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751360286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6zypL7Z/iJT9pt/jkPKsLbW/urAL7A4U3k+sv3E7jTg=;
	b=sgmfuKLl97WFPgJQ2Cl1kAqQzhUmEQJC6TCmpkh3zY+DwrRRPYl9zbjgCqmJcyT/Wiqf4S
	jPoLsppETFf6eeBg==
Date: Tue, 01 Jul 2025 10:57:56 +0200
Subject: [PATCH 02/14] vdso/vsyscall: Introduce a helper to fill clock
 configurations
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-vdso-auxclock-v1-2-df7d9f87b9b8@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751360285; l=2069;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=O+pdqhovJ5sCWr6cbVQYxtHMRmPHnT/rOYl0Ec66rdg=;
 b=p8vqvlzZbfPJuNB7hzPJj8dga3B+cwPmwh+UN2KNgYAAY1i/FYSqtwEPROhvYlPu5RH0FZzN+
 FzVHcGeNczjCyKAn7W8w6ERqHRSTH7MY5nl/wpUomcMyoG9AGWRKpyy
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The logic to configure a 'struct vdso_clock' from a
'struct tk_read_base' is copied two times.
Split it into a shared function to reduce the duplication,
especially as another user will be added for auxiliary clocks.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/time/vsyscall.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 32ef27c71b57aaa4ed898c0dbfdefcb73b8ff56a..d655df2597336f7305bfc74e2a87c651f314267b 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -15,26 +15,25 @@
 
 #include "timekeeping_internal.h"
 
+static inline void fill_clock_configuration(struct vdso_clock *vc, const struct tk_read_base *base)
+{
+	vc->cycle_last	= base->cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	vc->max_cycles	= base->clock->max_cycles;
+#endif
+	vc->mask	= base->mask;
+	vc->mult	= base->mult;
+	vc->shift	= base->shift;
+}
+
 static inline void update_vdso_time_data(struct vdso_time_data *vdata, struct timekeeper *tk)
 {
 	struct vdso_clock *vc = vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
 	u64 nsec, sec;
 
-	vc[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
-#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vc[CS_HRES_COARSE].max_cycles	= tk->tkr_mono.clock->max_cycles;
-#endif
-	vc[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
-	vc[CS_HRES_COARSE].mult		= tk->tkr_mono.mult;
-	vc[CS_HRES_COARSE].shift	= tk->tkr_mono.shift;
-	vc[CS_RAW].cycle_last		= tk->tkr_raw.cycle_last;
-#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vc[CS_RAW].max_cycles		= tk->tkr_raw.clock->max_cycles;
-#endif
-	vc[CS_RAW].mask			= tk->tkr_raw.mask;
-	vc[CS_RAW].mult			= tk->tkr_raw.mult;
-	vc[CS_RAW].shift		= tk->tkr_raw.shift;
+	fill_clock_configuration(&vc[CS_HRES_COARSE],	&tk->tkr_mono);
+	fill_clock_configuration(&vc[CS_RAW],		&tk->tkr_raw);
 
 	/* CLOCK_MONOTONIC */
 	vdso_ts		= &vc[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];

-- 
2.50.0



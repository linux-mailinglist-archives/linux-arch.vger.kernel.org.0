Return-Path: <linux-arch+bounces-10495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C7A4BE1A
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 12:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80D23BA162
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 11:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5C1F7914;
	Mon,  3 Mar 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cl0AoCOK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TBsb7Kj6"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71101F461B;
	Mon,  3 Mar 2025 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000276; cv=none; b=PHzCVh1A1Od+JKUKX1tJ3OAOx9CD0OEQLFlPWX3ViwPQ2fUoNSCNvfIz0fshTS+mkfDDM4+w9TLAix4cwOa2Kno28jiWlrTpu6OoHQZZtLljfkFJ1yMlgcUlwAvL8liA5WMER1uJb2p2B1FE9abE4vI3sjqZwL7JQvoLfifTOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000276; c=relaxed/simple;
	bh=G2oLk+J9gljjJufo60Ofx2Y0FsbxRQDawRxpTY6igvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlqD0docul0XOm1CAjSjntjQ6l3yQG0usgn7TKBKeNQRUIX2D2KKUZXPH+VL6SP8YY4TG1bYbmdxdRuNHEPAK8gw1jmrwEb33htFyBPZ2tjWwrTzMdh27a9Yzo52XkRUUvRpsjq/WXqgP0iLyP9esNKyTZBXoiYHNXXh9twVLuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cl0AoCOK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TBsb7Kj6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiNmzZsI+IlqtlcCBw/HCwN6rFN2wNt5TZpQsWV/3tM=;
	b=Cl0AoCOKpupsyYAO5IIgXBPx/dwzDoqlSEJGaUvOMylaTpHHIysdjntn6Ctsm2nL8hX+sQ
	s+hryKYal9Rf4xH1DDeKAvcA8b+VRvXZvRDeExzwKnT9KgewllMkt2vjUNHN3dME4h16xV
	c9yStGjf3FgZfuBqqsnHFW+LguzchG+7SpKFCg9KG8lwctVwJNoYxgIssr5sz8crgS/xFe
	uUHF7HWBAp/rDaeSLRSsOyqmzUS7zuXuUaORbp/oy0m1KA6XZ8VI1wSFLmSfR9r5cIQmax
	jrGrCvTqlym1ZlCxYF0o6wRbUE+ROt5zBaTvMvtnlk/qugj5cmykO3jRzgxxEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiNmzZsI+IlqtlcCBw/HCwN6rFN2wNt5TZpQsWV/3tM=;
	b=TBsb7Kj66vCWCP6XUXD66wGWbCHqHHClQq6fuw1EMoMniwrPAF35PE+ig41PwgKMDBDvum
	B5IuuFkqNjH6/uAg==
Date: Mon, 03 Mar 2025 12:11:08 +0100
Subject: [PATCH 06/19] vdso/gettimeofday: Prepare introduction of struct
 vdso_clock
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250303-vdso-clock-v1-6-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
In-Reply-To: <20250303-vdso-clock-v1-0-c1b5c69a166f@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741000267; l=3916;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=h8QoW/f3rU49l2BZnno5Ej+ilYnLc5MZmanJRJHxpLU=;
 b=abZnNYKsOGQP0oaHmpAMUtb18E47BKabUrpm1zoCjuMbUMyy9sW8Ip3ryJLR33/fwFe0OAmg2
 YSR+Gw5l1bnBYcJlJ/sMhD6901iTtR4NjPETiMDq5/6NGQFwLwu2CGa
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. At the moment, vdso_clock
is simply a define which maps vdso_clock to vdso_time_data.

Prepare all functions which need the pointer to the vdso_clock array to
work well after introducing the new struct. Whenever applicable, struct
vdso_time_data pointer is replaced by struct vdso_clock pointer.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/vdso/gettimeofday.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 299f027116ee0e50a69c5a8a17218004e4af0ea1..59369a4e9f25f937eb8d9aed3201ebd340097a9d 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -257,6 +257,7 @@ static __always_inline int
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 			     struct __kernel_timespec *ts)
 {
+	const struct vdso_clock *vc = vd;
 	u32 msk;
 
 	/* Check for negative values or invalid clocks */
@@ -269,15 +270,15 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
 	 */
 	msk = 1U << clock;
 	if (likely(msk & VDSO_HRES))
-		vd = &vd[CS_HRES_COARSE];
+		vc = &vc[CS_HRES_COARSE];
 	else if (msk & VDSO_COARSE)
-		return do_coarse(&vd[CS_HRES_COARSE], clock, ts);
+		return do_coarse(&vc[CS_HRES_COARSE], clock, ts);
 	else if (msk & VDSO_RAW)
-		vd = &vd[CS_RAW];
+		vc = &vc[CS_RAW];
 	else
 		return -1;
 
-	return do_hres(vd, clock, ts);
+	return do_hres(vc, clock, ts);
 }
 
 static __maybe_unused int
@@ -328,11 +329,12 @@ static __maybe_unused int
 __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
+	const struct vdso_clock *vc = vd;
 
 	if (likely(tv != NULL)) {
 		struct __kernel_timespec ts;
 
-		if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+		if (do_hres(&vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
 
 		tv->tv_sec = ts.tv_sec;
@@ -341,7 +343,7 @@ __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 
 	if (unlikely(tz != NULL)) {
 		if (IS_ENABLED(CONFIG_TIME_NS) &&
-		    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
+		    vc->clock_mode == VDSO_CLOCKMODE_TIMENS)
 			vd = __arch_get_vdso_u_timens_data(vd);
 
 		tz->tz_minuteswest = vd[CS_HRES_COARSE].tz_minuteswest;
@@ -361,13 +363,16 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 static __maybe_unused __kernel_old_time_t
 __cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *time)
 {
+	const struct vdso_clock *vc = vd;
 	__kernel_old_time_t t;
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
-	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
+	    vc->clock_mode == VDSO_CLOCKMODE_TIMENS) {
 		vd = __arch_get_vdso_u_timens_data(vd);
+		vc = vd;
+	}
 
-	t = READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	t = READ_ONCE(vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
 
 	if (time)
 		*time = t;
@@ -386,6 +391,7 @@ static __maybe_unused
 int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t clock,
 				struct __kernel_timespec *res)
 {
+	const struct vdso_clock *vc = vd;
 	u32 msk;
 	u64 ns;
 
@@ -394,7 +400,7 @@ int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t clock
 		return -1;
 
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
-	    vd->clock_mode == VDSO_CLOCKMODE_TIMENS)
+	    vc->clock_mode == VDSO_CLOCKMODE_TIMENS)
 		vd = __arch_get_vdso_u_timens_data(vd);
 
 	/*

-- 
2.48.1



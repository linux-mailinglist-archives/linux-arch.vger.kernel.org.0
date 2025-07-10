Return-Path: <linux-arch+bounces-12624-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A33AFF9B9
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 08:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1740916B73C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BBD2367CB;
	Thu, 10 Jul 2025 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CkDXOzjz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D5628A1C6
	for <linux-arch@vger.kernel.org>; Thu, 10 Jul 2025 06:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128591; cv=none; b=ilIdBTbajmt3255GcuSNAtlD58KNwfHaD0dRsxV3y6WkEGWEVO09px6oEZ8Y4LjgkggqhCdOmC2bp2TKTvyZEBmwtlj8eJud8fkSbgtsuZ4XMSsGU+DiMdwFX/Xbt4Z7FL+5FVy7yVP7TqjZ+FKpEIxcgGHFKyvOdVWzDQDlaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128591; c=relaxed/simple;
	bh=x+m5e/QFvtWFTj5jtNVJ04fQv6jS+clZ5jFJOqMnr1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=MaCw/oI8hHD4ZHBs4wj6hH5/3E8tF6pSpEG0r1WlkoZMo3xZ5kBkvnbnqkOBCfZdQ7cUijnS6KjplODeRc5kjX6m1r3ARuvlZ1Ys1tARt3EIum7XkJvAxCPN/ilbp9PxjurxOn0pl3SxzJzGcELSNf84NJ7e+rB1pQNOo8J9X5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CkDXOzjz; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250710062302euoutp013b2a45b6a7c8cc27a61ff027706ae940~Qz6maDjMU1924519245euoutp01o
	for <linux-arch@vger.kernel.org>; Thu, 10 Jul 2025 06:23:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250710062302euoutp013b2a45b6a7c8cc27a61ff027706ae940~Qz6maDjMU1924519245euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1752128582;
	bh=fjhCYtUcaSq0dNmp/uY6QFONknU1MFIVam9Vx9FJ4HI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=CkDXOzjz0vA7/XzIyo+2hcUn6b9nNB7sPzYh7UO9k4sX7rmzen6MGbAtJqzfReu+i
	 4Dm3Yr3jaCyjnBcp/Si7MGfLNhYU9zPcsar+tR1kRQgOIz3/coNw61WsT5y2LTFqkT
	 7tFSuFUUoRygio+yVh5F3asSyjMeGTI7dntJldFQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250710062301eucas1p1b61431dc31a5933087b45c246866fb17~Qz6lwTyHl1786817868eucas1p1F;
	Thu, 10 Jul 2025 06:23:01 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250710062257eusmtip1e3cd4937da192f21b7bc849539e961f7~Qz6iNiOSW1044910449eusmtip1h;
	Thu, 10 Jul 2025 06:22:57 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Andy Lutomirski
	<luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
	<shuah@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic
	Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>, Stephen
	Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
	Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Richard Cochran
	<richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>,
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt
	<werner.abt@meinberg-usa.com>, David Woodhouse <dwmw2@infradead.org>, Kurt
	Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine
	Tenart <atenart@kernel.org>
Subject: [PATCH] vdso/gettimeofday: Fix code refactoring
Date: Thu, 10 Jul 2025 08:22:49 +0200
Message-Id: <20250710062249.3533485-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250710062301eucas1p1b61431dc31a5933087b45c246866fb17
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250710062301eucas1p1b61431dc31a5933087b45c246866fb17
X-EPHeader: CA
X-CMS-RootMailID: 20250710062301eucas1p1b61431dc31a5933087b45c246866fb17
References: <CGME20250710062301eucas1p1b61431dc31a5933087b45c246866fb17@eucas1p1.samsung.com>

Commit fcc8e46f768f ("vdso/gettimeofday: Return bool from clock_gettime()
helpers") changed the return value from clock_gettime() helpers, but it
missed updating the one call to the do_hres() function, what breaks VDSO
operation on some of my ARM 32bit based test boards. Fix this.

Fixes: fcc8e46f768f ("vdso/gettimeofday: Return bool from clock_gettime() helpers")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 lib/vdso/gettimeofday.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index d6743ed756a1..97aa9059a5c9 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -395,7 +395,7 @@ __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 	if (likely(tv != NULL)) {
 		struct __kernel_timespec ts;
 
-		if (do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+		if (!do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
 
 		tv->tv_sec = ts.tv_sec;
-- 
2.34.1



Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CB55444
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 18:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfFYQSf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 12:18:35 -0400
Received: from foss.arm.com ([217.140.110.172]:44760 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbfFYQSf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 12:18:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 916D1360;
        Tue, 25 Jun 2019 09:18:34 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F12313F718;
        Tue, 25 Jun 2019 09:18:31 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com,
        pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com,
        linux@rasmusvillemoes.dk, huw@codeweavers.com,
        sthotton@marvell.com, andre.przywara@arm.com
Subject: [PATCH 1/3] lib/vdso: Delay mask application in do_hres()
Date:   Tue, 25 Jun 2019 17:18:02 +0100
Message-Id: <20190625161804.38713-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624133607.GI29497@fuggles.cambridge.arm.com>
References: <20190624133607.GI29497@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

do_hres() in the vDSO generic library masks the hw counter value
immediately after reading it.

Postpone the mask application after checking if the syscall fallback is
enabled, in order to be able to detect a possible fallback for the
architectures that have masks smaller than ULLONG_MAX.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/vdso/gettimeofday.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index ef28cc5d7bff..ee1221ba1d32 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -35,12 +35,12 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 
 	do {
 		seq = vdso_read_begin(vd);
-		cycles = __arch_get_hw_counter(vd->clock_mode) &
-			vd->mask;
+		cycles = __arch_get_hw_counter(vd->clock_mode);
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		if (unlikely((s64)cycles < 0))
 			return clock_gettime_fallback(clk, ts);
+		cycles &= vd->mask;
 		if (cycles > last)
 			ns += (cycles - last) * vd->mult;
 		ns >>= vd->shift;
-- 
2.22.0


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB78A3894
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfH3N7X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 09:59:23 -0400
Received: from foss.arm.com ([217.140.110.172]:60826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfH3N7W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 09:59:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9905E1597;
        Fri, 30 Aug 2019 06:59:21 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FAAB3F703;
        Fri, 30 Aug 2019 06:59:19 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com,
        luto@kernel.org
Subject: [PATCH v2 4/8] lib: vdso: Remove VDSO_HAS_32BIT_FALLBACK
Date:   Fri, 30 Aug 2019 14:58:58 +0100
Message-Id: <20190830135902.20861-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190830135902.20861-1-vincenzo.frascino@arm.com>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VDSO_HAS_32BIT_FALLBACK was introduced to address a regression which
caused seccomp to deny access to the applications to clock_gettime64()
and clock_getres64() because they are not enabled in the existing
filters.

The purpose of VDSO_HAS_32BIT_FALLBACK was to simplify the conditional
implementation of __cvdso_clock_get*time32() variants.

Now that all the architectures that support the generic vDSO library
have been converted to support the 32 bit fallbacks the conditional
can be removed.

Cc: Thomas Gleixner <tglx@linutronix.de>
CC: Andy Lutomirski <luto@kernel.org>
References: c60a32ea4f45 ("lib/vdso/32: Provide legacy syscall fallbacks")
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/vdso/gettimeofday.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index a86e89e6dedc..2c4b311c226d 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -126,13 +126,8 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 
 	ret = __cvdso_clock_gettime_common(clock, &ts);
 
-#ifdef VDSO_HAS_32BIT_FALLBACK
 	if (unlikely(ret))
 		return clock_gettime32_fallback(clock, res);
-#else
-	if (unlikely(ret))
-		ret = clock_gettime_fallback(clock, &ts);
-#endif
 
 	if (likely(!ret)) {
 		res->tv_sec = ts.tv_sec;
@@ -240,13 +235,8 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 
 	ret = __cvdso_clock_getres_common(clock, &ts);
 
-#ifdef VDSO_HAS_32BIT_FALLBACK
 	if (unlikely(ret))
 		return clock_getres32_fallback(clock, res);
-#else
-	if (unlikely(ret))
-		ret = clock_getres_fallback(clock, &ts);
-#endif
 
 	if (likely(!ret)) {
 		res->tv_sec = ts.tv_sec;
-- 
2.23.0


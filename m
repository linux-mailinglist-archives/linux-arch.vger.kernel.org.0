Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64CFEA388E
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbfH3N7U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 09:59:20 -0400
Received: from foss.arm.com ([217.140.110.172]:60794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfH3N7T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 09:59:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AD131576;
        Fri, 30 Aug 2019 06:59:18 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7569F3F703;
        Fri, 30 Aug 2019 06:59:16 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com,
        luto@kernel.org
Subject: [PATCH v2 2/8] lib: vdso: Build 32 bit specific functions in the right context
Date:   Fri, 30 Aug 2019 14:58:56 +0100
Message-Id: <20190830135902.20861-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190830135902.20861-1-vincenzo.frascino@arm.com>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

clock_gettime32 and clock_getres_time32 should be compiled only with a
32 bit vdso library.

Exclude these symbols when BUILD_VDSO32 is not defined.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 lib/vdso/gettimeofday.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index e630e7ff57f1..a86e89e6dedc 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -117,6 +117,7 @@ __cvdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 	return 0;
 }
 
+#ifdef BUILD_VDSO32
 static __maybe_unused int
 __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 {
@@ -139,6 +140,7 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
 	}
 	return ret;
 }
+#endif /* BUILD_VDSO32 */
 
 static __maybe_unused int
 __cvdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
@@ -229,6 +231,7 @@ int __cvdso_clock_getres(clockid_t clock, struct __kernel_timespec *res)
 	return 0;
 }
 
+#ifdef BUILD_VDSO32
 static __maybe_unused int
 __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 {
@@ -251,4 +254,5 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
 	}
 	return ret;
 }
+#endif /* BUILD_VDSO32 */
 #endif /* VDSO_HAS_CLOCK_GETRES */
-- 
2.23.0


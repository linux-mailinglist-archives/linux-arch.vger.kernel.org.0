Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9249A1810
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfH2LTK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 07:19:10 -0400
Received: from foss.arm.com ([217.140.110.172]:42750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbfH2LTK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 07:19:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC30F360;
        Thu, 29 Aug 2019 04:19:09 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 441B93F59C;
        Thu, 29 Aug 2019 04:19:08 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com,
        luto@kernel.org
Subject: [PATCH 1/7] arm64: compat: vdso: Expose BUILD_VDSO32
Date:   Thu, 29 Aug 2019 12:18:37 +0100
Message-Id: <20190829111843.41003-2-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190829111843.41003-1-vincenzo.frascino@arm.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

clock_gettime32 and clock_getres_time32 should be compiled only with the
32 bit vdso library.

Expose BUILD_VDSO32 when arm64 compat is compiled, to provide an
indication to the generic library to include these symbols.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index c50ee1b7d5cd..fe7afe0f1a3d 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -17,6 +17,7 @@
 #define VDSO_HAS_CLOCK_GETRES		1
 
 #define VDSO_HAS_32BIT_FALLBACK		1
+#define BUILD_VDSO32			1
 
 static __always_inline
 int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
-- 
2.23.0


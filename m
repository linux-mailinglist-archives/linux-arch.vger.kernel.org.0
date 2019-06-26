Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE6567BB
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 13:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfFZLgs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Jun 2019 07:36:48 -0400
Received: from foss.arm.com ([217.140.110.172]:59152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfFZLgs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jun 2019 07:36:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E2F5360;
        Wed, 26 Jun 2019 04:36:47 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00AED3F718;
        Wed, 26 Jun 2019 04:36:43 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de, salyzyn@android.com,
        pcc@google.com, shuah@kernel.org, 0x7f454c46@gmail.com,
        linux@rasmusvillemoes.dk, huw@codeweavers.com,
        sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] arm64: vdso: Fix compilation with clang older then 8
Date:   Wed, 26 Jun 2019 12:36:32 +0100
Message-Id: <20190626113632.9295-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621095252.32307-5-vincenzo.frascino@arm.com>
References: <20190621095252.32307-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

clang versions older then 8 do not support -mcmodel=tiny.

Add a check to the vDSO Makefile for arm64 to remove the flag when
these versions of the compiler are detected.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reported-by: Qian Cai <cai@lca.pw>
Tested-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kernel/vdso/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index ec81d28aeb5d..4ab863045188 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -38,6 +38,13 @@ else
 CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
 endif
 
+# Clang versions less than 8 do not support -mcmodel=tiny
+ifeq ($(CONFIG_CC_IS_CLANG), y)
+  ifeq ($(shell test $(CONFIG_CLANG_VERSION) -lt 80000; echo $$?),0)
+    CFLAGS_REMOVE_vgettimeofday.o += -mcmodel=tiny
+  endif
+endif
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
-- 
2.22.0


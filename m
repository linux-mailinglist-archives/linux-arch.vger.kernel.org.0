Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B15B055620
	for <lists+linux-arch@lfdr.de>; Tue, 25 Jun 2019 19:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfFYRn3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jun 2019 13:43:29 -0400
Received: from foss.arm.com ([217.140.110.172]:46316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbfFYRn3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Jun 2019 13:43:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE6E1360;
        Tue, 25 Jun 2019 10:43:28 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B2233F718;
        Tue, 25 Jun 2019 10:43:26 -0700 (PDT)
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
Subject: [PATCH] arm64: vdso: Fix compilation with clang < 8
Date:   Tue, 25 Jun 2019 18:43:16 +0100
Message-Id: <20190625174316.21946-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190621095252.32307-5-vincenzo.frascino@arm.com>
References: <20190621095252.32307-5-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

clang versions previous to 8 do not support -mcmodel=tiny.

Add a check to the vDSO Makefile for arm64 to remove the flag when these
versions of the compiler are detected.

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reported-by: Qian Cai <cai@lca.pw>
Tested-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/kernel/vdso/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index ec81d28aeb5d..5154f50aff2d 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -38,6 +38,11 @@ else
 CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -include $(c-gettimeofday-y)
 endif
 
+# Clang versions less than 8 do not support -mcmodel=tiny
+ifeq ($(shell test $(CONFIG_CLANG_VERSION) -lt 80000; echo $$?),0)
+CFLAGS_REMOVE_vgettimeofday.o += -mcmodel=tiny
+endif
+
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
-- 
2.22.0


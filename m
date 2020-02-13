Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 824E315C7F8
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 17:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgBMQRT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 11:17:19 -0500
Received: from foss.arm.com ([217.140.110.172]:50082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbgBMQRT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 11:17:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A87B5328;
        Thu, 13 Feb 2020 08:17:18 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25F573F6CF;
        Thu, 13 Feb 2020 08:17:16 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org,
        salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com,
        ndesaulniers@google.com, avagin@openvz.org
Subject: [PATCH 13/19] arm64: vdso: Include common headers in the vdso library
Date:   Thu, 13 Feb 2020 16:16:08 +0000
Message-Id: <20200213161614.23246-14-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213161614.23246-1-vincenzo.frascino@arm.com>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vDSO library should only include the necessary headers required for
a userspace library (UAPI and a minimal set of kernel headers). To make
this possible it is necessary to isolate from the kernel headers the
common parts that are strictly necessary to build the library.

Refactor the vdso implementation to include common headers.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso/gettimeofday.h | 1 -
 arch/arm64/kernel/vdso/vgettimeofday.c     | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/asm/vdso/gettimeofday.h
index b08f476b72b4..cc3456416096 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -8,7 +8,6 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/unistd.h>
-#include <uapi/linux/time.h>
 
 #define __VDSO_USE_SYSCALL		ULLONG_MAX
 
diff --git a/arch/arm64/kernel/vdso/vgettimeofday.c b/arch/arm64/kernel/vdso/vgettimeofday.c
index 747635501a14..4236cf34d7d9 100644
--- a/arch/arm64/kernel/vdso/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso/vgettimeofday.c
@@ -5,8 +5,6 @@
  * Copyright (C) 2018 ARM Limited
  *
  */
-#include <linux/time.h>
-#include <linux/types.h>
 
 int __kernel_clock_gettime(clockid_t clock,
 			   struct __kernel_timespec *ts)
-- 
2.25.0

